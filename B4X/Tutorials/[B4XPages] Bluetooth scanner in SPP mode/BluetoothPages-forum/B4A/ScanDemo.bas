B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.86
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Public btnSend As B4XView
	Private btnScanOn As Button
	Private lblStatus As B4XView
	Private list As List
	Private txtBinNbr As EditText
	Private txtItemNbr As EditText
	Private btnDone As Button
	Private btnExit As Button
	Private txtDesc As EditText
	Private currentEditText As EditText
	Private lblScanner As B4XView
	Private lblConnected As B4XView
	Private lblbinNbrSym As B4XView
	Private lblIItemNbr As B4XView
	
	Private ourCaller As  Object
	Private callersRoutine As String
End Sub

Public Sub Initialize
End Sub

public Sub Setup (theCaller As  Object, paCallersRoutine As String)
	' can't do in Initialize as UI objects are not inited yet. caller calls this sub
	' change if can find an event to accomplish this
	ourCaller = theCaller
	callersRoutine = paCallersRoutine
	clearForm
	gotoBinNbr ' Point scanner to Bin Nbr
	btnDone.Enabled = False
	If B4XPages.MainPage.ConnectionState = True Then
		lblConnected.Text = "Connected"
	Else
		lblConnected.Text = "Disconnected"
	End If
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("2")
End Sub

Sub B4XPage_CloseRequest As ResumableSub
	Dim sf As Object = getExitAnswer
	Wait For (sf) Complete(Result As Boolean)
	If Result Then
		exitPage
	End If
	Return Result
End Sub

Sub btnExit_Click
	Dim sf As Object = getExitAnswer
	Wait For (sf) Complete(Result As Boolean)
	If Result = True Then
		exitPage
		B4XPages.ClosePage(Me)
	End If
End Sub

Sub exitPage
	B4XPages.MainPage.Scanset(Null, "", Array As String ("")) ' scanner off
	CallSubDelayed2(ourCaller, callersRoutine, "")
End Sub

Sub getExitAnswer As ResumableSub
	If txtBinNbr.Text = "" And txtItemNbr.Text = "" Then
		Return True
	Else
		Dim sf As Object = xui.Msgbox2Async("Discard entry?", "", "Yes", "", "No", Null)
		Wait For (sf) Msgbox_Result (Result As Int)
		If Result = xui.DialogResponse_Positive Then
			B4XPages.MainPage.Scanset(Null, "", Array As String (""))' Scanner OFF
			Return True
		Else
			Return False
		End If
	End If
End Sub

'  Called by B4XMainPage
public Sub ScanError (errorMsg As String)
	lblStatus.Text = "" ' may not want to clear in some cases
	lblConnected.Text = errorMsg
End Sub

Sub btnScanOn_Click
	B4XPages.MainPage.Connect
End Sub

Sub BinNbrScan (paBarcode As String)
	txtBinNbr.Text = paBarcode
	txtBinNbr_EnterPressed
End Sub
Sub txtBinNbr_EnterPressed
	lblbinNbrSym.Text = B4XPages.MainPage.LastSymbology
	If txtBinNbr.Text = "12345670" Then
		' change scan destination to ItemNbr
		B4XPages.MainPage.PlaySound("good")
		setupEditText(Array("EAN_13", "UPC_E", "UPC_A"), txtItemNbr) ' point scanner to ItemNbr
		txtBinNbr.Enabled = False
		txtItemNbr.Enabled = True
		txtDesc.RequestFocus ' let Android control field to field navagation from here
	Else
		lblStatus.Text = "Bin not found - Re-Enter"
		B4XPages.MainPage.PlaySound("bad")
		gotoBinNbr
	End If
End Sub

Sub ItemNbrScan (paBarcode As String)
	txtItemNbr.Text = paBarcode
	txtItemNbr_EnterPressed
End Sub
Sub txtItemNbr_EnterPressed
	lblIItemNbr.Text = B4XPages.MainPage.LastSymbology
	If txtItemNbr.Text = "01234543" Then
		B4XPages.MainPage.PlaySound("good")
		lblStatus.Text = "Click Done to complete"
		btnDone.Enabled = True
	Else
		lblStatus.Text = "Item not found - Re-Enter"
		B4XPages.MainPage.PlaySound("bad")
		gotoItemNbr
	End If
End Sub

Sub gotoBinNbr
	setupEditText(Array("EAN_8"), txtBinNbr)
	txtBinNbr.Enabled = True
	txtItemNbr.Enabled = False
	txtBinNbr.RequestFocus
End Sub

Sub gotoItemNbr
	setupEditText(Array("EAN_13", "UPC_E", "UPC_A"), txtItemNbr)
	txtBinNbr.Enabled = False
	txtItemNbr.Enabled = True
	txtItemNbr.RequestFocus
End Sub

'  Called by B4XMainPage
'Public Sub NewMessage (msg As String)
'	currentEditText.Text = msg
'	If currentEditText.Tag = "BinNbr" Then ' use select if more than two scannable fields
'		txtBinNbr_EnterPressed
'	Else
'		txtItemNbr_EnterPressed
'	End If
'End Sub

Sub setupEditText (paSymbologies As List, paEditText As EditText)
	Dim symStr As String
	currentEditText = paEditText
	list.Initialize
	list.AddAll(paSymbologies)
	B4XPages.MainPage.Scanset(Me, paEditText.Tag & "Scan", list)
	For i = 0 To paSymbologies.Size - 1
		symStr = symStr & " " & paSymbologies.Get(i)
	Next
End Sub

Sub btnDone_Click
	clearForm
	gotoBinNbr
End Sub

Sub clearForm
	txtBinNbr.Enabled = True
	txtItemNbr.Enabled = False
	lblStatus.Text = ""
	txtBinNbr.Text = ""
	lblbinNbrSym.Text = ""
	txtItemNbr.Text = ""
	lblbinNbrSym.Text= ""
	txtDesc.Text = ""
	btnDone.Enabled = False
End Sub

