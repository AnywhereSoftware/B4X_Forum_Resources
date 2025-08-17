B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.13
@EndOfDesignText@
#Event: StateChanged (Pin As Int, Level As Int)
'Thin wrapper of <link>lgpio library|https://abyz.me.uk/lg/py_lgpio.html</link>
Sub Class_Globals
	Public sbc As PyWrapper
	Public gpiochip As PyWrapper
	Private Py As PyBridge
	Private mEventName As String
	Private mCallback As Object
	Public SET_ACTIVE_LOW, SET_OPEN_DRAIN, SET_OPEN_SOURCE, SET_PULL_UP, SET_PULL_DOWN, SET_PULL_NONE As PyWrapper
	Public EDGE_RISING, EDGE_FALLING, EDGE_BOTH As PyWrapper
End Sub

Public Sub Initialize (Bridge As PyBridge, Callback As Object, EventName As String)
	Py = Bridge
	sbc = Py.ImportModule("lgpio")
	mCallback = Callback
	mEventName = EventName
	CreateReadCallback
	SET_ACTIVE_LOW = sbc.GetField("SET_ACTIVE_LOW")
	SET_OPEN_DRAIN = sbc.GetField("SET_OPEN_DRAIN")
	SET_OPEN_SOURCE = sbc.GetField("SET_OPEN_SOURCE")
	SET_PULL_UP = sbc.GetField("SET_PULL_UP")
	SET_PULL_DOWN = sbc.GetField("SET_PULL_DOWN")
	SET_PULL_NONE = sbc.GetField("SET_PULL_NONE")
	EDGE_RISING = sbc.GetField("RISING_EDGE")
	EDGE_FALLING = sbc.GetField("FALLING_EDGE")
	EDGE_BOTH = sbc.GetField("BOTH_EDGES")
End Sub

'Opens a device (usually 0). Returns the device handle, an int number. You can fetch the result and check whether it is non-negative to test whether it succeed.
Public Sub Open(Device As Int) As PyWrapper
	gpiochip = sbc.Run("gpiochip_open").Arg(Device)
	Return gpiochip
End Sub

Private Sub CreateReadCallback
	Py.RunNoArgsCode($"
def read_callback(chip, gpio, level, timestamp):
	bridge_instance.raise_event("ReadCallback", {"pin": gpio, "level": level, "timestamp": timestamp})
"$)
	Py.SetEventMapping("ReadCallback", Me, "Py")
End Sub

Private Sub Py_ReadCallback (Args As Map)
	CallSub3(mCallback, mEventName & "_StateChanged", Args.Get("pin"), Args.Get("level"))
End Sub

'Subscribes for StateChanged events. Make sure to first call ClaimAlert on the pin.
Private Sub Subscribe (Pin As Int, EdgeFlags As Object)
	sbc.Run("callback").Arg(gpiochip).Arg(Pin).Arg(EdgeFlags) _
		.Arg(Py.GetMember("read_callback"))
End Sub

'Closes the device. Failing to close the device can lead to the device remained locked.
Public Sub Close
	sbc.Run("gpiochip_close").Arg(gpiochip)
End Sub
'Claims pin for output. Returns 0 if successful (value not fetched automatically).
Public Sub ClaimOutput(pin As Int) As PyWrapper
	Return sbc.Run("gpio_claim_output").Arg(gpiochip).Arg(pin)
End Sub
'Claims pin for input. Returns 0 if successful (value not fetched automatically).
'SetFlags - one of the SET constants.
Public Sub ClaimInput(Pin As Int, SetFlags As Object) As PyWrapper
	Return sbc.Run("gpio_claim_input").Arg(gpiochip).Arg(Pin).Arg(SetFlags)
End Sub
'Claims pin for alerts on level changes. Returns 0 if successful (value not fetched automatically).
'EdgeFlags - One of the EDGE constants.
'SetFlags - One of the SET constants.
Public Sub ClaimAlert(Pin As Int, EdgeFlags As Object, SetFlags As Object) As PyWrapper
	Dim res As PyWrapper = sbc.Run("gpio_claim_alert").Arg(gpiochip).Arg(Pin).Arg(EdgeFlags).Arg(SetFlags)
	Subscribe(Pin, EdgeFlags)
	Return res
End Sub

'Sets the pin value. Pin should be claimed for output first.
'Level: 0 for low, 1 for high.
Public Sub Write (pin As Int, Level As Object) As PyWrapper
	Return sbc.Run("gpio_write").Arg(gpiochip).Arg(pin).Arg(Level)
End Sub

'Reads the pin value. Returns 0 for low or 1 for high (value not fetched automatically).
Public Sub Read (pin As Int) As PyWrapper
	Return sbc.Run("gpio_read").Arg(gpiochip).Arg(pin)
End Sub

'Sets the debounce time.
Public Sub DebounceMicros(Pin As Int, Debounce As Long) As PyWrapper
	Return sbc.Run("gpio_set_debounce_micros").Arg(gpiochip).Arg(Pin).Arg(Debounce)
End Sub