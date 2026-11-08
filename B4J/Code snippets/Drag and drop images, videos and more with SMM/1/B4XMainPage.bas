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

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=SMM_Drop.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Pane1 As B4XView
	Private DragAndDrop1 As DragAndDrop
	Private smm As SimpleMediaManager
	Private ExtensionToMime As Map
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	DragAndDrop1.Initialize(Me)
	DragAndDrop1.MakeDragTarget(Pane1, "DropTarget")
	smm.Initialize
	ExtensionToMime = BuildMediaMimeMap
End Sub

Sub DropTarget_DragDropped(e As DragEvent)
	Log("drag dropped")
	Dim filename As String = e.GetDragboard.GetFiles.Get(0)
	Try
		smm.SetMediaFromFile(Pane1, filename, "", GetMime(filename), Null)
	Catch
		Log(LastException)
	End Try
	e.SetDropCompleted(True)
End Sub


Sub DropTarget_DragEntered(e As DragEvent)
	Log("DragEntered")
	Dim clr As Int
	If IsValidDropEvent(e) Then
		clr = xui.Color_Green
	Else
		clr = xui.Color_Red
	End If
	Pane1.SetColorAndBorder(xui.Color_White, 4dip, clr, 0)
End Sub

Sub DropTarget_DragExited(e As DragEvent)
	Pane1.SetColorAndBorder(xui.Color_White, 1dip, xui.Color_LightGray, 2dip)
End Sub

Sub DropTarget_DragOver(e As DragEvent)
	If IsValidDropEvent(e) Then e.AcceptTransferModes(TransferMode.COPY)
End Sub

Private Sub GetMime(fn As String) As String
	Dim i As Int = fn.LastIndexOf(".")
	If i > -1 Then
		Return ExtensionToMime.GetDefault(fn.SubString(i + 1).ToLowerCase, "")
	End If
	Return ""
End Sub

Sub IsValidDropEvent(e As DragEvent) As Boolean
	If e.GetDragboard.HasFiles Then
		Dim files As List = e.GetDragboard.GetFiles
		Try
			If files.Size = 1 And File.Exists(files.get(0), "") Then
				Dim fn As String = files.Get(0)
				Return GetMime(fn) <> "" 
			End If
		Catch
			Log(LastException)
		End Try
	End If
	Return False
End Sub


'thank you ChatGPT
Sub BuildMediaMimeMap As Map
	Dim m As Map
	m.Initialize

	' ========= IMAGES =========
	m.Put("jpg", "image/jpeg")
	m.Put("jpeg", "image/jpeg")
	m.Put("png", "image/png")
	m.Put("gif", "image/gif")
	m.Put("webp", "image/webp")
	m.Put("bmp", "image/bmp")
	m.Put("tif", "image/tiff")
	m.Put("tiff", "image/tiff")
	m.Put("svg", "image/svg+xml")
	m.Put("ico", "image/x-icon")
	m.Put("heic", "image/heic")
	m.Put("heif", "image/heif")

	' ========= AUDIO =========
	m.Put("mp3", "audio/mpeg")
	m.Put("m4a", "audio/mp4")
	m.Put("aac", "audio/aac")
	m.Put("wav", "audio/wav")
	m.Put("ogg", "audio/ogg")
	m.Put("oga", "audio/ogg")
	m.Put("flac", "audio/flac")
	m.Put("opus", "audio/opus")
	m.Put("mid", "audio/midi")
	m.Put("midi", "audio/midi")

	' ========= VIDEO =========
	m.Put("mp4", "video/mp4")
	m.Put("m4v", "video/x-m4v")
	m.Put("mov", "video/quicktime")
	m.Put("webm", "video/webm")
	m.Put("mkv", "video/x-matroska")
	m.Put("avi", "video/x-msvideo")
	m.Put("wmv", "video/x-ms-wmv")
	m.Put("flv", "video/x-flv")

	Return m
End Sub