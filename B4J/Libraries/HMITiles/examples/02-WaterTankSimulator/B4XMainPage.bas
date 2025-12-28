B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
' ================================================================
' File:			WaterTankSimulator
' Brief:		A simple interactive water tank PID simulator demonstrating ISA-101–style HMI design using HMITiles.
' Date:			2025-12-25
' Author:		Robert W.B. Linn (c) 2025 MIT
' Description:	WaterTankSimulator is a lightweight B4J demo application that simulates a controlled water tank process with input flow, tank level, and output flow.
'				It showcases the practical use of HMITiles (SP/PV tiles, mini trends, And readouts) following ISA-101 high-performance HMI principles.
'				The simulator includes dynamic process behavior, trend visualization, And setpoint control, making it ideal For demonstrations, experimentation, And HMI design validation.
' 				Important:
'				Input trend shows disturbance (PV)
' 				Tank trend shows controlled process value (PV)
'				Tiles mapping:
'				| Component        | Tile Type        | Function                                      |
'				| ---------------- | ---------------- | --------------------------------------------- |
'				| Input Flow       | HMITileSPPV      | Setpoint / PV input, trend visualization      |
'				| Tank Level       | HMITileSPPV      | Setpoint / PV tank level, trend visualization |
'				| Output Flow      | HMITileReadOut   | Just display output flow value                |
'				| Trend Mini Input | HMITileTrendMini | Shows input flow history                      |
'				| Trend Mini Tank  | HMITileTrendMini | Shows tank level history                      |
' ================================================================

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
#End Region

Sub Class_Globals
	' ================================================================
	' APPLICATION METADATA
	' ================================================================
	Private VERSION As String	= "Water Tank Simulator v20251225"
	Private ABOUT As String 	= $"HMITiles Example ${VERSION} (c) 2025 Robert W.B. Linn - MIT"$

	' ================================================================
	' UI ROOT & CORE
	' ================================================================
	Private xui As XUI
	Private Root As B4XView
	Private LabelAbout As B4XView

	' ================================================================
	' HMI TILES (ISA-101 STYLE)
	' ================================================================
	' Button to start/stop the simulation
	Private TileButtonOnOff As HMITileButton
	
	' Flow controller (FRC) tiles
	Private TileSPPVInput As HMITileSPPV
	Private TileTrendInput As HMITileTrend
	
	' Level controller (LRC) tiles
	Private TileSPPVTankLevel As HMITileSPPV
	Private TileTrendTankLevel As HMITileTrend
	
	' Output (valve / flow) indication
	Private TileReadoutOutput As HMITileReadout
	Private TileTrendOutput As HMITileTrend
	
	' Event / alarm viewer
	Private TileEvents As HMITileEventViewer

	' ================================================================
	' PROCESS VARIABLES (SIMULATION STATE)
	' ================================================================
	' Flow loop (FRC)
	Private InputFlowSP As Float = 20		' Operator-set flow SP
	Private InputFlowPV As Float			' Actual flow PV
	
	' Level loop (LRC)
	Private TankLevelSP As Float = 50		' Desired tank level (%)
	Private TankLevelPV As Float = TankLevelSP
	
	' Manipulated variable (output valve flow)
	Private OutputFlow As Float

	' ================================================================
	' SIMPLE LEVEL PID CONTROLLER (REVERSE ACTING)
	' ================================================================
	' Tuned for slow, integrating level process
	Private Kp As Float = 0.3
	Private Ki As Float = 0.6
	Private Kd As Float = 0.05			'ignore - Not currently used (kept for extension)
	
	Private Integral As Float			' Integral accumulator
	Private LastError As Float			'ignore - Reserved for derivative term

	' ================================================================
	' HISTORY BUFFERS (FOR MINI TRENDS)
	' ================================================================
	Private InputHistory As List
	Private TankHistory As List
	Private OutputHistory As List

	' ================================================================
	' SIMULATION TIMER
	' ================================================================
	Private TimerSimulator As Timer
	Private TIMERSIMULATOR_INTERVAL As Long = 2000	' 2s scan time (slow process)
	Private dt As Float = TIMERSIMULATOR_INTERVAL / 1000	' Simulation time step (0.1 if hardcoded)
