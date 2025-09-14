B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8
@EndOfDesignText@
Sub Class_Globals
	#If UI
	Private XUI As XUI
	#End If
	Private LS As LogServerClient
	
	'Message Structure
	Private Const M_LOGAREA As Int = 0
	Private Const M_COMMAND As Int = 1
	Private Const M_MESSAGE As Int = 2
	Private Const M_COLOR As Int = 3
	Private Const M_PARAMETER As Int = 4
	Private Const M_PARAMETER2 As Int = 5
	Private Const M_PARAMETER3 As Int = 6
	
	'For Array initialization
	Private Const M_MESSAGELENGTH As Int = 7
	
	Public Const LEDMODE_PULSE As String = "pulse"
	Public Const LEDMODE_LATCH As String = "latch"
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(LSC As LogServerClient)
	LS = LSC
End Sub

Public Sub Add(LEDMatrixName As String,Location As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LEDMatrixName
	RCT(M_COMMAND) = "LEDMatrixAdd"
	RCT(M_MESSAGE) = Location.ToUpperCase
	RCT(M_COLOR) = ""
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

Public Sub Add2(LEDMatrixName As String,Location As String,LEDOnColour As Object,LEDOffColour As Object,LEDInsetColour As Object)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LEDMatrixName
	RCT(M_COMMAND) = "LEDMatrixAdd"
	RCT(M_MESSAGE) = Location.ToUpperCase
	#If UI
	RCT(M_COLOR) = XUI.PaintOrColorToColor(LEDInsetColour)
	#Else
	RCT(M_COLOR) = LEDInsetColour
	#End if
	RCT(M_PARAMETER) = ""
	#If UI
	RCT(M_PARAMETER2) = XUI.PaintOrColorToColor(LEDOnColour)
	#Else
	RCT(M_PARAMETER2) = LEDOnColour
	#End if
	#If UI
	RCT(M_PARAMETER3) = XUI.PaintOrColorToColor(LEDOffColour)
	#Else
	RCT(M_PARAMETER3) = LEDOffColour
	#End if
	CallSub2(LS,"AddToLog",RCT)
End Sub

Public Sub AddTo(LEDMatrixName As String,AddToLogArea As String,Location As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LEDMatrixName
	RCT(M_COMMAND) = "LEDMatrixAddTo"
	RCT(M_MESSAGE) = Location.ToUpperCase
	RCT(M_COLOR) = ""
	RCT(M_PARAMETER) = AddToLogArea
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

Public Sub AddTo2(LEDMatrixName As String,AddToLogArea As String,Location As String,LEDOnColour As Object,LEDOffColour As Object,LEDInsetColour As Object)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LEDMatrixName
	RCT(M_COMMAND) = "LEDMatrixAddTo"
	RCT(M_MESSAGE) = Location.ToUpperCase
	#If UI
	RCT(M_COLOR) = XUI.PaintOrColorToColor(LEDInsetColour)
	#Else
	RCT(M_COLOR) = LEDInsetColour
	#End If
	RCT(M_PARAMETER) = AddToLogArea
	#If UI
	RCT(M_PARAMETER2) = XUI.PaintOrColorToColor(LEDOnColour)
	#Else
	RCT(M_PARAMETER2) = LEDOnColour
	#End If
	#If UI
	RCT(M_PARAMETER3) = XUI.PaintOrColorToColor(LEDOffColour)
	#Else
	RCT(M_PARAMETER3) = LEDOffColour
	#End If
	CallSub2(LS,"AddToLog",RCT)
End Sub

'Set the state for a channel (Row)
'The LED's are configured to display a bit value, setting the state to 0 turns off the channel
'A State of 1 turns on the LED representing the Least Significant bit (LSB) (Rightmost LED)
'A State of 128 (Presuming you have 8 LED's) will turn on the LED representing the Most Significant Bit (MSB) (Leftmost LED)
'A State of 255 will turn on all LED's in the channel 
Public Sub SetLEDStates(LEDMatrixName As String,Channel As Int,State As Int)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LEDMatrixName
	RCT(M_COMMAND) = "LEDMatrixSetStates"
	RCT(M_MESSAGE) = ""
	RCT(M_COLOR) = ""
	RCT(M_PARAMETER) = Channel
	RCT(M_PARAMETER2) = State
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

Public Sub setChannelCount(LEDMatrixName As String,ChannelCount As Int)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LEDMatrixName
	RCT(M_COMMAND) = "LEDMatrixSetChannelCount"
	RCT(M_MESSAGE) = ""
	RCT(M_COLOR) = ""
	RCT(M_PARAMETER) = ChannelCount
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

Public Sub setLEDCount(LEDMatrixName As String,LEDCount As Int)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LEDMatrixName
	RCT(M_COMMAND) = "LEDMatrixSetLEDCount"
	RCT(M_MESSAGE) = ""
	RCT(M_COLOR) = ""
	RCT(M_PARAMETER) = LEDCount
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub
'LED index is 0 - no of Leds from Right (LSB) to Left (MSB)
Public Sub SetLEDState(LEDMatrixName As String,Channel As Int,LEDIndex As Int,SetOn As Boolean)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LEDMatrixName
	RCT(M_COMMAND) = "LEDMatrixSetState"
	RCT(M_MESSAGE) = ""
	RCT(M_COLOR) = ""
	RCT(M_PARAMETER) = Channel
	RCT(M_PARAMETER2) = LEDIndex
	RCT(M_PARAMETER3) = SetOn
	CallSub2(LS,"AddToLog",RCT)
End Sub

'Set The LEDMode which can be "Pulse" Or "Latch" One of the LEDMODE Comstants:
'Pulse will show for the set Duration, Latch will display until explicitly turned off
Public Sub SetLEDMode(LEDMatrixName As String,LEDMode As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LEDMatrixName
	RCT(M_COMMAND) = "LEDMatrixSetLEDMode"
	RCT(M_MESSAGE) = ""
	RCT(M_COLOR) = ""
	RCT(M_PARAMETER) = LEDMode.ToLowerCase
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

Public Sub SetLEDOnColour(LEDMatrixName As String,OnColour As Object)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LEDMatrixName
	RCT(M_COMMAND) = "LEDMatrixSetLEDOnColour"
	RCT(M_MESSAGE) = ""
	#If UI
	RCT(M_COLOR) = XUI.PaintOrColorToColor(OnColour)
	#Else
	RCT(M_COLOR) = OnColour
	#End If
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

Public Sub SetLEDOffColour(LEDMatrixName As String,OffColour As Object)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LEDMatrixName
	RCT(M_COMMAND) = "LEDMatrixSetLEDOffColour"
	RCT(M_MESSAGE) = ""
	#If UI
	RCT(M_COLOR) = XUI.PaintOrColorToColor(OffColour)
	#Else
	RCT(M_COLOR) = OffColour
	#end if
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

Public Sub SetPulseDuration(LEDMatrixName As String,Duration As Int)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LEDMatrixName
	RCT(M_COMMAND) = "LEDMatrixSetPulseDur"
	RCT(M_MESSAGE) = ""
	RCT(M_COLOR) = ""
	RCT(M_PARAMETER) = Duration
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

'Set the shortnames to be displayed on the view order MSB to LSB
Public Sub SetShortNames(LEDMatrixName As String,Channel As Int, ShortNames() As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LEDMatrixName
	RCT(M_COMMAND) = "LEDMatrixSetShortNames"
	RCT(M_MESSAGE) = ""
	RCT(M_COLOR) = ""
	RCT(M_PARAMETER) = Channel
	RCT(M_PARAMETER2) = ShortNames
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

'Set the shortnames to be displayed on the view order MSB to LSB
Public Sub SetTooltipText(LEDMatrixName As String,Channel As Int, TooltipText() As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LEDMatrixName
	RCT(M_COMMAND) = "LEDMatrixSetTooltipText"
	RCT(M_MESSAGE) = ""
	RCT(M_COLOR) = ""
	RCT(M_PARAMETER) = Channel
	RCT(M_PARAMETER2) = TooltipText
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

'Remove the specified TimePlot
Public Sub Remove(LEDMatrixName As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LEDMatrixName
	RCT(M_COMMAND) = "LEDMatrixRemove"
	RCT(M_MESSAGE) = ""
	RCT(M_COLOR) = ""
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub