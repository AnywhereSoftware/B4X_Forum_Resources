B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9.8
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

	Private JSONResults As GetJSONResults

	Private ScrView As ScrollView
	Private ImgFlag As ImageView	
	Private SpnCountries As Spinner
	Private ChkBorder As CheckBox	
	Private BtnBorderColor As Button
	Private BtnLEDColor As Button
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	'Activity.LoadLayout("Layout1")

	ScrView.Initialize(350dip)
	ScrView.Height = Activity.Height
	ScrView.Width = Activity.Width
	ScrView.Panel.LoadLayout("Settings")

	Activity.AddView(ScrView, 0dip, 0dip, Activity.Width, Activity.Height)	

	SetRadius
	JSONResults.Initialize
	Wait For (CallSub(JSONResults, "FetchCoronaJSON")) Complete (Completed As Boolean)
End Sub

Sub Activity_Resume
	LoadSettings
End Sub

Sub Activity_Pause (UserClosed As Boolean)
End Sub

'Load saved settings
Sub LoadSettings
	Sleep(0)

	If LEDCorona.KVS2.GetBitmap("Flag") <> Null Then ImgFlag.Bitmap = LEDCorona.KVS2.GetBitmap("Flag")	

	If LEDCorona.KVS2.Get("Border") = True Then
		ChkBorder.Checked = True
		BtnBorderColor.Enabled = True
	Else
		ChkBorder.Checked = False
		BtnBorderColor.Enabled = False
	End If

	BtnBorderColor.Color = Colors.RGB(LEDCorona.KVS2.Get("BordR"), LEDCorona.KVS2.Get("BordG"), LEDCorona.KVS2.Get("BordB"))
	BtnLEDColor.Color = Colors.RGB(LEDCorona.KVS2.Get("LEDR"), LEDCorona.KVS2.Get("LEDG"), LEDCorona.KVS2.Get("LEDB"))
End Sub

'Add rounded corners (radius) to colour settings button
Sub SetRadius
	Dim Radius As Int = 3dip
	Dim BorderRadius, BackgroundRadius As ColorDrawable

	BorderRadius.Initialize2(Colors.White, Radius, 2dip, Colors.RGB(199, 199, 199))
	BtnBorderColor.Background = BorderRadius

	BackgroundRadius.Initialize2(Colors.White, Radius, 2dip, Colors.RGB(199, 199, 199))
	BtnLEDColor.Background = BackgroundRadius
End Sub

'LED COLOR
Sub BtnLEDColor_Click
	StartActivity(ColourPicker)
	ColourPicker.SetColour = 1
End Sub

'BORDER COLOR
Sub BtnBorderColor_Click
	StartActivity(ColourPicker)
	ColourPicker.SetColour = 2
End Sub

Sub BtnLEDColor_LongClick
	LEDCorona.KVS2.Put("LEDR", 255)
	LEDCorona.KVS2.Put("LEDG", 0)
	LEDCorona.KVS2.Put("LEDB", 0)

	ToastMessageShow("Default LED colour set", False)
	BtnLEDColor.Color = Colors.RGB(LEDCorona.KVS2.Get("LEDR"), LEDCorona.KVS2.Get("LEDG"), LEDCorona.KVS2.Get("LEDB"))
End Sub

Sub BtnBorderColor_LongClick
	LEDCorona.KVS2.Put("BordR", 124)
	LEDCorona.KVS2.Put("BordG", 215)
	LEDCorona.KVS2.Put("BordB", 167)

	ToastMessageShow("Default border colour set", False)
	BtnBorderColor.Color = Colors.RGB(LEDCorona.KVS2.Get("BordR"), LEDCorona.KVS2.Get("BordG"), LEDCorona.KVS2.Get("BordB"))
End Sub

'BORDER CHECKBOS
Sub ChkBorder_CheckedChange(Checked As Boolean)
	If Checked Then
		BtnBorderColor.Enabled = True
		LEDCorona.KVS2.Put("Border", True)
	Else
		BtnBorderColor.Enabled = False
		LEDCorona.KVS2.Put("Border", False)
	End If
End Sub

'POPULATE COUNTRY SPINNER
Public Sub PopulateSpnCountries(Countries As List)
	SpnCountries.AddAll(Countries)
End Sub

'COUNTRY SPINNER
Sub SpnCountries_ItemClick (Position As Int, Value As Object)
	Wait For (CallSub2(JSONResults, "ParseJSONCountry", Value)) Complete (Completed As Boolean)

	Dim CountryInfo As String = JSONResults.MapCountryInfo.Get(SpnCountries.SelectedItem)
	Wait For (CallSub2(JSONResults, "DownloadFlagImage", CountryInfo)) Complete (Flag As Bitmap) '0 = Flag image URL
	ImgFlag.Bitmap = Flag
	
	LEDCorona.KVS2.Put("Country", Value)	
	LEDCorona.KVS2.PutBitmap("Flag", Flag)
End Sub
