### WebViewSwipeToRefresh by peacemaker
### 09/03/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/113922/)

As AHSwipeToRefresh lib [cannot work](https://www.b4x.com/android/forum/threads/ahswipetorefresh-for-webview-is-crashed.112060/) now with WebView (seems, due to AndroidX) - any solution must be found for pull-to-refresh.  
So, CLVSwipe Erel's class was reworked into this WVSwipe result class (only for Android from my side).  
  
Dependencies: JavaObject, ViewsEx, XUI.  
\* Adjustable ProgressBar circle color  
\* Tested on Android8, 10 devices, please, give feedback how works.  
  
WebViewSwipeToRefresh.b4xlib is used in WebView SwipeToRefresh\_test.zip project: the lib is made to have more comfortable usage without layout file.  
I guess, this class can be customized and used to pull-to-refresh of any view.  
  
Update v.0.18: fix of WebView freeze at fast scrolling  
Update v.0.17: fix of progressbar horizontal position, if WebView is not centered.