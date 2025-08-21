### [custom view] GifViewer by Erel
### 06/02/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/82104/)

**Better implementation: <https://www.b4x.com/android/forum/threads/b4x-b4xgifview-cross-platform-animated-gif-view.118550/>**  
  
![](https://www.b4x.com/basic4android/images/SS-2017-07-26_17.24.05.png)  
  
Simple view that shows an animated gif. Based on agraham's GifDecoder library.  
  
The animated gifs included in this example are from giphy.com. I'm not sure whether they can be used commercially or not.  
  
Tip: B4J ImageView supports animated gifs.  
  
V1.20 - Images are cached once loaded. You need to add the following variable to the Main module:  

```B4X
Sub Process_Globals  
   Public GifsCache As Map  
End Sub
```