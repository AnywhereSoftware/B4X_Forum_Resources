B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
' ================================================================
' File:			HMITiles
' Brief:		Example showing all HMITiles.
' Date:			2025-12-17
' Author:		Robert W.B. Linn (c) 2025 MIT
' Description:	This library provides HMITile views following the ISA-101 standard.
' DependsOn:	XUI Views, ByteConverter
' ================================================================

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
#End Region

Sub Class_Globals
	Private VERSION As String	= "HMITiles Overview Example"
	Private ABOUT As String 	= $"${VERSION} (c) 2025 Robert W.B. Linn - MIT"$
	
	' UI
	Private xui As XUI
	Private Root As B4XView
	Private LabelAbout As B4XView
	
	' UI HMITiles
	Private HMITileButtonOnOff As HMITileButton
	Private HMITileButtonToggle As HMITileButton
	Private HMITileEventViewer1 As HMITileEventViewer
	Private HMITileButtonAlarm As HMITileButton
	Private HMITileLevelVessel As HMITileLevel
	Private HMITileSliderIndicator As HMITileSlider
	Private HMITileListCommands As HMITileList
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	' UI  additional settings
	Root.Color = HMITileUtils.COLOR_BACKGROUND_SCREEN
	B4XPages.SetTitle(Me, VERSION)
	B4XPages.GetNativeParent(Me).Resizable = False
	LabelAbout.Text = ABOUT

	' Ensure to set sleep prior calling customviews
	Sleep(1)
	
	' Eventviewer
	HMITileEventViewer1.CompactMode = False
	HMITileEventViewer1.Insert(VERSION, HMITileUtils.EVENT_LEVEL_INFO)

	' OnOff Button
	HMITileButtonOnOff.State = False
	HMITileButtonOnOff_Click
	
	' Toggle Button
	HMITileButtonToggle.SetStateFontFontAwesome
	HMITileButtonToggle.State = False
	HMITileButtonToggle_Click
	
	' LevelIndicator
	HMITileLevelVessel.Value = 25

	' SliderIndicator	
	HMITileSliderIndicator.BarValue.Vertical = True
	HMITileSliderIndicator.Value = 50
	HMITileSliderIndicator.BarValue.ShowTicks = False
	HMITileSliderIndicator.BarValue.Enabled = False
	HMITileSliderIndicator.BarValue.ThumbRadius = 0
	HMITileSliderIndicator.BarValue.ActiveBarWidth = 	HMITileSliderIndicator.mBase.Width - 10
	HMITileSliderIndicator.BarValue.InActiveBarWidth = 	HMITileSliderIndicator.mBase.Width - 10
	
	' List
	HMITileListCommandsAddItems
End Sub

' ================================================================
' BUTTONS
' ================================================================

Private Sub HMITileButtonOnOff_Click
	HMITileButtonOnOff.SetState(HMITileButtonOnOff.State)
	HMITileButtonOnOff.StateText = IIf(HMITileButtonOnOff.State, "ON", "OFF")
	HMITileEventViewer1.Insert($"[HMITileButtonOnOff] state=${HMITileButtonOnOff.State}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

' Button with fontawesome looks like a toggle switch.
Private Sub HMITileButtonToggle_Click
	HMITileButtonToggle.SetState(HMITileButtonToggle.State)
	HMITileButtonToggle.StateText = IIf(HMITileButtonToggle.State, Chr(0xF205), Chr(0xF204)) ' FA toggle-on / toggle-off
	HMITileEventViewer1.Insert($"[HMITileButtonToggle] state=${HMITileButtonToggle.State}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

Private Sub HMITileButtonAlarm_Click
	HMITileEventViewer1.Insert($"[HMITileButtonAlarm] state=${HMITileButtonToggle.State}"$, HMITileUtils.EVENT_LEVEL_ALARM)
End Sub

' ================================================================
' RGB
' ================================================================

Private Sub HMITileRGB_ValueChanged (m As Map)
	Dim tile As HMITileRGB = Sender
	HMITileEventViewer1.Insert($"[HMITileRGB1_ValueChanged] tile=${tile.Title}, value=${m}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

' ================================================================
' SLIDER
' ================================================================

Private Sub HMITileSlider1_ValueChanged (value As Int)
	HMITileLevelVessel.Value = value
	If value > 90 Then
		HMITileLevelVessel.TypeStyle = HMITileUtils.TYPESTYLE_ALARM
		HMITileEventViewer1.Insert($"[HMITileSlider1_ValueChanged] value=${value}"$, HMITileUtils.EVENT_LEVEL_ALARM)
	Else if value > 70 Then
		HMITileLevelVessel.TypeStyle = HMITileUtils.TYPESTYLE_WARNING
		HMITileEventViewer1.Insert($"[HMITileSlider1_ValueChanged] value=${value}"$, HMITileUtils.EVENT_LEVEL_WARNING)
	Else if value == 0 Then
		HMITileLevelVessel.SetTileStyleAlarm
	Else
		HMITileLevelVessel.TypeStyle = HMITileUtils.TYPESTYLE_NORMAL
		HMITileEventViewer1.Insert($"[HMITileSlider1_ValueChanged] value=${value}"$, HMITileUtils.EVENT_LEVEL_INFO)
	End If
End Sub

' ================================================================
' EVENTVIEWER
' ================================================================

Private Sub HMITileEventViewer1_ItemClick (Index As Int, Value As Object)
	HMITileEventViewer1.Insert($"[HMITileEventViewer1_ItemClick] index=${Index}, value=${Value}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

' ================================================================
' LIST
' ================================================================
Private Sub HMITileListCommandsAddItems
	' Items with secondary information
	For i = 0 To 9
		HMITileListCommands.Add($"${"item"} ${i}"$, i, $"${"item"} ${i}"$)
	Next

	' Items without secondary information
	i = 10
	HMITileListCommands.Add($"${"item"} ${i}"$, "", i)
	i = 11
	HMITileListCommands.Add($"${"item"} ${i}"$, "", i)
End Sub

Private Sub HMITileListCommands_ItemClick (Index As Int, Value As Object)
	HMITileEventViewer1.Insert($"[HMITileListCommands_ItemClick] index=${Index}, value=${Value}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub