@ECHO OFF
SET dumpdata=dump
SET sentimages=pictures
SET /P clientcnt=Number of test clients to create :
SET /P runtime=Number of seconds to run test :
SET /P sleeptime=Number of milliseconds to pause between requests :
SET /P batchsize=Size of SQL batches :
SET /P jrdclink=URL of jRDC server :
CHOICE /m "Dump existing data?"
IF errorlevel 2 SET /A dumpdata=FALSE
CHOICE /m "Sent images?"
IF errorlevel 2 SET /A sentimages=FALSE
SET /A pingcnt=runtime+1+(clientcnt/5)
ECHO Ping count: %pingcnt%
IF %clientcnt% LEQ 0 GOTO :END
IF %dumpdata%==dump java -jar TestClient.jar %jrdclink% %dumpdata%
:LOOP
START cmd /k java -jar TestClient.jar %jrdclink% %sentimages% %clientcnt% t:%runtime% s:%sleeptime% b:%batchsize%
SET /A clientcnt-=1
IF %clientcnt% GTR 0 GOTO :LOOP
ECHO:
ECHO Waiting for test clients to finish...
::https://ss64.com/nt/ping.html
ECHO %pingcnt%
Ping -n %pingcnt% 127.0.0.1>nul
java -jar TestClient.jar count %jrdclink% %sentimages%
:END