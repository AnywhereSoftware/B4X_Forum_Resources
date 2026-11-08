@echo off
net user "%username%" | find /i "*Administrators" >nul 2>&1
if %errorlevel% equ 0 (echo Current user is admin) else (echo Current user is not admin)