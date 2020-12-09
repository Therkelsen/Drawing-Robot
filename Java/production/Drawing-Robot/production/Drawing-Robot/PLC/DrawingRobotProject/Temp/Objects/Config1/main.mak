SHELL := cmd.exe
CYGWIN=nontsec
export PATH := C:\Python39\Scripts\;C:\Python39\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\Program Files\NVIDIA Corporation\NVIDIA NvDLISR;C:\Program Files\nodejs\;C:\ProgramData\chocolatey\bin;C:\Program Files\dotnet\;C:\Program Files\Git\cmd;C:\Users\Thomas Therkelsen\AppData\Local\Microsoft\WindowsApps;C:\Users\Thomas Therkelsen\AppData\Local\GitHubDesktop\bin;C:\Users\Thomas Therkelsen\AppData\Roaming\npm;C:\Users\Thomas Therkelsen\AppData\Local\Programs\Microsoft VS Code\bin;C:\Program Files (x86)\Common Files\Hilscher GmbH\TLRDecode;C:\Program Files (x86)\Nmap;C:\Users\Thomas Therkelsen\AppData\Local\Microsoft\WindowsApps;C:\Users\Thomas Therkelsen\AppData\Local\GitHubDesktop\bin;C:\Users\Thomas Therkelsen\AppData\Roaming\npm;C:\Users\Thomas Therkelsen\AppData\Local\Programs\Microsoft VS Code\bin;C:\Program Files (x86)\Common Files\Hilscher GmbH\TLRDecode;C:\Program Files (x86)\Nmap
export AS_BUILD_MODE := BuildAndTransfer
export AS_VERSION := 4.8.2.72
export AS_COMPANY_NAME :=  
export AS_USER_NAME := Thomas Therkelsen
export AS_PATH := C:/BrAutomation/AS48
export AS_BIN_PATH := C:/BrAutomation/AS48/Bin-en
export AS_PROJECT_PATH := C:/Users/Thomas\ Therkelsen/Documents/GitHub/Drawing-Robot/PLC/DrawingRobotProject
export AS_PROJECT_NAME := DrawingRobotProject
export AS_SYSTEM_PATH := C:/BrAutomation/AS/System
export AS_VC_PATH := C:/BrAutomation/AS48/AS/VC
export AS_TEMP_PATH := C:/Users/Thomas\ Therkelsen/Documents/GitHub/Drawing-Robot/PLC/DrawingRobotProject/Temp
export AS_CONFIGURATION := Config1
export AS_BINARIES_PATH := C:/Users/Thomas\ Therkelsen/Documents/GitHub/Drawing-Robot/PLC/DrawingRobotProject/Binaries
export AS_GNU_INST_PATH := C:/BrAutomation/AS48/AS/GnuInst/V4.1.2
export AS_GNU_BIN_PATH := $(AS_GNU_INST_PATH)/bin
export AS_GNU_INST_PATH_SUB_MAKE := C:/BrAutomation/AS48/AS/GnuInst/V4.1.2
export AS_GNU_BIN_PATH_SUB_MAKE := $(AS_GNU_INST_PATH_SUB_MAKE)/bin
export AS_INSTALL_PATH := C:/BrAutomation/AS48
export WIN32_AS_PATH := "C:\BrAutomation\AS48"
export WIN32_AS_BIN_PATH := "C:\BrAutomation\AS48\Bin-en"
export WIN32_AS_PROJECT_PATH := "C:\Users\Thomas Therkelsen\Documents\GitHub\Drawing-Robot\PLC\DrawingRobotProject"
export WIN32_AS_SYSTEM_PATH := "C:\BrAutomation\AS\System"
export WIN32_AS_VC_PATH := "C:\BrAutomation\AS48\AS\VC"
export WIN32_AS_TEMP_PATH := "C:\Users\Thomas Therkelsen\Documents\GitHub\Drawing-Robot\PLC\DrawingRobotProject\Temp"
export WIN32_AS_BINARIES_PATH := "C:\Users\Thomas Therkelsen\Documents\GitHub\Drawing-Robot\PLC\DrawingRobotProject\Binaries"
export WIN32_AS_GNU_INST_PATH := "C:\BrAutomation\AS48\AS\GnuInst\V4.1.2"
export WIN32_AS_GNU_BIN_PATH := "$(WIN32_AS_GNU_INST_PATH)\\bin" 
export WIN32_AS_INSTALL_PATH := "C:\BrAutomation\AS48"

.suffixes:

ProjectMakeFile:

	@'$(AS_BIN_PATH)/BR.AS.AnalyseProject.exe' '$(AS_PROJECT_PATH)/DrawingRobotProject.apj' -t '$(AS_TEMP_PATH)' -c '$(AS_CONFIGURATION)' -o '$(AS_BINARIES_PATH)'   -sfas -buildMode 'BuildAndTransfer'   

