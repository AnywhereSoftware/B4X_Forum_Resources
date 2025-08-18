###  Using Three.js / WebGL in a WebView by roumei
### 02/03/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/127277/)

This is a small B4XPages project (B4A and B4I) that shows how to use Three.js in a WebView. Three.js is a powerful JavaScript 3D library that uses WebGL and runs in all modern browsers. There's a small class plthreejs in the project that sets up a simple HTML page. After that you can add geometries. At the moment there are only a few commands but you can easily extend the class. Just have a look a the source code and check [Three.js – JavaScript 3D library](https://threejs.org/) for the documentation.  
  
![](https://www.b4x.com/android/forum/attachments/plthreejs_preview-jpg.107355/?hash=f6ef351ce07eb2b652896dfb34b45426)  

```B4X
    ' Create an instance of the plthreejs class and initializes it with the WebView/WKWebView (should be added with the Designer)  
    Dim pl As plthreejs  
    pl.Initialize(WebView)  
      
    ' Specify the options  
    pl.BackgroundColor = xui.Color_ARGB(255, 30, 30, 30)  
    pl.Filename = "index.html"  
    pl.RequestAnimationFrame = False  
      
    ' Create the basic HTML file with the above options  
    pl.PrepareHTML  
      
    ' Loads the created HTML file  
    pl.LoadHTML  
      
    #If B4A  
    Wait For WebView_PageFinished(Url As String)  
    #End If  
      
    #If B4I  
    Wait For WebView_PageFinished (Success As Boolean, Url As String)  
    #End If  
      
    ' Create a geometry and add it to the viewport  
    pl.CreateTorusKnotGeometry(10, 3, 100, 16, 2, 3, pl.MaterialType_MeshStandardMaterial, xui.Color_ARGB(255, 255, 128, 0))  
      
    ' Set the camera position  
    pl.SetCameraPosition(0, 0, 180)  
      
    ' Add a light  
    pl.AddPointLight(100, 100, 200, xui.Color_White, 2, True)  
  
    ' Render the scene  
    pl.render
```