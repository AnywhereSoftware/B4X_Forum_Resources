B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ================================================================
' File:     	HMITilesIOSwitch.bas
' Brief:    	Switch with state ON (True, Green) and OFF (False, Red).
' Date:			2026-10-28
' Description:	The Rocker Switch with crisp, tactile 3D effect with clear status symbols.
' Usage:		
'				TileSwitch.State = False - set state OFF, Red
'				TileSwitch.State = True - set state ON, Green
' ================================================================

Private Sub Class_Globals
	Private xui As XUI
	
	Private mState						As Boolean
	Private mValue						As String
	Private mParentPanel 				As B4XView		'ignore Local panel holding the webview
	Private mWebView					As WebView		'ignore Local WebView reference handle container
	Private mEventName 					As String
	Private mCallBack 					As Object
	Private mParentTile 				As HMITilesIO
End Sub

' Initializes the instance
Public Sub Initialize(parent As HMITilesIO, pnl As B4XView, wv As WebView, evt As String, cb As Object)
	mParentPanel = pnl
	mWebView = wv
	mEventName = evt
	mCallBack = cb
	mParentTile = parent
End Sub

' GetParent
' Get the parent tile HMITilesIO to access public methods & fields.
Public Sub GetParent As HMITilesIO
	Return mParentTile
End Sub

' SetTile
' Set all tile properties.
' Parameter:
'	Header - String set text at tile top
'	Footer - String set text at tile bottom
'	State - Boolean True (ON, Green) or False (OFF, Red)
Public Sub SetTile(Header As String, Footer As String, State As Boolean)

	mState = State

	' 1. Group standard text content updates directly
	Dim textUpdates As Map = CreateMap( _
		"tile-header": Header, _
		"tile-footer": Footer _
	)
	
	' 2. Calculate State-dependent variables upfront inside B4X using inline If expressions
	' --- Top Segment (ON State Options / OFF State Options) ---
	Dim topFill As String     = IIf(State, "url(#greenGlow)", "#450a0a")
	Dim topStroke As String   = IIf(State, "#86efac", "#1e0202")
	Dim topHeight As String   = IIf(State, "29", "26")
	Dim topSymStroke As String = IIf(State, "#ffffff", "#991b1b")
	Dim topSymFilter As String = IIf(State, "url(#neonGlow)", "") ' Empty string clears attribute
	
	' --- Bottom Segment (ON State Options / OFF State Options) ---
	Dim botFill As String     = IIf(State, "#14532d", "url(#redGlow)")
	Dim botStroke As String   = IIf(State, "#052e16", "#fca5a5")
	Dim botY As String        = IIf(State, "62", "60")
	Dim botHeight As String   = IIf(State, "25", "27")
	Dim botSymStroke As String = IIf(State, "#166534", "#ffffff")
	Dim botSymFilter As String = IIf(State, "", "url(#neonGlow)")

	' 3. Map all visual presentation attributes to their target element IDs cleanly
	Dim attrUpdates As Map = CreateMap( _
		"rocker-top": CreateMap( _
			"fill": topFill, _
			"stroke": topStroke, _
			"height": topHeight _
		), _
		"rocker-symbol-i": CreateMap( _
			"stroke": topSymStroke, _
			"filter": topSymFilter _
		), _
		"rocker-bottom": CreateMap( _
			"fill": botFill, _
			"stroke": botStroke, _
			"y": botY, _
			"height": botHeight _
		), _
		"rocker-symbol-o": CreateMap( _
			"stroke": botSymStroke, _
			"filter": botSymFilter _
		) _
	)
	
	' 4. Bundle everything up and push to your central utility engine
	Dim updatePayload As Map = CreateMap( _
		"text": textUpdates, _
		"attrs": attrUpdates _
	)
	
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
