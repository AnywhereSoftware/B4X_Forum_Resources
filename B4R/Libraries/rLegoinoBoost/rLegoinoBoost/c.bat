@ECHO OFF
REM Create B4R Library XML for rLegoinoBoost
REM 20211002 rwbl
ECHO Create B4R Library XML for rLegoinoBoost

REM Set the parameter for the converter h file to xml file
SET pathh2xml=d:\b4\b4r\tools\B4Rh2xml\B4Rh2xml.jar

ECHO Creating XML file ...
java -jar %pathh2xml% rLegoinoBoost.h ../rLegoinoBoost.xml

ECHO Done

PAUSE
