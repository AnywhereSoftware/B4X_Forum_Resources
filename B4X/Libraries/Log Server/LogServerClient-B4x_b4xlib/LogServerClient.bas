B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
#Event: Logserver_StreamReady

Sub Class_Globals
	#If Not(NON_UI)
	Private XUI As XUI
	#End If
	Private Serializator As B4XSerializator
	Private TCP As Socket
	Private AStream As AsyncStreams
	Private mLogLocal As Boolean = False
	Private LogBuffer As List
	Private mDefaultColor As Int
	Private StreamReady As Boolean
	Private DefaultLogArea As String
	Private SwitchStatus As Int
	
	Public Const SWITCHSTATUS_INITIALIZED As Int = -1
	Public Const SWITCHSTATUS_REQUESTED As Int = 0
	Public Const SWITCHSTATUS_SWITCHED As Int = 1
	
	#IF NON_UI
	Public Const INTCOLOR_BLACK As Int = 0xFF000000
	Public Const INTCOLOR_BLUE As Int = 0xFF0000FF
	Public Const INTCOLOR_CYAN As Int = 0xFF00FFFF
	Public Const INTCOLOR_DARKGRAY As Int = 0xFF444444
	Public Const INTCOLOR_GRAY As Int = 0xFF808080
	Public Const INTCOLOR_GREEN As Int = 0xFF00FF00
	Public Const INTCOLOR_LIGHTGRAY As Int = 0xFFD3D3D3
	Public Const INTCOLOR_MAGENTA As Int = 0xFFFF00FF
	Public Const INTCOLOR_RED As Int = 0xFFFF0000
	Public Const INTCOLOR_TRANSPARENT As Int = 0x00000000
	Public Const INTCOLOR_WHITE As Int = 0xFFFFFFFF
	Public Const INTCOLOR_YELLOW As Int = 0xFFFFFF00
	#End If
	
	
	Public Const TEXT_ORIENTATION_HORIZONTAL As String = "HORIZONTAL"
	Public Const TEXT_ORIENTATION_VERTICAL As String  = "VERTICAL"
	Public Const TEXT_ORIENTATION_45_DEGREES As String  = "45 DEGREES"
	Public Const TEXT_ORIENTATION_NONE As String  = "NONE"
	Public Const COLOR_SCHEME_LIGHT As String  = "LIGHT"
	Public Const COLOR_SCHEME_DARK As String  = "DARK"
	
	Public Const ORIENT_HORIZONTAL As String = "HORIZONTAL"
	Public Const ORIENT_VERTICAL As String = "VERTICAL"
	
	Public Const JUSTIFY_LEFT As String = "LEFT"
	Public Const JUSTIFY_CENTER As String = "CENTER"
	Public Const JUSTIFY_RIGHT As String = "RIGHT"
	
	Public Const LOCATION_LEFT As String = "LEFT"
	Public Const LOCATION_RIGHT As String = "RIGHT"
	Public Const LOCATION_TOP As String = "TOP"
	Public Const LOCATION_CENTER As String = "CENTER"
	Public Const LOCATION_BOTTOM As String = "BOTTOM"
	
	
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
	

	Private mIPAddress As String
	
	Private mTag As String
	
	Private Timer1 As Timer
	Private mCallback As Object
	
	Public LEDMatrix As LEDMatrixSubs
	Public CircularProgressBar As CircularProgressBarSubs
	Public TimePlot As TimePlotSubs
	Public HexView As HexViewSubs
	
	Private mVersion As String = "v2.2"
End Sub

'V2.1
'Added IntColors for Non_UI B4j applications
'Removed XUI fom Non_Ui B4j applications

'v2.2
'Added ServertimeStamp
'Added CircularProgressBar
'Added TimePlot
'Added LedMatrix
'Added HexView
'Improved tcp connection process

'Initializes the TCP object, pass 
'the required IPAddr, or -1 for the defaultlocal: 127.0.0.1
'the required port number, or -1 for the default: 49776
Public Sub Initialize(Callback As Object,IPaddr As String,Port As Int)
	mCallback = Callback

	Timer1.Initialize("Timer1",25)
	LogBuffer.Initialize
	LEDMatrix.Initialize(Me)
	CircularProgressBar.Initialize(Me)
	TimePlot.Initialize(Me)
	HexView.Initialize(Me)
	
	SwitchStatus = SWITCHSTATUS_INITIALIZED
	
	'Set the initial default color
	#If NON_UI
	mDefaultColor = INTCOLOR_BLACK
	#Else
	mDefaultColor = XUI.Color_Black
	#End If
	
	mIPAddress = IPaddr
	StartTCP(IPaddr,Port)
