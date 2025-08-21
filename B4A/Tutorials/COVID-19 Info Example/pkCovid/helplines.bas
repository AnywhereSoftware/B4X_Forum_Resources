B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9.801
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: True
	#IncludeTitle: true
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private Btn_Back As Button
	Private ListView1 As ListView
	Private Lbl_Location As Label
	Private Lbl_Source As Label
	Private sSrcAPI As String = "https://api.rootnet.in/covid19-in/contacts"
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("countries")

	Lbl_Location.Text = "India Helpline Numbers"
	Lbl_Source.Text = "source » " & sSrcAPI

	ProgressDialogShow2("Downloading data...", False)
End Sub

Sub Activity_Resume
	helplinedata
End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub helplinedata
	ListView1.Clear
	ListView1.SingleLineLayout.ItemHeight = 25dip
	ListView1.SingleLineLayout.Label.TextSize = 16
	ListView1.SingleLineLayout.Label.TextColor = Colors.White
	ListView1.SingleLineLayout.Label.Gravity = Gravity.LEFT
	ListView1.TwoLinesLayout.ItemHeight = 65dip
	ListView1.TwoLinesLayout.Label.TextSize = 12
	ListView1.TwoLinesLayout.Label.TextColor = Colors.ARGB(150, 255, 255, 255)
	ListView1.TwoLinesLayout.Label.Gravity=Gravity.TOP
	ListView1.TwoLinesLayout.SecondLabel.TextSize = 12
	ListView1.TwoLinesLayout.SecondLabel.TextColor = Colors.ARGB(150, 255, 255, 255)
	ListView1.TwoLinesLayout.SecondLabel.Gravity=Gravity.TOP
	
	Dim CovidCountries As HttpJob
	CovidCountries.Initialize("GetDetails", Me)
	CovidCountries.Download(sSrcAPI)

	Wait For (CovidCountries) JobDone(CovidCountries As HttpJob)
	
	ProgressDialogHide
		
	If CovidCountries.Success Then
		Dim parser As JSONParser
		parser.Initialize(CovidCountries.GetString)
					
		Dim root As Map = parser.NextObject
'		Dim lastRefreshed As String = root.Get("lastRefreshed")
		Dim data As Map = root.Get("data")
		Dim contacts As Map = data.Get("contacts")
		Dim regional As List = contacts.Get("regional")
		
		Dim primary As Map = contacts.Get("primary")
		Dim number As String = primary.Get("number")
		Dim twitter As String = primary.Get("twitter")
		Dim numbertollfree As String = primary.Get("number-tollfree")
		Dim facebook As String = primary.Get("facebook")
'		Dim media As List = primary.Get("media")
'		For Each colmedia As String In media
'		Next
		Dim email As String = primary.Get("email")
'		Dim success As String = root.Get("success")
'		Dim lastOriginUpdate As String = root.Get("lastOriginUpdate")
			
		Dim CaseResult1 As String = "Number: " & number & " | Toll-Free: " & numbertollfree & " | Email: " & email
		Dim CaseResult2 As String = "Twitter: " & twitter & " | Facebook: " & facebook
		
		ListView1.AddSingleLine("Primary")
		ListView1.AddTwoLines(CaseResult1, CaseResult2)

		For Each colregional As Map In regional
			Dim loc As String = colregional.Get("loc")
			Dim number As String = colregional.Get("number")
			ListView1.AddSingleLine(loc)
			ListView1.AddTwoLines(number,"")
		Next

	End If

	CovidCountries.Release

End Sub

Sub Btn_Back_Click
	StartActivity(Main)
	Activity.Finish
End Sub


