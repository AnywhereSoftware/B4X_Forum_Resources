B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.5
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private mClient As FTPClient
	Private mServer As FTPServer
	Private ssocket As ServerSocket
	Private AStream As AsyncStreams
	Private mTask As FTPTask
	Private months() As String = Array As String("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", _
		"Sep", "Oct", "Nov", "Dec")
	Private FileIn As InputStream
	Private FileOut As OutputStream
	Private FileBuffer(81920) As Byte
	Private RETRTimer As Timer
	Private Connected As Boolean
End Sub

Public Sub Initialize (Client As FTPClient, Server As FTPServer, port As Int)
	ssocket.Initialize(port, "ssocket")
	ssocket.Listen
	mClient = Client
	mServer = Server
	RETRTimer.Initialize("RETRTimer", 30)
End Sub

Public Sub SetTask (task As FTPTask)
	mTask = task
	AfterConnectionAndTask
End Sub

Private Sub AfterConnectionAndTask
	If mTask.IsInitialized And Connected Then
		Try
			Select mTask.Command
				Case "LIST"
					HandleLIST
				Case "RETR"
					FileIn = File.OpenInput(mServer.BaseDir, mTask.Path)
					RETRTimer.Enabled = True
				Case "STOR"
					FileOut = File.OpenOutput(mServer.BaseDir, mTask.Path, False)
			End Select
		Catch
			mClient.SendResponse(451, "")
			Close
			Log(LastException)
		End Try
	End If
End Sub


Private Sub ssocket_NewConnection (Successful As Boolean, NewSocket As Socket)
	If Successful Then
		Dim AStream As AsyncStreams
		AStream.Initialize(NewSocket.InputStream, NewSocket.OutputStream, "astream")
		Connected = True
		AfterConnectionAndTask
	End If
End Sub

Private Sub RETRTimer_Tick
	Try
		If AStream.OutputQueueSize > 50 Then Return
		Dim c As Int = FileIn.ReadBytes(FileBuffer, 0, FileBuffer.Length)
		If c <= 0 Then
			AStream.SendAllAndClose
			RETRTimer.Enabled = False
		Else
			
			AStream.Write2(FileBuffer, 0, c)
		End If
	Catch
		Log(LastException)
		Close
	End Try
End Sub


Private Sub HandleLIST
	Dim sb As StringBuilder
	sb.Initialize
	Dim dir As String = File.Combine(mServer.BaseDir, mTask.Path)
	'create the LIST format
	For Each f As String In File.ListFiles(dir)
		If File.IsDirectory(dir, f) Then
			sb.Append("drwxr-xr-x 1 owner group ")
		Else
			sb.Append("-rw-r--r-- 1 owner group ")
		End If
		Dim size As String = File.Size(dir, f)
		Pad(sb, 13, size).Append(" ")
		
		Dim date As Long = File.LastModified(dir, f)
		sb.Append(months(DateTime.GetMonth(date) - 1)).Append(" ")
		Dim day As String = DateTime.GetDayOfMonth(date)
		Pad(sb, 3, day).Append(" ")
		If DateTime.Now - date > 180 * DateTime.TicksPerDay Then
			Pad(sb, 5, DateTime.GetYear(date))
		Else
			sb.Append($"$2.0{DateTime.GetHour(date)}:$2.0{DateTime.GetHour(date)}"$)
		End If
		sb.Append(" ").Append(f).Append(mServer.EOL)
	Next
	AStream.Write(sb.ToString.GetBytes("UTF8"))
	AStream.SendAllAndClose
End Sub

Private Sub Pad(sb As StringBuilder, n As Int, value As String) As StringBuilder
	For i = 1 To n - value.Length
		sb.Append(" ")
	Next
	sb.Append(value)
	Return sb
End Sub

Private Sub AStream_NewData (buffer() As Byte)
	Try
		FileOut.WriteBytes(buffer, 0, buffer.Length)
	Catch
		Log(LastException)
		Close
	End Try
End Sub

Public Sub Close
	Log("DataConnection_Close")
	Connected = False
	If AStream.IsInitialized Then AStream.Close
	ssocket.Close
	If FileIn.IsInitialized Then FileIn.Close
	If FileOut.IsInitialized Then FileOut.Close
	RETRTimer.Enabled = False
End Sub

Private Sub AStream_Terminated
	Log("Data connection terminated: " & mTask.Path)
	CallSubDelayed3(mClient, "SendResponse", 226, "")
	Close
End Sub

Private Sub AStream_Error
	AStream_Terminated
End Sub