End Sub
#Region Communication Subs
Private Sub StartTCP(IPaddr As String,Port As Int)
	If IPaddr = "-1" Then IPaddr = "127.0.0.1"
	If Port = -1 Then Port = 49776
	TCP.Initialize("TCP")
	TCP.Connect(IPaddr,Port,10000)
	
	If SwitchStatus = SWITCHSTATUS_INITIALIZED Then
		Log("Waiting to switch")
	Else IF SwitchStatus = SWITCHSTATUS_REQUESTED Then 
		Log("Waiting for connection")
	End If
End Sub

Public Sub SetIPAddressPort(IPAddress As String, Port As Int)
	Close
	StartTCP(IPAddress,Port)
End Sub


Private Sub TCP_Connected (Successful As Boolean)
	If Successful Then
		If SwitchStatus = SWITCHSTATUS_INITIALIZED Then
			Dim AStream As AsyncStreams
			AStream.InitializePrefix(TCP.InputStream,False,TCP.OutputStream,"astream")
			Return
		End If

		SwitchStatus = SWITCHSTATUS_SWITCHED

		Dim AStream As AsyncStreams
		AStream.InitializePrefix(Null,False,TCP.OutputStream,"astream")

		StreamReady = True
		If LogBuffer.Size > 0 Then Timer1.Enabled = True
		Log("Connected ... ")
		If SubExists(mCallback,"LogServer_StreamReady") Then CallSubDelayed (mCallback,"LogServer_StreamReady")			'Ignore
	Else
		Log("LogServerClient : Please make sure the LogServer is running and the correct IP and Port addresses are entered")
	End If
End Sub

Public Sub IsConnected As Boolean
	Return StreamReady
End Sub

Private Sub astream_NewData (data() As Byte)
	
	Dim RCT() As Object = Serializator.ConvertBytesToObject(data)
	Log("Recd data " & RCT(0))
	If RCT(0) = "switch" Then 
		SwitchStatus = SWITCHSTATUS_REQUESTED
		SetIPAddressPort(mIPAddress,RCT(1))
	End If
End Sub

Private Sub astream_Error
	StreamReady = False
	SwitchStatus = SWITCHSTATUS_INITIALIZED
	Log("astream Error")
End Sub

Private Sub astream_Terminated
	Log("astream Terminated Switched = " & SwitchStatus)
	If SwitchStatus = SWITCHSTATUS_SWITCHED Then
		StreamReady = False
		SwitchStatus = SWITCHSTATUS_INITIALIZED
	End If
	
End Sub

Public Sub Close
	If AStream.IsInitialized Then
		AStream.Close
		StreamReady = False
		TCP.Close
	End If
End Sub



Private Sub Timer1_Tick
	Dim RCT(M_MESSAGELENGTH) As Object
	For i = 0 To Min(50, LogBuffer.size-1)
		If StreamReady = False Then Exit
		RCT = LogBuffer.Get(0)
		LogBuffer.RemoveAt(0)
		AStream.Write(Serializator.ConvertObjectToBytes(RCT))
	Next
	If LogBuffer.Size = 0 Or StreamReady = False Then Timer1.Enabled = False
End Sub
#End Region Communication Subs

#Region Create Log Entries

'Main control sub, start the thread to send messages to server.  
'This should not be called directly.
Private Sub AddToLog(RCT() As Object)
	If StreamReady Then
		If LogBuffer.Size > 0 Then
			LogBuffer.Add(RCT)
			If Timer1.Enabled = False Then Timer1.Enabled = True
		Else
			AStream.Write(Serializator.ConvertObjectToBytes(RCT))
		End If
		If mLogLocal And RCT(M_COMMAND) = "" Then
			Log(RCT(M_MESSAGE))
		End If
	Else
		If RCT(M_COMMAND) = "" Then Log(RCT(M_MESSAGE))
		LogBuffer.Add(RCT)
	End If
End Sub
#End Region Create Log Entries

