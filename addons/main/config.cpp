#define COMPONENT main
#include "script_macros.hpp"

class CfgPatches {
    class UKSFTA_Scripts_Main {
        name = "UKSF Task Force Alpha - Scripts Core";
        units[] = {};
        weapons[] = {};
        requiredVersion = 2.02;
        requiredAddons[] = {"cba_main"};
        author = QUOTE(AUTHOR);
    };
};

class CfgFunctions {
    class UKSFTA {
        class main {
            tag = "UKSFTA";
            class functions {
                file = "z\uksfta\addons\main\functions";
                // Functions will be registered as UKSFTA_fnc_filename
                class activateScrambleAlarm;
                class addAircraftSpawnActions;
                class addAtragMXPresetLoadAction;
                class addScrambleAlarmActivationAction;
                class createAtragMXPresetFromWeapon;
                class exportAtragMXPresetsToClipboard;
                class generateAtragMXPresetFromCurrentWeapon;
                class haloInsertionManager;
                class setVehicleDirectionFromMarker;
                class spawnInjuredPatient;
                class spawnPatient;
                class spawnVehicleAtMarker;
                class vehicleCTR_single;
            };
        };
    };
};
