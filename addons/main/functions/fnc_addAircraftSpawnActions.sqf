/*
 * Author: UKSFTA Team
 * Description: Adds aircraft spawning actions to an object (e.g., a sign or console).
 *
 * Parameter:
 * 0: OBJECT - The object to add actions to.
 *
 * Return:
 * NOTHING
 *
 * Example:
 * [this] call UKSFTA_fnc_addAircraftSpawnActions;
 */
params [["_host", objNull, [objNull]]];

if (isNull _host) exitWith {};

private _vehicle_list = [
    ["Spawn F-35B Lightning II (ZM136)", "FIR_F35B_RAF01"],
    ["Spawn F-35B Lightning II (ZM147)", "FIR_F35B_RAF02"],
    ["Spawn Aero Commander 500r", "UK3CB_B_AC500_HIDF"],
    ["Spawn Cessna 400 Navy", "UK3CB_MDF_B_C400_NAVY"],
    ["Spawn BAE Hawk T1", "sab_baehawk_b_1"],
    ["Spawn BAE Hawk T2", "sab_baehawk_b_2"],
    ["Spawn Typhoon F3 (RAF)", "Tornado_AWS_ADV_UK"],
    ["Spawn Typhoon GR 4 (RAF)", "Tornado_AWS_camo_uk"],
    ["Spawn Typhoon GR 4 (RAF Camo)", "Tornado_AWS_UK_617"],
    ["Spawn Typhoon GR 4 (RAF Desert Storm)", "Tornado_AWS_UK_DS"]
];

{
    _x params ["_display_name", "_vehicle_class"];
    _host addAction [_display_name, { _this call UKSFTA_fnc_spawnVehicleAtMarker }, [_vehicle_class]];
} forEach _vehicle_list;

_host addAction ["<t color='#FF0000'>Load Weapon Preset To Atrag MX</t>", { _this call UKSFTA_fnc_generateAtragMXPresetFromCurrentWeapon }];
_host addAction ["<t color='#FF0000'>Activate Alarm</t>", { _this call UKSFTA_fnc_activateScrambleAlarm }];
