### adding SFSafariViewController by Andrew (Digitwell)
### 03/24/2021
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/129028/)

I recently created an app for a charity that used STRIPE to collect Carbon Offsetting payments.  
  
The Android version had no problems. Unfortunately, Apple rejected the app, for being an Unacceptable business Model.  
  
> [SIZE=5]**Guideline 3.2.2 - Business - Other Business Model Issues - Unacceptable**[/SIZE]  
>   
>   
> We noticed that your app includes the ability to collect charitable donations within the app, which is not appropriate for the App Store, because your organization does not appear to be an approved nonprofit.  
>   
> **Next Steps**  
>   
> There are several alternatives available regarding the acceptance of charitable donations depending on whether your organization is a nonprofit that has been approved by [Benevity.org](https://causes.benevity.org/apple-pay/apple-pay-landing):  
>   
> 1) Both approved and not approved nonprofits may accept donations outside of free apps by providing a link to your website that launches Safari or SFSafariViewController for users to make a donation.  
>   
> 2) If you are an approved nonprofit, you may accept donations within free apps, so long as you don't collect the donation using in-app purchase and the app includes Apple Pay for Donations in all locations where Apple Pay is available.  
>   
> 3) If you are not an approved nonprofit, you may add a link in free apps to send an SMS to make the donation.  
>   
> If your organization is already a Benevity-approved nonprofit, it would be appropriate to confirm this approved nonprofit status in the App Review Information section of App Store Connect.

  
I chose option number 1, SFSafariViewController.  
  
This view controller is not available by default. After a bit of digging I came up with the following code  

```B4X
private Sub ShowSafariPage(safPanel As B4XView)  
     
    Private NOJ As NativeObject = Me  
    Private v As View = safPanel  'ignore  
     
     
    Private URL As String = $"https://URLto display"$  
  
'    Log("Calling..")  
    NOJ.RunMethod("displaySafari::",Array(v,URL))  
'    Log("Called…")  
End Sub  
#end region  
  
  
#region SFSafariViewController  
  
  
public Sub safariLoaded(success As Boolean)  
    Log($"Loaded event called with success = ${success}"$)  
End Sub  
  
public Sub safarievent(event As String)  
    Log($"Safari event ${event}"$)  
End Sub  
  
' Create a safari view controller and attach it to the panel  
'TAKEN FROM https://code.tutsplus.com/tutorials/ios-9-getting-started-with-sfsafariviewcontroller–cms-24260  
'And  
'https://gist.github.com/andrassomogyi/1528c4291a4cb5b51de5  
'https://stackoverflow.com/questions/1340434/get-to-uiviewcontroller-from-uiview  
'https://stackoverflow.com/questions/39019352/ios10-sfsafariviewcontroller-not-working-when-alpha-is-set-to-0  
#if OBJC  
@import SafariServices;  
  
  
  
- (void) displaySafari: (UIView*) _containerView : (NSString *) myUrl {  
  
UIViewController* _containerViewController = (UIViewController *) [self firstAvailableUIViewController: _containerView];  
  
SFSafariViewController *_safariViewController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:myUrl]];  
_safariViewController.delegate = self;  
_safariViewController.view.frame = _containerView.frame;  
[_containerViewController addChildViewController:_safariViewController];  
[_containerView addSubview:_safariViewController.view];  
//[_safariViewController didMoveToParentViewController:_containerViewController];  
  
}  
  
//https://stackoverflow.com/questions/1340434/get-to-uiviewcontroller-from-uiview  
  
- (UIViewController *)firstAvailableUIViewController: (UIView *) v {  
/// Finds the view's view controller.  
  
    // Take the view controller class object here and avoid sending the same message iteratively unnecessarily.  
    Class vcc = [UIViewController class];  
  
    // Traverse responder chain. Return first found view controller, which will be the view's view controller.  
    UIResponder *responder = v;  
    while ((responder = [responder nextResponder]))  
        if ([responder isKindOfClass: vcc])  
        {  
           NSLog(@"Found UIViewController");  
            return (UIViewController *)responder;  
        }  
    // If the view controller isn't found, return nil.  
   NSLog(@"UIViewController not found");  
       return nil;  
}  
  
-(void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully {  
               [self.bi raiseEvent:nil event:@"safariloaded:"  params:@[@(didLoadSuccessfully)]];  
  
           NSLog(@"Load Finished");  
             
}  
  
-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller {  
   [self.bi raiseEvent:nil event:@"safarievent:"  params:@[@"Done"]];  
    NSLog(@"Trapped dismiss");  
    [controller willMoveToParentViewController:nil];  
    [controller.view removeFromSuperview];  
    [controller removeFromParentViewController];  
}  
  
  
#End If  
  
#end region
```

  
The code takes a panel within which the sfSfariViewController is created. This allows me to use the panel in the in a layout.  
  
2 events are raised:  

- Safariloaded - when the webpage has finished loading.
- safarievent - When the "Done" button is pressed. This also removes the sfSafariViewController from the panel.

There doesn't seem to be an event when the viewcontroller move to another URL like WKWebview  
  
I then run Stripe in the window  
![](https://www.b4x.com/android/forum/attachments/110359)  
  
  
  
This is the minimum I had to do to get it working for my use case. Perhaps the community would like to extend.  
It's not as good as using the STRIPE API calls directly from a customer experience point of view, but you do get Apple Pay integration for free.  
  
If I get the chance, I will wrap the whole thing as an XUI Customview to remove the need for the separate panel.  
  
If you are interested in offsetting your travel, the app is now in the stores, just search for "ecolibrium"