B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub

Public Sub ApplyTheme(form As Form)
	form.Stylesheets.Add(File.GetUri(File.DirAssets,"base.css"))
	form.Stylesheets.Add(File.GetUri(File.DirAssets,"base_extras.css"))
	form.Stylesheets.Add(File.GetUri(File.DirAssets,"base_other_libraries.css"))
	form.Stylesheets.Add(File.GetUri(File.DirAssets,"panes.css"))
	form.Stylesheets.Add(File.GetUri(File.DirAssets,"light_theme.css"))
End Sub

