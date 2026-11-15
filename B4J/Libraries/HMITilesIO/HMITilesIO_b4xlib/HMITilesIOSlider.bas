B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' ================================================================
' File:     	HMITilesIOSlider.bas
' Brief:    	Horizontal slider with default range 0-100.
' Date:			2026-10-28
' Description:	Symmetrical control groove rail with flawless cursor mapping.
' Usage:		
'				TileSlider.Value = 68
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

	Private mMinValue					As Float
	Private mMaxValue					As Float
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

Public Sub setMinValue(value As Float)
	mMinValue = value
End Sub
Public Sub getMinValue As Float
	Return mMinValue
End Sub

Public Sub setMaxValue(value As Float)
	mMaxValue = value
End Sub
Public Sub getMaxValue As Float
	Return mMaxValue
End Sub

#If B4J
' Init
' Initializes the core mouse and touch interaction layer for B4J JavaFX containers
Public Sub Init(showmovement As Boolean)
	Dim movement As String = ""
	If showmovement Then
		movement = "window.location.href = 'http://slider?val=' + finalValue;"
	End If
	
	' We preserve the interactive touch tracking engine natively in JS,
	' but remove backticks and use single quotes to guarantee string stability.
	Dim js As String = $"
        (function() {
            var zone = document.getElementById("hmi-touch-zone");
            var handle = document.getElementById("hmi-handle");
            var prog = document.getElementById("hmi-progress");
            var value = document.getElementById("tile-value");
			var val = 0;
            
            if (zone && handle && prog) {
                var isDragging = false;
                
                function processMovement(e) {
                    var clientX = e.clientX;
                    if (e.touches && e.touches.length > 0) {
                        clientX = e.touches[0].clientX;
                    };
                    
                    var rect = zone.getBoundingClientRect();
                    if (!rect || rect.width === 0) {
                        return;
                    };
                    
                    var touchX = ((clientX - rect.left) / rect.width) * 120;
                    
                    if (touchX < 20) { touchX = 20; };
                    if (touchX > 100) { touchX = 100; };
                    
                    var pct = (touchX - 20) / 80;
                    var finalValue = Math.round(pct * 100);
					val = finalValue;
					
                    handle.setAttribute("x", (touchX - 5).toString());
                    prog.setAttribute("x2", touchX.toString());
                    if (value) { value.textContent = finalValue; };

					${movement}
                };

                zone.addEventListener("mousedown", function(e) {
                    isDragging = true;
                    processMovement(e);
                });

                window.addEventListener("mousemove", function(e) {
                    if (isDragging) { processMovement(e); };
                });

                window.addEventListener("mouseup", function() {
                    isDragging = false;
                    window.location.href = "http://slider?val=" + val;
                });

                zone.addEventListener("touchstart", function(e) {
                    isDragging = true;
                    processMovement(e);
                    e.preventDefault();
                }, {passive: false});

                window.addEventListener("touchmove", function(e) {
                    if (isDragging) { processMovement(e); };
                }, {passive: false});

                window.addEventListener("touchend", function() {
                    isDragging = false;
                });
            };
        })();
    "$

	' Directly calls your central executor utility
	HMITilesIOUtils.ExecuteJS(mWebView, js)
End Sub
#End If

#if B4A
' Init
' Sets starting position for Android touch layouts
Public Sub Init(StartingValue As Int)
	Dim startX As Float = 20 + ((StartingValue / 100) * 80)
	UpdateSliderPosition(startX, StartingValue)
End Sub
#End If

' SetTile
' Sets all tile properties uniformly
Public Sub SetTile(Header As String, Footer As String, MinValue As Int, MaxValue As Int, Value As Int)
	' Check boundaries
	Value = Max(MinValue, Min(MaxValue, Value))
	mValue = Value
	    
	' Calculates accurate offsets based on tracking layout standards
	Dim handleX As Float = 20.0 + ((Value / 100.0) * 80.0)
    
	' 1. Group core structural text updates
	Dim textUpdates As Map = CreateMap( _
		"tile-header": Header, _
		"tile-footer": Footer, _
		"tile-value":  Value _
	)
	
	' 2. Map SVG handle positions and bar progress vectors cleanly
	Dim attrUpdates As Map = CreateMap( _
		"hmi-handle":   CreateMap("x": NumberFormat2(handleX - 5.0, 1, 2, 2, False)), _
		"hmi-progress": CreateMap("x2": NumberFormat2(handleX, 1, 2, 2, False)) _
	)
	
	' 3. Bundle everything up and push to your central utility engine
	Dim updatePayload As Map = CreateMap( _
		"text": textUpdates, _
		"attrs": attrUpdates _
	)
	
	HMITilesIOUtils.UpdateElementsViaJSON(mWebView, updatePayload)
End Sub

' UpdateSlider
' Low-latency repositioning helper called during fast telemetry refreshes
Private Sub UpdateSlider(x As Float, value As String)
	UpdateSliderPosition(x, value)
End Sub

' --- Central Private Utility to handle clean positional translations ---
Private Sub UpdateSliderPosition(PositionX As Float, DisplayValue As String)
	Dim textUpdates As Map = CreateMap("tile-value": DisplayValue)
	
	Dim attrUpdates As Map = CreateMap( _
		"hmi-handle":   CreateMap("x": NumberFormat2(PositionX - 5.0, 1, 2, 2, False)), _
		"hmi-progress": CreateMap("x2": NumberFormat2(PositionX, 1, 2, 2, False)) _
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
	' Update internal class state
	mState = Data.State
	mValue = Data.Value

	' Only trigger interactions on the initial touch down event
	' Handle actions
	If Data.Action = HMITilesIOUtils.ACTION_DOWN Or _ 
	   Data.Action = HMITilesIOUtils.ACTION_MOVE Then
		Dim PanelWidth As Float = mParentPanel.Width
		Dim svgTouchX As Float = (Data.X / PanelWidth) * 120
		
		If svgTouchX < 20 Then svgTouchX = 20
		If svgTouchX > 100 Then svgTouchX = 100
		
		Dim pct As Float = (svgTouchX - 20) / 80
		Dim finalValue As Int = Round(pct * 100)
		
		' Only execute UI updates and raise events if the value has actually shifted
		If finalValue <> mValue Then
		
			mValue = finalValue

			UpdateSlider(svgTouchX, mValue)
			
			' Update the vector graphics layers inside the WebView container
			If xui.SubExists(mCallBack, mEventName & "_Click", 1) Then
				CallSubDelayed3(mCallBack, mEventName & "_Click", mState, mValue)
			End If
		End If
	End If
    
	' Simplify result creation using standard B4X Type initialization shorthand
	Dim result As HMITouchResult
	result.Initialize
	result.State = mState
	result.Value = mValue
	Return result
End Sub

