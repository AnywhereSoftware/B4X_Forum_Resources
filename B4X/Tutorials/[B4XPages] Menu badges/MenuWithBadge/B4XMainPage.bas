B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private CartBitmap As B4XBitmap
	Private IconCanvas As B4XCanvas
	Private BadgeNumber As Int
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	B4XPages.SetTitle(Me, "Menu Icons")
	Root.LoadLayout("MainPage")
	
	CartBitmap = xui.LoadBitmap(File.DirAssets, "cart.png")
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)
	IconCanvas.Initialize(p)
	UpdateMenuItems
End Sub

Private Sub UpdateMenuItems
	Dim bmp As B4XBitmap = CreateIconWithBadge(CartBitmap, BadgeNumber)
	#if B4A
	Dim menus As List = B4XPages.GetManager.GetPageInfoFromRoot(Root).Parent.MenuItems
	menus.Clear
	'add menu items
	Dim mi As B4AMenuItem = B4XPages.AddMenuItem(Me, "cart")
	mi.AddToBar = True
	mi.Bitmap = bmp
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	ctxt.RunMethod("invalidateOptionsMenu", Null)
	#else if B4i
	Dim bb As BarButton
	bb.InitializeBitmap(Main.KeepOriginalColors(bmp), "cart")
	B4XPages.GetNativeParent(Me).TopRightButtons = Array(bb)
	#end if
End Sub

Private Sub CreateIconWithBadge(bmp As B4XBitmap, Number As Int) As B4XBitmap
	IconCanvas.ClearRect(IconCanvas.TargetRect)
	IconCanvas.DrawBitmap(bmp, IconCanvas.TargetRect)
	Number = Min(Number, 9)
	If Number > 0 Then
		Dim cx As Int = IconCanvas.TargetRect.Width - 8dip
		Dim cy As Int = 8dip
		IconCanvas.DrawCircle(cx, cy, cy, Colors.Red, True, 0)
		Dim fnt As B4XFont = xui.CreateDefaultBoldFont(12)
		Dim r As B4XRect = IconCanvas.MeasureText(Number, fnt)
		Dim BaseLine As Int = cy - r.Height / 2 - r.Top
		IconCanvas.DrawText(Number, cx, BaseLine, fnt, xui.Color_White, "CENTER")
	End If
	Return IconCanvas.CreateBitmap
End Sub

Private Sub btnIncrement_Click
	BadgeNumber = BadgeNumber + 1
	UpdateMenuItems
End Sub

Private Sub btnClear_Click
	BadgeNumber = 0
	UpdateMenuItems
End Sub

Private Sub B4XPage_MenuClick (Tag As String)
	Log(Tag)
End Sub