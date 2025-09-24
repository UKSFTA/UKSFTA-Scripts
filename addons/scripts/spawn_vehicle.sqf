// This script spawns a vehicle at one of several predefined locations.
// It will dynamically find all markers starting with "vehiclespawn" and
// check if a spot is clear before spawning the vehicle.

// This script MUST only execute on the server to ensure proper synchronization.
if (isServer) then {

    // Get the vehicle class name from the parameters.
    private _vehicle_class = (_this select 3) select 0;

    // Only proceed if the vehicle class name is valid.
    if (isClass (configFile >> "CfgVehicles" >> _vehicle_class)) then {

        // Find all markers that start with "vehiclespawn" and sort them alphabetically.
        private _spawn_markers = [];
        {
            if (toLower _x find "vehiclespawn" == 0) then {
                _spawn_markers pushBack _x;
            };
        } forEach allMapMarkers;

        _spawn_markers sort true;

        // Iterate through the markers to find a free spot.
        private _vehicle_spawned = false;
        {
            private _spawn_pos = getMarkerPos _x;

            // Check if the area is clear of other vehicles.
            if ((count (nearestObjects [_spawn_pos, ["AllVehicles"], 5])) == 0) then {
                // The spawn location is clear. Create the vehicle.
                private _veh = _vehicle_class createVehicle _spawn_pos;

                // Get the marker's direction.
                private _direction = markerDir _x;
                _veh setDir _direction;

                // Add a hint to confirm the vehicle was spawned and send it to all players.
                hint "Vehicle spawned successfully!" remoteExec ["hint", 0, false];

                _vehicle_spawned = true;
                break;
            };
        } forEach _spawn_markers;

        // If no free spot was found, inform the player.
        if !(_vehicle_spawned) then {
            // Use remoteExec to send the hint to all players.
            hint "All vehicle spawn points are currently occupied." remoteExec ["hint", 0, false];
        };
    } else {
        // If the vehicle class name is not valid, inform the player.
        hint format ["Error: The vehicle class name '%1' is not valid. Please check your spelling or mod configuration.", _vehicle_class] remoteExec ["hint", 0, false];
    };
};
