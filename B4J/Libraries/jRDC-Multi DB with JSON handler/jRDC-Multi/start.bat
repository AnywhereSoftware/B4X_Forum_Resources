@rem Este script mata el proceso del servidor y despues lo reinicia, necesita los archivos stop.bat y start2.bat

start cmd.exe /c stop.bat
timeout 2

start cmd.exe /c start2.bat %1

exit