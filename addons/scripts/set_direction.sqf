// This script sets the direction of a newly spawned vehicle.
// It is called by spawn_vehicle.sqf after the vehicle is created.

// The parameters passed to this script are the spawned vehicle object and the marker name (as a string).
params ["_veh", "_markerName"];

// Get the marker's direction as a number (0-360 degrees).
private _direction = markerDir _markerName;

// Print the marker name and direction to the in-game hint
hint format ["Setting direction for marker: %1, Direction: %2", _markerName, _direction];

// Print the marker name and direction to the game's RPT log file
diag_log format ["Setting direction for marker: %1, Direction: %2", _markerName, _direction];

// Set the vehicle's direction to match the marker's rotation.
_veh setDir _direction;
