params ["_terminal", "_caller", "_actionId", "_config"];

_config params ["_label", "_maxDamage", "_bodyParts", "_damageTypes", "_minCount", "_maxCount"];

{
    if ((typeOf _x in ["b_survivor_F", "b_g_survivor_F"]) && !isPlayer _x) then {
        deleteVehicle _x;
    };
} forEach (getMarkerPos "PatientSpawn" nearEntities ["Man", 10]);

[_terminal, 3] call BIS_fnc_dataTerminalAnimate;
sleep 2;

private _spawnCount = floor (random [_minCount, (_minCount + _maxCount) / 2, _maxCount]);
private _group1 = createGroup west;

for "_i" from 1 to _spawnCount do {
    private _pos = getMarkerPos "PatientSpawn";
    private _spawnPos = [(_pos select 0) + (_i * 1.5), (_pos select 1), _pos select 2];

    private _pat = _group1 createUnit ["b_survivor_F", _spawnPos, [], 0, "CAN_COLLIDE"];

    doStop _pat;
    _pat setCaptive true;
    _pat setDir (getDir _terminal - 180);
    _pat switchMove "AmovPercMstpSsurWnonDnon";
    _pat disableAI "ANIM";

    {
        private _dmg = random _maxDamage;
        [_pat, _dmg, _x, selectRandom _damageTypes] call ace_medical_fnc_addDamageToUnit;
    } forEach _bodyParts;
};

[_terminal, 0] call BIS_fnc_dataTerminalAnimate;
hint format ["Patient(s) ready.\nMode: %1\nMax Dmg/Part: %2", _label, _maxDamage];
