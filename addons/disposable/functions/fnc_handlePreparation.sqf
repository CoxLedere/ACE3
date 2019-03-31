#include "script_component.hpp"
/*
 * Author: Ledere
 * Handle preparation animation for supported launchers.
 *
 * Arguments:
 * 0: unit - Object the event handler is assigned to <OBJECT>
 * 1: weapon - Weapon the unit is switching to <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [fromWeaponEH] call ace_disposable_fnc_handlePreparation;
 *
 * Public: No
 */

params ["_unit", "_weapon"];

//If current weapon is not a launcher, exit.
if (_weapon != secondaryWeapon _unit) exitWith {};

//If our current launcher is not a hasPreparation launcher, or if our launcher is actually a used launcher, exit. We do this here because the weaponEH is called for every weapon change.
private _config = configFile >> "CfgWeapons" >> _weapon;
if (getNumber (_config >> QGVAR(hasPreparation)) != 1 || {getNumber (_config >> "ACE_isUsedLauncher") == 1}) exitWith {};

private _magazine = getArray (_config >> "magazines") # 0;
_unit removeSecondaryWeaponItem _magazine;
/*if (backpack _unit == "") then {
    _unit addBackpack "ACE_FakeBackpack";
};*/

_unit addMagazine _magazine;