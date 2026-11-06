### rLEDController by rwblinn
### 07/21/2021
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/132759/)

**rLEDController** is an open source B4R B4XLib for controlling multiple LEDs.  
  
The LEDController enableds to control up-to 10 LEDs individually, like turn ON/OFF, turn on for period of time or number of timer ticks.  
*Background*  
The background for developing this module, is to control a number of LEDs for a model railroad project - digital command control using an Arduino MEGA as a Command Station.  
The LEDs have several functions: Buffer-Stop Indicators, Loco Drive State Indicator, Command-Controller State, Track-Lights etc.  
  
**Attached**  
rLEDController.zip archive contains the B4R library and B4R sample projects.  
  
**Install**  
The files rLEDController.bx4lib and rLEDController.xml to be installed in the B4R additional libraries folder.  
From the zip archive, copy the rLEDController.bx4lib and rLEDController.xml to the B4R additional libraries folder.  

```B4X
<path to b4r additional libraries folder>\rLEDController.bx4lib, rLEDController.xml
```

  
The folder Examples contain a B4R example (see below Basic Example).  
  
**Hardware**  
Tested the library with an **Arduino UNO** and three LEDs.  
  
**Wiring**  

```B4X
LED = Arduino UNO  
LED RED Plus = #13				'0x0D  
LED YELLOW Plus = #12			'0x0C  
LED GREEN Plus = #11			'0x0B  
LED RED,YELLOW,GREEN GND = GND
```

  
  
**Syntax Standard**  

- Constants are in UPPERCASE.
- Fields are in CamelCase.
- Types start with prefix TLEDController.
- All functions use underscores except Initialize.

**Functions**  
  
**Initialize Module**  

```B4X
LEDController.Initialize(Interval As ULong, Debug_Mode As Boolean)
```

  
Interval - Interval in ms to check the LEDs (default 1000ms).  
Debug\_Mode - Debug flag to log methods steps and output.  
*Returns*  
None  
*Example*  

```B4X
LEDController.Initialize(1000, True)
```

  
  
**Add an LED to the LED arrays**  

```B4X
LEDController.Add_LED(Index As Byte, PinNr As Byte) As Boolean
```

  
Index - LED array index. Must be in range array size 0 - 10 (set by LEDCOUNT in the module). Default 0-9.  
PinNr - LED GPIO pin number. Like 0x0D.  
*Returns*  
True if sucessfully added to the arrays; False if out of array index  
*Example*  

```B4X
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2  
LEDController.Add_LED(LEDRED, 0x0D)
```

  
  
**Set the LED controller timer enabled state**  

```B4X
LEDController.Set_Timer_Enabled(Enabled As Boolean)
```

  
Enabled - True (1) Timer is ON, False (0) Timer is Off.  
*Returns*  
None  
*Example*  

```B4X
LEDController.Set_Timer_Enabled(False)
```

  
  
**Set the timer off after number of ticks**  

```B4X
LEDController.Set_Timer_Off_After_Ticks(Ticks As ULong)
```

  
Ticks - If timer ticks > ticks, the timer will be disabled. Disable turning timer off by setting Ticks to 0.   
*Returns*  
None  
*Example*  

```B4X
LEDController.Set_Timer_Off_After_Ticks(10)	'Turn timer off after 10 ticks  
LEDController.Set_Timer_Off_After_Ticks(0)		'Disable turning timer off after max ticks
```

  
  
**Get the timer state enabled or disabled**  

```B4X
LEDController.Get_Timer_Enabled As Boolean
```

  
*Returns*  
True (timer is enabled), False (timer is disabled)  
*Example*  

```B4X
Dim LEDController_Timer_Enabled As Boolean = LEDController.Get_Timer_Enabled
```

  
  
**Set LED state to ON or OFF**  

```B4X
LEDController.Set_State(Index As Int, State As Boolean)
```

  
Index - LED array index.  
State - True=ON, False=OFF.  
*Returns*  
None  
*Example*  

```B4X
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2  
LEDController.Set_State(LEDRED, True)
```

  
  
**Get LED state ON (True) or OFF (False)**  

```B4X
LEDController.Get_State(Index As Int) As Boolean
```

  
Index - LED array index.  
*Returns*  
True (1) if LED is ON, False (0) if LED is OFF.  
*Example*  

```B4X
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2  
Dim State As Boolean = LEDController.Get_State(LEDRED)
```

  
  
**Set LED state to ON**  

```B4X
LEDController.Sub Set_ON(Index As Int)
```

  
Index - LED array index.  
*Returns*  
None  
*Example*  

```B4X
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2  
LEDController.Set_ON(LEDRED)
```

  
  
**Set LED state to OFF**  

```B4X
LEDController.Sub Set_OFF(Index As Int)
```

  
Index - LED array index.  
*Returns*  
None  
*Example*  

```B4X
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2  
LEDController.Set_OFF(LEDRED)
```

  
  
**Set mode to none**  
All counters are resetted and LED is turned off.  

```B4X
LEDController.Set_Mode_None(Index As Int)
```

  
Index - LED array index.  
*Returns*  
None  
*Example*  