End Sub

Public Sub Initialize
	' Enable lifecycle logging for debugging and learning
	B4XPages.GetManager.LogEvents = True
End Sub

' Called once when the page is created
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	' ================================================================
	' SIMULATOR TIMER
	' ================================================================
	' Timer is intentionally disabled at startup.
	' The ON/OFF tile controls execution (ISA-style Run/Stop).
	TimerSimulator.Initialize("TimerSimulator", TIMERSIMULATOR_INTERVAL)
	TimerSimulator.Enabled = False

	' ================================================================
	' GENERAL UI SETTINGS
	' ================================================================
	Root.Color = HMITileUtils.COLOR_BACKGROUND_SCREEN
	B4XPages.SetTitle(Me, VERSION)
	B4XPages.GetNativeParent(Me).Resizable = False
	LabelAbout.Text = ABOUT

	' Allow CustomViews to fully initialize
	Sleep(1)

	' ================================================================
	' EVENT VIEWER
	' ================================================================
	TileEvents.CompactMode = False
	TileEvents.Insert(VERSION, HMITileUtils.EVENT_LEVEL_INFO)

	' ================================================================
	' FLOW LOOP (FRC)
	' ================================================================
	TileSPPVInput.Title = "Input"
	TileSPPVInput.PV = 0
	TileSPPVInput.SP = InputFlowSP
	TileTrendInput.Title = "Input"

	' ================================================================
	' LEVEL LOOP (LRC)
	' ================================================================
	TileSPPVTankLevel.Title = "Tank Level"
	TileSPPVTankLevel.PV = TankLevelSP
	TileSPPVTankLevel.SP = TankLevelSP
	TileTrendTankLevel.Title = "Tank Level"

	' ================================================================
	' OUTPUT
	' ================================================================
	TileReadoutOutput.Title = "Output"
	TileReadoutOutput.Value = 0
	TileReadoutOutput.Unit = ""
	TileTrendOutput.Title = "Output"

	' ================================================================
	' SIMULATOR CONTROL BUTTON
	' ================================================================
	TileButtonOnOff.TitleText = "Simulator"
	TileButtonOnOff.State = True
	TileButtonOnOff_Click	' Apply initial state

	' ================================================================
	' INITIALIZE HISTORY BUFFERS
	' ================================================================
	InputHistory.Initialize
	TankHistory.Initialize
	OutputHistory.Initialize
End Sub

' ================================================================
' SIMULATOR SCAN
' ================================================================
Private Sub TimerSimulator_Tick
	SimulatorStep
End Sub

