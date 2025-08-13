B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=6.8
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

'Always extend Preference Activities from this Class!
#Extends: de.amberhome.preferences.AppCompatPreferenceActivity

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private ToolBar As ACToolBarDark
	Private PView As PreferenceView
	Private AC As AppCompat	
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	'Activity.LoadLayout("Layout1")
	Activity.LoadLayout("prefsscreen")

	ToolBar.Color = AC.GetThemeAttribute("colorPrimary")
	Dim AB As ACActionBar
	AB.Initialize
	AB.ShowUpIndicator = True
	AB.HomeVisible = True
	ToolBar.InitMenuListener
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub Activity_ActionBarHomeClick
	Activity.Finish
End Sub

Sub ToolBar_NavigationItemClick
	Activity.Finish
End Sub

Sub PView_Ready (PrefsView As PreferenceView)
	PrefsView.AddCheckBoxPreference("", "dcheck", "Check me for other options", "dependent items are enabled", "dependent items are disabled", False)
	
	Dim Slave As SeekBarPreference
	Slave = PrefsView.AddSeekBarPreference("", "dseek1", "Enable me", "", 0, 0, 10)
	Slave.Dependency="dcheck"
End Sub