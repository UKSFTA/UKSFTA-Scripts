/*
    UKSFTA Vehicle CTR - Init Script

    This script is called from a game logic to initialize the vehicle CTR script for all configured vehicles.
*/

if (!isServer) exitWith {};

private _vehicleConfigs = [
    [veh_1, "marker_1"],
    [veh_2, "marker_2"]
];

{
    _x spawn compile preprocessFileLineNumbers "uksfta_ctr\fnc_vehicleCTR.sqf";
} forEach _vehicleConfigs;
