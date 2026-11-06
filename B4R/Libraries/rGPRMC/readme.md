### rGPRMC by rwblinn
### 07/05/2021
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/132183/)

**rGPRMC** is an open source B4R B4XLib for parsing the GPS NMEA RMC sentence message.  
  
Obtain Lat / Lon position, Direction Indicator, Speed, Course an Timestamp.  
Addition functions: calculate the distance between, the course to for two Lat / Lon positions or time difference.  
  
**Attached**  
rGPRMC.zip archive contains the B4R library and B4R sample projects.  
  
**Install**  
The files rGPRMC.bx4lib and rGPRMC.xml to be installed in the B4R additional libraries folder.  
From the zip archive, copy the rGPRMC.bx4lib and rGPRMC.xml to the B4R additional libraries folder.  

```B4X
<path to b4r additional libraries folder>\rGPRMC.bx4lib, rGPRMC.xml
```

  
The folder Examples contain some B4R examples (see below Examples).  
  
**Hardware**  
Tested the library with an **Arduino UNO** and **MakerHawk GPS Module with GT-U7 chip and SIM39ES antenna**.  
**MakerHawk Module**: Operating frequency: L1 (1575.42 +/- 10MHz), Operating voltage: 3.3 - 5.2V, Operating current: normal 50mA, power-saving 30mA, Communication interface: TTL serial port, micro USB interface (debugging), Serial port baud rate: 9600bps, Communication format: 8N1, Interface logic voltage: 3.3V or 5V, External antenna interface: IPX, Onboard rechargeable button battery, Onboard E2PROM to save parameter data, NEMA output format compatible NEO-6M, Size: 27.6mm \* 26.6mm  
  
**Wiring**  

```B4X
GPS Module = Arduino UNO (Wirecolor)  
VCC = 3.3V (RED)  
GND = GND (BLACK)  
RXD = Pin #3 used as TX (BLUE)  
TXD = Pin #4 used as RX (GREEN)  
PPS = Time Pulse output = Not used - Can be used for the GPS to drive a hardware high precision clock
```

  
  
**Syntax Standard**  

- Constants are in UPPERCASE - KTTOKMH
- Fields are in CamelCase - TimeDifference
- Types start with prefix TGPRMC… - Type TGPRMCTime (Stamp As Double, Hours As Int, Minutes As Int, Seconds As Int)
- All functions use underscores - Time\_Difference(…), Knots\_To\_Kmh(knots As Double) As Double

**Functions  
  
Initialize Module**  

```B4X
GPRMC.Initialize(Debug_Mode As Boolean, UTC_Offset As Int, Speed_Min_Threshold As Double)
```

  
Debug\_Mode - Set To True To Log the various steps from init To getting data.  
Hint: The debug mode can also set via field GPRMC.DebugMode = True Or False.  
UTC\_Offset - UTC Offset in Hours (to Local Time) for the Timestamp Hours  
Speed\_Min\_Threshold - Speed Kmh is set to 0 if below min threshold. To disable, set minthreshold 0.  
Hint: The threshold can also set via field GPRMC.SpeedMinThresHold = NN.  
*Returns*  
None  
*Example*  

```B4X
GPRMC.Initialize(False, 2)
```

  
  
**Parse NMEA RMC Sentence CSV String into Fields**  

```B4X
GPRMC.Parse_RMC_Sentence(Data() As Byte) As Boolean
```

  
Parse the NMEA RMC sentence fields 0 - 9, which is a CSV string into the fields (see below section *Fields*).  
Data - Byte array holding the NMEA RMC sentence string  
*Returns*  
Boolean - True if successfully parsed or field DataValid is True.  
*Example*  

