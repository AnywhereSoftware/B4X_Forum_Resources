B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' WebSocket class: SearchWS
Sub Class_Globals
	Private ws As WebSocket
	' Αυτή η μεταβλητή θα μας σώσει από τα κρασαρίσματα!
	Private IsClientConnected As Boolean = False
End Sub

Public Sub Initialize
End Sub

' 1. Αυτό τρέχει αυτόματα μόλις μπει ο χρήστης στη σελίδα
Private Sub WebSocket_Connected (WebSocket1 As WebSocket)
	ws = WebSocket1
	IsClientConnected = True
	Log("client connect to WebSocket!")
End Sub

' 2. Αυτό τρέχει αυτόματα αν ο χρήστης κλείσει την καρτέλα ή κάνει Refresh
Private Sub WebSocket_Disconnected
	IsClientConnected = False
	Log("client disconnected.")
End Sub

' 3. Το Event της αναζήτησης
Private Sub get_vector (Params As Map)
	Dim txt As String = Params.Get("text")
	Log("Request: " & txt)

	' Στέλνουμε το αίτημα στην Python
	CallSubDelayed3(Main.PyWorker, "Get_Embedding_Request", Me, txt)
    
	' wait for it
	Wait For Embedding_Response (Base64String As String)
    
	If IsClientConnected = False Then
		Log("Python responsed, but client left.")
		Return 
	End If
    
	' are you here - our client ?
	Try
		ws.RunFunction("receiveVector", Array As Object(Base64String))
		ws.Flush
		Log("result at Browser!")
	Catch
		Log("Something wrong: " & LastException.Message)
	End Try
End Sub