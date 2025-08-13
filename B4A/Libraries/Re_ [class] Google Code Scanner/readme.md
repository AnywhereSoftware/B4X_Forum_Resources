### Re: [class] Google Code Scanner by drgottjr
### 04/25/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/160771/)

i modified erel's recent Google Code Scanner class  
<https://www.b4x.com/android/forum/threads/class-google-code-scanner-no-permission-very-simple-to-use-barcode-scanning.160725/>  
  
it includes the barcode type detected, which may be of interest if multiple formats have been enabled. the result returned to b4xmainpage includes the type.  
  
replace or modify the original class (in situ) and replace the button1\_click sub in b4xmainpage with this:  
  

```B4X
    Dim formats As List = Array(Scanner.FORMAT_ALL_FORMATS) 'For better performance pass the specific formats needed.  
    Wait For (Scanner.Scan(formats)) Complete (Result As ScannerResult)  
    If Result.Success Then  
        MsgboxAsync(Result.format & ": " & Result.Value, "Your scan:")  
        wait for msgbox_result(res As Int)  
    End If
```

  
  
class is attached.