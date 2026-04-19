B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' Handler class: SearchPage
Sub Class_Globals
End Sub

Public Sub Initialize
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	' 1. Διαβάζουμε την παράμετρο από το URL (αν υπάρχει)
	Dim query As String = req.GetParameter("text")
	If query = Null Then query = "" ' Αν δεν υπάρχει, το κάνουμε κενό
    
	Dim html As String
	' 2. Χρησιμοποιούμε το ${query} μέσα στο Smart String για να το περάσουμε στο HTML
	html = $"
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <title>Text-Embedding</title>
        <style>
            body { font-family: 'Segoe UI', sans-serif; background: #121212; color: white; text-align: center; padding: 50px; }
            #res { margin-top: 20px; padding: 15px; background: #1e1e1e; border: 1px solid #333; word-wrap: break-word; font-family: monospace; font-size: 12px; color: #00ffcc; }
            input { padding: 10px; width: 300px; border-radius: 4px; border: none; }
            button { padding: 10px 20px; cursor: pointer; background: #007bff; color: white; border: none; border-radius: 4px; }
        </style>
    </head>
    <body>
        <h2>Convert Text to Text-Embedding...</h2>
        <input type="text" id="query" value="${query}" placeholder="Write something...">
        <button onclick="sendQuery()">Send</button>
        <div id="res">Result will come here...</div>

        <script src="/b4j_ws.js"></script>
		<script>
            var b4j_ws;
            b4j_connect("/ws_search"); 

            var checkConnection = setInterval(function() {
                // Το readyState 1 σημαίνει ότι η γραμμή είναι OPEN και έτοιμη
                if (typeof b4j_ws !== 'undefined' && b4j_ws.readyState === 1) {
                    clearInterval(checkConnection); // Σταματάμε το χρονόμετρο
                    
                    var txt = document.getElementById("query").value;
                    if(txt !== "") {
                        sendQuery(); // Εκτέλεση αναζήτησης!
                    }
                }
            }, 100); // Κάνει έλεγχο κάθε 100 milliseconds (0.1 δευτερόλεπτο)

            function sendQuery() {
                var txt = document.getElementById("query").value;
                if(txt) {
                    b4j_raiseEvent("get_vector", {text: txt});
                    document.getElementById("res").innerText = "Processing in Python... Please wait.";
                }
            }

            function receiveVector(data) {
                document.getElementById("res").innerText = data;
            }
        </script>
    </body>
    </html>
    "$
    
	resp.ContentType = "text/html"
	resp.CharacterEncoding = "UTF-8"
	resp.Write(html)
End Sub