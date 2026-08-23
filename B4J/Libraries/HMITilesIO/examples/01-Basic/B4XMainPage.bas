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
	Private VERSION As String	= "HMITilesIO v20260821"
	Private ABOUT As String 	= "HMITilesIO (c) 2026 Robert W.B. Linn - MIT"
	
	' UI
	Private xui As XUI
	Private Root As B4XView
	Private LabelAbout As B4XView
	
	' UI HMITilesIO
	Private TileSwitch As HMITilesIO
	Private TileGauge As HMITilesIO
	Private TileLEDPanel As HMITilesIO
	Private TileVerticalMeter As HMITilesIO
	Private TileSlider As HMITilesIO
	Private TileSevenSegment As HMITilesIO
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

	' Switch
	TileSwitch.State = False
	' LEDPanel
	TileLEDPanel.State = True

	' ----------
	' Value
	' ----------

	' Slider
	TileSlider.Value = 68
	' SevenSegment
	TileSevenSegment.Value = TileSlider.Value
	' Gauge
	TileGauge.Value = TileSlider.Value
	TileGauge.SetHeader("MyGauge")
	TileGauge.SetFooter($"${NumberFormat(TileGauge.Value, 0, 0)}"$)
	' VMeter
	TileVerticalMeter.Value = TileSlider.Value
End Sub

' ================================================================
' TILE EVENTS
' ================================================================

Private Sub TileSwitch_Click(state As Boolean, value As Float)
	TileSwitch.State = IIf(state, False, True)
	Log($"[TileSwitch_Click] state=${TileSwitch.state}, value=${TileSwitch.value}"$)
End Sub

Private Sub TileLEDPanel_Click(state As Boolean, value As Float)
	TileLEDPanel.State = IIf(state, False, True)
	Log($"[TileLEDPanel_Click] state=${TileLEDPanel.state}, value=${TileLEDPanel.value}"$)
End Sub

Private Sub TileSlider_Click(state As Boolean, value As Float)
	' Update several component values
	TileGauge.Value = value
	TileGauge.SetFooter($"${NumberFormat(TileGauge.Value, 0, 0)}"$)

	TileVerticalMeter.Value = value

	TileSevenSegment.Value = value
	Log($"[TileSlider_Click] state=${TileSlider.state}, value=${TileSlider.value}"$)
End Sub
