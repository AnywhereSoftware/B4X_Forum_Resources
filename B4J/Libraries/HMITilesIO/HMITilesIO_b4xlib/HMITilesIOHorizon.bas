B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ==============================================================================
' File:         HMITilesIOHorizon.bas
' Brief:        Flight Attitude Indicator / Künstlicher Horizont UI Tile Component
' Date:         2026-09-25
' Framework:    HMITilesIO Ecosystem (Strict 3-Parameter Signature Standard)
' Platform:     B4J (Optimized for JavaFX WebEngine Hardware Acceleration on Pi 5)
'
' Technical Specifications:
' -------------
' Vector Math:  Translates combined linear Y-axis displacement (Pitch) and 
'               2D rotational Z-axis angle transformations (Roll) via JavaScript
'               DOM manipulation.
' Core Elements:
'   1. #tile-header: Displays static or dynamic alphanumeric upper title labels.
'   2. #tile-footer: Reflects calculated engineering readouts (e.g., "Pitch:5.5° | Roll:-12.3°").
'   3. #horizon-pitch-group: Inner SVG container translated vertically along 
'      the Y-axis using the PIXELS_PER_DEGREE coefficient.
'   4. #horizon-gyro-group: Middle SVG container rotated around the absolute 
'      viewBox center matrix origin (60, 60).
'
' Aviation Standard Flight Warning System (FWS) & Alarm Settings:
' -------------
' Use these real-world thresholds to drive HMI alarm states or physical buzzers:
'
' 1. BANK ANGLE (ROLL) ALERT ENVELOPE (GPWS Mode 6 Standard):
'    * Soft Warning (Pre-Alert): Absolute value >= 35.0° Roll.
'      Cockpit Action: Yellow/Amber Master Caution. Periodic voice callout ("Bank Angle!").
'    * Hard Warning (Structural Limit): Absolute value >= 45.0° to 50.0° Roll.
'      Cockpit Action: Continuous Red Master Warning. Fast acoustic alert loop.
'    * Extreme Boundary: > 60.0° Roll (Classified as an illegal aerodynamic stunt profile).
'
' 2. PITCH ATTITUDE PROTECTION LIMITS (Commercial Flight Envelope):
'    * Nose-Up Climb Limit: +30.0° Max.
'      Cockpit Action: Red Warning / Stick Shaker Core Stall Protection active.
'    * Nose-Down Dive Limit: -15.0° Max.
'      Cockpit Action: Red Warning / Overspeed Structural Stress protection active.
'
' Usage Workflow:
' -------------
' Initialize:   TileHorizon.Initialize(Me, "Horizon1")
' Update Engine:
'   Dim CombinedTelemetry As String = CurrentPitch & "," & CurrentRoll
'   TileHorizon.SetTile("Horizon", "Pitch:" & CurrentPitch & "° | Roll:" & CurrentRoll & "°", CombinedTelemetry)
' ==============================================================================
#End Region

Sub Class_Globals
	Private xui As XUI

	' Mandatory class globals private
	Private mState						As Boolean
	Private mValue						As String
	Private mParentPanel 				As B4XView		'ignore Local panel holding the webview
	Private mWebView					As WebView		'ignore Local WebView reference handle container
	Private mEventName 					As String		'ignore
	Private mCallBack 					As Object		'ignore

	' Scaling factor: how many pixels the background shifts per 1 degree of pitch
	Private Const PIXELS_PER_DEGREE As Double = 1.5
    
	' --- Mathematical Matrix Coefficients ---
	' Defines the pixel translation offset mapping factor per single degree of pitch
	Private Const PIXELS_PER_DEGREE As Double = 1.5
    
	' --- Hardware Boundary Security Constraints ---
	' Maximum structural vertical limits before the SVG background strips clipping boundaries bleed out
	Public Const PITCH_MAX_LIMIT As Float = 30.0   ' Maximum Climb (+30° Nose Up)
	Public Const PITCH_MIN_LIMIT As Float = -30.0  ' Maximum Dive (-30° Nose Down)
    
	' Angular coordinate circle wrapping boundaries
	Public Const ROLL_MAX_LIMIT As Float = 360.0
	Public Const ROLL_MIN_LIMIT As Float = 0.0
	
	' --- Aviation FWS Alarm Threshold Constants ---
	Public Const FWS_ROLL_CAUTION_DEG As Float = 35.0  ' Soft Alert
	Public Const FWS_ROLL_WARNING_DEG As Float = 45.0  ' Hard Alert
	Public Const FWS_PITCH_CLIMB_LIMIT As Float = 30.0 ' Stall Danger Bound
	Public Const FWS_PITCH_DIVE_LIMIT As Float = -15.0 ' Overspeed Danger Bound

	' Public class vars
	Public PitchDegrees As Float = 0
	Public RollDegrees As Float = 0
