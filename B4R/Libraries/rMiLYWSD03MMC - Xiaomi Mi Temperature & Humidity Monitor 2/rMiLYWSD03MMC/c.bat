@ECHO OFF
REM Create B4R Library XML for rMiLYWSD03MMC

REM Set the parameter for the converter h file to xml file
SET pathh2xml=d:\b4\b4r\tools\B4Rh2xml\B4Rh2xml.jar

ECHO Creating Library XML for rMiLYWSD03MMC ...
java -jar %pathh2xml% rMiLYWSD03MMC.h ../rMiLYWSD03MMC.xml
ECHO Done

pause
