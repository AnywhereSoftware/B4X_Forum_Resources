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
Public Sub SetTile(Header As String, _
					Footer As String, _
					State As Boolean) As String
	Dim js As String
    
	' Escape text values cleanly for safe JS execution strings
	Header = Header.Replace("'", "\'")
	Footer = Footer.Replace("'", "\'")
    
	If State Then
		js = $"
            var head = document.getElementById("tile-header");
            var foot = document.getElementById("tile-footer");
            var lens = document.getElementById("led-lens");
            if(head) { head.textContent = "${Header}"; };
            if(foot) {
                foot.textContent = "${Footer}";
                foot.setAttribute("fill", "#64748b");
            };
            if(lens) {
                lens.setAttribute("fill", "url(#ledGreen)");
                lens.setAttribute("filter", "url(#lensGlow)");
            };
        "$
	Else
		js = $"
            var head = document.getElementById("polygon-header");
            var head = document.getElementById("tile-header");
            var foot = document.getElementById("tile-footer");
            var lens = document.getElementById("led-lens");
            if(head) { head.textContent = "${Header}"; };
            if(foot) {
                foot.textContent = "${Footer}";
                foot.setAttribute("fill", "#64748b");
            };
            if(lens) {
                lens.setAttribute("fill", "url(#ledOff)");
                lens.removeAttribute("filter");
            };
        "$
	End If
	Return js
End Sub

