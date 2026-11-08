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
	
	Private fx As JFX
	Private Label1 As Label
	Private DragAndDrop1 As DragAndDrop
	Private xui As XUI
	Private ImageView1 As ImageView
	Private Pane1 As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	DragAndDrop1.Initialize(Me)
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	DragAndDrop1.MakeDragTarget(Root, "DropTarget")
	
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
	
	Pane1.SetColorAndBorder(xui.Color_White, 0, 0, 0)

End Sub

Sub DropTarget_DragOver(e As DragEvent)
	If IsValidDropEvent(e) Then e.AcceptTransferModes(TransferMode.COPY)
End Sub


Sub IsValidDropEvent(e As DragEvent) As Boolean
	If e.GetDragboard.HasFiles Then
		Dim files As List = e.GetDragboard.GetFiles
		If files.Size = 1 Then
			Dim filename As String = files.Get(0)
			filename = filename.ToLowerCase
			Return filename.EndsWith(".png") Or filename.EndsWith(".jpg") Or filename.EndsWith(".jpeg")
		End If
	End If
	Return False
End Sub


Sub DropTarget_DragDropped(e As DragEvent)
	Log("drag dropped")

	Dim filename As String = e.GetDragboard.GetFiles.Get(0)
	filename = filename.ToLowerCase

	Try
		If filename.EndsWith(".png") Or filename.EndsWith(".jpg") Or filename.EndsWith(".jpeg") Then
			Dim img As Image
			img.Initialize(File.GetFileParent(filename), File.GetName(filename))

			ImageView1.SetImage(img)

			Dim nameOnly As String = File.GetName(filename)
			Dim sizeBytes As Long = File.Size(File.GetFileParent(filename), nameOnly)
			Dim sizeMB As Double = sizeBytes / (1024 * 1024)

			Dim sizeMBFormatted As String = NumberFormat(sizeMB, 1, 2)
			Dim sizeBytesFormatted As String = NumberFormat2(sizeBytes, 1, 0, 0, True)

			Label1.Text = $"${nameOnly} - ${sizeMBFormatted} Mo (${sizeBytesFormatted} octets)"$

		End If
	Catch
		Label1.Text = LastException
	End Try

	e.SetDropCompleted(True)
End Sub


