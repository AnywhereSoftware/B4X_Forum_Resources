### GetSDKname by DonManfred
### 08/23/2019
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/40511/)

subname: GetSDKname  
  
description: Get the name of an SDK release  
  

```B4X
Sub GetSDKname() As String  
   Dim versions As Map  
   versions.Initialize  
   versions.Put(1,"Base")  
   versions.Put(2,"Base_1.1")  
   versions.Put(3,"Cupcake")  
   versions.Put(4,"Donut")  
   versions.Put(7,"Éclair")  
   versions.Put(8,"Froyo")  
   versions.Put(10,"Gingerbread")  
   versions.Put(11,"Honeycomb")  
   versions.Put(12,"Honeycomb")  
   versions.Put(13,"Honeycomb")  
   versions.Put(14,"Ice Cream Sandwich")  
   versions.Put(15,"Ice Cream Sandwich")  
   versions.Put(16,"Jelly Bean")  
   versions.Put(17,"Jelly Bean")  
   versions.Put(18,"Jelly Bean")  
   versions.Put(19,"KitKat")  
   versions.Put(20,"Lollipop Preview")  
   versions.Put(21,"Lollipop")  
   versions.Put(22,"Lollipop MR1")  
   versions.Put(23,"Marshmallow")  
   versions.Put(24,"Nougat")  
   versions.Put(25,"Nougat MR1")  
   versions.Put(26,"Oreo")  
   versions.Put(27,"Oreo MR1")  
   versions.Put(28,"PIE")  
   Dim p As Phone  
   Return versions.Get(p.SdkVersion)  
End Sub
```

  
  
Example:

```B4X
log("SDKname="&GetSDKname) ' SDKname=Kitkat (on my device)
```