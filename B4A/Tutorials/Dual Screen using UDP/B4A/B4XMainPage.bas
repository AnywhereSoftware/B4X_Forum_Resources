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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private UDPSocket1 As UDPSocket
	Private txtConnect As B4XView
	Private txtData As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("Secondary")
	B4XPages.SetTitle(Me, "Secondary")
	txtConnect.Text = "192.168.50.91"
	txtData.Text = "Hello from Secondary"
	UDPSocket1.Initialize("UDP", 5000, 8000)
End Sub

Private Sub BtnSend_Click
	Dim data() As Byte
	data = txtData.Text.GetBytes("UTF8")
	Dim Packet As UDPPacket
	Packet.Initialize(data, txtConnect.Text, 5000)
	UDPSocket1.Send(Packet)
End Sub

Sub UDP_PacketArrived (Packet1 As UDPPacket)
	Dim msg As String = BytesToString(Packet1.Data, Packet1.Offset, Packet1.Length, "UTF8")
	'LogColor(msg, xui.Color_Black)
	MsgboxAsync("Message received: " & msg, "")
End Sub