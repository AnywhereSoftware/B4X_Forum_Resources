B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11.5
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	'Private CustomListView1 As CustomListView
	Private Ignore As EditText
	Private Record As EditText
	Private nfc As NFC
	Private TagTech As TagTechnology
	Private prevIntent As Intent
	Private toast As BCToast
	Private Label1 As Label
End Sub

Public Sub Initialize
	'B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("NFCWR")
	toast.Initialize(Root)
	Ignore.Text = ""
	Record.Text =  ""
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
		WriteNdef(Array(nfc.CreateMimeRecord("text/plain", Ignore.Text.GetBytes("UTF8")), _
		  			nfc.CreateMimeRecord("text/plain", Record.Text.GetBytes("UTF8"))))
	End If
End Sub

Private Sub WriteNdef (Records() As Object)
	Dim RecordsJO As JavaObject
	RecordsJO.InitializeArray("android.nfc.NdefRecord", Records)
	Dim message As JavaObject
	message.InitializeNewInstance("android.nfc.NdefMessage", Array(RecordsJO))
	TagTech.RunAsync("WriteNdef", "writeNdefMessage", Array(message), 0)
	Label1.Text = "Tag Writed With Text : " & Record.Text
	Sleep(1000)
	Label1.Text = "Awaiting for a Ndef tag scanned"
End Sub

Private Sub WriteNdef_RunAsync (Flag As Int, Success As Boolean, Result As Object)
	Log($"Writing completed. Success=${Success}, Flag=${Flag}"$)
End Sub

Private Sub Button1_Click
	B4XPages.ShowPage("MainPage")
End Sub