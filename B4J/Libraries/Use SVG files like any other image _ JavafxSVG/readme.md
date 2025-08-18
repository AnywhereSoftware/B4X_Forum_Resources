### Use SVG files like any other image : JavafxSVG by stevel05
### 12/19/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/127667/)

WARNING: This lib uses an old version of Log4j - see this post: <https://www.b4x.com/android/forum/threads/log4j-problem-are-we-interested-in-it-too.136898/post-866187>  
It doesn't appear to work with later versions, so for now, use at your own risk until a solution is found.  
  
  
I'm not quite sure how I have missed this library for so long, but I stumbled across it yesterday. I won't say it's a wrap of the javafxSVG github library as I only had to write 9 lines of code, it's more of an interface. Anyway, the github project can be found [here](https://github.com/codecentric/javafxsvg) and there is an interesting blog post [here](https://blog.codecentric.de/en/2015/03/adding-custom-image-renderer-javafx-8). The blog states that the project uses a non public API, I can't find any information about it but it is still available in Java 14 I just tested it.  
  
You need to download some additional jars, which I have zipped and uploaded to my Dropbox, Get them [here](https://www.dropbox.com/s/pow6oasic70av9y/javafxSVG.zip?dl=0) and unzip the file into your B4j Additional libraries folder. It will create a subfolder called javafxSVG, leave the additional jars in there.  
  
The library creates a java Image loader instance that allows SVG files to be loaded into an Imageview (including B4xImageView) and anywhere else you would use images. Even in the designer, you just have to override the file extension in the file open dialog.  
  
As in the example app, the SVGImageLoaderFactory class should be declared and initialized as soon as possible, so right at the top of Appstart is a good place. And that is all that is needed.  
  

```B4X
Sub AppStart (Form1 As Form, Args() As String)  
    Dim SVG As SVGImageLoaderFactory  
    SVG.Initialize(False)  
  
    .  
    .  
    .
```

  
  
The TrySizeFromFile option in the initialize call is added for completeness, but if the file does not specify a size, nothing is shown so use with cautiion.  
  
The example app is just to prove it works, you only really need to download the B4xlib or the .bas file. There may be an issue with some SVG files if they have space or comments at the head of the file. See the blog post for more info.  
  

![](https://www.b4x.com/android/forum/attachments/108027)  
  
An SVG in an B4xImageview, and added to a button from the designer.

  
  
For java 11 & 14 you need an additional line in the Main module before Process\_Globals:  

```B4X
#VirtualMachineArgs: –add-opens javafx.graphics/com.sun.javafx.iio.common=ALL-UNNAMED –add-opens javafx.graphics/com.sun.javafx.iio=ALL-UNNAMED
```

  
  
The example app has been updated with this line.  
  
  
**B4jPackager**  
  
To create a package with the integrated packager you need to add the VMArgs as a PackagerProperty:  
  

```B4X
#PackagerProperty: VMArgs = –add-opens javafx.graphics/com.sun.javafx.iio.common=b4j –add-opens javafx.graphics/com.sun.javafx.iio=b4j
```

  
  
NOTE: these are slightly different to the #VirtualMachineArgs as the target module needs to be specified for the packager, which is b4j instead of ALL-UNNAMED.  
  
  
I've added some conditional compilation configurations to the example to manage the switching of the parameters. If you want to use them, you will need to provide the paths to your java javac.exe for each version, if not just comment or delete them and manage the required parameters yourself.  
  
  
  
  
Dependencies:  

- JavaObject
- XUI Views
- Additional jars, download link is above.

**Update:** I thought I should add a B4xlib as well.  
  
Let me know how you get on with it.