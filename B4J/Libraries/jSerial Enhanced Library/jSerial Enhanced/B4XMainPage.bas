B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI

	Private Serial As jSerialEnhanced
	Private Ports As List

	Private CmbComList As ComboBox
	Private TxtSendString As B4XView
	Private TxtLog As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True

	Serial.Initialize("Serial")
	Ports.Initialize
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	B4XPages.SetTitle(Me, "jSerial Monitor")

	Ports = Serial.ListPorts
	For Each p As String In Ports
		CmbComList.Items.Add(p)
	Next
	If CmbComList.Items.Size > 0 Then CmbComList.SelectedIndex = CmbComList.Items.Size - 1
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	ExitApplication
	Return True
End Sub

Private Sub BtnRefresh_Click
	CmbComList.Items.Clear

	Ports = Serial.ListPorts
	For Each p As String In Ports
		CmbComList.Items.Add(p)
	Next
	If CmbComList.Items.Size > 0 Then CmbComList.SelectedIndex = CmbComList.Items.Size - 1
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
Private Sub BtnOpen_Click
	Serial.Open(CmbComList.Value, 115200, 8, 1, 0)
End Sub

Private Sub BtnSend_Click
	'Define the text or number that you want to send
	Dim Message As String = TxtSendString.Text
	'Dim Message As String = $"Hello B4X Developers...${Chr(13)}${Chr(10)}The B4X community is great...${Chr(13)}${Chr(10)}"$ 'Adding CR LF for line termination
	Serial.Write(Message.GetBytes("UTF8"))
End Sub

Private Sub BtnClose_Click
	Serial.Close
End Sub

Private Sub BtnInfo_Click
	Dim PortInfo As Map = Serial.GetPortInfo(Serial.GetOpenPortName)

	LogToScreen("Port Name: " & PortInfo.Get("PortName"))
	LogToScreen("Port Description: " & PortInfo.Get("PortDescription"))
	LogToScreen("Descriptive Port: " & PortInfo.Get("DescriptivePort"))
	LogToScreen("VID: " & PortInfo.Get("VID"))
	LogToScreen("PID: " & PortInfo.Get("PID"))
	LogToScreen("Manufacturer: " & PortInfo.Get("Manufacturer"))
	LogToScreen("Serial Number: " & PortInfo.Get("SerialNumber"))
	LogToScreen("Product: " & PortInfo.Get("Product"))
End Sub

Private Sub BtnClearLogs_Click
	TxtSendString.Text = ""
	TxtLog.Text = ""
End Sub

Sub Serial_Opened
	LogToScreen("Port opened successfully")
End Sub

Sub Serial_Closed
	LogToScreen("Port closed successfully")
End Sub

Sub Serial_DataSent(Data() As Byte)
'	LogToScreen("TX: " & BytesToString(Data, 0, Data.Length, "UTF8"))
	DataSentReceived(Data)
End Sub

Sub Serial_LineReceived (Line As String)
'	LogToScreen("Line: " & Line)
'	LogToScreen(Line)
End Sub

Sub Serial_NewData(Data() As Byte)
	LogToScreen($"Successfully Received: ${Data.Length} bytes"$)
	LogToScreen($"Received in B4J: ${BytesToString(Data, 0, Data.Length, "UTF8")}"$)
	DataSentReceived(Data)
End Sub

Sub Serial_Error(Message As String)
	LogToScreen("Error: " & Message)
End Sub

Private Sub DataSentReceived (Data() As Byte)
	Dim s As String = BytesToString(Data, 0, Data.Length, "UTF8")
	Dim Lines() As String = Regex.Split(Chr(13) & Chr(10), s)

	For Each Line As String In Lines
		If Line.Length > 0 Then
			'LogToScreen($"Data: ${Line}"$)
		End If
	Next
End Sub

'DISPLAY MESSAGES IN THE ON-SCREEN LOG AND SYSTEM LOG
Private Sub LogToScreen(Msg As String)
	Log(Msg)
	TxtLog.Text = TxtLog.Text & Msg & CRLF
	TxtLog.SelectionStart = TxtLog.Text.Length
End Sub
