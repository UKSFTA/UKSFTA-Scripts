#define QUOTE(var1) #var1
#define GVAR(var1) PREFIX##_##COMPONENT##_##var1
#define QGVAR(var1) QUOTE(GVAR(var1))
#define ARR_1(ARG1) ARG1
#define ARR_2(ARG1,ARG2) ARG1, ARG2
#define ARR_3(ARG1,ARG2,ARG3) ARG1, ARG2, ARG3

// Versioning Macros
#define VERSION "1.0.0"
#define VERSION_STR 1.0.0
#define VERSION_AR 1,0,0

#define AUTHOR UKSF Taskforce Alpha Team

#define VERSION_CONFIG version = VERSION; versionStr = QUOTE(VERSION_STR); versionAr[] = {VERSION_AR}
