### NFCEx class - Write Ndef tags by Erel
### 01/11/2023
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/110726/)

Starting from iOS 13 it is possible to write Ndef tags.  
NFCEx adds writing support to iNFC library.  
  
Before you start with writing, make sure to follow the "reading" tutorial and get the example working: <https://www.b4x.com/android/forum/threads/nfc-reading-ndef-tags.84784/#post-536918>  
It requires some configuration.  
  
With NFCEx class the reading and writing is done inside the class. NFCEx is not built as a library. You are expected to modify Scan method.  
  
The Scan method:  

```B4X
Public Sub Scan (DialogMessage As String)  
   NFC.Scan(DialogMessage)  
   Wait For NFC_TagConnected (Success As Boolean, Tag As Object)  
   If Success Then  
       Dim no As NativeObject = NFC  
       no.RunMethod("checkStatus:", Array(Tag))  
       Wait For NFC_Status(Success As Boolean, Status As Int, Capacity As Int)  
       '1 = not supported  
       '2 = read / wrute  
       '3 = read only  
       Main.LogMsg("Status: " & Status)  
       no.RunMethod("read:", Array(Tag)) 'read previous value  
       Wait For NFC_TagRead (Success As Boolean, Messages As List)  
       If Success Then  
           ReadMessages (Messages)  
           If Status = 2 Then  
               Dim msg As Object = CreateTextNdefMessage("This is the value that will be written") '<– write new value  
               no.RunMethod("write::", Array(Tag, msg))  
               Wait For NFC_WriteComplete (Success As Boolean)  
               Main.LogMsg("Write complete: " & Success)  
           End If  
       End If  
   End If  
   NFC.StopScan  
End Sub
```

  
The steps are:  
  
1. Scan for tags.  
2. Check the connected tag state.  
3. Read and / or write.  
4. Stop scanning.  
  
  
Bytes message: <https://www.b4x.com/android/forum/threads/nfcex-class-write-ndef-tags.110726/#post-691504>  
URL message: <https://www.b4x.com/android/forum/threads/nfcex-class-write-ndef-tags.110726/#post-692860>