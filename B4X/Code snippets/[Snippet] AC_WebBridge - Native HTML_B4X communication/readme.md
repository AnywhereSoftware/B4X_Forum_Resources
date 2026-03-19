###   [Snippet] AC_WebBridge - Native HTML/B4X communication by Abdull Cadre
### 03/15/2026
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/170594/)

[TABLE]  
[TR]  
[TD]

![](https://www.b4x.com/android/forum/attachments/170610)

[/TD]  
  
[TD]

![](https://www.b4x.com/android/forum/attachments/170611)

[/TD]  
[/TR]  
[/TABLE]  
  
**Imagine that** you want to integrate an HTML page (WebView) with B4X or vice-versa. For example, creating a modern interface via HTML5/CSS and making it interact directly with your B4X logic…  
**Without using external libraries!** One of the things I've learned in B4X is that external libs can be a lot of work, especially when the lib owner stops offering support or when Android updates break the library's internal reflection.  
This snippet, **AC\_WebBridge**, provides a lightweight, "Zero-Library" solution that uses native Java via JavaObject to create a stable bridge between both worlds.  
[HEADING=2]**Key Features:**[/HEADING]  

- **Cross-Platform:** Single class that handles both B4A and B4J logic.
- **B4A Stability:** It intercepts console.log messages using a native WebChromeClient. This is much more stable than standard reflection and avoids the common ContentSettingsAdapter error on newer Android versions.
- **B4J Power:** It uses the JSObject from the JavaFX engine to inject the B4X instance directly into the browser's window object.
- **Clean Code:** Strictly follows English naming conventions, AC\_ prefixing, and SOLID principles.
- **Bi-directional:** Simple methods to send data from B4X to HTML and catch events from HTML in B4X.

---

  
[HEADING=2]**How it works:**[/HEADING]  
**1. On the JavaScript side:**  
You use a universal function to detect if you are running on B4J (object injection) or B4A (console log):  
JavaScript  
  

```B4X
function sendToB4X(message) {  
if (window.b4x && window.b4x.NativeBridgeHandler) {  
window.b4x.NativeBridgeHandler(message); // B4J path  
} else {  
console.log(message); // B4A path (captured by ChromeClient)  
    }  
}
```

  
  
  
**2. On the B4X side:**  
You simply initialize the bridge and listen for the \_OnJsMessage event:  

```B4X
' Initialize the bridge  
Bridge.Initialize(Me, "MyBridge")  
Bridge.Setup(WebView1)  
  
' Send data to HTML  
Bridge.RunJS(WebView1, "htmlFunction", Array("Hello from B4X"))  
  
' Receive data from HTML  
Public Sub MyBridge_OnJsMessage (Value As String)  
    Log("Received from WebView: " & Value)  
End Sub
```

  
  
**Files attached:**  

- **AC\_WebBridge.bas**: The standalone class.
- **Example.zip**: A full working project demonstrating the bi-directional flow

  
**Support**  
If this library is useful to you and you'd like to support my work, feel free to buy me a coffee!  
  
[☕ Click here to support via PayPal (yusrahassamo@gmail.com)](https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=yusrahassamo@gmail.com&item_name=Support+AC_WebBridge+Library&currency_code=USD&amount=)