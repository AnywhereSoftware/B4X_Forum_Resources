@ECHO OFF
REM Create B4R Library XML for rLiquidCrystalI2CEx

REM Set the parameter for the converter h file to xml file
SET pathh2xml=d:\b4\b4r\tools\B4Rh2xml\B4Rh2xml.jar

ECHO Creating Library XML for rLiquidCrystalI2CEX ...
java -jar %pathh2xml% rLiquidCrystalI2CEx.h ../rLiquidCrystalI2CEx.xml
ECHO Done

pause
