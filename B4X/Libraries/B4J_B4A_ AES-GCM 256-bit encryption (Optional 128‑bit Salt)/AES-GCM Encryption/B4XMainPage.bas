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
	Private XUI As XUI

	Private Enc As AESGCMEncryption

	Private TxtName As B4XView
	Private TxtAge As B4XFloatTextField
	Private ChkPro As B4XSwitch
	Private TxAOutput As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	B4XPages.SetTitle(Me, "AES GCM Encryption")

	' Initialise encrypted data
	If XUI.IsB4J Then XUI.SetDataFolder("Simply Software\AES-GCM Encryption")
	Enc.Initialize(XUI.DefaultFolder, "SecureaData.dat", "MyStrongPassword0123.*")
	Enc.SetSaltBase64 = "q83J4u2F9pA7x1V0yqkN+w=="
	
	Append("AES-GCM encrypted preferences initialised.")
End Sub

Private Sub btnSave_Click
	Enc.PutString("UserName", TxtName.Text)
	Enc.PutInt("Age", TxtAge.Text)
	Enc.PutBoolean("IsPro", ChkPro.Value)
	TxAOutput.Text = TxAOutput.Text & "Saved." & CRLF
End Sub

Private Sub btnLoad_Click
	TxtName.Text = Enc.GetString("UserName")
	TxtAge.Text = Enc.GetInt("Age")
	ChkPro.Value = Enc.GetBoolean("IsPro")
	TxAOutput.Text = TxAOutput.Text & "Loaded." & CRLF
End Sub

Private Sub btnClear_Click
	Enc.Clear
	TxAOutput.Text = TxAOutput.Text & "Cleared." & CRLF
End Sub

Private Sub btnShowKeys_Click
	Dim keys As List = Enc.Keys
	For Each k As String In keys
		Dim v As Object = Enc.GetString(k) ' or choose based on key
		TxAOutput.Text = TxAOutput.Text & k & " = " & v & CRLF
	Next

	Log("---------------------- B4X Logs ----------------------")

	Log(Enc.GetString("UserName"))
	Log(Enc.GetString("Age"))
	Log(Enc.GetString("IsPro"))
End Sub

Sub AESGCMEncryption_Error (Message As String, Tag As Object)
	TxAOutput.Text = TxAOutput.Text & "ERROR: " & Message & CRLF
End Sub

Private Sub Append(Text As String)
	TxAOutput.Text = TxAOutput.Text & Text & CRLF
End Sub
