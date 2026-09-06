B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
' ================================================================
' File:			B4XMainPage
' Project:		HMITilesIO
' Brief:		Development program for the B4X HMITilesIO library.
' Date:			See Class_Globals VERSION
' Author:		Robert W.B. Linn (c) 2026 MIT
' Description:	This pages is used to develop .
' DependsOn:	XUI Views, JavaObject
' ================================================================

#Region Shared Files
' Ref: www.b4x.com/android/forum/threads/b4x-codebundle-–-export-projects-as-a-single-json-for-ai-analysis.169835/
#Macro: Title, Code bundle, ide://run?File=%ADDITIONAL%\CodeBundle.jar&Args=%PROJECT_NAME%&vmargs=-DCompactJson%3DFalse
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
#End Region

Private Sub Class_Globals
	Private VERSION As String	= "HMITilesIO v20260831"
	Private ABOUT As String 	= "HMITilesIO (c) 2026 Robert W.B. Linn - MIT"
	
	' UI
	Private xui As XUI
	Private Root As B4XView
	Private LabelAbout As B4XView
	
	' UI HMITilesIO
	Private TileSwitch As HMITilesIO
	Private TileGauge As HMITilesIO
	Private TileGaugeReverse As HMITilesIO
	Private TileLEDPanel As HMITilesIO
	Private TileVerticalMeter As HMITilesIO
	Private TileSlider As HMITilesIO
	Private TileSevenSegment As HMITilesIO
	Private TileReadOut As HMITilesIO
	Private TileSpinner As HMITilesIO
	Private TileByteStatus As HMITilesIO
	Private TileSelector As HMITilesIO
	Private TileIOPanel As HMITilesIO
	Private TileMultiState As HMITilesIO
	Private TileVerticalMeter As HMITilesIO
	Private TileButton As HMITilesIO
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("mainpage")

	' UI  additional settings
	Root.Color = 0xFFE6E6E6
	#if B4A
	B4XPages.SetTitle(Me, $"${VERSION} (B4A)"$)
	#End If
	#if B4J
	B4XPages.SetTitle(Me, $"${VERSION} (B4J)"$)
	B4XPages.GetNativeParent(Me).Resizable = False
	#End If
	#if LINUX
	B4XPages.SetTitle(Me, $"${VERSION} (LINUX)"$)
	B4XPages.GetNativeParent(Me).Resizable = False
	#End If
	LabelAbout.Text = ABOUT
	LabelAbout.TextColor = 0xFF000000

	' HMITiles
	' Ensure to set sleep prior calling customviews
	Sleep(1)

	' ----------
	' State
	' ----------

	' Button
	TileButton.State = False

	' LEDPanel
	TileLEDPanel.State = True

	' Switch
	TileSwitch.State = False

	' ----------
	' Value
	' ----------

	' ByteStatus
	TileByteStatus.Value = 103	' 0110 0111
	TileByteStatus.InstanceByteStatus.PinsAttached = Array As Byte(1,1,1,1,1,1,1,1)

