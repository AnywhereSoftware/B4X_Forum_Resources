B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	
End Sub

Public Sub Initialize
	
End Sub

Sub Handle (req As ServletRequest, resp As ServletResponse)
	Dim value As String = "https://www.b4x.com"
	If req.GetParameter("value").Length > 0 Then value = req.GetParameter("value")
	Dim img As String = File.Combine(Main.AssetFolder, "img")
	Dim generate As ZXing
	generate.Initialize
	generate.QrCode(value, 400, File.Combine(img, "image.png"), "png")
	Dim Html As String = $"<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>QRCode Generator</title>
</head>
<body>
	<div align="center">
		<h1 style="color: #9400D3">Simple B4JServer QRCode Generator</h1>
		<h2>by aeric</h2>
		<p>${value}</p>
		<img src="/img/image.png" width="400" height="400" title="qrcode" />
	</div>
</body>
</html>"$
	resp.Write(Html)
End Sub