@echo off
set "color_defaulta=a"
echo %color_defaulta% > %TEMP%/BatchGame/color.txt
setlocal enabledelayedexpansion
set "GETCOLORMETHOD=%TEMP%/BatchGame/color.txt"
for /f "usebackq delims=" %%a in ("%GETNICKNAMEMETHODDIR%") do (
    set "color_setdefaultusable=%%a"
)
color %color_setdefaultusable%
title %NICKNAME_USABLE%'s RPG (Playing on %username%)
echo %username% played at %time% and %date% as %NICKNAME_USABLE%
echo %username% played at %time% and %date% as %NICKNAME_USABLE%>> %TEMP%/BatchGame/logs.txt

cls

if exist "%TEMP%/BatchGame" (
    echo Welcome !
    goto welcome
) else (
    echo Welcome ! (First launch)
    set FIRSTLAUNCH=0
    set ISMENUREDIRECT=YES
    set GAMEVER=1.0
    set GAMEBUILD=1.2
    set COPYRIGHT=NOCOPYRIGHT
    set GAMEFOLD=BatchGame
    set GAMEDIR=%TEMP%/%GAMEFOLD%
    set GAMEDIRMD=%TEMP%\%GAMEFOLD%
    md %GAMEDIRMD%
    echo ONE = 0x78245 = Game is corrupt, level was not succefully loaded, please re-download the game. > %GAMEDIR%/errors.gamesettings
    echo TWO = 0x35126 = Game encountered an error while writing to disk, the disk is corrupted or write - protected (can often happen if you ran the game on an protected SD CARD !) >> %GAMEDIR%/errors.gamesettings
    echo THREE = 0x62548 = SYSTEM cannot access Game, please restart you computer or disable AntiVirus Protection >> %GAMEDIR%/errors.gamesettings
    echo FOUR = 0x23684 = GAME CORRUPTED ! DOWNLOAD THE GAME AGAIN THEN RETRY, IF THIS ERROR OFTEN OCCURS, CONTACT PANDO >> %GAMEDIR%/errors.gamesettings
    echo FIVE = 0x00255 = Game cannot access CMD, please reintall windows or make sure CMD isn't protected by any AntiVirus >> %GAMEDIR%/errors.gamesettings
    echo SIX = 0x00000 = SYSTEM Violation, Game has been modified and a line of code is missing ! >> %GAMEDIR%/errors.gamesettings
    echo SEVEN = 0x45714 = Stats are already created, value is UNDEFINED, failed to operate >> %GAMEDIR%/errors.gamesettings
    echo FIRSTLAUNCH= %FIRSTLAUNCH% >> %GAMEDIR%/settings.inf
    echo GAMEVERSION = %GAMEVER% > %GAMEDIR%/settings.inf
    echo GAMEBUILDENGINE = %GAMEBUILD% >> %GAMEDIR%/settings.inf
    echo ISCOPYRIGHTED? = %COPYRIGHT% >> %GAMEDIR%/settings.inf
    echo GAMEFOLDERNAME = %GAMEFOLD% >> %GAMEDIR%/settings.inf
    echo GAMEDIRECTORY= %GAMEDIR% >> %GAMEDIR%/settings.inf
    copy main.bat %TEMP%/BatchGame/
    rename %TEMP%/BatchGame/main.bat GAMECOPY.bat.gamesettings
    echo del logs.txt > %GAMEDIR%/dll.bat
    echo exit >> %GAMEDIR%/dll.bat
    goto stats_create
)

:username_choose
cls
echo.
set /p nickname="How would you like to be called ? :  "
set NAME_NICKNAME=%nickname%
title Processing with the request : Modified nickname == "%NAME_NICKNAME%"
echo %NAME_NICKNAME%> %TEMP%/BatchGame/nickname.txt
echo %username% modified the componement NICKNAME with the following value : %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt
goto welcome

:welcome
cls
set "GETNICKNAMEMETHODDIR=%TEMP%/BatchGame/nickname.txt"
for /f "usebackq delims=" %%a in ("%GETNICKNAMEMETHODDIR%") do (
    set "NICKNAME_USABLE=%%a"
)
echo %username% made the following request : MENU as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt
title %NICKNAME_USABLE%'s RPG (Playing on %username%)
echo.
echo ========================
echo.
echo      %NICKNAME_USABLE%'s RPG
echo.
echo ========================
echo.
echo.
echo [1] Load Game
echo [2] Create New Game
echo [3] Settings 
echo [4] How to play ?
echo [5] Exit
echo.
choice /n /m "Enter your choice here : " /c 12345
if %errorlevel% equ 1 echo %username% made the following request : %errorlevel% (Load Game) as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt & goto load_game
if %errorlevel% equ 2 echo %username% made the following request : %errorlevel% (Create New Game) as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt & goto create_game
if %errorlevel% equ 3 echo %username% made the following request : %errorlevel% (Settings) as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt & goto settings
if %errorlevel% equ 4 echo %username% made the following request : %errorlevel% (How to play ?) as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt & goto howto_play
if %errorlevel% equ 5 echo %username% made the following request : %errorlevel% (Exit) as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt & goto exit_cmd

