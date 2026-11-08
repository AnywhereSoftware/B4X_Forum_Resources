@echo off
setlocal enabledelayedexpansion

:: ==========================================
:: CONFIGURATION (Update these paths)
:: ==========================================
set "B4J_PROJECT_DIR=C:\MyProject\B4J"
set "B4J_FILE=%B4J_PROJECT_DIR%\MyApp.b4j"
set "TEMPLATE_RC=%B4J_PROJECT_DIR%\Objects\version_template.rc"
set "GENERATED_RC=%B4J_PROJECT_DIR%\Objects\version.rc"
set "ICON_PATH=%B4J_PROJECT_DIR%\Files\app.ico"
set "MANIFEST_PATH=%B4J_PROJECT_DIR%\Objects\app.manifest"
set "INNO_SCRIPT=%B4J_PROJECT_DIR%\Objects\installer.iss"

:: Tool Paths
set "JAVA_EXE=C:\Java\jdk-19.0.2\bin\java.exe"
set "B4J_BUILDER=C:\Program Files\Anywhere Software\B4J\B4JBuilder.exe"
set "B4J_PACKAGER_JAR=C:\Program Files\Anywhere Software\B4J\B4JPackager11.jar"
set "RESHACKER=C:\Program Files (x86)\Resource Hacker\ResourceHacker.exe"
set "INNO_COMPILER=C:\Program Files (x86)\Inno Setup 6\ISCC.exe"

:: Derived Output Paths
set "PACKAGER_JSON=%B4J_PROJECT_DIR%\Objects\packager.json"
set "TARGET_EXE=%B4J_PROJECT_DIR%\Objects\temp\build\MyApp.exe"

:: ==========================================
:: STEP 0: Auto-Extract Variables from .b4j
:: ==========================================
echo [0/7] Extracting properties from B4J project...

:: Helper function to clean and parse the properties
for /f "tokens=2,3 delims==:" %%A in ('findstr /I "#PackagerProperty:" "%B4J_FILE%"') do (
    set "PROP_NAME=%%A"
    set "PROP_VAL=%%B"
    
    :: Remove leading/trailing spaces
    set "PROP_NAME=!PROP_NAME: =!"
    if "!PROP_VAL:~0,1!"==" " set "PROP_VAL=!PROP_VAL:~1!"
    if "!PROP_VAL:~-1!"==" " set "PROP_VAL=!PROP_VAL:~0,-1!"

    :: Store them into environment variables
    if /I "!PROP_NAME!"=="ExeName" set "EXE_NAME=!PROP_VAL!"
    if /I "!PROP_NAME!"=="AssemblyTitle" set "ASS_TITLE=!PROP_VAL!"
    if /I "!PROP_NAME!"=="AssemblyProduct" set "ASS_PRODUCT=!PROP_VAL!"
    if /I "!PROP_NAME!"=="AssemblyCompany" set "ASS_COMPANY=!PROP_VAL!"
    if /I "!PROP_NAME!"=="AssemblyVersion" set "B4J_VERSION=!PROP_VAL!"
    if /I "!PROP_NAME!"=="AssemblyDescription" set "ASS_DESC=!PROP_VAL!"
    if /I "!PROP_NAME!"=="AssemblyCopyrightAttribute" set "ASS_COPY=!PROP_VAL!"
)

if "%B4J_VERSION%"=="" (
    echo Error: Could not find AssemblyVersion properties inside %B4J_FILE%
    exit /b 1
)

echo Found AssemblyVersion: %B4J_VERSION%
echo Found ExeName:         %EXE_NAME%

:: Format Version commas and dots for Resource Hacker
for /f "tokens=1,2,3,4 delims=." %%a in ("%B4J_VERSION%") do (
    set "v1=%%a" & set "v2=%%b" & set "v3=%%c" & set "v4=%%d"
)
if "%v2%"=="" set "v2=0"
if "%v3%"=="" set "v3=0"
if "%v4%"=="" set "v4=0"

set "VERSION_DOTS=%v1%.%v2%.%v3%.%v4%"
set "VERSION_COMMAS=%v1%,%v2%,%v3%,%v4%"

:: Generate version.rc from template
if exist "%GENERATED_RC%" del "%GENERATED_RC%"
for /f "delims=" %%L in ('type "%TEMPLATE_RC%"') do (
    set "line=%%L"
    set "line=!line:[VERSION_COMMAS]=%VERSION_COMMAS%!"
    set "line=!line:[VERSION_DOTS]=%VERSION_DOTS%!"
    echo !line!>>"%GENERATED_RC%"
)

