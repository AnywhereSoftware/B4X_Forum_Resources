B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ================================================================
' File:     	HMITilesIOSelector.bas
' Brief:    	Selector with rolling selection using touch.
' Date:			2026-10-28
' Description:	Readout style value.
' Usage:		
'				Private TileSelector As HMITilesIO
'				TileSelector.Items = Array As String("A","B","C")
'				TileSelector.Value = TileSelector.Items.Get(0)
'				Use TileSelector.Value to get the cuirrent value.
' ================================================================

Private Sub Class_Globals
	Private xui As XUI
	
	Private mItems As List
	Private mSelectedIndex As Int = -1
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
	mItems.Initialize
End Sub

' GetParent
' Get the parent tile HMITilesIO to access public methods & fields.
Public Sub GetParent As HMITilesIO
	Return mParentTile
End Sub

' Configures the selection data list from a clean CSV input string
' Returns True if item array parsing succeeds
Public Sub SetItems(items As List) As Boolean
	mItems.Clear
	mItems = items
	If mItems.Size > 0 Then
		mSelectedIndex = 0
		Return True
	Else
		mSelectedIndex = -1
		Return False
	End If
End Sub

' Reads the active item string context value
Public Sub GetCurrentValue As String
	If mSelectedIndex >= 0 And mSelectedIndex < mItems.Size Then
		Return mItems.Get(mSelectedIndex)
	End If
	Return ""
End Sub

' Calculates the next round-robin loop index pointer location
Public Sub GetNextValue As String
	If mItems.Size = 0 Then Return ""
	
	mSelectedIndex = mSelectedIndex + 1
	If mSelectedIndex > mItems.Size - 1 Then
		mSelectedIndex = 0
	End If
	
	Return mItems.Get(mSelectedIndex)
End Sub

' Generates the real-time index count layout for the footer element (e.g. "1 of 4")
Public Sub GetCounterFooter As String
	If mItems.Size > 0 Then
		Return $"${mSelectedIndex + 1} of ${mItems.Size}"$
	Else
		Return ""
	End If
End Sub

' SetTile
' Set all tile properties.
' Parameter:
'	Header - String set text at tile top
'	Footer - String set text at tile bottom
' 	Value - String current value (can be number or text)
Public Sub SetTile(Header As String, Footer As String, Value As String)
	mValue = Value
	
	' Map the structural element IDs directly to their intended text strings
	Dim textUpdates As Map = CreateMap( _
		"tile-header": Header, _
		"tile-footer": Footer, _
		"tile-value": Value _
	)
	
	' Bundle into the payload layout expected by the universal handler
	Dim updatePayload As Map = CreateMap("text": textUpdates)
	
	' Send directly to your central utility engine
	HMITilesIOUtils.UpdateElementsViaJSON(mWebView, updatePayload)

	UpdateValue(Value)
End Sub

Private Sub UpdateValue(Value As String)
	' Map the text swap target directly
	Dim textUpdates As Map = CreateMap("tile-value": Value)
	
	' 3. Bundle and push out down the data pipeline
	Dim updatePayload As Map = CreateMap( _
		"text": textUpdates)
	
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
		' Get and Update the value - the state does not change
		mValue = GetNextValue
		UpdateValue(mValue)

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
