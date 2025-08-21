B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8
@EndOfDesignText@
'METRO STYLE BY BRIAN MICHAEL FOR WWW.B4X.COM

Sub Process_Globals
	Private fx As JFX
End Sub

Public Sub ApplyTheme(form As Form,Theme As String)
	form.Stylesheets.Add(File.GetUri(File.DirAssets,"base.css"))
	form.Stylesheets.Add(File.GetUri(File.DirAssets,"base_extras.css"))
	form.Stylesheets.Add(File.GetUri(File.DirAssets,"base_other_libraries.css"))
	form.Stylesheets.Add(File.GetUri(File.DirAssets,"panes.css"))
	If Theme = "Dark" Then
		form.Stylesheets.Add(File.GetUri(File.DirAssets,"dark_theme.css"))
	Else
		form.Stylesheets.Add(File.GetUri(File.DirAssets,"light_theme.css"))
	End If
End Sub

