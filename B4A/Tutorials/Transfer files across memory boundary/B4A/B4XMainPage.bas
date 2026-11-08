B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
'This is a simple example of moving files across the internal/external memory boundary.
'EG Transfering a CSV file from an external location to an internal folder to load a database in the App.

'XFER started as B4X TextEditor [and a chainsaw]. I have deliberately minimized it as much as I could, 
'not even friendly Toast Messages.  
'This was fairly easy as most of the work is done in the FileHandler class.

'The App itself is quite rough but I envisage the code used in an App where 
'import/export of files is required.



#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=TextEditor.zip

Sub Class_Globals
	Private Root, LblXfer, BtnXFER As B4XView
	Private FileHandler1 As FileHandler
	Private inputstream1 As InputStream
	Private byte1() As Byte
	Private ime As IME 					'ignore
	Public ShowMimeType As String = "*/*"   'Used in FileHandler Class [Line 39] to identify which type
											'of file is shown for selection.
											'"*/*" shows all types.
											'"text/plain" shows only text files. 
											'"Image/jpg" shows only jpg files.
											'"image/*" shows all types of image files.											
End Sub

Public Sub Initialize
	'B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "Transfer")
	FileHandler1.Initialize
End Sub

Sub BtnXFER_Click
	'File Manager to select file
	Wait For (FileHandler1.Load) Complete (Result As LoadResult)			
	If Result.Success Then
		byte1 = File.ReadBytes(Result.Dir, Result.FileName)
		inputstream1.InitializeFromBytesArray(byte1, 0, byte1.Length)
			
		'File Manager to Select Destination Folder												
		Wait For (FileHandler1.SaveAs(inputstream1, Result.MimeType, Result.RealName)) Complete (Success1 As Boolean)
	End If
End Sub
