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
Public Sub SetTile(Header As String, _
				   Footer As String, _
				   MinValue As Int, _
				   MaxValue As Int, _ 
				   Value As Int) As String
				   
	' Check boundaries
	Value = Max(MinValue, Min(MaxValue, Value))
    
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

