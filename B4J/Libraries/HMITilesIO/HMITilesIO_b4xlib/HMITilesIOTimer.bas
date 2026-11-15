B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ================================================================
' File:     	HMITilesIOTimer.bas
' Brief:    	Timer clock and execution tracker.
' Date:			2026-10-28
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
	Private mParentTile 				As HMITilesIO
	
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
Public Sub Initialize(parent As HMITilesIO, pnl As B4XView, wv As WebView, evt As String, cb As Object)
	mParentPanel = pnl
	mWebView = wv
	mEventName = evt
	mCallBack = cb
	mParentTile = parent

	' Clock - disabled per default
	TimerClock.Initialize("TimerClock", TIMERCLOCK_INTERVAL)
	TimerClock.Enabled = False
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
' 	Value - String with currenttime;totaltime
Public Sub SetTile(Header As String, Footer As String, Value As String)
    
	mValue = Value
	
	Dim CleanValue As String = Value.Replace(CRLF, "").Replace(Chr(10), "").Replace(Chr(13), "").Trim
	If CleanValue.Length = 0 Then
		Log($"[IdTimer.SetTile[E] Missing items. Check value."$)
		Return
	End If
    
	Dim DisplayText As String = CleanValue
	Dim ProgressPct As Double = 0
	Dim ShowRing As Boolean = False
    
	CurrentTime = 0
	TotalTime = 0
    
	If CleanValue.Contains(";") Then
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
		ShowRing = False
	End If
    
	If ProgressPct < 0 Then ProgressPct = 0
	If ProgressPct > 100 Then ProgressPct = 100

	' 1. Calculate percentage constraints natively
	Dim circumference As Double = 188.5
	Dim calculatedOffset As Double = circumference - ((ProgressPct / 100) * circumference)
	
	Dim ringColor As String = "#3b82f6" ' Default blue
	If ProgressPct >= 90 Then
		ringColor = "#ef4444"
	Else If ProgressPct >= 75 Then
		ringColor = "#f59e0b"
	End If

	' Determine exact display rules based on Mode status matching your original setup
	Dim displayRule As String = "display: none;"
	If ShowRing Then displayRule = "display: inline;"

	' 2. Formulate target text updates
	Dim textUpdates As Map = CreateMap( _
		"tile-header": Header, _
		"tile-footer": Footer, _
		"tile-value":  DisplayText _
	)
	
	' 3. Map precise presentation attributes safely
	Dim attrUpdates As Map = CreateMap( _
		"tile-value": CreateMap("font-size": "24"), _
		"timer-ring": CreateMap( _
			"style": displayRule, _
			"stroke-dashoffset": NumberFormat2(calculatedOffset, 1, 1, 1, False), _
			"stroke": ringColor _
		) _
	)
	
	' 4. Bundle and send down the safe json utility line
	Dim updatePayload As Map = CreateMap( _
		"text": textUpdates, _
		"attrs": attrUpdates _
	)
	
	HMITilesIOUtils.UpdateElementsViaJSON(mWebView, updatePayload)
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

	' 1. Group the text changes directly mapping your element IDs
	Dim textUpdates As Map = CreateMap( _
		"tile-footer":   footer, _
		"tile-value": value _
	)
	
	' 2. Enforce the font styling property safely
	Dim attrUpdates As Map = CreateMap( _
		"tile-value": CreateMap("font-size": "24") _
	)
	
	' 3. Bundle and push down the safe data pipeline
	Dim updatePayload As Map = CreateMap( _
		"text": textUpdates, _
		"attrs": attrUpdates _
	)
	
	HMITilesIOUtils.UpdateElementsViaJSON(mWebView, updatePayload)
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