```B4X
Dim GPRMC_DATA As String  "$GPRMC,083559.00,A,4717.11437,N,00833.91522,E,10.4,77.52,290621,,,A,V*57"  
Dim bc As ByteConverter  
GPRMC.Initialize(False)  
If GPRMC.Parse_RMC_Sentence(GPRMC_DATA) Then  
    Log("Data Valid: ", GPRMC.DataValid)  
    Log("Lat: ", GPRMC.Lat.DegreesDec, ", Indicator: ", bc.StringFromBytes(Array As Byte(GPRMC.Lat.Indicator)))  
    Log("Lon: ", GPRMC.Lon.DegreesDec, ", Indicator: ", bc.StringFromBytes(Array As Byte(GPRMC.Lon.Indicator)))  
    Log("Speed (kmh): ", GPRMC.Speed, ", Course (deg): ", GPRMC.Course)  
    Log("TimeStamp (h.m.s): ", GPRMC.TimeStamp.Hour, ".", GPRMC.TimeStamp.Minutes, ".", GPRMC.TimeStamp.Seconds)  
    Log("DateStamp (D.M.Y): ", GPRMC.DateStamp.Day, ".", GPRMC.DateStamp.Month, ".", GPRMC.DateStamp.Year)  
End If
```

  
  
**Distance (approx in meters) between two Lat Lon Positions**  

```B4X
GPRMC.Distance_Between_Positions(latA As Double, lonA As Double, latB As Double, lonB As Double, unit As Byte) As Double
```

  
Calculate approximate distance between two locations with lat / lon coordinates - NOT ACCURATE.  
Best result for distances > 10 Km (to be checked out if smaller distance can do as well properly with f.e. Arduino Leonardo).  
latA - Latitude of the first location in decimal degrees (DD.DDDDDD)  
lonA - Longitude of the first location in decimal degrees (DD.DDDDDD)  
latB - Latitude of the second location in decimal degrees (DD.DDDDDD)  
lonB - Longitude of the second location in decimal degrees (DD.DDDDDD)  
unit - 0 statute miles, 1 kilometers, 2 nautical miles  
*Returns*  
Double - Distance NN.NNNN for the selected unit.  
*Example*  

```B4X
'Distance between the cities Hamburg and Kiel (Germany) = 86.5038 km  
Log(GPRMC.Distance_Between(53.551086, 9.993682, 54.323334, 10.1394444, 1))
```

  
  
**Distance (approx in meters) between two GPS timestamps**  

```B4X
Distance_Between_TimeStamps(speedA As Double, speedB As Double, timeA As TGPRMCTime, timeB As TGPRMCTime) As Double
```

  
Calculate approximate distance in Km using average speed between two GPS timestamps - NOT ACCURATE.  
The usual time difference in seconds between two GPS readings is 1 second (depends GPS device and atenna).  
speedA - First Speed Kmh  
speedB - Second Speed Kmh  
timeA - Start time stamp  
timeB - End time stamp  
*Returns*  
Distance in Km  
*Example*  

```B4X
' Time difference is 1 second between two GPS readings. Speed A=50, B=52, Avg=51.  
Dim TimeA As TGPRMCTime  
TimeA.Hours = 10: TimeA.Minutes=10: TimeA.Seconds=10  
Dim TimeB As TGPRMCTime  
TimeB.Hours = 10: TimeB.Minutes=10: TimeB.Seconds=11  
Log(GPRMC.Distance_Between_TimeStamps(50, 52, TimeA, TimeB))  
'0.0142km
```

  
  
**Bearing or Course To (approx in degrees) between two Lat Lon Positions**  

```B4X
GPRMC.Course_To(latA As Double, lonA As Double, latB As Double, lonB As Double) As Double
```

  
Calculate approximate bearing (course to) between two locations with lat / lon coordinates - NOT ACCURATE.  
latA - Latitude first location in decimal degrees (DD.DDDDDD)  
lonA - Longitude first location in decimal degrees (DD.DDDDDD)  
latB - Latitude second location in decimal degrees (DD.DDDDDD)  
lonB - Longitude second location in decimal degrees (DD.DDDDDD)  
*Returns*  
Double - NN.NNNN in degrees decimal  
*Example*  

```B4X
'Bearing (=Course to) between the cities Hamburg and Kiel (Germany) = 6.2814 degrees  
Log(GPRMC.Course_To(53.551086, 9.993682, 54.323334, 10.1394444))
```

  
  
**Time Difference Start and End Time**  

