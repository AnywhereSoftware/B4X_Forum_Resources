B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ================================================================
' File:     	HMITilesIOSpinner.bas
' Brief:    	Spinner with + and - buttons to set a value.
' Date:			2026-10-28
' Description:	High-precision directional increment control featuring clear high-contrast tactile action touch targets for exact setpoint calibration.
' Usage:		
'				TileSpinner.Value = 99
'				TileSpinner.ValueFontSize = 24
' ================================================================

Private Sub Class_Globals
	Private xui As XUI
	
	' Instance-specific configuration variables (completely isolated for each tile)
	Public PinsAttached() 	As Byte = Array As Byte (1,1,1,1,1,1,1,1)

	Private mState			As Boolean
	Private mValue			As String
	Private mParentPanel	As B4XView		'ignore Local panel holding the webview
	Private mWebView		As WebView		'ignore Local WebView reference handle container
	Private mEventName 		As String
	Private mCallBack 		As Object
	Private mParentTile 	As HMITilesIO  

	Private mMinValue		As Float
	Private mMaxValue		As Float
	Private mStepSize		As Int
End Sub

' Initializes the instance
Public Sub Initialize(parent As HMITilesIO, pnl As B4XView, wv As WebView, evt As String, cb As Object)
	mParentPanel = pnl
	mWebView = wv
	mEventName = evt
	mCallBack = cb

	mParentTile = parent	
	mStepSize = 1
End Sub

' GetParent
' Get the parent tile HMITilesIO to access public methods & fields.
Public Sub GetParent As HMITilesIO
	Return mParentTile
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

Public Sub setStepSize(value As Int)
	If mStepSize < 1 Then mStepSize = 1
	mStepSize = value
End Sub
Public Sub getStepSize As Int
	Return mStepSize
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
				   Value As String)

	' Guard input values inside safety boundaries
	Dim GuardedValue As Float = Max(MinValue, Min(MaxValue, Value.As(Float)))
	
	mValue = GuardedValue

	' Map the structural element IDs directly to their intended text strings
	Dim textUpdates As Map = CreateMap( _
		"tile-header": Header, _
		"tile-footer": Footer, _
		"tile-value": Value _
	)
	
	' Bundle into the payload layout expected by the universal handler
	Dim updatePayload As Map = CreateMap("text": textUpdates)

	HMITilesIOUtils.UpdateElementsViaJSON(mWebView, updatePayload)
End Sub

Private Sub UpdateValue(Value As String)
	' Direct text target swap map
	Dim textUpdates As Map = CreateMap("tile-value": Value)
	
	' Bundle and push down the safe data pipeline
	Dim updatePayload As Map = CreateMap("text": textUpdates)
	
	HMITilesIOUtils.UpdateElementsViaJSON(mWebView, updatePayload)
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
			mValue = mValue - mStepSize
			ValueChanged = True
		Else If svgTouchX >= 80 Then
			' PLUS REGION CLICKED
			mValue = mValue + mStepSize
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

