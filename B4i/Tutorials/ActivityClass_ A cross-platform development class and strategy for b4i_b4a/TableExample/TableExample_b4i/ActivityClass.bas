B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.4
@EndOfDesignText@
Sub Class_Globals
	Dim parentModule As Object
	Dim ActivityEvent As String
	Dim ActivityView As Page
	Dim ActivityWidth, ActivityHeight As Int
	Dim FirstTime As Boolean
End Sub


'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(callingmodule As Object, Event As String)
'	LogColor("Initializing "&Event,Colors.Magenta)
	FirstTime=True
	parentModule=callingmodule
	ActivityEvent=Event
'	CallSub(callingmodule,"Process_Globals")
	ActivityView.Initialize("Activity")
	Main.NavControl.ShowPage(ActivityView)
End Sub

#Region UI Related
Public Sub AddView(V As View,left As Int, top As Int, width As Int, height As Int)
'	ActivityView.RootPanel.AddView(V,left,top,width,height)
'	LogColor($"AddView width=${width}, height=${height}"$, Colors.Yellow)
'	LogColor($"ActivityHeight=${ActivityHeight}, ActivityWidth=${ActivityWidth}"$, Colors.Green)
	CallSub2(parentModule,"AddView_To_ActivityPanel",CreateMap("View":V,"Left":left,"Top":top,"Width":width,"Height":height))
'	CallSub2(parentModule,"TestLog","test")
End Sub

Public Sub RemoveAllViews
	CallSub(parentModule,"RemoveAllViews")
End Sub

Public Sub LoadLayout(Layout As String)
'	Log("ActivityClass LoadLayout "&Layout)
	CallSub2(parentModule, "LoadLayout", Layout)
End Sub

'this is the page resizing on iOS
Private Sub Activity_Resize(Width As Int, Height As Int)
'	LogColor("ActivityClass Activity_Resize",Colors.Magenta)
	ActivityHeight=Height
	ActivityWidth=Width
'	LogColor("Activity_Resize "&ActivityEvent,Colors.green)
	If Not(FirstTime) Then CallSub2(parentModule,"Activity_Pause", False) 'signifies something like changing orientation
	CallSub(parentModule,"Globals")
	CallSub2(parentModule, "Set_Activity", Me)
	Dim ActivityOpenedAlready As Boolean = True
	If Main.ActivitiesOpenedDuringSession.IsInitialized Then
		ActivityOpenedAlready=Main.ActivitiesOpenedDuringSession.IndexOf(ActivityEvent)=-1
	Else
		Main.ActivitiesOpenedDuringSession.Initialize
		ActivityOpenedAlready=False
	End If
	CallSub2(parentModule,"Activity_Create",ActivityOpenedAlready)
	Main.ActivitiesOpenedDuringSession.Add(ActivityEvent)
'	LogColor("android emu after AC "&ActivityEvent,Colors.Blue)
	Activity_Resume
	FirstTime=False
End Sub

#End Region UI Related

#Region Getters and Setters

Public Sub getHeight As Int
	Return ActivityHeight
End Sub

Public Sub getWidth As Int
	Return ActivityWidth
End Sub

#End Region Getters and Setters

#Region Activity Lifecycle
Public Sub Activity_Resume
'	LogColor("Activity_Resume "&ActivityEvent,Colors.Magenta)
	CallSub(parentModule,"Activity_Resume")
End Sub

Public Sub Activity_Pause(UserClosed As Boolean)
'	LogColor("Activity_Pause "&ActivityEvent,Colors.Magenta)
	CallSub2(parentModule,"Activity_Pause",UserClosed)
End Sub

Public Sub Finish
'	LogColor("Finishing activity: "&ActivityEvent,0xFFE16833)
	Main.GoBack(ActivityEvent)
End Sub

#End Region Activity Lifecycle