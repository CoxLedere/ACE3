#include "script_component.hpp"
/*
 * Author: bux, commy2
 * Replace the disposable launcher with the used dummy. Called from the unified fired EH.
 *
 * Arguments:
 * None. Parameters inherited from EFUNC(common,firedEH)
 *
 * Return Value:
 * None
 *
 * Example:
 * [fromBisFiredEH] call ace_disposable_fnc_replaceATWeapon;
 *
 * Public: No
 */

//IGNORE_PRIVATE_WARNING ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle", "_gunner", "_turret"];
TRACE_10("firedEH:",_unit, _weapon, _muzzle, _mode, _ammo, _magazine, _projectile, _vehicle, _gunner, _turret);

if (!local _unit || {_weapon != secondaryWeapon _unit})  exitWith {};

private _replacementTube = getText (configFile >> "CfgWeapons" >> _weapon >> "ACE_UsedTube");
if (_replacementTube == "") exitWith {}; //If no replacement defined just exit

//Save array of items attached to launcher
private _items = secondaryWeaponItems _unit;
//Replace the orginal weapon with the 'usedTube' weapon
_unit addWeapon _replacementTube;
//Makes sure the used tube is still equiped
_unit selectWeapon _replacementTube;
//Re-add all attachments to the used tube
{
    if (_x != "") then {_unit addSecondaryWeaponItem _x};
} count _items;

//If we're an AI, we're just going to toss the launcher now.
if (!([_unit] call EFUNC(common,isPlayer))) then {
    [_unit, _replacementTube] call FUNC(throwTube);
};