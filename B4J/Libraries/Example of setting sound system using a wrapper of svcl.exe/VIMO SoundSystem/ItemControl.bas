B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private Event_Name As String
	Private base As Pane
	Public Properties As Map
	Private ivControl As ImageView
	Private lblName As Label
	Private lblDeviceName As Label
	Private Tag As String
	Private lblVolume As Label
	Private sldVolume As Slider
	Private lblBalance As Label
	Private sldBalance As Slider
	Private chbMute As CheckBox
	Private btnDefault As Button
	Private ivDefault As ImageView

	
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(EventName As String)
	Event_Name=EventName
	base.Initialize("base")
	Properties.Initialize
	Tag=""
	ivControl.Initialize("ivControl")
	lblName.Initialize("lblName")
	lblName.Text="Name"
	lblName.Alignment="CENTER"
	lblDeviceName.Initialize("lblDeviceName")
	lblDeviceName.Text="DeviceName"
	lblDeviceName.Alignment="CENTER"
	lblBalance.Initialize("lblBalance")
	lblBalance.Text="Balance"
	lblBalance.Alignment="CENTER"
	sldBalance.Initialize("sldBalance")
	lblVolume.Initialize("lblVolume")
	lblVolume.Text="Volume"
	lblVolume.Alignment="CENTER"
	sldVolume.Initialize("sldVolume")
	chbMute.Initialize("chbMute")	
	chbMute.Text="Mute"
	btnDefault.Initialize("btnDefault")
	btnDefault.Text="  Default"
	ivDefault.Initialize("ivDefault")
End Sub

Public Sub AddTo(pane As Pane,left As Int,top As Int,width As Int,height As Int)
	base.SetSize(width,height)
	sldVolume.MaxValue=100
	sldVolume.MinValue=0
	sldVolume.Vertical=True
	sldBalance.MaxValue=200
	sldBalance.MinValue=0
	sldBalance.Value=100
	sldBalance.Vertical=False
	Dim img As Image
	img.Initialize(File.DirAssets,"settings.png")
	ivControl.SetImage(img)
	
	base.AddNode(lblName,10,10,120,30) 
	base.AddNode(lblDeviceName,10,40,120,30)
	base.AddNode(lblBalance,10,70,90,30)
	base.AddNode(sldBalance,10,100,90,30)
	base.AddNode(lblVolume,10,130,90,30)
	base.AddNode(sldVolume,40,160,30,200)
	base.AddNode(chbMute,25,360,80,30)

	base.AddNode(btnDefault,10,400,120,30)
	base.AddNode(ivDefault,15,410,20,20)
	btnDefault.TextSize=20
	base.AddNode(ivControl,45,450,40,40)

	
	pane.AddNode(base,left,top,width,height)
	StyleTickMarks(sldVolume)
End Sub

Private Sub StyleTickMarks(sld As Slider)
	sld.As(JavaObject).RunMethod("setShowTickLabels", Array(True))
	sld.As(JavaObject).RunMethod("setShowTickMarks", Array(True))
	sld.As(JavaObject).RunMethod("setValueChanging", Array(True))
	sld.As(JavaObject).RunMethod("setSnapToTicks", Array(True))
End Sub

Public Sub UpdateControl(map As Map)
	Properties=map
	Dim icon ,icon1 As Image
	
	Dim name As String=map.Get("Name")
	Tag=map.Get("Command-Line Friendly ID")
	lblName.Text=name
	lblDeviceName.Text=map.Get("Device Name")
	If map.Get("Default")="Render" Or map.Get("Default")="Capture" Then
		icon.Initialize(File.DirAssets,"on.png")
		btnDefault.TextColor=fx.Colors.Green
		CSSUtils.SetBackgroundColor(btnDefault, fx.Colors.DarkGray)
		icon1.Initialize(File.DirAssets,"settings.png")
	Else
		icon.Initialize(File.DirAssets,"off.png")
		btnDefault.TextColor=fx.Colors.White
		CSSUtils.SetBackgroundColor(btnDefault, fx.Colors.Gray)
		icon1.Initialize(File.DirAssets,"settingsoff.png")
	End If
	ivDefault.SetImage(icon)
	ivControl.SetImage(icon1)
	'Update Volume Control
	'Dim VolumePercent As String=map.Get("Volume Percent")
	'VolumePercent=VolumePercent.Replace("%","")
	'Dim Percent As Double=VolumePercent
	Dim volume As Double=Main.Sound.getVolume(Tag)
	Log(volume)
	
	sldVolume.Value=volume
	
	' Update Mute Control
	If map.Get("Muted")="No" Then
		chbMute.Checked=False
	Else
		chbMute.Checked=True
	End If

	'Update Balance Control

	If map.Get("Channels Count")="2" Then
		'Dim response As String=Main.Sound.getVolumeChannels(Tag)
		'Dim channels() As String=Regex.Split(",",response)
		Dim channels() As String=Main.Sound.getVolumeChannels(Tag)
		
		Log(channels(0) & " - " & channels(1))


		
		'Calculate sldBalance Position
		Dim value As Double
		If Main.lblControls.Text.Contains("Devices") Then

			If channels(0)>channels(1) Then
				value=100-channels(0)*100/volume
			Else if channels(0)<channels(1) Then
				value=100+channels(1)*100/volume
			Else
				value=100
			End If
		Else
			value=100
		End If
		
		sldBalance.Enabled=True
		sldBalance.Value=value
	Else
		sldBalance.Enabled=False
	End If

	' Hide some item controls
	If Main.lblControls.Text.Contains("Subunits") Or Main.lblControls.Text.Contains("Applications")Then
		lblBalance.Visible=False
		sldBalance.Visible=False
		btnDefault.Visible=False
		ivDefault.Visible=False
		ivControl.Visible=False
		lblVolume.Top=lblDeviceName.Top+30
		sldVolume.Top=lblVolume.Top+30
		sldVolume.PrefHeight=sldVolume.PrefHeight+40
	
	End If
	


	

