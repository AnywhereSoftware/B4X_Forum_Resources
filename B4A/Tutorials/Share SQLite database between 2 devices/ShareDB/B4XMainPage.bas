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
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=ShareDB.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private lblMyIP As B4XView
	Private lblStatus As B4XView
	Private txtIP As B4XFloatTextField
	Private txtTodo As B4XFloatTextField
	Private BtnConnect As Button
	Private BtnAdd As Button
	Private lblTodo As B4XView
	Private lblCreated As B4XView
	Private CLV1 As CustomListView
	Private server As ServerSocket
	Private client As Socket
	Private ser As B4XSerializator
	Private astream As AsyncStreams
	Private connected As Boolean
	Private working As Boolean = True
	Private const PORT As Int = 51042
	Private SQL As SQL 'ignore
	Type Message (Query As String, Param As List)
End Sub

Public Sub Initialize
	server.Initialize(PORT, "server")
	ListenForConnections
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "ShareDB")
	DateTime.DateFormat = "yyyy-MM-dd HH:mm:ss"
	#If SERVER
		#If B4J
			If File.Exists(File.DirApp, "Todo.db") = False Then
				SQL.InitializeSQLite(File.DirApp, "Todo.db", True)
				SQL.ExecNonQuery($"CREATE TABLE tblTodo (id	INTEGER, Todo TEXT, Created TEXT, PRIMARY KEY(id))"$)
			Else
				SQL.InitializeSQLite(File.DirApp, "Todo.db", False)
			End If
		#Else
			If File.Exists(File.DirInternal, "Todo.db") = False Then
				SQL.Initialize(File.DirInternal, "Todo.db", True)
				SQL.ExecNonQuery($"CREATE TABLE tblTodo (id	INTEGER, Todo TEXT, Created TEXT, PRIMARY KEY(id))"$)
			Else
				SQL.Initialize(File.DirInternal, "Todo.db", False)
			End If
		#End If
	ListTodo(ReadTodo)
	#Else
		txtIP.Text = "192.168.50.91" ' Server's IP
	#End If
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
	UpdateState(False)
End Sub

Sub AStream_Error
	UpdateState(False)
End Sub

Sub AStream_Terminated
	UpdateState(False)
End Sub

Sub UpdateState (NewState As Boolean)
	connected = NewState
	BtnAdd.Enabled = connected
	If connected Then
		BtnConnect.Text = "Disconnect"
		lblStatus.Text = "Connected"
	Else
		BtnConnect.Text = "Connect"
		lblStatus.Text = "Disconnected"
	End If
	lblMyIP.Text = "My ip: " & server.GetMyIP
End Sub

Sub AStream_NewData (Buffer() As Byte)
	Dim Msg As Message = ser.ConvertBytesToObject(Buffer)
	
	If Msg.Query.StartsWith("INSERT") Then
		#If SERVER
		Log("INSERT")
		SQL.ExecNonQuery2(Msg.Query, Msg.Param)
		ListTodo(ReadTodo)
		Dim Msg As Message = CreateMessage("REFRESH", ReadTodo)
		SendData(ser.ConvertObjectToBytes(Msg))
		#End If
	End If
	
	If Msg.Query.EqualsIgnoreCase("READ") Then
		Log("READ")
		Dim Msg As Message = CreateMessage("REFRESH", ReadTodo)
		SendData(ser.ConvertObjectToBytes(Msg))
	End If
	
	If Msg.Query.EqualsIgnoreCase("REFRESH") Then
		Log("REFRESH")
		ListTodo(Msg.Param)
	End If
End Sub

Private Sub ConnectToServer (Host As String)
	Log("Trying to connect to: " & Host)
	CloseExistingConnection
	Dim client As Socket
	client.Initialize("client")
	client.Connect(Host, PORT, 10000)
	Wait For Client_Connected (Successful As Boolean)
	If Successful Then
		astream.InitializePrefix(client.InputStream, False, client.OutputStream, "astream")
		UpdateState(True)
		
		Dim empty As List
		empty.Initialize
		Dim Msg As Message = CreateMessage("READ", empty)
		SendData(ser.ConvertObjectToBytes(Msg))
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

Private Sub BtnConnect_Click
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

Private Sub BtnAdd_Click
	Dim query As String = "INSERT INTO tblTodo (Todo, Created) VALUES (?, ?)"
	Dim param As List = Array As String(txtTodo.Text, DateTime.Date(DateTime.Now))
	#If SERVER
	SQL.ExecNonQuery2(query, param)
	ListTodo(ReadTodo)
		
	Dim Msg As Message = CreateMessage("REFRESH", ReadTodo)
	SendData(ser.ConvertObjectToBytes(Msg))
	#Else
	Dim Msg As Message = CreateMessage(query, param)
	SendData(ser.ConvertObjectToBytes(Msg))
	#End If
End Sub

Private Sub ReadTodo As List
	Dim Todos As List
	Todos.Initialize
	Dim RS As ResultSet
	RS = SQL.ExecQuery("SELECT id, Todo, Created FROM tblTodo ORDER BY id")
	Do While RS.NextRow
		Todos.Add(CreateMap("id": RS.GetInt("id"), "Todo": RS.GetString("Todo"), "Created": RS.GetString("Created")))
	Loop
	RS.Close
	Return Todos
End Sub

Private Sub ListTodo (Todos As List)
	Log("refreshing CLV...")
	CLV1.Clear
	For Each todo As Map In Todos
		CLV1.Add(CreateItem(todo.Get("Todo"), todo.Get("Created")), todo.Get("id"))
	Next
End Sub

Private Sub CreateItem (Todo As String, Created As String) As B4XView
	Dim pnl As B4XView = xui.CreatePanel("")
	pnl.Height = 90dip
	pnl.Width = CLV1.AsView.Width
	pnl.LoadLayout("Todo")
	lblTodo.Text = Todo
	lblCreated.Text = Created
	Return pnl
End Sub

Public Sub CreateMessage (Query As String, Param As List) As Message
	Dim t1 As Message
	t1.Initialize
	t1.Query = Query
	t1.Param = Param
	Return t1
End Sub