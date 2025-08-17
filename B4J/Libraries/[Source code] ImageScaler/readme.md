### [Source code] ImageScaler by aeric
### 02/24/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/144818/)

**Introduction:**  
I don't know if there is any library exist to resize image in B4J non-UI app.  
I thought such library will be useful to process images for web server in building REST API for e-commerce or e-learning web apps.  
I found [an example on web](https://www.baeldung.com/java-resize-image) and chose the third method, from an old project call [**ImgScalr**](https://github.com/rkalla/imgscalr).  
I done some experiments and manage to get it work in B4J using Inline Java.  
Then I tried to compile the project as a library. boop! Done. It is so easy and I have my .jar and .xml files ready to use.  
  
**Supported file types:**  

- JPG
- JPEG
- PNG
- BMP
- WBMP

*Note: GIF is not supported*  
  
**Additional Jar:** [**imgscalr-lib-4.2.jar**](https://mvnrepository.com/artifact/org.imgscalr/imgscalr-lib/4.2)  
  

---

  
  
**ImageScaler  
Author:** Aeric Poon  
**Version:** 1.00  

- **ImageScaler**

- **Functions:**

- **Initialize** As String
- **IsInitialized** As Boolean
- **Resizeimage** (InputDir As String, OutputDir As String, Filename As String, Width As Int, Height As Int, Mode As String) As String
**Mode:** AUTOMATIC, FIT\_EXACT, FIT\_TO\_HEIGHT and FIT\_TO\_WIDTH
Reference: [<https://www.baeldung.com/java-resize-image>](https://www.baeldung.com/java-resize-image)
Example: Private img As ImageScaler
img.Initialize
img.ResizeImage(File.DirApp, File.DirApp, "sonic.jpg", 200, 200, "AUTOMATIC")