End Sub


Private Sub sldVolume_ValueChange (value As Double)
	'Working
	Main.Sound.SetVolume(Tag, value)
End Sub

Private Sub sldBalance_ValueChange (value As Double)
	'WORKING

	'Calculate Left and Right Channels
	Dim lChannel As Double=100.0
	Dim rChannel As Double=100.0
	If value>100 Then
		lChannel=lChannel+100-value
	End If
	If value<100 Then
		rChannel=value
	End If
	
	If lChannel>sldVolume.Value Then lChannel=sldVolume.Value
	If rChannel>sldVolume.Value Then rChannel=sldVolume.Value
	
	Main.Sound.setVolumeChannels(Tag, lChannel,rChannel)
End Sub
Private Sub chbMute_CheckedChange(Checked As Boolean)

	'Main.Sound.Switch(Tag)
	'Return
	If Checked Then
		Main.Sound.Mute(Tag)
	Else
		Main.Sound.Unmute(Tag)
	End If
	
End Sub

Private Sub chbListenTo_CheckedChange(Checked As Boolean)
	Main.Sound.listenDevice(Tag,Checked)
End Sub

Private Sub btnDefault_Click
	Log(Tag)
	Main.Sound.Stop
	Main.Sound.setDefault(Tag,"all")
	Main.RefreshDevices
	Main.Sound.Start
	
End Sub

Private Sub cbbSpatial_ValueChanged (Value As Object)
	Main.Sound.setSpatial(Tag,Value)	
End Sub





Private Sub lblVolume_MouseClicked (EventData As MouseEvent)
	sldVolume.Value=80
End Sub

Private Sub lblBalance_MouseClicked (EventData As MouseEvent)
	sldBalance.Value=100
End Sub












Private Sub ivControl_MouseClicked(EventData As MouseEvent)
	If Tag.Contains("Render") Or Tag.Contains("Capture") Then
		Dim p As B4XView=Main.paneControls
		p.BringToFront
		p.Left=Main.scrControls.Left+base.Left+base.Width+50
			p.Top=Main.scrControls.Top+50
		p.Visible=True
		p.Tag=Tag
		If Tag.Contains("Render") Then
			Main.chbListenTo.Visible=False
			Main.cbbSpatial.Visible=True
			Main.lblSpatial.Visible=True
		Else if Tag.contains("Capture") Then
			Main.chbListenTo.Visible=True
			Main.cbbSpatial.Visible=False
			Main.lblSpatial.Visible=False
		End If
	End If

	
End Sub

private Sub base_MouseClicked(EventData As MouseEvent)
	ShowProperties
End Sub
Public Sub ShowProperties()
	Dim parser As JSONParser
	'Dim Devices As String=Main.Sound.getDevices("/sjson")
	'parser.Initialize(Devices)
	Main.Sound.SaveDevices("/sjson",False,False)
	Sleep(100)
	parser.Initialize(File.ReadString(File.DirApp,"devices.json"))
	Dim list As List=parser.NextArray
	For i=0 To list.Size-1
		Dim map As Map=list.Get(i)
		If Tag=map.Get("Command-Line Friendly ID") Then
			Properties=map
			Exit
		End If
	Next
	
	For Each key In Properties.Keys
		Log(key & "-" & Properties.Get(key))
	Next
End Sub







