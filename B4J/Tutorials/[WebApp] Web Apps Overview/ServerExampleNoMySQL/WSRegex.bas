B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private ws As WebSocket
	Private CaseSensitive, Multiline, Pattern, TextArea, LogsDiv As JQueryElement
End Sub


Public Sub Initialize

End Sub

Private Sub WebSocket_Connected (WebSocket1 As WebSocket)
	ws = WebSocket1
	TextArea.RunMethod("autosize", Null)
End Sub

Sub btnParse_Click (Params As Map)
	'get the required values
	Dim fCaseSensitive As Future = CaseSensitive.GetProp("checked")
	Dim fMultiline As Future = Multiline.GetProp("checked")
	Dim ftext As Future = TextArea.GetVal
	Dim fpattern As Future = Pattern.GetVal
	Dim options As Int = 0
	'only at this point the server will actually wait for the values to be available.
	If fCaseSensitive.Value = False Then options = Regex.CASE_INSENSITIVE
	If fMultiline.Value = True Then options = Bit.OR(options, Regex.Multiline)
	Try
		Dim m As Matcher = Regex.Matcher2(fpattern.Value, options, ftext.Value)
		Dim res As StringBuilder
		res.Initialize
		Do While m.Find
			res.Append("Match (length=" & m.Match.Length & "): " & _
				WebUtils.EscapeHtml(m.Match)).Append("<br/>")
			For g = 1 To m.GroupCount
				res.Append("Group #" & g & ": " & WebUtils.EscapeHtml(m.Group(g))).Append("<br/>")
			Next
		Loop
		If res.Length = 0 Then res.Append("No matches were found.")
		LogsDiv.SetHtml(res.ToString)
	Catch
		ws.Alert("Error: " & LastException.Message)
	End Try 
End Sub

