Type=Activity
Version=5.2
ModulesStructureVersion=1
B4A=true
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: True
	#IncludeTitle: false
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

	Dim Accelerometer, Magnetic  As PhoneSensors
   	Dim accValues(), magValues() As Float
  	Dim SM As JavaObject
	
	'	initializes the compass
	'	http://en.wikipedia.org/wiki/Magnetic_declination
	Type MyMD (MAGNETIC_DECLINATION_default  As Float, MAGNETIC_DECLINATION_local  As Float)
	Dim MD  As MyMD
	Dim MAGNETIC_HEADING As Float = 0
	Dim COMPASS_VISIBLE  As Boolean = True
	
	Dim Timer1 As Timer
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

'	create some variables the compass
	Dim Pn1 As Panel
	Dim RG1 As OverlayMapCompass
	
	Dim Label1 As Label

End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("Layout1")
	
'	Location dependent magnetic declination http://magnetic-declination.com/
'	http://en.wikipedia.org/wiki/Magnetic_declination
	MD.Initialize
	MD.MAGNETIC_DECLINATION_default = 5.4786111
	MD.MAGNETIC_DECLINATION_local   = 5.4786111

	'******************* compass **********************************
	Pn1.Initialize("")  'the panel you want to display the gauge on
	Pn1.Color = Colors.Transparent
	Activity.AddView(Pn1, 0dip, 0dip, 100%x, 50%y)
	'**************************************************************
	RG1.Initialize(Pn1, 100dip, 128dip, 100dip, 100dip, 360, "roundback1.png", "roundback2.png", "roundback3.png") 'G,N,B
	'*************************************************************************************************************
	If FirstTime Then
		Accelerometer.Initialize(Accelerometer.TYPE_ACCELEROMETER)
     	Magnetic.Initialize(Magnetic.TYPE_MAGNETIC_FIELD)
     	SM.InitializeStatic("android.hardware.SensorManager")
	End If
	
	Timer1.Initialize("Timer1",   200) 	'  200 =   0.2 seconds
	Timer1.Enabled = False
End Sub

Sub Activity_Resume
	Accelerometer.StartListening("Accelerometer")
   	Magnetic.StartListening("Magnetic")
	COMPASS_VISIBLE = RG1.ChangeVisible(COMPASS_VISIBLE)
	Timer1.Enabled  = COMPASS_VISIBLE
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	Accelerometer.StopListening
   	Magnetic.StopListening
	Timer1.Enabled = False
End Sub

Sub Timer1_Tick
'	Handle tick events
	RG1.ChangeVal(MAGNETIC_HEADING, 0, 0)
	Label1.Text = ((Floor(Round(MAGNETIC_HEADING+MD.MAGNETIC_DECLINATION_local))) & "°" & CRLF & "TRUE HEADING")
End Sub

Sub Accelerometer_SensorChanged (Values() As Float)
	accValues = Values
   	CalcOrientation
End Sub

Sub Magnetic_SensorChanged (Values() As Float)
   	magValues = Values
   	CalcOrientation
End Sub

Sub CalcOrientation
   	If accValues.Length = 0 Or magValues.Length = 0 Then Return
   	Dim R(9), I(9) As Float
   	Dim success As Boolean = SM.RunMethod("getRotationMatrix", Array(R, I, accValues, magValues))
   	If success Then
     	Dim GetOrientation(3) As Float
     	SM.RunMethod("getOrientation", Array(R, GetOrientation))
 		MAGNETIC_HEADING = ((GetOrientation(0) * 180 / cPI + 360) mod 360)
   	End If
End Sub