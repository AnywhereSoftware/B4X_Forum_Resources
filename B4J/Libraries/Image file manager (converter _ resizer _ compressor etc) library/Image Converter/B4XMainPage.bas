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

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI

	Private ImgCon As ImageConverter
	Private SubFolder As String = "New Images"

	'UI Controls
	Private BtnSelectFile, BtnConvertFile, BtnSelectFolder, BtnConvertFolder, BtnStopConverting As B4XView
	Private LblSelectedFile, LblStatus As B4XView
	Private CmbFormats, CmbQuality As B4XComboBox
	Private PBarConverted As ProgressBar

	'State variables
	Private SelectedSourcePath, SelectedSourceFolder, SelectedSourceFileName As String
	Private SelectedSourceFolderDir As String
End Sub

Public Sub Initialize
	'B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	B4XPages.SetTitle(Me, "Image Converter")
	B4XPages.GetNativeParent(me).Resizable = False
	B4XPages.GetNativeParent(Me).Icon = XUI.LoadBitmap(File.DirAssets, "logo.png")

	CmbFormats.mBase.SetColorAndBorder(XUI.Color_Transparent, 0, 0, 0)
	CmbQuality.mBase.SetColorAndBorder(XUI.Color_Transparent, 0, 0, 0)
	BtnStopConverting.As(Button).Style = "-fx-font-weight: bold;"

	ImgCon.Initialize("ImgCon")
	ImgCon.UseCompression = True

	'Populate CmbFormats with the available writer formats
	PopulateFormats

	'Populate CmbQuality with values 0 to 100 for jpg/jpeg quality
	PopulateQuality

	'Set initial state of UI
	LblSelectedFile.Text = "No file selected."
	LblStatus.Text = "Ready"
	BtnConvertFile.Enabled = False
	BtnConvertFolder.Enabled = False
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub PopulateFormats()
	'Fetch writer formats
	Dim Writers() As String = ImgCon.SupportedWriterFormats
	Dim ListFormats As List
		ListFormats.Initialize

	For Each fmt As String In Writers
		Dim LowerFmt As String = fmt.ToLowerCase
		If Not(ListFormats.IndexOf(LowerFmt) > -1) Then
			ListFormats.Add(LowerFmt)
		End If
	Next

	ListFormats.Sort(True)
	CmbFormats.SetItems(ListFormats)

	If ListFormats.Size > 0 Then
		CmbFormats.SelectedIndex = CmbFormats.IndexOf("jpg")
	End If
End Sub

Private Sub PopulateQuality()
	Dim LstQuality As List
		LstQuality.Initialize

	For i = 0 To 100
		LstQuality.Add(i)
	Next

	CmbQuality.SetItems(LstQuality)
	CmbQuality.SelectedIndex = 63
End Sub

Private Sub CmbFormats_SelectedIndexChanged (Index As Int)
	If CmbFormats.SelectedItem = "jpg" Or CmbFormats.SelectedItem = "jpeg" Then
		CmbQuality.mBase.Enabled = True
	Else
		CmbQuality.mBase.Enabled = False
	End If
End Sub

'Select an image file via open file dialog
Private Sub BtnSelectFile_Click
	Dim Chooser As FileChooser
		Chooser.Initialize
		Chooser.InitialDirectory = File.Combine(GetSystemProperty("user.home", ""), "Desktop")
		Chooser.Title = "Select Image File"
		Chooser.SetExtensionFilter("Image Files", Array As String("*.png", "*.jpg", "*.jpeg", "*.webp", "*.tga", "*.targa", "*.bigtiff", "*.tiff", "*.tif", "*.bmp", "*.gif", "*.ico", "*.iff", "*.pcx", "*.pict", "*.pct", "*.sgi"))

	Dim Result As String = Chooser.ShowOpen(B4XPages.GetNativeParent(Me))
	If Result <> "" Then
		SelectedSourcePath = Result
		SelectedSourceFolder = File.GetFileParent(SelectedSourcePath)
		SelectedSourceFileName = File.GetName(SelectedSourcePath)

		LblSelectedFile.Text = SelectedSourceFileName
		LblStatus.Text = "File loaded. Ready to convert."
		BtnConvertFile.Enabled = True
	End If
End Sub

