@echo off

set update_date=[08 June 2019]
set rdpwrap_ini="%~dp0rdpwrap.ini"
set RDPWInst_exe="%~dp0RDPWInst.exe"

echo ______________________________________________________________
echo.
echo %update_date%
echo.
echo RDP Wrapper Library Updater
echo ---------------------------
echo ^<Add support of new termsrv.dll versions in rdpwrap.ini^>
echo.
echo.
REM check if admin
fsutil dirty query %systemdrive% >nul
if not %errorlevel% == 0 goto :not_admin
REM check file exist
if not exist %rdpwrap_ini% goto :error_ini
if not exist %RDPWInst_exe% goto :error_exe
goto :start_update
:not_admin
echo [-] This script must be run as administrator to work properly!
echo     ^<Please use 'right click' on this batch file and select "Run As Administrator"^>
echo.
goto :anykey
:error_ini
echo [-] rdpwrap.ini not found.
goto :error
:error_exe
echo [-] RDPWInst.exe not found.
goto :error
:error
echo Please install the RDP Wrapper first, then run rdpwrap_ini_updater
echo.
goto :anykey

REM ---------------------------------------------------------------
REM      SEARCH - termsrv.dll version entries in rdpwrap_ini
REM ---------------------------------------------------------------

:start_update
findstr /x /c:"[10.0.17134.706]" %rdpwrap_ini% >nul || call :Update_10_0_17134_706
findstr /x /c:"[10.0.17763.165]" %rdpwrap_ini% >nul || call :Update_10_0_17763_165
findstr /x /c:"[10.0.17763.292]" %rdpwrap_ini% >nul || call :Update_10_0_17763_292
findstr /x /c:"[10.0.17763.379]" %rdpwrap_ini% >nul || call :Update_10_0_17763_379
findstr /x /c:"[10.0.17763.437]" %rdpwrap_ini% >nul || call :Update_10_0_17763_437
findstr /x /c:"[10.0.18362.1]" %rdpwrap_ini% >nul || call :Update_10_0_18362_1
findstr /x /c:"[10.0.18362.53]" %rdpwrap_ini% >nul || call :Update_10_0_18362_53


if "%updated%"=="1" goto :restart_rdpwrap else goto :no_update
:no_update
echo ... rdpwrap.ini is up to date!
echo.
goto :anykey
:restart_rdpwrap
echo.
echo [~] restart the RDP Wrapper to accept the new ini updates ... 
echo.
%RDPWInst_exe% -r
echo.
REM
REM 'RDPWInst.exe -r' and the error '[-] StartService error (code 1056)'
REM   -> ERROR_SERVICE_ALREADY_RUNNING = 1056 (0x420)
REM      An instance of the service is already running.
REM   -> This is not an error, you can ignore it
REM
goto :anykey
:anykey
pause
exit


REM ---------------------------------------------------------------
REM      UPDATES - RDP Wrapper Library configuration
REM ---------------------------------------------------------------


:Update_10_0_17134_706
set updated=1
echo [+] add support for termsrv.dll v.10.0.17134.706
(
echo.
echo [10.0.17134.706]
echo LocalOnlyPatch.x86=1
echo LocalOnlyOffset.x86=ADAB8
echo LocalOnlyCode.x86=jmpshort
echo LocalOnlyPatch.x64=1
echo LocalOnlyOffset.x64=92521
echo LocalOnlyCode.x64=jmpshort
echo SingleUserPatch.x86=1
echo SingleUserOffset.x86=36B1C
echo SingleUserCode.x86=nop
echo SingleUserPatch.x64=1
echo SingleUserOffset.x64=1511C
echo SingleUserCode.x64=Zero
echo DefPolicyPatch.x86=1
echo DefPolicyOffset.x86=33579
echo DefPolicyCode.x86=CDefPolicy_Query_eax_ecx
echo DefPolicyPatch.x64=1
echo DefPolicyOffset.x64=10E78
echo DefPolicyCode.x64=CDefPolicy_Query_edi_rcx
echo SLInitHook.x86=1
echo SLInitOffset.x86=475DD
echo SLInitFunc.x86=New_CSLQuery_Initialize
echo SLInitHook.x64=1
echo SLInitOffset.x64=22F5C
echo SLInitFunc.x64=New_CSLQuery_Initialize
echo.
echo [10.0.17134.706-SLInit]
echo bInitialized.x86      =CBF38
echo bServerSku.x86        =CBF3C
echo lMaxUserSessions.x86  =CBF40
echo bAppServerAllowed.x86 =CBF44
echo bRemoteConnAllowed.x86=CBF48
echo bMultimonAllowed.x86  =CBF4C
echo ulMaxDebugSessions.x86=CBF50
echo bFUSEnabled.x86       =CBF54
echo bServerSku.x64        =F1378
echo lMaxUserSessions.x64  =F137C
echo bAppServerAllowed.x64 =F1380
echo bInitialized.x64      =F2430
echo bRemoteConnAllowed.x64=F2434
echo bMultimonAllowed.x64  =F2438
echo ulMaxDebugSessions.x64=F243C
echo bFUSEnabled.x64       =F2440
) >> %rdpwrap_ini%
goto :eof


