#include "script_component.hpp"
/*
 * Author: Ledere
 * Check if launcher is a hasPreparation launcher, if so, add an action to allow reloading.
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

//Override regular reload handling so we can spawn a magazine for the launcher in on demand.
private _actionID = _unit addAction ["", DFUNC(reloadPreparationLauncher), _magazine, 0, false, true, "ReloadMagazine"];

//Running this perFrame so we can hold onto the actionID and magazine. The alternative is looping through every actionID the player has trying to find the one we created on weapon switch.
[{currentWeapon (_this # 0) != (_this # 1)},
    {
        params["_unit", "_weapon", "_actionID", "_magazine"];
        if ((_unit actionParams _actionID) # 2 isEqualTo _magazine) then {
            _unit removeAction _actionID; //Remove the action we added above so the player can reload normally.
        };
    },
[_unit, _weapon, _actionID, _magazine]] call CBA_fnc_waitUntilAndExecute;