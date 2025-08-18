B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9
@EndOfDesignText@
Sub Class_Globals
	Private ServSock As ServerSocket
	Private ServHttp As ServerSocket
	Private Work As Boolean = False
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(SocksPort As Int)
	ServSock.Initialize(SocksPort,"ServSock")
	ServHttp.Initialize(1080,"ServHttp")
End Sub

Public Sub Start
	Work=True
	StartSocks
	StartHttp
End Sub

Public Sub Stop
	Work=False
End Sub

Private Sub StartSocks
	Do While Work
		ServSock.Listen
		Wait For ServSock_NewConnection (Successful As Boolean, NewSocket As Socket)

		If Successful Then
			Dim NewSocks As SockHandle
			NewSocks.Initialize(NewSocket)
		End If
	Loop
End Sub

Private Sub StartHttp
	Do While Work
		ServHttp.Listen
		Wait For ServHttp_NewConnection (Successful As Boolean, NewSocket As Socket)

		If Successful Then
			Dim NewSocks As HttpHandle
			NewSocks.Initialize(NewSocket)
		End If
	Loop
End Sub