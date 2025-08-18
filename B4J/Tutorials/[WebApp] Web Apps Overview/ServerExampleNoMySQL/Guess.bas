B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4
@EndOfDesignText@
'Class module
Sub Class_Globals
End Sub

Public Sub Initialize

End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	Try
		If req.GetSession.HasAttribute("myNumber") = False Then
			req.GetSession.SetAttribute("myNumber", Rnd(0, 101))
		End If
		Dim myNumber As Int = req.GetSession.GetAttribute("myNumber")
		Dim n As String = req.GetParameter("number")
		If IsNumber(n) = False Then
			resp.Write("Please enter a valid number.")
		Else
			If n > myNumber Then
				resp.Write("My number is smaller.")
			Else If n < myNumber Then
				resp.Write("My number is larger.")
			Else
				resp.Write("Well done!!!")
			End If
		End If
	Catch
		resp.SendError(500, "error....")
	End Try
End Sub