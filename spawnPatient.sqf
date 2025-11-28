private _colors = ["#00FF00","#9ACD32","#FFFF00","#FF8C00","#FF0000"];
private _trainingModes = [
    ["Single Patient (Trivial)", 0.2, ["leg_l","hand_l"], ["stab"], 1, 1],
    ["Single Patient (Easy)",    0.3, ["leg_l","leg_r","hand_l","body"], ["stab"], 1, 1],
    ["Single Patient (Medium)",  0.5, ["body","leg_l","leg_r"], ["stab","bullet"], 1, 1],
    ["Single Patient (Hard)",    0.7, ["body","head","leg_l","leg_r"], ["bullet","stab"], 1, 1],
    ["Single Patient (Extreme)", 0.9, ["head","body","leg_l","leg_r","hand_r"], ["bullet","falling","stab"], 1, 1],
    ["Group Patient (Trivial)",  0.2, ["leg_l","hand_r"], ["stab"], 2, 3],
    ["Group Patient (Easy)",     0.4, ["leg_l","body"], ["stab"], 3, 5],
    ["Group Patient (Medium)",   0.6, ["body","head","leg_l"], ["stab","bullet"], 4, 6],
    ["Group Patient (Hard)",     0.8, ["body","head"], ["bullet","stab"], 5, 8],
    ["Group Patient (Extreme)",  0.9, ["head","body","leg_l","leg_r","hand_r"], ["bullet","falling","stab"], 6, 10]
];


this addAction ["<t color='#FFFFFF'><u><b>--- SINGLE PATIENT MODES ---</b></u></t>", {true}, [], 100, false, false];
for "_i" from 0 to 4 do {
    private _config = _trainingModes select _i;
    private _display_name = _config select 0;
    private _color = _colors select _i;
    this addAction [
        format ["<t color='%1'>%2</t>", _color, _display_name],
        {
            params ["_target", "_caller", "_actionId", "_cfg"];
            [_target, _caller, _actionId, _cfg] execVM "spawnPatient.sqf";
        },
        _config
    ];
};


this addAction ["", {true}, [], 100, false, false];
this addAction ["<t color='#FFFFFF'><u><b>--- GROUP PATIENT MODES ---</b></u></t>", {true}, [], 100, false, false];
for "_i" from 5 to 9 do {
    private _config = _trainingModes select _i;
    private _display_name = _config select 0;
    private _color = _colors select (_i - 5);
    this addAction [
        format ["<t color='%1'>%2</t>", _color, _display_name],
        {
            params ["_target", "_caller", "_actionId", "_cfg"];
            [_target, _caller, _actionId, _cfg] execVM "spawnPatient.sqf";
        },
        _config
    ];
};