```B4X
Time_Difference(StartHours As Int, StartMinutes As Int, StartSeconds As Int, EndHours As Int, EndMinutes As Int, EndSeconds As Int)
```

  
Calculate the time difference in HH MM SS between a start and end time (to used for duration calculations).  
StartHours, StartMinutes, StartSeconds - Int  
EndHours, EndMinutes, EndSeconds - Int  
*Returns*  
Global variable TimeDifference with type TGPRMCTime is updated.  
Note: The time difference is always positive even if the endtime smaller starttime.  
*Example*  

```B4X
GPRMC.Time_Difference(10, 55, 1, 11, 2, 3)  
Log("Time Difference: ", GPRMC.TimeDifference.Stamp, ",",GPRMC.TimeDifference.Hours,",",GPRMC.TimeDifference.Minutes,",",GPRMC.TimeDifference.Seconds)  
' Time Difference: 702,0,7,2
```

  
  
**Conversions**  
Knots to Kmh - 1 knot (kt) = 1.85200 kmh  
Kmh to Knots - 1 kmh = 0,539957 knot (kt)  

```B4X
Knots_To_Kmh(knots As Double) As Double  
Kmh_To_Knots(kmh As Double) As Double
```

  
  
**Fields**  

- DateStamp.Stamp - Double, Day, Month, Year - Int, UTC
- TimeStamp.Stamp - Double, Hours, Minutes, Seconds - Int, UTC
- DataValid - True or False
- Lat.Degrees, Minutes, Seconds - Int
- Lat.DegreesDec - Double - Decimal Degrees can be used directly in f.e. Google Maps 47.2852,8.5653
- Lat.Indicator (N, S) - Byte - Convert to string with ByteConverter bc.StringFromBytes(Array As Byte(GPRMC.Lat.Indicator))
- Lon.Degrees, Minutes, Seconds - Int
- Lon.DegreesDec - Double
- Lon.Indicator (E, W) - Byte
- Speed - Kmh - Double
- Course - Degrees over ground - Double

*Note*  
The RMC sentence fields 10 - 14 are not parsed.  
  
**Parameter**  

- UTCOffSet - Int - UTC Offset in Hours (to Local Time) for the Timestamp Hours.
- SpeedMinThresHold - Double - Speed Kmh is set to 0 if below min threshold. To disable, set minthreshold 0.

**B4R Examples**  

