B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:     	HMITilesIODualReadOut.bas
' Brief:    	Display 2 values with units.
' Date:			2026-09-06
' Description:	Crisp telemetry display that outputs two dynamic process numbers or 
'				operational status string values (e.g., "23.5 °C", "1013 hPa", "RUNNING").
'				The value contains a string with ; as seperator for 4 items:
'				value-left;unit-left;value-right;unit-right
' Usage:		
'				Display 2 values 123 C and 456 %:
'				TileDualReadOut.Value = "123;C;456;%"
' ================================================================
#End Region

Private Sub Class_Globals
	Private xui As XUI
	
	' Instance-specific configuration variables (completely isolated for each tile)
	Public TEXT_COLOR As String = "#0f172a"
	Public TEXT_SIZE As Int = 24

	Private mState						As Boolean
	Private mValue						As String
	Private mParentPanel 				As B4XView		'ignore Local panel holding the webview
	Private mWebView					As WebView		'ignore Local WebView reference handle container
	Private mEventName 					As String
	Private mCallBack 					As Object

	' Tile specific
	Private mValueLeft					As String
	Private mValueRight					As String
	Private mUnitLeft					As String
	Private mUnitRight					As String

End Sub

' Initializes the instance
Public Sub Initialize(pnl As B4XView, wv As WebView, evt As String, cb As Object)
	mParentPanel = pnl
	mWebView = wv
	mEventName = evt
	mCallBack = cb
End Sub

' SetTile
' Set all tile properties.
' Parameter:
'	Header - String set text at tile top
'	Footer - String set text at tile bottom
' 	Value - String with 4 items separated by ;, i.e. 23;C;68;% for temperature with unit C and humidity with unit %
Public Sub SetTile(Header As String, _
				   Footer As String, _
				   Value As String)

	Dim items() As String = Regex.Split(";", Value)
	If items.Length <> 4 Then
		Log($"[DualReadOut.SetTile][E] Value "${Value}" wrong number of items. Expect 4, got ${items.Length}"$)
		Return
	End If
	' Log($"[HMITIlesIODual.SetTile] value=${Value}, items=${items.Length}"$)

	mValueLeft	= items(0)
	mUnitLeft	= items(1)
	mValueRight	= items(2)
	mUnitRight	= items(3)
	' Log($"[HMITIlesIODual.SetTile] ${mValueLeft}, ${mUnitLeft}, ${mValueRight}, ${mUnitRight}"$)

	' Formulate a safe, compact single-line DOM manipulator execution string
	Dim js As String = $"
		var head = document.getElementById("tile-header");
		var foot = document.getElementById("tile-footer");
		var valueleft = document.getElementById("value-left");
		var unitleft = document.getElementById("unit-left");
		var valueright = document.getElementById("value-right");
		var unitright = document.getElementById("unit-right");

		if(head) { head.textContent = "${Header}"; };
		if(foot) { foot.textContent = "${Footer}"; };


		if(valueleft) { valueleft.textContent = "${mValueLeft}"; };
		if(unitleft) { unitleft.textContent = "${mUnitLeft}"; };
		if(valueright) { valueright.textContent = "${mValueRight}"; };
		if(unitright) { unitright.textContent = "${mUnitRight}"; }
	"$
	UpdateTile(js)
End Sub

' UpdateTile
' Change the state using JavaScript.
' Parameters:
'	js - JavaScript to update the tile elements.
Private Sub UpdateTile(js As String)
	Sleep(50)
	Wait for (HMITilesIOUtils.ExecuteJS(mWebView, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[DualReadOut.UpdateTile][E] Can not update the tile."$)
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