:Update_10_0_17763_165
set updated=1
echo [+] add support for termsrv.dll v.10.0.17763.165 x64
(
echo.
echo [10.0.17763.165]
echo LocalOnlyPatch.x64=1
echo LocalOnlyOffset.x64=77941
echo LocalOnlyCode.x64=jmpshort
echo SingleUserPatch.x64=1
echo SingleUserOffset.x64=1322C
echo SingleUserCode.x64=Zero
echo DefPolicyPatch.x64=1
echo DefPolicyOffset.x64=17F45
echo DefPolicyCode.x64=CDefPolicy_Query_eax_rcx
echo SLInitHook.x64=1
echo SLInitOffset.x64=1ABFC
echo SLInitFunc.x64=New_CSLQuery_Initialize
echo.
echo [10.0.17763.165-SLInit]
echo bInitialized.x64      =ECAB0
echo bServerSku.x64        =ECAB4
echo lMaxUserSessions.x64  =ECAB8
echo bAppServerAllowed.x64 =ECAC0
echo bRemoteConnAllowed.x64=ECAC4
echo bMultimonAllowed.x64  =ECAC8
echo ulMaxDebugSessions.x64=ECACC
echo bFUSEnabled.x64       =ECAD0
) >> %rdpwrap_ini%
goto :eof


:Update_10_0_17763_292
set updated=1
echo [+] add support for termsrv.dll v.10.0.17763.292
(
echo.
echo [10.0.17763.292]
echo LocalOnlyPatch.x86=1
echo LocalOnlyOffset.x86=AFAD4
echo LocalOnlyCode.x86=jmpshort
echo LocalOnlyPatch.x64=1
echo LocalOnlyOffset.x64=77A11
echo LocalOnlyCode.x64=jmpshort
echo SingleUserPatch.x86=1
echo SingleUserOffset.x86=4D665
echo SingleUserCode.x86=nop
echo SingleUserPatch.x64=1
echo SingleUserOffset.x64=1322C
echo SingleUserCode.x64=Zero
echo DefPolicyPatch.x86=1
echo DefPolicyOffset.x86=4BE69
echo DefPolicyCode.x86=CDefPolicy_Query_eax_ecx
echo DefPolicyPatch.x64=1
echo DefPolicyOffset.x64=17F45
echo DefPolicyCode.x64=CDefPolicy_Query_eax_rcx
echo SLInitHook.x86=1
echo SLInitOffset.x86=5B18A
echo SLInitFunc.x86=New_CSLQuery_Initialize
echo SLInitHook.x64=1
echo SLInitOffset.x64=1ABFC
echo SLInitFunc.x64=New_CSLQuery_Initialize
echo.
echo [10.0.17763.292-SLInit]
echo bInitialized.x86      =CD798
echo bServerSku.x86        =CD79C
echo lMaxUserSessions.x86  =CD7A0
echo bAppServerAllowed.x86 =CD7A8
echo bRemoteConnAllowed.x86=CD7AC
echo bMultimonAllowed.x86  =CD7B0
echo ulMaxDebugSessions.x86=CD7B4
echo bFUSEnabled.x86       =CD7B8
echo bInitialized.x64      =ECAB0
echo bServerSku.x64        =ECAB4
echo lMaxUserSessions.x64  =ECAB8
echo bAppServerAllowed.x64 =ECAC0
echo bRemoteConnAllowed.x64=ECAC4
echo bMultimonAllowed.x64  =ECAC8
echo ulMaxDebugSessions.x64=ECACC
echo bFUSEnabled.x64       =ECAD0
) >> %rdpwrap_ini%
goto :eof


