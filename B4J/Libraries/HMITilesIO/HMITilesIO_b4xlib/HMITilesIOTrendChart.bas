B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ================================================================
' File:     	HMITilesIOTrendChart.bas
' Brief:    	Show simple trend line.
' Date:			2026-10-28
' Description:	TrendChart: Precise, low-overhead graph tile displaying live trend profiles. Features trend data as sparkline, automatic Min/Max scale labeling and an integrated X/Y reference grid layout designed for compact historical overview.
' Usage:		
'				TileTrendChart.Value = "10;20;30;25;20;0"
'				Add a value as int and redraw the chart
'				TileTrendChart.Value = $"${TileTrendChart.Value};68"$
'				TileTrendChart.Value = $"${TileTrendChart.Value};${value.As(Int)}"$
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
   
    ' Global telemetry tracking metrics
    Public MinValue As Double
    Public MaxValue As Double
    Public FirstValue As Double
	Public LastValue As Double
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
' Header - String containing text to display at the top
' Footer - String containing text to display at the bottom
' Value - CSV String with digits separated by ;.
Public Sub SetTile(Header As String, Footer As String, Value As String)
    
	' Thoroughly clean out any carriage returns or newlines from the raw incoming value string
	Dim CleanValue As String = Value.Replace(CRLF, "").Replace(Chr(10), "").Replace(Chr(13), "").Trim
	mValue = CleanValue
    
	If CleanValue.Length = 0 Then Return
	
	Dim items() As String = Regex.Split(";", CleanValue)
	If items.Length = 0 Then
		Log($"[TrendChart.SetTile[E] Missing items. Check value."$)
		Return
	End If
    
	' Calculate and store the global tracking variables in B4X
	FirstValue = items(0).As(Double)
	LastValue = items(items.Length - 1).As(Double)
    
	' Initialize min and max with the first item
	MinValue = FirstValue
	MaxValue = FirstValue
    
	' Loop through the array in B4X to find the true min and max boundaries
	For i = 0 To items.Length - 1
		Dim CurrentVal As Double = items(i).As(Double)
		If CurrentVal < MinValue Then MinValue = CurrentVal
		If CurrentVal > MaxValue Then MaxValue = CurrentVal
	Next
    
	' Calculate range safety factor to prevent divide-by-zero errors
	Dim Range As Double = MaxValue - MinValue
	If Range = 0 Then Range = 1

	' 1. Group core structural text readouts
	Dim textUpdates As Map = CreateMap( _
		"tile-header": Header, _
		"tile-footer": Footer, _
		"tile-value":  NumberFormat(LastValue, 1, 0) _
	)
	
	Dim attrUpdates As Map
	attrUpdates.Initialize

	' 2. Pure B4X Geometric Math Engine (Calculates SVG Polyline Points natively)
	If items.Length > 1 Then
		' Format scale min/max labels safely
		Dim maxLabel As String = NumberFormat(MaxValue, 1, 0)
		Dim minLabel As String = IIf(MinValue = MaxValue, "0", NumberFormat(MinValue, 1, 0))
		
		textUpdates.Put("scale-max", maxLabel)
		textUpdates.Put("scale-min", minLabel)

		' Viewport scaling dimensions from your exact vector layout constraints
		Dim graphWidth As Double = 88
		Dim graphHeight As Double = 50
		Dim startX As Double = 27
		Dim startY As Double = 35
                
		Dim sbPoints As StringBuilder
		sbPoints.Initialize
		Dim xStep As Double = graphWidth / (items.Length - 1)
                
		For i = 0 To items.Length - 1
			Dim rawVal As Double = items(i).As(Double)
			Dim vx As Double = startX + (i * xStep)
			Dim vy As Double = startY + graphHeight - (((rawVal - MinValue) / Range) * graphHeight)
			
			If i > 0 Then sbPoints.Append(" ")
			sbPoints.Append(NumberFormat2(vx, 1, 1, 1, False))
			sbPoints.Append(",")
			sbPoints.Append(NumberFormat2(vy, 1, 1, 1, False))
		Next
		
		' Set calculated geometric coordinates directly to the SVG polyline array
		attrUpdates.Put("sparkline-path", CreateMap("points": sbPoints.ToString))
	Else
		' Reset states gracefully on empty or single-point updates
		attrUpdates.Put("sparkline-path", CreateMap("points": ""))
		textUpdates.Put("scale-max", "---")
		textUpdates.Put("scale-min", "---")
	End If
	
	' 3. Bundle everything up and push to your central utility engine
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
