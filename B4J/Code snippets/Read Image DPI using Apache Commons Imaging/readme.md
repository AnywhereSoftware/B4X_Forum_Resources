### Read Image DPI using Apache Commons Imaging by xulihang
### 01/02/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/137270/)

As discussed in [this question](https://www.b4x.com/android/forum/threads/save-images-in-300-dpi.137269/), I need to rescale an image if its DPI is not 300.  
  
I found it is possible to use the Apache Commons Imaging library.  
  
I've made a thin wrapper for this.  
  
ApacheImageImaging.bas:  
  

```B4X
Sub Class_Globals  
    Private imaging As JavaObject  
End Sub  
  
'Initializes the object. You can add parameters to this method if needed.  
Public Sub Initialize  
    imaging.InitializeStatic("org.apache.commons.imaging.Imaging")  
End Sub  
  
Public Sub getImageInfo(path As String) As ApacheImageInfo  
    Dim f As JavaObject  
    f.InitializeNewInstance("java.io.File",Array(path))  
    Dim imageInfo As JavaObject = imaging.RunMethod("getImageInfo",Array(f))  
    Dim imageInfoWrapper As ApacheImageInfo  
    imageInfoWrapper.Initialize(imageInfo)  
    Return imageInfoWrapper  
End Sub
```

  
  
ApacheImageInfo.bas:  
  

```B4X
Sub Class_Globals  
    Private mInfo As JavaObject  
End Sub  
  
'Initializes the object. You can add parameters to this method if needed.  
Public Sub Initialize(info As JavaObject)  
    mInfo = info  
End Sub  
  
Public Sub getPhysicalHeightDpi As Int  
    Return mInfo.RunMethod("getPhysicalHeightDpi",Null)  
End Sub  
  
Public Sub     getPhysicalWidthDpi As Int  
    Return mInfo.RunMethod("getPhysicalWidthDpi",Null)  
End Sub
```

  
  
Usage:  
  

```B4X
#AdditionalJar: commons-imaging-1.0-alpha2  
  
Dim imaging As ApacheImaging  
imaging.Initialize  
Dim info  As ApacheImageInfo = imaging.getImageInfo(File.Combine(File.DirApp,"test.jpg"))  
Log(info.PhysicalHeightDpi)  
Log(info.PhysicalWidthDpi)
```