[B]rLEDController[/B] is an open source B4R B4XLib for controllig multiple LEDs.

The LEDController enableds to control up-to 10 LEDs individually, like turn ON/OFF, turn on for period of time or number of timer ticks.
[I]Background[/I]
The background for developing this module, is to control a number of LEDs for a model railroad project - digital command control using an Arduino MEGA as a Command Station.
The LEDs have several functions: Buffer-Stop Indicators, Loco Drive State Indicator, Command-Controller State, Track-Lights etc.

[B]Attached[/B]
rLEDController.zip archive contains the B4R library and B4R sample projects.

[B]Install[/B]
The files rLEDController.bx4lib and rLEDController.xml to be installed in the B4R additional libraries folder.
From the zip archive, copy the rLEDController.bx4lib and rLEDController.xml to the B4R additional libraries folder.
[CODE=b4x]
<path to b4r additional libraries folder>\rLEDController.bx4lib, rLEDController.xml
[/CODE]
The folder Examples contain some B4R examples (see below Examples).

[B]Hardware[/B]
Tested the library with an [B]Arduino UNO[/B] and three LEDs.

[B]Wiring[/B]
[CODE=b4x]
LED = Arduino UNO
LED RED Plus = #13				'0x0D
LED YELLOW Plus = #12			'0x0C
LED GREEN Plus = #11			'0x0B
LED RED,YELLOW,GREEN GND = GND
[/CODE]

[B]Syntax Standard[/B]
[LIST]
[*]Constants are in UPPERCASE.
[*]Fields are in CamelCase.
[*]Types start with prefix TLEDController.
[*]All functions use underscores except Initialize.
[/LIST]
[B]Functions[/B]

[B]Initialize Module[/B]
[CODE=b4x]
LEDController.Initialize(Interval As ULong, Debug_Mode As Boolean)
[/CODE]
Interval - Interval in ms to check the LEDs (default 1000ms).
Debug_Mode - Debug flag to log methods steps and output.
[I]Returns[/I]
None
[I]Example[/I]
[CODE=b4x]
LEDController.Initialize(1000, True)
[/CODE]

[B]Add an LED to the LED arrays[/B]
[CODE=b4x]
LEDController.Add_LED(Index As Byte, PinNr As Byte) As Boolean
[/CODE]
Index - LED array index. Must be in range array size 0 - 10 (set by LEDCOUNT in the module). Default 0-9.
PinNr - LED GPIO pin number. Like 0x0D.
[I]Returns[/I]
True if sucessfully added to the arrays; False if out of array index
[I]Example[/I]
[CODE=b4x]
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2
LEDController.Add_LED(LEDRED, 0x0D)
[/CODE]

[B]Set the LED controller timer enabled state[/B]
[CODE=b4x]
LEDController.Set_Timer_Enabled(Enabled As Boolean)
[/CODE]
Enabled - True (1) Timer is ON, False (0) Timer is Off.
[I]Returns[/I]
None
[I]Example[/I]
[CODE=b4x]
LEDController.Set_Timer_Enabled(False)
[/CODE]

[B]Set the timer off after number of ticks[/B]
[CODE=b4x]
LEDController.Set_Timer_Off_After_Ticks(Ticks As ULong)
[/CODE]
Ticks - If timer ticks > ticks, the timer will be disabled. Disable turning timer off by setting Ticks to 0. 
[I]Returns[/I]
None
[I]Example[/I]
[CODE=b4x]
LEDController.Set_Timer_Off_After_Ticks(10)	'Turn timer off after 10 ticks
LEDController.Set_Timer_Off_After_Ticks(0)		'Disable turning timer off after max ticks
[/CODE]

[B]Get the timer state enabled or disabled[/B]
[CODE=b4x]
LEDController.Get_Timer_Enabled As Boolean
[/CODE]
[I]Returns[/I]
True (timer is enabled), False (timer is disabled)
[I]Example[/I]
[CODE=b4x]
Dim LEDController_Timer_Enabled As Boolean = LEDController.Get_Timer_Enabled
[/CODE]

[B]Set LED state to ON or OFF[/B]
[CODE=b4x]
LEDController.Set_State(Index As Int, State As Boolean)
[/CODE]
Index - LED array index.
State - True=ON, False=OFF.
[I]Returns[/I]
None
[I]Example[/I]
[CODE=b4x]
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2
LEDController.Set_State(LEDRED, True)
[/CODE]

