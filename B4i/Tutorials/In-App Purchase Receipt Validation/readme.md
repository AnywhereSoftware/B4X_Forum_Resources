### In-App Purchase Receipt Validation by walterf25
### 12/27/2019
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/112505/)

Hello Everyone, after trying so many different things and different php scripts, I finally found one that seems to give me the results I was looking for.  
  
I needed a way to verify the transaction receipt from the In-app Purchases in an app i'm working on, below is what is needed in case anyone else needs to accomplish the same task.  
  
A secure server is needed in order for the receipt information to be verified with App Store. For more info you can [read this link](https://developer.apple.com/library/archive/releasenotes/General/ValidateAppStoreReceipt/Chapters/ValidateRemotely.html#//apple_ref/doc/uid/TP40010573-CH104-SW1).  
The PHP script simply takes the receipt data passed from your app and send that data over to the App Store to be verified.  
  
**Note: The PHP Function that verifies the data takes two parameters, param1=receipt data param2=Boolean to Test with Sandbox and production, for testing purposes i have harcoded the second parameter to True since i am testing using the sandbox environment, once I am done testing and ready to go into production I will change the second parameter to False, I guess you can create another variable in the script which stores the second parameter and pass it to the function.**  
  

```B4X
<?php  
  
$rece = $_GET['receipt'];  
  
verify_app_store_in_app($rece, true);  
  
function verify_app_store_in_app($receipt, $is_sandbox)  
{  
   // echo 'sandbox: ' . $is_sandbox;  
    //$sandbox should be TRUE if you want to test against itunes sandbox servers  
    if ($is_sandbox)  
        $verify_host = "ssl://sandbox.itunes.apple.com";  
    else  
        $verify_host = "ssl://buy.itunes.apple.com";  
    $receipt = base64_encode($receipt);  
    $json ='{"receipt-data" : "'.$receipt.'" }';  
    //opening socket to itunes  
    $fp = fsockopen ($verify_host, 443, $errno, $errstr, 30);  
    if (!$fp)  
    {  
        // HTTP ERROR  
        echo 'error' . $errno + ' ' . $errstr;  
        return false;  
    }  
    else  
    {  
        //iTune's request url is /verifyReceipt     
        $header = "POST /verifyReceipt HTTP/1.0\r\n";  
        $header .= "Content-Type: application/json\r\n";  
        $header .= "Content-Length: " . strlen($json) . "\r\n\r\n";  
        fputs ($fp, $header . $json);  
        $res = '';  
        while (!feof($fp))  
        {  
            $step_res = fgets ($fp, 1024);  
            $res = $res . $step_res;  
        }  
        fclose ($fp);  
        //taking the JSON response  
        $json_source = substr($res, stripos($res, "\r\n\r\n{") + 4);  
        //decoding  
        $app_store_response_map = json_decode($json_source);  
        $app_store_response_status = $app_store_response_map->{'status'};  
        if ($app_store_response_status == 0)//eithr OK or expired and needs to synch  
        {  
            //here are some fields from the json, btw.  
            $json_receipt = $app_store_response_map->{'receipt'};  
            $transaction_id = $json_receipt->{'transaction_id'};  
            $original_transaction_id = $json_receipt->{'original_transaction_id'};  
            $json_latest_receipt = $app_store_response_map->{'latest_receipt_info'};  
            echo json_encode($json_receipt);  
        }  
        else  
        {  
            echo 'response: ' . $app_store_response_status;  
            return false;  
        }  
    }  
}  
?>
```

  
  
Once your purchase transaction is done on your app, you need to retrieve the Transaction Receipt with the following code  

```B4X
Dim no As NativeObject = Product  
Dim b() As Byte = no.NSDataToArray(no.GetField("transactionReceipt"))
```

  
The product is returned from the following Sub  

```B4X
purchase_PurchaseCompleted (Success As Boolean, Product As Purchase)
```

  
  
Before continuing with your app and letting the user proceed to the purchase item/subscription etc.. you need to verify the receipt.  
You need to place the php script in your own secure server and call it from within your app, Example:  

```B4X
Private request As HttpJob  
Dim no As NativeObject = Product  
Dim b() As Byte = no.NSDataToArray(no.GetField("transactionReceipt"))  
Dim receipt As String = BytesToString(b, 0, b.Length, "UTF-8")  
Dim su As StringUtils  
receipt = su.EncodeUrl(receipt, "UTF-8")  
request.Initialize("receiptvalidation", Me)  
request.PostString("https://www.yourownserver.com/receiptvalidation.php?receipt="&receipt, "")
```

  
  
If everything was set up correctly and the receipt data is validated you will get a json response that looks similar to the following:  

```B4X
{  
    "original-purchase-date-pst" = "2019-12-23 22:39:20 America/Los_Angeles";  
    "unique-identifier" = "7d77c782a8bfa8d278b54b25af40a90173c41be4";  
    "original-transaction-id" = "1000000608447239";  
    "bvrs" = "1.0.0";  
    "transaction-id" = "1000000608914084";  
    "quantity" = "1";  
    "original-purchase-date-ms" = "1577169560000";  
    "unique-vendor-identifier" = "FA977F38-A71E-41BD-AB2C-824999B5843E";  
    "product-id" = "M1212902";  
    "item-id" = "1492747143";  
    "version-external-identifier" = "0";  
    "is-in-intro-offer-period" = "false";  
    "purchase-date-ms" = "1577327984236";  
    "purchase-date" = "2019-12-26 02:39:44 Etc/GMT";  
    "is-trial-period" = "false";  
    "original-purchase-date" = "2019-12-24 06:39:20 Etc/GMT";  
    "bid" = "genesis.a1reader";  
    "purchase-date-pst" = "2019-12-25 18:39:44 America/Los_Angeles";  
}
```

  
  
Hope this is helpful to many of you who are looking to validate in-app transaction receipts from your in-app purchases.  
  
Happy Holidays All!  
  
Walter