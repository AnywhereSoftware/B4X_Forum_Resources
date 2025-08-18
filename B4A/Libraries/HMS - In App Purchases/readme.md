### HMS - In App Purchases by Erel
### 12/30/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/126020/)

[HMS v1.03](https://www.b4x.com/android/forum/threads/hms-huawei-sdk.124034/#content) adds support for in app purchases.  
  
There are several steps that need to be done on HUAWEI developers console, including: enable merchant service, enable IAP API and add products.  
<https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides/introduction-0000001050033062>  
There are three types of products:  
  
- Consumables: temporary purchases that can be consumed and then bought again. For example, game coins.  
- Non-consumables: permanent purchases. For example, payment to remove ads.  
- Subscription: Recurring payments.  
  
This tutorial focuses on the client code.  
  
1. Add to the manifest editor:  

```B4X
CreateResourceFromFile(Macro, hms.hms_iap)
```

  
  
2. Check if IAP is ready and supported:  

```B4X
Wait For (hms.IsIAPEnvReady) Complete (Ready As Boolean)  
If Ready Then  
…
```

  
  
**Making a purchase:**  
  
Call hms.MakePurchase. Pass the price type and the product id.  
Check the return code as demonstrated below. If it is a consumable product then consume it (you can also keep it and consume it in the future).  

```B4X
Wait For (hms.MakePurchase(hms.PRICE_TYPE_CONSUMABLE, "iap1")) Complete (PurchaseResultInfo  As JavaObject)  
    If PurchaseResultInfo.IsInitialized Then  
        Dim ReturnCode As Int = PurchaseResultInfo.RunMethod("getReturnCode", Null)  
        Select ReturnCode  
            Case 0 'ORDER_STATE_SUCCESS  
                Log("Product purchased")  
                Dim data As String = PurchaseResultInfo.RunMethod("getInAppPurchaseData", Null)  
                'you can use this string to consume the purchase if it is a consumable product:  
                Wait For (hms.ConsumePurchase(data)) Complete (Success As Boolean)  
                Log("Product consumed result: " & Success)  
            Case 60000 'ORDER_STATE_CANCEL  
                Log("order cancelled")  
            Case -1 'ORDER_STATE_FAILED  
                Log("order failed")  
            Case 60001 'ORDER_STATE_PARAM_ERROR  
                Log("parameter error")  
            Case 60051 'ORDER_PRODUCT_OWNED  
                Log("product already owned")  
            Case Else  
                Log("Error. Return code: " & ReturnCode)  
        End Select  
    End If
```

  
  
**Get owned products:**  
  
The map returned holds the products ids as keys and the "data" that can be used to consume a product as values.  
  

```B4X
Wait For (hms.ObtainOwnedPurchases(hms.PRICE_TYPE_CONSUMABLE)) Complete (OwnedProducts As Map)  
If OwnedProducts.IsInitialized Then  
    'example of consuming a previously purchased consumable product:  
    If OwnedProducts.ContainsKey("iap1") Then  
        Wait For (hms.ConsumePurchase(OwnedProducts.Get("iap1"))) Complete (Success As Boolean)  
    End If  
End If
```

  
  
**Get store products information:**  

```B4X
Wait For (hms.ObtainProductInfo(hms.PRICE_TYPE_CONSUMABLE, Array("iap1"))) Complete (ProductsInfos As List)  
If ProductsInfos.IsInitialized Then  
    For Each ProductInfo As JavaObject In ProductsInfos  
        Dim Price As String = ProductInfo.RunMethod("getPrice", Null)  
        Dim Currency As String = ProductInfo.RunMethod("getCurrency", Null)  
        Dim ProductName As String = ProductInfo.RunMethod("getProductName", Null)  
        'do something here…  
    Next  
End If
```

  
  
Note that I've tested it with a "test product".