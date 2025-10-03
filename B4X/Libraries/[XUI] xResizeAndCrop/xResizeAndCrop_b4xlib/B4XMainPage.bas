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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=\%PROJECT_NAME%.zip

'B4A ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4A\%PROJECT_NAME%.b4a 
'B4i ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4i\%PROJECT_NAME%.b4i 
'B4J ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4J\%PROJECT_NAME%.b4j

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI

	Private ImageDir, ImageFileName As String
#If B4A
	Public Chooser As ContentChooser
#Else If B4i
#Else If B4J
	Private Chooser As FileChooser
#End If
	
	Private xResizeAndCrop1 As xResizeAndCrop
	Private pnlCroppedImage, pnlCustomRatio, pnlRoundCorners As B4XView
	Private cbxWidthHeightRatio As B4XComboBox
	Private edtWidthHeightRatioValue, lblRoundCorners As B4XView
	Private swtRoundCorners As B4XSwitch
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("Main")
	
	xResizeAndCrop1.LoadImage(File.DirAssets, "image0.jpg")
'	xResizeAndCrop1.HandleColor = xui.Color_Red
	xResizeAndCrop1.CroppedView = pnlCroppedImage
#If B4A
#Else If B4i
#Else If B4J
	Chooser.Initialize
#End If
	
	FillWidthHeightRatios
	
	edtWidthHeightRatioValue .Text = xResizeAndCrop1.WidthHeightRatioValue
	lblRoundCorners.Text = xResizeAndCrop1.CornerRadius
	swtRoundCorners.Value = xResizeAndCrop1.RoundCorners
'	If xResizeAndCrop1.WidthHeightRatio = "Circle" Then
'		pnlRoundCorners.Visible = False
'	Else
'		pnlRoundCorners.Visible = True
'	End If
	xResizeAndCrop1.MinCroppedHeight = 160
	xResizeAndCrop1.MinCroppedWidth = 240
End Sub

Private Sub FillWidthHeightRatios
	cbxWidthHeightRatio.SetItems(Array As String("None", "Square", "Circle", "3/2", "2/3", "4/3", "3/4", "16/9", "9/16", "Custom"))
	cbxWidthHeightRatio_SelectedIndexChanged(cbxWidthHeightRatio.IndexOf(xResizeAndCrop1.WidthHeightRatio))
End Sub

Private Sub btnLoadImage_Click
	Private n As Int

#If B4A
	Chooser.Initialize("Chooser")
	Chooser.Show("image/*", "Select an image")
#Else If B4i
	Dim cam As Camera
	cam.Initialize("cam", B4XPages.GetNativeParent(Me))
	cam.SelectFromSavedPhotos(Sender, cam.TYPE_IMAGE)
	Wait For (cam) Cam_Complete(Success As Boolean, Image As B4XBitmap, VideoPath As String)
	If Success Then
		If Image.IsInitialized Then
			xResizeAndCrop1.Image = Image
		End If
	End If
#Else If B4J
	Private lstExtensions As List
	lstExtensions.Initialize2(Array As String("*.bmp", "*.jpg", "*.png"))
	Chooser.SetExtensionFilter("Image files", lstExtensions)
	Chooser.Title = "Select an image file"
	ImageFileName = Chooser.ShowOpen(Main.MainForm)
	If ImageFileName <> "" Then
		Log(ImageFileName)
		n = ImageFileName.LastIndexOf("\")
		ImageDir = ImageFileName.SubString2(0, n)
		ImageFileName = ImageFileName.SubString(n + 1)
		xResizeAndCrop1.LoadImage(ImageDir, ImageFileName)
	End If
#End If
End Sub

Private Sub btnSaveCroppedImage_Click
	Private Dir, FileName As String
	
	xui.SetDataFolder("xResizeAndCropDemo")
	Dir = xui.DefaultFolder
	Log(Dir)
	FileName = "image.png"
	Private Out As OutputStream
	Out = File.OpenOutput(Dir, FileName, False)
	xResizeAndCrop1.CroppedImage.WriteToStream(Out, 100, "PNG")
	Out.Close
	
	'Rezsizes the croped image
'	Out = File.OpenOutput(Dir, "temp.png", False)
'	xResizeAndCrop1.CroppedImage.WriteToStream(Out, 100, "PNG")
'	Out.Close
'	Private bmpTemp As B4XBitmap
'	bmpTemp = xui.LoadBitmapResize(Dir, "temp.jpg", 100, 100, True)
'	Private Out As OutputStream
'	Out = File.OpenOutput(Dir, FileName, False)
'	bmpTemp.WriteToStream(Out, 100, "PNG")
'	Out.Close
'	File.Delete(Dir, "temp.png")
End Sub

Private Sub xResizeAndCrop1_CropFinished
'	Log("Crop finished")
End Sub

Private Sub cbxWidthHeightRatio_SelectedIndexChanged (Index As Int)
	Private Item As String
	
	Item = cbxWidthHeightRatio.GetItem(Index)
	If Item = "Custom" Then
		xResizeAndCrop1.WidthHeightRatioValue = edtWidthHeightRatioValue.Text
		pnlCustomRatio.Visible = True
	Else
		pnlCustomRatio.Visible = False
	End If
	If Item = "Circle" Then
		pnlRoundCorners.Visible = False
	Else
		pnlRoundCorners.Visible = True
	End If
	xResizeAndCrop1.WidthHeightRatio = Item
End Sub

Private Sub btnRotateRight_Click
	xResizeAndCrop1.RotateImage(90)
End Sub

Private Sub btnRotateLeft_Click
	xResizeAndCrop1.RotateImage(-90)
End Sub

Private Sub swtRoundCorners_ValueChanged (Value As Boolean)
	xResizeAndCrop1.RoundCorners = Value
End Sub

Private Sub skbRoundCorners_ValueChanged (Value As Int)
	lblRoundCorners.Text = Value
	xResizeAndCrop1.CornerRadius = Value
End Sub

Private Sub btnCustomRatio_Click
	xResizeAndCrop1.WidthHeightRatioValue = edtWidthHeightRatioValue.Text
End Sub

#If B4A
Private Sub Chooser_Result (Success As Boolean, Dir As String, FileName As String)
	If True Then
		ImageDir = Dir
		ImageFileName = FileName
'		xResizeAndCrop1.LoadImage(ImageDir, ImageFileName)
		xResizeAndCrop1.Image = xui.LoadBitmap(ImageDir, ImageFileName)
		Log(xResizeAndCrop1.Image.Width)
'		xResizeAndCrop1.Image = xui.LoadBitmapResize(ImageDir, ImageFileName, 2000, 2000, True)
	End If
End Sub
#End If