@ECHO OFF
:start ECHO Copyright (C) 2025 Free Software

IF "%1"==""  GOTO errors
IF "%1"=="0" GOTO cnverting_copy
IF "%1"=="1" GOTO cnverting_low
IF "%1"=="2" GOTO cnverting_low2
IF "%1"=="3" GOTO cnverting_med
IF "%1"=="4" GOTO cnverting_high
IF "%1"=="5" GOTO cnverting_max

:cnverting_copy
IF NOT EXIST 0000.media GOTO GO_1N10

D:\Application\ffmpeg\bin\ffmpeg.exe -i 0000.media -c:v copy -c:a copy 0000-copy.mp4

:GO_1N10
IF NOT EXIST 0010.media GOTO GO_1N20

D:\Application\ffmpeg\bin\ffmpeg.exe -i 0010.media -c:v copy -c:a copy 0010-copy.mp4

:GO_1N20
IF NOT EXIST 0020.media GOTO GOTO GO_2
D:\Application\ffmpeg\bin\ffmpeg.exe -i 0020.media -c:v copy -c:a copy 0020-copy.mp4

:GO_2
IF "%2"==""  GOTO end_completed
IF "%2"=="1" GOTO cnverting_low
IF "%2"=="2" GOTO cnverting_low2
IF "%2"=="3" GOTO cnverting_med
IF "%2"=="4" GOTO cnverting_high
IF "%2"=="5" GOTO cnverting_max

:cnverting_low
IF NOT EXIST 0000.media GOTO GO_2N10

D:\Application\ffmpeg\bin\ffmpeg.exe -i 0000.media -s 640x360 -c:v libx264 -b:v 560k -r 24 -x264opts keyint=48:min-keyint=48:no-scenecut -profile:v main -preset fast -movflags +faststart -c:a libfdk_aac -b:a 192k -ac 2 0000-low.mp4

:GO_2N10
IF NOT EXIST 0010.media GOTO GO_2N20

D:\Application\ffmpeg\bin\ffmpeg.exe -i 0010.media -s 640x360 -c:v libx264 -b:v 560k -r 24 -x264opts keyint=48:min-keyint=48:no-scenecut -profile:v main -preset fast -movflags +faststart -c:a libfdk_aac -b:a 192k -ac 2 0010-low.mp4

:GO_2N20
IF NOT EXIST 0020.media GOTO GO_3

D:\Application\ffmpeg\bin\ffmpeg.exe -i 0020.media -s 640x360 -c:v libx264 -b:v 560k -r 24 -x264opts keyint=48:min-keyint=48:no-scenecut -profile:v main -preset fast -movflags +faststart -c:a libfdk_aac -b:a 192k -ac 2 0020-low.mp4

:GO_3
IF "%3"==""  GOTO end_completed
IF "%3"=="2" GOTO cnverting_low2
IF "%3"=="3" GOTO cnverting_med
IF "%3"=="4" GOTO cnverting_high
IF "%3"=="5" GOTO cnverting_max

:cnverting_low2
IF NOT EXIST 0000.media GOTO GO_3N10

D:\Application\ffmpeg\bin\ffmpeg.exe -i 0000.media -s 640x360 -c:v libx265 -b:v 334k -r 24 -x265-params "keyint=48:min-keyint=48:no-open-gop=1:no-scenecut=1" -preset fast -movflags +faststart -c:a libfdk_aac -profile:a aac_he_v2 -b:a 192k -ac 2 0000-low-2.mp4

:GO_3N10
IF NOT EXIST 0010.media GOTO GO_3N20

D:\Application\ffmpeg\bin\ffmpeg.exe -i 0010.media -s 640x360 -c:v libx265 -b:v 334k -r 24 -x265-params "keyint=48:min-keyint=48:no-open-gop=1:no-scenecut=1" -preset fast -movflags +faststart -c:a libfdk_aac -profile:a aac_he_v2 -b:a 192k -ac 2 0010-low-2.mp4

:GO_3N20
IF NOT EXIST 0020.media GOTO GO_4

D:\Application\ffmpeg\bin\ffmpeg.exe -i 0020.media -s 640x360 -c:v libx265 -b:v 334k -r 24 -x265-params "keyint=48:min-keyint=48:no-open-gop=1:no-scenecut=1" -preset fast -movflags +faststart -c:a libfdk_aac -profile:a aac_he_v2 -b:a 192k -ac 2 0020-low-2.mp4

