B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'Handler class
Sub Class_Globals
	Dim cpr As LZStringCompress
End Sub

Public Sub Initialize
	cpr.Initialize
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	resp.ContentType = "application/json"
	resp.Write(Compress)
End Sub

Sub Compress() As String
	Dim text As String = File.ReadString(File.DirApp & "\www", "testfile.txt")
	Dim cprText As String = cpr.Compress4Socket(text)
	Return cprText
End Sub