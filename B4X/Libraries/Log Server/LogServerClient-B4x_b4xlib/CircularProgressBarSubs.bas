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
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(LSC As LogServerClient)
	LS = LSC
End Sub

Public Sub Add(ProgressBarName As String,BackGroundColor As Object, ColorFull As Object, ColorEmpty As Object, Location As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = ProgressBarName
	RCT(M_COMMAND) = "CPBAdd"
	RCT(M_MESSAGE) = Location.ToUpperCase
	#If UI
	RCT(M_COLOR) = XUI.PaintOrColorToColor(ColorFull)
	#Else
	RCT(M_COLOR) = ColorFull
	#End if
	RCT(M_PARAMETER) = ""
	#If UI
	RCT(M_PARAMETER2) = XUI.PaintOrColorToColor(ColorEmpty)
	#Else
	RCT(M_PARAMETER2) = ColorEmpty
	#End If
	#If UI
	RCT(M_PARAMETER3) = XUI.PaintOrColorToColor(BackGroundColor)
	#else
	RCT(M_PARAMETER3) = BackGroundColor
	#End If
	CallSub2(LS,"AddToLog",RCT)
End Sub

Public Sub AddTo(ProgressBarName As String,AddToLogArea As String,BackGroundColor As Object, ColorFull As Object, ColorEmpty As Object, Location As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = ProgressBarName
	RCT(M_COMMAND) = "CPBAddTo"
	RCT(M_MESSAGE) = Location.ToUpperCase
	#If UI
	RCT(M_COLOR) = XUI.PaintOrColorToColor(ColorFull)
	#Else
	RCT(M_COLOR) = ColorFull
	#End If
	RCT(M_PARAMETER) = AddToLogArea
	#If UI
	RCT(M_PARAMETER2) = XUI.PaintOrColorToColor(ColorEmpty)
	#Else
	RCT(M_PARAMETER2) = ColorEmpty
	#End If
	#If UI
	RCT(M_PARAMETER3) = XUI.PaintOrColorToColor(BackGroundColor)
	#Else
	RCT(M_PARAMETER3) = BackGroundColor
	#End If
	CallSub2(LS,"AddToLog",RCT)
End Sub

'Remove the specified CircularProgressBar
Public Sub Remove(ProgressBarName As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = ProgressBarName
	RCT(M_COMMAND) = "CPBRemove"
	RCT(M_MESSAGE) = ""
	RCT(M_COLOR) = ""
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

'Update the value of the progress bar
Public Sub Update(ProgressBarName As String, Value As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = ProgressBarName
	RCT(M_COMMAND) = "CPBUpdate"
	RCT(M_COLOR) = ""
	RCT(M_MESSAGE) = Value
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

Public Sub Clear(ProgressBarName As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = ProgressBarName
	RCT(M_COMMAND) = "CPBClear"
	RCT(M_COLOR) = ""
	RCT(M_MESSAGE) = ""
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub