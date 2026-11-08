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

'Ctrl + click To export As zip: ide://run?File=%B4X%\Zipper.jar&Args=\%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI

	Private EXIF As ReadEXIFData

	Private LstVOutput As ListView

	Private LastDir, LastFile As String
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	EXIF.Initialize("EXIF")
End Sub

Private Sub btnSelect_Click
	Dim FC As FileChooser
		FC.Initialize
		FC.Title = "Select an image"
		FC.SetExtensionFilter("Images", Array As String("*.jpg","*.jpeg","*.png","*.tif","*.tiff","*.webp","*.heic","*.heif"))

	Dim FullPath As String = FC.ShowOpen(Main.MainForm)
	If FullPath = "" Then Return

	LastDir = File.GetFileParent(FullPath)
	LastFile = File.GetName(FullPath)

	LstVOutput.Items.Clear
	LstVOutput.Items.Add("Reading metadata...")

	EXIF.ReadMetadata(LastDir, LastFile)
End Sub

'EVENTS FROM THE WRAPPER

Private Sub exif_OnMetadataReady (Success As Boolean, Result As Map)
	LstVOutput.Items.Clear

	If Success = False Then
		LstVOutput.Items.Add("Failed to read metadata.")
		Return
	End If

	'FULL METADATA MAP
	LstVOutput.Items.Add("=== FULL METADATA MAP ===")
	LstVOutput.Items.Add("Entries: " & Result.Size)
	LstVOutput.Items.Add("")

	For Each k As String In Result.Keys
		LstVOutput.Items.Add(k & " = " & Result.Get(k))
	Next

	LstVOutput.Items.Add("")
	LstVOutput.Items.Add("=== HELPER FUNCTIONS ===")
	LstVOutput.Items.Add("")

	'EXIF ONLY
	Dim exifOnly As Map = EXIF.GetExifOnly(LastDir, LastFile)
	LstVOutput.Items.Add("EXIF Only:")
	For Each k As String In exifOnly.Keys
		LstVOutput.Items.Add("   " & k & ": " & exifOnly.Get(k))
	Next
	LstVOutput.Items.Add("")

	'GPS ONLY
	Dim gpsOnly As Map = EXIF.GetGpsOnly(LastDir, LastFile)
	LstVOutput.Items.Add("GPS Only:")
	For Each k As String In gpsOnly.Keys
		LstVOutput.Items.Add("   " & k & ": " & gpsOnly.Get(k))
	Next
	LstVOutput.Items.Add("")

	'GPS LOCATION
	Dim GPS As Map = EXIF.GetGpsLocation(LastDir, LastFile)
	LstVOutput.Items.Add("GPS Location:")
	If GPS.Size > 0 Then
		LstVOutput.Items.Add("   Latitude: " & GPS.Get("Latitude"))
		LstVOutput.Items.Add("   Longitude: " & GPS.Get("Longitude"))
	Else
		LstVOutput.Items.Add("   No GPS location")
	End If
	LstVOutput.Items.Add("")

	'IPTC ONLY
	Dim IPTC As Map = EXIF.GetIptcOnly(LastDir, LastFile)
	LstVOutput.Items.Add("IPTC Only:")
	For Each k As String In IPTC.Keys
		LstVOutput.Items.Add("   " & k & ": " & IPTC.Get(k))
	Next
	LstVOutput.Items.Add("")

	'XMP ONLY
	Dim XMP As Map = EXIF.GetXmpOnly(LastDir, LastFile)
	LstVOutput.Items.Add("XMP Only:")
	For Each k As String In XMP.Keys
		LstVOutput.Items.Add("   " & k & ": " & XMP.Get(k))
	Next
	LstVOutput.Items.Add("")

	'ICC ONLY
	Dim ICC As Map = EXIF.GetIccOnly(LastDir, LastFile)
	LstVOutput.Items.Add("ICC Only:")
	For Each k As String In ICC.Keys
		LstVOutput.Items.Add("   " & k & ": " & ICC.Get(k))
	Next
	LstVOutput.Items.Add("")

	'CAMERA INFO
	Dim Cam As Map = EXIF.GetCameraInfo(LastDir, LastFile)
	LstVOutput.Items.Add("Camera Info:")
	For Each k As String In Cam.Keys
		LstVOutput.Items.Add("   " & k & ": " & Cam.Get(k))
	Next
	LstVOutput.Items.Add("")

	'DATE TAKEN
	Dim DT As String = EXIF.GetDateTaken(LastDir, LastFile)
	LstVOutput.Items.Add("Date Taken: " & DT)
	LstVOutput.Items.Add("")

	'ALL DIRECTORIES
	Dim Dirs As List = EXIF.GetAllDirectories(LastDir, LastFile)
	LstVOutput.Items.Add("All Directories:")
	For Each d As String In Dirs
		LstVOutput.Items.Add("   " & d)
	Next
	LstVOutput.Items.Add("")

	'ALL AS JSON
	Dim JSON As String = EXIF.GetAllAsJson(LastDir, LastFile)
	LstVOutput.Items.Add("All As JSON:")
	LstVOutput.Items.Add(JSON)
	LstVOutput.Items.Add("")
End Sub

Private Sub EXIF_OnError (Message As String)
	LstVOutput.Items.Add("ERROR: " & Message)
End Sub

Private Sub EXIF_OnGpsFound (HasLocation As Boolean, Latitude As Double, Longitude As Double)
	If HasLocation Then
		LstVOutput.Items.Add("GPS Event: " & Latitude & ", " & Longitude)
	Else
		LstVOutput.Items.Add("GPS Event: No location")
	End If
End Sub

Private Sub EXIF_OnThumbnailReady (Success As Boolean, Thumbnail() As Byte)
	If Success Then
		LstVOutput.Items.Add("Thumbnail extracted (" & Thumbnail.Length & " bytes)")
	Else
		LstVOutput.Items.Add("No thumbnail found")
	End If
End Sub
