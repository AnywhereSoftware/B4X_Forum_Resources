B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
' ================================================================
' File:			WaterTankSimulator
' Brief:		An interactive water tank PID simulator demonstrating selective HMITiles.
' Date:			2026-01-09
' Author:		Robert W.B. Linn (c) 2025-2026 MIT
' Description:	WaterTankSimulator is a lightweight B4J demo application that simulates a controlled water tank process with input flow, tank level, and output flow.
'				It showcases the practical use of HMITiles (SP/PV tiles, mini trends, and readouts).
'				The simulator includes dynamic process behavior, trend visualization, and setpoint control, making it ideal For demonstrations, experimentation, And HMI design validation.
' 				Important:
'				Input trend shows disturbance (PV)
' 				Tank trend shows controlled process value (PV)
'				Tiles mapping:
'				| Component        | Tile Type        | Function                                      |
'				| ---------------- | ---------------- | --------------------------------------------- |
'				| Input Flow       | HMITileSPPV      | Setpoint / PV input, trend visualization      |
'				| Tank Level       | HMITileSPPV      | Setpoint / PV tank level, trend visualization |
'				| Output Flow      | HMITileReadOut   | Just display output flow value                |
'				| Trend Input      | HMITileTrend     | Shows input flow history                      |
'				| Trend Tank       | HMITileTrend     | Shows tank level history                      |
' How it works:	
'				Tank level is an integrating process > flows add up over time
'				PID controller adjusts the outlet valve
'				- High level > open valve more
'				- Low level > close valve
'				- The Integral term remembers past error
'				- Without this > steady - state offset
'				- If abused > oscillation or “jumping”
'				- This Is controlled by:
'					Allow the Integral term To go positive And negative
'					so the controller can smoothly balance inflow And outflow.
' ================================================================

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
#End Region

Sub Class_Globals
	' ================================================================
	' APPLICATION METADATA
	' ================================================================
	Private VERSION As String	= "Water Tank Simulator v20260109"
	Private ABOUT As String 	= $"HMITiles (c) 2025-2016 Robert W.B. Linn - MIT"$

	' ================================================================
	' UI ROOT & CORE
	' ================================================================
	Private xui As XUI
	Private Root As B4XView
	Private LabelAbout As B4XView

	' ================================================================
	' HMI TILES
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
	Private TileSeekBarOutputValvePosition As HMITileSeekBar
	Private TileTrendOutputValvePosition As HMITileTrend
	
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
	Root.LoadLayout("mainpage")

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
	LabelAbout.TextColor = HMITileUtils.COLOR_TEXT_WARNING

	' Allow CustomViews to fully initialize
	Sleep(1)

	' ================================================================
	' EVENT VIEWER
	' ================================================================
	TileEvents.Insert(VERSION, HMITileUtils.EVENT_LEVEL_INFO)

	' ================================================================
	' FLOW LOOP (FRC)
	' ================================================================
	TileSPPVInput.Title = "FIC-101"
	TileSPPVInput.PV = 0
	TileSPPVInput.SP = InputFlowSP
	TileSPPVInput.StepSize = 5
	TileTrendInput.Title = "FR-101"

	' ================================================================
	' LEVEL LOOP (LRC)
	' ================================================================
	TileSPPVTankLevel.Title = "LIC-101"
	TileSPPVTankLevel.PV = TankLevelSP
	TileSPPVTankLevel.SP = TankLevelSP
	TileSPPVTankLevel.StepSize = 5
	TileTrendTankLevel.Title = "LR-101"

	' ================================================================
	' OUTPUT
	' ================================================================
	TileReadoutOutput.Title = "FI-102"
	TileReadoutOutput.Value = 0
	TileReadoutOutput.Unit = ""
	TileTrendOutput.Title = "FR-102"
	TileSeekBarOutputValvePosition.Title = "VPI-102"
	TileSeekBarOutputValvePosition.Value = 0
	TileSeekBarOutputValvePosition.MinValue = 0
	TileSeekBarOutputValvePosition.MaxValue = 50
	TileSeekBarOutputValvePosition.Unit = "Valve %"

	TileTrendOutputValvePosition.Title = "VPR-102"
	TileTrendOutputValvePosition.Add(TileSeekBarOutputValvePosition.Value)

	' ================================================================
	' SIMULATOR CONTROL BUTTON
	' ================================================================
	TileButtonOnOff.Title = "Simulator"
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
	ValveCmd = Max(0, Min(100, ValveCmd))
	TileSeekBarOutputValvePosition.Value = Round(ValveCmd)
	TileTrendOutputValvePosition.Add(TileSeekBarOutputValvePosition.Value)
	
	' ------------------------------------------------
	' OUTPUT VALVE PHYSICS
	' ------------------------------------------------
	' Valve effectiveness depends on tank level
	' (gravity head / outlet pressure effect)
	Dim ValveGain As Float = 1.2
	OutputFlow = ValveCmd * ValveGain * (0.3 + 0.7 * TankLevelPV / 100)
	' OutputFlow = ValveCmd * ValveGain * (TankLevelPV / 100)

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
' This controller regulates tank level by adjusting the outlet valve.
'
' Reverse acting:
'   - If level is ABOVE setpoint → increase output flow
'   - If level is BELOW setpoint → reduce output flow
'
' The tank itself is an integrating process, so the controller
' must be gentle and well-damped.
'
Private Sub PID_Control(SetPoint As Float, PV As Float) As Float

	' ------------------------------------------------
	' CONTROL ERROR
	' ------------------------------------------------
	' Reverse acting error:
	' Positive error means level is too high
	' Negative error means level is too low
	Dim error As Float = PV - SetPoint

	' ------------------------------------------------
	' INTEGRAL TERM
	' ------------------------------------------------
	' The integral term accumulates error over time.
	' This removes steady-state offset caused by
	' constant inflow disturbances.
	'
	' Scaling factor (0.2) makes integration slower
	' and prevents oscillation.
	Integral = Integral + error * dt * 0.2

	' ------------------------------------------------
	' ANTI-WINDUP (SYMMETRIC)
	' ------------------------------------------------
	' Integral is clamped in BOTH directions.
	' Allowing negative integral is critical:
	' otherwise the controller "snaps" at setpoint
	' and causes level oscillation.
	If Integral > 100 Then Integral = 100
	If Integral < -100 Then Integral = -100

	' ------------------------------------------------
	' CONTROLLER OUTPUT
	' ------------------------------------------------
	' Proportional term reacts immediately to level error
	' Integral term provides long-term correction
	Dim out As Float = Kp * error + Ki * Integral

	' ------------------------------------------------
	' OUTPUT LIMITS
	' ------------------------------------------------
	' Valve command is limited to physical range
	' (0–100 % open)
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
	TileEvents.Insert($"[TileButtonOnOff] state=${TileButtonOnOff.State}"$, HMITileUtils.EVENT_LEVEL_WARNING)

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

