call{
    this addAction ["--------STEP ONE--------", "hint 'Select the Drop Zone';
    "];

    this addAction ["<t color='#FF0000'>Select Drop Zone For The Plane</t>", {
        openMap true;
        hint 'Click on desired location.'; onMapSingleClick {
            onMapSingleClick {};
            createMarker ["dz_plane", _Pos];
            "dz_plane" setMarkerType "Mil_Start";
            hint 'Flight Plan Set';
            openMap false;
            true;
        };
    }];

    this addAction ["<t color='#800080'>Select Drop Zone For The Helicopter</t>", {
        openMap true;
        hint 'Click on desired location.'; onMapSingleClick {
            onMapSingleClick {};
            createMarker ["dz_heli", _Pos];
            "dz_heli" setMarkerType "Mil_Start";
            hint 'Flight Plan Set';
            openMap false;
            true;
        };
    }];

    this addAction ["<t color='#09FF00'>Give PLAYER Parachute (stores current backpack)</t>", {
        [player, [missionNamespace, "inventory_var"]] call BIS_fnc_saveInventory;
        removeBackpack player;
        player addBackpack "B_Parachute";
    }];

    this addAction ["<t color='#0040ff'>Give AI Team Parachutes (stores current backpack)</t>", {
        {
            if !(isPlayer _x) then {
                _inv = name _x;
                _x allowDamage false;
                [_x, [missionNamespace, format["%1%2", "inventory", _inv]]]
                call BIS_fnc_saveInventory;
            }
        } forEach units group player;

        {
            if !(isPlayer _x) then {
                removeBackpack _x;
                _x addBackpack "B_Parachute"; _x allowDamage false;
            };
        } forEach units group player;
    }];

    this addAction ["--------STEP TWO FOR HELI ONLY--------", "hint 'Select the Altitude Helicopters Only';
    "];

    this addAction ["<t color='#04ff00'>-35m</t>", {
        _dz_heli = createVehicle ["O_diver_TL_F", getMarkerPos "dz_heli", [], 0, "NONE"];
        _dz_heli hideObjectGlobal true;
        _dz_heli disableAI "MOVE";
        _dz_heli disableAI "TARGET";
        _dz_heli disableAI "AUTOTARGET";
        _dz_heli disableAI "WEAPONAIM";
        _dz_heli disableAI "ANIM";
        _heli = createVehicle ["TF373_RAF_HC5_EasyActions", getMarkerPos "dz_heli", [], 0, "NONE"];
        _heli hideObjectGlobal true;
        _heli attachTo [_dz_heli, [0, 0, 35] ];
        _heli engineOn true;
        _heli flyInHeight 6000;
        _heli setVehicleVarName "heli02";
        heli02 = _heli;
        publicVariable "heli02";
        _dz_heli setVehicleVarName "dz_heli";
        dz_heli = _dz_heli;
        publicVariable "dz_heli";

        _dz_heli setVehicleVarName "dz_heli";
        dz_heli = _dz_heli;
        _whitelight = createVehicle ["Land_Camping_Light_F", getMarkerPos "dz_heli", [], 0, "NONE"];
        _whitelight setVehicleVarName "whitelight";
        whitelight = _whitelight;
        _redlight = createVehicle ["Land_TentLamp_01_suspended_red_F", getMarkerPos "dz_heli", [], 0, "NONE"];
        _redlight setVehicleVarName "redlight";
        redlight = _redlight;
        _greenlight = createVehicle ["Reflector_Cone_01_wide_green_F", getMarkerPos "dz_heli", [], 0, "NONE"];
        _greenlight setVehicleVarName "greenlight";
        greenlight = _greenlight;
        _redlight attachTo [_heli, [0, 10, 100] ];
        _greenlight attachTo [_heli, [0, 10, 100] ];
        _whitelight attachTo [_heli, [0, 10, 4] ];

        hint 'Altitute Selected - Board Helicopter Below';

        _heli hideObjectGlobal false;
    }];

    this addAction ["--------STEP TWO FOR PLANES ONLY--------", "hint 'Select the Altitude Planes Only';
    "];

    this addAction ["<t color='#04ff00'>-2000m</t>", {
        _dz_plane = createVehicle ["O_diver_TL_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _dz_plane hideObjectGlobal true;
        _dz_plane disableAI "MOVE";
        _dz_plane disableAI "TARGET";
        _dz_plane disableAI "AUTOTARGET";
        _dz_plane disableAI "WEAPONAIM";
        _dz_plane disableAI "ANIM";
        _plane = createVehicle ["B_A400M_UK_CAMO_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _plane hideObjectGlobal true;
        _plane attachTo [_dz_plane, [0, 0, 2000] ];
        _plane engineOn true;
        _plane flyInHeight 6000;
        _plane setVehicleVarName "plane02";
        plane02 = _plane;
        publicVariable "plane02";
        _dz_plane setVehicleVarName "dz_plane";
        dz_plane = _dz_plane;
        publicVariable "dz_plane";

        _dz_plane setVehicleVarName "dz_plane";
        dz_plane = _dz_plane;
        _whitelight = createVehicle ["Land_Camping_Light_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _whitelight setVehicleVarName "whitelight";
        whitelight = _whitelight;
        _redlight = createVehicle ["Land_TentLamp_01_suspended_red_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _redlight setVehicleVarName "redlight";
        redlight = _redlight;
        _greenlight = createVehicle ["Reflector_Cone_01_wide_green_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _greenlight setVehicleVarName "greenlight";
        greenlight = _greenlight;
        _redlight attachTo [_plane, [0, 10, 100] ];
        _greenlight attachTo [_plane, [0, 10, 100] ];
        _whitelight attachTo [_plane, [0, 10, 4] ];

        hint 'Altitute Selected - Board Plane Below';

        _plane hideObjectGlobal false;
    }];

    this addAction ["<t color='#04ff00'>-4000m</t>", {
        _dz_plane = createVehicle ["O_diver_TL_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _dz_plane hideObjectGlobal true;
        _dz_plane disableAI "MOVE";
        _dz_plane disableAI "TARGET";
        _dz_plane disableAI "AUTOTARGET";
        _dz_plane disableAI "WEAPONAIM";
        _dz_plane disableAI "ANIM";
        _plane = createVehicle ["B_A400M_UK_CAMO_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _plane hideObjectGlobal true;
        _plane attachTo [_dz_plane, [0, 0, 4000] ];
        _plane engineOn true;
        _plane setVehicleVarName "plane02";
        plane02 = _plane;
        publicVariable "plane02";
        _dz_plane setVehicleVarName "dz_plane";
        dz_plane = _dz_plane;
        publicVariable "dz_plane";

        _dz_plane setVehicleVarName "dz_plane";
        dz_plane = _dz_plane;
        _whitelight = createVehicle ["Land_Camping_Light_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _whitelight setVehicleVarName "whitelight";
        whitelight = _whitelight;
        _redlight = createVehicle ["Land_TentLamp_01_suspended_red_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _redlight setVehicleVarName "redlight";
        redlight = _redlight;
        _greenlight = createVehicle ["Reflector_Cone_01_wide_green_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _greenlight setVehicleVarName "greenlight";
        greenlight = _greenlight;
        _redlight attachTo [_plane, [0, 10, 100] ];
        _greenlight attachTo [_plane, [0, 10, 100] ];
        _whitelight attachTo [_plane, [0, 10, 4] ];

        hint 'Altitute Selected - Board Plane Below';

        _plane hideObjectGlobal false;
    }];

    this addAction ["<t color='#04ff00'>-6000m</t>", {
        _dz_plane = createVehicle ["O_diver_TL_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _dz_plane hideObjectGlobal true;
        _dz_plane disableAI "MOVE";
        _dz_plane disableAI "TARGET";
        _dz_plane disableAI "AUTOTARGET";
        _dz_plane disableAI "WEAPONAIM";
        _dz_plane disableAI "ANIM";
        _plane = createVehicle ["B_A400M_UK_CAMO_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _plane hideObjectGlobal true;
        _plane attachTo [_dz_plane, [0, 0, 6000] ];
        _plane engineOn true;
        _plane flyInHeight 6000;
        _plane setVehicleVarName "plane02";
        plane02 = _plane;
        publicVariable "plane02";
        _dz_plane setVehicleVarName "dz_plane";
        dz_plane = _dz_plane;
        publicVariable "dz_plane";

        _dz_plane setVehicleVarName "dz_plane";
        dz_plane = _dz_plane;
        _whitelight = createVehicle ["Land_Camping_Light_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _whitelight setVehicleVarName "whitelight";
        whitelight = _whitelight;
        _redlight = createVehicle ["Land_TentLamp_01_suspended_red_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _redlight setVehicleVarName "redlight";
        redlight = _redlight;
        _greenlight = createVehicle ["Reflector_Cone_01_wide_green_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _greenlight setVehicleVarName "greenlight";
        greenlight = _greenlight;
        _redlight attachTo [_plane, [0, 10, 100] ];
        _greenlight attachTo [_plane, [0, 10, 100] ];
        _whitelight attachTo [_plane, [0, 10, 4] ];

        hint 'Altitute Selected - Board Plane Below';

        _plane hideObjectGlobal false;
    }];

    this addAction ["<t color='#04ff00'>-8000m</t>", {
        _dz_plane = createVehicle ["O_diver_TL_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _dz_plane hideObjectGlobal true;
        _dz_plane disableAI "MOVE";
        _dz_plane disableAI "TARGET";
        _dz_plane disableAI "AUTOTARGET";
        _dz_plane disableAI "WEAPONAIM";
        _dz_plane disableAI "ANIM";
        _plane = createVehicle ["B_A400M_UK_CAMO_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _plane hideObjectGlobal true;
        _plane attachTo [_dz_plane, [0, 0, 8000] ];
        _plane engineOn true;
        _plane flyInHeight 6000;
        _plane setVehicleVarName "plane02";
        plane02 = _plane;
        publicVariable "plane02";
        _dz_plane setVehicleVarName "dz_plane";
        dz_plane = _dz_plane;
        publicVariable "dz_plane";

        _dz_plane setVehicleVarName "dz_plane";
        dz_plane = _dz_plane;
        _whitelight = createVehicle ["Land_Camping_Light_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _whitelight setVehicleVarName "whitelight";
        whitelight = _whitelight;
        _redlight = createVehicle ["Land_TentLamp_01_suspended_red_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _redlight setVehicleVarName "redlight";
        redlight = _redlight;
        _greenlight = createVehicle ["Reflector_Cone_01_wide_green_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _greenlight setVehicleVarName "greenlight";
        greenlight = _greenlight;
        _redlight attachTo [_plane, [0, 10, 100] ];
        _greenlight attachTo [_plane, [0, 10, 100] ];
        _whitelight attachTo [_plane, [0, 10, 4] ];

        hint 'Altitute Selected - Board Plane Below';

        _plane hideObjectGlobal false;
    }];

    this addAction ["<t color='#04ff00'>-10000m</t>", {
        _dz_plane = createVehicle ["O_diver_TL_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _dz_plane hideObjectGlobal true;
        _dz_plane disableAI "MOVE";
        _dz_plane disableAI "TARGET";
        _dz_plane disableAI "AUTOTARGET";
        _dz_plane disableAI "WEAPONAIM";
        _dz_plane disableAI "ANIM";
        _plane = createVehicle ["B_A400M_UK_CAMO_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _plane hideObjectGlobal true;
        _plane attachTo [_dz_plane, [0, 0, 10000] ];
        _plane engineOn true;
        _plane flyInHeight 6000;
        _plane setVehicleVarName "plane02";
        plane02 = _plane;
        publicVariable "plane02";
        _dz_plane setVehicleVarName "dz_plane";
        dz_plane = _dz_plane;
        publicVariable "dz_plane";
        _dz_plane setVehicleVarName "dz_plane";
        dz_plane = _dz_plane;
        _whitelight = createVehicle ["Land_Camping_Light_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _whitelight setVehicleVarName "whitelight";
        whitelight = _whitelight;
        _redlight = createVehicle ["Land_TentLamp_01_suspended_red_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _redlight setVehicleVarName "redlight";
        redlight = _redlight;
        _greenlight = createVehicle ["Reflector_Cone_01_wide_green_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _greenlight setVehicleVarName "greenlight";
        greenlight = _greenlight;
        _redlight attachTo [_plane, [0, 10, 100] ];
        _greenlight attachTo [_plane, [0, 10, 100] ];
        _whitelight attachTo [_plane, [0, 10, 4] ];

        hint 'Altitute Selected - Board Plane Below';

        _plane hideObjectGlobal false;
    }];

    this addAction ["--------STEP THREE--------", "hint 'Select Flight Time';
    "];

    this addAction ["<t color='#0040ff'>Select Flight Time - One Minute</t>", {
        sleep 60;

        whitelight attachTo [plane02, [0, 8, 100] ];
        redlight attachTo [plane02, [0, 3, 0] ];
        plane02 animate ["ramp_bottom", 1];
        plane02 animate ["ramp_top", 1];

        sleep 10;
        hint 'Green Light';

        whitelight attachTo [plane02, [0, 8, 100] ];
        redlight attachTo [plane02, [0, -6, 100] ];
        greenlight attachTo [plane02, [0, -15, 4] ];
        sleep 5;
        {
            if !(isPlayer _x) then {
                _x action ["Eject", plane02];
            };
        } forEach units group player;
        {
            if !(isPlayer _x) then {
                _x action ["Eject", heli02];
            };
        } forEach units group player;

        {
            if !(isPlayer _x) then {
                {
                    waitUntil {
                        (getPosATL _x select 2) < 120
                    };
                    _x action ["openParachute", _x];
                } forEach units group player;
            };
        };

        sleep 60;
        deleteVehicle plane02;
        deleteVehicle heli02;
        deleteVehicle dz_plane;
        deleteVehicle dz_heli;
        deleteVehicle whitelight;
        deleteVehicle redlight;
        deleteVehicle greenlight;
        deleteMarker "dz_plane";
        deleteMarker "dz_heli";
    }];

    this addAction ["<t color='#0040ff'>Select Flight Time - Two Minutes</t>", {
        sleep 120;

        whitelight attachTo [plane02, [0, 8, 100] ];
        redlight attachTo [plane02, [0, 3, 0] ];
        plane02 animate ["ramp_bottom", 1];
        plane02 animate ["ramp_top", 1];

        sleep 10;
        hint 'Green Light';

        whitelight attachTo [plane02, [0, 8, 100] ];
        redlight attachTo [plane02, [0, -6, 100] ];
        greenlight attachTo [plane02, [0, -15, 4] ];
        sleep 5;
        {
            if !(isPlayer _x) then {
                _x action ["Eject", plane02];
            };
        } forEach units group player;
        {
            if !(isPlayer _x) then {
                _x action ["Eject", heli02];
            };
        } forEach units group player;

        {
            if !(isPlayer _x) then {
                {
                    waitUntil {
                        (getPosATL _x select 2) < 120
                    };
                    _x action ["openParachute", _x];
                } forEach units group player;
            };
        };

        sleep 60;
        deleteVehicle plane02;
        deleteVehicle heli02;
        deleteVehicle dz_plane;
        deleteVehicle dz_heli;
        deleteVehicle whitelight;
        deleteVehicle redlight;
        deleteVehicle greenlight;
        deleteMarker "dz_plane";
        deleteMarker "dz_heli";
    }];

    this addAction ["<t color='#0040ff'>Select Flight Time - Five Minutes</t>", {
        sleep 300;

        whitelight attachTo [plane02, [0, 8, 100] ];
        redlight attachTo [plane02, [0, 3, 0] ];
        plane02 animate ["ramp_bottom", 1];
        plane02 animate ["ramp_top", 1];

        sleep 10;
        hint 'Green Light';

        whitelight attachTo [plane02, [0, 8, 100] ];
        redlight attachTo [plane02, [0, -6, 100] ];
        greenlight attachTo [plane02, [0, -15, 4] ];
        sleep 5;
        {
            if !(isPlayer _x) then {
                _x action ["Eject", plane02];
            };
        } forEach units group player;
        {
            if !(isPlayer _x) then {
                _x action ["Eject", heli02];
            };
        } forEach units group player;

        {
            if !(isPlayer _x) then {
                {
                    waitUntil {
                        (getPosATL _x select 2) < 120
                    };
                    _x action ["openParachute", _x];
                } forEach units group player;
            };
        };

        sleep 60;
        deleteVehicle plane02;
        deleteVehicle heli02;
        deleteVehicle dz_plane;
        deleteVehicle dz_heli;
        deleteVehicle whitelight;
        deleteVehicle redlight;
        deleteVehicle greenlight;
        deleteMarker "dz_plane";
        deleteMarker "dz_heli";
    }];

    this addAction ["--------STEP FOUR--------", "hint 'Board the aircraft';
    "];

    this addAction ["<t color='#FF0000'>Board Plane</t>", {
        cutText ["", "BLACK OUT", 3];
        sleep 4;
        player attachTo [plane02, [0, 3, 3] ];
        player setDir 180; detach player; hint 'Standby for Red Light';
        {
            if !(isPlayer _x) then {
                _x moveInCargo plane02;
            };
        } forEach units group player;
        cutText ["", "BLACK IN", 1];

        waitUntil {
            (getPosATL player select 2) < 120
        };
        sleep 5;
        waitUntil {
            isTouchingGround player or (getPosASL player select 2) <2
        };
        [player, [missionNamespace, "inventory_var"]] call BIS_fnc_loadInventory;
        {
            if !(isPlayer _x) then {
                waitUntil {
                    isTouchingGround _x
                };
                _x allowDamage true;
                _inv = name _x;
                [_x, [missionNamespace, format["%1%2", "inventory", _inv]]] call BIS_fnc_loadInventory;
            }
        }forEach units group player;
    }];

    this addAction ["<t color='#800080'>Board Helicopter</t>", {
        cutText ["", "BLACK OUT", 3];
        sleep 4;
        player attachTo [heli02, [0, 3, -3] ];
        player setDir 180; detach player; hint 'Standby for Red Light';
        {
            if !(isPlayer _x) then {
                _x moveInCargo heli02;
            };
        } forEach units group player;
        cutText ["", "BLACK IN", 1];
        waitUntil {
            (getPosATL player select 2) < 120
        };
        sleep 5;
        waitUntil {
            isTouchingGround player or (getPosASL player select 2) <2
        };
        [player, [missionNamespace, "inventory_var"]] call BIS_fnc_loadInventory;
        {
            if !(isPlayer _x) then {
                waitUntil {
                    isTouchingGround _x
                };
                _x allowDamage true;
                _inv = name _x;
                [_x, [missionNamespace, format["%1%2", "inventory", _inv]]] call BIS_fnc_loadInventory;
            }
        }forEach units group player;
    }];

    this addAction ["OPTIONAL: Choose Vehicles for Drop", "hint ' ';
    "];

    this addAction ["-----Slot 1-----", "hint ' ';
    "];

    this addAction ["<t color='#04ff00'>-MRZR 4</t>", {
        _Dagor1 = createVehicle ["rhsusf_mrzr4_d", getMarkerPos "dz_plane", [], 0, "NONE"];
        _Dagor1 hideObjectGlobal true;
        _Dagor1 allowDamage false;
        _Dagor1 attachTo [plane02, [0, -3.5, 3.5] ];
        _Dagor1 setDir 180;
        _Dagor1 setVehicleVarName "Dagor1";
        Dagor1 = _Dagor1;
        publicVariable "Dagor1";

        _Dagor1 hideObjectGlobal false;

        plane02 addAction ["<t color='#0040ff'>Drop Vehicle 1</t>", {
            detach Dagor1;
            Dagor1 setVelocity [0, -20, 0];
            _irstrobe = "NVG_TargetC" createVehicle position Dagor1;
            _irstrobe attachTo [Dagor1, [0, 0, 0] ];
            sleep 5;
            waitUntil {
                (getPosATL Dagor1 select 2) < 250
            };

            _para = createVehicle ["B_Parachute_02_F", [0, 0, 100], [], 0, ""];
            _para setPos (getPos Dagor1);
            Dagor1 attachTo [_para, [0, 0, 0]];

            waitUntil {
                ((((position Dagor1) select 2) < 0.6) || (isNil "_para"))
            };
            detach Dagor1;
            Dagor1 setVelocity [0, 0, -5];
            sleep 0.3;
            Dagor1 setPos [(position Dagor1) select 0, (position Dagor1) select 1, 1];
            Dagor1 setVelocity [0, 0, 0];

            sleep 120;
            deleteVehicle _irstrobe;
            Dagor1 allowDamage true;
        }];
    }];

    this addAction ["<t color='#04ff00'>-Zodiac Boat</t>", {
        _Dagor1 = createVehicle ["B_Boat_Transport_01_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _Dagor1 hideObjectGlobal true;
        _Dagor1 allowDamage false;
        _Dagor1 attachTo [plane02, [0, -1, -3.5] ];
        _Dagor1 setDir 180;
        _Dagor1 setVehicleVarName "Dagor1";
        Dagor1 = _Dagor1;
        publicVariable "Dagor1";

        _Dagor1 hideObjectGlobal false;

        plane02 addAction ["<t color='#0040ff'>Drop Vehicle 1</t>", {
            detach Dagor1;
            Dagor1 setVelocity [0, -20, 0];
            _irstrobe = "NVG_TargetC" createVehicle position Dagor1;
            _irstrobe attachTo [Dagor1, [0, 0, -0.5] ];
            sleep 5;
            waitUntil {
                (getPosATL Dagor1 select 2) < 250
            };

            _para = createVehicle ["B_Parachute_02_F", [0, 0, 100], [], 0, ""];
            _para setPos (getPos Dagor1);
            Dagor1 attachTo [_para, [0, 0, 0]];

            waitUntil {
                ((((position Dagor1) select 2) < 0.6) || (isNil "_para"))
            };
            detach Dagor1;
            Dagor1 setVelocity [0, 0, -5];
            sleep 0.3;
            Dagor1 setPos [(position Dagor1) select 0, (position Dagor1) select 1, 1];
            Dagor1 setVelocity [0, 0, 0];

            sleep 120;
            deleteVehicle _irstrobe;
            Dagor1 allowDamage true;
        }];
    }];

    this addAction ["<t color='#04ff00'>-POLARIS DAGOR (UNARMED)</t>", {
        _Dagor1 = createVehicle ["B_LSV_01_unarmed_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _Dagor1 hideObjectGlobal true;
        _Dagor1 allowDamage false;
        _Dagor1 attachTo [plane02, [0, -1, -2.5] ];
        _Dagor1 setDir 180;
        _Dagor1 setVehicleVarName "Dagor1";
        Dagor1 = _Dagor1;
        publicVariable "Dagor1";

        _Dagor1 hideObjectGlobal false;

        plane02 addAction ["<t color='#0040ff'>Drop Vehicle 1</t>", {
            detach Dagor1;
            Dagor1 setVelocity [0, -20, 0];
            _irstrobe = "NVG_TargetC" createVehicle position Dagor1;
            _irstrobe attachTo [Dagor1, [0, 0, 0] ];
            sleep 5;
            waitUntil {
                (getPosATL Dagor1 select 2) < 250
            };

            _para = createVehicle ["B_Parachute_02_F", [0, 0, 100], [], 0, ""];
            _para setPos (getPos Dagor1);
            Dagor1 attachTo [_para, [0, 0, 0]];

            waitUntil {
                ((((position Dagor1) select 2) < 0.6) || (isNil "_para"))
            };
            detach Dagor1;
            Dagor1 setVelocity [0, 0, -5];
            sleep 0.3;
            Dagor1 setPos [(position Dagor1) select 0, (position Dagor1) select 1, 1];
            Dagor1 setVelocity [0, 0, 0];

            sleep 120;
            deleteVehicle _irstrobe;
            Dagor1 allowDamage true;
        }];
    }];

    this addAction ["<t color='#04ff00'>-POLARIS DAGOR (HMG)</t>", {
        _Dagor1 = createVehicle ["B_LSV_01_armed_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _Dagor1 hideObjectGlobal true;
        _Dagor1 allowDamage false;
        _Dagor1 attachTo [plane02, [0, -1, -2.5] ];
        _Dagor1 setDir 180;
        _Dagor1 setVehicleVarName "Dagor1";
        Dagor1 = _Dagor1;
        publicVariable "Dagor1";

        _Dagor1 hideObjectGlobal false;

        plane02 addAction ["<t color='#0040ff'>Drop Vehicle 1</t>", {
            detach Dagor1;
            Dagor1 setVelocity [0, -20, 0];
            _irstrobe = "NVG_TargetC" createVehicle position Dagor1;
            _irstrobe attachTo [Dagor1, [0, 0, 0] ];
            sleep 5;
            waitUntil {
                (getPosATL Dagor1 select 2) < 250
            };

            _para = createVehicle ["B_Parachute_02_F", [0, 0, 100], [], 0, ""];
            _para setPos (getPos Dagor1);
            Dagor1 attachTo [_para, [0, 0, 0]];

            waitUntil {
                ((((position Dagor1) select 2) < 0.6) || (isNil "_para"))
            };
            detach Dagor1;
            Dagor1 setVelocity [0, 0, -5];
            sleep 0.3;
            Dagor1 setPos [(position Dagor1) select 0, (position Dagor1) select 1, 1];
            Dagor1 setVelocity [0, 0, 0];

            sleep 120;
            deleteVehicle _irstrobe;
            Dagor1 allowDamage true;
        }];
    }];

    this addAction ["<t color='#04ff00'>-POLARIS DAGOR (AT)</t>", {
        _Dagor1 = createVehicle ["B_LSV_01_AT_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _Dagor1 hideObjectGlobal true;
        _Dagor1 allowDamage false;
        _Dagor1 attachTo [plane02, [0, -1, -3] ];
        _Dagor1 setDir 180;
        _Dagor1 setVehicleVarName "Dagor1";
        Dagor1 = _Dagor1;
        publicVariable "Dagor1";

        _Dagor1 hideObjectGlobal false;

        plane02 addAction ["<t color='#0040ff'>Drop Vehicle 1</t>", {
            detach Dagor1;
            Dagor1 setVelocity [0, -20, 0];
            _irstrobe = "NVG_TargetC" createVehicle position Dagor1;
            _irstrobe attachTo [Dagor1, [0, 0, 0] ];
            sleep 5;
            waitUntil {
                (getPosATL Dagor1 select 2) < 250
            };

            _para = createVehicle ["B_Parachute_02_F", [0, 0, 100], [], 0, ""];
            _para setPos (getPos Dagor1);
            Dagor1 attachTo [_para, [0, 0, 0]];

            waitUntil {
                ((((position Dagor1) select 2) < 0.6) || (isNil "_para"))
            };
            detach Dagor1;
            Dagor1 setVelocity [0, 0, -5];
            sleep 0.3;
            Dagor1 setPos [(position Dagor1) select 0, (position Dagor1) select 1, 1];
            Dagor1 setVelocity [0, 0, 0];

            sleep 120;
            deleteVehicle _irstrobe;
            Dagor1 allowDamage true;
        }];
    }];

    this addAction ["<t color='#04ff00'>-HMMWV (Mk19)</t>", {
        _Dagor1 = createVehicle ["rhsusf_m1025_d_Mk19", getMarkerPos "dz_plane", [], 0, "NONE"];
        _Dagor1 hideObjectGlobal true;
        _Dagor1 allowDamage false;
        _Dagor1 attachTo [plane02, [0, -1, -2.5] ];
        _Dagor1 setDir 180;
        _Dagor1 setVehicleVarName "Dagor1";
        Dagor1 = _Dagor1;
        publicVariable "Dagor1";

        _Dagor1 hideObjectGlobal false;

        plane02 addAction ["<t color='#0040ff'>Drop Vehicle 1</t>", {
            detach Dagor1;
            Dagor1 setVelocity [0, -20, 0];
            _irstrobe = "NVG_TargetC" createVehicle position Dagor1;
            _irstrobe attachTo [Dagor1, [0, 0, 0] ];
            sleep 5;
            waitUntil {
                (getPosATL Dagor1 select 2) < 250
            };

            _para = createVehicle ["B_Parachute_02_F", [0, 0, 100], [], 0, ""];
            _para setPos (getPos Dagor1);
            Dagor1 attachTo [_para, [0, 0, 0]];

            waitUntil {
                ((((position Dagor1) select 2) < 0.6) || (isNil "_para"))
            };
            detach Dagor1;
            Dagor1 setVelocity [0, 0, -5];
            sleep 0.3;
            Dagor1 setPos [(position Dagor1) select 0, (position Dagor1) select 1, 1];
            Dagor1 setVelocity [0, 0, 0];

            sleep 120;
            deleteVehicle _irstrobe;
            Dagor1 allowDamage true;
        }];
    }];

    this addAction ["<t color='#04ff00'>-HMMWV (M2)</t>", {
        _Dagor1 = createVehicle ["rhsusf_m1025_d_m2", getMarkerPos "dz_plane", [], 0, "NONE"];
        _Dagor1 hideObjectGlobal true;
        _Dagor1 allowDamage false;
        _Dagor1 attachTo [plane02, [0, -1, -2.5] ];
        _Dagor1 setDir 180;
        _Dagor1 setVehicleVarName "Dagor1";
        Dagor1 = _Dagor1;
        publicVariable "Dagor1";

        _Dagor1 hideObjectGlobal false;

        plane02 addAction ["<t color='#0040ff'>Drop Vehicle 1</t>", {
            detach Dagor1;
            Dagor1 setVelocity [0, -20, 0];
            _irstrobe = "NVG_TargetC" createVehicle position Dagor1;
            _irstrobe attachTo [Dagor1, [0, 0, 0] ];
            sleep 5;
            waitUntil {
                (getPosATL Dagor1 select 2) < 250
            };

            _para = createVehicle ["B_Parachute_02_F", [0, 0, 100], [], 0, ""];
            _para setPos (getPos Dagor1);
            Dagor1 attachTo [_para, [0, 0, 0]];

            waitUntil {
                ((((position Dagor1) select 2) < 0.6) || (isNil "_para"))
            };
            detach Dagor1;
            Dagor1 setVelocity [0, 0, -5];
            sleep 0.3;
            Dagor1 setPos [(position Dagor1) select 0, (position Dagor1) select 1, 1];
            Dagor1 setVelocity [0, 0, 0];

            sleep 120;
            deleteVehicle _irstrobe;
            Dagor1 allowDamage true;
        }];
    }];

    this addAction ["<t color='#04ff00'>-HMMWV (AT)</t>", {
        _Dagor1 = createVehicle ["rhsusf_m1045_d", getMarkerPos "dz_plane", [], 0, "NONE"];
        _Dagor1 hideObjectGlobal true;
        _Dagor1 allowDamage false;
        _Dagor1 attachTo [plane02, [0, -1, -2.5] ];
        _Dagor1 setDir 180;
        _Dagor1 setVehicleVarName "Dagor1";
        Dagor1 = _Dagor1;
        publicVariable "Dagor1";

        _Dagor1 hideObjectGlobal false;

        plane02 addAction ["<t color='#0040ff'>Drop Vehicle 1</t>", {
            detach Dagor1;
            Dagor1 setVelocity [0, -20, 0];
            _irstrobe = "NVG_TargetC" createVehicle position Dagor1;
            _irstrobe attachTo [Dagor1, [0, 0, 0] ];
            sleep 5;
            waitUntil {
                (getPosATL Dagor1 select 2) < 250
            };

            _para = createVehicle ["B_Parachute_02_F", [0, 0, 100], [], 0, ""];
            _para setPos (getPos Dagor1);
            Dagor1 attachTo [_para, [0, 0, 0]];

            waitUntil {
                ((((position Dagor1) select 2) < 0.6) || (isNil "_para"))
            };
            detach Dagor1;
            Dagor1 setVelocity [0, 0, -5];
            sleep 0.3;
            Dagor1 setPos [(position Dagor1) select 0, (position Dagor1) select 1, 1];
            Dagor1 setVelocity [0, 0, 0];

            sleep 120;
            deleteVehicle _irstrobe;
            Dagor1 allowDamage true;
        }];
    }];

    this addAction ["<t color='#04ff00'>-HMMWV (UNARMED - RECON)</t>", {
        _Dagor1 = createVehicle ["rhsusf_m998_d_4dr", getMarkerPos "dz_plane", [], 0, "NONE"];
        _Dagor1 hideObjectGlobal true;
        _Dagor1 allowDamage false;
        _Dagor1 attachTo [plane02, [0, -1, -2.5] ];
        _Dagor1 setDir 180;
        _Dagor1 setVehicleVarName "Dagor1";
        Dagor1 = _Dagor1;
        publicVariable "Dagor1";

        _Dagor1 hideObjectGlobal false;

        plane02 addAction ["<t color='#0040ff'>Drop Vehicle 1</t>", {
            detach Dagor1;
            Dagor1 setVelocity [0, -20, 0];
            _irstrobe = "NVG_TargetC" createVehicle position Dagor1;
            _irstrobe attachTo [Dagor1, [0, 0, 0] ];
            sleep 5;
            waitUntil {
                (getPosATL Dagor1 select 2) < 250
            };

            _para = createVehicle ["B_Parachute_02_F", [0, 0, 100], [], 0, ""];
            _para setPos (getPos Dagor1);
            Dagor1 attachTo [_para, [0, 0, 0]];

            waitUntil {
                ((((position Dagor1) select 2) < 0.6) || (isNil "_para"))
            };
            detach Dagor1;
            Dagor1 setVelocity [0, 0, -5];
            sleep 0.3;
            Dagor1 setPos [(position Dagor1) select 0, (position Dagor1) select 1, 1];
            Dagor1 setVelocity [0, 0, 0];

            sleep 120;
            deleteVehicle _irstrobe;
            Dagor1 allowDamage true;
        }];
    }];

    this addAction ["<t color='#04ff00'>-SDV</t>", {
        _Dagor1 = createVehicle ["B_SDV_01_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _Dagor1 hideObjectGlobal true;
        _Dagor1 allowDamage false;
        _Dagor1 attachTo [plane02, [0.3, -1, -2.7] ];
        _Dagor1 setDir 180;
        _Dagor1 setVehicleVarName "Dagor1";
        Dagor1 = _Dagor1;
        publicVariable "Dagor1";

        _Dagor1 hideObjectGlobal false;

        plane02 addAction ["<t color='#0040ff'>Drop Vehicle 1</t>", {
            detach Dagor1;
            Dagor1 setVelocity [0, -20, 0];
            _irstrobe = "NVG_TargetC" createVehicle position Dagor1;
            _irstrobe attachTo [Dagor1, [0, 0, -0.5] ];
            sleep 5;
            waitUntil {
                (getPosATL Dagor1 select 2) < 250
            };

            _para = createVehicle ["B_Parachute_02_F", [0, 0, 100], [], 0, ""];
            _para setPos (getPos Dagor1);
            Dagor1 attachTo [_para, [0, 0, 0]];

            waitUntil {
                ((((position Dagor1) select 2) < 0.6) || (isNil "_para"))
            };
            detach Dagor1;
            Dagor1 setVelocity [0, 0, -5];
            sleep 0.3;
            Dagor1 setPos [(position Dagor1) select 0, (position Dagor1) select 1, 1];
            Dagor1 setVelocity [0, 0, 0];

            sleep 120;
            deleteVehicle _irstrobe;
            Dagor1 allowDamage true;
        }];
    }];

    this addAction ["<t color='#04ff00'>-UGV</t>", {
        _Dagor1 = createVehicle ["B_UGV_01_rcws_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _Dagor1 hideObjectGlobal true;
        _Dagor1 allowDamage false;
        _Dagor1 attachTo [plane02, [0.3, 0, -2.7] ];
        _Dagor1 setDir 180;
        _Dagor1 setVehicleVarName "Dagor1";
        Dagor1 = _Dagor1;
        publicVariable "Dagor1";

        _Dagor1 hideObjectGlobal false;

        plane02 addAction ["<t color='#0040ff'>Drop Vehicle 1</t>", {
            detach Dagor1;
            Dagor1 setVelocity [0, -20, 0];
            _irstrobe = "NVG_TargetC" createVehicle position Dagor1;
            _irstrobe attachTo [Dagor1, [0, 0, -0.5] ];
            sleep 5;
            waitUntil {
                (getPosATL Dagor1 select 2) < 250
            };

            _para = createVehicle ["B_Parachute_02_F", [0, 0, 100], [], 0, ""];
            _para setPos (getPos Dagor1);
            Dagor1 attachTo [_para, [0, 0, 0]];

            waitUntil {
                ((((position Dagor1) select 2) < 0.6) || (isNil "_para"))
            };
            detach Dagor1;
            Dagor1 setVelocity [0, 0, -5];
            sleep 0.3;
            Dagor1 setPos [(position Dagor1) select 0, (position Dagor1) select 1, 1];
            Dagor1 setVelocity [0, 0, 0];

            sleep 120;
            deleteVehicle _irstrobe;
            Dagor1 allowDamage true;
        }];
    }];

    this addAction ["<t color='#04ff00'>-Arsenal Box</t>", {
        _Dagor1 = createVehicle ["B_CargoNet_01_ammo_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _Dagor1 hideObjectGlobal true;
        _Dagor1 allowDamage false;
        _Dagor1 attachTo [plane02, [0.3, 0, -3.8] ];
        _Dagor1 setDir 180;
        _Dagor1 setVehicleVarName "Dagor1";
        Dagor1 = _Dagor1;
        publicVariable "Dagor1";

        _Dagor1 hideObjectGlobal false;

        ["AmmoboxInit", [Dagor1, true]] call BIS_fnc_arsenal;
        Dagor1 call ace_arsenal_fnc_initBox;

        plane02 addAction ["<t color='#0040ff'>Drop Vehicle 1</t>", {
            detach Dagor1;
            Dagor1 setVelocity [0, -20, 0];
            _irstrobe = "NVG_TargetC" createVehicle position Dagor1;
            _irstrobe attachTo [Dagor1, [0, 0, -0.5] ];
            sleep 5;
            waitUntil {
                (getPosATL Dagor1 select 2) < 250
            };

            _para = createVehicle ["B_Parachute_02_F", [0, 0, 100], [], 0, ""];
            _para setPos (getPos Dagor1);
            Dagor1 attachTo [_para, [0, 0, 0]];

            waitUntil {
                ((((position Dagor1) select 2) < 0.6) || (isNil "_para"))
            };
            detach Dagor1;
            Dagor1 setVelocity [0, 0, -5];
            sleep 0.3;
            Dagor1 setPos [(position Dagor1) select 0, (position Dagor1) select 1, 1];
            Dagor1 setVelocity [0, 0, 0];

            sleep 120;
            Dagor1 allowDamage true;
        }];
    }];

    this addAction ["-----Slot 2-----", "hint ' ';
    "];

    this addAction ["<t color='#04ff00'>-MRZR 4</t>", {
        _Dagor2 = createVehicle ["rhsusf_mrzr4_d", getMarkerPos "dz_plane", [], 0, "NONE"];
        _Dagor2 hideObjectGlobal true;
        _Dagor2 allowDamage false;
        _Dagor2 attachTo [plane02, [0, 0.5, 3.5] ];
        _Dagor2 setDir 180;
        _Dagor2 setVehicleVarName "Dagor2";
        Dagor2 = _Dagor2;
        publicVariable "Dagor2";

        _Dagor2 hideObjectGlobal false;

        plane02 addAction ["<t color='#0040ff'>Drop Vehicle 2</t>", {
            Dagor2 attachTo [plane02, [0, 1.5, -3] ];
            sleep 0.03;
            Dagor2 attachTo [plane02, [0, 1.0, -3] ];
            sleep 0.03;
            Dagor2 attachTo [plane02, [0, 0.5, -3] ];
            sleep 0.03;
            Dagor2 attachTo [plane02, [0, 0.0, -3] ];
            sleep 0.03;
            Dagor2 attachTo [plane02, [0, -0.5, -3] ];
            sleep 0.03;
            Dagor2 attachTo [plane02, [0, -1.0, -3] ];
            sleep 0.03;
            Dagor2 attachTo [plane02, [0, -1.5, -3] ];
            detach Dagor2;
            Dagor2 setVelocity [0, -15, 0];
            _irstrobe = "NVG_TargetC" createVehicle position Dagor2;
            _irstrobe attachTo [Dagor2, [0, 0, 0] ];
            sleep 5;
            waitUntil {
                (getPosATL Dagor2 select 2) < 250
            };

            _para = createVehicle ["B_Parachute_02_F", [0, 0, 100], [], 0, ""];
            _para setPos (getPos Dagor2);
            Dagor2 attachTo [_para, [0, 0, 0]];

            waitUntil {
                ((((position Dagor2) select 2) < 0.6) || (isNil "_para"))
            };
            detach Dagor2;
            Dagor2 setVelocity [0, 0, -5];
            sleep 0.3;
            Dagor2 setPos [(position Dagor2) select 0, (position Dagor2) select 1, 1];
            Dagor2 setVelocity [0, 0, 0];

            sleep 120;
            deleteVehicle _irstrobe;
            Dagor2 allowDamage true;
        }];
    }];

    this addAction ["<t color='#04ff00'>-Zodiac Boat</t>", {
        _Dagor2 = createVehicle ["B_Boat_Transport_01_F", getMarkerPos "dz_plane", [], 0, "NONE"];
        _Dagor2 hideObjectGlobal true;
        _Dagor2 allowDamage false;
        _Dagor2 attachTo [plane02, [0, -1, -2.5] ];
        _Dagor2 setDir 180;
        _Dagor2 setVehicleVarName "Dagor2";
        Dagor2 = _Dagor2;
        publicVariable "Dagor2";

        _Dagor2 hideObjectGlobal false;

        plane02 addAction ["<t color='#0040ff'>Drop Vehicle 2</t>", {
            detach Dagor2;
            Dagor2 setVelocity [0, -15, 0];
            _irstrobe = "NVG_TargetC" createVehicle position Dagor2;
            _irstrobe attachTo [Dagor2, [0, 0, -0.5] ];
            sleep 5;
            waitUntil {
                (getPosATL Dagor2 select 2) < 250
            };

            _para = createVehicle ["B_Parachute_02_F", [0, 0, 100], [], 0, ""];
            _para setPos (getPos Dagor2);
            Dagor2 attachTo [_para, [0, 0, 0]];

            waitUntil {
                ((((position Dagor2) select 2) < 0.6) || (isNil "_para"))
            };
            detach Dagor2;
            Dagor2 setVelocity [0, 0, -5];
            sleep 0.3;
            Dagor2 setPos [(position Dagor2) select 0, (position Dagor2) select 1, 1];
            Dagor2 setVelocity [0, 0, 0];

            sleep 120;
            deleteVehicle _irstrobe;
            Dagor2 allowDamage true;
        }];
    }];

    this addAction ["------------------------", "hint ' ';
    "];

    this addAction ["<t color='#FF0000'>Clear Flight Plan (Start Over)</t>", {
        deleteVehicle plane02;
        deleteVehicle heli02;
        deleteVehicle dz_plane;
        deleteVehicle dz_heli;
        deleteMarker "dz_plane";
        deleteMarker "dz_heli";
        deleteVehicle Dagor1;
        deleteVehicle Dagor2;
    }];
}
