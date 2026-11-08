B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private lblIP As Label
	Private lblStatus As Label
	Private ImageView1 As ImageView
	Private server As ServerSocket
	Private astream As AsyncStreams
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("1")
	B4XPages.SetTitle(Me, "CCTV")
	server.Initialize(17178, "server")
	server.Listen
	lblIP.Text = "My IP: " & server.GetMyIP
End Sub

Sub Server_NewConnection (Successful As Boolean, NewSocket As Socket)
	If Successful Then
		If astream.IsInitialized Then astream.Close
		astream.InitializePrefix(NewSocket.InputStream, False, NewSocket.OutputStream, "astream")
		lblStatus.Text = "Status: Connected"
	Else
		Log(LastException)
	End If
	server.Listen
End Sub

Sub astream_NewData (Buffer() As Byte)
	Log("received: " & DateTime.GetSecond(DateTime.Now))
	Dim In As InputStream
	Log(Buffer.Length)
	In.InitializeFromBytesArray(Buffer, 0, Buffer.Length)
	Dim img As Image
	img.Initialize2(In)
	ImageView1.SetImage(img)
End Sub

Sub astream_Error
	Log("Error: " & LastException)
	astream.Close
	astream_Terminated
End Sub

Sub astream_Terminated
	lblStatus.Text = "Status: Disconnected"
End Sub