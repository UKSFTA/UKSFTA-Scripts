private _colors = ["#00FF00","#9ACD32","#FFFF00","#FF8C00","#FF0000"];

private _trainingModes = [
    ["Single (Trivial)", 0.2, ["leg_l","hand_l"], ["stab"], 1, 1],
    ["Single (Easy)",    0.3, ["leg_l","leg_r","hand_l","body"], ["stab"], 1, 1],
    ["Single (Medium)",  0.5, ["body","leg_l","leg_r"], ["stab","bullet"], 1, 1],
    ["Single (Hard)",    0.7, ["body","head","leg_l","leg_r"], ["bullet","stab"], 1, 1],
    ["Single (Extreme)", 0.9, ["head","body","leg_l","leg_r","hand_r"], ["bullet","falling","stab"], 1, 1],
    ["Group (Trivial)",  0.2, ["leg_l","hand_r"], ["stab"], 2, 3],
    ["Group (Easy)",     0.4, ["leg_l","body"], ["stab"], 3, 5],
    ["Group (Medium)",   0.6, ["body","head","leg_l"], ["stab","bullet"], 4, 6],
    ["Group (Hard)",     0.8, ["body","head"], ["bullet","stab"], 5, 8],
    ["Group (Extreme)",  0.9, ["head","body","leg_l","leg_r","hand_r"], ["bullet","falling","stab"], 6, 10]
];

this addAction ["<t color='#FFFFFF'>--- SINGLE PATIENT MODES ---</t>", {}, [], 10, false, false];

for "_i" from 0 to 4 do {
    private _config = _trainingModes select _i;
    this addAction [
        format ["<t color='%1'>%2</t>", _colors select _i, _config select 0],
        { [_this select 0, _this select 1, _this select 2, _this select 3] execVM "spawnPatient.sqf"; },
        _config,
        1.5, true, true, "", "true", 5
    ];
};

this addAction ["<t color='#FFFFFF'>--- GROUP PATIENT MODES ---</t>", {}, [], 10, false, false];

for "_i" from 5 to 9 do {
    private _config = _trainingModes select _i;
    this addAction [
        format ["<t color='%1'>%2</t>", _colors select (_i - 5), _config select 0],
        { [_this select 0, _this select 1, _this select 2, _this select 3] execVM "spawnPatient.sqf"; },
        _config,
        1.5, true, true, "", "true", 5
    ];
};
