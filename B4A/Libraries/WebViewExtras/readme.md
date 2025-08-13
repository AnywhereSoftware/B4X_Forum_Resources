### WebViewExtras by warwound
### 10/16/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/12453/)

Hi all.  
  
WebViewExtras is my latest library.  
It's a much updated version of [JSInterface](http://www.b4x.com/forum/additional-libraries-official-updates/9893-jsinterface.html#post54859).  
  
WebViewExtras exposes more of the available native Android WebView methods to your B4A application:  
  
[SIZE=4]**addJavascriptInterface(webView1 As WebView, interfaceName As String)**[/SIZE]  
  
Add a javascript interface to webView1, methods of the interface can be accessed using javascript with the interfaceName as the javascript namespace.  
  
The interface contains just a single overloaded method **CallSub()**.  
The CallSub method signatures are:  
  
**CallSub(subName As String, callUIThread As boolean)  
CallSub(subName As String, callUIThread As boolean, parameter1 As String)  
CallSub(subName As String, callUIThread As boolean, parameter1 As String, parameter2 As String)  
CallSub(subName As String, callUIThread As boolean, parameter1 As String, parameter2 As String, parameter3 As String)**  
  
So if you have added the interface to your webView with the interfaceName of "B4A" then you can write javascript such as:  
  

```B4X
B4A.CallSub('MySubName', true)
```

  
  
The **callUIThread** parameter is an important update - it's not available with JSInterface.  
  
Does the Sub called by your javascript modify your activity UI?  
If the answer is yes then you need to pass boolean true as callUIThread otherwise you can pass false.  
If you pass false and then the Sub tries to modify your activity UI you will get an exception.  
  
Does your javascript require a return value from your Sub?  
If the answer is yes then the Sub MUST NOT modify the activity UI.  
If CallSub is excuted with callUIThread set to true then no values will be returned from your Sub to the javascript.  
  
You will need to structure your B4A code so that Subs that return values to javascript do not modify the activity UI.  
  
[SIZE=4]**addWebChromeClient(webView1 As WebView, EventName As String)**[/SIZE]  
  
Add a WebChromeClient to webView1.  
  
The default B4A WebView has no WebChromeClient.  
A WebChromeClient handles many things, the WebChromeClient that WebViewExtras adds to your WebView enables:  

- Javascript modal dialogs: alert, prompt and confirm.
- Logging of javascript console messages and errors to the B4A log.
- File upload dialog - see <http://www.b4x.com/forum/additional-libraries-official-updates/12453-webviewextras-2.html#post97320>.
- Web page requests for device geolocation can be granted or denied - see <http://www.b4x.com/forum/additional-libraries-official-updates/12453-webviewextras-2.html#post102448>.

  
**Version 1.30 of WebViewExtras requires that an additional EventName parameter is passed to the addWebChromeClient method, see this post**: <http://www.b4x.com/forum/additional-libraries-official-updates/12453-webviewextras-2.html#post102448>  
  
[SIZE=4]**clearCache(webView1 As WebView, includeDiskFiles As boolean)**[/SIZE]  
  
Clear the WebView cache.  
Note that the cache is per-application, so this will clear the cache for all WebViews used in an application.  
  
boolean includeDiskFiles - If false, only the RAM cache is cleared.  
  
[SIZE=4]**executeJavascript(webView1 As WebView, javascriptStatement As String)**[/SIZE]  
  
Executes a string of one or more javascript statements in webView1.  
javascriptStatement - A string of one or more (semi-colon seperated) javascript statements.  
  
[SIZE=4]**flingScroll(webView1 As WebView, vx As Int, vy As Int)**[/SIZE]  
  
flingScroll is a poorly documented method of the WebView.  
*It's included in WebViewExtras as it may be useful but i can find no documentation for it or it's parameters.*  
  
vx and vy do not seem to be pixel values - i suspect they are velocity values for the kinetic/fling scroll.  
  
[SIZE=4]**pageDown(webView1 As WebView, scrollToBottom As boolean)**[/SIZE]  
  
Scroll the contents of webView1 down by half the page size.  
  
scrollToBottom - If true then webView1 will be scrolled to the bottom of the page.  
  
Returns a Boolean value to indicate the success or failure of the scroll.  
  
[SIZE=4]**pageUp(webView1 As WebView, scrollToTop As boolean)**[/SIZE]  
  
Scroll the contents of webView1 up by half the page size.  
  
scrollToTop - If true then webView1 will be scrolled to the top of the page.  
  
Returns a Boolean value to indicate the success or failure of the scroll.  
  
[SIZE=4]**zoomIn(webView1 As WebView)**[/SIZE]  
  
Perform zoom in on webView1.  
  
Returns a Boolean value to indicate the success or failure of the zoom.  
  
[SIZE=4]**zoomOut(webView1 As WebView)**[/SIZE]  
  
Perform zoom out on webView1.  
  
Returns a Boolean value to indicate the success or failure of the zoom.  
  
Up to date documentation/reference for this library can be found here: <http://www.b4x.com/forum/additional-libraries-official-updates/12453-webviewextras-3.html#post106486>.  
  
Library and demo code is attached to this post.  
  
The demo is a bit brief - sorry but i don't have time to write demo code for all the new methods.  
The demo displays two WebViews - the top WebView has a JavascriptInterface and WebChromeClient whereas the lower WebView has neither - it is the default B4A WebView.  
  
Martin.  
  
Edit by Erel:  
- There is a security issue related to AddJavascriptInterface in older versions of Android. See this link: <https://www.b4x.com/android/forum/threads/webviewextras-addjavascriptinterface-vulnerability.85032/#content>  
**- v2.20 is attached. This is the latest version.**