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
'<INCLUDEFILE>C:\Users\Acer\Documents\abasic\apps\sharedModules\includes\b4i_activity_subs.bas</INCLUDEFILE>
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	LogColor("Main2 Process_Globals",Colors.Yellow)
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
	LogColor("Main2 Activity_Create FirstTime="&FirstTime,Colors.Green)
	Activity.LoadLayout("main2_menu")
End Sub

Sub Activity_Resume
	LogColor("Main2 Activity_Resume",Colors.Magenta)
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	LogColor("Main2 Activity_Pause UserClosed="&UserClosed,Colors.Red)
End Sub


Sub TableActivityButton_Click

'#if b4a
'	StartActivity(TableActivity)
'#else
'	Main.StartActivity(TableActivity,"TableActivity")
'#end if
End Sub



#Region <PRECOMPILER>
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

#End Region </PRECOMPILER>