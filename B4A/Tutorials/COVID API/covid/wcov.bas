B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9.801
@EndOfDesignText@

#Region  Activity Attributes 
	#FullScreen: true
	#IncludeTitle: false
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
 
	Private Label2,label4,label6 As Label

End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("wcov")
	
 
	

	ProgressDialogShow2("waiting...",False)
	
	covid
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

 




Sub covid

	Dim cov1 As HttpJob
	cov1.Initialize("GetAddress", Me)
	cov1.Download("https://coronavirus-19-api.herokuapp.com/all/")
	Wait For (cov1) JobDone(cov1 As HttpJob)
	If cov1.Success Then
		ProgressDialogHide
		Dim parser As JSONParser
		parser.Initialize(cov1.GetString)
		Dim root As Map = parser.NextObject
		Dim recovered As Int = root.Get("recovered")
		Dim cases As Int = root.Get("cases")	
		Dim deaths As Int = root.Get("deaths")
		
	

		Label2.Text=cases
		label4.Text=deaths
		label6.Text=recovered
	
	


	End If


	cov1.Release



End Sub


