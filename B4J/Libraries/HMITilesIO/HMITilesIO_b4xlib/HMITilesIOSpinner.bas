B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:     	HMITilesIOSpinner.bas
' Brief:    	Spinner with + and - buttons to set a value.
' Date:			2026-08-29
' Description:	High-precision directional increment control featuring clear high-contrast tactile action touch targets for exact setpoint calibration.
' Usage:		
'				TileSpinner.Value = 99
'				TileSpinner.ValueFontSize = 24
' ================================================================
#End Region

Private Sub Class_Globals
	Private xui As XUI
	
	' Instance-specific configuration variables (completely isolated for each tile)
	Public TEXT_COLOR As String = "#0f172a"
	Public TEXT_SIZE As Int = 24
	Public PinsAttached() As Byte = Array As Byte (1,1,1,1,1,1,1,1)

	Private mState						As Boolean
	Private mValue						As String
	Private mParentPanel 				As B4XView		'ignore Local panel holding the webview
	Private mWebView					As WebView		'ignore Local WebView reference handle container
	Private mEventName 					As String
	Private mCallBack 					As Object

	Private mMinValue					As Float
	Private mMaxValue					As Float
End Sub

' Initializes the instance
Public Sub Initialize(pnl As B4XView, wv As WebView, evt As String, cb As Object)
	mParentPanel = pnl
	mWebView = wv
	mEventName = evt
	mCallBack = cb
End Sub

Public Sub setMinValue(value As Float)
	mMinValue = value
End Sub
Public Sub getMinValue As Float
	Return mMinValue
End Sub

Public Sub setMaxValue(value As Float)
	mMaxValue = value
End Sub
Public Sub getMaxValue As Float
	Return mMaxValue
End Sub

' SetTile
' Set all tile properties.
' Parameter:
'	Header - String set text at tile top
'	Footer - String set text at tile bottom
' 	MinValue / MaxValue - Float for calibration floor and ceiling limits
' 	Value - Float current value
Public Sub SetTile(Header As String, _
				   Footer As String, _
                   MinValue As Float, _
				   MaxValue As Float, _
				   Value As String) As String

	' Guard input values inside safety boundaries
	Value = Max(MinValue, Min(MaxValue, Value.As(Float)))

	' Formulate a safe, compact single-line DOM manipulator execution string
	Dim js As String = $"
		var head = document.getElementById("tile-header");
		var foot = document.getElementById("tile-footer");
		var txt = document.getElementById("value-display");

		if(head) { 
			head.textContent = "${Header}"; 
		};
		
		if(foot) { 
			foot.textContent = "${Footer}"; 
		};

		if (txt) {
			txt.textContent = "${Value}";
			txt.setAttribute("font-size", "${TEXT_SIZE}");
			txt.setAttribute("fill", "${TEXT_COLOR}");
		}
	"$
	Return js
End Sub

Private Sub UpdateValue(Value As String)
	Dim js As String = $"
		var txt = document.getElementById("value-display");
		if(txt) {
			txt.textContent = "${Value}";
			txt.setAttribute("font-size", "${TEXT_SIZE}");
			txt.setAttribute("fill", "${TEXT_COLOR}");
		}
	"$

	Wait for (HMITilesIOUtils.ExecuteJS(mWebView, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[Spinner.UpdateValue][E] Can not update value"$)
	End If
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
	
		Dim PanelWidth As Float = mParentPanel.Width
	
		' Translate the physical screen pixel touch point into your 120-unit SVG matrix space
		Dim svgTouchX As Float = (Data.X / PanelWidth) * 120
	                
		Dim ValueChanged As Boolean = False
	                
		' Check boundary conditions based on exact 120-unit canvas sizing layout
		If svgTouchX <= 40 Then
			' MINUS REGION CLICKED
			mValue = mValue - 1
			ValueChanged = True
		Else If svgTouchX >= 80 Then
			' PLUS REGION CLICKED
			mValue = mValue + 1
			ValueChanged = True
		End If

		' Set the new value
		If ValueChanged Then

			' Safeguard min/max
			mValue = Max(mMinValue, Min(mMaxValue, mValue.As(Float)))

			' Get and Update the value - the state does not change
			UpdateValue(mValue)

			' Callback
			If xui.SubExists(mCallBack, mEventName & "_Click", 1) Then
				CallSubDelayed3(mCallBack, mEventName & "_Click", mState, mValue)
			End If
		End If
	
	End If
    
	' Simplify result creation using standard B4X Type initialization shorthand
	Dim result As HMITouchResult
	result.Initialize
	result.State = mState
	result.Value = mValue
	' Log($"[Spinner.ProcessTouchHandler] state=${result.State} value=${result.Value}"$)
	Return result
End Sub

