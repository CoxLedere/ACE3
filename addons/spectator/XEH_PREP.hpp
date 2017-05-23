// Camera functions
PREP(cam);
PREP(cam_prepareTarget);
PREP(cam_resetTarget);
PREP(cam_setCameraMode);
PREP(cam_setTarget);
PREP(cam_setVisionMode);
PREP(cam_tick);
PREP(cam_toggleVeryFast);

// UI functions
PREP(ui);
PREP(ui_draw3D);
PREP(ui_fadeList);
PREP(ui_getTreeDataIndex);
PREP(ui_handleChildDestroyed);
PREP(ui_handleKeyDown);
PREP(ui_handleKeyUp);
PREP(ui_handleListClick);
PREP(ui_handleMapClick);
PREP(ui_handleMapDraw);
PREP(ui_handleMouseButtonDblClick);
PREP(ui_handleMouseButtonDown);
PREP(ui_handleMouseMoving);
PREP(ui_handleMouseZChanged);
PREP(ui_handleTabSelected);
PREP(ui_toggleMap);
PREP(ui_toggleUI);
PREP(ui_updateHelp);
PREP(ui_updateIconsToDraw);
PREP(ui_updateListEntities);
PREP(ui_updateListFocus);
PREP(ui_updateListLocations);
PREP(ui_updateWidget);

// Utility functions
PREP(compat_counter);
PREP(compat_spectatorBI);
PREP(getTargetEntities);
PREP(getTargetGroups);
PREP(handleFired);
PREP(moduleSpectatorSettings);
PREP(respawnTemplate);
PREP(setFocus);

// Public functions
PREP(addLocation);
PREP(interrupt);
PREP(removeLocation);
PREP(setCameraAttributes);
PREP(setSpectator);
PREP(stageSpectator);
PREP(updateCameraModes);
PREP(updateSides);
PREP(updateUnits);
PREP(updateVisionModes);

// Deprecated (temp)
DFUNC(updateSpectatableSides) = {
    ACE_DEPRECATED(QFUNC(updateSpectatableSides),"3.12.0",QFUNC(updateSides));
    _this call FUNC(updateSides);
};
