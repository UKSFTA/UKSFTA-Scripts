/*
 * Author: UKSFTA Team
 * Description: Generates and saves an ACE ATragMX preset based on the player's current weapon and ammo.
 *
 * Parameter:
 * 0: OBJECT - The unit to generate the preset for (usually player).
 *
 * Return:
 * NOTHING
 */
params [["_player", player, [objNull]]];

private _userZeroRange = 100;
private _weapon = primaryWeapon _player;
private _mags = primaryWeaponMagazine _player;

if (_weapon == "" || count _mags == 0) exitWith {
    hint "Error: No primary weapon or magazine found.";
};

private _magazine = _mags select 0;
private _ammoClassName = getText (configFile >> "CfgMagazines" >> _magazine >> "ammo");
private _weaponConfig = configFile >> "CfgWeapons" >> _weapon;
private _ammoConfig = configFile >> "CfgAmmo" >> _ammoClassName;

private _barrelTwist_raw = 0 max getNumber(_weaponConfig >> "ACE_barrelTwist");
private _rifleTwist = if (_barrelTwist_raw > 100) then { _barrelTwist_raw / 10 } else { _barrelTwist_raw };
private _boreHeight = getNumber(_weaponConfig >> "ACE_barrelBoreHeight");
if (_boreHeight == 0) then { _boreHeight = 3.81; };

private _airFriction = getNumber(_ammoConfig >> "airFriction");
private _bulletMass = 0 max getNumber(_ammoConfig >> "ACE_bulletMass");
private _dragModel = getNumber(_ammoConfig >> "ACE_dragModel");
private _ballisticCoefficients = getArray(_ammoConfig >> "ACE_ballisticCoefficients");
if (count _ballisticCoefficients == 0) then { _ballisticCoefficients = [0.5]; };

private _muzzleVelocityTable = getArray(_ammoConfig >> "ACE_muzzleVelocities");

private _getAverage = {
    params ["_array"];
    private _sum = 0;
    { _sum = _sum + _x } forEach _array;
    if (count _array == 0) exitWith { 0 };
    _sum / (count _array)
};

private _muzzleVel_avg = [_muzzleVelocityTable] call _getAverage;
private _bc_avg = [_ballisticCoefficients] call _getAverage;

private _mvTempInterp_formatted = [];
private _ammoTempMuzzleVelocityShifts = getArray(_ammoConfig >> "ACE_ammoTempMuzzleVelocityShifts");
{ _mvTempInterp_formatted pushBack [_x, 0]; } forEach _ammoTempMuzzleVelocityShifts;

private _weaponDisplayName = getText(configFile >> "CfgWeapons" >> _weapon >> "displayName");
private _presetName = format ["%1 (%2)", _weaponDisplayName, _ammoClassName];

private _newPreset = [
    _presetName, _muzzleVel_avg, _userZeroRange, 0, _airFriction, _boreHeight,
    0, 0, 0, 0, 0, 0, _bulletMass, 0, _rifleTwist, _bc_avg, _dragModel,
    "ICAO", _mvTempInterp_formatted, [], true
];

private _presets = profileNamespace getVariable ["ACE_ATragMX_gunList", []];
private _foundIndex = -1;
{ if ((_x select 0) == _presetName) exitWith { _foundIndex = _forEachIndex; }; } forEach _presets;

if (_foundIndex != -1) then { _presets set [_foundIndex, _newPreset]; } else { _presets pushBack _newPreset; };

profileNamespace setVariable ["ACE_ATragMX_gunList", _presets];
saveProfileNamespace;
hint format ["Preset saved: %1", _presetName];
