this addAction ["Download ATrag Preset From Weapon", {
	private _player = _this select 1;
	private _userZeroRange = 100;

	private _weaponsInfo = _player weaponsInfo ["", true];
	private _selectedWeaponInfo = _weaponsInfo findIf {
		_x select 1
	};
	if (_selectedWeaponInfo == -1) exitWith {
		hint "Error: No selected weapon found. Please ensure you are holding a primary weapon with a loaded magazine.";
	};

	private _weapon = (_weaponsInfo select _selectedWeaponInfo) select 2;
	private _magazine = (_weaponsInfo select _selectedWeaponInfo) select 5;
	if (_weapon == "" || _magazine == "") exitWith {
		hint "Error: Could not retrieve weapon or magazine name. Please ensure you are holding a primary weapon with a loaded magazine.";
	};

	private _ammoClassName = getText (configFile >> "CfgMagazines" >> _magazine >> "ammo");
	if (_ammoClassName == "") exitWith {
		hint "Error: Ammunition class name not found for the current magazine.";
	};

	private _weaponConfig = configFile >> "CfgWeapons" >> _weapon;
	private _ammoConfig = configFile >> "CfgAmmo" >> _ammoClassName;
	if (!isClass _ammoConfig) exitWith {
		hint format ["Error: The ammo class '%1' does not exist in the game config.", _ammoClassName];
	};

	private _barrelTwist_raw = 0 max getNumber(_weaponConfig >> "ACE_barrelTwist");
	private _rifleTwist = if (_barrelTwist_raw > 100) then {
		_barrelTwist_raw / 10
	} else {
		_barrelTwist_raw
	};
	private _boreHeight = getNumber(_weaponConfig >> "ACE_barrelBoreHeight");
	if (_boreHeight isEqualTo 0) then {
		_boreHeight = 3.81;
	};

	private _airFriction = getNumber(_ammoConfig >> "airFriction");
	private _bulletMass = 0 max getNumber(_ammoConfig >> "ACE_bulletMass");
	private _dragModel = getNumber(_ammoConfig >> "ACE_dragModel");
	private _ballisticCoefficients = getArray(_ammoConfig >> "ACE_ballisticCoefficients");
	if (_ballisticCoefficients isEqualTo []) then {
		_ballisticCoefficients = [0.5];
	};

	private _atmosphereModel = getText(_ammoConfig >> "ACE_standardAtmosphere");
	if (_atmosphereModel == "") then {
		_atmosphereModel = "ICAO";
	};

	private _ammoTempMuzzleVelocityShifts = getArray(_ammoConfig >> "ACE_ammoTempMuzzleVelocityShifts");
	private _muzzleVelocityTable = getArray(_ammoConfig >> "ACE_muzzleVelocities");

	private _getAverage = {
		params ["_array"];
		private _count = count _array; if (_count == 0) exitWith {
			0
		};
		private _sum = 0; {
			_sum = _sum + _x
		} forEach _array;
		_sum / _count
	};
	private _muzzleVel_avg = [_muzzleVelocityTable] call _getAverage;
	private _bc_avg = [_ballisticCoefficients] call _getAverage;

	private _mvTempInterp_formatted = [];
	{
		_mvTempInterp_formatted pushBack [_x, 0];
	} forEach _ammoTempMuzzleVelocityShifts;

	private _weaponDisplayName = getText(configFile >> "CfgWeapons" >> _weapon >> "displayName");
	private _weaponClean = _weaponDisplayName call {
		private _str = _this;
		if (_str find "[" == 0) then {
		_str = (_str splitString "]") select 1;
		_str = (_str call trimLeft);
	};
	_str;
};
private _weaponWords = _weaponClean splitString " ";
private _weaponShort = (_weaponWords select {
	_x != ""
}) select 0;

private _ammoDisplayName = getText(configFile >> "CfgMagazines" >> _magazine >> "displayName");
private _ammoCaliber = (_ammoDisplayName splitString " ") select 0;

private _presetName = format ["%1 (%2)", _weaponShort, _ammoCaliber];

private _newPreset = [
	_presetName,
	_muzzleVel_avg,
	_userZeroRange,
	0,
	_airFriction,
	_boreHeight,
	0,
	0,
	0,
	0,
	0,
	0,
	_bulletMass,
	0,
	_rifleTwist,
	_bc_avg,
	_dragModel,
	_atmosphereModel,
	_mvTempInterp_formatted,
	[],
	true
];

private _presets = profileNamespace getVariable ["ACE_ATragMX_gunList", []];
private _foundIndex = _presets findIf {
	(_x select 0) == _presetName
};

if (_foundIndex != -1) then {
	_presets set [_foundIndex, _newPreset];
	hint format ["Updated ATrag preset for %1.", _presetName];
} else {
	_presets pushBack _newPreset;
	hint format ["Added new ATrag preset for %1.", _presetName];
};

profileNamespace setVariable ["ACE_ATragMX_gunList", _presets];
saveProfileNamespace;
}];
