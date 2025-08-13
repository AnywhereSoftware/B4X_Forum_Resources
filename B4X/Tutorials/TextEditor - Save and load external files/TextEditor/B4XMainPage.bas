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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=TextEditor.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private txtField As B4XFloatTextField
	Private FileHandler1 As FileHandler
	Private toast As BCToast
	#if B4A
	Private ime As IME 'ignore
	#end if
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "Text Editor")
	#if B4A
	AddMenuItem(0xF0C7, "save")
	AddMenuItem(0xF115, "load")
	#end if
	txtField.TextField.SetTextAlignment("TOP", "LEFT")
	FileHandler1.Initialize
	toast.Initialize(Root)
End Sub


Private Sub B4XPage_MenuClick (Tag As String)
	HideKeyboard
	Select Tag
		Case "save"
			Save
		Case "load"
			Load
	End Select
End Sub

Private Sub Save

	#if B4A
	Dim b() As Byte = txtField.Text.GetBytes("UTF8")
	Dim in As InputStream
	in.InitializeFromBytesArray(b, 0, b.Length)
	Wait For (FileHandler1.SaveAs(in, "text/plain", "NewFile.txt")) Complete (Success As Boolean)
	#else if B4i
	Wait For (FileHandler1.SaveAs(Me, B4XPages.GetNativeParent(Me).TopRightButtons.Get(0), txtField.Text)) Complete (Success As Boolean)
	#end if
	If Success Then
		toast.Show("File saved successfully")
	Else
		toast.Show("File not saved")
	End If
End Sub

Private Sub Load
	#if B4A
	Wait For (FileHandler1.Load) Complete (Result As LoadResult)
	#else if B4i
	Wait For (FileHandler1.Load(Me, B4XPages.GetNativeParent(Me).TopRightButtons.Get(1))) Complete (Result As LoadResult)
	#end if
	HandleLoadResult(Result)
End Sub

Private Sub HandleLoadResult(Result As LoadResult)
	If Result.Success Then
		Dim s As String
		Try
			s = File.ReadString(Result.Dir, Result.FileName)
			toast.Show($"File '${Result.RealName}' loaded"$)
		Catch
			s = "Error loading file"
			Log(LastException)
		End Try
		txtField.Text = s
	End If
End Sub

Private Sub B4XPage_Appear
	#if B4A
	HandleLoadResult(FileHandler1.CheckForReceivedFiles)
	#end if
End Sub

#if B4A
Private Sub AddMenuItem(FontAwesomeIcon As Int, Tag As String)
	Dim cs As CSBuilder
	Dim mi As B4AMenuItem = B4XPages.AddMenuItem(Me, cs.Initialize.Typeface(Typeface.FONTAWESOME).Size(30).Append(Chr(FontAwesomeIcon)).PopAll)
	mi.AddToBar = True
	mi.Tag = Tag
End Sub

Private Sub IME_HeightChanged (NewHeight As Int, OldHeight As Int)
	txtField.mBase.Height = NewHeight
	txtField.TextField.Height = NewHeight
End Sub

Private Sub HideKeyboard
	ime.HideKeyboard
End Sub

#else if B4i
Private Sub HideKeyboard
	B4XPages.GetNativeParent(Me).ResignFocus
End Sub

Private Sub B4XPage_KeyboardStateChanged (KeyboardHeight As Float)
	txtField.mBase.Height = Root.Height - KeyboardHeight
	txtField.TextField.Height = txtField.mBase.Height
End Sub

Public Sub OpenUrl(url As String)
	If url.StartsWith("file://") Then
		Dim f As String = url.SubString(7) 'remove the file:// scheme.
		Dim res As LoadResult = FileHandler1.UrlToLoadResult(f)
		HandleLoadResult(res)
	End If
End Sub
#end if


