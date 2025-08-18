B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.18
@EndOfDesignText@
'Class module
Sub Class_Globals
	
End Sub

Public Sub Initialize

End Sub

Public Sub Handle(req As ServletRequest, resp As ServletResponse)
	Dim jp As JSONParser
	Dim data() As Byte = Bit.InputStreamToBytes(req.InputStream)
	jp.Initialize(BytesToString(data, 0, data.Length, "UTF8"))
	Dim resJson As Map
	resJson.Initialize
	Try
		Dim json As Map = jp.NextObject
		Dim options As Int = 0
		If json.Get("case_sensitive") = False Then options = Regex.CASE_INSENSITIVE
		If json.Get("multiline") = True Then options = Bit.OR(options, Regex.MULTILINE)
		Dim m As Matcher = Regex.Matcher2(json.Get("pattern"), options, json.Get("text"))
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
		resJson.Put("success", True)
		resJson.Put("log", res.ToString)
	Catch
		resJson.Put("success", False)
		resJson.Put("error", LastException.Message)
	End Try
	
	Dim jg As JSONGenerator
	jg.Initialize(resJson)
	resp.ContentType = "application/json"
	resp.CharacterEncoding = "UTF8"
	resp.Write(jg.ToString)
End Sub

