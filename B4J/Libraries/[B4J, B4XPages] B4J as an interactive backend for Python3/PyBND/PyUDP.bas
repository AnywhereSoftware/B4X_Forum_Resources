B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'A Python based UDP server is launched at start
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private us As UDPSocket
	Private pane1, pane2 As B4XView
	Private ta1, ta2 As TextArea
	Private dummyfocus As TextField
	Private resultButton As Label
End Sub

'Initializes the instance of this B4XPages Class - no arguments needed.
Public Sub Initialize As Object
	Return Me
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	CallSubDelayed(Me, "adjustPanels")
	us.Initialize("us", 52041, 8192)
	Log("starting UDPServer")
	Dim shl As Shell
	File.WriteString(File.DirApp, "UDPServer.py", UDPServer)
	shl.Initialize("shl", "py", Array(File.Combine(File.DirApp, "UDPServer.py")))
	shl.RunWithOutputEvents(-1)
End Sub

Private Sub adjustPanels
	dummyfocus.As(B4XView).SetLayoutAnimated(0, -200, -200, 10, 10)
	pane1.SetLayoutAnimated(0, 2, 2, Root.Width / 2 - 6, Root.Height - 24)
	pane2.SetLayoutAnimated(0, Root.Width / 2 + 2, 2, Root.Width / 2 - 6, Root.Height - 24)
	ta1.Initialize("")
	ta1.As(B4XView).TextSize = 18
	ta2.Initialize("")
	ta2.As(B4XView).TextSize = 18
	ta2.As(B4XView).TextColor = xui.Color_Blue
	pane1.AddView(ta1, 0, 0, pane1.Width, pane1.Height)
	pane2.AddView(ta2, 0, 0, pane2.Width, pane2.Height)
	resultButton.Initialize("next")
	resultButton.As(B4XView).text = "Next" & " " & Chr(0x2B95)
	resultButton.As(B4XView).font = xui.CreateDefaultBoldFont(14)
	Root.AddView(resultButton, Root.Width - 85, Root.Height - 20, 80, 20)
	resultButton.visible = False
End Sub

Private Sub shl_StdErr (Buffer() As Byte, Length As Int)
	Log("Error_____________________________")
	Try
		Dim response As String = BytesToString(Buffer, 0, Buffer.Length, "UTF-8")
		Sleep(0)	'required - in release to return to main thread
		ta2.Text = ta2.Text & response	'already has CRLF
		ta2.SetSelection(ta2.Text.Length-1, ta2.Text.Length)
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub shl_StdOut (Buffer() As Byte, Length As Int)
	Try
		Dim response As String = BytesToString(Buffer, 0, Length, "UTF-8")
		If response.StartsWith("Listening") Then 
			File.Delete(File.DirApp, "UDPServer.py")
			CallSubDelayed(B4XPages.MainPage, "Py_Ready")
		Else
			Sleep(0)	'required - in release to return to main thread
			ta2.Text = ta2.Text & response	'already has CRLF
			ta2.SetSelection(ta2.Text.Length-1, ta2.Text.Length)
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	Log("Process completed")
End Sub

'This will be needed - it let us know that the message is received - so ready for the next 'statement'
Private Sub us_PacketArrived (Packet As UDPPacket)
	Dim response As String = BytesToString(Packet.Data, 0, Packet.Length, "ASCII")
	If response = "ACK" Then CallSubDelayed(Me, "Exec_Complete")
End Sub

Private Sub UDPServer As String
	Dim sc As String = $"
import socket
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
server_address = '0.0.0.0'
server_port = 52042
server = (server_address, server_port)
sock.bind(server)

print("Listening on ", server_address, ":", str(server_port), flush=True)

while True:
	payload, client_address = sock.recvfrom(1000)
	if payload == b'exit':
		break
	exec(payload)
	sent = sock.sendto(b'ACK', client_address)
"$
	Return sc
End Sub

'Instructs the UDP server to execute code string - one unindented block at a time
Public Sub Run(s As String)
	s = s.trim
	Dim v() As String = Regex.Split(CRLF, s)
	Dim sb As StringBuilder: sb.Initialize

	For i = 0 To v.Length - 1
		Dim t As String = v(i)	
		If t.StartsWith(TAB) Then
			sb.Append(t).Append(CRLF)
		Else
			If sb.Length > 0 Then
				sb.Remove(sb.Length -1, sb.Length)
				PExec(sb.toString)
				wait for Exec_Complete
				sb.Initialize
			End If
			sb.Append(t).Append(CRLF)
			If i = v.Length - 1 And sb.Length > 0 Then
				sb.Remove(sb.Length -1, sb.Length)
				PExec(sb.toString)
				wait for Exec_Complete
				sb.initialize
			End If
		End If
	Next
	If sb.Length > 0 Then
		PExec(sb.toString)
		wait for Exec_Complete
	End If
	ta1.Text = ta1.Text & CRLF
	CallSubDelayed(B4XPages.MainPage, "Py_Complete")
End Sub

'Instructs the UDP server to terminate
Public Sub Kill
	PExec("exit")
End Sub

Private Sub PExec(msg As String)
	If msg<>"exit" Then
		If msg.replace("(", " (").replace("=", "= ").Contains(" input ") Then msg = "#Disabled: " & msg 
		ta1.Text = ta1.Text & msg & CRLF
		ta1.SetSelection(ta1.Text.Length-1, ta1.Text.Length)
		If msg.trim.StartsWith("print") Then
			If Not(msg.Contains("flush")) Then 
				msg = msg.SubString2(0, msg.LastIndexOf(")")) & ", flush=True)"
			End If
		End If
	End If
	Dim Packet As UDPPacket
	Packet.Initialize(msg.GetBytes("ASCII"), "127.0.0.1", 52042)
	us.Send(Packet)
End Sub

'Used to retrieve the last 2 lines from the output panel. 1st line is comma delimited keys. 2nd line is comma delimited results. Returns a Map
Public Sub GetResults As Map
	Dim w() As String = Regex.Split(CRLF, ta2.text)
	Dim a As List: a.Initialize
	For j = w.Length - 1 To 0 Step -1
		If w(j).Trim.Length > 0 Then 
			a.InsertAt(0, w(j))
			If a.Size = 2 Then Exit
		End If
	Next
	Dim mp As Map
	mp.Initialize
	If a.Size < 2 Then Return mp
	Dim v0() As String = Regex.Split("\,", a.Get(0))
	Dim v1() As String = Regex.Split("\,", a.Get(1))
	For i = 0 To v0.Length -1
		mp.Put(v0(i).trim, v1(i).trim)
	Next
	Return mp
End Sub

'Used to retrieve complete output of all Python code. Returns a List of lines
Public Sub GetAllResults As List
	Dim w() As String = Regex.Split(CRLF, ta2.text)
	Dim result As List: result.initialize
	For Each s As String In w
		result.Add(s)
	Next
	Return result
End Sub

'Used to retrieve last line of output of all Python code. Returns a String. If blank then no output.
Public Sub GetLastResult As String
	Dim w() As String = Regex.Split(CRLF, ta2.text)
	For j = w.Length - 1 To 0 Step -1
		If w(j).Trim.Length > 0 Then Return w(j)
	Next
	Return ""
End Sub

Public Sub PlotButton(txt As String)
	resultButton.text = txt & " " & Chr(0x2B95)
	resultButton.Visible = True
End Sub

Private Sub next_MouseClicked(Ev As MouseEvent)
	B4XPages.MainPage.ShowResultRequest
End Sub