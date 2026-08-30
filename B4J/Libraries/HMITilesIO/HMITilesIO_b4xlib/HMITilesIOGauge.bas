B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.5
@EndOfDesignText@
'Static code module
Sub Process_Globals
'
End Sub

' SetTile
' Set all tile properties.
' Parameters:
' 	Header: Tile label text
' 	FooterText: Dynamic unit value display string (e.g. "45.2 PSI")
' 	MinValue: Bottom scale value (maps to -180 degrees)
' 	MaxValue: Top scale value (maps to 0 degrees)
' 	GreenMaxPct: At what percentage of the total range does Green end? (e.g., 50)
' 	YellowMaxPct: At what percentage of the total range does Yellow end? (e.g., 85)
' 	Value: The actual reading
' Returns:
'	String - JavaScript
Public Sub SetTile(Header As String, _
				   Footer As String, _
                   MinValue As Float, _
				   MaxValue As Float, _
                   GreenMaxPct As Float, _
				   YellowMaxPct As Float, _
				   Value As Float) As String
    
	' 1. Guard input values inside safety boundaries
	Value = Max(MinValue, Min(MaxValue, Value))
	
	' 2. Calculate percentage position across your custom scale range
	Dim totalRange As Float = MaxValue - MinValue
	Dim pct As Float = 0
	If totalRange > 0 Then pct = (Value - MinValue) / totalRange
    
	' 3. Symmetrical 180-degree sweep calculation math
	' Pct = 0.0 (0%)   -> Angle maps to -180 degrees (Pointing exactly West / Left)
	' Pct = 0.5 (50%)  -> Angle maps to -90 degrees  (Pointing exactly North / Straight Up)
	' Pct = 1.0 (100%) -> Angle maps to 0 degrees    (Pointing exactly East / Right)
	Dim targetDegrees As Float = -90.0 + (pct * 180.0)
    
	' 4. Clean text variables
	Header = Header.Replace("'", "\'")
	Footer = Footer.Replace("'", "\'")
    
	' 5. Calculate mask offsets to reveal zones from left to right (Total Arc = 113.1px)
	Dim greenOffset As Float = 113.1 - (113.1 * (GreenMaxPct / 100.0))
	Dim yellowOffset As Float = 113.1 - (113.1 * (YellowMaxPct / 100.0))
    
	Dim js As String = $"
        var head = document.getElementById("tile-header");
        var foot = document.getElementById("tile-footer");
        var needle = document.getElementById("gauge-needle");
        var arcG = document.getElementById("arc-green");
        var arcY = document.getElementById("arc-yellow");
        
        if(head) { head.textContent = "${Header}"; };
        if(foot) { foot.textContent = "${Footer}"; };
        
        if(arcG) { arcG.setAttribute("stroke-dashoffset", "${greenOffset}"); };
        if(arcY) { arcY.setAttribute("stroke-dashoffset", "${yellowOffset}"); };
        
        if(needle) {
            needle.style.transform = "";
            needle.style.transformOrigin = "";
            needle.style.transition = "";
            var deg = ${targetDegrees};
            needle.setAttribute("transform", "rotate(" + deg + ", 60, 80)");
        };
    "$
	Return js
End Sub
