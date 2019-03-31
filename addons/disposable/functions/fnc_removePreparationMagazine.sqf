#include "script_component.hpp"
/*
 * Author: Ledere
 * Remove magazines for hasPreparation launchers.
 *
 * Arguments:
 * 0: unit - Object the event handler is assigned to <OBJECT>
 * 1: weapon - Weapon the unit is switching to <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [fromWeaponEH] call ace_disposable_fnc_removePreparationMagazine;
 *
 * Public: No
 */

params ["_unit", "_weapon"];
private _launcher = secondaryWeapon _unit;
if (_launcher == "" || {_weapon == _launcher})  exitWith {};

private _config = configFile >> "CfgWeapons" >> _launcher;
if (getNumber (_config >> QGVAR(hasPreparation)) != 1) exitWith {};

private _magazine = getArray (_config >> "magazines") # 0;
_unit removeMagazines _magazine; //Remove the magazine if the player doesn't load the launcher so it's not just hanging around in their inventory.
//Check if we gave the player a dummy backpack, and if so, remove it only if it is empty.
/*if (backpack _unit == "ACE_FakeBackpack" && {backpackItems _unit isEqualTo []}) then {
    removeBackpack _unit;
};*/