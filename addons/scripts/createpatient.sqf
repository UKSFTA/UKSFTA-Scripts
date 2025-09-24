{if ((typeOf _x == 'b_survivor_F') && (!isPlayer _x)) then {deleteVehicle _x}} forEach allUnits;
[MedicalData,3] call BIS_fnc_dataTerminalAnimate;
sleep 5;
_group1=createGroup west;
'b_survivor_F' createUnit [getMarkerPos 'PatientSpawn', _group1,'pat1=this; dostop pat1; pat1 setcaptive true; pat1 switchmove "AmovPercMstpSsurWnonDnon";'];
[pat1, selectRandom[0.3,0.5,0.7,0.9], "leg_r", selectRandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
[pat1, selectRandom[0.3,0.5,0.7,0.9], "leg_l", selectRandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
[pat1, selectRandom[0.3,0.5,0.7,0.9], "body", selectRandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
[pat1, selectRandom[0.3,0.5,0.7,0.9], "head", selectRandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
[pat1, selectRandom[0.3,0.5,0.7,0.9], "hand_r", selectRandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
[pat1, selectRandom[0.3,0.5,0.7,0.9], "hand_l", selectRandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
[pat1] call ace_medical_fnc_handleDamage_advancedSetDamage;
[MedicalData,0] call BIS_fnc_dataTerminalAnimate;
hint 'Your patient is ready';

// The first selectRandom chooses a random damage from a small one to a large one, the second selectRandom chooses the type of damage
