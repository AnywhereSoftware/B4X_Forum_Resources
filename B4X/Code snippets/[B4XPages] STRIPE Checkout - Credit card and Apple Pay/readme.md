###  [B4XPages] STRIPE Checkout - Credit card and Apple Pay by Andrew (Digitwell)
### 11/02/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/124141/)

Attached a project which demonstrates how to accept a STRIPE Payment within your app. It is based on the information on this page: <https://stripe.com/docs/checkout/integration-builder>  
  
On iOS it also allows the use of APPLE PAY.  
  
Unfortunately, Google Pay does not seem to work for me, not sure why. If anyone can work that out, please let me know.  
  
Please forgive the naming convention, it originally was a test for APPLE PAY, but then through the power of B4XPAGES, I realized it will work with ANDROID with only minor tweaks.  
  
It uses a Webview to display the a Standard STRIPE Checkout screen.  
  
**PREREQUISITES:**  

1. You need you own stripe keys: <https://Stripe.com>
2. replace the lines with your own keys

```B4X
#if StoreRelease  
StripeAPIKey = "pk_LIVE_XXXX"  
StripeOtherKey = "sk_LIVE_XXXX"  
  
#else  
StripeAPIKey = "pk_test_XXXX"  
StripeOtherKey = "sk_test_XXXX"  
#end if  
    #End If
```

3. If you are using the B4A code you need to put the keys in the manifest file.
4. For iOS you will need to change the Certificate and Provisionfiles

  
In a real app, you will need to setup your products, the doSession() function has a product hardcoded.  
  
You will also need to handle the Success and Cancel results.  
  

```B4X
Sub wvApple_OverrideUrl (Url As String) As Boolean  
    Log($"Override ? (${Url})"$)  
    If (Url.Contains("cancel.html")) Then  
        wvApple.Visible = False  
        xui.MsgboxAsync("Cancelling. Do something ","Hi")  
        'handle cancelling here  
    else if (Url.contains("success.html")) Then  
        wvApple.Visible = False  
        xui.MsgboxAsync("Success! Do something ","Hi")  
        'Handle success here  
    End If    
    Return False  
End Sub
```

  
  
The StripeClass is a subset of a much larger class which will handle credit card payments without a webview. Please message me if you would like to know more.  
  
  
If you use this code, please consider [donating](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=SF4HDA5CRQ8U6&currency_code=GBP),