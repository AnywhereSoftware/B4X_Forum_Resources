B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
'module name: esp32_buttons
'v0.142 (c) Peacemaker
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.
	Private Const BUTTON_PRESS_TIME As UInt = 60
	Private Const SHORT_CLICK_INTERVAL As UInt = 100
	Private Const LONG_CLICK_INTERVAL As UInt = 700
	Private Const PERIODIC_INTERVAL As UInt = 500
	Private Const POLL_INTERVAL As UInt = 20
    
	Type ButtonState (index As Byte, lastState As Boolean, currentState As Boolean, lastDebounceTime As ULong, pressStartTime As ULong, pressDuration As ULong, eventGenerated As Boolean, periodicCounter As UInt, pressEventTime As ULong, lastPeriodicTime As ULong, initialized As Boolean)
    
	Private buttons(2) As ButtonState   'setup exactly needed qty to avoid crash!
	Private pins(2) As Pin    'setup exactly needed qty to avoid crash!
	Private ButtonsIndex As Byte
	Private timer1 As Timer
End Sub

' Initialize module
Public Sub Initialize
	ButtonsIndex = 0
	timer1.Initialize("CheckButtons_Tick", POLL_INTERVAL)
	timer1.Enabled = True
	Log("Buttons initialized")
End Sub

' Add new button
Public Sub AddButton(gpio_num As Byte, pin_mode As Byte)
	pins(ButtonsIndex).Initialize(gpio_num, pin_mode)
	buttons(ButtonsIndex).index = ButtonsIndex
	buttons(ButtonsIndex).lastState = True ' assuming pull-up, so default is HIGH
	buttons(ButtonsIndex).currentState = True
	buttons(ButtonsIndex).lastDebounceTime = 0
	buttons(ButtonsIndex).pressStartTime = 0
	buttons(ButtonsIndex).pressDuration = 0
	buttons(ButtonsIndex).eventGenerated = False
	buttons(ButtonsIndex).periodicCounter = 0
	buttons(ButtonsIndex).pressEventTime = 0
	buttons(ButtonsIndex).lastPeriodicTime = 0
	buttons(ButtonsIndex).initialized = False
    
	' Check initial state
	Dim initialReading As Boolean = pins(ButtonsIndex).DigitalRead
	If pin_mode = pins(ButtonsIndex).MODE_INPUT_PULLUP And initialReading = False Then
		' Button is pressed at initialization
		buttons(ButtonsIndex).currentState = False
		buttons(ButtonsIndex).pressStartTime = Millis
		buttons(ButtonsIndex).pressEventTime = Millis
		Log("Button(", gpio_num, ") INITIAL event: press (0ms)")
	End If
    
	buttons(ButtonsIndex).initialized = True
	Log("Button added with GPIO ", gpio_num)
	ButtonsIndex = ButtonsIndex + 1
End Sub

' Main button check loop
Private Sub CheckButtons_Tick
	For i = 0 To buttons.Length - 1
		If buttons(i).initialized Then
			ProcessButton(buttons(i))
		End If
	Next
End Sub

' Process single button state
Private Sub ProcessButton(btn As ButtonState)
	Dim gpio_num As Byte = pins(btn.index).PinNumber
	Dim reading As Boolean = pins(btn.index).DigitalRead
	Dim currentTime As ULong = Millis
    
	' Debounce logic
	If reading <> btn.lastState Then
		btn.lastDebounceTime = currentTime
	End If
    
	If (currentTime - btn.lastDebounceTime) > BUTTON_PRESS_TIME Then
		' State has actually changed
		If reading <> btn.currentState Then
			btn.currentState = reading
            
			' Button pressed (falling edge for pull-up)
			If btn.currentState = False Then
				btn.pressStartTime = currentTime
				btn.pressEventTime = currentTime 'zero point for events
				btn.pressDuration = 0
				btn.eventGenerated = False
				btn.periodicCounter = 0
				btn.lastPeriodicTime = currentTime
				Log("Button(", gpio_num, ") event: press (0ms)")
			Else
				btn.pressDuration = currentTime - btn.pressStartTime
				Dim timeSincePress As ULong = currentTime - btn.pressEventTime
                
				If btn.pressDuration >= BUTTON_PRESS_TIME And btn.pressDuration >= SHORT_CLICK_INTERVAL And btn.pressDuration < LONG_CLICK_INTERVAL Then
					Log("Button(", gpio_num, ") event: short_click (", timeSincePress, "ms since press)")
				End If
				If btn.pressDuration >= LONG_CLICK_INTERVAL And btn.periodicCounter = 0 Then
					Log("Button(", gpio_num, ") event: long_click (", timeSincePress, "ms since press)")
					If btn.index = 1 Then
						Log("Sleep by second button")
						Main.ESP.DeepSleepWakeUpByPin(0, 0)
					End If
				End If
                
				btn.pressStartTime = 0
				btn.pressEventTime = 0
				btn.eventGenerated = False
				btn.periodicCounter = 0
				btn.lastPeriodicTime = 0
			End If
		End If
        
		' Handle button being held down
		If btn.currentState = False And btn.pressStartTime > 0 Then
			Dim duration As ULong = currentTime - btn.pressStartTime
    
			' Check for periodic events only after triple LONG_CLICK_INTERVAL
			If duration >= 3 * LONG_CLICK_INTERVAL Then
				' Calculate expected time for next periodic event
				Dim expectedTime As ULong = LONG_CLICK_INTERVAL + (btn.periodicCounter * PERIODIC_INTERVAL)
        
				' Only trigger if current time reached expected time
				If currentTime >= expectedTime And (currentTime - btn.lastPeriodicTime) >= (PERIODIC_INTERVAL) Then
					Dim timeSinceLastPeriodic As ULong = currentTime - btn.lastPeriodicTime
					Log("Button(", gpio_num, ") event: periodic (", timeSinceLastPeriodic, "ms since last event)")
					btn.periodicCounter = btn.periodicCounter + 1
					btn.lastPeriodicTime = currentTime
				End If
			End If
		End If
	End If
    
	btn.lastState = reading
End Sub