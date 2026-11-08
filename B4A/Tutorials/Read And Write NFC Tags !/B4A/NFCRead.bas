B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private nfc As NFC
	Private TagTech As TagTechnology
	Private prevIntent As Intent
	Private toast As BCToast
	Private Label1 As Label
	Private Tagvalue As String
	Private ProgressBar1 As ProgressBar
	Private Button1 As Button
End Sub

Public Sub Initialize
	'B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("NFCRE")
	toast.Initialize(Root)
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
			ReadNdef
	End If
End Sub

Private Sub ReadNdef
	TagTech.RunAsync("ReadNdef", "getNdefMessage", Null, 0)
End Sub

Private Sub ReadNdef_RunAsync (Flag As Int, Success As Boolean, Result As Object)
	Log($"Reading completed. Success=${Success}, Flag=${Flag}"$)
	If Success Then
		If Result = Null Then
			ToastMessageShow("No records found.", False)
		Else
			Dim message As JavaObject = Result
			Dim records() As Object = message.RunMethod("getRecords", Null)
			For Each r As NdefRecord In records
				Dim b() As Byte = r.GetPayload
'				CustomListView1.AddTextItem(BytesToString(b, 0, b.Length, "utf8"), "")
				Tagvalue = BytesToString(b, 0, b.Length, "utf8")
				If Tagvalue = "" Then
					Else
					ProgressBar1.Visible = False
					Label1.Text = "Tag Scanned !"
					Sleep(2000)
					MsgboxAsync(Tagvalue,"The Tag :")
					Label1.Text = "Awaiting For a Ndef tag scanned"
					ProgressBar1.Visible = True
				End If
			Next
		End If
	End If
End Sub



Private Sub Button1_Click
	B4XPages.ShowPage("MainPage")
End Sub