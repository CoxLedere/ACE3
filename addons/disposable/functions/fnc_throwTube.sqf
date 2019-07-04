#include "script_component.hpp"
/*
 * Author: Ledere
 * Dump an already fired tube.
 *
 * Arguments:
 * 0: unit - Unit to remove used tube from <OBJECT>
 * 1: launcher - The tube that is being removed <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit, _launcher] call ace_disposable_fnc_throwTube;
 *
 * Public: No
 */

params ["_unit", "_launcher"];
//Remove the weapon and "throw" it on the ground.
_unit removeWeaponGlobal _launcher;
private _containerPosition =  ASLToATL (_unit modelToWorldWorld ((_unit selectionPosition ["rightshoulder", "Memory"]) vectorAdd [0, 0.2, 0.1])); //No direct modelSpace -> ATL, so we need to go modelSpace -> ASL then ASL -> ATL
private _container = createVehicle ["WeaponHolderSimulated", _containerPosition, [], 0, "CAN_COLLIDE"];
_container addWeaponCargoGlobal [_launcher, 1];
_container setDir (getDir _unit - 90);
//We get the current velocity of the soldier, then apply it to the launcher. Position 0 and 1 in the array are reversed because the model is rotated by 90 degrees
_currentVelocity = velocityModelSpace _unit;
_container setVelocityModelSpace ([_currentVelocity # 1, _currentVelocity # 0, _currentVelocity # 2] vectorAdd [0.2, -1.5, 0]);