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
	
	Public Const TEXT_ORIENTATION_HORIZONTAL As String = "HORIZONTAL"
	Public Const TEXT_ORIENTATION_VERTICAL As String  = "VERTICAL"
	Public Const TEXT_ORIENTATION_45_DEGREES As String  = "45 DEGREES"
	Public Const TEXT_ORIENTATION_NONE As String  = "NONE"
	Public Const COLOR_SCHEME_LIGHT As String  = "LIGHT"
	Public Const COLOR_SCHEME_DARK As String  = "DARK"
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(LSC As LogServerClient)
	LS = LSC
End Sub

'Plots to Show - The number of plots to display on the graph
'XScaleTextOrientation - one of the TEXTORIENTATION constants :HORIZONTAL|VERTICAL|45 DEGREES|NONE
'Color Scheme - one of the COLOR_SCHEME constants LIGHT|DARK
Public Sub Add(TimePlotName As String,PlotsToShow As Int, XScaleTextOrientation As String, ColorScheme As String, Location As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = TimePlotName
	RCT(M_COMMAND) = "TimePlotAdd"
	RCT(M_MESSAGE) = Location.ToUpperCase
	RCT(M_COLOR) = PlotsToShow
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = XScaleTextOrientation
	RCT(M_PARAMETER3) = ColorScheme
	CallSub2(LS,"AddToLog",RCT)
End Sub

'Plots to Show - The number of plots to display on the graph
'XScaleTextOrientation - one of the TEXTORIENTATION constants :HORIZONTAL|VERTICAL|45 DEGREES|NONE
'Color Scheme - one of the COLOR_SCHEME constants LIGHT|DARK
Public Sub AddTo(TimePlotName As String,AddToLogArea As String,PlotsToShow As Int, XScaleTextOrientation As String, ColorScheme As String, Location As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = TimePlotName
	RCT(M_COMMAND) = "TimePlotAddTo"
	RCT(M_MESSAGE) = Location.ToUpperCase
	RCT(M_COLOR) = PlotsToShow
	RCT(M_PARAMETER) = AddToLogArea
	RCT(M_PARAMETER2) = XScaleTextOrientation
	RCT(M_PARAMETER3) = ColorScheme
	CallSub2(LS,"AddToLog",RCT)
End Sub

Public Sub AddLine(TimePlotName As String, LineName As String, Linecolor As Object)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = TimePlotName
	RCT(M_COMMAND) = "TimePlotAddLine"
	RCT(M_MESSAGE) = ""
	RCT(M_COLOR) = ""
	RCT(M_PARAMETER) = LineName
	#If UI
	RCT(M_PARAMETER2) = XUI.PaintOrColorToColor(Linecolor)
	#Else
	RCT(M_PARAMETER2) = Linecolor
	#End if
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

'Points an array of doubles with values between 0 and 100
Public Sub AddData(TimePlotName As String, Points() As Double)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = TimePlotName
	RCT(M_COMMAND) = "TimePlotUpdate"
	RCT(M_COLOR) = ""
	RCT(M_MESSAGE) = ""
	
	Dim L As List
	L.Initialize
	L.AddAll(Points)
	
	RCT(M_PARAMETER) = L
	RCT(M_PARAMETER2) = DateTime.Now
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

'Next message sent will reset the start time.
Public Sub ResetTime(TimePlotName As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = TimePlotName
	RCT(M_COMMAND) = "TimePlotResetTime"
	RCT(M_MESSAGE) = ""
	RCT(M_COLOR) = ""
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

'Remove the specified TimePlot
Public Sub Remove(TimePlotName As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = TimePlotName
	RCT(M_COMMAND) = "TimePlotRemove"
	RCT(M_MESSAGE) = ""
	RCT(M_COLOR) = ""
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub