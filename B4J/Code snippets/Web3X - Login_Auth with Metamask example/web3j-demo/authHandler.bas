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
	Dim signature As String = req.GetHeader("signature")
	
	signature = Utils.CleanHexPrefix(signature)
	
	Dim originalMessage As String = DB.database.Get(address&"_message")
	
	Dim bc As ByteConverter
	
	Log(address & " is authenticating")
	Log(originalMessage)
	Log(signature)
	
	Dim IsVerified As Boolean = Utils.VerifySignature(bc.HexToBytes(originalMessage), bc.HexToBytes(signature), address)
	Log(IsVerified)
	resp.ContentType = "application/json"
	If IsVerified Then
		Dim token As String = genToken
		DB.database.Put(address&"_token", token)
		
		Dim m As Map
		m.Initialize
		m.Put("success", True)
		m.Put("token", token)
		
		Dim jg As JSONGenerator
		jg.Initialize(m)
		resp.Write(jg.ToString)
	Else
		resp.SendError(401, "Unauthenticated")
	End If
End Sub

Sub genToken As String
	Dim token(32) As Byte
	Dim SR As SecureRandom
	SR.GetRandomBytes(token)
	
	Dim bc As ByteConverter
	Return bc.HexFromBytes(token)
End Sub