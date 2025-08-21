### B4A WebView & SSL Certificate Errors by drgottjr
### 07/24/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/120515/)

the question of ssl certificate errors and b4a's webview comes up periodically.  
a workaround has been proposed using httputils2, hc client and webview.  
and, of course, the ssl error event itself is addressed in webviewextras2.  
for those interested in the knowing the reason for the error, i have cobbled  
together the following:  
  

```B4X
' usual webview setup  
Dim webview as WebView  
webview.Initialize("wv")  
Activity.AddView(webview, 0%x,0%y,100%x,100%y)  
  
' add this to allow your webview to see ssl errors and respond  
makeSslAware(webview, True)   ' True=ignore err  False=cancel load  
  
' load your url  
webview.LoadUrl( some_url )      ' presumably https …  
  
'———————————————————————————  
' add everything from here to the bottom to main:  
Sub makeSslAware( wv As WebView, ignore As Boolean )  
    Dim fielder As JavaObject  
    fielder.InitializeContext  
    fielder.SetField("ignore", ignore)  
    Dim client As JavaObject  
    client.InitializeNewInstance(Application.PackageName & ".main$MyWebViewClient", Null)  
    Dim jo As JavaObject = wv  
    jo.RunMethod("setWebViewClient", Array(client))  
End Sub  
  
Sub ssl_err(emsg As String)  
    Log("SSL cert error: " & emsg)  
End Sub  
  
  
  
#if Java  
   import anywheresoftware.b4a.BA;  
   import anywheresoftware.b4a.keywords.Common;  
  
   import android.webkit.SslErrorHandler;  
   import android.net.http.SslError;  
   import android.net.http.SslCertificate;  
   import android.webkit.WebView;  
   import android.webkit.WebViewClient;  
   import java.lang.Boolean;  
    
   public static boolean ignore;  
    
   public static class MyWebViewClient extends WebViewClient {  
   @Override  
      public void onReceivedSslError( WebView wv, SslErrorHandler handler, SslError sslerror) {  
         if (ignore)  
               handler.proceed();  
         else  
            handler.cancel();  
             
         String sslerr;  
          
         switch (sslerror.getPrimaryError()) {  
            case android.net.http.SslError.SSL_DATE_INVALID:  
                sslerr = "Date Invalid";  
                break;  
            case android.net.http.SslError.SSL_EXPIRED:  
                sslerr = "Expired";  
                break;  
            case android.net.http.SslError.SSL_IDMISMATCH:  
                sslerr = "Host mismatch";  
                break;  
            case android.net.http.SslError.SSL_NOTYETVALID:  
                sslerr = "Not yet valid";  
                break;  
            case android.net.http.SslError.SSL_UNTRUSTED:  
                sslerr = "Untrusted";  
                break;  
            default:          // android.net.http.SslError.SSL_INVALID:  
                sslerr = "Generic Invalidity";  
                break;  
         }  
         processBA.raiseEvent(this, "ssl_err",new Object[] {sslerr});     
      }  
   }  
  
#End If
```

  
  
  
disclaimers:  
  
for b4a, not the other b4's.  
  
with a little more effort, i could have implemented it as a class. and with a fair amount of effort,  
a library probably could have been made. too old, too weak at this point.  
  
my understanding of the Android's WebViewClient documentation is that, when an SSL error is  
triggered, you have the choice of continuing to load the page or to cancel loading. canceling appears  
to be the default. when you run the makeSslAware sub, you choose true (to continue) or false (to  
cancel).  
  
there several testing sites out there which deliberately return SSL certificate errors. i tested with  
them. as far as indicating which errors were generated, the code works as expected. as to  
whether "continue" or "cancel" modes work, frankly, i got the same results with these sites  
regardless of which i chose. i also got the same results even if i didn't use my code, so i'm  
guessing that since these were specifically designed test sites, their responses were  
specifically designed.   
  
i don't know of any particiular sites whose certificates are invalid, so i could not test the code  
with a real site. in other words, i have no idea how things play out when you try to access a real  
site with a bad SSL cert. i'm sure you'll see what the error is, but i don't know for sure if you'll be  
able to load the page in the event you choose "continue" mode. that seems to be the main  
concern for anyone who has posted here. eg, "i got an ssl exception and couldn't load the page…"   
so if the page doesn't load after you've chosen "continue", then - obviously - toss the code, as  
its value is questionable at best. and i apologize for wasting your time.  
  
the included code (as well as that of webviewextras2), is supposed to let you load the affected  
page (or cancel loading if the error frightens you). the difference between my code and  
webviewextras2's handling of the ssl error is that i show what the error is (should that be of  
interest).  
  
note: regrettably, i believe my code will conflict with webviewextras2; it was mainly designed for  
use with webviewextras1.42 or without webviewextras. if you have no interest in knowing what  
the ssl error is, then don't bother with it; webviewextras2 is your ticket.  
  
(thanks to Erel for some hints provided in a different context.)