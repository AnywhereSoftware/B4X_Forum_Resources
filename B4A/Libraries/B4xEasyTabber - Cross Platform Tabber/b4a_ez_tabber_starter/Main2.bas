B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9.3
@EndOfDesignText@
#if b4a
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: False
#End Region
#end if

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Dim LastTab As Int
#if b4a	
End Sub

Sub Globals
#end if

	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

	
#if b4i
	Private Activity As ActivityClass
	Private ActivityPanel As Panel
#End If	
	Private B4xEasyTabber1 As B4xEasyTabber
End Sub

#if b4i
Sub Globals
	LogColor("Main2 Globals",Colors.Yellow)
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	'Duplicate variables above and here
	'This does not truly create new global variables, but will redim variables
	'that are declared in process globals.  Remember to always add variables to both places
	'when adding UI elements.

	Private Activity As ActivityClass
	Private ActivityPanel As Panel
End Sub
#end if

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	'Activity.LoadLayout("Layout1")
	
	Activity.LoadLayout("main2_menu")
	B4xEasyTabber1.GetTabPanel(0).LoadLayout("tabcontent")
	B4xEasyTabber1.GetTabPanel(1).LoadLayout("tabcontent")
	B4xEasyTabber1.GetTabTitleLabel(0).Text="Tab 1"
End Sub

Sub Activity_Resume
	'restore the tab if returning to the activity or changing orientation
	If LastTab<>B4xEasyTabber1.CurrentTab Then B4xEasyTabber1.CurrentTab=LastTab
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	
End Sub


Sub TableActivityButton_Click

'#if b4a
'	StartActivity(TableActivity)
'#else
'	Main.StartActivity(TableActivity,"TableActivity")
	'#end if
End Sub

#Region Android Compatibility Helpers for b4i
#if b4i
'shouldn't need to modify this code block in most cases
Sub Set_Activity(ParentActivityClass As ActivityClass)
	Activity=ParentActivityClass

	ActivityPanel.Initialize("")
	Activity.ActivityView.RootPanel.AddView(ActivityPanel,0,0,Activity.Width,Activity.Height)
End Sub

Sub AddView_To_ActivityPanel(ParameterMap As Map)
	ActivityPanel.AddView(ParameterMap.Get("View"), ParameterMap.Get("Left"), ParameterMap.Get("Top"), ParameterMap.Get("Width"), ParameterMap.Get("Height"))
End Sub

Sub LoadLayout(Layout As String)
	ActivityPanel.LoadLayout(Layout)
End Sub

Sub RemoveAllViews
'	LogColor("Main2 RemoveAllViews",Colors.Magenta)
	ActivityPanel.RemoveAllViews
End Sub

Sub TestLog(str As String)
	Log("testlog: "&str)
End Sub

Sub ExitApplication
	Main.ExitApplication
End Sub
#End If
#End Region


Sub B4xEasyTabber1_TabChanged (ActiveTabNumber As Int)
	LastTab=ActiveTabNumber
End Sub

Sub SwiftButton1_Click
	If B4xEasyTabber1.CurrentTab=0 Then 
		B4xEasyTabber1.CurrentTab=1
	Else
		B4xEasyTabber1.CurrentTab=0
	End If
End Sub