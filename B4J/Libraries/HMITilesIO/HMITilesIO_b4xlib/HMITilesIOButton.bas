B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ================================================================
' File:     	HMITilesIOButton.bas
' Brief:    	Push button with state ON (Green) or OFF (Red).
' Date:			2026-10-28
' Description:	Deep, polished status lens with a realistic glare overlay.
' Usage:		Set state ON:
'				TileLEDPanel.State = True
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
' 	State - Boolean True (ON, Green) or False (OFF, Red)
Public Sub SetTile(Header As String, Footer As String, State As Boolean)
	mState = State
	
	' Formulate standard text content mappings
	Dim textUpdates As Map = CreateMap( _
		"tile-header": Header, _
		"tile-footer": Footer _
	)
	
	' Determine state-dependent lens properties using B4X inline If expressions
	Dim lensFill As String = IIf(State, "url(#ledGreen)", "url(#ledOff)")
	Dim lensFilter As String = IIf(State, "url(#lensGlow)", "") ' An empty string safely resets/clears the SVG filter effect
	
	' Map DOM element attributes cleanly
	' "tile-footer": CreateMap("fill": "#64748b"), _
	Dim attrUpdates As Map = CreateMap( _
		"led-lens": CreateMap("fill": lensFill, "filter": lensFilter) _
	)
	
	' Bundle everything up and push to your central utility engine
	Dim updatePayload As Map = CreateMap( _
		"text": textUpdates, _
		"attrs": attrUpdates _
	)
	
	' Log($"[HMITilesIOButton.SetTile] state=${State}, > ${updatePayload}"$)
	' [HMITilesIOButton.SetTile] state=true, > {text={tile-header=BUTTON, tile-footer=Footer}, attrs={tile-footer={fill=#64748b}, led-lens={fill=url(#ledGreen), filter=url(#lensGlow)}}}
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
