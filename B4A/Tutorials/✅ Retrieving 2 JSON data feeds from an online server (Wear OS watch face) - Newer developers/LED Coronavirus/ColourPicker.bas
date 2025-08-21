B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=7.3
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: True
	#IncludeTitle: False
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

	Public SetColour As Int
	Private ColPicker As ColorPicker
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Initialise HoloColorPicker
	ColPicker.Initialize("ColorPalette")
	Activity.AddView(ColPicker, 0dip + 7%x, 0dip + 7%y, Activity.Width - 14%x, Activity.Width - 14%y)
End Sub

Sub Activity_Resume
	Select SetColour
		Case 1 'LED Color
			ColPicker.Color = Colors.RGB(LEDCorona.KVS2.Get("LEDR"), LEDCorona.KVS2.Get("LEDG"), LEDCorona.KVS2.Get("LEDB"))
			ColPicker.OldCenterColor = Colors.RGB(LEDCorona.KVS2.Get("LEDR"), LEDCorona.KVS2.Get("LEDG"), LEDCorona.KVS2.Get("LEDB"))		
		Case 2 'Border Color
			ColPicker.Color = Colors.RGB(LEDCorona.KVS2.Get("BordR"), LEDCorona.KVS2.Get("BordG"), LEDCorona.KVS2.Get("BordB"))
			ColPicker.OldCenterColor = Colors.RGB(LEDCorona.KVS2.Get("BordR"), LEDCorona.KVS2.Get("BordG"), LEDCorona.KVS2.Get("BordB"))
	End Select
End Sub

Sub Activity_Pause (UserClosed As Boolean)
End Sub

Sub Activity_PermissionResult(Permission As String, Result As Boolean)
End Sub

Sub ColorPalette_onColorChanged(color As Int)
'	Dim ARGB() As Int =  GetARGB(color)
'	Log($"A=${ARGB(0)} R=${ARGB(1)} G=${ARGB(2)} B=${ARGB(3)}"$)
End Sub

Sub ColorPalette_onColorSelected(color As Int)
	Dim ARGB() As Int =  GetARGB(color)
	Log($"A=${ARGB(0)} R=${ARGB(1)} G=${ARGB(2)} B=${ARGB(3)}"$)

	Select SetColour
		Case 1 'LED Color
			LEDCorona.KVS2.Put("LEDR", ARGB(1))
			LEDCorona.KVS2.Put("LEDG", ARGB(2))
			LEDCorona.KVS2.Put("LEDB", ARGB(3))		
		Case 2 'Border Color
			LEDCorona.KVS2.Put("BordR", ARGB(1))
			LEDCorona.KVS2.Put("BordG", ARGB(2))
			LEDCorona.KVS2.Put("BordB", ARGB(3))
	End Select
End Sub

'RETRIEVE ARGB SEPERATE VALUES
Sub GetARGB(Color As Int) As Int()
	Dim RES(4) As Int
		RES(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
		RES(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
		RES(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
		RES(3) = Bit.And(Color, 0xff)
	Return RES
End Sub
