@ECHO off
:: I reccommend using minimal adb

@SET ADB_LOC=%LOCALAPPDATA%\Microsoft\WindowsApps\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\
:: trailing backslash required, I've stored my adb.exe in this location/directory, this is WSA WindowsApp's location
@SET PORT=127.0.0.1:58526
:: generally same across WSA's

ECHO %%"[TIP:]    If you see error connecting to PORT, then click WSA->Developer_mode(Should be on)->Manage_developer_setting"
ECHO %%           sometimes eventhough developer mode is enabled, but ports are not connected, so this wakes it up
ECHO %%"[TIP:]    If you see error device offline, then in Manage_developer_setting->USB_debugging(on)"
ECHO %%"[#Usage:] Create this file's shortcut, cut it, Open Run (Windows + R), Type \'shell:sendto\', Hit enter, paste that Shortcut Here"
ECHO %%"[TIP:]    You can (rename/change icon of) the shortcut however you want"
ECHO %%"[#Usage:] Now select files you want to send, Right click, Send to -> <Shortcut name>, Easy peasy"
ECHO ===============

if not exist "%ADB_LOC%adb.exe" (
	ECHO "cannot find ADB in | %ADB_LOC% | please check if it exists"
	TIMEOUT 5
	EXIT /B
)

pushd %ADB_LOC%

	adb connect %PORT%

::Calculate number of parameters
	@SET num_of_params=0
	@SET MAX_ALLOWED=26

	for %%I IN (%*) DO set /A "num_of_params+=1"
	ECHO Num of files passed = %num_of_params%, Max allowed = %MAX_ALLOWED%

	if %num_of_params% GTR %MAX_ALLOWED% (
		ECHO Maximum of 26 files are allowed, Please reduce the nuber of selections
		TIMEOUT 5
		EXIT /B
	)

	for %%I IN (%*) DO (
		adb -s %PORT% push %%I ./storage/emulated/0/Download
	)

POPD
TIMEOUT 5

::By Harshal Kudale, Modified by Ishansh Lal
::https://github.com/HarshalKudale/EasySideload-WSA
::https://github.com/ishanshLal-tRED/Everyday-powershell