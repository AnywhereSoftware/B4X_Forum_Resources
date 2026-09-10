B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:     	HMITilesIOSparkline.bas
' Brief:    	Show simple trend line.
' Date:			2026-09-06
' Description:	TrendChart: Precise, low-overhead graph tile displaying live trend profiles. Features trend data as sparkline, automatic Min/Max scale labeling and an integrated X/Y reference grid layout designed for compact historical overview.
' Usage:		
'				TileTrendChart.Value = "10;20;30;25;20;0"
'				Add a value as int and redraw the chart
'				TileTrendChart.Value = $"${TileTrendChart.Value};68"$
'				TileTrendChart.Value = $"${TileTrendChart.Value};${value.As(Int)}"$
' ================================================================
#End Region

Private Sub Class_Globals
	Private xui As XUI
	
	' Instance-specific configuration variables (completely isolated for each tile)
	'Public TEXT_COLOR As String = "#0f172a"
	'Public TEXT_SIZE As Int = 24

	Private mState						As Boolean
	Private mValue						As String
	Private mParentPanel 				As B4XView		'ignore Local panel holding the webview
	Private mWebView					As WebView		'ignore Local WebView reference handle container
	Private mEventName 					As String
	Private mCallBack 					As Object
   
    ' Global telemetry tracking metrics
    Public MinValue As Double
    Public MaxValue As Double
    Public FirstValue As Double
    Public LastValue As Double
End Sub

' Initializes the instance
Public Sub Initialize(pnl As B4XView, wv As WebView, evt As String, cb As Object)
	mParentPanel = pnl
	mWebView = wv
	mEventName = evt
	mCallBack = cb
End Sub

' SetTile
' Header - String containing text to display at the top
' Footer - String containing text to display at the bottom
' Value - CSV String with digits separated by ;.
Public Sub SetTile(Header As String, _
                   Footer As String, _
                   Value As String)
    
	' Thoroughly clean out any carriage returns or newlines from the raw incoming value string
	Dim CleanValue As String = Value.Replace(CRLF, "").Replace(Chr(10), "").Replace(Chr(13), "").Trim
    
	Dim items() As String = Regex.Split(";", CleanValue)
	If items.Length = 0 Then 
		Log($"[TrendChart.SetTile[E] Missing items. Check value."$)
		Return
	End If
    
	' Calculate and store the global tracking variables in B4X
	FirstValue = items(0)
	LastValue = items(items.Length - 1)
    
	' Initialize min and max with the first item
	MinValue = FirstValue
	MaxValue = FirstValue
    
	' Loop through the array in B4X to find the true min and max boundaries
	For i = 0 To items.Length - 1
		Dim CurrentVal As Double = items(i)
		If CurrentVal < MinValue Then MinValue = CurrentVal
		If CurrentVal > MaxValue Then MaxValue = CurrentVal
	Next
    
	' Calculate range safety factor to prevent divide-by-zero errors
	Dim Range As Double = MaxValue - MinValue
	If Range = 0 Then Range = 1

	Dim EscapedHeader As String = Header.Replace("'", "\'").Replace("""", "\""")
	Dim EscapedFooter As String = Footer.Replace("'", "\'").Replace("""", "\""")

	' Formulate the streamlined JavaScript (Pre-calculated variables are injected directly)
	' Force standard dot-notation formatting for all B4X Doubles to bypass European comma rules
	Dim JS_Min As String = NumberFormat2(MinValue, 1, 1, 0, False).Replace(",", ".")
	Dim JS_Max As String = NumberFormat2(MaxValue, 1, 1, 0, False).Replace(",", ".")
	Dim JS_Range As String = NumberFormat2(Range, 1, 4, 0, False).Replace(",", ".")
	Dim JS_Last As String = NumberFormat2(LastValue, 1, 1, 0, False).Replace(",", ".")
	
	' Formulate the streamlined JavaScript (Pre-calculated variables are injected directly)
    Dim js As String = $"
        var head = document.getElementById('tile-header');
        var foot = document.getElementById('tile-footer');
        var valTxt = document.getElementById('current-value');
        var poly = document.getElementById('sparkline-path');
        var txtMax = document.getElementById('scale-max');
        var txtMin = document.getElementById('scale-min');

        if (head) { head.textContent = `${EscapedHeader}`; };
        if (foot) { foot.textContent = `${EscapedFooter}`; };
        if (valTxt) { valTxt.textContent = parseFloat(${JS_Last}).toFixed(0); };
        if (poly) {
            var rawData = `${CleanValue}`.split(';').map(Number);
            if (rawData.length > 1) {
                if (txtMax) { txtMax.textContent = parseFloat(${JS_Min}) === parseFloat(${JS_Max}) ? parseFloat(${JS_Max}).toFixed(0) : parseFloat(${JS_Max}).toFixed(0); };
                if (txtMin) { txtMin.textContent = parseFloat(${JS_Min}) === parseFloat(${JS_Max}) ? '0' : parseFloat(${JS_Min}).toFixed(0); };

                var graphWidth = 88;
                var graphHeight = 50;
                var startX = 27;
                var startY = 35;
                
                var pointsArray = [];
                var xStep = graphWidth / (rawData.length - 1);
                
                for (var i = 0; i < rawData.length; i++) {
                    var x = startX + (i * xStep);
                    var y = startY + graphHeight - (((rawData[i] - ${JS_Min}) / ${JS_Range}) * graphHeight);
                    pointsArray.push(x.toFixed(1) + ',' + y.toFixed(1));
                }
                
                poly.setAttribute('points', pointsArray.join(' '));
            } else {
                poly.setAttribute('points', '');
                if (txtMax) { txtMax.textContent = '---'; };
                if (txtMin) { txtMin.textContent = '---'; };
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
	Wait for (HMITilesIOUtils.ExecuteJS(mWebView, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[TrendChart.UpdateTile][E] Can not update the tile."$)
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
