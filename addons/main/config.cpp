#define COMPONENT main
#include "script_macros.hpp"

class CfgPatches {
    class UKSFTA_Scripts_Main {
        name = "UKSF Task Force Alpha - Scripts Core";
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.60;
        requiredAddons[] = {"cba_main"};
        author = "UKSF Taskforce Alpha Team";
        VERSION_CONFIG;
    };
};

class CfgFunctions {
    class UKSFTA {
        class main {
            tag = "UKSFTA";
            class functions {
                file = "\z\UKSFTA-Scripts\addons\main\functions";
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
