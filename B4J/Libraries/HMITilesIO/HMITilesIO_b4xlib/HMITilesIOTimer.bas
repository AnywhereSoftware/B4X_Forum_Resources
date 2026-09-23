B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:     	HMITilesIOTimer.bas
' Brief:    	Timer clock and execution tracker.
' Date:			2026-09-06
' Description:	A high-visibility clock and execution tracker featuring a centered monospace layout and 
'				a dynamic circular progress ring with integrated multi-state warning colors.
'				To keep things ultra-flexible for different firmware behaviors, this routine will accept a string formatted as 
'				CurrentTime;TotalTime (e.g., 45;120 in seconds or raw percentages like 25;100), or 
'				simply a plain time string (e.g., 01:23:45) if no progress ring is needed.
' Usage:		Set the timer to start at 45 seconds and run till 120 seconds
'				TileTimer.Value = "45;120"
'				Start the clock
'				TileTimerClock.InstanceTimer.StartClock
' 				Important: TimerClock - must be started after sleep(1)
' ================================================================
#End Region

Private Sub Class_Globals
	Private xui As XUI
	
	' Instance-specific configuration variables (completely isolated for each tile)
	'Public TEXT_COLOR As String = "#0f172a"
	'Public TEXT_SIZE As Int = 24

	' Class locals mandatory for every tile
	Private mState						As Boolean
	Private mValue						As String
	Private mParentPanel 				As B4XView		'ignore Local panel holding the webview
	Private mWebView					As WebView		'ignore Local WebView reference handle container
	Private mEventName 					As String
	Private mCallBack 					As Object
	
	' Class locals specific
	' Global Timer tracking metrics (Exposed for applications)
	Public CurrentTime As Long
	Public TotalTime As Long
	
	' Clock Mode
	' Using standard European date layout format > Change to "yyyy-MM-dd" if preferred
	Private DATE_FORMAT As String = "dd.MM.yyyy"
	' Timer for the clock every second
	Private TimerClock As Timer
	Private TIMERCLOCK_INTERVAL As Long = 1000
End Sub

' Initializes the instance
Public Sub Initialize(pnl As B4XView, wv As WebView, evt As String, cb As Object)
	mParentPanel = pnl
	mWebView = wv
	mEventName = evt
	mCallBack = cb

	' Clock - disabled per default
	TimerClock.Initialize("TimerClock", TIMERCLOCK_INTERVAL)
	TimerClock.Enabled = False
End Sub

