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

Public Sub Add(HexViewName As String, Location As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = HexViewName
	RCT(M_COMMAND) = "HexViewAdd"
	RCT(M_MESSAGE) = Location.ToUpperCase
	RCT(M_COLOR) = ""
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

Public Sub AddTo(HexViewName As String,AddToLogArea As String, Location As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = HexViewName
	RCT(M_COMMAND) = "HexViewAddTo"
	RCT(M_MESSAGE) = Location.ToUpperCase
	RCT(M_COLOR) = ""
	RCT(M_PARAMETER) = AddToLogArea
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

'Remove the specified HexView
Public Sub Remove(ProgressBarName As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = ProgressBarName
	RCT(M_COMMAND) = "HexViewRemove"
	RCT(M_MESSAGE) = ""
	RCT(M_COLOR) = ""
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

'Send data to the HexView
Public Sub AddData(HexViewName As String, Data() As Byte)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = HexViewName
	RCT(M_COMMAND) = "HexViewAddData"
	RCT(M_COLOR) = ""
	RCT(M_MESSAGE) = Data
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

'Clear the HexView
Public Sub Clear(HexViewName As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = HexViewName
	RCT(M_COMMAND) = "HexViewClear"
	RCT(M_COLOR) = ""
	RCT(M_MESSAGE) = ""
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

Public Sub HighlightColors(HexViewName As String, HighlightColor As Object, FollowingHighlightColor As Object)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = HexViewName
	RCT(M_COMMAND) = "HexViewHLC"
	#If UI
	RCT(M_COLOR) = XUI.PaintOrColorToColor(HighlightColor)
	#else
	RCT(M_COLOR) = HighlightColor
	#End If
	RCT(M_MESSAGE) = ""
	#If UI
	RCT(M_PARAMETER) = XUI.PaintOrColorToColor(FollowingHighlightColor)
	#Else
	RCT(M_PARAMETER) = FollowingHighlightColor
	#End if
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

Public Sub FindHighlightColors(HexViewName As String, HighlightColor As Object, FollowingHighlightColor As Object)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = HexViewName
	RCT(M_COMMAND) = "HexViewFHLC"
	#If UI
	RCT(M_COLOR) = XUI.PaintOrColorToColor(HighlightColor)
	#Else
	RCT(M_COLOR) = HighlightColor
	#end If
	RCT(M_MESSAGE) = ""
	#If UI
	RCT(M_PARAMETER) = XUI.PaintOrColorToColor(FollowingHighlightColor)
	#Else
	RCT(M_PARAMETER) = FollowingHighlightColor
	#End if
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

Public Sub SelectedHighlightColors(HexViewName As String, HighlightColor As Object, FollowingHighlightColor As Object)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = HexViewName
	RCT(M_COMMAND) = "HexViewSHLC"
	#If UI
	RCT(M_COLOR) = XUI.PaintOrColorToColor(HighlightColor)
	#Else
	RCT(M_COLOR) = HighlightColor
	#End If
	RCT(M_MESSAGE) = ""
	#If UI
	RCT(M_PARAMETER) = XUI.PaintOrColorToColor(FollowingHighlightColor)
	#Else
	RCT(M_PARAMETER) = FollowingHighlightColor
	#End if
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

Public Sub HeadingColors(HexViewName As String, BackgroundColor As Object, TextColor As Object)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = HexViewName
	RCT(M_COMMAND) = "HexViewHeadColors"
	#If UI
	RCT(M_COLOR) = XUI.PaintOrColorToColor(BackgroundColor)
	#Else
	RCT(M_COLOR) = BackgroundColor
	#end If
	RCT(M_MESSAGE) = ""
	#If UI
	RCT(M_PARAMETER) = XUI.PaintOrColorToColor(TextColor)
	#Else
	RCT(M_PARAMETER) = TextColor
	#End If
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

Public Sub TextAreaColors(HexViewName As String, BackgroundColor As Object, TextColor As Object)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = HexViewName
	RCT(M_COMMAND) = "HexViewAreaColors"
	#If UI
	RCT(M_COLOR) = XUI.PaintOrColorToColor(BackgroundColor)
	#Else
	RCT(M_COLOR) = BackgroundColor
	#End If
	RCT(M_MESSAGE) = ""
	#If UI
	RCT(M_PARAMETER) = XUI.PaintOrColorToColor(TextColor)
	#Else
	RCT(M_PARAMETER) = TextColor
	#End If
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

Public Sub SetShowHeader(HexViewName As String, Header As Boolean)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = HexViewName
	RCT(M_COMMAND) = "HexViewShowHeader"
	RCT(M_COLOR) = ""
	RCT(M_MESSAGE) = ""
	RCT(M_PARAMETER) = Header
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub

Public Sub SetMaxResults(HexViewName As String, PageResults As Int)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = HexViewName
	RCT(M_COMMAND) = "HexViewMaxResults"
	RCT(M_COLOR) = ""
	RCT(M_MESSAGE) = ""
	RCT(M_PARAMETER) = PageResults
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	CallSub2(LS,"AddToLog",RCT)
End Sub