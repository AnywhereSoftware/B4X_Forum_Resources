B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
'Handler class
Sub Class_Globals
	
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	Dim ParameterMap As Map = req.ParameterMap
	
	Dim input() As String = ParameterMap.Get("input")
	
	Dim qr As qrcodegen
	qr.Initialize
	
	Dim base64 As String = qr.EncodeTextToBase64(input(0),5)
	
	resp.Write($"<img src="data:image/jpeg;base64,${base64}" width="200" height="200" alt="base64 test">"$)	
End Sub