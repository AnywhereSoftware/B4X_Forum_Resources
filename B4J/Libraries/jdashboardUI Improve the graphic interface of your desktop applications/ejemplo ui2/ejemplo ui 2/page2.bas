B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
	Private Panel21 As InformationPanelmodel2
	Private Panel22 As InformationPanelmodel2
	Private Panel23 As InformationPanelmodel2
	Private firebasebutton As Button
	Private playstorebutton As Button
	Private Googlesheetsbutton As Button
End Sub




Sub show
	Main.UI.pbase.RemoveAllNodes
	Main.UI.pbase.LoadLayout("2")
	
	jdashboardUtils.ButtonSetImage2(firebasebutton,File.DirAssets,"google_firebase_console_512px.png","#5D5F90","#8C8FD9",30,30,"LEFT")
	jdashboardUtils.ButtonSetImage2(playstorebutton,File.DirAssets,"icons8_Google_Play_512px.png","#5D5F90","#8C8FD9",30,30,"LEFT")
	jdashboardUtils.ButtonSetImage2(Googlesheetsbutton,File.DirAssets,"icons8_google_sheets_512px.png","#5D5F90","#8C8FD9",30,30,"LEFT")
	
	jdashboardUtils.SetShadow(firebasebutton,4,fx.Colors.RGB(160, 158, 158))
	jdashboardUtils.SetShadow(playstorebutton,4,fx.Colors.RGB(160, 158, 158))
	jdashboardUtils.SetShadow(Googlesheetsbutton,4,fx.Colors.RGB(160, 158, 158))
	
	Panel21.set_maintext(3000)
	Panel21.set_description("Firebase")
	Panel21.setlogo(File.DirAssets,"google_firebase_console_512px.png")

	
	Panel22.set_maintext(2000)
	Panel22.set_description("Google play")
	Panel22.setlogo(File.DirAssets,"icons8_Google_Play_512px.png")
	
	Panel23.set_maintext(4000)
	Panel23.set_description("Google Sheets")
Panel23.setlogo(File.DirAssets,"icons8_google_sheets_512px.png")

End Sub