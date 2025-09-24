// List of vehicles to add as actions.
// Each inner array contains [Display Name, Vehicle Class Name]
private _vehicle_list = [
    ["Spawn F-35B Lightning II (ZM136)", "FIR_F35B_RAF01"],
    ["Spawn F-35B Lightning II (ZM147)", "FIR_F35B_RAF02"],
    ["Spawn Aero Commander 500r", "UK3CB_B_AC500_HIDF"],
    ["Spawn Cessna 400 Navy", "UK3CB_MDF_B_C400_NAVY"],
    ["Spawn BAE Hawk T1", "sab_baehawk_b_1"],
    ["Spawn BAE Hawk T2", "sab_baehawk_b_2"],
    ["Spawn Typhoon F3 (RAF)", "Tornado_AWS_ADV_UK"],
    ["Spawn Typhoon GR 4 (RAF)", "Tornado_AWS_camo_uk"],
    ["Spawn Typhoon GR 4 (RAF Camo)", "Tornado_AWS_UK_617"],
    ["Spawn Typhoon GR 4 (RAF Desert Storm)", "Tornado_AWS_UK_DS"]
];

// Loop through the list and add an action for each vehicle.
{
    private _display_name = _x select 0;
    private _vehicle_class = _x select 1;
    this addAction [_display_name, "scripts\spawn_vehicle.sqf", [_vehicle_class]];
} forEach _vehicle_list;