:: ==========================================
:: STEP 1: Compile B4J to App JAR
:: ==========================================
echo [1/7] Compiling B4J project to JAR...
"%B4J_BUILDER%" -task=Build -basefolder="%B4J_PROJECT_DIR%" -configuration=Default
if %errorlevel% neq 0 (echo B4J Build Failed! && exit /b %errorlevel%)

:: ==========================================
:: STEP 2: Dynamically Update packager.json
:: ==========================================
echo [2/7] Injecting B4J properties into packager.json...
if not exist "%PACKAGER_JSON%" (
    echo Error: packager.json not found! Build Standalone Package manually in the IDE once to generate it.
    exit /b 1
)

:: Use PowerShell to parse, map, and cleanly rewrite all JSON values
powershell -Command ^
    "$json = Get-Content '%PACKAGER_JSON%' -Raw | ConvertFrom-Json;" ^
    "$json.ExeName = '%EXE_NAME%';" ^
    "$json.AssemblyTitle = '%ASS_TITLE%';" ^
    "$json.AssemblyProduct = '%ASS_PRODUCT%';" ^
    "$json.AssemblyCompany = '%ASS_COMPANY%';" ^
    "$json.AssemblyVersion = '%VERSION_DOTS%';" ^
    "$json.AssemblyDescription = '%ASS_DESC%';" ^
    "$json.AssemblyCopyrightAttribute = '%ASS_COPY%';" ^
    "$json | ConvertTo-Json -Depth 10 | Set-Content '%PACKAGER_JSON%'"

if %errorlevel% neq 0 (echo JSON Properties Injection Failed! && exit /b %errorlevel%)

:: ==========================================
:: STEP 3: Build Standalone Package with B4JPackager11
:: ==========================================
echo [3/7] Running B4JPackager11 to create standalone build directory...
"%JAVA_EXE%" -jar "%B4J_PACKAGER_JAR%" "%PACKAGER_JSON%"
if %errorlevel% neq 0 (echo B4JPackager11 Failed! && exit /b %errorlevel%)

:: ==========================================
:: STEP 4: Resource Hacker - Icon
:: ==========================================
echo [4/7] Injecting Custom Icon into Standalone EXE...
"%RESHACKER%" -open "%TARGET_EXE%" -save "%TARGET_EXE%" -action addoverwrite -res "%ICON_PATH%" -mask ICONGROUP,MAINICON,
if %errorlevel% neq 0 (echo Icon Injection Failed! && exit /b %errorlevel%)

:: ==========================================
:: STEP 5: Resource Hacker - Manifest
:: ==========================================
echo [5/7] Injecting Custom Manifest...
"%RESHACKER%" -open "%TARGET_EXE%" -save "%TARGET_EXE%" -action addoverwrite -res "%MANIFEST_PATH%" -mask MANIFEST,1,0
if %errorlevel% neq 0 (echo Manifest Injection Failed! && exit /b %errorlevel%)

:: ==========================================
:: STEP 6: Resource Hacker - Version Info
:: ==========================================
echo [6/7] Injecting Synced Version Info...
"%RESHACKER%" -open "%GENERATED_RC%" -save "%B4J_PROJECT_DIR%\version.res" -action compile
if %errorlevel% neq 0 (echo RC Compilation Failed! && exit /b %errorlevel%)

"%RESHACKER%" -open "%TARGET_EXE%" -save "%TARGET_EXE%" -action addoverwrite -res "%B4J_PROJECT_DIR%\version.res" -mask VERSIONINFO,1,
if %errorlevel% neq 0 (echo Version Info Injection Failed! && exit /b %errorlevel%)

del "%B4J_PROJECT_DIR%\version.res"
del "%GENERATED_RC%"

:: ==========================================
:: STEP 7: Compile Inno Setup Installer
:: ==========================================
echo [7/7] Compiling Inno Setup Installer...
"%INNO_COMPILER%" /DAppVersion="%VERSION_DOTS%" "%INNO_SCRIPT%"
if %errorlevel% neq 0 (echo Inno Setup Compilation Failed! && exit /b %errorlevel%)

echo ==========================================
echo Pipeline finished successfully! App Version: %VERSION_DOTS%
echo ==========================================