' SetTile
' Set all tile properties.
' Parameter:
'	Header - String set text at tile top
'	Footer - String set text at tile bottom
' 	Value - String with currenttime;totaltime
Public Sub SetTile(Header As String, _
                   Footer As String, _
                   Value As String)
    
	Dim CleanValue As String = Value.Replace(CRLF, "").Replace(Chr(10), "").Replace(Chr(13), "").Trim
	' Check value
	If CleanValue.Length = 0 Then
		Log($"[IOTimer.SetTile[E] Missing items. Check value."$)
		Return
	End If
    
	Dim DisplayText As String = CleanValue
	Dim ProgressPct As Double = 0
	Dim ShowRing As Boolean = False
    
	CurrentTime = 0
	TotalTime = 0
    
	If CleanValue.Contains(";") Then
		' Mode 1: Timer Profile (e.g., "45;60" or "0;300") -> Circle is Visible
		ShowRing = True
		Dim Parts() As String = Regex.Split(";", CleanValue)
		If Parts.Length >= 2 Then
			Try
				CurrentTime = Parts(0)
				TotalTime = Parts(1)
			Catch
				Log("[HMITilesIO.Timer] Error parsing numbers: " & CleanValue)
			End Try
            
			If TotalTime > 0 Then
				ProgressPct = (CurrentTime / TotalTime) * 100
			End If
            
			' Format long raw seconds into standard visual clock format if applicable
			If CurrentTime < 86400 And TotalTime > 120 Then
				Dim Hours As Int = CurrentTime / 3600
				Dim Minutes As Int = (CurrentTime Mod 3600) / 60
				Dim Seconds As Int = CurrentTime Mod 60
				DisplayText = NumberFormat(Hours, 2, 0) & ":" & NumberFormat(Minutes, 2, 0) & ":" & NumberFormat(Seconds, 2, 0)
			Else
				DisplayText = Parts(0)
			End If
		End If
	Else
		' Mode 2: Time Readout Only (e.g., "12:01:22") -> Circle is HIdden
		ShowRing = False
	End If
    
	If ProgressPct < 0 Then ProgressPct = 0
	If ProgressPct > 100 Then ProgressPct = 100

	Dim EscapedHeader As String = Header.Replace("'", "\'").Replace("""", "\""")
	Dim EscapedFooter As String = Footer.Replace("'", "\'").Replace("""", "\""")
	Dim JS_Pct As String = NumberFormat2(ProgressPct, 1, 1, 0, False).Replace(",", ".")
	Dim JS_ShowRing As String = "none"
	If ShowRing Then JS_ShowRing = "inline"

	' Strictly removed all // comments to prevent single-line flattening crashes
	Dim js As String = $"
        var head = document.getElementById('tile-header');
        var foot = document.getElementById('tile-footer');
        var valTxt = document.getElementById('current-value');
        var ring = document.getElementById('timer-ring');
        var track = ring ? ring.previousElementSibling : null;

        if (head) { head.textContent = `${EscapedHeader}`; };
        if (foot) { foot.textContent = `${EscapedFooter}`; };
        if (valTxt) { 
            valTxt.textContent = `${DisplayText}`; 
            if (`${DisplayText}`.length > 3) {
                valTxt.setAttribute('font-size', '24'); 
            } else {
                valTxt.setAttribute('font-size', '24'); 
            }
        };

        if (ring) {
            ring.style.display = `${JS_ShowRing}`;
            if (track) { track.style.display = `${JS_ShowRing}`; }
            
            var pct = parseFloat(`${JS_Pct}`); 
            var circumference = 188.5; 
            var offset = circumference - ((pct / 100) * circumference);
            
            ring.setAttribute('stroke-dashoffset', offset.toFixed(1));
            
            if (pct >= 90) {
                ring.setAttribute('stroke', '#ef4444');
            } else if (pct >= 75) {
                ring.setAttribute('stroke', '#f59e0b');
            } else {
                ring.setAttribute('stroke', '#3b82f6');
            }
        }
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
		Log($"[Timer.UpdateTile][E] Can not update the tile."$)
	End If
End Sub

Public Sub GetTime As String
	Return DateTime.Time(DateTime.Now)
End Sub

Public Sub GetDate As String
	DateTime.DateFormat = DATE_FORMAT
	Return DateTime.Date(DateTime.Now)
End Sub

#Region TimerClock
Public Sub StartClock
	TimerClock.Enabled = True
End Sub

Public Sub StopClock
	TimerClock.Enabled = False
End Sub

Private Sub TimerClock_Tick
	Dim value As String = GetTime
	Dim footer As String = GetDate

	Dim js As String = $"
        var foot = document.getElementById('tile-footer');
        var currentvalue = document.getElementById('current-value');

        if (foot) { foot.textContent = `${footer}`; };
        if (currentvalue) { 
            currentvalue.textContent = `${value}`; 
            currentvalue.setAttribute('font-size', '24'); 
        };
    "$
	
	UpdateClock(js)
End Sub

' UpdateTile
' Change the state using JavaScript.
' Parameters:
'	js - JavaScript to update the tile elements.
Private Sub UpdateClock(js As String)
	Wait for (HMITilesIOUtils.ExecuteJS(mWebView, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[Timer.UpdateClock][E] Can not update the tile."$)
	End If
End Sub

#End Region	

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
