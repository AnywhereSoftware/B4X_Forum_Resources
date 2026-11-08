@ECHO OFF
:start ECHO Copyright (C) 2025 SecutekMedia Free Software

IF "%1"==""  GOTO errors
IF "%1"=="0" GOTO cnverting_copy
IF "%1"=="1" GOTO cnverting_low
IF "%1"=="2" GOTO cnverting_low2
IF "%1"=="3" GOTO cnverting_med
IF "%1"=="4" GOTO cnverting_high
IF "%1"=="5" GOTO cnverting_max

:cnverting_copy

C:\Windows\System32\cmd.exe /c start /low /B /affinity 3 D:\ffmpeg\bin\ffmpeg.exe -i %2 -c:v copy -c:a copy -nostats -nostdin -threads 6 %3
GOTO end_completed

:cnverting_low

C:\Windows\System32\cmd.exe /c start /low /B /affinity 3 D:\ffmpeg\bin\ffmpeg.exe -i %2 -s 640x360 -c:v libx264 -b:v 560k -r 24 -x264opts keyint=48:min-keyint=48:no-scenecut -profile:v main -preset medium -movflags +faststart -nostats -nostdin -threads 6 %3
GOTO end_completed

:cnverting_low2

C:\Windows\System32\cmd.exe /c start /low /B /affinity 3 D:\ffmpeg\bin\ffmpeg.exe -i %2 -s 640x360 -c:v libx265 -b:v 334k -r 24 -x265-params "keyint=48:min-keyint=48:no-open-gop=1:no-scenecut=1" -preset medium -movflags +faststart -nostats -nostdin -threads 6 %3
GOTO end_completed

:cnverting_med
 
C:\Windows\System32\cmd.exe /c start /low /B /affinity 3 D:\ffmpeg\bin\ffmpeg.exe -i %2 -s 960x540 -c:v libx264 -b:v 1260k -r 24 -x264opts keyint=48:min-keyint=48:no-scenecut -profile:v main -preset medium -movflags +faststart -nostats -nostdin -threads 6 %3
GOTO end_completed

:cnverting_high

C:\Windows\System32\cmd.exe /c start /low /B /affinity 3 D:\ffmpeg\bin\ffmpeg.exe -i %2 -s 1280x720 -c:v libx264 -b:v 2224k -r 24 -x264opts keyint=48:min-keyint=48:no-scenecut -profile:v main -preset medium -movflags +faststart -nostats -nostdin -threads 6 %3
GOTO end_completed

:cnverting_max

C:\Windows\System32\cmd.exe /c start /low /B /affinity 3 D:\ffmpeg\bin\ffmpeg.exe -i %2 -s 1920x1080 -c:v libx264 -b:v 5050k -r 24 -x264opts keyint=48:min-keyint=48:no-scenecut -profile:v main -preset medium -movflags +faststart -nostats -nostdin -threads 6 %3
GOTO end_completed

:errors 
CLS
ECHO ----------------------------------------------------
ECHO Script Usage: Script_converting.cmd with parameters.
ECHO ----------------------------------------------------
GOTO end

:end_completed 
ECHO The Windows command script has completed.

:end


