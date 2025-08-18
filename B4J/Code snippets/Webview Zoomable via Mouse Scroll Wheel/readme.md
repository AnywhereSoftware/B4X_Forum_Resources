###  Webview Zoomable via Mouse Scroll Wheel by swChef
### 05/19/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/130869/)

Perhaps there is another or better way to accomplish a mouse scroll wheel zoomable Webview, but here is what I found works. It borrows from a post on Scroll Events.  
I didn't research DeltaY, MultiplierY and TextDeltaY deeply, and likely all 3 are not necessary to achieve the same effect. But since I'm only looking at it on one platform/OS/screensize I used all 3 and left the debug lines commented.  
  
You'll need a Scroll\_Event Sub  
  

```B4X
Sub Scroll_Event (MethodName As String, Args() As Object) As Object  
    Dim scrollevent As JavaObject = Args(0)  
    Dim bControl As Boolean = scrollevent.RunMethod("isControlDown", Null)  
    If bControl Then  
        Dim dDy As Double = scrollevent.RunMethod("getDeltaY", Null) ' values here and My are double  
        Dim dMy As Double = scrollevent.RunMethod("getMultiplierY", Null) ' same mag as DeltaY  
        Dim dTDy As Double = scrollevent.RunMethod("getTextDeltaY", Null)  
        Dim dZ As Double = WebView1.Zoom  ' nominally 1  
        Dim dDz As Double = 1.0 / (Abs(dTDy)*dDy/dMy)  
        'Log(dDz)  
        WebView1.Zoom = dZ + dDz * dZ  
        'Log(WebView1.Zoom)  
    End If  
    Return Null  
End Sub
```

  
  
I registered the Scroll EventHandler just after the Root.LoadLayout  
  

```B4X
    Dim jo As JavaObject = WebView1  
    Dim e As Object = jo.CreateEventFromUI("javafx.event.EventHandler", "scroll", Null)  
    jo.RunMethod("setOnScroll", Array(e))
```

  
  
I used a ScrollPane to hold the Webview, because I'm essentially doing a splitscreen with another control (not shown here).  
  
I placed the ScrollPanel LoadLayout in the B4XPage\_Created after the Root.LoadLayout, and before the Scroll EventHandler. For the "WebviewOnly" layout, in the Designer I set the WebView1 to the size of Main and set the H and V anchors to <->.  
  

```B4X
ScrollPane1.LoadLayout("WebviewOnly",-1,-1)
```

  
  
So in my case the B4XPage\_Created started like this.  
  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    ScrollPane1.LoadLayout("WebviewOnly",-1,-1)  
     
    Dim jo As JavaObject = WebView1  
    Dim e As Object = jo.CreateEventFromUI("javafx.event.EventHandler", "scroll", Null)  
    jo.RunMethod("setOnScroll", Array(e))
```