:stats_create
echo %username% made the following request : STATS_CREATE as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt
echo The following request : STATS_CREATE failed as %NAME_NICKNAME% at %time% and %date%, Reason : SEVEN in %GAMEDIR%/errors.gamesettings (line 7), the game cannot handle request, game will continue running>> %TEMP%/BatchGame/logs.txt
set "MONEYVAR=UND"
set "LEVELVAR=UND"
set "PLAYEDTIME=0Hours0Minutes0Seconds0Miliseconds"
echo %MONEYVAR%>%GAMEDIR%/stats.txt
echo %LEVELVAR%>>%GAMEDIR%/stats.txt
echo %PLAYEDTIME%>>%GAMEDIR%/stats.txt
echo values have been succefully created, processing in your request.
goto username_choose

:color_choose
cls
echo.
echo Return Back [9]
echo.
echo ==================================
echo.
echo          Choose your color
echo.
echo ==================================
echo.
echo.
echo [1] Normal
echo [2] Red
echo [3] Blue
echo [4] Lime ( Hacker like :-) )
echo [5] Aqua
echo [6] Green
choice /n /m "Enter your choice here : " /c 123456789
if %errorlevel% equ 1 echo %username% made the following request in the menu : Change Color : %errorlevel% (Normal) as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt & color & set "color_defaulta=a" & echo Color has been changed & pause & echo %color_defaulta% > %TEMP%/BatchGame/color.txt & goto settings
if %errorlevel% equ 2 echo %username% made the following request in the menu : Change Color : %errorlevel% (Red) as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt & color 4 & set "color_defaulta=4" & echo Color has been changed & pause  & echo %color_defaulta% > %TEMP%/BatchGame/color.txt & goto settings
if %errorlevel% equ 3 echo %username% made the following request in the menu : Change Color : %errorlevel% (Blue) as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt & color 1 & set "color_defaulta=1" & echo Color has been changed & pause & echo %color_defaulta% > %TEMP%/BatchGame/color.txt & goto settings
if %errorlevel% equ 4 echo %username% made the following request in the menu : Change Color : %errorlevel% (Lime ( Hacker like :-) )) as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt & color a & set "color_defaulta=a" & echo Color has been changed & pause & echo %color_defaulta% > %TEMP%/BatchGame/color.txt & goto settings
if %errorlevel% equ 5 echo %username% made the following request in the menu : Change Color : %errorlevel% (Aqua) as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt & color 9 & set "color_defaulta=9" & echo Color has been changed & pause & echo %color_defaulta% > %TEMP%/BatchGame/color.txt & goto settings 
if %errorlevel% equ 7 goto color_choose
if %errorlevel% equ 8 goto color_choose
if %errorlevel% equ 6 echo %username% made the following request in the menu : Change Color : %errorlevel% (Green) as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt & color 2 & set "color_defaulta=2" & echo Color has been changed & pause & echo %color_defaulta% > %TEMP%/BatchGame/color.txt & goto settings 
if %errorlevel% equ 9 echo %username% made the following request in the menu : Change Color : %errorlevel% (Return Back) as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt & goto settings


:command_prompt_ig_temp
echo.
echo.
echo Type "goto settings" to return to the settings
set /p comand_type_ig_temp="Enter your command:  "
%comand_type_ig_temp%
goto command_prompt_ig_temp

:exit_cmd
cls
echo. 
echo You choosed exit, are you sure ? --1, YES /\ 2, NO--
choice /c 12
if %errorlevel% equ 1 goto exit_choice_asked_yes
if %errorlevel% equ 2 goto welcome
pause

:settings
cls
echo.
echo Return Back [9]
echo.
echo ========================
echo.
echo      %NICKNAME_USABLE%'s RPG
echo.
echo ========================
echo.
echo.
echo [1] Change NickName
echo [2] Change Color theme
echo [3] Open Game Directory
echo [4] Pando's discord
echo [5] Reset stats
echo [6] Clear Logs
echo TEMP (command prompt ig) [7]
choice /n /m "Enter your choice here : " /c 123456789
if %errorlevel% equ 1 echo %username% made the following request in the menu : settings : %errorlevel% (Change NickName) as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt & goto username_choose
if %errorlevel% equ 2 echo %username% made the following request in the menu : settings : %errorlevel% (Change Color theme) as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt & goto color_choose
if %errorlevel% equ 3 echo %username% made the following request in the menu : settings : %errorlevel% (Open Game irectory) as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt & start %TEMP%/%GAMEFOLD%/ & goto settings
if %errorlevel% equ 4 echo %username% made the following request in the menu : settings : %errorlevel% (Pando's discord) as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt & echo pando7243 or https://discord.gg/WM6bWhMq6u & pause > %TEMP%/%random%.gamesettings & goto settings
if %errorlevel% equ 5 echo %username% made the following request in the menu : settings : %errorlevel% (Reset stats) as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt & goto reset_ask
if %errorlevel% equ 8 goto settings
if %errorlevel% equ 9 echo %username% made the following request in the menu : settings : %errorlevel% (Return Back) as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt & goto welcome
if %errorlevel% equ 6 echo %username% made the following request in the menu : settings : %errorlevel% (Clear Logs) as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt & start %TEMP%/BatchGame/dll.bat & echo Logs has been cleared ! & pause & goto settings
if %errorlevel% equ 7 echo %username% made the following request in the menu : settings : %errorlevel% (Command Prompt IG) as %NAME_NICKNAME% at %time% and %date%>> %TEMP%/BatchGame/logs.txt & goto command_prompt_ig_temp


:exit_choice_asked_yes
cls
echo %username% made the following request : %NOREQUEST% (Exit) as %NAME_NICKNAME% at %time% and %date% : Game will close>> %TEMP%/BatchGame/logs.txt
exit
