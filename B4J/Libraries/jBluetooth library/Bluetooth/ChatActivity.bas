Type=Activity
Version=5.5
ModulesStructureVersion=1
B4A=true
@EndOfDesignText@
#Region Module Attributes
	#FullScreen: False
	#IncludeTitle: True
#End Region

'Activity module
Sub Process_Globals
	Dim AStream As AsyncStreams
End Sub

Sub Globals
	Dim txtInput As EditText
	Dim txtLog As EditText
	Dim btnSend As Button
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.LoadLayout("2")
	If AStream.IsInitialized = False Then
		AStream.InitializePrefix(Main.serial1.InputStream, True, Main.serial1.OutputStream, "AStream")
	End If
	txtLog.Width = 100%x
End Sub

Sub AStream_NewData (Buffer() As Byte)
	LogMessage("You", BytesToString(Buffer, 0, Buffer.Length, "UTF8"))
End Sub

Sub AStream_Error
	ToastMessageShow("Connection is broken.", True)
	btnSend.Enabled = False
	txtInput.Enabled = False
End Sub

Sub AStream_Terminated
	AStream_Error
End Sub

Sub Activity_Resume
	
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	If UserClosed Then
		AStream.Close
	End If
End Sub

Sub txtInput_EnterPressed
	If btnSend.Enabled = True Then btnSend_Click
End Sub
Sub btnSend_Click
	AStream.Write(txtInput.Text.GetBytes("UTF8"))
	txtInput.SelectAll
	txtInput.RequestFocus
	LogMessage("Me", txtInput.Text)
End Sub

Sub LogMessage(From As String, Msg As String)
	txtLog.Text = txtLog.Text & From & ": " & Msg & CRLF
	txtLog.SelectionStart = txtLog.Text.Length
End Sub