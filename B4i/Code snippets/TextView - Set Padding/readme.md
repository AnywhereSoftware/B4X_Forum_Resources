### TextView - Set Padding by Alexander Stolte
### 07/19/2022
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/141882/)

<https://stackoverflow.com/a/18987810>  
This brings the left edge of the text to the left edge of the container:  

```B4X
Dim no As NativeObject = tv_TextView  
no.RunMethod("textContainer",Null).SetField("lineFragmentPadding",0)
```

  
This causes the top of the text to align with the top of the container:  

```B4X
Dim no As NativeObject = tv_TextView  
no.SetField("textContainerInset",0)
```