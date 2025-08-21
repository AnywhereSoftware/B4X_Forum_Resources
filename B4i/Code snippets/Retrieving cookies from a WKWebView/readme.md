### Retrieving cookies from a WKWebView by CaptKronos
### 04/24/2020
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/116809/)

I don't think a way of getting cookies from a WKWebView has been presented yet. The following seems to work.  
  

```B4X
Sub getCookies  
    Dim no As NativeObject=Me  
    no.RunMethod("getCookies::", Array(WKWebView1, "WKWebView1_gotcookies"))  
End Sub  
  
Sub WKWebView1_gotCookies(cookies As List) 'ignore  
    Dim no As NativeObject  
    For i=0 To cookies.Size-1  
        no=cookies.Get(i)  
        Log(no.GetField("name").AsString & "=" & no.GetField("value").AsString)  
    Next  
End Sub  
  
#if ObjC  
  
- (void)getCookies:(WKWebView *)_webView :(NSString *)eventName  
{  
    _webView.configuration.processPool = [[WKProcessPool alloc] init];  
     WKHTTPCookieStore *cookieStore = _webView.configuration.websiteDataStore.httpCookieStore;  
     [cookieStore getAllCookies:^(NSArray* cookies) {  
        B4IList* lst = [B4IList new];  
        lst.object = cookies;  
        NSString *fullEventName = [NSString stringWithFormat:@"%@:", [eventName lowercaseString]];  
        [self.bi raiseEvent:nil event:fullEventName params:@[lst]];  
      }  
     ];  
}  
#End If
```