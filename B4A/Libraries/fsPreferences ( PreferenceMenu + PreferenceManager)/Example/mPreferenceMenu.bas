B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=7.3
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: False
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	
	Dim screen As clsPreferenceScreen
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("frmPreferenceScreen")

	Dim ph As Phone
	ph.SetScreenOrientation(-1)
	
End Sub

Sub Activity_Resume
'	Log("Activity_Resume")
	CreatePreferenceScreen
End Sub

Sub Activity_Pause (UserClosed As Boolean)
End Sub

#Region "Settings-Menu"
Sub CreatePreferenceScreen
	Dim lstSpeedUnits,lstDistanceUnits As List
	lstSpeedUnits.Initialize
	lstSpeedUnits.AddAll(Array As String("kmh","minKm"))

	lstDistanceUnits.Initialize
	lstDistanceUnits.AddAll(Array As String("m","km","mile","yard"))

	Dim lstServer As List
	lstServer.Initialize
	lstServer = File.ReadList(File.DirAssets,"ntpserver.txt")

	Dim lstRadioButton As List
	lstRadioButton.Initialize
	lstRadioButton.AddAll(Array As String("Radio 1","Radio 2","Radio 3","Radio 4","Radio 5"))

	screen.Clear
	
    'create one categories
	Dim cat1,cat2,cat3 As clsPMCategory
    cat1.Initialize("Units")
	cat1.AddList("lstDistanceUnits","DistanceUnits","Das ist ein Test","","","",True,lstDistanceUnits)
	cat1.AddList("lstSpeedUnits","SpeedUnits","","","","",True,lstSpeedUnits)
	cat1.AddScrollView("lstScrollView", "NTP-Server", "Das ist ein Test","","lstSpeedUnits","kmh",True,lstServer)
	
    cat2.Initialize("LapSetting")
    cat2.AddEditText2("txtLapDistance", "LapDistance",2,"","","","", True)
	cat2.AddSeekBar("lstStrokRate","Strokrate","",3,2,6,"txtLapDistance","100",True)
	cat2.AddCheckBox("cbxShowDetailsAsTable","ShowDetailsAsTable","Table nur ein test für die Label-höhe und nochmal ein Test!","Text",True,"lstStrokRate","5",True)
 
	cat3.Initialize("Alarm")
	cat3.AddEditText2("txtBeepCount", "Sekunden-Anzahl",2, "Die Sekunden-Anzahl eintragen um die Zeit-unterschied zwischen GPS-Uhr und Funkuhr abzugleichen (manche GPS-Chips können die Zeit-unterschied nicht selber angleichen).", "10","cbxShowDetailsAsTable","",True)
	cat3.AddSeekBar("lstVolume","Volume","prozent",5,0,10,"","",True)
	cat3.AddSeekBar("lstSekbar","New Sekbar","prozent",0,-10,10,"","",True)
	cat3.AddRadioButton("RadioButton2", "RadioButton", "Table nur ein test für die Label-höhe und nochmal ein Test! Table nur ein test für die Label-höhe und nochmal ein Test!", 0,"","",True)
	cat3.AddRadioButton("rbtAppModality", "AppModality", "", 0, "", "", True)
	cat3.AddRadioButton("rbtTrainingsmode", "TrainingModality", "", 0, "rbtAppModality", mAllgemein.manager.GetMapValue("rbtAppModality", 1), True)

    'add the categories to the main screen
    screen.AddPreferenceCategory(cat1)
	screen.AddPreferenceCategory(cat2)
	screen.AddPreferenceCategory(cat3)
End Sub
#End Region