#include "script_component.hpp"

if (hasInterface) then {
    [
        "UKSFTA_CTR",
        "UKSFTA CTR",
        "UKSFTA Vehicle CTR Settings",
        "UKSFTA",
        "UKSFTA Vehicle CTR",
        true
    ] call CBA_fnc_addSetting;

    // Settings for veh_1
    [
        "UKSFTA_CTR_veh_1",
        "Vehicle 1 Settings",
        "Settings for veh_1",
        "UKSFTA CTR",
        "UKSFTA_CTR"
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_1_detectRadius",
        "Detection Radius",
        "The radius in which the vehicle will detect players.",
        "UKSFTA CTR",
        "NUMBER",
        300,
        [100, 1000, 0]
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_1_confirmTime",
        "Confirm Time",
        "The time in seconds it takes to confirm a contact.",
        "UKSFTA CTR",
        "NUMBER",
        2,
        [1, 10, 0]
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_1_requireLoS",
        "Require LoS",
        "If true, the vehicle needs line of sight to detect players.",
        "UKSFTA CTR",
        "CHECKBOX",
        true
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_1_approachSpeed",
        "Approach Speed",
        "The speed at which the vehicle will approach the target.",
        "UKSFTA CTR",
        "NUMBER",
        90,
        [30, 200, 0]
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_1_arrivalRadius",
        "Arrival Radius",
        "The radius at which the vehicle will consider itself to have arrived at the target.",
        "UKSFTA CTR",
        "NUMBER",
        25,
        [10, 100, 0]
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_1_dismountDelay",
        "Dismount Delay",
        "The delay in seconds between each unit dismounting.",
        "UKSFTA CTR",
        "NUMBER",
        0.3,
        [0.1, 5, 1]
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_1_garrisonRadius",
        "Garrison Radius",
        "The radius in which the AI will garrison.",
        "UKSFTA CTR",
        "NUMBER",
        35,
        [10, 200, 0]
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_1_postureCombat",
        "Combat Posture",
        "The posture the AI will adopt in combat.",
        "UKSFTA CTR",
        "STRING",
        "COMBAT"
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_1_postureHide",
        "Hide Posture",
        "The posture the AI will adopt when hiding.",
        "UKSFTA CTR",
        "STRING",
        "STEALTH"
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_1_teleport",
        "Teleport to Garrison",
        "If true, units will teleport to garrison positions. If false, they will walk.",
        "UKSFTA CTR",
        "CHECKBOX",
        false
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_1_coverSearchRadius",
        "Cover Search Radius",
        "Radius around target position to search for cover for the vehicle.",
        "UKSFTA CTR",
        "NUMBER",
        100,
        [50, 500, 0]
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_1_coverTarget",
        "Cover Target Object",
        "Name of the object to find cover from. Leave empty to use detected contact.",
        "UKSFTA CTR",
        "STRING",
        ""
    ] call CBA_fnc_addSetting;

    // Settings for veh_2
    [
        "UKSFTA_CTR_veh_2",
        "Vehicle 2 Settings",
        "Settings for veh_2",
        "UKSFTA CTR",
        "UKSFTA_CTR"
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_2_detectRadius",
        "Detection Radius",
        "The radius in which the vehicle will detect players.",
        "UKSFTA CTR",
        "NUMBER",
        300,
        [100, 1000, 0]
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_2_confirmTime",
        "Confirm Time",
        "The time in seconds it takes to confirm a contact.",
        "UKSFTA CTR",
        "NUMBER",
        2,
        [1, 10, 0]
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_2_requireLoS",
        "Require LoS",
        "If true, the vehicle needs line of sight to detect players.",
        "UKSFTA CTR",
        "CHECKBOX",
        true
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_2_approachSpeed",
        "Approach Speed",
        "The speed at which the vehicle will approach the target.",
        "UKSFTA CTR",
        "NUMBER",
        90,
        [30, 200, 0]
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_2_arrivalRadius",
        "Arrival Radius",
        "The radius at which the vehicle will consider itself to have arrived at the target.",
        "UKSFTA CTR",
        "NUMBER",
        25,
        [10, 100, 0]
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_2_dismountDelay",
        "Dismount Delay",
        "The delay in seconds between each unit dismounting.",
        "UKSFTA CTR",
        "NUMBER",
        0.3,
        [0.1, 5, 1]
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_2_garrisonRadius",
        "Garrison Radius",
        "The radius in which the AI will garrison.",
        "UKSFTA CTR",
        "NUMBER",
        35,
        [10, 200, 0]
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_2_postureCombat",
        "Combat Posture",
        "The posture the AI will adopt in combat.",
        "UKSFTA CTR",
        "STRING",
        "COMBAT"
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_2_postureHide",
        "Hide Posture",
        "The posture the AI will adopt when hiding.",
        "UKSFTA CTR",
        "STRING",
        "STEALTH"
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_2_teleport",
        "Teleport to Garrison",
        "If true, units will teleport to garrison positions. If false, they will walk.",
        "UKSFTA CTR",
        "CHECKBOX",
        false
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_2_coverSearchRadius",
        "Cover Search Radius",
        "Radius around target position to search for cover for the vehicle.",
        "UKSFTA CTR",
        "NUMBER",
        100,
        [50, 500, 0]
    ] call CBA_fnc_addSetting;

    [
        "UKSFTA_CTR_veh_2_coverTarget",
        "Cover Target Object",
        "Name of the object to find cover from. Leave empty to use detected contact.",
        "UKSFTA CTR",
        "STRING",
        ""
    ] call CBA_fnc_addSetting;
};
