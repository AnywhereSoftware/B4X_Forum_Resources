B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private WebView1 As WebView
	Private btnB4X As Button
	Private WI As AC_WebBridge
	Private EditText1 As B4XView
End Sub

Public Sub Initialize
	' Add page initialization logic here if needed
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
    
	' Initialize the native bridge
	WI.Initialize(Me, "MyBridge")
	WI.Setup(WebView1)
    
	LoadHtmlContent
End Sub

' Loads the responsive HTML interface into the WebView
Private Sub LoadHtmlContent
	Dim html As String = $"
    <!DOCTYPE html>
    <html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
        <style>
            body { 
                font-family: 'Roboto', sans-serif; 
                background-color: #f5f5f5; 
                display: flex; flex-direction: column; 
                align-items: center; justify-content: center; 
                height: 100vh; margin: 0;
            }
            .card {
                background: white; padding: 24px;
                border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                width: 85%; max-width: 400px;
            }
            h2 { color: #1976D2; font-weight: 400; margin-top: 0; }
            input {
                width: 100%; padding: 12px 0; margin: 20px 0;
                border: none; border-bottom: 2px solid #bdbdbd;
                outline: none; font-size: 16px; transition: border-color 0.3s;
                box-sizing: border-box;
            }
            input:focus { border-bottom: 2px solid #1976D2; }
            button {
                background-color: #1976D2; color: white;
                border: none; padding: 12px 24px;
                border-radius: 4px; font-weight: bold;
                text-transform: uppercase; cursor: pointer;
                width: 100%; box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            }
            button:active { background-color: #1565C0; box-shadow: none; }
        </style>
    </head>
    <body>
        <div class="card">
            <h2>HTML Interface</h2>
            <input type="text" id="myInput" placeholder="Enter message...">
            <button onclick="sendToB4X()">Send to B4X</button>
        </div>

        <script>
            /**
             * Sends data from HTML to the B4X host
             */
            function sendToB4X() {
                var msg = document.getElementById('myInput').value;
                if (typeof b4x !== 'undefined') {
                    // B4J route
                    b4x.NativeBridgeHandler(msg);
                } else {
                    // B4A route (intercepted via ConsoleMessage)
                    console.log(msg);
                }
            }

            /**
             * Receives data from B4X and updates the input field
             */
            function updateHtmlInput(textValue) {
                document.getElementById('myInput').value = textValue;
            }
        </script>
    </body>
    </html>
    "$
	WebView1.LoadHtml(html)
End Sub

' -------------------------------------------------------------------------
' Communication: B4X -> HTML
' -------------------------------------------------------------------------
Sub btnB4X_Click
	Dim InputText As String = EditText1.Text
	' Triggers the JavaScript function defined in the HTML string
	WI.RunJS(WebView1, "updateHtmlInput", Array(InputText))
End Sub

' -------------------------------------------------------------------------
' Communication: HTML -> B4X
' -------------------------------------------------------------------------
' This event is triggered by the AC_WebBridge class
Public Sub MyBridge_OnJsMessage (Value As String)
	Log("Message received from WebView: " & Value)
	EditText1.Text = Value
End Sub