:Update_10_0_17763_379
set updated=1
echo [+] add support for termsrv.dll v.10.0.17763.379
(
echo.
echo [10.0.17763.379]
echo LocalOnlyPatch.x86=1
echo LocalOnlyOffset.x86=AFAD4
echo LocalOnlyCode.x86=jmpshort
echo LocalOnlyPatch.x64=1
echo LocalOnlyOffset.x64=77A11
echo LocalOnlyCode.x64=jmpshort
echo SingleUserPatch.x86=1
echo SingleUserOffset.x86=4D665
echo SingleUserCode.x86=nop
echo SingleUserPatch.x64=1
echo SingleUserOffset.x64=1322C
echo SingleUserCode.x64=Zero
echo DefPolicyPatch.x86=1
echo DefPolicyOffset.x86=4BE69
echo DefPolicyCode.x86=CDefPolicy_Query_eax_ecx
echo DefPolicyPatch.x64=1
echo DefPolicyOffset.x64=17F45
echo DefPolicyCode.x64=CDefPolicy_Query_eax_rcx
echo SLInitHook.x86=1
echo SLInitOffset.x86=5B18A
echo SLInitFunc.x86=New_CSLQuery_Initialize
echo SLInitHook.x64=1
echo SLInitOffset.x64=1ABFC
echo SLInitFunc.x64=New_CSLQuery_Initialize
echo.
echo [10.0.17763.379-SLInit]
echo bInitialized.x86      =CD798
echo bServerSku.x86        =CD79C
echo lMaxUserSessions.x86  =CD7A0
echo bAppServerAllowed.x86 =CD7A8
echo bRemoteConnAllowed.x86=CD7AC
echo bMultimonAllowed.x86  =CD7B0
echo ulMaxDebugSessions.x86=CD7B4
echo bFUSEnabled.x86       =CD7B8
echo bInitialized.x64      =ECAB0
echo bServerSku.x64        =ECAB4
echo lMaxUserSessions.x64  =ECAB8
echo bAppServerAllowed.x64 =ECAC0
echo bRemoteConnAllowed.x64=ECAC4
echo bMultimonAllowed.x64  =ECAC8
echo ulMaxDebugSessions.x64=ECACC
echo bFUSEnabled.x64       =ECAD0
) >> %rdpwrap_ini%
goto :eof


:Update_10_0_17763_437
set updated=1
echo [+] add support for termsrv.dll v.10.0.17763.437
(
echo.
echo [10.0.17763.437]
echo LocalOnlyPatch.x86=1
echo LocalOnlyOffset.x86=AFE24
echo LocalOnlyCode.x86=jmpshort
echo LocalOnlyPatch.x64=1
echo LocalOnlyOffset.x64=77A41
echo LocalOnlyCode.x64=jmpshort
echo SingleUserPatch.x86=1
echo SingleUserOffset.x86=4D7B5
echo SingleUserCode.x86=nop
echo SingleUserPatch.x64=1
echo SingleUserOffset.x64=1339C
echo SingleUserCode.x64=Zero
echo DefPolicyPatch.x86=1
echo DefPolicyOffset.x86=4BFB9
echo DefPolicyCode.x86=CDefPolicy_Query_eax_ecx
echo DefPolicyPatch.x64=1
echo DefPolicyOffset.x64=18025
echo DefPolicyCode.x64=CDefPolicy_Query_eax_rcx
echo SLInitHook.x86=1
echo SLInitOffset.x86=5B2CA
echo SLInitFunc.x86=New_CSLQuery_Initialize
echo SLInitHook.x64=1
echo SLInitOffset.x64=1ACDC
echo SLInitFunc.x64=New_CSLQuery_Initialize
echo.
echo [10.0.17763.437-SLInit]
echo bInitialized.x86      =CD798
echo bServerSku.x86        =CD79C
echo lMaxUserSessions.x86  =CD7A0
echo bAppServerAllowed.x86 =CD7A8
echo bRemoteConnAllowed.x86=CD7AC
echo bMultimonAllowed.x86  =CD7B0
echo ulMaxDebugSessions.x86=CD7B4
echo bFUSEnabled.x86       =CD7B8
echo bInitialized.x64      =ECAB0
echo bServerSku.x64        =ECAB4
echo lMaxUserSessions.x64  =ECAB8
echo bAppServerAllowed.x64 =ECAC0
echo bRemoteConnAllowed.x64=ECAC4
echo bMultimonAllowed.x64  =ECAC8
echo ulMaxDebugSessions.x64=ECACC
echo bFUSEnabled.x64       =ECAD0
) >> %rdpwrap_ini%
goto :eof


