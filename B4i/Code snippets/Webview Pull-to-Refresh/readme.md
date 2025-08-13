### Webview Pull-to-Refresh by JohnC
### 02/21/2024
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/159416/)

'init hook  

```B4X
Dim no As NativeObject  
no.Initialize("WebViewRefreshControl")  
no.RunMethod("addPullToRefreshToWebView:", Array(wv))    'assumes wv = webview
```

  
  
'event code that is called to do actual refresh  

```B4X
Private Sub wv_RefreshEvent  
    wv.LoadUrl(LastURL)   'store each URL navigated to into the var LastURL so can reuse it  
End Sub
```

  
  
'OBJC code  

```B4X
#If OBJC  
@end  
@interface WebViewRefreshControl : NSObject  
@end  
  
#import <UIKit/UIKit.h>  
  
@implementation WebViewRefreshControl  
  
+ (void)addPullToRefreshToWebView:(WKWebView *)webView {  
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];  
    [refreshControl addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventValueChanged];  
    [webView.scrollView addSubview:refreshControl];  
    webView.scrollView.bounces = YES;  
}  
  
+ (void)refreshAction:(UIRefreshControl *)refreshControl {  
    WKWebView *webView = (WKWebView *)refreshControl.superview.superview;  
    [B4IObjectWrapper raiseEvent:webView :@"_refreshevent" :@[]];  
    [refreshControl endRefreshing];  
}  
  
#End If
```