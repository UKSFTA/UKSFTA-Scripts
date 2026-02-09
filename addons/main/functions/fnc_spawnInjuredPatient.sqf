/*
 * Author: UKSFTA Team
 * Description: Spawns an injured patient unit for medical training.
 *
 * Parameter:
 * 0: ARRAY - Position to spawn the patient.
 *
 * Return:
 * OBJECT - The spawned patient.
 */
params [["_pos", [0,0,0], [[]]]];

private _group1 = createGroup civilian;
private _patient = _group1 createUnit ["C_man_1", _pos, [], 0, "NONE"];

[_patient, true] call ace_medical_fnc_setUnconscious;
[_patient, 0.5] call ace_medical_fnc_setBloodLoss;

_patient
