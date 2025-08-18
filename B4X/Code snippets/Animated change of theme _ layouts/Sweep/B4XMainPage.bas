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
	Private CurrentThemeIsLight As Boolean
	Private SwiftButtons As List
	Private Labels As List
	Private Label1 As B4XView
	Private Label2 As B4XView
	Private Label3 As B4XView
	Private Label4 As B4XView
	Private SwiftButton1 As SwiftButton
	Private bc1, bc2 As BitmapCreator
	Private ImageViewForAnimation As ImageView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	CurrentThemeIsLight = True
	Labels = Array(Label1, Label2, Label3, Label4)
	SwiftButtons = Array(SwiftButton1)
	CurrentThemeIsLight = False
	UpdateTheme
End Sub

Private Sub SetNewTheme As ResumableSub
	If bc1.IsInitialized = False Then
		bc1.Initialize(Root.Width, Root.Height)
		bc2.Initialize(Root.Width, Root.Height)
		ImageViewForAnimation.Initialize("")
	End If
	If ImageViewForAnimation.As(B4XView).Parent.IsInitialized Then Return True 'already in progress...
	bc1.CopyPixelsFromBitmap(Root.Snapshot)
	UpdateTheme
	bc2.CopyPixelsFromBitmap(Root.Snapshot)
	Root.AddView(ImageViewForAnimation, 0, 0, Root.Width, Root.Height)
	bc1.SetBitmapToImageView(bc1.Bitmap, ImageViewForAnimation)
	Dim brush As BCBrush = bc1.CreateBrushFromBitmapCreator(bc2)
	brush.BlendBorders = False
	For r = 1 To Max(bc1.mWidth, bc1.mHeight) / 2 * 1.5 Step 20dip
		Dim task As DrawTask = bc1.AsyncDrawCircle(bc1.mWidth / 2, bc1.mHeight / 2, r, brush, True, 0)
		bc1.DrawBitmapCreatorsAsync(Me, "BC", Array(task))
		Wait For BC_BitmapReady (bmp As B4XBitmap)
		If xui.IsB4J Then bmp = bc1.Bitmap
		bc1.SetBitmapToImageView(bc1.Bitmap, ImageViewForAnimation)
		Sleep(16)
	Next
	ImageViewForAnimation.As(B4XView).RemoveViewFromParent
	Return True
End Sub

Private Sub UpdateTheme
	Dim TextColor As Int = IIf(CurrentThemeIsLight, xui.Color_Black, xui.Color_White)
	Dim Background As Int = IIf(CurrentThemeIsLight, xui.Color_White, xui.Color_Black)
	Dim Background2 As Int = IIf(CurrentThemeIsLight, 0xFFF1F1F1, 0xFF7A7A7A)
	Dim Background3 As Int = IIf(CurrentThemeIsLight, 0xFFC5C0C0, 0xFF969696)
	
	Root.Color = Background
	For Each button As SwiftButton In SwiftButtons
		button.xLBL.TextColor = TextColor
		button.SetColors(Background2, Background3)
	Next
	For Each lbl As B4XView In Labels
		lbl.TextColor = TextColor
		lbl.SetColorAndBorder(Background2, 1dip, Background3, 2dip)
	Next
End Sub

Private Sub SwiftButton1_Click
	CurrentThemeIsLight = Not(CurrentThemeIsLight)
	SetNewTheme
End Sub