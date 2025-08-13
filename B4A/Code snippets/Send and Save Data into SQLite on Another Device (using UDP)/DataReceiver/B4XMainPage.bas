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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=DataReceiver.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private UDPSocket1 As UDPSocket
	Private DB As SQL
	Private DATA_FOLDER As String
	Private DATA_FILE As String
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	DATA_FOLDER = xui.DefaultFolder
	DATA_FILE = "Database.db"
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, Application.LabelName)
	UDPSocket1.Initialize("UDP", 5000, 8000)
	If File.Exists(DATA_FOLDER, DATA_FILE) Then
		DB.Initialize(DATA_FOLDER, DATA_FILE, False)
	Else
		DB.Initialize(DATA_FOLDER, DATA_FILE, True)
		CreateTable
	End If
End Sub

Private Sub BtnQuery_Click
	Dim Query As String = $"SELECT * FROM Data"$
	QueryDatabase(Query)
End Sub

Private Sub QueryDatabase (strSQL As String)
	Dim RS As ResultSet = DB.ExecQuery(strSQL)
	Do While RS.NextRow
		Log($"${RS.GetInt("id")}: ${RS.GetString("Name")} (${RS.GetInt("Age")})"$)
	Loop
	RS.Close
End Sub

Private Sub CreateTable
	Dim strSQL As String = $"CREATE TABLE Data (id INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT, Age INTEGER)"$
	DB.ExecNonQuery(strSQL)
End Sub

Private Sub ExecuteCommand (strSQL As String, Parameters As List)
	DB.ExecNonQuery2(strSQL, Parameters)
End Sub

Sub UDP_PacketArrived (Packet1 As UDPPacket)
	Dim msg As String = BytesToString(Packet1.Data, Packet1.Offset, Packet1.Length, "UTF8")
	Log("Message received: " & msg) ' received from 192.168.50.33
	ToastMessageShow("Message received", False)
	Dim M As Map = msg.As(JSON).ToMap
	If M.IsInitialized Then
		Dim Action As String = M.Get("Action")
		Dim strSQL As String = M.Get("Query")
		Dim Parameters As List = M.Get("Parameters")
		Select Action.ToUpperCase
			Case "INSERT"				
				ExecuteCommand(strSQL, Parameters)
			Case Else
				
		End Select
	End If
End Sub