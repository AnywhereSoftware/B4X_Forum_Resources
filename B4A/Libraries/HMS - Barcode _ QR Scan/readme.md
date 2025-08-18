### HMS - Barcode / QR Scan by Erel
### 08/11/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/133334/)

HMS v1.04 adds support for HMS Scan kit.  
  
Instructions:  
Add to manifest editor:  

```B4X
CreateResourceFromFile(Macro, hms.hms_scan)
```

  
  
Code:  

```B4X
Sub Button1_Click  
    rp.CheckAndRequest(rp.PERMISSION_CAMERA) 'rp is a global RuntimePermissions object.  
    Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)  
    If Result Then  
        Wait For (hms.StartScan) Complete (ScanResult As String)  
        Log(ScanResult)  
        ToastMessageShow("Scan result: " & ScanResult, True)  
    End If  
End Sub
```

  
Scanning happens in a separate activity. It will return an empty string if nothing was detected.  
  
<https://www.b4x.com/android/forum/threads/hms-huawei-sdk.124034/#content>