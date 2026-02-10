#define PREFIX UKSFTA
#define SUBPREFIX scripts

#include "script_version.hpp"
#include "\x\cba\addons\main\script_macros_common.hpp"

#ifdef SUBCOMPONENT
    #define COMPONENT_NAME QUOTE(PREFIX - SUBPREFIX: COMPONENT - SUBCOMPONENT)
#else
    #define COMPONENT_NAME QUOTE(PREFIX - SUBPREFIX: COMPONENT)
#endif

#define VERSION_CONFIG \
    version = MAJOR.MINOR; \
    versionStr = QUOTE(MAJOR.MINOR.PATCHLVL); \
    versionAr[] = {MAJOR,MINOR,PATCHLVL}
