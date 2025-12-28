B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private ClientSocket As Socket
	Private AST As AsyncStreams					'Requires jRandomAccessFile Library
	Public ID As String
End Sub



Public Sub Initialize (s As Socket, ClientId As String)
    ClientSocket = s
    ID = ClientId

    AST.Initialize(ClientSocket.InputStream, ClientSocket.OutputStream, "AST")
    Log("ClientHandler started: " & ID)
End Sub

'==================================================
' Incoming data from client
'==================================================
Sub AST_NewData (Buffer() As Byte)
    Dim msg As String = BytesToString(Buffer, 0, Buffer.Length, "UTF8").Trim
    Log("From " & ID & ": " & msg)

    ' Simple command handling example
    Select True
        Case msg.ToLowerCase = "who"
            Send("You are " & ID)

        Case msg.ToLowerCase.StartsWith("broadcast ")
            Dim text As String = msg.SubString(10)
            CallSub2(Main, "Broadcast", ID & ": " & text)

        Case Else
            ' Echo back
            Send("Echo: " & msg)
    End Select
End Sub

'==================================================
' Send data to this client
'==================================================
Public Sub Send(Text As String)
    If AST.IsInitialized Then
        AST.Write(Text.GetBytes("UTF8"))
    End If
End Sub

Sub AST_Terminated
    Log("Disconnected: " & ID)
    Close
End Sub

Sub AST_Error
    Log("Stream error: " & ID)
    Close
End Sub

Public Sub Close
    Try
        If AST.IsInitialized Then AST.Close
        If ClientSocket.IsInitialized Then ClientSocket.Close
    Catch
		Log("Could not close AST or ClientSocket - No big deal")
		
    End Try

    CallSub2(Main, "RemoveClient", ID)
End Sub
