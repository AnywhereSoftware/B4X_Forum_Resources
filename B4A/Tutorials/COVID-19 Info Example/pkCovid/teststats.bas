B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9.801
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: True
	#IncludeTitle: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private Btn_Back As Button
	Private Lbl_TotalSamples_Num As Label
	Private Lbl_IndTested_Num As Label
	Private Lbl_TotalPositive_Num As Label
	Private Lbl_LastUpdated_Num As Label
	Private Lbl_Source As Label
	Private Lbl_Location As Label
	Private sPDFsource As String
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("tests")
		
	Lbl_Location.Text = "Testing Stats (ICMR-DELHI)"
	ProgressDialogShow2("Downloading data...", False)
End Sub

Sub Activity_Resume
	Test_Stats
End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub Test_Stats
	Dim CovidTests As HttpJob
	CovidTests.Initialize("GetDetails", Me)
	CovidTests.Download("https://api.rootnet.in/covid19-in/stats/testing/latest")
	
	Wait For (CovidTests) JobDone(CovidTests As HttpJob)

	ProgressDialogHide
		
	If CovidTests.Success Then
		Dim parser As JSONParser
		parser.Initialize(CovidTests.GetString)

		Dim root As Map = parser.NextObject
'		Dim lastRefreshed As String = root.Get("lastRefreshed")
		Dim data As Map = root.Get("data")
		Dim totalPositiveCases As String = data.Get("totalPositiveCases")
		Dim totalIndividualsTested As String = data.Get("totalIndividualsTested")
		Dim source As String = data.Get("source")
'		Dim day As String = data.Get("day")
		Dim totalSamplesTested As String = data.Get("totalSamplesTested")
'		Dim success As String = root.Get("success")
		Dim lastOriginUpdate As String = root.Get("lastOriginUpdate")
		
		If totalSamplesTested = "null" Then
			Lbl_TotalSamples_Num.Text = "N/A"
		Else
			Lbl_TotalSamples_Num.Text = NumberFormat(totalSamplesTested, 0, 0)
		End If
		
		If totalIndividualsTested = "null" Then
			Lbl_IndTested_Num.Text = "N/A"
		Else
			Lbl_IndTested_Num.Text = NumberFormat(totalIndividualsTested, 0, 0)
		End If
		
		If totalPositiveCases = "null" Then
			Lbl_TotalPositive_Num.Text = "N/A"
		Else
			Lbl_TotalPositive_Num.Text = NumberFormat(totalPositiveCases, 0, 0)
		End If
		
		If lastOriginUpdate = "null" Then
			Lbl_LastUpdated_Num.Text = "N/A"
		Else
			lastOriginUpdate = lastOriginUpdate.Replace("T", " ")
			lastOriginUpdate = lastOriginUpdate.Replace("Z", " ")
			Lbl_LastUpdated_Num.Text = lastOriginUpdate
		End If
		
		If source = "null" Then
			Lbl_LastUpdated_Num.Text = "N/A"
			sPDFsource = ""
		Else
			Lbl_Source.Text = "Source » " &  source
			sPDFsource = source
		End If
	End If

	CovidTests.Release

End Sub

Sub Btn_Back_Click
	StartActivity(Main)
	Activity.Finish
End Sub

Sub Lbl_Source_Click
	If sPDFsource = "" Then
		ToastMessageShow("Source not available!", True)
	Else
		Dim clip As BClipboard
		clip.setText(sPDFsource)
		ToastMessageShow("URL copied to clipboard", True)
	End If
End Sub


