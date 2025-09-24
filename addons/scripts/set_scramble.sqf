private _target = _this select 0;

if (isNull _target) exitWith { hint "Error: The button's object was not passed to the script." };

private _soundFile = "a3\sounds_f\sfx\siren.wss";
private _radius = 500;
private _duration = 20; // Duration in seconds
private _speakerClassNames = ["Land_Loudspeakers_F", "Loudspeaker", "Loudspeakers_EP1", "Land_PortableSpeakers_01_F"];
private _speakerObjects = nearestObjects [_target, _speakerClassNames, _radius];

if (count _speakerObjects == 0) then {
hint "Scramble Alarm: No speakers found. Please check your speaker object class names.";
} else {
// Start the alarm loop
private _startTime = time;
sleep 1; // Wait for a moment to allow the speakers to be found and sync
while {time < _startTime + _duration} do {
{
private _speaker = _x;
playSound3D [_soundFile, _speaker, false, getPosASL _speaker, 5, 1, 0];
} forEach _speakerObjects;
sleep 1; // Wait for a moment before playing the sound again
};
hint "Scramble Alarm: Duration expired.";
};
