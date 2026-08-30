B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.5
@EndOfDesignText@
'Static code module
Private Sub Process_Globals
'
End Sub

' SetTile
' Set all tile properties.
Public Sub SetTile(Header As String, _
				   Footer As String, _
				   State As Boolean) As String
	' Escape text values cleanly for safe JS execution strings
	Header = Header.Replace("'", "\'")
	Footer = Footer.Replace("'", "\'")
    
	Dim js As String
    
	If State Then
		' State: ON -> Top part turns GREEN / Glowing (Pressed up). Bottom part turns dark dim.
		js = $"
            var head = document.getElementById("tile-header");
            var foot = document.getElementById("tile-footer");
            var topSeg = document.getElementById("rocker-top");
            var topSym = document.getElementById("rocker-symbol-i");
            var botSeg = document.getElementById("rocker-bottom");
            var botSym = document.getElementById("rocker-symbol-o");
            
            if(head) { head.textContent = "${Header}"; };
            if(foot) { foot.textContent = "${Footer}"; };
            if(topSeg) {
                topSeg.setAttribute("fill", "url(#greenGlow)");
                topSeg.setAttribute("stroke", "#86efac");
                topSeg.setAttribute("height", "29");
                topSym.setAttribute("stroke", "#ffffff");
                topSym.setAttribute("filter", "url(#neonGlow)");
            };
            if(botSeg) {
                botSeg.setAttribute("fill", "#14532d");
                botSeg.setAttribute("stroke", "#052e16");
                botSeg.setAttribute("y", "62");
                botSeg.setAttribute("height", "25");
                botSym.setAttribute("stroke", "#166534");
                botSym.removeAttribute("filter");
            };
        "$
	Else
		' State: OFF -> Top part turns dark dim. Bottom part turns RED / Glowing (Pressed down).
		js = $"
            var head = document.getElementById("tile-header");
            var foot = document.getElementById("tile-footer");
            var topSeg = document.getElementById("rocker-top");
            var topSym = document.getElementById("rocker-symbol-i");
            var botSeg = document.getElementById("rocker-bottom");
            var botSym = document.getElementById("rocker-symbol-o");
            
            if(head) { head.textContent = "${Header}"; };
            if(foot) { foot.textContent = "${Footer}"; };
            if(topSeg) {
                topSeg.setAttribute("fill", "#450a0a");
                topSeg.setAttribute("stroke", "#1e0202");
                topSeg.setAttribute("height", "26");
                topSym.setAttribute("stroke", "#991b1b");
                topSym.removeAttribute("filter");
            };
            if(botSeg) {
                botSeg.setAttribute("fill", "url(#redGlow)");
                botSeg.setAttribute("stroke", "#fca5a5");
                botSeg.setAttribute("y", "60");
                botSeg.setAttribute("height", "27");
                botSym.setAttribute("stroke", "#ffffff");
                botSym.setAttribute("filter", "url(#neonGlow)");
            };
        "$
	End If
	Return js
End Sub

