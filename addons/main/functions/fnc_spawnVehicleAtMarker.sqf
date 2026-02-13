/*
 * Author: UKSFTA Team
 * Description: Spawns a vehicle at a random marker position from a list of marker names.
 *
 * Parameter:
 * 0: ARRAY - List of marker names to check.
 * 1: STRING - Vehicle class name to spawn.
 *
 * Return:
 * NOTHING
 */
params [
    ["_marker_names", [], [[]]],
    ["_vehicle_class", "", [""]]
];

if (isServer) then {
    private _spawned = false;
    {
        private _marker_name = _x;
        private _spawn_pos = getMarkerPos _marker_name;

        if (_spawn_pos isNotEqualTo [0,0,0]) then {
            if ((nearestObjects [_spawn_pos, ["AllVehicles"], 5]) isEqualTo []) then {
                private _vehicle = createVehicle [_vehicle_class, _spawn_pos, [], 0, "NONE"];
                private _marker_dir = markerDir _marker_name;
                _vehicle setDir _marker_dir;
                _spawned = true;

                ["Vehicle spawned successfully!"] remoteExec ["hint", 0, false];
                break;
            };
        };
    } forEach _marker_names;

    if (!_spawned) then {
        ["All vehicle spawn points are currently occupied."] remoteExec ["hint", 0, false];
    };
} else {
    if (!isClass (configFile >> "CfgVehicles" >> _vehicle_class)) then {
        [format ["Error: The vehicle class name '%1' is not valid.", _vehicle_class]] remoteExec ["hint", 0, false];
    };
};
