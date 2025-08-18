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
	Private prefdialog As PreferencesDialog
	Private Options1, Options2, Options3 As Map
	Private xui As XUI
	Private TextArea1 As B4XView
	Private TextArea2 As B4XView
	Private TextArea3 As B4XView
	Private OptionsFile As String = "options.map"
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("1")
	Options1.Initialize
	Options2.Initialize
	Options3.Initialize
	xui.SetDataFolder ("preferences")
	prefdialog.Initialize(Root, "Preferences Dialog", 300dip, 300dip)
	prefdialog.LoadFromJson(File.ReadString(File.DirAssets, "example.json"))
	prefdialog.SetOptions("Cities", File.ReadList(File.DirAssets, "cities.txt"))
	prefdialog.SetEventsListener(Me, "PrefDialog")
	LoadSavedData
End Sub

Private Sub PrefDialog_IsValid (TempData As Map) As Boolean
	Dim number As Int = TempData.GetDefault("NumberToValidate", 0)
	If number < 10 Or number > 20 Then 
		prefdialog.ScrollToItemWithError("NumberToValidate")
		Return False
	End If
	Return True
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	If xui.IsB4A Then
		'back key in Android
		If prefdialog.BackKeyPressed Then Return False
	End If
	Return True
End Sub

'Don't miss the code in the Main module + manifest editor.
Private Sub IME_HeightChanged (NewHeight As Int, OldHeight As Int)
	prefdialog.KeyboardHeightChanged(NewHeight)
End Sub

Private Sub LoadSavedData
	Try
		If File.Exists(xui.DefaultFolder, OptionsFile) Then
			Dim ser As B4XSerializator
			Dim opt() As Object = ser.ConvertBytesToObject(File.ReadBytes(xui.DefaultFolder, OptionsFile))
			Options1 = opt(0)
			Options2 = opt(1)
			Options3 = opt(2)
			PrintOptions(Options1, TextArea1)
			PrintOptions(Options2, TextArea2)
			PrintOptions(Options3, TextArea3)
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub btnOptions1_Click
	Wait For (prefdialog.ShowDialog(Options1, "OK", "CANCEL")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		PrintOptions(Options1, TextArea1)
	End If
End Sub

Private Sub btnOptions2_Click
	Wait For (prefdialog.ShowDialog(Options2, "OK", "CANCEL")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		PrintOptions(Options2, TextArea2)
	End If
End Sub

Private Sub btnOptions3_Click
	Wait For (prefdialog.ShowDialog(Options3, "OK", "CANCEL")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		PrintOptions(Options3, TextArea3)
	End If
End Sub

Private Sub PrintOptions (Options As Map, TextArea As B4XView)
	Dim sb As StringBuilder
	sb.Initialize
	For Each key As String In Options.Keys
		If key = "" Then Continue 'separators
		sb.Append(key).Append(": ").Append(Options.Get(key)).Append(CRLF)
	Next
	Dim birthday As Long = Options.Get("Birthday")
	Dim time As Period = Options.Get("Time")
	sb.Append($"Date and time: $DateTime{DateUtils.AddPeriod(birthday, time)}"$).Append(CRLF)
	TextArea.Text = sb.ToString
End Sub