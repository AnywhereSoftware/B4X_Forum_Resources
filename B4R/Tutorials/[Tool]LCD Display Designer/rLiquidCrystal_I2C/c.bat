@ECHO OFF
REM Create B4R Library XML for rLiquidCrystal_I2C

REM Set the parameter for the converter h file to xml file
SET pathh2xml=d:\b4\b4r\tools\B4Rh2xml\B4Rh2xml.jar

ECHO Creating Library XML for rLiquidCrystal_I2C ...
java -jar %pathh2xml% rLiquidCrystal_I2C.h ../rLiquidCrystal_I2C.xml
ECHO Done

pause
