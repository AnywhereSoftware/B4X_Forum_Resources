### rURL - UrlEncode and UrlDecode by hatzisn
### 09/25/2021
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/134410/)

This library was developed by [USER=1]@Erel[/USER] and me. He lead the way (as always) and I followed. It allows you to UrlEncode and UrlDecode strings in order to use them in URLs. Here is how to use it:  
  

```B4X
    Dim sToURLEncode As String = "Αυτή είναι μία πρόταση στα Ελληνικά. Για να δούμε πόσο καλά θα την κωδικοποιήσει"  
    Dim bEnc(sToURLEncode.Length * 3) As Byte  
    URL.Encode(sToURLEncode, bEnc)  
    Log(bEnc)  
    Dim bDec(sToURLEncode.Length * 3) As Byte  
    URL.Decode(bEnc, bDec)  
    Log(bDec)
```