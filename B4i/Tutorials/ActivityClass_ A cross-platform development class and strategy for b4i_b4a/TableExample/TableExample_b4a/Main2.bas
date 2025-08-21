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

#if b4a	
End Sub

Sub Globals
#end if

	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

	Private TableActivityButton As SwiftButton
#if b4i
	Private Activity As ActivityClass
	Private ActivityPanel As Panel
#End If	
End Sub

#if b4i
Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

	Private TableActivityButton As SwiftButton

	Private Activity As ActivityClass
	Private ActivityPanel As Panel
End Sub
#end if

#if b4i
Sub Set_Activity(ParentActivityClass As ActivityClass)
	Activity=ParentActivityClass

	ActivityPanel.Initialize("")
	Activity.ActivityView.RootPanel.AddView(ActivityPanel,0,0,100%x,100%y)
End Sub

Sub AddView_To_ActivityPanel(ParameterMap As Map)
	ActivityPanel.AddView(ParameterMap.Get("View"), ParameterMap.Get("Left"), ParameterMap.Get("Top"), ParameterMap.Get("Width"), ParameterMap.Get("Height"))
End Sub

Sub LoadLayout(Layout As String)
	ActivityPanel.LoadLayout(Layout)
End Sub

Sub TestLog(str As String)
	Log("testlog: "&str)
End Sub

Sub ExitApplication
	Main.ExitApplication
End Sub
#End If

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	'Activity.LoadLayout("Layout1")
	Activity.LoadLayout("main2_menu")
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub


Sub TableActivityButton_Click
#if b4a
	StartActivity(TableActivity)
#else
	Main.StartActivity(TableActivity,"TableActivity")
#end if
End Sub