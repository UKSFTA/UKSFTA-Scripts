/*
 * Author: UKSFTA Team
 * Description: Exports all saved ACE ATragMX presets to the system clipboard in a CSV-style format.
 *
 * Return:
 * NOTHING
 */
private _atragPresets = profileNamespace getVariable ["ACE_ATragMX_gunList", []]; 
private _tableOutput = "// Profile Name, Muzzle Velocity, Zero Range, Scope Base Angle, AirFriction, Bore Height, Scope Unit, Scope Click Unit, Scope Click Number, Maximum Elevation, Dialed Elevation, Dialed Windage, Mass, Bullet Diameter, Rifle Twist, BC, Drag Model, Atmosphere Model, Muzzle Velocity vs. Temperature Interpolation, C1 Ballistic Coefficient vs. Distance Interpolation, Persistent" + endl; 
 
{ 
    _x params [
        "_name", "_muzzleVel", "_zeroRange", "_scopeBaseAngle", "_airFriction", 
        "_boreHeight", "_scopeUnit", "_scopeClickUnit", "_scopeClickNum", 
        "_maxElev", "_dialedElev", "_dialedWind", "_mass", "_bulletDia", 
        "_rifleTwist", "_bc", "_dragModel", "_atmModel", "_mvTempInterp", 
        "_bcDistInterp", "_persistent"
    ]; 
 
    _tableOutput = _tableOutput + format [
        "%1, %2, %3, %4, %5, %6, %7, %8, %9, %10, %11, %12, %13, %14, %15, %16, %17, %18, ""%19"", ""%20"", %21", 
        _name, _muzzleVel, _zeroRange, _scopeBaseAngle, _airFriction, _boreHeight, _scopeUnit, 
        _scopeClickUnit, _scopeClickNum, _maxElev, _dialedElev, _dialedWind, _mass, _bulletDia, 
        _rifleTwist, _bc, _dragModel, _atmModel, _mvTempInterp, _bcDistInterp, _persistent
    ] + endl; 
} forEach _atragPresets; 
 
copyToClipboard _tableOutput; 
hint "Atrag MX presets copied to clipboard as a table!";