```B4X
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2  
LEDController.Set_Mode_None(LEDRED)
```

  
  
**Set mode to blink**  

```B4X
LEDController.Sub Set_Mode_Blink(Index As Int, Ticks As Int)
```

  
Index - LED array index.  
Ticks - Blink on number of timer ticks. Set to 1 if every timer tick else higher for every N timer ticks.  
*Returns*  
None  
*Example*  

```B4X
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2  
LEDController.Set_Mode_Blink(LEDRED, 2)
```

  
  
**Set mode to blink for time**  
Each timer\_tick is calculated using the Timer\_Interval.  

```B4X
LEDController.Set_Blink_For_Time(Index As Int, Time As ULong)
```

  
Time - Time in ms.  
*Returns*  
None  
*Example*  

```B4X
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2  
LEDController.Blink_For_Time(LEDRED, 4000)
```

  
  
**Set mode to blink for N number of timer ticks (counts)**  

```B4X
LEDController.Set_Blink_For_Count(Index As Int, Count As ULong)
```

  
Index - LED array index.  
Count - Number of timer ticks the LED should blink.  
*Returns*  
None  
*Example*  

```B4X
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2  
LEDController.Set_Blink_For_Count(LEDRED, 4)
```

  
  
**Set mode to on for time**  
Each timer\_tick is calculated using the Timer\_Interval.  

```B4X
LEDController.Sub Set_ON_For_Time(Index As Int, Time As ULong)
```

  
Time - Time in ms.  
*Returns*  
None  
*Example*  

```B4X
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2  
LEDController.Blink_For_Time(LEDRED, 4000)
```

  
  
**Set the blink ticks**  

```B4X
LEDController.Set_Blink_Ticks(Index As Int, Ticks As Int)
```

  
Index - LED array index.  
Ticks - Blink on number of timer ticks. Set to 1 if every timer tick else higher for every N timer ticks.  
*Returns*  
None  
*Example*  

```B4X
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2  
LEDController.Set_Blink_Ticks(LEDRED, 4)
```

  
  
**Check the state of the LEDS, output to the log (serialline)**  

```B4X
LEDController.Check_LEDS
```

  
*Returns*  
None but the output is written to the log.  
*Example*  

```B4X
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2  
LEDController.Check_LEDS
```

  
  
**Fields**  

- Debug - Debug flag to log methods steps and output.
- VERSION - Module version number.

  
**B4R Basic Example**  

```B4X
Sub Process_Globals  
	Public VERSION As String = "B4R Library rLEDController - Basic Example"  
	Public serialLine As Serial  
	' Declare the LEDS each with unique index used for the LEDControl LED arrays. Must be in range with constant - LEDController.LEDCOUNT.  
	Private Const LEDRED As Int = 0, LEDYELLOW As Int = 1, LEDGREEN As Int = 2  
	' Set the LED controller timer interval in ms.  
	Private Const TIMER_INTERVAL As ULong = 1000  
End Sub  
  
Private Sub AppStart  
	serialLine.Initialize(115200)  
	Log(VERSION)  
	'Init the LED Controller  
	LEDController.Initialize(TIMER_INTERVAL, True)  
  
	'Add to the LED controller 3 LEDs (Index, PinNr)  
	LEDController.Add_LED(LEDRED, 0x0D)  
	LEDController.Add_LED(LEDYELLOW, 0x0C)  
	LEDController.Add_LED(LEDGREEN, 0x0B)  
  
	'Examples Overview - Some are commented out.  
  
	'LEDRED to blink every 4 timer ticks, i.e. every 4 seconds (4 * TIMER_INTERVAL in ms)  
	'LEDController.Set_Mode_Blink(LEDRED, 4)  
  
	'LEDYELLOW to blink 4 seconds, i.e. blinking 2 times (ON-OFF-ON-OFF) if TIMER_INTERVAL is 1000 ms  
	LEDController.Set_Blink_For_Time(LEDYELLOW, 4 * TIMER_INTERVAL)  
  
	'LEDRED ON for 4 seconds, if TIMER_INTERVAL is 1000 ms  
	LEDController.Set_ON_For_Time(LEDRED, 4 * TIMER_INTERVAL)  
  
	'LEDGREEN to blink 6 times (=12 timer ticks)  
	LEDController.Set_Blink_For_Count(LEDGREEN, 6)  
  
	'Let all LEDS blink same time (=interval factor 1)  
	'LEDController.Set_Mode_Blink(LEDRED, 1)  
	'LEDController.Set_Mode_Blink(LEDYELLOW, 1)  
	'LEDController.Set_Mode_Blink(LEDGREEN, 1)  
	  
	'LEDController.Check_LEDS  
	  
	'Turn the timer off after 15 ticks  
	LEDController.Set_Timer_Off_After_Ticks(15)  
End Sub
```

  
  
**Hints**  

- The number of supported LEDs can be changed in the module LEDController.bas, constant LEDCOUNT and arrays LEDS, LEDPins.

  
**Licence**  
GNU General Public License v3.0.  
  
**ToDo**  
See file TODO.md.  
  
**Changelog**  
v1.00 (20210721) - First version.  
See file CHANGELOG.md.