B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
'Handler class
Sub Class_Globals
	Private Utils As W3Utils
End Sub

Public Sub Initialize
	Utils.Initialize
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	Dim address As String = req.GetParameter("address")
	
	If address.Length = 0 Then
		resp.SendError(400, "No address parameter found")
		Return
	End If
	
	Dim message(32) As Byte 
	Dim SR As SecureRandom
	SR.GetRandomBytes(message)
	
	Dim bc As ByteConverter
	Dim HexMessage As String = bc.HexFromBytes(message)
	
	Log(address & " requested a message: " & HexMessage)
	
	DB.database.Put(address&"_message", HexMessage)
	
	resp.Write(HexMessage)
End Sub