' ================================================================
' MAIN PROCESS SIMULATION STEP
' ================================================================
Private Sub SimulatorStep
	' ------------------------------------------------
	' FLOW LOOP (FRC)
	' ------------------------------------------------
	' First-order lag towards SP with added noise
	' This represents a realistic flow control loop
	InputFlowPV = InputFlowPV + (InputFlowSP - InputFlowPV) * 0.3
	InputFlowPV = InputFlowPV + (Rnd(-10,10) / 20)

	' ------------------------------------------------
	' LEVEL CONTROLLER (LRC)
	' ------------------------------------------------
	' PID output represents valve command (0–100 %)
	Dim ValveCmd As Float = PID_Control(TankLevelSP, TankLevelPV)

	' ------------------------------------------------
	' OUTPUT VALVE PHYSICS
	' ------------------------------------------------
	' Valve effectiveness depends on tank level
	' (gravity head / outlet pressure effect)
	Dim ValveGain As Float = 1.2
	OutputFlow = ValveCmd * ValveGain * (TankLevelPV / 100)

	' ------------------------------------------------
	' TANK DYNAMICS (INTEGRATING PROCESS)
	' ------------------------------------------------
	TankLevelPV = TankLevelPV + (InputFlowPV - OutputFlow) * dt

	' Physical limits of the tank
	If TankLevelPV < 0 Then TankLevelPV = 0
	If TankLevelPV > 100 Then TankLevelPV = 100

	' ------------------------------------------------
	' UPDATE UI TILES
	' ------------------------------------------------
	InputFlowSP = TileSPPVInput.SP
	TileSPPVInput.PV = NumberFormat(InputFlowPV,1,1)

	TankLevelSP = TileSPPVTankLevel.SP
	TileSPPVTankLevel.PV = NumberFormat(TankLevelPV,0,0)

	TileReadoutOutput.Value = NumberFormat(OutputFlow, 1, 1)

	' ------------------------------------------------
	' UPDATE TRENDS
	' ------------------------------------------------
	InputHistory.Add(InputFlowPV)
	If InputHistory.Size > 50 Then InputHistory.RemoveAt(0)
	TileTrendInput.UpdateChart(InputHistory)

	TankHistory.Add(TankLevelPV)
	If TankHistory.Size > 50 Then TankHistory.RemoveAt(0)
	TileTrendTankLevel.UpdateChart(TankHistory)

	OutputHistory.Add(OutputFlow)
	If OutputHistory.Size > 50 Then OutputHistory.RemoveAt(0)
	TileTrendOutput.UpdateChart(OutputHistory)

	' ------------------------------------------------
	' EVENT LOGGING
	' ------------------------------------------------
	TileEvents.Insert($"[SimulatorStep] Input=${NumberFormat(InputFlowPV,1,1)}, Level=${NumberFormat(TankLevelPV,1,0)}, Output=${NumberFormat(OutputFlow, 1, 1)}"$, _
		HMITileUtils.EVENT_LEVEL_INFO)
End Sub

' ================================================================
' LEVEL PID CONTROLLER (REVERSE ACTING)
' ================================================================
Private Sub PID_Control(SetPoint As Float, PV As Float) As Float
	' Reverse acting:
	' Higher level → more output flow required
	Dim error As Float = PV - SetPoint

	' Integral action removes steady-state offset
	Integral = Integral + error * dt

	' Integral clamping (simple anti-windup)
	If Integral > 100 Then Integral = 100
	If Integral < 0 Then Integral = 0

	Dim out As Float = Kp * error + Ki * Integral

	' Valve command limits (0–100 %)
	If out < 0 Then out = 0
	If out > 100 Then out = 100

	Return out
End Sub

' ================================================================
' SIMULATOR CONTROL BUTTON
' ================================================================
Private Sub TileButtonOnOff_Click
	TileButtonOnOff.SetState(TileButtonOnOff.State)
	TileButtonOnOff.StateText = IIf(TileButtonOnOff.State, "ON", "OFF")
	TileEvents.Insert($"[TileButtonOnOff] state=${TileButtonOnOff.State}"$, _
		HMITileUtils.EVENT_LEVEL_INFO)

	' Start/stop simulation scan
	TimerSimulator.Enabled = TileButtonOnOff.State
End Sub

' ================================================================
' EVENT VIEWER & TILE CALLBACKS
' ================================================================
Private Sub TileEvents_ItemClick (Index As Int, Value As Object)
	TileEvents.Insert($"[TileEvents_ItemClick] index=${Index}, value=${Value}"$, _
		HMITileUtils.EVENT_LEVEL_INFO)
End Sub

Private Sub TileSPPVInput_SetPointChanged(Value As Float)
	TileEvents.Insert($"[TileSPPVInput_SetPointChanged] value=${Value}"$, _
		HMITileUtils.EVENT_LEVEL_INFO)
End Sub

Private Sub TileSPPVTankLevel_SetPointChanged(Value As Float)
	TileEvents.Insert($"[TileSPPVTankLevel_SetPointChanged] value=${Value}"$, _
		HMITileUtils.EVENT_LEVEL_INFO)
End Sub

Private Sub TileSPPVTankLevel_ValueChanged(Value As Float)
	' Deviation alarm based on absolute deviation
	If Abs(TileSPPVTankLevel.Deviation) > TileSPPVTankLevel.DeviationAlarm Then
		TileEvents.Insert($"[TileSPPVTankLevel_ValueChanged] value=${Value}"$, _
			HMITileUtils.EVENT_LEVEL_ALARM)
	End If
End Sub

