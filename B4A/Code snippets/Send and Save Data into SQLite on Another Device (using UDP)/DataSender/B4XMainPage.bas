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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=DataSender.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private UDPSocket1 As UDPSocket
	Private txtHost As EditText
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, Application.LabelName)
	UDPSocket1.Initialize("UDP", 5000, 8000)
	txtHost.Text = "192.168.50.91"
End Sub

Private Sub BtnSend_Click
	SendData
End Sub

Private Sub SendData
	Dim Names As List = Array As String("Tom", "Jerry", "Spike", "Tyke")
	Dim Name As String = Names.Get( Rnd(0, 4) )
	Dim Age As Int = Rnd(1, 99)
	
	Dim M As Map = CreateMap("Action": "INSERT", "Query": "INSERT INTO Data (Name, Age) VALUES (?, ?)", "Parameters": Array(Name, Age))
	Dim data() As Byte = M.As(JSON).ToCompactString.GetBytes("UTF8")
	Dim Packet As UDPPacket
	Packet.Initialize(data, txtHost.Text, 5000)
	UDPSocket1.Send(Packet)
	xui.MsgboxAsync("Data sent!", "B4X")
End Sub