:Update_10_0_18362_1
set updated=1
echo [+] add support for termsrv.dll v.10.0.18362.1
(
echo.
echo [10.0.18362.1]
echo LocalOnlyPatch.x86=1
echo LocalOnlyOffset.x86=B7A16
echo LocalOnlyCode.x86=jmpshort
echo LocalOnlyPatch.x64=1
echo LocalOnlyOffset.x64=82F35
echo LocalOnlyCode.x64=jmpshort
echo SingleUserPatch.x86=1
echo SingleUserOffset.x86=50515
echo SingleUserCode.x86=nop
echo SingleUserPatch.x64=1
echo SingleUserOffset.x64=0DBFC
echo SingleUserCode.x64=Zero
echo DefPolicyPatch.x86=1
echo DefPolicyOffset.x86=50249
echo DefPolicyCode.x86=CDefPolicy_Query_eax_ecx
echo DefPolicyPatch.x64=1
echo DefPolicyOffset.x64=1FE05
echo DefPolicyCode.x64=CDefPolicy_Query_eax_rcx
echo SLInitHook.x86=1
echo SLInitOffset.x86=5A75A
echo SLInitFunc.x86=New_CSLQuery_Initialize
echo SLInitHook.x64=1
echo SLInitOffset.x64=22DCC
echo SLInitFunc.x64=New_CSLQuery_Initialize
echo.
echo [10.0.18362.1-SLInit]
echo bInitialized.x86      =D477C
echo bServerSku.x86        =D4780
echo lMaxUserSessions.x86  =D4784
echo bAppServerAllowed.x86 =D478C
echo bRemoteConnAllowed.x86=D4790
echo bMultimonAllowed.x86  =D4794
echo ulMaxDebugSessions.x86=D4798
echo bFUSEnabled.x86       =D479C
echo bInitialized.x64      =F6A8C
echo bServerSku.x64        =F6A90
echo lMaxUserSessions.x64  =F6A94
echo bAppServerAllowed.x64 =F6A9C
echo bRemoteConnAllowed.x64=F6AA0
echo bMultimonAllowed.x64  =F6AA4
echo ulMaxDebugSessions.x64=F6AA8
echo bFUSEnabled.x64       =F6AAC
) >> %rdpwrap_ini%
goto :eof


:Update_10_0_18362_53
set updated=1
echo [+] add support for termsrv.dll v.10.0.18362.53
(
echo.
echo [10.0.18362.53]
echo LocalOnlyPatch.x86=1
echo LocalOnlyOffset.x86=B7D06
echo LocalOnlyCode.x86=jmpshort
echo LocalOnlyPatch.x64=1
echo LocalOnlyOffset.x64=82FB5
echo LocalOnlyCode.x64=jmpshort
echo SingleUserPatch.x86=1
echo SingleUserOffset.x86=50535
echo SingleUserCode.x86=nop
echo SingleUserPatch.x64=1
echo SingleUserOffset.x64=0DBFC
echo SingleUserCode.x64=Zero
echo DefPolicyPatch.x86=1
echo DefPolicyOffset.x86=50269
echo DefPolicyCode.x86=CDefPolicy_Query_eax_ecx
echo DefPolicyPatch.x64=1
echo DefPolicyOffset.x64=1FE15
echo DefPolicyCode.x64=CDefPolicy_Query_eax_rcx
echo SLInitHook.x86=1
echo SLInitOffset.x86=5A77A
echo SLInitFunc.x86=New_CSLQuery_Initialize
echo SLInitHook.x64=1
echo SLInitOffset.x64=22DDC
echo SLInitFunc.x64=New_CSLQuery_Initialize
echo.
echo [10.0.18362.53-SLInit]
echo bInitialized.x86      =D577C
echo bServerSku.x86        =D5780
echo lMaxUserSessions.x86  =D5784
echo bAppServerAllowed.x86 =D578C
echo bRemoteConnAllowed.x86=D5790
echo bMultimonAllowed.x86  =D5794
echo ulMaxDebugSessions.x86=D5798
echo bFUSEnabled.x86       =D579C
echo bInitialized.x64      =F6A8C
echo bServerSku.x64        =F6A90
echo lMaxUserSessions.x64  =F6A94
echo bAppServerAllowed.x64 =F6A9C
echo bRemoteConnAllowed.x64=F6AA0
echo bMultimonAllowed.x64  =F6AA4
echo ulMaxDebugSessions.x64=F6AA8
echo bFUSEnabled.x64       =F6AAC
) >> %rdpwrap_ini%
goto :eof



