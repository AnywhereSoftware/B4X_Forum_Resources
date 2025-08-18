### iUI9 - Safari Controller by Erel
### 04/08/2021
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/70552/)

![](https://www.b4x.com/android/forum/attachments/47434)  
  
iUI9 currently includes a single class named SafariController.  
  
This library is supported by iOS 9+. This means that you need to add:  

```B4X
#MinVersion: 9
```

  
  
Up until now there were two controls to show web content: WebView and WKWebView internal WebView = WKWebView. These views give you full control over the content. You can extract the html and you can inject JavaScript and modify it.  
  
This is not the case with SafariController.  
  
1. SafariController is a full page controller. It is not a view.  
2. You can only use it to show web content. You cannot extract anything or modify the content.  
3. It is a full browser with most of Mobile Safari features.  
  
Another important feature of SafariController is that it can open non-https urls without disabling the ATS service. Apple will make it impossible (or difficult) to disable it in the future.  
  
Using SafariController is very simple as you can see from the following code:  

```B4X
#MinVersion: 9  
'no need to disable ATS.  
#ATSEnabled: true  
Sub Process_Globals  
   'These global variables will be declared once when the application starts.  
   'Public variables can be accessed from all modules.  
   Public App As Application  
   Public NavControl As NavigationController  
   Private Page1 As Page  
   Private safari As SafariController  
End Sub  
  
Private Sub Application_Start (Nav As NavigationController)  
   NavControl = Nav  
   Page1.Initialize("Page1")  
   Page1.Title = "Page 1"  
   Page1.RootPanel.Color = Colors.White  
   NavControl.ShowPage(Page1)  
   Dim bb As BarButton  
   bb.InitializeText("Open", "Open")  
   Page1.TopRightButtons = Array(bb)  
End Sub  
  
Sub Page1_BarButtonClick (Tag As String)  
   If Tag = "Open" Then  
     safari.Initialize("safari", "https://www.b4x.com")  
     safari.TintColor = Colors.Red  
     safari.Show(Page1)  
   End If  
End Sub  
  
  
Sub Safari_PageFinished (Success As Boolean)  
   Log($"PageFinished, Success = ${Success}"$)  
End Sub  
  
Sub Safari_Closed  
   Log("Controller closed")  
End Sub
```

  
  
Notes:  
- The PageFinished event is only raised for the first url.  
- The address bar is read-only. The user can navigate to other pages by following links.  
- 88%+ of the iOS devices are running iOS 9: <https://developer.apple.com/support/app-store/>