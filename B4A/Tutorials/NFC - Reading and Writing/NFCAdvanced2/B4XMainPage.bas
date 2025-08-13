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
	Private CustomListView1 As CustomListView
	Private txtRecord2 As B4XFloatTextField
	Private txtRecord1 As B4XFloatTextField
	Private nfc As NFC
	Private TagTech As TagTechnology
	Private prevIntent As Intent
	Private toast As BCToast
	Private rdbWrite As B4XView
	Private rdbRead As B4XView
	Private Label1 As B4XView
End Sub

Public Sub Initialize
	'B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	toast.Initialize(Root)
	txtRecord1.Text = "hello"
	txtRecord2.Text =  "world!"
End Sub

Private Sub B4XPage_Appear
	nfc.EnableForegroundDispatch
	Dim si As Intent = B4XPages.GetNativeParent(Me).GetStartingIntent
	If si.IsInitialized = False Or si = prevIntent Then Return
	prevIntent = si
	If si.Action.EndsWith("TECH_DISCOVERED") Or si.Action.EndsWith("NDEF_DISCOVERED") Or si.Action.EndsWith("TAG_DISCOVERED") Then
		Dim techs As List = nfc.GetTechList(si)
		Log($"Techs: ${techs}"$)
		'in this case we are only accessing Ndef tags.
		If techs.IndexOf("android.nfc.tech.Ndef") > -1 Then
			TagTech.Initialize("TagTech", "android.nfc.tech.Ndef" , si)
			'Connect to the tag
			TagTech.Connect
		Else
			toast.Show("Tag does not support Ndef.")
		End If
	End If
End Sub

Private Sub B4XPage_Disappear
	nfc.DisableForegroundDispatch
End Sub

Private Sub TagTech_Connected (Success As Boolean)
	Log($"Connected: ${Success}"$)
	If Success = False Then
		toast.Show("Error connecting to tag")
		Log(LastException)
	Else
		If rdbRead.Checked Then
			ReadNdef
		Else
			WriteNdef(Array(nfc.CreateMimeRecord("text/plain", txtRecord1.Text.GetBytes("UTF8")), _
		  			nfc.CreateMimeRecord("text/plain", txtRecord2.Text.GetBytes("UTF8"))))
		End If
	End If
End Sub

Private Sub ReadNdef
	TagTech.RunAsync("ReadNdef", "getNdefMessage", Null, 0)
End Sub

Private Sub WriteNdef (Records() As Object)
	Dim RecordsJO As JavaObject
	RecordsJO.InitializeArray("android.nfc.NdefRecord", Records)
	Dim message As JavaObject
	message.InitializeNewInstance("android.nfc.NdefMessage", Array(RecordsJO))
	TagTech.RunAsync("WriteNdef", "writeNdefMessage", Array(message), 0)
End Sub

Private Sub WriteNdef_RunAsync (Flag As Int, Success As Boolean, Result As Object)
	Log($"Writing completed. Success=${Success}, Flag=${Flag}"$)
	If Success Then ReadNdef
End Sub

Private Sub ReadNdef_RunAsync (Flag As Int, Success As Boolean, Result As Object)
	Log($"Reading completed. Success=${Success}, Flag=${Flag}"$)
	CustomListView1.Clear
	If Success Then
		If Result = Null Then
			ToastMessageShow("No records found.", False)
		Else
			Dim message As JavaObject = Result
			Dim records() As Object = message.RunMethod("getRecords", Null)
			For Each r As NdefRecord In records
				Dim b() As Byte = r.GetPayload
				CustomListView1.AddTextItem(BytesToString(b, 0, b.Length, "utf8"), "")
			Next
		End If
	End If
End Sub

