B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.18
@EndOfDesignText@
'Class module
Sub Class_Globals
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

End Sub

Public Sub Filter(req As ServletRequest, resp As ServletResponse) As Boolean
	If req.GetSession.GetAttribute2("registered", "") = True Then
		'check that no more than 30 minutes passed since last activity
		If req.GetSession.LastAccessedTime + DateTime.TicksPerMinute * 30 > DateTime.Now Then
			Return True 'allow request to continue
		End If
	End If
	resp.SendRedirect("/login_example/")
	Return False
End Sub