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
	Private WebView1 As WebView
	Private Lbl_Privacy As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("privacy")
	
	Lbl_Privacy.Text = "Privacy Policy"

	Load_PrivacyPolicy
	
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub Btn_Back_Click
	StartActivity(Main)
	Activity.Finish
End Sub

Sub Load_PrivacyPolicy
	WebView1.ZoomEnabled=True
	WebView1.JavaScriptEnabled = True
	WebView1.LoadUrl("https://sites.google.com/site/rintu1niyor/privacy_pkcovid-19")
End Sub

