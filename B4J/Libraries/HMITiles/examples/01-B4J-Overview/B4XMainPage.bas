B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
' ================================================================
' File:			HMITiles
' Brief:		Example B4J program for the HMITiles B4X library.
' Description:	Show usage of selective HMITiles.
' Date:			2025-01-01
' Author:		Robert W.B. Linn (c) 2025-2026 MIT
' DependsOn:	XUI Views, ByteConverter, JavaObject
' ================================================================

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
#End Region

Sub Class_Globals
	Private VERSION As String	= "HMITiles Example Overview v20260101"
	Private ABOUT As String 	= $"HMITiles (c) 2025-2026 Robert W.B. Linn - MIT"$
	
	' UI
	Private xui As XUI
	Private Root As B4XView
	Private LabelAbout As B4XView
	
	' UI HMITiles
	Private TileButtonOnOff As HMITileButton
	Private TileButtonToggle As HMITileButton
	Private TileEventViewer As HMITileEventViewer
	Private TileButtonAlarm As HMITileButton
	Private TileLevel As HMITileLevel
	Private TileSeekBarIndicator As HMITileSeekBar
	Private TileList As HMITileList
	Private TileReadOut As HMITileReadout
	Private TileSPPV1 As HMITileSPPV
	Private TileSPPV2 As HMITileSPPV
	Private TileSelect As HMITileSelect
	Private TileSelectList As HMITileSelectList
	Private TileTrend As HMITileTrend
	Private TileGauge As HMITileGauge
	Private TileDigitalClock As HMITileDigitalClock
	Private TileSeekBar As HMITileSeekBar
	Private TileSensor As HMITileSensor
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("mainpage")

	' UI  additional settings
	Root.Color = HMITileUtils.COLOR_BACKGROUND_SCREEN
	#if B4A
	B4XPages.SetTitle(Me, $"${VERSION} (B4A)"$)
	#End If
	#if B4J
	B4XPages.SetTitle(Me, $"${VERSION} (B4J)"$)
	B4XPages.GetNativeParent(Me).Resizable = False
	#End If
	LabelAbout.Text = ABOUT
	LabelAbout.TextColor = HMITileUtils.COLOR_TEXT_WARNING

	' Ensure to set sleep prior calling customviews
	Sleep(1)

	' Digital Clock
	TileDigitalClock.ShowSeconds = True
	
	' Eventviewer
	TileEventViewer.CompactMode = False
	TileEventViewer.Insert(VERSION, HMITileUtils.EVENT_LEVEL_INFO)

	' OnOff Button
	TileButtonOnOff.State = False
	TileButtonOnOff_Click
	
	' Toggle Button
	TileButtonToggle.SetStateFontFontAwesome
	TileButtonToggle.State = False
	TileButtonToggle_Click

	' Readout
	TileReadOut.Value = 67
	
	' LevelIndicator
	TileLevel.Value = 25

	' SliderIndicator	
	TileSeekBarIndicator.Vertical = True
	TileSeekBarIndicator.Value = 25
	TileSeekBarIndicator.ShowTicks = False
	' TileSeekBarIndicator.Enabled = False
	TileSeekBarIndicator.ThumbRadius = 0
	TileSeekBarIndicator.ActiveBarWidth		= TileSeekBarIndicator.mBase.Width * 0.2
	TileSeekBarIndicator.InActiveBarWidth	= TileSeekBarIndicator.mBase.Width * 0.2
	
	' List
	TileListAddItems
	
	' SPPV
	TileSPPV1.DeviationLimit = 10
	TileSPPV1.SP = 25
	TileSPPV1.PV = 20
	TileSPPV1.StepSize = 5
	TileSPPV1.ShowDeviation = True
	TileSPPV1.EditMode = True

	' Trend
	' Sleep(1)
	TileTrendAddData

	' SelectList
	TileSelectList.CompactMode = True
	TileSelectListAddAll

	TileSelect.AddAll(Array As String("ON", "OFF", "BLINK"))
	TileSelect.Selected = "ON"
End Sub

' ================================================================
' BUTTONS
' ================================================================