'Convert the selected file and saving it in a sub folder
Private Sub BtnConvertFile_Click
	If SelectedSourcePath = "" Then
		XUI.MsgboxAsync("Please select an image file first.", "Error")
		Return
	End If

	If CmbFormats.SelectedIndex < 0 Then
		XUI.MsgboxAsync("Please select a target format.", "Error")
		Return
	End If

	Dim TargetFormat As String = CmbFormats.GetItem(CmbFormats.SelectedIndex)

	Dim BaseName As String = SelectedSourceFileName
	Dim Dot As Int = BaseName.LastIndexOf(".")

	If Dot > 0 Then
		BaseName = BaseName.SubString2(0, Dot)
	End If

	Dim TargetSubFolder As String = File.Combine(SelectedSourceFolder, SubFolder & " - " & CmbFormats.SelectedItem)
	If Not(File.IsDirectory(SelectedSourceFolder, SubFolder & " - " & CmbFormats.SelectedItem)) Then
		File.MakeDir(SelectedSourceFolder, SubFolder & " - " & CmbFormats.SelectedItem)
	End If

	Dim TargetPath As String = File.Combine(TargetSubFolder, BaseName & "." & TargetFormat)

	LblStatus.Text = "Converting..."
	BtnConvertFile.Enabled = False
	BtnSelectFile.Enabled = False
	BtnConvertFolder.Enabled = False
	BtnSelectFolder.Enabled = False

	Dim NewWidth As Int = 800
	Dim NewHeight As Int = 600
	Dim KeepProportions As Boolean = True
	Dim Quality As Int = CmbQuality.SelectedItem

	ImgCon.ConvertImage(SelectedSourcePath, TargetPath, TargetFormat, NewWidth, NewHeight, KeepProportions, Quality)
End Sub

'Single conversion complete
Sub ImgCon_Complete (Success As Boolean, SourcePath As String, TargetPath As String, Message As String)
	BtnConvertFile.Enabled = True
	BtnSelectFile.Enabled = True

	If SelectedSourceFolderDir <> "" Then
		BtnConvertFolder.Enabled = True
	End If

	BtnSelectFolder.Enabled = True

	If Success Then
		LblStatus.Text = "Converted successfully: " & File.GetName(TargetPath)
		Log("Conversion successful: " & TargetPath)
	Else
		LblStatus.Text = "Conversion failed: " & ImgCon.LastError
		Log("Conversion failed: " & Message & " | Error: " & ImgCon.LastError)
	End If
End Sub

Sub ImgCon_Progress (Percent As Int, CurrentFile As String)
	PBarConverted.Progress = MapRange(Percent, 0, 100, 0, 1)
	LblStatus.Text = $"Converting ${Percent}%${CRLF}${File.GetName(CurrentFile).Trim}"$
	If Percent = 100 Then PBarConverted.Visible = False
End Sub

Sub ImgCon_MetadataComplete (Meta As Map)
	If Meta.Size > 0 Then
		LblStatus.Text = "Read metadata successfully:"
		Log("Read metadata successfully:")
		
		For Each Key As String In Meta.Keys
			Dim FullLine As String = Key & " = " & Meta.Get(Key)
			Dim Matcher As Matcher = Regex.Matcher("\[(.*?)\](\s*=\s*.*)", FullLine)
			
			If Matcher.Find Then
				Log(Matcher.Group(1) & " " & Matcher.Group(2))
			End If
		Next
	Else
		LblStatus.Text = "Read metadata failed" & ImgCon.LastError
		Log("Read metadata failed: " & ImgCon.LastError)
	End If
End Sub

Private Sub MapRange(Value As Float, FromLow As Float, FromHigh As Float, ToLow As Float, ToHigh As Float) As Float
	Return ToLow + (ToHigh - ToLow) * ((Value - FromLow) / (FromHigh - FromLow))
End Sub

Sub ImgCon_FolderComplete (Success As Boolean, Count As Int, Message As String)
	BtnConvertFile.Enabled = True
	BtnSelectFile.Enabled = True

	If SelectedSourceFolderDir <> "" Then
		BtnConvertFolder.Enabled = True
	End If

	BtnSelectFolder.Enabled = True
	PBarConverted.Visible = False
	PBarConverted.Progress = 0

	If Success Then
		LblStatus.Text = "Batch complete! Converted " & Count & " files."
		Log("Folder conversion successful. Total converted: " & Count)
	Else
		LblStatus.Text = "Batch failed: " & Message
		Log("Folder conversion failed: " & Message)
	End If