[B]Get LED state ON (True) or OFF (False)[/B]
[CODE=b4x]
LEDController.Get_State(Index As Int) As Boolean
[/CODE]
Index - LED array index.
[I]Returns[/I]
True (1) if LED is ON, False (0) if LED is OFF.
[I]Example[/I]
[CODE=b4x]
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2
Dim State As Boolean = LEDController.Get_State(LEDRED)
[/CODE]

[B]Set LED state to ON[/B]
[CODE=b4x]
LEDController.Sub Set_ON(Index As Int)
[/CODE]
Index - LED array index.
[I]Returns[/I]
None
[I]Example[/I]
[CODE=b4x]
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2
LEDController.Set_ON(LEDRED)
[/CODE]

[B]Set LED state to OFF[/B]
[CODE=b4x]
LEDController.Sub Set_OFF(Index As Int)
[/CODE]
Index - LED array index.
[I]Returns[/I]
None
[I]Example[/I]
[CODE=b4x]
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2
LEDController.Set_OFF(LEDRED)
[/CODE]

[B]Set mode to none[/B]
All counters are resetted and LED is turned off.
[CODE=b4x]
LEDController.Set_Mode_None(Index As Int)
[/CODE]
Index - LED array index.
[I]Returns[/I]
None
[I]Example[/I]
[CODE=b4x]
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2
LEDController.Set_Mode_None(LEDRED)
[/CODE]

[B]Set mode to blink[/B]
[CODE=b4x]
LEDController.Sub Set_Mode_Blink(Index As Int, Ticks As Int)
[/CODE]
Index - LED array index.
Ticks - Blink on number of timer ticks. Set to 1 if every timer tick else higher for every N timer ticks.
[I]Returns[/I]
None
[I]Example[/I]
[CODE=b4x]
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2
LEDController.Set_Mode_Blink(LEDRED, 2)
[/CODE]

[B]Set mode to blink for time[/B]
Each timer_tick is calculated using the Timer_Interval.
[CODE=b4x]
LEDController.Set_Blink_For_Time(Index As Int, Time As ULong)
[/CODE]
Time - Time in ms.
[I]Returns[/I]
None
[I]Example[/I]
[CODE=b4x]
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2
LEDController.Blink_For_Time(LEDRED, 4000)
[/CODE]

[B]Set mode to blink for N number of timer ticks (counts)[/B]
[CODE=b4x]
LEDController.Set_Blink_For_Count(Index As Int, Count As ULong)
[/CODE]
Index - LED array index.
Count - Number of timer ticks the LED should blink.
[I]Returns[/I]
None
[I]Example[/I]
[CODE=b4x]
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2
LEDController.Set_Blink_For_Count(LEDRED, 4)
[/CODE]

[B]Set mode to on for time[/B]
Each timer_tick is calculated using the Timer_Interval.
[CODE=b4x]
LEDController.Sub Set_ON_For_Time(Index As Int, Time As ULong)
[/CODE]
Time - Time in ms.
[I]Returns[/I]
None
[I]Example[/I]
[CODE=b4x]
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2
LEDController.Blink_For_Time(LEDRED, 4000)
[/CODE]

[B]Set the blink ticks[/B]
[CODE=b4x]
LEDController.Set_Blink_Ticks(Index As Int, Ticks As Int)
[/CODE]
Index - LED array index.
Ticks - Blink on number of timer ticks. Set to 1 if every timer tick else higher for every N timer ticks.
[I]Returns[/I]
None
[I]Example[/I]
[CODE=b4x]
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2
LEDController.Set_Blink_Ticks(LEDRED, 4)
[/CODE]

[B]Check the state of the LEDS, output to the log (serialline)[/B]
[CODE=b4x]
LEDController.Check_LEDS
[/CODE]
[I]Returns[/I]
None but the output is written to the log.
[I]Example[/I]
[CODE=b4x]
Private Const LEDRED As Int = 0, LEDYellow As Int = 1, LEDGREEN As Int = 2
LEDController.Check_LEDS
[/CODE]

[B]Fields[/B]
[LIST]
[*]Debug - Debug flag to log methods steps and output.
[*]VERSION - Module version number.
[/LIST]

[B]B4R Basic Example[/B]
[CODE=b4x]
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
[/CODE]

[B]Hints[/B]
[LIST]
[*]The number of supported LEDs can be changed in the module LEDController.bas, constant LEDCOUNT and arrays LEDS, LEDPins.
[/LIST]

[B]Licence[/B]
GNU General Public License v3.0.

[B]ToDo[/B]
See file TODO.md.

[B]Changelog[/B]
v1.00 (20210721) - First version.
See file CHANGELOG.md.
