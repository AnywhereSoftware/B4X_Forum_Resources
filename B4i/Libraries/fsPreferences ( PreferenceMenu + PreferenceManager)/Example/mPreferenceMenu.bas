B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4.4
@EndOfDesignText@
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.

	Private screen As clsPreferenceScreen
	Private pnlRoot As Panel
	Private pMenu As Page
End Sub

Public Sub Show
	pMenu.Initialize("pMenu")
	pMenu.RootPanel.LoadLayout("Main")
	pMenu.Title = "Einstellungen"

	pnlRoot.LoadLayout("layPMScreen")
	Main.NavControl.ShowPage(pMenu)
End Sub

Private Sub pMenu_Resize (Width As Float, Height As Float)
	'Log("pMenu_Resize : Width=" & Width)
	Dim r As Rect = pMenu.SafeAreaInsets
	pnlRoot.SetLayoutAnimated(0, 1, r.Left, r.Top, Width - r.Right - r.Left, Height - r.Bottom - r.Top)
End Sub

Private Sub pnlRoot_Resize (Width As Float, Height As Float)
	'Log("pnlRoot_Resize : Width=" & Width)
	CreatePreferenceScreen
End Sub

Private Sub pMenu_KeyboardStateChanged (Height As Float)
	screen.KeyboardStateChanged(Height)
End Sub

#Region "Settings-Menu"
Private Sub CreatePreferenceScreen
	Dim lstSpeedUnits,lstDistanceUnits As List
	lstSpeedUnits.Initialize
	lstSpeedUnits.AddAll(Array As String("kmh","minKm"))

	lstDistanceUnits.Initialize
	lstDistanceUnits.AddAll(Array As String("m","km","mile","yard"))

	Dim lstServer As List
	lstServer.Initialize
	lstServer = File.ReadList(File.DirAssets,"ntp-server.txt")

	Dim lstRadioButton As List
	lstRadioButton.Initialize
	lstRadioButton.AddAll(Array As String("Radio 1","Radio 2","Radio 3","Radio 4","Radio 5"))

    'create one categories
	screen.Clear
	Dim cat1,cat2,cat3 As clsPMCategory
	cat1.Initialize("Units")
	cat1.AddList("lstDistanceUnits","DistanceUnits","Das ist ein Test","","","",True,lstDistanceUnits)
	cat1.AddList("lstSpeedUnits","SpeedUnits","","","","",True,lstSpeedUnits)
	cat1.AddScrollView("lstScrollView", "NTP-Server", "Das ist ein Test","","lstSpeedUnits","kmh",True,lstServer)
	
	cat2.Initialize("LapSetting")
	cat2.AddEditText2("txtLapDistance", "LapDistance",8,"","","","", True)
	cat2.AddSeekBar("lstStrokRate","Strokrate","",3,2,6,"txtLapDistance","100",True)
	cat2.AddCheckBox("cbxShowDetailsAsTable","ShowDetailsAsTable","Table nur ein test für die Label-höhe und nochmal ein Test!","Text",True,"lstStrokRate","5",True)

	cat3.Initialize("Alarm")
	cat3.AddEditText2("txtBeepCount", "Sekunden-Anzahl",8, "Die Sekunden-Anzahl eintragen um die Zeit-unterschied zwischen GPS-Uhr und Funkuhr abzugleichen (manche GPS-Chips können die Zeit-unterschied nicht selber angleichen).", "10","cbxShowDetailsAsTable","",True)
	cat3.AddSeekBar("lstVolume","Volume","prozent",5,0,10,"cbxShowDetailsAsTable","",True)
	cat3.AddSeekBar("lstSekbar","New Sekbar","prozent",0,-10,10,"","",True)
	cat3.AddLabel("Bluetoot-Gerät version=?","Die Sekunden-Anzahl eintragen um die Zeit-unterschied zwischen GPS-Uhr und Funkuhr abzugleichen (manche GPS-Chips können die Zeit-unterschied nicht selber angleichen)","","",True)
	cat3.AddRadioButton("RadioButton2", "RadioButton", "Table nur ein test für die Label-höhe und nochmal ein Test! Table nur ein test für die Label-höhe und nochmal ein Test!", 0,"","",True)
	cat3.AddRadioButton("rbtAppModality", "AppModality", "", 0, "", "", True)
	cat3.AddRadioButton("rbtTrainingsmode", "TrainingModality", "", 0, "rbtAppModality", mPMAllg.manager.GetMapValue("rbtAppModality", 1), True)

    'add the categories to the main screen
	screen.AddPreferenceCategory(cat1)
	screen.AddPreferenceCategory(cat2)
	screen.AddPreferenceCategory(cat3)
End Sub
#End Region