End Sub

Private Sub BtnSelectFolder_Click
	Dim DirChooser As DirectoryChooser
		DirChooser.Initialize
		DirChooser.Title = "Select Source Folder"
		DirChooser.InitialDirectory = File.Combine(GetSystemProperty("user.home", ""), "Desktop")

	Dim Result As String = DirChooser.Show(B4XPages.GetNativeParent(Me))
	If Result <> "" Then
		SelectedSourceFolderDir = Result
		LblSelectedFile.Text = "Folder: " & Result
		LblStatus.Text = "Source folder loaded. Ready for batch conversion."
		BtnConvertFolder.Enabled = True
	End If
End Sub

Private Sub BtnConvertFolder_Click
	If SelectedSourceFolderDir = "" Then
		XUI.MsgboxAsync("Please select a source folder first.", "Error")
		Return
	End If
	
	If CmbFormats.SelectedIndex < 0 Then
		XUI.MsgboxAsync("Please select a target format.", "Error")
		Return
	End If
	
	Dim targetFormat As String = CmbFormats.GetItem(CmbFormats.SelectedIndex)
	
	Dim TargetDir As String = File.Combine(SelectedSourceFolderDir, SubFolder & " - " & CmbFormats.SelectedItem)
	If Not(File.IsDirectory(SelectedSourceFolderDir, SubFolder & " - " & CmbFormats.SelectedItem)) Then
		File.MakeDir(SelectedSourceFolderDir, SubFolder & " - " & CmbFormats.SelectedItem)
	End If
	
	LblStatus.Text = "Converting folder..."

	BtnConvertFolder.Enabled = False
	BtnSelectFolder.Enabled = False
	BtnConvertFile.Enabled = False
	BtnSelectFile.Enabled = False
	PBarConverted.Visible = True
	
	Dim NewWidth As Int = 0
	Dim NewHeight As Int = 0
	Dim KeepProportions As Boolean = True
	Dim Quality As Int = CmbQuality.SelectedItem
	
	ImgCon.ConvertFolder(SelectedSourceFolderDir, TargetDir, targetFormat, NewWidth, NewHeight, KeepProportions, Quality)
End Sub

Private Sub BtnResizeImage_Click
	If CmbFormats.SelectedIndex < 0 Then
		XUI.MsgboxAsync("Please select a target format.", "Error")
		Return
	End If
	
	Dim TargetFormat As String = CmbFormats.GetItem(CmbFormats.SelectedIndex)
	
	Dim Chooser As FileChooser
		Chooser.Initialize
		Chooser.InitialDirectory = File.Combine(GetSystemProperty("user.home", ""), "Desktop")
		Chooser.Title = "Select Image to Resize"
		Chooser.SetExtensionFilter("Image Files", Array As String("*.png", "*.jpg", "*.jpeg", "*.webp", "*.tga", "*.targa", "*.bigtiff", "*.tiff", "*.tif", "*.bmp", "*.gif", "*.ico", "*.iff", "*.pcx", "*.pict", "*.pct", "*.sgi"))
		
	Dim Result As String = Chooser.ShowOpen(B4XPages.GetNativeParent(Me))
	LblSelectedFile.Text = File.GetName(Result)
	
	If Result <> "" Then
		Dim SourcePath As String = Result
		Dim SourceFolder As String = File.GetFileParent(SourcePath)
		Dim SourceFileName As String = File.GetName(SourcePath)
		
		Dim BaseName As String = SourceFileName
		Dim Dot As Int = BaseName.LastIndexOf(".")
		
		If Dot > 0 Then
			BaseName = BaseName.SubString2(0, Dot)
		End If
		
		Dim TargetSubFolder As String = File.Combine(SourceFolder, SubFolder & " - " & CmbFormats.SelectedItem)
		If Not(File.IsDirectory(SourceFolder, SubFolder & " - " & CmbFormats.SelectedItem)) Then
			File.MakeDir(SourceFolder, SubFolder & " - " & CmbFormats.SelectedItem)
		End If

		Dim TargetPath As String = File.Combine(TargetSubFolder, BaseName & "_resized." & TargetFormat)

		Dim NewWidth As Int = 800
		Dim NewHeight As Int = 600
		Dim KeepProportions As Boolean = True
		Dim Quality As Int = CmbQuality.SelectedItem
		
		Dim Success As Boolean = ImgCon.ResizeImage(SourcePath, TargetPath, NewWidth, NewHeight, TargetFormat, KeepProportions, Quality)
		
		If Success Then
			LblStatus.Text = "Resized image successfully: " & SourceFileName
			Log("Resized image successfully: " & TargetPath)
		Else
			LblStatus.Text = "Resize image failed: " & ImgCon.LastError
			Log("Resize image failed: " & ImgCon.LastError)
		End If
	End If
