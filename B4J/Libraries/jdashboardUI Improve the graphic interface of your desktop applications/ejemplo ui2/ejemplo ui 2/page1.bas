B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
	
	Private pandroid As InformationPanel
	Private pios As InformationPanel
	Private pwindows As InformationPanel
	Private jdashboard_CircularProgressBar1 As jdashboard_CircularProgressBar
	Private jdashboard_CircularProgressBar2 As jdashboard_CircularProgressBar
	Private jdashboard_CircularProgressBar3 As jdashboard_CircularProgressBar
	Private jButtonOptions1 As jButtonOptions
	Private jbtfloating1 As jbtfloating
End Sub


Sub show
	
	Main.UI.pbase.RemoveAllNodes
	Main.UI.pbase.LoadLayout("Layout1")
	
	pandroid.set_subtitle("30%")
	pandroid.set_maintext(300)
	pandroid.set_description("Android")
	pandroid.lcon(Chr(0xF17B))
	
	pios.set_subtitle("15%")
	pios.set_maintext(150)
	pios.set_description("IOS")
	pios.lcon(Chr(0xF179))
	
	pwindows.set_subtitle("55%")
	pwindows.set_maintext(550)
	pwindows.set_description("Windows")
	pwindows.lcon(Chr(0xF17A))

	jdashboard_CircularProgressBar3.Value =55
	jdashboard_CircularProgressBar2.Value =15
	jdashboard_CircularProgressBar1.Value =30
	
	' menu option
	jButtonOptions1.Add_Option("option1")
	jButtonOptions1.Add_Option("option2")

	
	jbtfloating1.lcon(Chr(0xF067))
End Sub



Private Sub jButtonOptions1_ItemClick (value As String)
	'jButtonOptions1.set_text(value)
	Log(value)
End Sub

Private Sub jbtfloating1_Click(open As Boolean)
	If open = True Then
		jbtfloating1.mBase.SetRotationAnimated(600,360)
	Else if open = False Then
		jbtfloating1.mBase.SetRotationAnimated(600,0)
	End If
	Log(open)
	Log("button")
End Sub