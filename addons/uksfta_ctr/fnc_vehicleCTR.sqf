if (!isServer) exitWith {};

_this spawn {
    params ["_veh", "_marker"];

    private _vehName = vehicleVarName _veh;

    private _detectRadius    = ["UKSFTA_CTR_" + _vehName + "_detectRadius", 300] call CBA_fnc_getSetting;
    private _confirmTime     = ["UKSFTA_CTR_" + _vehName + "_confirmTime", 2] call CBA_fnc_getSetting;
    private _requireLoS      = ["UKSFTA_CTR_" + _vehName + "_requireLoS", true] call CBA_fnc_getSetting;
    private _approachSpeed   = ["UKSFTA_CTR_" + _vehName + "_approachSpeed", 90] call CBA_fnc_getSetting;
    private _arrivalRadius   = ["UKSFTA_CTR_" + _vehName + "_arrivalRadius", 25] call CBA_fnc_getSetting;
    private _dismountDelay   = ["UKSFTA_CTR_" + _vehName + "_dismountDelay", 0.3] call CBA_fnc_getSetting;
    private _garrisonRadius  = ["UKSFTA_CTR_" + _vehName + "_garrisonRadius", 35] call CBA_fnc_getSetting;
    private _postureCombat   = ["UKSFTA_CTR_" + _vehName + "_postureCombat", "COMBAT"] call CBA_fnc_getSetting;
    private _postureHide     = ["UKSFTA_CTR_" + _vehName + "_postureHide", "STEALTH"] call CBA_fnc_getSetting;
    private _teleport        = ["UKSFTA_CTR_" + _vehName + "_teleport", false] call CBA_fnc_getSetting;
    private _coverSearchRadius = ["UKSFTA_CTR_" + _vehName + "_coverSearchRadius", 100] call CBA_fnc_getSetting;
    private _coverTargetName = ["UKSFTA_CTR_" + _vehName + "_coverTarget", ""] call CBA_fnc_getSetting;
    private _coverTarget = if (_coverTargetName isEqualTo "") then { objNull } else { missionNamespace getVariable _coverTargetName };

    private _grp = group driver _veh;
    if (isNull _grp) exitWith {};
    private _currentGrp = _grp;

    private _targetPos = getMarkerPos _marker;
    private _state = "IDLE";
    private _contactTimer = 0;
    private _contact = objNull;
    private _wp = objNull;
    private _hiddenPos = _targetPos;

    while {alive _veh && _state != "DONE"} do {
        switch (_state) do {

            case "IDLE": {
                private _players = allPlayers select { alive _x && (_x distance2D _veh) < _detectRadius };
                {
                    if ((_currentGrp knowsAbout _x) >= 1.5) exitWith {
                        _contact = _x; _state = "OBSERVING";
                    };
                } forEach _players;
            };

            case "OBSERVING": {
                if (isNull _contact || !alive _contact) then {
                    _state = "IDLE";
                    _contactTimer = 0;
                } else {
                    _contactTimer = _contactTimer + 1;
                    if (_contactTimer >= _confirmTime) then {
                        _state = "ALERTED";
                    };
                };
            };

            case "ALERTED": {
                if (!isNil "lambs_wp_fnc_taskReset") then { _currentGrp = [_currentGrp] call lambs_wp_fnc_taskReset; };
                for "_i" from (count waypoints _currentGrp - 1) to 0 step -1 do { deleteWaypoint [_currentGrp, _i]; };
                _currentGrp setBehaviour _postureCombat;
                _currentGrp setCombatMode "RED";
                _currentGrp setSpeedMode "FULL";
                _veh limitSpeed _approachSpeed;

                private _currentVehiclePos = getPos _veh;
                private _targetToHideFrom = if (isNull _coverTarget) then { _contact } else { _coverTarget };
                private _hiddenPos = _targetPos;

                if (!isNull _targetToHideFrom && !isNil "lambs_main_fnc_findCover") then {
                    private _coverPositions = [_currentVehiclePos, _coverSearchRadius, _targetToHideFrom, _detectRadius] call lambs_main_fnc_findCover;
                    if (!(_coverPositions isEqualTo [])) then {
                        _hiddenPos = _coverPositions select 0;
                    };
                };

                _wp = _currentGrp addWaypoint [_hiddenPos, 0];
                _wp setWaypointType "MOVE";
                _currentGrp setCurrentWaypoint _wp;
                (driver _veh) doMove _hiddenPos;
                _state = "MOVING";
            };

            case "MOVING": {
                waitUntil { (_veh distance2D _hiddenPos < _arrivalRadius) || speed _veh < 1 };
                _veh forceSpeed 0;
                _veh engineOn false;
                _veh lock 2;

                if (!isNull _wp) then {
                    deleteWaypoint [_currentGrp, _wp];
                    _wp = objNull;
                };

                _state = "DISMOUNT";
            };

            case "DISMOUNT": {
                {
                    _x leaveVehicle _veh;
                    moveOut _x;

                    if (!isNil "CBA_fnc_triggerEventHandler") then {
                        ["lambs_danger_OnContact", [_x, group _x, _contact]] call CBA_fnc_triggerEventHandler;
                    };

                    sleep _dismountDelay;
                } forEach (units _currentGrp);

                waitUntil { ({_x in _veh} count units _currentGrp) == 0 };

                if (!isNil "lambs_wp_fnc_taskReset") then { _currentGrp = [_currentGrp] call lambs_wp_fnc_taskReset; };
                for "_i" from (count waypoints _currentGrp - 1) to 0 step -1 do { deleteWaypoint [_currentGrp, _i]; };

                _state = "GARRISON";
            };

            case "GARRISON": {
                _currentGrp setCombatMode "YELLOW";

                if (!isNil "lambs_wp_fnc_taskGarrison") then { [_currentGrp, _targetPos, _garrisonRadius, [], _teleport, false, -1, false] call lambs_wp_fnc_taskGarrison; };
                _currentGrp setBehaviour _postureHide;

                _state = "DONE";
            };
        };
        sleep 1;
    };
};
