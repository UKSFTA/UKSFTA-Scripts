_atragPresets = profileNamespace getVariable ["ACE_ATragMX_gunList", []]; 
_tableOutput = "// Profile Name, Muzzle Velocity, Zero Range, Scope Base Angle, AirFriction, Bore Height, Scope Unit, Scope Click Unit, Scope Click Number, Maximum Elevation, Dialed Elevation, Dialed Windage, Mass, Bullet Diameter, Rifle Twist, BC, Drag Model, Atmosphere Model, Muzzle Velocity vs. Temperature Interpolation, C1 Ballistic Coefficient vs. Distance Interpolation, Persistent" + endl; 
 
{ 
    _name = _x select 0; 
    _muzzleVel = _x select 1; 
    _zeroRange = _x select 2; 
    _scopeBaseAngle = _x select 3; 
    _airFriction = _x select 4; 
    _boreHeight = _x select 5; 
    _scopeUnit = _x select 6; 
    _scopeClickUnit = _x select 7; 
    _scopeClickNum = _x select 8; 
    _maxElev = _x select 9; 
    _dialedElev = _x select 10; 
    _dialedWind = _x select 11; 
    _mass = _x select 12; 
    _bulletDia = _x select 13; 
    _rifleTwist = _x select 14; 
    _bc = _x select 15; 
    _dragModel = _x select 16; 
    _atmModel = _x select 17; 
    _mvTempInterp = _x select 18; 
    _bcDistInterp = _x select 19; 
    _persistent = _x select 20; 
 
    _tableOutput = _tableOutput + format ["%1, %2, %3, %4, %5, %6, %7, %8, %9, %10, %11, %12, %13, %14, %15, %16, %17, %18, ""%19"", ""%20"", %21", _name, _muzzleVel, _zeroRange, _scopeBaseAngle, _airFriction, _boreHeight, _scopeUnit, _scopeClickUnit, _scopeClickNum, _maxElev, _dialedElev, _dialedWind, _mass, _bulletDia, _rifleTwist, _bc, _dragModel, _atmModel, _mvTempInterp, _bcDistInterp, _persistent] + endl; 
} forEach _atragPresets; 
 
copyToClipboard _tableOutput; 
hint "Atrag MX presets copied to clipboard as a table!";
