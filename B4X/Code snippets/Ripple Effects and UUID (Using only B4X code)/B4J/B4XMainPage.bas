B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	RippleEffect(Sender, xui.Color_LightGray, 400)
End Sub

Private Sub Panel1_MouseClicked (EventData As MouseEvent)
	RippleEffect(Sender, xui.Color_LightGray, 300)
End Sub

Private Sub Label1_MouseClicked (EventData As MouseEvent)
	RippleEffect(Sender, xui.Color_LightGray, 300)
End Sub

Private Sub CheckBox1_CheckedChange(Checked As Boolean)
	RippleEffect(Sender, xui.Color_LightGray, 300)
End Sub

'https://www.b4x.com/android/forum/threads/b4x-xui-simple-halo-animation.80267/#content
Private Sub RippleEffect (Target As B4XView, Color As Int, Duration As Int)
	Dim InnerRadius As Int = Max(Target.Width, Target.Height) * 2
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, InnerRadius, InnerRadius)
	p.Tag = UUID
	Log(p.Tag)
	Dim cvs As B4XCanvas
	cvs.Initialize(p)
	cvs.DrawCircle(cvs.TargetRect.CenterX, cvs.TargetRect.CenterY, cvs.TargetRect.Width / 2, Color, True, 0)
	cvs.Invalidate
	Dim bmp As B4XBitmap = cvs.CreateBitmap
	cvs.ClearRect(cvs.TargetRect)
	cvs.Release
	Dim iv As ImageView
	iv.Initialize("")
	Dim v As B4XView = iv
	v.SetBitmap(bmp)
	Dim Radius As Int = InnerRadius / 2
	Dim x As Int = Target.Width / 2
	Dim y As Int = Target.Height / 2
	Target.Parent.AddView(p, Target.Left, Target.Top, Target.Width, Target.Height)
	p.AddView(v, x, y, 0, 0)
	v.SetLayoutAnimated(Duration, x - Radius, y - Radius, Radius * 2, Radius * 2)
	v.SetVisibleAnimated(Duration, False)
	Sleep(Duration)
	For Each v As B4XView In Target.Parent.GetAllViewsRecursive
		If v.Tag = p.Tag Then v.RemoveViewFromParent
	Next
End Sub

Public Sub UUID As String
#If B4i
   Dim no As NativeObject
   Return no.Initialize("NSUUID").RunMethod("UUID", Null).RunMethod("UUIDString", Null).AsString
#Else
	Dim jo As JavaObject
	Return jo.InitializeStatic("java.util.UUID").RunMethod("randomUUID", Null)
#End If
End Sub