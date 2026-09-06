B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:     	HMITilesIOSlider.bas
' Brief:    	Horizontal slider with default range 0-100.
' Date:			2026-08-29
' Description:	Symmetrical control groove rail with flawless cursor mapping.
' Usage:		
'				TileSlider.Value = 68
' ================================================================
#End Region

Private Sub Class_Globals
	Private xui As XUI

	Public TEXT_COLOR As String = "#0f172a"
	Public TEXT_SIZE As Int = 24

	Private mState						As Boolean
	Private mValue						As String
	Private mParentPanel 				As B4XView		'ignore Local panel holding the webview
	Private mWebView					As WebView		'ignore Local WebView reference handle container
	Private mEventName 					As String
	Private mCallBack 					As Object

	Private mMinValue					As Float
	Private mMaxValue					As Float
End Sub

' Initializes the instance
Public Sub Initialize(pnl As B4XView, wv As WebView, evt As String, cb As Object)
	mParentPanel = pnl
	mWebView = wv
	mEventName = evt
	mCallBack = cb
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
Public Sub Init(showmovement As Boolean) As String
	Dim movement As String = ""
	If showmovement Then
		movement = $"window.location.href = "http://slider?val=" + finalValue;"$
	End If
	
	Dim js As String = $"
        (function() {
            var zone = document.getElementById("hmi-touch-zone");
            var handle = document.getElementById("hmi-handle");
            var prog = document.getElementById("hmi-progress");
            var txt = document.getElementById("slider-val");
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
                    if (txt) { txt.textContent = finalValue; };

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

	' Standard flattening to safeguard single-line execution mechanics
	js = js.Replace(Chr(10), " ").Replace(Chr(13), " ")
	Return js
End Sub
#End If

#if B4A
' Init
' Set starting position touch
Public Sub Init(StartingValue As Int) As String
	' Pre-calculate the starting visual layout vectors based on your hardware initialization parameters
	Dim startX As Float = 20 + ((StartingValue / 100) * 80)
	
	Dim js As String = $"
		(function() {
			var handle = document.getElementById("hmi-handle");
			var prog = document.getElementById("hmi-progress");
			var txt = document.getElementById("slider-val");
			
			if (handle) { handle.setAttribute("x", "${startX - 5}"); }
			if (prog)   { prog.setAttribute("x2", "${startX}"); }
			if (txt)    { txt.textContent = "${StartingValue}"; }
		})();
	"$
	Return js.Replace(Chr(10), " ").Replace(Chr(13), " ")
End Sub
#End If

' SetTile
' Set all tile properties.
' Parameter:
'	Header - String set text at tile top
'	Footer - String set text at tile bottom
' 	MinValue / MaxValue - Float for calibration floor and ceiling limits
' 	Value - Float current value
Public Sub SetTile(Header As String, _
				   Footer As String, _
				   MinValue As Int, _
				   MaxValue As Int, _ 
				   Value As Int) As String
				   
	' Check boundaries
	Value = Max(MinValue, Min(MaxValue, Value))
	mValue = Value
	    
	' Calculates accurate offsets based on tracking layout standards
	Dim handleX As Float = 20.0 + ((Value / 100.0) * 80.0)
	Dim rectOriginX As Float = handleX - 5.0
    
	Header = Header.Replace("'", "\'")
	Footer = Footer.Replace("'", "\'")
    
	Dim js As String = $"
        var head = document.getElementById("tile-header");
        var foot = document.getElementById("tile-footer");
        var handle = document.getElementById("hmi-handle");
        var prog = document.getElementById("hmi-progress");
        var txt = document.getElementById("slider-val");
        
        if(head) { head.textContent = "${Header}"; };
        if(foot) { foot.textContent = "${Footer}"; };
        if(txt) { txt.textContent = "${Value}"; };
        if(handle) { handle.setAttribute("x", "${rectOriginX}"); };
        if(prog) { prog.setAttribute("x2", "${handleX}"); };
    "$
	Return js
End Sub

Private Sub UpdateSlider(x As Float, value As String)
	Dim js As String = $"
						var handle = document.getElementById("hmi-handle");
						var prog = document.getElementById("hmi-progress");
						var txt = document.getElementById("slider-val");
						
						if (handle) { handle.setAttribute("x", "${X - 5}"); }
						if (prog)   { prog.setAttribute("x2", "${X}"); }
						if (txt)    { txt.textContent = "${value}"; }
					"$
	Wait for (HMITilesIOUtils.ExecuteJS(mWebView, js)) complete (result As Boolean)
	If Not(result) Then
		Log($"[Slider.UpdateValue][E] Can not update value"$)
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

