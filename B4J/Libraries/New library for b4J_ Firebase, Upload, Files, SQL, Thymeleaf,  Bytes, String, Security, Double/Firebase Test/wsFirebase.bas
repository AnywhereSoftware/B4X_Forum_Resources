B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
'WebSocket class
Sub Class_Globals
	Private ws As WebSocket
	
End Sub

Public Sub Initialize
	
End Sub

Private Sub WebSocket_Connected (WebSocket1 As WebSocket)
	ws = WebSocket1
End Sub

Private Sub WebSocket_Disconnected
	
End Sub

Sub event_register(variable As Map)
	Log("CONNECTED")
	Dim token As String = variable.Get("tk")
	
	Log(token)
	Dim firetoken As jFirebaseAuthWrapper
	Dim auth As String = File.Combine(File.DirApp, "firebase.json")
	firetoken.Initialize("firebaseauth", auth)
	firetoken.verifyIdToken(token)
End Sub

Sub firebaseauth_tokenverified (Token As Map)
	Log(Token.Get("getEmail"))
	Log(Token.Get("getIssuer"))
	Log(Token.Get("getName"))
	Log(Token.Get("getPicture"))
	Log(Token.Get("getTenantId"))
	Log(Token.Get("getUid"))
	Log(Token.Get("isEmailVerified"))
	'https://thienvienphuocson-69b69-default-rtdb.asia-southeast1.firebasedatabase.app
End Sub