#Region Log / LogColor

'Send a message to the default LogArea
Public Sub Message(Msg As String)
	MessageColorTo("", Msg, mDefaultColor)
End Sub

'Send a message to the deafult LogArea with Color
Public Sub MessageColor(Msg As String, clr As Object)
	MessageColorTo(DefaultLogArea,Msg, clr)
End Sub

'Send a message to the specified LogArea
Public Sub MessageTo(LogArea As String,Msg As String)
	MessageColorTo(LogArea, Msg, mDefaultColor)
End Sub

'Send a message to the specified LogArea with Color
Public Sub MessageColorTo(LogArea As String,Msg As String, clr As Object)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LogArea
	RCT(M_COMMAND) = ""
	#IF NOT(Non_UI)
	RCT(M_COLOR) = XUI.PaintOrColorToColor(clr)
	#Else
	RCT(M_COLOR) = clr
	#End If
	RCT(M_MESSAGE) = mTag & Msg
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	AddToLog(RCT)
End Sub

#End Region Log / LogColor


#Region LogList

'Send a list or array of Objects to the default log area
Public Sub List(Li As List, Orientation As String)
	ListColorTo(DefaultLogArea, Li, Orientation, mDefaultColor)
End Sub

'Send a list or array of Objects to the Specified log area
Public Sub ListTo(LogArea As String, Li As List, Orientation As String)
	ListColorTo(LogArea, Li, Orientation, mDefaultColor)
End Sub

'Send a list or array of Objects to the default log area
Public Sub ListColor(Li As List, Orientation As String, clr As Object)
	ListColorTo(DefaultLogArea, Li, Orientation, clr)
End Sub

'Send a list or array of Objects to the Specified log area with the specified color
Public Sub ListColorTo(LogArea As String ,Li As List, Orientation As String, clr As Object)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LogArea
	RCT(M_COMMAND) = ""
	#IF NOT(Non_UI)
	RCT(M_COLOR) = XUI.PaintOrColorToColor(clr)
		#Else
	RCT(M_COLOR) = clr
	#End If
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	Dim SB As StringBuilder
	Dim Remove As Int
	SB.Initialize
	SB.Append(mTag)
	For Each S As String In Li
		SB.Append(S)
		If Orientation = ORIENT_VERTICAL Then
			SB.Append(CRLF)
			Remove = 1
		Else
			SB.Append(", ")
			Remove = 2
		End If
	Next
	SB.Remove(SB.Length - Remove, SB.Length)
	RCT(M_MESSAGE) = SB.ToString
	AddToLog(RCT)
End Sub

#End Region Log List

#Region Log Columns
'Send a list or array of Objects to the Specified log area with the specified color 
'with each element Left, Right or Center justified in the specified number of spaces
Public Sub ColumnsColorTo(LogArea As String, Li As List, NoSpaces As Int, Justify As String, Header As Boolean, Clr As Object)
	Dim OutList As List
	OutList.Initialize
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LogArea
	RCT(M_COMMAND) = ""
	#IF NOT(Non_UI)
	RCT(M_COLOR) = XUI.PaintOrColorToColor(Clr)
	#Else
	RCT(M_COLOR) = clr
	#End If
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	Dim SB As StringBuilder
	SB.Initialize
	If Header And mTag <> "" Then SB.Append(mTag & CRLF)
	For Each S As String In Li
		SB.Append(SpaceAligned(S, NoSpaces, Justify))
	Next
	RCT(M_MESSAGE) = SB.ToString
	AddToLog(RCT)
End Sub

'Send a list or array of Objects to the default log area with the specified color 
'with each element Left, Right or Center  justified in the specified number of spaces
Public Sub ColumnsColor(LI As List,NoSpaces As Int, Justify As String, Header As Boolean,Clr As Object)
	ColumnsColorTo(DefaultLogArea, LI, NoSpaces,Justify, Header, Clr)
End Sub

'Send a list or array of Objects to the Specified log area with the default color 
'with each element Left, Right or Center  justified in the specified number of spaces
Public Sub ColumnsTo(LogArea As String,LI As List, NoSpaces As Int, Justify As String, Header As Boolean)
	ColumnsColorTo(LogArea,LI, NoSpaces, Justify, Header, mDefaultColor)
End Sub

