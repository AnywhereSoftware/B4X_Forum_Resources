B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ================================================================
' File:         HMITilesIOLoadingIndicator.bas
' Brief:        LoadingIndicator to visualize long-running processes or polling states.
' Date:         2026-10-28
' Description:  An industrial dashboard indicator designed around an SVG vector asset. 
'               Features a high-performance CSS-animated rotating blue arc for active processes,
'               and morphs into a static, neutral full circle upon task completion.
' Usage:        
'               TileLoading.Start("DATA SYNC", "Fetching registers...")
'               TileLoading.Stop("DATA SYNC", "COMPLETE", True)
' ================================================================

Private Sub Class_Globals
	Private xui As XUI
	
	' Instance-specific configuration variables
	Private mState                      As Boolean
	Private mValue                      As String
	Private mParentPanel                As B4XView      'ignore Local panel holding the webview
	Private mWebView                    As WebView      'ignore Local WebView reference handle container
	Private mEventName                  As String
	Private mCallBack                   As Object
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
' Header - String set text at tile top
' Footer - String set text at tile bottom
' State - Boolean true to show loading else false
Public Sub SetTile(Header As String, Footer As String, State As Boolean)
	mState = State
	
	If State Then
		Start(Header, Footer)
	Else
		Stop(Header, Footer, False)
	End If
End Sub

' Start
Public Sub Start(Header As String, Footer As String)
	UpdateTile(Header, Footer, "is-loading", "visible")
End Sub

' Stop
Public Sub Stop(Header As String, Footer As String, HideTileAfterwards As Boolean)
	If HideTileAfterwards Then
		' Freeze the circle first
		UpdateTile(Header, Footer, "is-stopped", "visible")
		' Plain synchronous block pause. Because it's followed by a direct command,
		' it acts as a clean delay before execution moves to the next line.
		Sleep(800)
		UpdateTile(Header, Footer, "is-stopped", "hidden")
	Else
		UpdateTile(Header, Footer, "is-stopped", "visible")
	End If
End Sub

' Reset
Public Sub Reset
	UpdateTile("", "", "is-stopped", "visible")
End Sub

' --- Simple Synchronous UI Updater ---
Private Sub UpdateTile(Header As String, Footer As String, StateClass As String, ObjectVisibility As String)
	Dim textUpdates As Map = CreateMap( _
		"tile-header": Header, _
		"tile-footer": Footer _
	)
	
	Dim attrUpdates As Map = CreateMap( _
		"stateContainer": CreateMap("class": StateClass), _
		"tile-value":     CreateMap("style": "visibility: " & ObjectVisibility & ";"), _
		"tile-loadingindicator": CreateMap("style": "visibility: " & ObjectVisibility & ";") _
	)
	
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
	mState = Data.State
	mValue = Data.Value

	If Data.Action = HMITilesIOUtils.ACTION_DOWN Then
		If xui.SubExists(mCallBack, mEventName & "_Click", 1) Then
			CallSubDelayed3(mCallBack, mEventName & "_Click", mState, mValue)
		End If
	End If
    
	Dim result As HMITouchResult
	result.Initialize
	result.State = mState
	result.Value = mValue
	Return result
End Sub
