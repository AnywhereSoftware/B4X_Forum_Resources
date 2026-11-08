B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
'Filter class
Sub Class_Globals
	
End Sub

Public Sub Initialize
	
End Sub

'Return True to allow the request to proceed.
Public Sub Filter(req As ServletRequest, resp As ServletResponse) As Boolean
	Dim token As String = req.GetParameter("token")
	Dim address As String = req.GetParameter("address")
	
	If token.Length > 0 And token = DB.database.GetDefault(address&"_token","") Then
		Log(address & "accepted")
		Return True
	End If
	resp.SendError(401, "Unauthenticated")
	Return False
End Sub