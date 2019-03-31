class CfgWeapons {
    class Launcher;
    class Launcher_Base_F: Launcher {
        class WeaponSlotsInfo;
    };
    class launch_NLAW_F: Launcher_Base_F {
        ACE_UsedTube = "ACE_launch_NLAW_Used_F";      // The class name of the used tube.
        magazines[] = {"ACE_PreloadedMissileDummy_NLAW"};  // The dummy magazine
        model = "\A3\weapons_f\launchers\nlaw\nlaw_loaded_F";
        class WeaponSlotsInfo: WeaponSlotsInfo {
            mass = 180;
        };
    };
    class ACE_launch_NLAW_Used_F: launch_NLAW_F {   // the used tube should be a sub class of the disposable launcher
        EGVAR(nlaw,enabled) = 0; // disable guidance for the disposabled tube
        scope = 1;
        ACE_isUsedLauncher = 1;
        author = ECSTRING(common,ACETeam);
        displayName = CSTRING(UsedTube);
        descriptionShort = CSTRING(UsedTubeDescription);
        magazines[] = {"ACE_FiredMissileDummy"};  // This will disable the used launcher class from being fired again.
        model = "\A3\weapons_F\launchers\nlaw\nlaw_F.p3d";
        weaponPoolAvailable = 0;
        class WeaponSlotsInfo: WeaponSlotsInfo {
            mass = 100;
        };
    };
};