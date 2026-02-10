#define PREFIX UKSFTA
#define SUBPREFIX scripts

#include "\x\cba\addons\main\script_macros_common.hpp"

#define VERSION_CONFIG version = MAJOR.MINOR.PATCHLVL; versionStr = QUOTE(MAJOR.MINOR.PATCHLVL); versionAr[] = {MAJOR,MINOR,PATCHLVL}

#ifdef SUBCOMPONENT
    #define COMPONENT_NAME QUOTE(PREFIX - SUBPREFIX: COMPONENT - SUBCOMPONENT)
#else
    #define COMPONENT_NAME QUOTE(PREFIX - SUBPREFIX: COMPONENT)
#endif
