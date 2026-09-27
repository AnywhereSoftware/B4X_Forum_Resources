B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:     	HMITilesIOBattery.bas
' Brief:    	Battery indicator
' Date:			2026-08-29
' Description:	Smart, low-footprint charge level layout displaying a responsive 4-segment vertical vector cell. Automatically transitions through visibility and warning color profiles based on raw 0-100% capacity data blocks.
' Usage:		Show a low level battery with red cell.
'				TileBattery.Value = 10
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
' 	Value - String converted to 0-100 percentage
Public Sub SetTile(Header As String, _
                   Footer As String, _
                   Value As String)
    
	' Clean input parameters safely
	If Not(IsNumber(Value)) Then
		Return
	End If
	Dim BatteryPct As Double = Value.As(Double)
    
	' Ensure boundaries stay within 0-100% constraints
	If BatteryPct < 0 Then BatteryPct = 0
	If BatteryPct > 100 Then BatteryPct = 100

	Dim EscapedHeader As String = Header.Replace("'", "\'").Replace("""", "\""")
	Dim EscapedFooter As String = Footer.Replace("'", "\'").Replace("""", "\""")
	Dim JS_Pct As String = NumberFormat2(BatteryPct, 1, 0, 0, False)

	' Formulate the execution string
	Dim js As String = $"
        var head = document.getElementById('tile-header');
        var foot = document.getElementById('tile-footer');
        var valTxt = document.getElementById('current-value');
        
        var lvl1 = document.getElementById('bat-lvl1');
        var lvl2 = document.getElementById('bat-lvl2');
        var lvl3 = document.getElementById('bat-lvl3');
        var lvl4 = document.getElementById('bat-lvl4');

        if (head) { head.textContent = `${EscapedHeader}`; };
        if (foot) { foot.textContent = `${EscapedFooter}`; };
        if (valTxt) { valTxt.textContent = `${JS_Pct}%`; };

        if (lvl1 && lvl2 && lvl3 && lvl4) {
            var pct = parseInt(`${JS_Pct}`);
            
            var color = '#22c55e'; 
            if (pct <= 20) { color = '#ef4444'; }       
            else if (pct <= 50) { color = '#f59e0b'; }  

            lvl1.setAttribute('fill', pct > 5   ? color : 'none');
            lvl2.setAttribute('fill', pct >= 25 ? color : 'none');
            lvl3.setAttribute('fill', pct >= 50 ? color : 'none');
            lvl4.setAttribute('fill', pct >= 75 ? color : 'none');
        }
    "$

	UpdateTile(js)
End Sub

' UpdateTile
' Change the state using JavaScript.
' Parameters:
'	js - JavaScript to update the tile elements.
Private Sub UpdateTile(js As String)
	Wait for (HMITilesIOUtils.ExecuteJS(mWebView, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[Battery.UpdateTile][E] Can not update the tile."$)
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
