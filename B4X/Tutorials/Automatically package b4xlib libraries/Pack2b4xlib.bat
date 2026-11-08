
@echo off
chcp 65001 >nul
cd /d "%~dp0"

if "%~1"=="" (
    echo Error: Missing output directory parameter!
    goto end
)
if "%~2"=="" (
    echo Error: Missing output filename parameter!
    goto end
)

set "output_dir=%~1"
set "output_file=%~2"
set "temp_zip=%output_dir%\%output_file%.zip"

if not exist "%output_dir%" mkdir "%output_dir%"

echo Generating ZIP file...
powershell -Command "$files = @(); @(Get-ChildItem -Filter *.bas | Where-Object { $_.Name -ne 'B4XMainPage.bas' }) | ForEach-Object { echo ('Adding file: ' + $_.Name); $files += $_ }; if (Test-Path 'manifest.txt') { echo ('Adding file: manifest.txt'); $files += 'manifest.txt' }; if (-not $files) { Write-Error 'No files to pack!'; exit 1 }; Compress-Archive -Path $files -DestinationPath '%temp_zip%' -Force"

if exist "%temp_zip%" (
    echo Zip Generated: %output_file%.zip
) else (
    echo Error: Packing failed, no ZIP file generated!
    goto end
)

set "final_output=%output_dir%\%output_file%"
move /Y "%temp_zip%" "%final_output%" >nul

if exist "%final_output%" (
    echo b4xlib Packed: %output_file%
) else (
    echo Error: Renaming failed!
)

:end
::pause