Private Sub TileButtonOnOff_Click
	TileButtonOnOff.SetState(TileButtonOnOff.State)
	TileButtonOnOff.StateText = IIf(TileButtonOnOff.State, "ON", "OFF")
	TileEventViewer.Insert($"[TileButtonOnOff] state=${TileButtonOnOff.State}"$, HMITileUtils.EVENT_LEVEL_INFO)
	TileEventViewer.Insert($"[TileButtonOnOff] ${TileEventViewer.StateSummary}"$, HMITileUtils.EVENT_LEVEL_INFO)
	TileEventViewer.Insert($"[TileButtonOnOff] slidermax=${TileSeekBarIndicator.MaxValue}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

' Button with fontawesome looks like a toggle switch.
Private Sub TileButtonToggle_Click
	TileButtonToggle.SetState(TileButtonToggle.State)
	TileButtonToggle.StateText = IIf(TileButtonToggle.State, Chr(0xF205), Chr(0xF204)) ' FA toggle-on / toggle-off
	TileEventViewer.Insert($"[TileButtonToggle] state=${TileButtonToggle.State}"$, HMITileUtils.EVENT_LEVEL_INFO)
	
	If TileButtonToggle.State Then
		TileTrend.Clear
		TileEventViewer.Insert($"[TileButtonToggle] TileTrend cleared (#${TileTrend.Size})"$, HMITileUtils.EVENT_LEVEL_WARNING)
	End If
End Sub

Private Sub TileButtonAlarm_Click
	TileEventViewer.Insert($"[TileButtonAlarm] state=${TileButtonToggle.State}"$, HMITileUtils.EVENT_LEVEL_ALARM)
End Sub

' ================================================================
' RGB
' ================================================================

Private Sub TileRGBHorizontal_ValueChanged (m As Map)
	Dim tile As HMITileRGB = Sender
	TileEventViewer.Insert($"[TileRGBHorizontal_ValueChanged] tile=${tile.Title}, value=${m}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

' ================================================================
' SLIDER
' ================================================================

' Handle slider value changed.
' Set the value and style (Normal, Warning, Alarm) for selected tiles.
Private Sub TileSeekBar_ValueChanged (value As Int)
	Dim level As Int
	TileLevel.Value = value
	TileGauge.Value = value
	TileSensor.Value = value
	TileSeekBarIndicator.Value = value
	TileTrend.Add(value)

	If value > 90 Then
		TileLevel.SetStyleAlarm
		TileGauge.SetStyleAlarm
		TileSensor.SetStyleAlarm
		level = HMITileUtils.EVENT_LEVEL_ALARM
	Else if value > 70 Then
		TileLevel.SetStyleWarning
		TileGauge.SetStyleWarning
		TileSensor.SetStyleWarning
		level = HMITileUtils.EVENT_LEVEL_WARNING
	Else if value == 0 Then
		TileLevel.SetStyleAlarm
		level = HMITileUtils.EVENT_LEVEL_ALARM
	Else
		TileLevel.SetStyleNormal
		TileGauge.SetStyleNormal
		TileSensor.SetStyleNormal
		level = HMITileUtils.EVENT_LEVEL_INFO
	End If
	
	TileEventViewer.Insert($"[TileSeekBar_ValueChanged] value=${value}"$, level)
End Sub

' ================================================================
' EVENTVIEWER
' ================================================================

Private Sub TileEventViewer_ItemClick (Index As Int, Value As Object)
	TileEventViewer.Insert($"[TileEventViewer_ItemClick] index=${Index}, value=${Value}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

' ================================================================
' LIST
' ================================================================

Private Sub TileListAddItems
	' Items with secondary information
	For i = 0 To 2
		TileList.Add($"${"item"} ${i}"$, i, $"${"item"} ${i}"$)
	Next

	' Items without secondary information
	i = 10
	TileList.Add($"${"item"} ${i}"$, "", i)
	i = 11
	TileList.Add($"${"item"} ${i}"$, "", i)
End Sub

Private Sub TileListCommands_ItemClick (Index As Int, Value As Object)
	TileEventViewer.Insert($"[TileListCommands_ItemClick] index=${Index}, value=${Value}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

' ================================================================
' TREND
' ================================================================

Private Sub TileTrendAddData
	Dim data As List
	data.Initialize2(Array As Int(20, 20, 30, 15, 75))
	TileTrend.UpdateChart(data)
End Sub

' ================================================================
' SETPOINT
' ================================================================

Private Sub TileSPPV1_SetPointChanged(Value As Float)
	TileEventViewer.Insert($"[TileSPPV1_SetPointChanged] value=${Value}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

Private Sub TileSPPV2_SetPointChanged(Value As Float)
	TileEventViewer.Insert($"[TileSPPV2_SetPointChanged] value=${Value}"$, HMITileUtils.EVENT_LEVEL_INFO)
	TileSPPV2.PV = Rnd(TileSPPV2.Min, TileSPPV2.Max * 1.1)
End Sub

Private Sub TileSPPV2_ValueChanged(Value As Float)
	TileEventViewer.Insert($"[TileSPPV2_ValueChanged] value=${Value}, setpoint=${TileSPPV2.SP}, deviation=${TileSPPV2.Deviation}"$, HMITileUtils.EVENT_LEVEL_INFO)
	' Set alarm depending deviaton
	If Abs(TileSPPV2.Deviation) > 3 Then
		TileSPPV2.SetStyleAlarm
	Else If Abs(TileSPPV2.Deviation) > 1.5 Then
		TileSPPV2.SetStyleWarning
	Else
		TileSPPV2.SetStyleNormal
	End If
End Sub

' ================================================================
' SELECT
' ================================================================

Private Sub TileSelectListAddAll
	TileSelectList.AddAll(Array As String("Item1", "Item 2", "Item 3"))
End Sub

Private Sub TileSelectList_ItemClick (Index As Int, Value As Object)
	TileEventViewer.Insert($"[TileSelectList_ItemClick] index=${Index}, value=${Value}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub

Private Sub TileSelect_ValueChanged (Value As Object)
	TileEventViewer.Insert($"[TileSelect_ValueChanged] value=${Value}"$, HMITileUtils.EVENT_LEVEL_INFO)
End Sub