End Sub

Private Sub BtnReadMetaData_Click
	Dim Chooser As FileChooser
		Chooser.Initialize
		Chooser.InitialDirectory = File.Combine(GetSystemProperty("user.home", ""), "Desktop")
		Chooser.Title = "Select Image to Read Metadata"
		Chooser.SetExtensionFilter("Image Files", Array As String("*.png", "*.jpg", "*.jpeg", "*.webp", "*.tga", "*.targa", "*.bigtiff", "*.tiff", "*.tif", "*.bmp", "*.gif", "*.ico", "*.iff", "*.pcx", "*.pict", "*.pct", "*.sgi"))

	Dim Result As String = Chooser.ShowOpen(B4XPages.GetNativeParent(Me))
	LblSelectedFile.Text = File.GetName(Result)

	If Result <> "" Then
		ImgCon.GetMetadata(Result)
	Else
		LblStatus.Text = "Read metadata failed"
		Log("Read metadata failed: " & ImgCon.LastError)
	End If
End Sub

Private Sub BtnImageInfo_Click
	Dim Chooser As FileChooser
		Chooser.Initialize
		Chooser.InitialDirectory = File.Combine(GetSystemProperty("user.home", ""), "Desktop")
		Chooser.Title = "Select Image to Read Metadata"
		Chooser.SetExtensionFilter("Image Files", Array As String("*.png", "*.jpg", "*.jpeg", "*.webp", "*.tga", "*.targa", "*.bigtiff", "*.tiff", "*.tif", "*.bmp", "*.gif", "*.ico", "*.iff", "*.pcx", "*.pict", "*.pct", "*.sgi"))

	Dim Result As String = Chooser.ShowOpen(B4XPages.GetNativeParent(Me))
	LblSelectedFile.Text = File.GetName(Result)

	If Result <> "" Then
		LblStatus.Text = "Read info successfully: " & File.GetName(Result)
		Log("Read info successfully: " & File.GetName(Result))
		XUI.MsgboxAsync(ImgCon.GetImageInfo(Result), "Basic image info")
	Else
		LblStatus.Text = "Reading info failed" & ImgCon.LastError
		Log("Reading info failed: " & ImgCon.LastError)
	End If
End Sub

Private Sub BtnRotateImage_Click
	Dim Chooser As FileChooser
		Chooser.Initialize
		Chooser.InitialDirectory = File.Combine(GetSystemProperty("user.home", ""), "Desktop")
		Chooser.Title = "Select Image to Rotate"
		Chooser.SetExtensionFilter("Image Files", Array As String("*.png", "*.jpg", "*.jpeg", "*.webp", "*.tga", "*.targa", "*.bigtiff", "*.tiff", "*.tif", "*.bmp", "*.gif", "*.ico", "*.iff", "*.pcx", "*.pict", "*.pct", "*.sgi"))
	
	Dim Result As String = Chooser.ShowOpen(B4XPages.GetNativeParent(Me))
	LblSelectedFile.Text = File.GetName(Result)
	
	If Result <> "" Then
		Dim SourceFolder As String = File.GetFileParent(Result)
		Dim FileName As String = File.GetName(Result)

		Dim TargetSubFolder As String = File.Combine(SourceFolder, SubFolder)
		If Not(File.IsDirectory(SourceFolder, SubFolder)) Then File.MakeDir(SourceFolder, SubFolder)

		Dim TargetPath As String = File.Combine(TargetSubFolder, FileName.Replace(ImgCon.GetFormat(Result), "") & "_rotated." & ImgCon.GetFormat(Result))

		Dim Success As Boolean = ImgCon.RotateImage(Result, TargetPath, 90, ImgCon.GetFormat(Result))
		If Success Then
			LblStatus.Text = "Resized image successfully: " & Result
			Log("Resize image successfully: " & Result)
		Else
			LblStatus.Text = "Resize image failed: " & ImgCon.LastError
			Log("Resize image failed: " & ImgCon.LastError)
		End If		
	End If
End Sub

Private Sub BtnStopConverting_Click
	ImgCon.Stop
	PBarConverted.Visible = False
End Sub

'Here is exactly what this library can and cannot convert using the bundled registered ImageIO readers/writers.

'Global Rules, you must remember these hard limits:

'1. Target availability: Determined at runtime via ImageIO writers. The wrapper can write the formats exposed by the registered ImageIO
' writers. WebP, PCX and SGI are read-only in this wrapper.

'2. ICO targeting: ICO has a registered writer and can be written by the conversion methods. It is only filtered out of the
' SupportedWriterFormats() list.

'3. GIF targeting: GIF output depends on the registered GIF writer accepting the BufferedImage colour/sample model supplied to it.
' The wrapper does not perform automatic colour quantisation.

'4. WBMP targeting: The wrapper explicitly converts the source to TYPE_BYTE_BINARY before writing WBMP.

'5. BMP targeting: The wrapper explicitly converts the image to TYPE_3BYTE_BGR and flattens transparency onto a white background.

'6. JPEG/JPG targeting: The wrapper explicitly converts the image to TYPE_INT_RGB and flattens transparency onto a white background.

'7. WebP is supported as a source format only. The wrapper does not provide WebP output.

'8. PCX and SGI are supported as source formats only. The bundled' TwelveMonkeys plugins do not provide writers for these formats.

'Format Breakdown:

' SUPPORTED SOURCE FORMATS

' The following source formats are supported:
' *.png, *.jpg, *.jpeg, *.webp, *.tiff, *.tif, *.bmp, *.gif,
' *.ico, *.iff, *.pcx, *.pict, *.pct, *.sgi, *.tga, *.targa

' SUPPORTED OUTPUT FORMATS

' The following output formats are supported:
' bigtiff, bmp, gif, ico, iff, jpeg, jpg, pct, 
' pict, png, tga, targa, tif, tiff, wbmp

' WebP, PCX and SGI are supported as source formats only and are
' not supported as output formats.

' 1. Source: *.png
' 2. Source: *.jpg / *.jpeg
' 3. Source: *.webp
' 4. Source: *.tiff / *.tif
' 5. Source: *.bmp
' 6. Source: *.gif
' 7. Source: *.ico
' 8. Source: *.iff
' 9. Source: *.pcx
' 10. Source: *.pict / *.pct
' 11. Source: *.sgi
' 12. Source: *.tga / *.targa

' FORMAT-SPECIFIC CONDITIONS

' - bmp: The wrapper converts the image to TYPE_3BYTE_BGR and
' flattens transparency onto a white background.
' - jpeg/jpg: The wrapper converts the image to TYPE_INT_RGB and
' flattens transparency onto a white background.
' - wbmp: The wrapper converts the source to TYPE_BYTE_BINARY before
' writing. The resulting image is 1-bit monochrome.

' FORMAT-SPECIFIC NOTES

' - WebP: Supported for reading only. WebP is not supported as an
' output format.

' - PCX: Supported for reading only. PCX is not supported as an
' output format.

' - SGI: Supported for reading only. SGI is not supported as an
' output format.

' - TIFF/BigTIFF: BigTIFF is supported for both reading and writing.
' Standard TIFF and BigTIFF are handled as separate ImageIO formats
' where applicable. Only image/page 0 is read. Multi-page TIFFs are
' not preserved.

' - GIF: Only frame 0 is read. Animated GIF frames are not preserved.
' GIF output does not perform automatic colour quantisation.

' - ICO: Supported for both reading and writing by the registered
' TwelveMonkeys ICO reader/writer. Only image/resolution 0 is read.
' Multi-resolution icon containers are not fully preserved.

' - IFF: Supported for both reading and writing.

' - TGA/TARGA: *.tga and *.targa refer to the same Targa image format
' and use the same TGA reader/writer support.

' - PCT/PICT: *.pct and *.pict refer to the Macintosh PICT image
' format and use the same PICT reader/writer support. PICT-specific
' features may not be preserved when converted to a generic
' BufferedImage.

' - All formats: Conversion is performed through Java ImageIO using
' the TwelveMonkeys plugins supplied with this wrapper.
