### GetSDKVersion by DonManfred
### 08/23/2019
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/40510/)

subname: GetSDKVersion  
  
Description: Returns the SDK-Version of the device running this code  
  

```B4X
Sub GetSDKversion() As String  
   Dim versions As Map  
   versions.Initialize  
   versions.Put(3,"1.5")  
   versions.Put(4,"1.6")  
   versions.Put(7,"2.1")  
   versions.Put(8,"2.2")  
   versions.Put(10,"2.3.3")  
   versions.Put(11,"3.0")  
   versions.Put(12,"3.1")  
   versions.Put(13,"3.2")  
   versions.Put(14,"4.0")  
   versions.Put(15,"4.0.3")  
   versions.Put(16,"4.1.2")  
   versions.Put(17,"4.2.2")  
   versions.Put(18,"4.3")  
   versions.Put(19,"4.4.2")  
   versions.Put(20,"5.0p")  
   versions.Put(21,"5.0")  
   versions.Put(22,"5.1")  
   versions.Put(23,"6.0")  
   versions.Put(24,"7.0")  
   versions.Put(25,"7.1")  
   versions.Put(26,"8.0")  
   versions.Put(27,"8.1")  
   versions.Put(28,"9.0")  
   Dim p As Phone  
   Return versions.Get(p.SdkVersion)  
End Sub
```

  
  
Tags: SDK, SDKVersion  
  
Example  

```B4X
Log("SDKversion="&GetSDKversion) ' SDKversion=4.4.2 (on my Phone)
```