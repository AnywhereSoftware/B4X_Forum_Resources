B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11
@EndOfDesignText@
'Library Name: PinLockerLP											'
'By: Leon Prokopis, Nafplio, Greece 								'
'Code version 1.1													'
'Date created:  11/27/2021											'	
'Date changed:  12/31/2021											'
'Changes v 1.1  1. Repaired a small bug of not initialized field	'			
'				2. AskPin Dialog changed floattextBox height and 	'	

Sub Class_Globals
	Private xui As XUI
	Private dlg As B4XDialog
	Private Root As B4XView
	Private lblEnablePin As Label
	Private fTxtPin1 As B4XFloatTextField
	Private fTxtPin2 As B4XFloatTextField
	Private swEnablePin As B4XSwitch 
	Public kvs As KeyValueStore
	Private fTxtEnteredPin As B4XFloatTextField
	Private lblEnPin As Label
	
	'Public Values 
	Public MAXPASSLENGHT As Int = 4
	'Dialog Buttons Labels
	Public textDlgTitle As String = "Secure Application"
	Public textBtnOK As String = "Ok"
	Public textBtnNo As String = ""
	Public textBtnCancel As String = "Cancel"
	Public textLabelEnablePin As String = "Enable Pin"
	Public textHintPin1 As String = "Pin"
	Public textHintPin2 As String = "Retype Pin"
	Public textToastMsgSuccessSavePin As String = "Pin saved"
	Public textToastMsgPinDisaled As String = "Pin disabled"
	Public textLabelEnablePin As String = "Pin enabled"
	Public textHintEnterPin As String = "Enter Pin"
	Public textToastWrongPin As String = "Wrong Pin entered"
End Sub


'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Parent As B4XView) 
	Root = Parent
	xui.SetDataFolder("kvs")
	kvs.Initialize(xui.DefaultFolder, "pinLockerLP.dat")
	If Not(kvs.ContainsKey("pinEnabled")) Then kvs.Put("pinEnabled", False )
End Sub


Public Sub IsPinActive As Boolean
	Return kvs.Get("pinEnabled")
End Sub


Public  Sub createPin()
	dlg.Initialize(Root) 
	dlg.Title = textDlgTitle
'	Log ("Setting Pin")
	Dim p As B4XView = xui.CreatePanel("") 
	p = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 350dip, 22%y)
	p.LoadLayout("dlgSetPin")

	dlg.PutAtTop = True 'put the dialog at the top of the screen
	lblEnablePin.text = textLabelEnablePin
	If IsPinActive Then 
		fTxtPin1.HintText = textHintPin1
		fTxtPin1.Update
		fTxtPin2.HintText = textHintPin2
		fTxtPin2.Update
		swEnablePin.Value = True
	End If 
	
	fTxtPin1.mBase.Visible = swEnablePin.Value
	fTxtPin2.mBase.Visible = swEnablePin.Value
	
	Dim rs As ResumableSub = dlg.ShowCustom(p, textBtnOK, textBtnNo, textBtnCancel)
	If swEnablePin.Value = True Then
		fTxtPin1.RequestFocusAndShowKeyboard
	End If

	ValidatePins(fTxtPin1.Text, fTxtPin2.text)
	
	Wait For (rs) Complete (result As Int)
	
	If result = xui.DialogResponse_Positive Then
		If swEnablePin.Value = True Then
			kvs.Put("pinEnabled", True)
			kvs.Put("pin", fTxtPin2.Text)
			ToastMessageShow(textToastMsgSuccessSavePin, True)	'"Επιτυχημένη  αποθήκευση pin"
'			Log("pin: " & kvs.Get("pin"))
		Else
			kvs.Put("pinEnabled", False)
			kvs.Remove("pin")
			ToastMessageShow(textToastMsgPinDisaled, True)  '"To pin απενεργοποιήθηκε"
'			Log("pin: " & kvs.Get("pin"))
		End If
	End If
End Sub


Private Sub ValidatePins (pin1 As String, pin2 As String)
	Dim ok As B4XView = dlg.GetButton(xui.DialogResponse_Positive)
	If swEnablePin.Value = True Then
		If pin1.Length <> MAXPASSLENGHT Or pin2.Length <> MAXPASSLENGHT Then
			ok.Enabled = False
			ok.TextColor = xui.Color_Gray
		else if pin1 <> pin2 Then
			ok.Enabled = False
			ok.TextColor = xui.Color_Gray
		Else
			ok.Enabled = True
			ok.TextColor = xui.Color_Green
		End If
	Else
		ok.Enabled = True
		ok.TextColor = xui.Color_Green
	End If
End Sub


Private Sub fTxtPin1_TextChanged (Old As String, New As String)
	If dlg.Visible = False Then Return
	If New.Length > MAXPASSLENGHT Then
		fTxtPin1.Text = Old
	End If
	ValidatePins(New, fTxtPin2.Text)
End Sub

Private Sub fTxtPin2_TextChanged (Old As String, New As String)
	If dlg.Visible = False Then Return
	If New.Length > MAXPASSLENGHT Then
		fTxtPin2.Text = Old
	End If
	ValidatePins(New, fTxtPin1.Text)
End Sub


Private Sub swEnablePin_ValueChanged (Value As Boolean)
	fTxtPin1.mBase.Visible = Value
	fTxtPin2.mBase.Visible = Value
	fTxtPin1.HintText = textHintPin1
	fTxtPin1.Update
	fTxtPin2.HintText = textHintPin2
	fTxtPin2.Update
	Dim ok As B4XView = dlg.GetButton(xui.DialogResponse_Positive)
	If Value = False Then ok.Enabled = True
	ok.TextColor = xui.Color_Green
	If swEnablePin.Value = True Then
		ok.Enabled = False
		ok.TextColor = xui.Color_Gray
		fTxtPin1.Text = ""
		fTxtPin2.Text = ""
		fTxtPin1.RequestFocusAndShowKeyboard
	End If
End Sub


Public Sub dlgAskPin As ResumableSub
	Dim Rt As Boolean = False
	If kvs.Get("pinEnabled") = True Then
		Do While Not(Rt)
			wait for (askPin) Complete (Rt As Boolean)
		Loop
	End If
	Return True
End Sub


Private Sub askPin As ResumableSub 
	dlg.Initialize(Root)
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 400dip, 18%y)
	p.LoadLayout("dlgAskPin")

	Dim pDlg As Object = dlg.ShowCustom(p, "", "", "")
	Sleep(100)
'	lblEnablePin.Text = textLabelEnablePin
	fTxtEnteredPin.HintText = textHintEnterPin
	fTxtEnteredPin.Update
	fTxtEnteredPin.RequestFocusAndShowKeyboard
	Wait For (pDlg) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		If fTxtEnteredPin.Text = kvs.Get("pin") Then 
			Return True
		Else 
			ToastMessageShow(textToastWrongPin, False) 
			Return False 
		End If
	End If 
	ToastMessageShow(textToastWrongPin, False) 
	Return False
End Sub


Private Sub fTxtEnteredPin_EnterPressed
	dlg.Close(xui.DialogResponse_Positive)
End Sub