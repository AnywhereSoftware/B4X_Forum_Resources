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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=EffectsExample.zip&VMArgs=-DZeroSharedFiles%3DTrue

'Run in release mode to test performance (it is very good).
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private CLV As CustomListView
	Private ItemHeight As Int
	Private Label1 As B4XView
	Private OriginalBmp As B4XBitmap
	Private effects As BitmapCreatorEffects
	Private B4XImageView1 As B4XImageView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("Main")
	AddImages
End Sub

Private Sub AddImages
	ItemHeight = 230dip
	effects.Initialize
	
	OriginalBmp = xui.LoadBitmapResize(File.DirAssets, "bas-van-brandwijk-588535-unsplash.jpg",256dip, 192dip, False)
	AddImageAndLabel(effects.FlipHorizontal(effects.FlipHorizontal(OriginalBmp)), "Original")
	AddImageAndLabel(effects.GreyScale(OriginalBmp), "Grey Scale")
	AddImageAndLabel(effects.Negate(OriginalBmp), "Negate")
	Sleep(0) 'allow the layout to appear
	AddImageAndLabel(effects.Blur(OriginalBmp), "Blur")
	AddImageAndLabel(effects.FadeBorders(OriginalBmp, 5), "Fade Borders")
	AddImageAndLabel(effects.Brightness(OriginalBmp, 1.2), "Brightness (1.2)")
	AddImageAndLabel(effects.Brightness(OriginalBmp, 0.8), "Brightness (0.8)")
	
	AddImageAndLabel(effects.Pixelate(OriginalBmp, 5), "Pixelate (5)")
	AddImageAndLabel(effects.Pixelate(OriginalBmp, 10), "Pixelate (10)")
	AddImageAndLabel2(OriginalBmp, "PixelateAnimated (Click)", "Pixelate_Animated")
	Dim mask As B4XBitmap = xui.LoadBitmapResize(File.DirAssets, "mask.png", OriginalBmp.Width, OriginalBmp.Height, False)
	AddImageAndLabel(mask, "Mask Bitmap")
	AddImageAndLabel(effects.DrawThroughMask(OriginalBmp, mask), "DrawThroughMask")
	AddImageAndLabel(effects.DrawOutsideMask(OriginalBmp, mask), "DrawOutsideMask")
	AddImageAndLabel(effects.ReplaceColor(mask, xui.Color_Black, xui.Color_Red, True), "Replace Color")
	
	If xui.IsB4A Or xui.IsB4i Then
		'scaling is not relevant for B4J
		effects.ScaleDownImages = False
		Dim mask As B4XBitmap = xui.LoadBitmapResize(File.DirAssets, "mask.png", OriginalBmp.Width * effects.ImageScale, OriginalBmp.Height * effects.ImageScale, False)
		AddImageAndLabel(effects.ReplaceColor(mask, xui.Color_Black, xui.Color_Red, True), "Replace Color (full scale)")
		effects.ScaleDownImages = True
	End If
	
	AddImageAndLabel2(OriginalBmp, "ImplodeAnimated (4) (Click)", "Implode4_Animated")
	AddImageAndLabel2(OriginalBmp, "ImplodeAnimated (12) (Click)", "Implode12_Animated")
	AddImageAndLabel2(OriginalBmp, "Transition (Click)", "Transition_Animated")
	AddImageAndLabel2(OriginalBmp, "FadeOut (Click)", "FadeOut_Animated")
	AddImageAndLabel(effects.FlipHorizontal(OriginalBmp), "Flip Horizontal")
	AddImageAndLabel(effects.FlipVertical(OriginalBmp), "Flip Vertical")
End Sub


Private Sub Pixelate_Animated (iv As B4XView)
	effects.PixelateAnimated(1000, OriginalBmp, 20, 1, iv)
End Sub

Private Sub Implode4_Animated (iv As B4XView)
	effects.ImplodeAnimated(1500, OriginalBmp, iv, 4)
End Sub

Private Sub Implode12_Animated (iv As B4XView)
	effects.ImplodeAnimated(1500, OriginalBmp, iv, 12)
End Sub

Private Sub Transition_Animated (iv As B4XView)
	Dim ToBmp As B4XBitmap = xui.LoadBitmapResize(File.DirAssets, "berry-delicious-dessert-70861.jpg", OriginalBmp.Width, OriginalBmp.Height, False)
	effects.TransitionAnimated(1500, OriginalBmp, ToBmp, iv)
End Sub

Private Sub FadeOut_Animated (iv As B4XView)
	Dim bc As BitmapCreator = effects.CreateEmptyBC(OriginalBmp)
	bc.FillRect(xui.Color_Black, bc.TargetRect)
	effects.TransitionAnimated(1500, OriginalBmp, bc.Bitmap, iv)
End Sub


Private Sub AddImageAndLabel (bmp As B4XBitmap, text As String)
	AddImageAndLabel2(bmp, text, "")
End Sub

Private Sub AddImageAndLabel2 (bmp As B4XBitmap, text As String, SubName As String)
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, CLV.AsView.Width, ItemHeight)
	p.LoadLayout("ImageAndLabel")
	If bmp.IsInitialized Then
		B4XImageView1.SetBitmap(bmp)
	End If
	Label1.Text = text
	CLV.Add(p, SubName)
End Sub


Private Sub CLV_ItemClick (Index As Int, Value As Object)
	If Value <> "" Then
		Dim SubName As String = Value
		CallSub2(Me, SubName, CLV.GetPanel(Index).GetView(0))
	End If
End Sub




