if (!isServer) exitWith {};

[] spawn {
    private _veh = missionNamespace getVariable ["veh_1", objNull];
    private _targetMarker = "marker_1";

    if (isNull _veh) exitWith {};

    private _c_enableSignal   = true;
    private _c_enableBurn     = true;
    private _c_signalFreq     = 390.5;
    private _c_breakLoSTime   = 30;
    private _c_garrisonRadius = 60;
    private _c_detectionRange = 600;
    private _c_evadeSpeed     = 110;
    private _c_safeDriveSpeed = 45;
    private _c_freezeRadius   = 15;
    private _c_rePathInterval = 20;
    private _c_stuckTimeout   = 6;

    private _grp = group driver _veh;
    private _currentGrp = _grp;
    private _targetPos = getMarkerPos _targetMarker;
    private _state = "IDLE";
    private _contact = objNull;
    private _losTimer = 0;
    private _evadeTimer = 0;
    private _stuckTimer = 0;
    private _currentDest = [0,0,0];
    private _hiddenPos = _targetPos;
    private _parkingPos = _targetPos;
    private _lastDamage = damage _veh;

    while {count (waypoints _currentGrp) > 0} do {
        deleteWaypoint ((waypoints _currentGrp) select 0);
    };

    _veh setUnloadInCombat [false, false];
    _veh setConvoySeparation 0;
    _veh forceFollowRoad false;

    (driver _veh) setSkill 1;
    _currentGrp setBehaviour "AWARE";

    {
        _x setSkill 1;
        _x unassignItem "NVGoggles";
        _x removeItem "NVGoggles";
    } forEach (units _currentGrp);

    private _fnc_forceBlackout = {
        params ["_v", "_g"];
        private _isCombat = (behaviour (leader _g) == "COMBAT");
        private _mode = if (_isCombat) then {"Auto"} else {"ForceOff"};
        private _lasers = if (_isCombat) then {true} else {false};
        _v setPilotLight _lasers;
        _v setCollisionLight false;
        {
            _x enableGunLights _mode;
            _x enableIRLasers _lasers;
            if (!_lasers) then { _x action ["lightOff", _v]; };
        } forEach (units _g);
    };

    while {alive _veh && _state != "DONE"} do {
        if (vectorUp _veh select 2 < 0.6) then {
            _veh setVectorUp [0,0,1];
            _veh setPosATL [(getPosATL _veh select 0), (getPosATL _veh select 1), 0.2];
        };

        if (!canMove _veh && _state in ["PURSUED", "MOVING"]) then {
            _state = "DISMOUNT";
            if (_c_enableBurn) then {
                [_veh] spawn {
                    params ["_v"];
                    sleep 5;
                    private _bomb = "DemoCharge_Remote_Ammo" createVehicle (getPos _v);
                    _bomb setDamage 1;
                    { _x setDamage 1; } forEach (nearestObjects [_v, ["Car", "Air"], 5]);
                };
            };
        };

        switch (_state) do {
            case "IDLE": {
                private _potentialThreats = allPlayers select { alive _x };
                {
                    private _p = _x;
                    if (_p distance _veh < _c_detectionRange) then {
                        if ((_currentGrp knowsAbout _p) >= 1.5) exitWith {
                            _contact = _p;
                            _state = "PURSUED";
                        };
                    };
                } forEach _potentialThreats;
            };

            case "PURSUED": {
                [_veh, _currentGrp] call _fnc_forceBlackout;
                private _inCombat = (behaviour (leader _currentGrp) == "COMBAT");
                _veh limitSpeed (if (_inCombat) then {200} else {_c_evadeSpeed});
                private _canSeeMe = false;
                if (!isNull _contact && alive _contact) then {
                    _canSeeMe = ([_veh, "VIEW"] checkVisibility [eyePos _contact, eyePos (driver _veh)]) > 0.05;
                };
                if (_canSeeMe) then {
                    _losTimer = 0;
                    _currentGrp setBehaviour "COMBAT";
                } else {
                    _losTimer = _losTimer + 1;
                    if (_losTimer > 5) then { _currentGrp setBehaviour "AWARE"; };
                };
                private _currentDamage = damage _veh;
                private _isPanicking = (_currentDamage > _lastDamage + 0.05);
                _lastDamage = _currentDamage;
                if (speed _veh < 5 && _veh distance _currentDest > 40) then {
                    _stuckTimer = _stuckTimer + 1;
                    if (_stuckTimer > _c_stuckTimeout) then {
                        _veh setDriveOnPath [];
                        _veh setVelocityModelSpace [0, -15, 2];
                        _evadeTimer = 0;
                        _stuckTimer = 0;
                    };
                } else {
                    _stuckTimer = 0;
                };
                if (time > _evadeTimer || _isPanicking) then {
                    if (_losTimer >= _c_breakLoSTime && !_isPanicking) then {
                        _state = "ALERTED";
                    } else {
                        private _escapeDir = if (_canSeeMe) then {
                            ([_contact, _veh] call BIS_fnc_relativeDirTo) + (random 60 - 30)
                        } else {
                            (getDir _veh) + (random 40 - 20)
                        };
                        private _dist = if (_isPanicking) then { 400 } else { 1200 };
                        private _rawMovePos = _veh getRelPos [_dist, _escapeDir];
                        if (_isPanicking) then {
                            _veh setDriveOnPath [];
                            _currentDest = _rawMovePos;
                            _evadeTimer = time + 5;
                        } else {
                            private _roads = _rawMovePos nearRoads 800;
                            _currentDest = if (count _roads > 0) then { getPos (_roads select 0) } else { _rawMovePos };
                            _evadeTimer = time + _c_rePathInterval;
                        };
                        (driver _veh) doMove _currentDest;
                    };
                };
            };

            case "ALERTED": {
                [_veh, _currentGrp] call _fnc_forceBlackout;
                _veh limitSpeed _c_safeDriveSpeed;
                _currentGrp setBehaviour "AWARE";
                private _pPos = _targetPos findEmptyPosition [5, 60, typeOf _veh];
                _parkingPos = if (count _pPos > 0) then { _pPos } else { _targetPos };
                private _houses = nearestObjects [_parkingPos, ["House", "Building"], _c_garrisonRadius];
                private _validHouses = _houses select { count (_x buildingPos -1) > 3 };
                _hiddenPos = if (count _validHouses > 0) then { getPosATL (_validHouses select (count _validHouses - 1)) } else { _targetPos };
                _currentDest = _parkingPos;
                (driver _veh) doMove _currentDest;
                _state = "MOVING";
            };

            case "MOVING": {
                if (behaviour (leader _currentGrp) == "COMBAT") exitWith { _state = "PURSUED"; _evadeTimer = 0; };
                if (speed _veh < 2 && _veh distance _currentDest > 20) then {
                    _stuckTimer = _stuckTimer + 1;
                    if (_stuckTimer > _c_stuckTimeout) then {
                        _veh setDriveOnPath [];
                        _veh setVelocityModelSpace [0, -8, 1];
                        (driver _veh) doMove _currentDest;
                        _stuckTimer = 0;
                    };
                };
                if (_veh distance _parkingPos < 15 || (speed _veh < 1 && _veh distance _parkingPos < 40)) then {
                    _veh stop true;
                    _veh engineOn false;
                    _veh lock 2;
                    _state = "DISMOUNT";
                };
            };

            case "DISMOUNT": {
                [_veh, _currentGrp] call _fnc_forceBlackout;
                _currentGrp leaveVehicle _veh;
                {
                    unassignVehicle _x;
                    moveOut _x;
                    _x setUnitPos "UP";
                } forEach (units _currentGrp);
                _currentGrp setBehaviour "AWARE";
                _currentGrp setSpeedMode "FULL";
                (units _currentGrp) doMove _hiddenPos;
                _state = "GARRISON";
            };

            case "GARRISON": {
                if (!isNil "lambs_wp_fnc_taskGarrison") then {
                    [_currentGrp, _hiddenPos, _c_garrisonRadius, [], false, false, -1, false] call lambs_wp_fnc_taskGarrison;
                };

                [_currentGrp, _c_freezeRadius, _c_signalFreq, _c_enableSignal] spawn {
                    params ["_grp", "_fRadius", "_freq", "_sigOn"];
                    waitUntil { sleep 1; (speed (leader _grp) < 0.5) };
                    sleep 5;
                    while {alive (leader _grp) && !isNull _grp} do {
                        private _inCombat = (behaviour (leader _grp) == "COMBAT");
                        private _nearPlayer = ({_x distance (leader _grp) < _fRadius} count allPlayers > 0);
                        if (_sigOn && !isNil "BIS_fnc_createSpectralEmitter") then {
                            [leader _grp, _freq, 0.5] call BIS_fnc_createSpectralEmitter;
                        };
                        {
                            _x enableGunLights (if (_inCombat) then {"Auto"} else {"ForceOff"});
                            _x enableIRLasers _inCombat;
                            if (_nearPlayer && !_inCombat) then {
                                _x disableAI "PATH";
                                _x setUnitPos "DOWN";
                            } else {
                                _x enableAI "PATH";
                            };
                        } forEach (units _grp);
                        sleep 4;
                    };
                };
                _currentGrp setBehaviour "STEALTH";
                _state = "DONE";
            };
        };
        sleep 1;
    };
};
