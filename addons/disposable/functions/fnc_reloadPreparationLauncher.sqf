#include "script_component.hpp"
/*
 * Author: Ledere
 * Add launcher magazine when player attempts to reload.
 *
 * Arguments:
 * 0: unit - Unit we want to modify <OBJECT>
 * 1: caller - From addAction, should be the same as unit <OBJECT>
 * 2: id - From addAction <NUMBER>
 * 3: weapon - Weapon the unit is switching to <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * _unit addAction ["", ace_disposable_fnc_reloadPreparationLauncher, _magazine, 0, false, true, "ReloadMagazine"];
 *
 * Public: No
 */
 
params ["_unit", "_caller", "_id", "_magazine"];


_unit removeAction _id;
private _addedBackpack = false;
if (backpack _unit == "") then {
    _unit addBackpack "ACE_FakeBackpack";
    _addedBackpack = true;
};

_unit addMagazine _magazine;

//loadMagazine action only takes the ID of the magazine that is loaded into the launcher. So we need to do some weird stuff to get this ID
//We need to get magazinesDetail as this is the only place that stores the ID
_magazines = magazinesDetailBackpack _unit;
//We need the DisplayName of the magazine to get the right ID
private _magazineName = getText (configFile >> "CfgMagazines" >> _magazine >> "DisplayName");
//Set this to -1 so we can easily check if the next section fails
private _id = -1;
//Loop through magazinesDetail, looking for the DisplayName in each string.
{
    if (_x find _magazineName >= 0) then {
        //When we find the magazine we're looking for, we split the string into an array so we can reference the specific ID every time. Non-ASCII characters shouldn't break this as we're looking from the back of the array
        private _detailArray = _x splitString ":/";
        _id = parseNumber (_detailArray # (count _detailArray -2));
    };
} forEach _magazines;

if (_id == -1) then {
    //Something went wrong, just add the magazine directly to the launcher so they can use it
    private _launcher = secondaryWeapon _unit;
    _unit removeWeapon _launcher;
    _unit addWeapon _launcher;
    _unit selectWeapon _launcher;
} else {
    //Force the player to load the launcher with animation
    _unit action ["loadMagazine", _unit, _unit, 0, _id, currentWeapon _unit, currentMuzzle _unit];
};

if(_addedBackpack) then {
    removeBackpack _unit;
};