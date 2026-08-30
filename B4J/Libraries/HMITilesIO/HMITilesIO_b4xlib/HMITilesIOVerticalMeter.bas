B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.5
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private xui As XUI
	Public COLOR_TRACK As String = "#808080"
End Sub

' SetTile
' Set all tile properties.
' CurrentValue: Raw reading from the microcontroller
' MinValue / MaxValue: Calibration floor and ceiling limits
' ColorHex: Web format color string passed down dynamically (e.g. "#22c55e")
Public Sub SetTile(Header As String, _
				   Footer As String, _
				   TrackColor As String, _ 
				   MinValue As Float, _
				   MaxValue As Float, _
				   Value As Float) As String	' HEX #RRGGBB
    
	' 1. Guard input values inside safety boundaries
	If Value < MinValue Then Value = MinValue
	If Value > MaxValue Then Value = MaxValue
    
	' 2. Calculate percentage position across your custom scale range
	Dim totalRange As Float = MaxValue - MinValue
	Dim pct As Float = 0
	If totalRange > 0 Then pct = (Value - MinValue) / totalRange
    
	' 3. Calculate explicit height and tracking coordinates (Total track slot span = 64px)
	Dim barHeight As Float = pct * 64.0
	Dim barY As Float = 94.0 - barHeight
    
	' 4. Calculate vertical slide translate vector shift for the pointer arrow
	Dim arrowShiftY As Float = -barHeight
    
	' 5. Clean text variables
	Header = Header.Replace("'", "\'")
	Footer = Footer.Replace("'", "\'")
	TrackColor = TrackColor.Replace("'", "\'")
    
	' Isolated script execution prevents global DOM crashes
	Dim js As String = $"
        var head = document.getElementById("tile-header");
        var foot = document.getElementById("tile-footer");
        var vtxt = document.getElementById("meter-val");
        var level = document.getElementById("meter-level");
        var arrow = document.getElementById("meter-arrow");
        
        if(head) { head.textContent = "${Header}"; };
        if(foot) { foot.textContent = "${Footer}"; };
        if(vtxt) { vtxt.textContent = "${Value.As(Int)}"; };
        
        if(level) { 
            level.setAttribute("y", "${barY}");
            level.setAttribute("height", "${barHeight}");
            level.setAttribute("fill", "${TrackColor}");
        };
        
        if(arrow) {
            arrow.setAttribute("fill", "${TrackColor}");
            arrow.setAttribute("transform", "translate(0, " + ${arrowShiftY} + ")");
        };
    "$
	Return js
End Sub