'	TileByteStatus.Value = 103	' 0110 0111
'	TileByteStatus.InstanceByteStatus.PinsAttached = Array As Byte(1,1,1,1,0,0,0,0)
	' Log(HMITilesIOByteStatus.ByteToBin(TileByteStatus.Value.As(Byte)))

	' Selector
	TileSelector.Items = Array As String("COM1","COM2","COM3")
	TileSelector.Value = TileSelector.Items.Get(0)
	TileSelector.Footer = "Select COM port"
	
	' Spinner
	TileSpinner.Value = 99
	TileSpinner.ValueFontSize = 18
	
	' ReadOut
	TileReadOut.Value = "Value"
	TileReadOut.ValueFontColor = "#FF0000"

	' Slider
	TileSlider.Value = 68
	' SevenSegment
	TileSevenSegment.Value = TileSlider.Value
		
	' VMeter
	TileVerticalMeter.Value = TileSlider.Value

	' IOPanel
	TileIOPanel.Value = "0111"	' "01010101"
	TileIOPanel.Footer = TileIOPanel.Value
	TileIOPanel.InstanceIOPanel.SetChannelText(3, "P9")

	' Gauge
	TileGauge.Value = TileSlider.Value
	TileGauge.Footer = $"${NumberFormat(TileGauge.Value, 0, 0)}"$
	TileGaugeReverse.Value = TileSlider.Value
	TileGaugeReverse.Footer = $"${NumberFormat(TileGauge.Value, 0, 0)}"$
	TileGaugeReverse.SetSegmentColor(TileGaugeReverse.SEGMENT_RED, TileGaugeReverse.SEGMENT_GREEN_COLOR)
	TileGaugeReverse.SetSegmentColor(TileGaugeReverse.SEGMENT_YELLOW, TileGaugeReverse.SEGMENT_YELLOW_COLOR)
	TileGaugeReverse.SetSegmentColor(TileGaugeReverse.SEGMENT_GREEN, TileGaugeReverse.SEGMENT_RED_COLOR)

	' MultiState
	TileMultiState.InstanceMultiState.States = Array As Byte(1,1,1,1,1,0,0,0)
	TileMultiState.Value = 2
	TileMultiState.Footer = $"Select state"$
	TileMultiState.InstanceMultiState.SetStateText(0, "1")
	TileMultiState.InstanceMultiState.SetStateText(1, "2")
	TileMultiState.InstanceMultiState.SetStateText(2, "3")
	TileMultiState.InstanceMultiState.SetStateText(3, "4")
	TileMultiState.InstanceMultiState.SetStateText(4, "5")
End Sub

' ================================================================
' TILE EVENTS
' ================================================================

Private Sub TileSwitch_Click(state As Boolean, value As String)
	TileSwitch.State = IIf(state, False, True)
	Log($"[TileSwitch_Click] state=${TileSwitch.state}, value=${TileSwitch.value}"$)
End Sub

Private Sub TileLEDPanel_Click(state As Boolean, value As String)
	TileLEDPanel.State = IIf(state, False, True)
	Log($"[TileLEDPanel_Click] state=${TileLEDPanel.state}, value=${TileLEDPanel.value}"$)
End Sub

Private Sub TileGauge_Click(state As Boolean, value As String)
	Log($"[TileGauge_Click] state=${TileGauge.state}, value=${TileGauge.value}"$)
End Sub

Private Sub TileSlider_Click(state As Boolean, value As String)
	' Update several component values
	TileGauge.Value = value.As(Float)
	TileGauge.SetFooter($"${NumberFormat(TileGauge.Value, 0, 0)}"$)
	TileGaugeReverse.Value = value.As(Float)
	TileGaugeReverse.SetFooter($"${NumberFormat(TileGaugeReverse.Value, 0, 0)}"$)

	TileVerticalMeter.Value = value.As(Float)

	TileSevenSegment.Value = value.As(Float)
	Log($"[TileSlider_Click] state=${TileSlider.state}, value=${TileSlider.value}"$)
End Sub

Private Sub TileReadOut_Click(State As Boolean, Value As String)
	Log($"[TileReadOut_Click] state=${State}, value=${Value}"$)
End Sub

Private Sub TileByteStatus_Click(State As Boolean, Value As String)
	Log($"[TileByteStatus_Click] state=${State}, value=${Value}"$)
End Sub

Private Sub TileSelector_Click(State As Boolean, Value As String)
	Log($"[TileSelector_Click] state=${State}, value=${Value}"$)
	TileReadOut.Value = Value
End Sub

Private Sub TileMultiState_Click(State As Boolean, Value As String)
	Log($"[TileMultiState_Click] state=${State}, value=${Value}"$)
	TileMultiState.Footer = $"Set state ${Value}"$
End Sub

Private Sub TileIOPanel_Click(state As Boolean, value As String)
	Log($"[TileIOPanel_Click] state=${state}, value=${value}"$)
	TileIOPanel.Footer = TileIOPanel.Value
End Sub

Private Sub TileSevenSegment_Click(state As Boolean, value As String)
	Log($"[TileSevenSegment_Click] state=${state}, value=${value}"$)
End Sub

Private Sub TileVerticalMeter_Click(state As Boolean, value As String)
	Log($"[TileVerticalMeter_Click] state=${state}, value=${value}"$)
End Sub

Private Sub TileButton_Click(state As Boolean, value As String)
	TileButton.State = IIf(state, False, True)
	Log($"[TileButton_Click] state=${TileButton.state}, value=${TileButton.value}"$)
End Sub

