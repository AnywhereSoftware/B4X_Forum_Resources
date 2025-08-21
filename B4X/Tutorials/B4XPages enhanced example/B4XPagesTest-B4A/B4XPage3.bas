B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.86
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Private btnClear As Button
	Private btnSet As Button
	Public pnlTouch As B4XView
	Public cvs As B4XCanvas
	
	
	Dim Drawer As B4XDrawer	
	Private btnDrawer As Button
	Private lviewDrawer As ListView
	Private pnlDrawer As Panel
		
End Sub

'You can add more parameters here.
Public Sub Initialize

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	'Root.LoadLayout("Page3")
	'cvs.Initialize(pnlTouch)
	
	B4XPages.SetTitle(Me, "Draw Something")	

	Drawer.Initialize(Me, "Drawer", Root, 200dip)
	Drawer.CenterPanel.LoadLayout("Page3")
	Drawer.LeftPanel.LoadLayout("left")
	cvs.Initialize(pnlTouch)
	For i = 1 To 10
		lviewDrawer.AddSingleLine("Page3 " & i)
	Next
	
	Dim mi As B4AMenuItem = B4XPages.AddMenuItem(Me, "Random Background")
	mi.AddToBar = True
	' the image will be scaled down but not up from its actual size
	mi.Bitmap = xui.LoadBitmapResize(File.DirAssets, "colors-icon.png", 64dip, 64dip, True)
	B4XPages.AddMenuItem(Me, "Fred")
	B4XPages.AddMenuItem(Me, "Bill")
	B4XPages.AddMenuItem(Me, "Jim")

	Dim ab As JavaObject = B4XPages.GetManager.ActionBar
	Dim listener As Object = ab.CreateEventFromUI("android.app.ActionBar.OnMenuVisibilityListener", "MenuVisible", Null)
	ab.RunMethod("addOnMenuVisibilityListener", Array(listener))
End Sub

Public Sub ClearImage
	If pnlTouch.IsInitialized Then
		cvs.ClearRect(cvs.TargetRect)
		cvs.Invalidate
	End If
End Sub


' Events

Sub MenuVisible_Event (MethodName As String, Args() As Object) As Object
	Drawer.LeftOpen = False
	Return Null
End Sub

Sub pnlTouch_Touch (Action As Int, X As Float, Y As Float)
	If Action <> pnlTouch.TOUCH_ACTION_MOVE_NOTOUCH Then
		cvs.DrawCircle(X, Y, 10dip, Rnd(xui.Color_Black, xui.Color_White), True, 0)
		cvs.Invalidate
	End If
End Sub

Sub btnSet_Click
	B4XPages.ClosePage(Me)
End Sub

Private Sub btnClear_Click
	ClearImage
End Sub

Sub btnDrawer_Click
	Log("Button")
	Drawer.LeftOpen = False
End Sub

Sub lviewDrawer_ItemClick (Position As Int, Value As Object)
	Log("Listview " & Position & " " & Value)
	Drawer.LeftOpen = False	
End Sub

Sub B4XPage_MenuClick (Tag As String)
	Log("MenuItem " & Tag)
	If Drawer.LeftOpen Then
		Drawer.LeftOpen = False
		Sleep(0) ' let it close if open
	End If
	'If Tag = "Random Background" Then
		cvs.DrawRect(cvs.TargetRect, Rnd(xui.Color_Black, xui.Color_White), True, 0)
		cvs.Invalidate
	'End If	
End Sub


'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub B4XPage_Appear	
	Log("Page3 Appeared")	
	
	Sleep(0) '<-- important.
	B4XPages.GetManager.ActionBar.RunMethod("setDisplayHomeAsUpEnabled", Array(True))
	Dim bd As BitmapDrawable ' this will be used at whatever is the actual size
	bd.Initialize(xui.LoadBitmapResize(File.DirAssets, "hamburger-icon.png", 24dip, 24dip, False)) 'better to load the image once and store it in a global variable.
	B4XPages.GetManager.ActionBar.RunMethod("setHomeAsUpIndicator", Array(bd))	
End Sub

Sub B4XPage_Disappear
	Log("Page3 Disappeared")	
	'Only needed if pmgr.ShowUpIndicator = False globally
	'B4XPages.GetManager.ActionBar.RunMethod("setDisplayHomeAsUpEnabled", Array(False))
	B4XPages.GetManager.ActionBar.RunMethod("setHomeAsUpIndicator", Array(0))	
End Sub

Sub B4XPage_Foreground
	Log("Page3 Foreground")
End Sub

Sub B4XPage_Background
	Log("Page3 Background")
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	Log("Page3 CloseRequest")
	If Starter.UseHomeClickForDrawer Then
		Starter.UseHomeClickForDrawer = False
		Drawer.LeftOpen = Not(Drawer.LeftOpen)
		Return False		
	End If
	If Drawer.LeftOpen Then
		Drawer.LeftOpen = False		
		Return False
	End If
	Return True
End Sub

