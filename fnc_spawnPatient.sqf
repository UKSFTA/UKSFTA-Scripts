params ["_terminal", "_maxDamage", "_label"];

{
    if ((typeOf _x == "b_survivor_F" || typeOf _x == "b_g_survivor_F") && !isPlayer _x) then {
        deleteVehicle _x;
    };
} forEach allUnits;

[_terminal,3] call BIS_fnc_dataTerminalAnimate;
sleep 5;

_group1 = createGroup west;
_pat1 = "b_survivor_F" createUnit [getMarkerPos "PatientSpawn", _group1, ""];
doStop _pat1;
_pat1 setCaptive true;
_pat1 switchMove "AmovPercMstpSsurWnonDnon";

_damageTypes = ["stab","bullet","falling"];
["leg_r","leg_l","body","head","hand_r","hand_l"] forEach {
    _damage = random (_maxDamage);
    [_pat1, _damage, _x, selectRandom _damageTypes] call ace_medical_fnc_addDamageToUnit;
};

[_pat1] call ace_medical_fnc_handleDamage_advancedSetDamage;
[_terminal,0] call BIS_fnc_dataTerminalAnimate;

hint format ["Your patient is ready. Difficulty: %1 (Max %2 damage per body part).", _label, _maxDamage];
