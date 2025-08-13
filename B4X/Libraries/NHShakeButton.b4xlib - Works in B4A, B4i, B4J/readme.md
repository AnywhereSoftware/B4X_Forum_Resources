###  NHShakeButton.b4xlib - Works in B4A, B4i, B4J by hatzisn
### 10/31/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/157060/)

This library will zoom in, zoom out and shake 4 times in random directions a button. It should work also with any view since the ShakeButton sub accepts as an argument a B4XView.  
  
**(2023-10-31)** Added new implementation - now you select the effects.  
  

```B4X
Dim shb As ShakeButton  
shb.Initialize  
shb.ShakeButton(Button1, True, True)
```