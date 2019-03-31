#include "script_component.hpp"
/*
 * Author: Ledere
 * Have player throw tube on weapon swap.
 *
 * Arguments:
 * 0: unit - Object the event handler is assigned to <OBJECT>
 * 1: weapon - Weapon the unit is switching to <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [fromWeaponEH] call ace_disposable_fnc_playerThrowTubeEvent;
 *
 * Public: No
 */

params ["_unit", "_weapon"];
private _launcher = secondaryWeapon _unit;
if (_launcher == "" || {_weapon == _launcher} || {getNumber (configFile >> "CfgWeapons" >> _launcher >> "ACE_isUsedLauncher") != 1})  exitWith {};

[_unit, _launcher] call FUNC(throwTube);