'Send a list or array of Objects to the default log area with the default color 
'with each element Left, Right or Center  justified in the specified number of spaces
Public Sub Columns(LI As List, NoSpaces As Int, Justify As String, Header As Boolean)
	ColumnsColorTo(DefaultLogArea, LI, NoSpaces, Justify, Header, mDefaultColor)
End Sub

#End Region Log Columns

#Region timeStamp
'Send A Timestamp (DateTime.Now) to the default log area in the default color
Public Sub TimeStamp
	TimeStampMessageColorTo(DefaultLogArea, "", mDefaultColor)
End Sub

'Send A Timestamp (DateTime.Now) to the default log area in the specified color
Public Sub TimeStampColor(clr As Object)
	TimeStampMessageColorTo(DefaultLogArea, "", clr)
End Sub

'Send A Timestamp (DateTime.Now) to the specified log area
Public Sub TimeStampTo(LogArea As String)
	TimeStampMessageColorTo(LogArea, "", mDefaultColor)
End Sub

'Send A Timestamp (DateTime.Now) to the specified log area in the specified color
Public Sub TimeStampColorTo(LogArea As String,clr As Object)
	TimeStampMessageColorTo(LogArea, "", clr)
End Sub

'Send A Timestamp (DateTime.Now) and message to the default log area in the default color
Public Sub TimeStampMessage(Msg As String)
	TimeStampMessageColorTo(DefaultLogArea, Msg, mDefaultColor)
End Sub

'Send A Timestamp (DateTime.Now) and message to the default log area in the specified color
Public Sub TimeStampMessageColor(Msg As String, clr As Object)
	TimeStampMessageColorTo(DefaultLogArea,Msg,clr)
End Sub

'Send A Timestamp (DateTime.Now) and message to the specified log area
Public Sub TimeStampMessageTo(LogArea As String, Msg As String)
	TimeStampMessageColorTo(LogArea, Msg, mDefaultColor)
End Sub

'Send A Timestamp (DateTime.Now) and message to the specified log area in the specified color
Public Sub TimeStampMessageColorTo(LogArea As String,Msg As String,clr As Object)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LogArea
	RCT(M_COMMAND) = "TimeStamp"
	#If UI
	RCT(M_COLOR) = XUI.PaintOrColorToColor(clr)
	#Else
	RCT(M_COLOR) = clr
	#End If
	RCT(M_MESSAGE) = DateTime.Now
	RCT(M_PARAMETER) = " " & mTag & Msg
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	AddToLog(RCT)
End Sub

'Send A ServerTimeStamp (DateTime.Now) to the default log area in the default color
Public Sub ServerTimeStamp
	ServerTimeStampMessageColorTo(DefaultLogArea, "", mDefaultColor)
End Sub

'Send A ServerTimeStamp (DateTime.Now) to the default log area in the specified color
Public Sub ServerTimeStampColor(clr As Object)
	ServerTimeStampMessageColorTo(DefaultLogArea, "", clr)
End Sub

'Send A ServerTimeStamp (DateTime.Now) to the specified log area
Public Sub ServerTimeStampTo(LogArea As String)
	ServerTimeStampMessageColorTo(LogArea, "", mDefaultColor)
End Sub

'Send A ServerTimeStamp (DateTime.Now) to the specified log area in the specified color
Public Sub ServerTimeStampColorTo(LogArea As String,clr As Object)
	ServerTimeStampMessageColorTo(LogArea, "", clr)
End Sub

'Send A ServerTimeStamp (DateTime.Now) and message to the default log area in the default color
Public Sub ServerTimeStampMessage(Msg As String)
	ServerTimeStampMessageColorTo(DefaultLogArea, Msg, mDefaultColor)
End Sub

'Send A ServerTimeStamp (DateTime.Now) and message to the default log area in the specified color
Public Sub ServerTimeStampMessageColor(Msg As String, clr As Object)
	ServerTimeStampMessageColorTo(DefaultLogArea,Msg,clr)
End Sub

'Send A ServerTimeStamp (DateTime.Now) and message to the specified log area
Public Sub ServerTimeStampMessageTo(LogArea As String, Msg As String)
	ServerTimeStampMessageColorTo(LogArea, Msg, mDefaultColor)
End Sub

