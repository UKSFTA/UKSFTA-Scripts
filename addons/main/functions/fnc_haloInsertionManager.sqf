/*
 * Author: UKSFTA Team
 * Description: Manages HALO insertion procedures, including drop zones, altitude, and vehicle drops.
 *
 * Parameter:
 * 0: OBJECT - The console or object hosting the manager.
 *
 * Return:
 * NOTHING
 */
params [["_host", objNull, [objNull]]];

if (isNull _host) exitWith {};

_host addAction ["--------STEP ONE--------", { hint 'Select the Drop Zone'; }];

_host addAction ["<t color='#00ffa6'>Select Drop Zone</t>", {
    openMap true;
    hint 'Click on desired location.';
    onMapSingleClick {
        params ["_pos"]; // Declare private parameter
        onMapSingleClick {};
        createMarker ["dz", _pos];
        "dz" setMarkerType "Mil_Start";
        hint 'Flight Plan Set';
        openMap false;
        true;
    };
}];

_host addAction ["<t color='#09FF00'>Give PLAYER Parachute (stores current backpack)</t>", {
    [player, [missionNamespace, "inventory_var"]] call BIS_fnc_SaveInventory;
    removeBackpack player;
    player addBackpack "B_Parachute";
}];

_host addAction ["--------STEP TWO--------", { hint 'Select the Altitude'; }];

{
    _x params ["_label", "_alt"];
    _host addAction [format ["<t color='#04ff00'>-%1m</t>", _label], {
        params ["", "", "", "_args"]; // Suppress unused action parameters
        _args params ["_altVal"];
        private _dz = createVehicle ["O_diver_TL_F", getMarkerPos "dz", [], 0, "NONE"];
        _dz hideObjectGlobal true;
        _dz disableAI "ALL";

        private _plane = createVehicle ["RHS_C130J", getMarkerPos "dz", [], 0, "NONE"];
        _plane attachTo [_dz, [0, 0, _altVal]];
        _plane engineOn true;
        _plane setVehicleVarName "plane02";
        plane02 = _plane;
        publicVariable "plane02";

        hint format ["Altitude %1m Selected", _altVal];
    }, [_alt]];
} forEach [["350", 350], ["2000", 2000], ["4000", 4000], ["6000", 6000], ["10000", 10000]];

_host addAction ["<t color='#FF0000'>Board Plane</t>", {
    cutText ["", "BLACK OUT", 3];
    sleep 4;
    player moveInCargo (missionNamespace getVariable ["plane02", objNull]);
    cutText ["", "BLACK IN", 1];
    hint 'Boarded. Standby for drop.';
}];

_host addAction ["<t color='#FF0000'>Clear Flight Plan</t>", {
    deleteVehicle (missionNamespace getVariable ["plane02", objNull]);
    deleteMarker "dz";
    hint "Flight plan cleared.";
}];
