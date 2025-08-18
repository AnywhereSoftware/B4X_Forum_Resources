### WebViewAssetLoader - the demo by drgottjr
### 09/09/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/134162/)

here is a demonstration of the WebViewAssetLoader class API.  
  
questions about webview's failing to load local resources under sdk30 are starting to pop up occasionally. they are, of course, beaten down by a chorus of "don't use webview!" i'm not here to judge.   
   
what it boils down to is google wants you to use the https:// scheme to load local resources into webviews. this is a problem if you don't run a secure server on the same device as the app.  
  
to allow you to use the https:// scheme, google has created a dummy secure url. with the webviewassetloader api, you keep your local files in dirassets or dirinternal, like always, but load them using the dummy url instead of the file:// scheme, which is what google is turning off. (yes, i know it's possible to turn it on - for the moment - and i am also aware of a number of other considerations and questions, but for the purposes of the demo, i'm haven't addressed them here. i previously referred to some workarounds in [this post.](https://www.b4x.com/android/forum/threads/webview-access-denied-with-api-30.132424/#content) i have no doubt they will be phased out once everyone is onboard with the assetloader.)  
   
to run the demo, you need to:  
1) unzip the attached archive.  
2) copy/move the .jar and .xml files to your additional libraries folder.  
3) open your sdk manager and look for "webkit". you're looking for "androidx.webkit:webkit (Google Maven) Version 1.4.0". download it, if applicable. this is the assetloader api.  
4) build and run the demo. (b4a11, sdk30, right?)  
  
if you are among those encountering the net::ERR\_ACCESS\_DENIED problem as a result of trying to load a webview with file://, the demo should work for you. if you look closely at my test file, you will see how you can even load local resources from within the test file. (and if you keep sub-folders in dirinternal, you can load from them as well. i didn't do that for the demo.)  
  
if the demo doesn't run correctly, and you've run it on a recent device targeting sdk30, i'll try to help. i've tested it on 2 devices running android 11, targeting sdk30 and built with b4a 11.   
  
the api overrides aspects of the webviewwrapper in our b4a core library. and it overrides some aspects of android's own webview, so i would assume that will change as google catches up with what may be unintended behavior and people start complaining loud enough. for the moment, google seems intent on shutting down vulnerabilities first.