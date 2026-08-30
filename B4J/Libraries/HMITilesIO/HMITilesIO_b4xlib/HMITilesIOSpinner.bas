B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.5
@EndOfDesignText@
'Static code module
Private Sub Process_Globals
	Public TEXT_COLOR As String = "#0f172a"
	Public TEXT_SIZE As Int = 24
End Sub

' SetTile
' Updates the readout text, size, and coloring instantly without page reloads
Public Sub SetTile(Header As String, _
				   Footer As String, _
                   MinValue As Float, _
				   MaxValue As Float, _
				   Value As String) As String

	' 1. Guard input values inside safety boundaries
	Value = Max(MinValue, Min(MaxValue, Value.As(Float)))

	' Formulate a safe, compact single-line DOM manipulator execution string
	Dim js As String = $"
		var head = document.getElementById("tile-header");
		var foot = document.getElementById("tile-footer");
		var txt = document.getElementById("value-display");

		if(head) { 
			head.textContent = "${Header}"; 
		};
		
		if(foot) { 
			foot.textContent = "${Footer}"; 
		};

		if (txt) {
			txt.textContent = "${Value}";
			txt.setAttribute("font-size", "${TEXT_SIZE}");
			txt.setAttribute("fill", "${TEXT_COLOR}");
		}
	"$
	Return js
End Sub