- **ParseMessage** - Test parsing NMEA GPRMC sentence message into fields. There is no GPS module connected.
- **MakerHawk** - Test reading & parsing NMEA GPRMC sentence messages from a MakerHawk GPS Module with GT-U7 chip and SIM39ES antenna.
- **LCDDisplay** - Mini dashboard showing Lat/Lon position, Speed, Distance, Duration, Actual Time (see post #2 & 3).

**MakerHawk**  

```B4X
Sub Process_Globals  
    ' Serial line  
    Public serialLine As Serial  
    Private Const SERIALLINE_BAUD As ULong = 115200  
    ' Software serial port used for GPS module with baud rate 9600  
    Private serialGPS As SoftwareSerial  
    Private Const SERIALGPS_BAUD As ULong    = 9600        'Take from GPS module datasheet  
    Private Const SERIALGPS_RX_PIN As Byte    = 4            'Microcontroller RX pin  
    Private Const SERIALGPS_TX_PIN As Byte    = 3            'Microcontroller TX pin  
    Private CONST GPRMC_SENTENCE() As Byte    = "$GPRMC"    'As defined by NMEA spec  
    ' Handle GPS data received via serial gps  
    Private asyncStream As AsyncStreams  
    ' Helper to get GPRMC Lat indicator as String in the log  
    Private bc As ByteConverter  
End Sub  
  
Private Sub AppStart  
    serialLine.Initialize(SERIALLINE_BAUD)  
    Log("GPRMC Test - GPS MakerHawk Module v20210704")  
    'Init the GPS object  
    GPRMC.Initialize(False, 2, 0)  
    'Init serial GPS with Baud, Arduino RX Pin 4, Arduino TX Pin 3  
    serialGPS.Initialize(SERIALGPS_BAUD, SERIALGPS_RX_PIN, SERIALGPS_TX_PIN)  
    Log("Init serial GPS")  
    asyncStream.Initialize(serialGPS.Stream,"AsyncStream_NewData",Null)  
    Log("Init asyncstream, waiting for data… (approx every second)")  
End Sub  
  
' Handle new data from the serial GPS line  
Sub AsyncStream_NewData(rmcData() As Byte)  
    ' Check if the incoming data starts with the NMEA GPRMC sentence  
    If bc.IndexOf2(rmcData, GPRMC_SENTENCE, 0) > -1 Then  
        Log(rmcData)  
        ' Parse the RMC sentence data - the first 10 fields  
        If GPRMC.Parse_RMC_Sentence(rmcData) Then  
            If GPRMC.DataValid Then  
                Log("DateStamp (D.M.Y): ", GPRMC.DateStamp.Stamp, "=", GPRMC.DateStamp.Day, ".", GPRMC.DateStamp.Month, ".", GPRMC.DateStamp.Year)  
                Log("TimeStamp (h:m:s): ", GPRMC.TimeStamp.Stamp, "=", GPRMC.TimeStamp.Hours, ":", GPRMC.TimeStamp.Minutes, ":", GPRMC.TimeStamp.Seconds)  
                Log("Lat: ", GPRMC.Lat.DegreesDec, ", Indicator: ", bc.StringFromBytes(Array As Byte(GPRMC.Lat.Indicator)))  
                Log("Lon: ", GPRMC.Lon.DegreesDec, ", Indicator: ", bc.StringFromBytes(Array As Byte(GPRMC.Lon.Indicator)))  
                Log("Speed (kmh): ", GPRMC.Speed, ", ", GPRMC.Speed * GPRMC.KMHTOKT, " (kt)")  
                Log("Course Over Ground (deg): ", GPRMC.Course)  
                Log("********************************************************************")  
            Else  
                ' If not receiving GPS signal, the data valid flag is 0 (false)  
                Log("Data is NOT valid")  
            End If  
        End If  
    End If  
    ' Short delay to ensure parsing is complete befor new data arrives  
    DelayMicroseconds(100)  
End Sub
```

  
  
*B4R Log Snippet (Debug=False)*  

```B4X
$GPRMC,082243.00,A,5338.25112,N,00947.94171,E,0.245,,010721,,,A*71  
$GPVTG,,T,,M,0.245,N,0.453,K,A*2  
DateStamp (D.M.Y): 10721=1.7.21  
TimeStamp (h:m:s): 82243=8:22:43  
Lat: 53.6375, Indicator: N  
Lon: 9.7990, Indicator: E  
Speed (kmh): 0.4537, 0.2450 (kt)  
Course Over Ground (deg): 0
```

  
  
**Hints**  

- It can take up-to few minutes (module onboard red LED lights steady) till the module receives GPS data (module onboard red LED starts to blink).
- If GPS satellite connection made, data is updated almost every second.
- If testing inhouse, ensure the antenna is close pointing to an outside area.
- For external power - DC 9V, 2A is required - tested with an Arduino UNO and the MakerHawk.
- The accuracy of method Distance\_Between\_Positions improves the longer the distance - depends also on the precision of the microcontroller used.

**Licence**  
GNU General Public License v3.0.  
  
**Credits**  
The formulas used for the  

- method "Distance\_Between\_Positions" are based on the VB example by [GeoDataSource](https://www.geodatasource.com).
- methods "Distance\_Between\_Positions2" (currently not used, kept for reference) and "Course\_To" are based on the work by and courtesy of Maarten Lamers, The Netherlands.

**ToDo**  
See file TODO.md.  
  
**Changelog**  
v1.45 (20210705) - New function Distance\_Between\_TimeStamps; Reworked and renamed: Distance\_Between to Distance\_Between\_Positions; FIX: Distance\_Between\_Positions and Course\_To if position not changed; Update LCD Display Example.  
v1.40 (20210704) - New functions Time\_Difference, Kmh\_To\_Knots, Knots\_To\_Kmh; New parameter UTCOffset, SpeedMinThreshold; Changed names types & functions; New example LCDDisplay (see post #2).  
v1.00 (20210702) - First version.  
See file CHANGELOG.md.