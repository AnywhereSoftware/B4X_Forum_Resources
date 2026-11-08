B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private ClvSetting As CustomListView
	Private CmdAdd As Button
	Private LabNome As Label
	Private LblChiudi As Button
	Private PanTestata As Panel

	Private Panel1 As Panel
	Private Panel2 As Panel
	Private PanSeparatore As Panel
	Private Label1 As Label
	Private Label3 As Label
	Private LabTesto As Label
	Private PanBottom As Panel
	Private PanCentrale As Panel
	Private PanTop As Panel
	Private LabIcona As Label
	Public Dark As Int=1
	Private LabFreccia As Label
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	B4XPages.GetManager.TransitionAnimationDuration = 0
	Root.LoadLayout("FrmImpostazioni")
	'CreaVoci
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub LblChiudi_Click
	B4XPages.ClosePage(Me)
End Sub

Private Sub CmdAdd_Click
	
End Sub

Private Sub ClvSetting_ItemClick (Index As Int, Value As Object)
	Log(Value)
	ToastMessageShow("Premuto il menu " & Value,False)
End Sub

Sub CreaVoci
	ImpostaTema
	ClvSetting.Clear
	ClvSetting.Add(Creariga("Profilo","",0,Definizioni.colore_arancio),1)
	ClvSetting.Add(Creariga("Test","",2,Definizioni.colore_azzurro),2)
	
	ClvSetting.Add(Creariga("Generali","",0,Definizioni.colore_celeste),3)
	ClvSetting.Add(Creariga("Privacy","",1,Definizioni.colore_giallopastello),4)
	ClvSetting.Add(Creariga("Notifiche","",1,Definizioni.colore_mattone),5)
	ClvSetting.Add(Creariga("Notifiche","",1,Definizioni.colore_marrone),6)
	ClvSetting.Add(Creariga("Notifiche","",1,Definizioni.colore_pisello),7)
	ClvSetting.Add(Creariga("Test","",2,Definizioni.colore_rosa),8)
	
	ClvSetting.Add(Creariga("Help","",0,Definizioni.colore_verde),9)
	ClvSetting.Add(Creariga("Esci","",2,Definizioni.colore_viola),10)
	
	
	ClvSetting.Add(Creariga("Notifiche","",0,Definizioni.colore_mattone),11)
	ClvSetting.Add(Creariga("Notifiche","",1,Definizioni.colore_marrone),12)
	ClvSetting.Add(Creariga("Notifiche","",1,Definizioni.colore_marrone),13)
	ClvSetting.Add(Creariga("Notifiche","",1,Definizioni.colore_marrone),14)
	ClvSetting.Add(Creariga("Notifiche","",1,Definizioni.colore_marrone),15)
	ClvSetting.Add(Creariga("Notifiche","",2,Definizioni.colore_pisello),16)
	
	
End Sub


private Sub  Creariga(testo As String, icona As String,modalita As Int,colore As Int) As B4XView
	Dim p As B4XView=xui.CreatePanel("")
	'da aggiornare
	Select Case modalita
		Case 0
			p.SetLayoutAnimated(0,0,0,ClvSetting.AsView.Width,65dip)
			p.LoadLayout("RigaImpostazioniT")
			If Dark=1 Then
				PanTop.Color=Colors.Black
			End If
		Case 1
			p.SetLayoutAnimated(0,0,0,ClvSetting.AsView.Width,55dip)
			p.LoadLayout("RigaImpostazioniC")
			If Dark=1 Then
				PanCentrale.Color=Colors.Black
			End If
		Case 2
			p.SetLayoutAnimated(0,0,0,ClvSetting.AsView.Width,75dip)
			p.LoadLayout("RigaImpostazioniD")
			If Dark=1 Then
				PanBottom.Color=Colors.Black
			End If
	End Select
	If Dark=1 Then
		LabFreccia.TextColor=Colors.White
		LabTesto.TextColor=Colors.White
	End If
	LabTesto.text=testo
	LabIcona.Text=icona
	LabIcona.TextColor=colore

	Return p
End Sub


Sub ImpostaTema
	If Dark=1 Then
		CmdAdd.TextColor=Colors.White
		LblChiudi.TextColor=Colors.White
		LabNome.TextColor=Colors.White
		PanTestata.Color=Colors.Black
		Root.Color=Colors.DarkGray
	Else
		CmdAdd.TextColor=Colors.Black
		LblChiudi.TextColor=Colors.Black
		LabNome.TextColor=Colors.Black
		PanTestata.Color=Colors.White
		Root.Color=Colors.Transparent
	End If
	
End Sub