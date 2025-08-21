B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9.5
@EndOfDesignText@
#if b4a
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
	#Extends: android.support.v7.app.AppCompatActivity	
#End Region
#end if

Sub Process_Globals

#if b4a
End Sub

Sub Globals
	Private ACToolBarLight1 As ACToolBarLight
	Private ToolbarHelper As ACActionBar
#end if
	Private Drawer As B4XDrawer
	Private CustomListView1 As CustomListView
	Private ParentPanel As Panel
	
#if b4i
	Private Activity As ActivityClass
	Private ActivityPanel As Panel
#End If		
End Sub

#if b4i
Sub Globals
	Private Drawer As B4XDrawer
	Private CustomListView1 As CustomListView
	Private ParentPanel As Panel
	Private Activity As ActivityClass
	Private ActivityPanel As Panel
End Sub
#end if

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


Sub Activity_Create(FirstTime As Boolean)
	LogColor("Main2 Activity_Create",Colors.Green)
#if b4i
	SetNavColors(0xFFB0F1FF)
	ActivityPanel.SetBorder(0, 0, 0)
	ActivityPanel.Color = Colors.White
	Drawer.Initialize(Me, "Drawer", ActivityPanel, 300dip)
	Activity.ActivityView.Title="Test"
#else if b4a
	Drawer.Initialize(Me, "Drawer", Activity, 300dip)
#End If


	Drawer.CenterPanel.LoadLayout("1")
#if b4a	
	ToolbarHelper.Initialize
	ToolbarHelper.ShowUpIndicator = True 'set to true to show the up arrow
	Dim bd As BitmapDrawable
	bd.Initialize(LoadBitmap(File.DirAssets, "hamburger.png"))
	ToolbarHelper.UpIndicatorDrawable =  bd
	ACToolBarLight1.InitMenuListener
#else if b4i
	Dim bb As BarButton
	bb.InitializeBitmap(LoadBitmapResize(File.DirAssets, "hamburger.png", 32dip, 32dip, True), "hamburger")
	Activity.ActivityView.TopLeftButtons=Array(bb)
#end if
	Drawer.LeftPanel.LoadLayout("Left")
	CustomListView1.DefaultTextBackgroundColor = 0xFF77CAFF
	For i = 1 To 30
		CustomListView1.AddTextItem("Item " & i, i)
	Next
End Sub

Sub ACToolBarLight1_NavigationItemClick
	Drawer.LeftOpen = Not(Drawer.LeftOpen)
End Sub

#if b4a
Sub Activity_KeyPress (KeyCode As Int) As Boolean 
	If KeyCode = KeyCodes.KEYCODE_BACK And Drawer.LeftOpen Then
		Drawer.LeftOpen = False
		Return True
	End If
	Return False
End Sub
#end if

Sub Activity_Resume
	LogColor("Main2 Activity_Resume",Colors.Green)
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	LogColor("Main2 Activity_Pause UserClosed="&UserClosed,Colors.Green)
End Sub

#if b4i

Private Sub SetNavColors(clr As Int)
	Dim bar As NativeObject = Main.NavControl
	bar.GetField("toolbar").RunMethod("setBarTintColor:", Array(bar.ColorToUIColor(clr)))
	bar = bar.GetField("navigationBar")
	bar.RunMethod("setBarTintColor:", Array(bar.ColorToUIColor(clr)))
	bar.SetField("translucent", False)
	Dim image As NativeObject
	image = image.Initialize("UIImage").RunMethod("new", Null)
	bar.RunMethod("setShadowImage:", Array(image))
	bar.RunMethod("setBackgroundImage:forBarMetrics:", Array(image, 0))
End Sub

Sub Activity_BarButtonClick (Tag As String)
	Log("Main2 Activity_BarButtonClick")

	If Tag = "hamburger" Then
		Drawer.LeftOpen = Not(Drawer.LeftOpen)
	End If
End Sub
#End If