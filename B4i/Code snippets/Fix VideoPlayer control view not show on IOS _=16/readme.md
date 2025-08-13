### Fix VideoPlayer control view not show on IOS >=16 by tuhatinhvn
### 02/29/2024
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/159569/)

```B4X
    Dim no As NativeObject = VideoPlayer1  
    Dim controller As NativeObject = no.GetField("controller")  
    controller.RunMethod("beginAppearanceTransition:animated:",Array(True, False))
```