:GO_4
IF "%4"==""  GOTO end_completed
IF "%4"=="3" GOTO cnverting_med
IF "%4"=="4" GOTO cnverting_high
IF "%4"=="5" GOTO cnverting_max

:cnverting_med
IF NOT EXIST 0000.media GOTO GO_4N10

D:\Application\ffmpeg\bin\ffmpeg.exe -i 0000.media -s 960x540 -c:v libx264 -b:v 1260k -r 24 -x264opts keyint=48:min-keyint=48:no-scenecut -profile:v main -preset fast -movflags +faststart -c:a libfdk_aac -b:a 192k -ac 2 0000-med.mp4

:GO_4N10
IF NOT EXIST 0010.media GOTO GO_4N20

D:\Application\ffmpeg\bin\ffmpeg.exe -i 0010.media -s 960x540 -c:v libx264 -b:v 1260k -r 24 -x264opts keyint=48:min-keyint=48:no-scenecut -profile:v main -preset fast -movflags +faststart -c:a libfdk_aac -b:a 192k -ac 2 0010-med.mp4

:GO_4N20
IF NOT EXIST 0020.media GOTO GO_5

D:\Application\ffmpeg\bin\ffmpeg.exe -i 0020.media -s 960x540 -c:v libx264 -b:v 1260k -r 24 -x264opts keyint=48:min-keyint=48:no-scenecut -profile:v main -preset fast -movflags +faststart -c:a libfdk_aac -b:a 192k -ac 2 0020-med.mp4

:GO_5
IF "%5"==""  GOTO end_completed
IF "%5"=="4" GOTO cnverting_high
IF "%5"=="5" GOTO cnverting_max

:cnverting_high
IF NOT EXIST 0000.media GOTO GO_5N10

D:\Application\ffmpeg\bin\ffmpeg.exe -i 0000.media -s 1280x720 -c:v libx264 -b:v 2224k -r 24 -x264opts keyint=48:min-keyint=48:no-scenecut -profile:v main -preset fast -movflags +faststart -c:a libfdk_aac -b:a 192k -ac 2 0000-high.mp4

:GO_5N10
IF NOT EXIST 0010.media GOTO GO_5N20

D:\Application\ffmpeg\bin\ffmpeg.exe -i 0010.media -s 1280x720 -c:v libx264 -b:v 2224k -r 24 -x264opts keyint=48:min-keyint=48:no-scenecut -profile:v main -preset fast -movflags +faststart -c:a libfdk_aac -b:a 192k -ac 2 0010-high.mp4

:GO_5N20
IF NOT EXIST 0020.media GOTO GO_6

D:\Application\ffmpeg\bin\ffmpeg.exe -i 0020.media -s 1280x720 -c:v libx264 -b:v 2224k -r 24 -x264opts keyint=48:min-keyint=48:no-scenecut -profile:v main -preset fast -movflags +faststart -c:a libfdk_aac -b:a 192k -ac 2 0020-high.mp4

:GO_6
IF "%6"==""  GOTO end_completed
IF "%6"=="5" GOTO cnverting_max

:cnverting_max
IF NOT EXIST 0000.media GOTO GO_6N10

D:\Application\ffmpeg\bin\ffmpeg.exe -i 0000.media -s 1920x1080 -c:v libx264 -b:v 5050k -r 24 -x264opts keyint=48:min-keyint=48:no-scenecut -profile:v main -preset fast -movflags +faststart -c:a libfdk_aac -b:a 192k -ac 2 0000-max.mp4

:GO_6N10
IF NOT EXIST 0010.media GOTO GO_6N20

D:\Application\ffmpeg\bin\ffmpeg.exe -i 0010.media -s 1920x1080 -c:v libx264 -b:v 5050k -r 24 -x264opts keyint=48:min-keyint=48:no-scenecut -profile:v main -preset fast -movflags +faststart -c:a libfdk_aac -b:a 192k -ac 2 0010-max.mp4

:GO_6N20
IF NOT EXIST 0020.media GOTO end_completed

D:\Application\ffmpeg\bin\ffmpeg.exe -i 0020.media -s 1920x1080 -c:v libx264 -b:v 5050k -r 24 -x264opts keyint=48:min-keyint=48:no-scenecut -profile:v main -preset fast -movflags +faststart -c:a libfdk_aac -b:a 192k -ac 2 0020-max.mp4
GOTO end_completed

:errors 
CLS
ECHO --------------------------------------------------------------------
ECHO Script usage example: Script_converting_SessionData with parameters
ECHO --------------------------------------------------------------------
GOTO end

:end_completed 
ECHO The Windows command script has completed.

:end


