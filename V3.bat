@echo off

Echo [V3 - Prestart Checks]
:ExecutionPolicy
Echo [V3 - Checking Execution Policy]
Powershell Get-ExecutionPolicy >info.tmp
set /p ExecPol=<info.tmp
Echo %ExecPol%
IF "%ExecPol%"=="Restricted" Echo EXECUTION_POLICY : FAILED - ExecutionPolicy !!RESTRICTED, V3 will Enable && Pause && Echo V3 - Enabling Execution && Powershell Set-ExecutionPolicy -Scope CurrentUser Unrestricted && goto :ExecutionPolicy
IF "%ExecPol%"=="Unrestricted" Echo [EXECUTION_POLICY : PASSED - ExecutionPolicy UNRESTRICTED
Rem Powershell Set-ExecutionPolicy -Scope CurrentUser restricted
PowerShell .\V3_Main.ps1
Rem PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Unrestricted -File "".\V3_Main.ps1""' -Verb RunAs}" -NoNewWindow;
Rem PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Unrestricted -File ""V3_Main.ps1""' -Verb RunAs}";
Rem C:\Users\Legend68\Documents\WPS Cloud Files\409081444\$XUL_FILES\Keanu_V3
