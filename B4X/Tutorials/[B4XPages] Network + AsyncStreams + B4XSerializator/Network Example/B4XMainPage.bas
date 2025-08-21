B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private ser As B4XSerializator
	Private btnSend As B4XView
	Private btnConnect As B4XView
	Private connected As Boolean
	Private client As Socket
	Public server As ServerSocket
	Private astream As AsyncStreams
	Private const PORT As Int = 51042
	Private working As Boolean = True
	Private lblStatus As B4XView
	Private lblMyIp As B4XView
	Private txtIP As B4XFloatTextField
	Private txtName As B4XFloatTextField
	Private txtAge As B4XFloatTextField
	Private cvs As B4XCanvas
	Private pnlCanvas As B4XView
	Type MyMessage (Name As String, Age As Int, Image() As Byte)
End Sub

'You can add more parameters here.
Public Sub Initialize
	server.Initialize(PORT, "server")
	ListenForConnections
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("1")
	B4XPages.SetTitle(Me, "Network Example")
	For Each txt As B4XFloatTextField In Array(txtIP, txtName, txtAge)
		txt.LargeLabelTextSize = 15
		txt.SmallLabelTextSize = 12
		txt.Update
	Next
	cvs.Initialize(pnlCanvas)
	cvs.DrawRect(cvs.TargetRect, xui.Color_White, True, 0)
	UpdateState(False)
End Sub

Sub B4XPage_Resize (Width As Int, Height As Int)
	cvs.Resize(pnlCanvas.Width, pnlCanvas.Height)
End Sub

Private Sub ListenForConnections
	Do While working
		server.Listen
		Wait For Server_NewConnection (Successful As Boolean, NewSocket As Socket)
		If Successful Then
			CloseExistingConnection
			client = NewSocket
			astream.InitializePrefix(client.InputStream, False, client.OutputStream, "astream")
			UpdateState(True)
		End If
	Loop
End Sub

Sub CloseExistingConnection
	If astream.IsInitialized Then astream.Close
	If client.IsInitialized Then client.Close
	UpdateState (False)
End Sub

Sub AStream_Error
	UpdateState(False)
End Sub

Sub AStream_Terminated
	UpdateState(False)
End Sub

Sub UpdateState (NewState As Boolean)
	connected = NewState
	btnSend.Enabled = connected
	If connected Then
		btnConnect.Text = "Disconnect"
		lblStatus.Text = "Connected"
	Else
		btnConnect.Text = "Connect"
		lblStatus.Text = "Disconnected"
	End If
	lblMyIp.Text = "My ip: " & server.GetMyIP
End Sub

Sub AStream_NewData (Buffer() As Byte)
	Dim mm As MyMessage = ser.ConvertBytesToObject(Buffer)
	txtAge.Text = mm.Age
	txtName.Text = mm.Name
	Dim bmp As B4XBitmap = LoadBitmapFromBytes(mm.Image)
	bmp = bmp.Resize(pnlCanvas.Width, pnlCanvas.Height, False)
	cvs.ClearRect(cvs.TargetRect)
	cvs.DrawBitmap(bmp, cvs.TargetRect)
	cvs.Invalidate
End Sub

Private Sub LoadBitmapFromBytes(Data() As Byte) As B4XBitmap
	Dim in As InputStream
	in.InitializeFromBytesArray(Data, 0, Data.Length)
	#if B4J
	Dim bmp As Image
	#Else If B4A or B4i
	Dim bmp As Bitmap
	#End If
	bmp.Initialize2(in)
	Return bmp
End Sub

Private Sub ConnectToServer(Host As String)
	Log("Trying to connect to: " & Host)
	CloseExistingConnection
	Dim client As Socket
	client.Initialize("client")
	client.Connect(Host, PORT, 10000)
	Wait For Client_Connected (Successful As Boolean)
	If Successful Then
		astream.InitializePrefix(client.InputStream, False, client.OutputStream, "astream")
		UpdateState (True)
	Else
		Log("Failed to connect: " & LastException)
	End If
End Sub

Private Sub Disconnect
	CloseExistingConnection
End Sub


Public Sub SendData (data() As Byte)
	If connected Then astream.Write(data)
End Sub

Sub pnlCanvas_Touch (Action As Int, X As Float, Y As Float)
	If Action <> pnlCanvas.TOUCH_ACTION_MOVE_NOTOUCH Then
		cvs.DrawCircle(X, Y, 30dip, Rnd(xui.Color_Black, xui.Color_White), True, 0)
		cvs.Invalidate
	End If
	
End Sub

Sub btnConnect_Click
	If connected = False Then
		If txtIP.Text.Length = 0 Then
			xui.MsgboxAsync("Please enter the server ip address.", "")
			Return
		Else
			ConnectToServer(txtIP.Text)
		End If
	Else
		Disconnect
	End If
End Sub

Sub btnSend_Click
	Dim mm As MyMessage
	mm.Initialize
	If IsNumber(txtAge.Text) Then mm.Age = txtAge.Text Else mm.Age = 0
	mm.Name = txtName.Text
	'convert the bitmap to bytes
	Dim out As OutputStream
	out.InitializeToBytesArray(0)
	cvs.CreateBitmap.WriteToStream(out, 100, "PNG")
	out.Close
	mm.Image = out.ToBytesArray
	SendData (ser.ConvertObjectToBytes(mm))
End Sub



Sub btnClear_Click
	cvs.ClearRect(cvs.TargetRect)
	cvs.Invalidate
End Sub