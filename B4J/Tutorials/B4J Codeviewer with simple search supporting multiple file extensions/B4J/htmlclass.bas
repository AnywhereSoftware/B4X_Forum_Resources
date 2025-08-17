B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private htmlstring As String
End Sub

Public Sub Initialize
	htmlstring = ""
End Sub

Public Sub set_htmlpage(strtext As String,lang As String,csstype As String,extension As String) As String
	If lang = "markup" Or lang = "php" Or lang = "css" Then
		strtext = strtext.Replace("&","&amp;")
		strtext = strtext.Replace("<","&lt;")
		strtext = strtext.Replace(">","&gt;")
	End If
	If lang = "html" And csstype = "w3css" Then
		If extension <> ".html" And extension <> ".htm" Then
			strtext = strtext.Replace(Chr(10),"<br>")			
		End If
	End If
	Private sb As StringBuilder
	sb.Initialize
	sb = html_header(sb,lang,csstype)
	sb = html_body(sb,lang,strtext,csstype)
	sb = html_footer(sb,csstype)
	htmlstring = sb.ToString
	Return htmlstring
End Sub

Private Sub html_header(sb As StringBuilder, lang As String, csstype As String) As StringBuilder
	sb.Append("<html>")
	sb.Append("<head>")
	sb.Append("<meta name='viewport' content='width=device-width, initial-scale=1'>")
	If csstype = "prism" Then
		Private prismcss As String
		prismcss = set_prism_css1
		sb.Append("<style type='text/css'>").Append(prismcss).Append("</style>").Append(CRLF)
		Private prismjs As String
		prismjs = set_prism_js1
		sb.Append("<script>").Append(prismjs).Append("</script>").Append(CRLF)
		If lang = "b4x" Then
			prismcss = set_prism_css2
			sb.Append("<style type='text/css'>").Append(prismcss).Append("</style>").Append(CRLF)
			prismjs = set_prism_js2
			sb.Append("<script>").Append(prismjs).Append("</script>").Append(CRLF)
			prismjs = set_prism_js3
			sb.Append("<script>").Append(prismjs).Append("</script>").Append(CRLF)
		End If		
	End If
	If csstype = "w3css" Then
		Private w3css As String
		w3css = set_w3_css
		sb.Append("<style type='text/css'>").Append(w3css).Append("</style>").Append(CRLF)		
	End If
	Return sb
End Sub
Private Sub html_body(sb As StringBuilder, lang As String, strtext As String,csstype As String) As StringBuilder
	If csstype = "prism" Then
		sb.Append("</head><body><pre><code class='language-" & lang & " line-numbers'>")		
	End If
	If csstype = "w3css" Then
		sb.Append("</head><body>")
	End If
	sb.Append(strtext).Append(CRLF)
	Return sb
End Sub
Private Sub html_footer(sb As StringBuilder,csstype As String) As StringBuilder
	If csstype = "w3css" Then
		sb.Append("</body></html>")
	Else
		sb.Append("</code></pre></body></html>")			
	End If

	Return sb
End Sub
Private Sub set_prism_css1 As String
	Dim css As String
	css= File.ReadString(File.DirAssets,"prism.css")
	Return css
End Sub
Private Sub set_prism_css2 As String
	Dim css As String
	css= File.ReadString(File.DirAssets,"prism_b4x.css")
	Return css
End Sub
Private Sub set_prism_js1 As String
	Dim js As String
	js= File.ReadString(File.DirAssets,"prism.js")
	Return js
End Sub
Private Sub set_prism_js2 As String
	Dim js As String
	js= File.ReadString(File.DirAssets,"prism_b4x.js")
	Return js
End Sub
Private Sub set_prism_js3 As String
	Dim js As String
	js= File.ReadString(File.DirAssets,"prism-b4x.js")
	Return js
End Sub
Private Sub set_w3_css As String
	Dim css As String
	css= File.ReadString(File.DirAssets,"w3.css")
	Return css
End Sub
