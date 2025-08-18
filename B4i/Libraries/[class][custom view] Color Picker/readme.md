### [class][custom view] Color Picker by Erel
### 02/07/2021
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/76118/)

**Don't use. Nicer picker in XUI Views.**  
  
![](https://www.b4x.com/basic4android/images/SS-2017-02-12_17.54.44.png)  
  
Wrapper for: <https://github.com/johankasperi/SwiftHSVColorPicker>  
  
It is implemented as a custom view. The native library is accessed with NativeObject.  
  
You need to add these two lines to the main module:  

```B4X
#AdditionalLib: ColorPicker.framework.swift.3  
#MinVersion: 8
```

  
  
Note that the color picker is not resizable. The size will be set based on the custom view initial size.  
  
If you are using a local Mac then you need to download and copy the framework to the Mac Libs folder.  
Xcode 9 Swift framework is attached.  
Xcode 10: [www.b4x.com/b4i/files/Xcode10SwiftFrameworks.zip](https://www.b4x.com/b4i/files/Xcode10SwiftFrameworks.zip)