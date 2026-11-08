B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private websocketServer As JakartaWsLibrary
	Private closecodes As Closecodes_Utils
	Dim serverPort As Int
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(port As Int)
	serverPort = port
	'Here is everthing about your context path
	'if you desire to use a diffrent context path just include it in the parameter
	'in tyrus you cant include 2 endpoints at the same time so simply create a new websocketserver object for desired context path
	'do not forget to include the backslash at the end when you connect 
	websocketServer.Initialize("Adwebsocket", "pixet", "WebContent", serverPort)
	'the end point url will be ws://localhost:6875/pixet/
End Sub

Public Sub startServer
	websocketServer.Start
End Sub

Public Sub stopserver
	websocketServer.Stop
End Sub


Private Sub Adwebsocket_onOpen (session As SessionInfo)
	Log("User opened session : " & session.Session_Id)
End Sub

Private Sub Adwebsocket_onMessage (session As SessionInfo, message As String)
	Log(session.Session_Id & ": " & message)
	session.sendMessage("Hi from b4j-" & Rnd(100,100000))
End Sub

Private Sub Adwebsocket_onClose (session As SessionInfo, statusCode As Int, reason As String)
	Log("User disconnected: " &  session.Session_Id)
End Sub

Private Sub Adwebsocket_onError (session As SessionInfo, errortext As String)
	Log("User error: " &  session.Session_Id)
End Sub


Private Sub Adwebsocket_onException (methodName As String, Exception As String)
	Log("Exception on: " & methodName &  "Error : " & Exception )
End Sub