End Sub
#End Region

' Initializes the instance
Public Sub Initialize(pnl As B4XView, wv As WebView, evt As String, cb As Object)
	mParentPanel = pnl
	mWebView = wv
	mEventName = evt
	mCallBack = cb
End Sub

' ==============================================================================
' PUBLIC API
' ==============================================================================

' SetTile
' Set all tile properties.
' Parameter:
'   Header - String set text at tile top
'   Footer - String set text at tile bottom
'   Value  - String containing Pitch and Roll separated by a comma (e.g. "5.5,-12.3")
Public Sub SetTile(Header As String, Footer As String, Value As String)
    mValue = Value
            
	' Safe Split and Cast the uniform Value string to extraction floats
	If Value.Contains(",") Then
		Dim parts() As String = Regex.Split(",", Value)
		If IsNumber(parts(0)) Then PitchDegrees = parts(0)
		If IsNumber(parts(1)) Then RollDegrees = parts(1)
	Else
		If IsNumber(Value) Then RollDegrees = Value
	End If
    
	' Enforce structural bounding constraints using our new global public constants
	If PitchDegrees > PITCH_MAX_LIMIT Then PitchDegrees = PITCH_MAX_LIMIT
	If PitchDegrees < PITCH_MIN_LIMIT Then PitchDegrees = PITCH_MIN_LIMIT
    
	' Enforce standard rotation bounding rules (wrap roll inside 0-360)
	RollDegrees = (RollDegrees Mod ROLL_MAX_LIMIT)
	If RollDegrees < ROLL_MIN_LIMIT Then RollDegrees = RollDegrees + ROLL_MAX_LIMIT
    
    ' Calculate the vertical Pitch offset translation shift
    ' Climbing shifts the horizon line DOWNwards on the Y-axis matrix
    Dim pitchShiftY As Double = PitchDegrees * PIXELS_PER_DEGREE
    
    ' Clean text variables to protect string injection safety
    Header = Header.Replace("'", "\'")
    Footer = Footer.Replace("'", "\'")
    
    ' Framework Native DOM Execution Package Block
    Dim js As String = $"
        var head = document.getElementById("tile-header");
        var foot = document.getElementById("tile-footer");
        var pitchGroup = document.getElementById("horizon-pitch-group");
        var gyroGroup = document.getElementById("horizon-gyro-group");
        
        if(head) { head.textContent = "${Header}"; };
        if(foot) { foot.textContent = "${Footer}"; };
        
        if(pitchGroup) {
            pitchGroup.setAttribute("transform", "translate(0, " + ${pitchShiftY} + ")");
        };
        
        if(gyroGroup) {
            var roll = ${RollDegrees};
            gyroGroup.setAttribute("transform", "rotate(" + roll + ", 60, 60)");
        };
    "$
    
    ' Pass the built layout package script straight up to your active WebView container
    UpdateTile(js)
End Sub

' UpdateTile
' Private proxy bridge method required by the HMITilesIO engine pipeline wrapper
' Change the state using JavaScript.
' Parameters:
'	js - JavaScript to update the tile elements.
Private Sub UpdateTile(js As String)
	Wait for (HMITilesIOUtils.ExecuteJS(mWebView, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[HMITilesIOHorizon.UpdateTile][E] Can not update the tile."$)
	End If
End Sub

' GETTER

Public Sub PitchRollDegreesString(Value As String) As String
	Dim pd As Float = 0.0
	Dim rd As Float = 0.0
	
	If Value.Contains(",") Then
		Dim parts() As String = Regex.Split(",", Value)
		If IsNumber(parts(0)) Then
			pd = parts(0)
		End If
		If IsNumber(parts(1)) Then
			rd = parts(1)
		End If
	Else
		' Fallback if only a single number is passed (treat as Roll)
		If IsNumber(Value) Then 
			rd = Value
		End If
	End If
	Return $"Pitch:${pd}° | Roll:${rd}°"$
End Sub

' ProcessTouchHandler
' Process the tile touch event.
' Parameter:
'	Data - Type with all touch properties
Public Sub ProcessTouchHandler(Data As HMITouchData) As HMITouchResult
	' Update internal class state
	mState = Data.State
	mValue = Data.Value

	' Only trigger interactions on the initial touch down event
	If Data.Action = HMITilesIOUtils.ACTION_DOWN Then
		' Trigger the event if it exists in the parent module
		If xui.SubExists(mCallBack, mEventName & "_Click", 1) Then
			CallSubDelayed3(mCallBack, mEventName & "_Click", mState, mValue)
		End If
	End If
    
	' Simplify result creation using standard B4X Type initialization shorthand
	Dim result As HMITouchResult
	result.Initialize
	result.State = mState
	result.Value = mValue
	Return result
End Sub