'Send A ServerTimeStamp (DateTime.Now) and message to the specified log area in the specified color
Public Sub ServerTimeStampMessageColorTo(LogArea As String,Msg As String,clr As Object)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LogArea
	RCT(M_COMMAND) = "ServerTimeStamp"
	#IF NOT(Non_UI)
	RCT(M_COLOR) = XUI.PaintOrColorToColor(clr)
	#Else
	RCT(M_COLOR) = clr
	#End If
	RCT(M_MESSAGE) = ""
	RCT(M_PARAMETER) = " " & mTag & Msg
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	AddToLog(RCT)
End Sub

#end Region TimeStamp
#Region Spaced Subs
'Send a formatted message to the Default logarea with SpcCount spaces in between
Public Sub Spaced(LI As List,SpcCount As Int)
	SpacedColorTo(DefaultLogArea,LI,SpcCount,mDefaultColor)
End Sub

'Send a formatted message to the specified logarea with SpcCount spaces in between
Public Sub SpacedTo(LogArea As String, LI As List,SpcCount As Int)
	SpacedColorTo(LogArea,LI,SpcCount,mDefaultColor)
End Sub

'Send a formatted message to the default logarea with SpcCount spaces in between in the specified color
Public Sub SpacedColor(LI As List,SpcCount As Int,clr As Object)
	SpacedColorTo(DefaultLogArea,LI,SpcCount,clr)
End Sub

'Send a formated message to the specified logarea with SpcCount spaces in between and the specified color
Public Sub SpacedColorTo(LogArea As String,LI As List,SpcCount As Int,clr As Object)
	Dim RCT(M_MESSAGELENGTH) As Object
	
	RCT(M_LOGAREA) = LogArea
	RCT(M_COMMAND) = ""
	#If UI
	RCT(M_COLOR) = XUI.PaintOrColorToColor(clr)
	#Else
	RCT(M_COLOR) = clr
	#End If
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	Dim SB As StringBuilder
	SB.Initialize
	SB.Append(mTag)
	For Each Str As String In LI
		SB.Append(Str)
		For i = 0 To SpcCount - 1
			SB.Append(" ")
		Next
	Next
	RCT(M_MESSAGE) = SB.ToString.Trim
	AddToLog(RCT)
End Sub

#End Region Spaced Subs

#End Region

#Region Commands
'NOTE: Fields cannot Null, so color needs to be set!

