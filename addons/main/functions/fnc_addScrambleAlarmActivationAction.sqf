/*
 * Author: UKSFTA Team
 * Description: Adds the scramble alarm activation action to an object.
 *
 * Parameter:
 * 0: OBJECT - The object to add the action to.
 *
 * Return:
 * NOTHING
 */
params [["_host", objNull, [objNull]]];

if (isNull _host) exitWith {};

_host addAction ["<t color='#FF0000'>Activate Alarm</t>", { _this call UKSFTA_fnc_activateScrambleAlarm }];
