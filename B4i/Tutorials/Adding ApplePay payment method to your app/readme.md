### Adding ApplePay payment method to your app by Mr.Coder
### 12/02/2024
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/164423/)

**Hi,**  
  
**This is a tutorial explaining how to add apple pay payment method to your app.  
  
- First you need to create a merchant ID for your app and create Apple Pay Payment Processing Certificate.**  
- **Second** **you need to add apple pay payment processing to your app id.  
  
- Login to your apple developer account and go to "Certificates, Identifiers & Profiles".**  
  

---

  
  
**- Steps to create a merchant ID for your app :**  
  
![](https://www.b4x.com/android/forum/attachments/159101)  
  

---

  
  
![](https://www.b4x.com/android/forum/attachments/159102)  
  

---

  
  
**![](https://www.b4x.com/android/forum/attachments/159103)**  
  

---

  
  
**![](https://www.b4x.com/android/forum/attachments/159104)**  

---

  
  
**- Steps to create Apple Pay Payment Processing Certificate :  
  
![](https://www.b4x.com/android/forum/attachments/159105)**  
  

---

  
  
**- Here you need to create "signing request certificate", Steps to create signing request certificate for **Apple Pay Payment Processing Certificate using openssl :**  
  
- Step 1. Create ECC private key with 256 bits size command.  
  
openssl.exe ecparam -out PrivateKey.key -name prime256v1 -genkey  
  
- Step 2. Create a Certificate Signing Request command.  
  
openssl.exe req –new –sha256 –key PrivateKey.key -nodes –out ApplePay\_Processing\_Signing\_Request.csr**  
  

---

  
  
**![](https://www.b4x.com/android/forum/attachments/159106)**  
  

---

  
  
**![](https://www.b4x.com/android/forum/attachments/159107)**  
  

---

  
  
**![](https://www.b4x.com/android/forum/attachments/159108)**  
  

---

  
  
**![](https://www.b4x.com/android/forum/attachments/159109)**  
  

---

  
  
**![](https://www.b4x.com/android/forum/attachments/159111)**  

---

  
  
**- Download the Apple Pay Payment Processing Certificate and put it in your project keys folder, and put the private key and signing request certificate in somewhere secure.**  
  

---

  
  
**- Steps to **to add apple pay payment processing to your app id** :**  
  
![](https://www.b4x.com/android/forum/attachments/159122)  

---

  
  
![](https://www.b4x.com/android/forum/attachments/159123)  
  

---

  
  
![](https://www.b4x.com/android/forum/attachments/159124)  
  

---

  
  
![](https://www.b4x.com/android/forum/attachments/159125)  
  

---

  
  
![](https://www.b4x.com/android/forum/attachments/159126)  
  

---

  
  
**- Now you need to delete all previous provision profiles** **for your app and create new ones and put it all in your project keys folder.**  
  

---

  
  
**- Add this line in #Region Project Attributes in your project :  
  

```B4X
#Entitlement: <key>com.apple.developer.in-app-payments</key><array><string>merchant.com.yourcompany.yourappname</string></array>
```**  
  

---

  
  
**- Add this function and apple pay events in your project code :**  
  

```B4X
Private Sub ShowApplePayPayment  
   
    Try  
  
        Dim oMe As NativeObject = Me  
        Dim Ret As String  
                    
        Ret = oMe.RunMethod("createPaymentRequest:::", Array("Your product name or any text you want", "7.99", "merchant.com.yourcompany.yourappname")).AsString  
    
        Log("Ret=" & Ret)  
    
        Return  
    
    Catch  
    
        'Log(LastException)  
    
        Return  
    
    End Try  
   
End Sub
```

  
  

```B4X
Private Sub ApplePayPaymentInfo (Payment As Object) As String  
   
    Dim oPayment As NativeObject = Payment  
    Dim oPaymentToken As NativeObject  
    Dim oPaymentData As NativeObject  
    Dim oTransactionIdentifier As NativeObject  
    Dim PaymentDataBytes() As Byte  
   
    If oPayment.IsInitialized = False Then Return "Failed"  
   
    oPaymentToken = oPayment.GetField("token")  
   
    If oPaymentToken.IsInitialized = False Then Return "Failed"  
  
    oTransactionIdentifier = oPaymentToken.GetField("transactionIdentifier")  
  
    If oTransactionIdentifier.IsInitialized = False Then Return "Failed"  
   
    Log("TransactionIdentifier=" & oTransactionIdentifier.AsString)  
    
    oPaymentData = oPaymentToken.GetField("paymentData")  
  
    If oPaymentData.IsInitialized = False Then Return "Failed"  
   
    PaymentDataBytes = oPaymentData.NSDataToArray(oPaymentData)  
   
    Log("PaymentData=" & BytesToString(PaymentDataBytes, 0, PaymentDataBytes.Length, "UTF-8"))  
   
    Return "Success"  
   
End Sub  
  
  
Sub ApplePayPayment_Done (PaymentStatus As String)  
   
    Log("ApplePayPayment_Done=" & PaymentStatus)  
   
End Sub  
  
  
Sub ApplePayPayment_Closed  
   
    Log("ApplePayPayment_Closed")  
   
End Sub
```

  
  

```B4X
#if OBJC  
  
#import <PassKit/PassKit.h>  
  
- (NSString*)createPaymentRequest:(NSString*)itemName :(NSString*)itemAmount :(NSString*)merchantID {  
   
    NSString* iReturnValue = @"OK";  
   
    NSArray* paymentNetworks = @[PKPaymentNetworkMasterCard, PKPaymentNetworkVisa, PKPaymentNetworkQuicPay];  
   
    if ([PKPaymentAuthorizationViewController canMakePayments]) {  
    
        if ([PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:paymentNetworks]) {  
        
            NSString* iAmount = [NSString stringWithFormat:@"%.02f", itemAmount];  
  
            PKPaymentSummaryItem* paymentSummaryItem = [PKPaymentSummaryItem summaryItemWithLabel:itemName amount:[NSDecimalNumber decimalNumberWithString:itemAmount locale:NSLocale.currentLocale]];  
                                                                                  
            PKPaymentRequest* paymentRequest = [[PKPaymentRequest alloc] init];  
            paymentRequest.countryCode = @"US";  
            paymentRequest.currencyCode = @"USD";  
            paymentRequest.supportedNetworks = paymentNetworks;  
            paymentRequest.merchantIdentifier = merchantID;  
            paymentRequest.merchantCapabilities = PKMerchantCapability3DS;  
            paymentRequest.paymentSummaryItems = @[paymentSummaryItem];  
  
            PKPaymentAuthorizationViewController* paymentViewController = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:paymentRequest];  
            paymentViewController.delegate = self;  
        
            UIViewController* topRootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;  
        
            [topRootViewController presentViewController:paymentViewController animated:TRUE completion:nil];  
                
        } else {  
    
            iReturnValue = @"CardNotSupported";  
        
        }           
   
    } else {  
   
        iReturnValue = @"CannotMakePayments";  
    
    }  
   
   return iReturnValue;  
   
}  
  
  
-(void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller {  
  
    [(self._page1).object dismissViewControllerAnimated:YES completion:^{  
    
        B4I* bi = [b4i_main new].bi;  
    
        [bi raiseEvent:nil event:@"applepaypayment_closed" params:nil];  
    
    }];  
   
}  
  
  
- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus))completion {  
   
     B4I* bi = [b4i_main new].bi;  
   
     NSString* lVerified = @"Success";  
            
     NSString* verifyResult = [self _applepaypaymentinfo:payment];  
   
     //NSLog(@"%@", [payment.token description]);  
  
     if ([verifyResult isEqualToString:lVerified]) {  
         [bi raiseEvent:nil event:@"applepaypayment_done:" params:@[lVerified]];  
          completion(PKPaymentAuthorizationStatusSuccess);  
     } else {  
          [bi raiseEvent:nil event:@"applepaypayment_done:" params:@[verifyResult]];  
          completion(PKPaymentAuthorizationStatusFailure);  
     }  
   
};  
  
#End If
```

  
  

---

  
  
**And you can return "Failed" or "Success" in ApplePayPaymentInfo function to tell apple pay server if the user payment is valid or not you can also check the validity of payment data on your server and return "Failed" or "Success".  
  
- I hope this tutorial is useful to you.**