'Add a new logarea relative to the window contents.
'Location on of LOCATION_CENTER, LOCATION_TOP , LOCATION_BOTTOM , LOCATION_LEFT or LOCATION_RIGHT 
'All areas are autosized after the add.
Public Sub AddLogArea(LogArea As String,Location As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	
	RCT(M_LOGAREA) = LogArea
	DefaultLogArea = LogArea
	RCT(M_COMMAND) = "AddLogArea"
	RCT(M_MESSAGE) = Location.ToUpperCase
	RCT(M_COLOR) = mDefaultColor
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	AddToLog(RCT)
End Sub

'Add a new log area relative to an existing one.
'Location on of LOCATION_CENTER, LOCATION_TOP , LOCATION_BOTTOM , LOCATION_LEFT or LOCATION_RIGHT 
'All areas are autosized after the add.
Public Sub AddLogAreaTo(NewLogArea As String,AddTo As String,Location As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = NewLogArea
	DefaultLogArea = NewLogArea
	RCT(M_COMMAND) = "AddLogAreaTo"
	RCT(M_MESSAGE) = Location.ToUpperCase
	RCT(M_COLOR) = mDefaultColor
	RCT(M_PARAMETER) = AddTo
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	AddToLog(RCT)
End Sub

'Make the specified log area the default
Public Sub SwitchTo(LogArea As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LogArea
	DefaultLogArea = LogArea
	RCT(M_COMMAND) = "SwitchToLogArea"
	RCT(M_MESSAGE) = ""
	RCT(M_COLOR) = mDefaultColor
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	AddToLog(RCT)
End Sub

'Remove the specified logarea, it is not possible to remove the main area.
Public Sub RemoveLogArea(LogArea As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LogArea
	RCT(M_COMMAND) = "RemoveLogArea"
	RCT(M_MESSAGE) = ""
	RCT(M_COLOR) = mDefaultColor
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	AddToLog(RCT)
End Sub

'Clears the current log area
Public Sub Clear
	Dim RCT(M_MESSAGELENGTH) As Object
	
	RCT(M_LOGAREA) = DefaultLogArea
	RCT(M_COMMAND) = "ClearLogArea"
	RCT(M_MESSAGE) = ""
	RCT(M_COLOR) = mDefaultColor
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	AddToLog(RCT)
End Sub


'Clears All log area
Public Sub ClearAll
	Dim RCT(M_MESSAGELENGTH) As Object
	
	RCT(M_LOGAREA) = DefaultLogArea
	RCT(M_COMMAND) = "ClearAll"
	RCT(M_MESSAGE) = ""
	RCT(M_COLOR) = mDefaultColor
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	AddToLog(RCT)
End Sub

'Clear a specific log
Public Sub ClearLogArea(LogArea As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	
	RCT(M_LOGAREA) = LogArea
	RCT(M_COMMAND) = "ClearLogArea"
	RCT(M_MESSAGE) = ""
	RCT(M_COLOR) = mDefaultColor
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	AddToLog(RCT)
End Sub

'Start logging to a file for the spcified logarea
'don't forget to set the archive folder on the server app (in Edit/UserOptions)
Public Sub FileStart(LogArea As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LogArea
	RCT(M_COMMAND) = "File"
	RCT(M_MESSAGE) = "StartFile"
	RCT(M_COLOR) = mDefaultColor
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	AddToLog(RCT)
End Sub

'Stop wrting to file for the specified logarea
Public Sub FileStop(LogArea As String)
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = LogArea
	RCT(M_COMMAND) = "File"
	RCT(M_MESSAGE) = "StopFile"
	RCT(M_COLOR) = mDefaultColor
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	AddToLog(RCT)
End Sub

'Stop writing to files for all logareas
Public Sub FileStopAll
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = DefaultLogArea
	RCT(M_COMMAND) = "File"
	RCT(M_MESSAGE) = "StopAllFiles"
	RCT(M_COLOR) = mDefaultColor
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	AddToLog(RCT)
End Sub

'Remove All Log Areas
Public Sub Reset
	Dim RCT(M_MESSAGELENGTH) As Object
	RCT(M_LOGAREA) = DefaultLogArea
	RCT(M_COMMAND) = "Reset"
	RCT(M_MESSAGE) = ""
	RCT(M_COLOR) = mDefaultColor
	RCT(M_PARAMETER) = ""
	RCT(M_PARAMETER2) = ""
	RCT(M_PARAMETER3) = ""
	AddToLog(RCT)
End Sub

#End Region Commands

#Region Utils

Public Sub Version As String
	Return mVersion
End Sub

'Returns A String Left, Center or Right justified in the specified number of spaces.
'NOTE: this does not send a message, just returns a string that you can place in a message.
Public Sub SpaceAligned(Text As String, NoSpaces As Int,Justify As String) As String
	Dim SB As StringBuilder
	SB.Initialize
	Dim LeftSpaces,RightSpaces As Int
	If Justify = JUSTIFY_CENTER Then
		LeftSpaces = (NoSpaces - Text.Length) / 2
		RightSpaces = NoSpaces - Text.Length - LeftSpaces
		For i = 0 To LeftSpaces - 1
			SB.Append(" ")
		Next
		SB.Append(Text)
		For i = 0 To RightSpaces - 1
			SB.Append(" ")
		Next
	Else
		If Justify = JUSTIFY_LEFT Then SB.Append(Text)
	
		For i = Text.Length To NoSpaces - 1
			SB.Append(" ")
		Next
	
		If Justify = JUSTIFY_RIGHT Then SB.Append(Text)
	End If
		
	Return SB.ToString
End Sub


#End Region Utils

#Region Local Config
'Get / Set the log to local status
Public Sub setLogLocal(LogLocal As Boolean)
	mLogLocal = LogLocal
End Sub

Public Sub getLogLocal As Boolean
	Return mLogLocal
End Sub

'Set a tag to be prefixed to messages (postfixed to the timestamp)
Public Sub SetTag(Tag As String)
	mTag = Tag
End Sub

'Set the default color
Public Sub setDefaultColor(clr As Object)
	#IF UI
	mDefaultColor = XUI.PaintOrColorToColor(clr)
	#Else
	mDefaultColor  = clr
	#End If
End Sub
#End Region Local Config