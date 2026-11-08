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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=SelfieSegmentation.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private SelfieSegmenter As SelfieSegmentation
	Private ivMask As B4XImageView
	Private ivOriginal As B4XImageView
	Private ivOrigSmall As B4XImageView
	Private ivMaskSmall As B4XImageView
	Private chooser As MediaChooser
	Private effects As BitmapCreatorEffects
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	B4XPages.SetTitle(Me, "Selfie Segmentation")
	Root.LoadLayout("MainPage")
	SelfieSegmenter.Initialize
	chooser.Initialize(Me, "chooser")
	effects.Initialize
End Sub

Private Sub btnChooseImage_Click
	Wait For (chooser.ChooseImage(Sender)) Complete (Result As MediaChooserResult)
	HandeChooserResult(Result)
End Sub

Private Sub btnCaptureImage_Click
	Wait For (chooser.CaptureImage) Complete (Result As MediaChooserResult)
	HandeChooserResult(Result)
End Sub

Private Sub HandeChooserResult (ChooserResult As MediaChooserResult)
	For Each v As B4XView In Root.GetAllViewsRecursive
		If v.Tag Is B4XImageView Then v.Tag.As(B4XImageView).Clear
	Next
	If ChooserResult.Success = False Then Return
	Dim bmp As B4XBitmap = xui.LoadBitmap(ChooserResult.MediaDir, ChooserResult.MediaFile)
	
	'not mandatory but for better performance we will limit the image size.
	If bmp.Width > 2000 Or bmp.Height > 2000 Then bmp = bmp.Resize(2000, 2000, True)
	Log(bmp)
	#if B4A
	If ChooserResult.Mime = "image/jpeg" Then
		bmp = RotateJpegs(ChooserResult, bmp)
	End If
	#end if
	
	'ivOriginal.Bitmap = bmp
	ivOrigSmall.Bitmap = bmp
	ivMask.mBase.Alpha = 0.5
	ivOriginal.mBackgroundColor = xui.Color_Transparent
	Wait For (SelfieSegmenter.Process(bmp)) Complete (res As SelfieSegmentationResult)
	If res.Success Then
		Dim AfterMask As B4XBitmap = RemoveMask(bmp, res.ForegroundBitmap)
		ivOriginal.Bitmap = AfterMask
		ivMaskSmall.Bitmap = res.ForegroundBitmap
	End If
End Sub

Private Sub RemoveMask(Selfie As B4XBitmap, Mask As B4XBitmap) As B4XBitmap
	Dim SelfieBC As BitmapCreator = CreateBC(Selfie)
	Dim MaskBC As BitmapCreator = CreateBC(Mask)
	Dim oldargb, newargb, a As ARGBColor
	SelfieBC.ColorToARGB(xui.Color_Black, oldargb)
	SelfieBC.ColorToARGB(xui.Color_Transparent, newargb)
	For x = 0 To SelfieBC.mWidth - 1
		For y = 0 To SelfieBC.mHeight - 1
			MaskBC.GetARGB(x, y, a)
			If a.r = oldargb.r And a.g = oldargb.g And a.b = oldargb.b Then
				SelfieBC.SetARGB(x, y, newargb)
			End If
		Next
	Next
	Return SelfieBC.Bitmap
End Sub

Private Sub CreateBC(bmp As B4XBitmap) As BitmapCreator
	Dim bc As BitmapCreator
	bc.Initialize(bmp.Width / bmp.Scale, bmp.Height / bmp.Scale)
	bc.CopyPixelsFromBitmap(bmp)
	Return bc
End Sub

#if B4A
'code from SimpleMediaManager
Private Sub RotateJpegs(ChooserResult As MediaChooserResult, bmp As B4XBitmap) As B4XBitmap
	Dim in As InputStream = File.OpenInput(ChooserResult.MediaDir, ChooserResult.MediaFile)
	Dim ExifInterface As JavaObject
	ExifInterface.InitializeNewInstance("android.media.ExifInterface", Array(in))
	Dim orientation As Int = ExifInterface.RunMethod("getAttribute", Array("Orientation"))
	bmp = RotateBitmapBasedOnOrientation(bmp, orientation)
	in.Close
	Return bmp
End Sub

Private Sub RotateBitmapBasedOnOrientation (bmp As B4XBitmap, orientation As Int) As B4XBitmap 'ignore
	Select orientation
		Case 3  '180
			bmp = bmp.Rotate(180)
		Case 6 '90
			bmp = bmp.Rotate(90)
		Case 8 '270
			bmp = bmp.Rotate(270)
	End Select
	Return bmp
End Sub
#End If