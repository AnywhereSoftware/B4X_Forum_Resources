### [PyBridge] pyvips - image manipulation library by Erel
### 03/19/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/166206/)

[pyvips](https://github.com/libvips/pyvips) is a very powerful image manipulation library. It can manipulate very large images. I've created a modified "[HugeImageView](https://www.b4x.com/android/forum/threads/b4x-hugeimageview-show-very-large-images.132905/#content)" based on it as an example. It can show 1-2 GB images. These are images that need special handling to draw, as the full image can't be loaded into RAM.  
  
It depends on an external library - libvips. Download and extract: <https://github.com/libvips/build-win64-mxe/releases/download/v8.16.1/vips-dev-w64-all-8.16.1.zip>  
  
The path to libvips should be added to the PATH environment variable:  

```B4X
Dim opt As PyOptions = Py.CreateOptions("Python/python/python.exe")  
Dim PathToVips As String = "C:\Users\H\Downloads\projects\vips-dev-8.16\bin" '<—-  
opt.EnvironmentVars.Put("PATH", opt.EnvironmentVars.Get("PATH") & ";" & PathToVips)
```

  
  
Note that on the first run a scaled down image is created. This takes some time. The image is saved. On the next run the first zoom step will also be a bit slow as it needs to build its internal cache.  
  
![](https://www.b4x.com/android/forum/attachments/162768)