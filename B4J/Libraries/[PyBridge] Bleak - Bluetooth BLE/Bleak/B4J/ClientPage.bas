B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.12
@EndOfDesignText@
Sub Class_Globals
	Private frm As Form
	Private root As B4XView
	Private lstData As CustomListView
	Private lblState As B4XView
	Public mClient As BleakClient
	Private xui As XUI
	Private mConnected As Boolean
	Private CharToPanel As Map
	Private ddd1 As DDD
	Private Dialog As B4XDialog
	Private InputTemplate As B4XInputTemplate
End Sub

Public Sub Initialize (Client As BleakClient)
	frm.Initialize("frm", 600dip, 600dip)
	root = frm.RootPane
	frm.Show
	root.LoadLayout("Client")
	mClient = Client
	SetState(True)
	lstData.DefaultTextBackgroundColor = xui.Color_Gray
	lstData.DefaultTextColor = xui.Color_White
	CharToPanel.Initialize
	ddd1 = B4XPages.MainPage.ddd1
	Dialog.Initialize(root)
	InputTemplate.Initialize
	For Each service As BleakService In mClient.Services.Values
		lstData.AddTextItem($"Service: ${service.UUID} - ${service.Description}"$, "")
		For Each Chara As BleakCharacteristic In service.Characteristics
			Dim pnl As B4XView = xui.CreatePanel("")
			pnl.SetLayoutAnimated(0, 0, 0, lstData.AsView.Width, 94dip)
			pnl.LoadLayout("CharLayout")
			CharToPanel.Put(Chara.UUID, pnl)
			Dim btnRead As B4XView = ddd1.GetViewByName(pnl, "btnRead")
			btnRead.Tag = Chara.UUID
			Dim btnNotify As B4XView = ddd1.GetViewByName(pnl, "btnNotify")
			btnNotify.Tag = Chara.UUID
			Dim btnWrite As B4XView = ddd1.GetViewByName(pnl, "btnWrite")
			btnWrite.Tag = Chara.UUID
			If Chara.Properties.IndexOf("read") = -1 Then btnRead.Visible = False
			If Chara.Properties.IndexOf("notify") = -1 And  Chara.Properties.IndexOf("indicate") = -1 Then btnNotify.Visible = False
			If Chara.Properties.IndexOf("write") = -1 And  Chara.Properties.IndexOf("reliable-writes") = -1 Then btnWrite.Visible = False
			ddd1.GetViewByName(pnl, "Label1").Text = "Characteristic: " & Chara.UUID
			ddd1.GetViewByName(pnl, "Label2").Text = B4XPages.MainPage.ListToString(Chara.Properties)
			lstData.Add(pnl, Null)
		Next
	Next
End Sub


Public Sub SetState(Connected As Boolean)
	mConnected = Connected
	lblState.Text = mClient.mDevice.DeviceId & " - " & (IIf(Connected, "connected", "disconnected"))
End Sub

Private Sub btnRead_Click
	Dim uuid As String = Sender.As(B4XView).Tag
	Dim lbl As B4XView = ddd1.GetViewByName(CharToPanel.Get(uuid), "Label3")
	lbl.Text = "Reading..."
	Log("reading: " & uuid)
	Wait For (mClient.ReadChar(uuid)) Complete (Result As PyWrapper)
	If Result.IsSuccess = False Then
		lbl.Text = "Error: " & B4XPages.MainPage.ParseErrorMessage(Result.ErrorMessage)
	Else
		Dim b() As Byte = Result.Value
		lbl.Text = BytesToString(b, 0, b.Length, "ascii")
	End If
End Sub

Public Sub NotificationEvent(n As BleakNotification)
	Dim pnl As B4XView = CharToPanel.Get(n.CharacteristicUUID)
	ddd1.GetViewByName(pnl, "Label3").Text = BytesToString(n.Value, 0, n.Value.Length, "ASCII")
End Sub

Private Sub btnNotify_Click
	Dim uuid As String = Sender.As(B4XView).Tag
	Dim lbl As B4XView = ddd1.GetViewByName(CharToPanel.Get(uuid), "Label3")
	lbl.Text = "Setting notification..."
	Wait For (mClient.SetNotify(uuid)) Complete (Result As PyWrapper)
	If Result.IsSuccess = False Then
		lbl.Text = "Error: " & B4XPages.MainPage.ParseErrorMessage(Result.ErrorMessage)
	Else
		lbl.Text = "Set successfully"
	End If
End Sub

Private Sub btnWrite_Click
	Dim uuid As String = Sender.As(B4XView).Tag
	Dim lbl As B4XView = ddd1.GetViewByName(CharToPanel.Get(uuid), "Label3")
	Wait For (Dialog.ShowTemplate(InputTemplate, "Ok", "", "Cancel")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Dim rs As Object = mClient.Write(uuid, InputTemplate.Text.GetBytes("UTF8"))
		Wait For (rs) Complete (Result2 As PyWrapper)
		If Result2.IsSuccess = False Then
			lbl.Text = "Error: " & B4XPages.MainPage.ParseErrorMessage(Result2.ErrorMessage)
		Else
			lbl.Text = "Written successfully"
		End If
	End If
End Sub

Private Sub frm_Closed
	If mConnected Then
		mClient.Disconnect
	End If
	B4XPages.MainPage.PageClosed(Me)
End Sub

