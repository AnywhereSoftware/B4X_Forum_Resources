### A library to create Powerpoint Presentations by jkhazraji
### 05/11/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/161060/)

This library creates powerpoint presentation files by handling a Javascript file or text set in the properties. It depends on PptxGenJS.  
Example of script to generate one-slide file with text :  

```B4X
var pptx = new PptxGenJS();  
var slide = pptx.addSlide();  
slide.addText("Hello", { x: 0.5, y: 0.7, w: 3, color: "0000FF", fontSize: 64 });  
slide.addText("World!", { x: 2.7, y: 1.0, w: 5, color: "DDDD00", fontSize: 90 });
```

  
  
This can be either saved in a file (with an extension of .js if you like) or to be set as string. The instructions of adding text, charts, images, tables and media can be found in:[here](http://gitbrent.github.io/PptxGenJS/docs/quick-start/)  
The library has the following methods and properties:  
  

- **Initialize** : to initialize the library
- **pptxDoc:**  *as a String* the script text to be set directly from the app. it is preferred to be in the $""$ format to take care of the quotation marks and apostrophes. and be easier to include variables ${….}.
- **scrFileDirName:**  *as a String* choose the path of the script file e.g., (*File.DirApp* )
- **scrFileName:** *as a String* choose the name of the script file e.g., "*JSScript.txt*"
- **PptxDirFileName:** *as a String* the path where the powerpoint file is to be saved e.g.,(*File.DirApp*) 'If the file is saved in assets dir, it will not be shown.
- **PptxFileName:** *as a String* the name of the powerpoint file e.g.,: *"demoPresentation2.pptx"*
- **showFile:** *as a boolean* whether to display the powerpoint file or not**.** If 'showFile' is set to false (default), the powerpoint file will not be shown. If you want to show the file in powerpoint, It should be installed and 'showFile' is set to true.
- **genPptx :**  The method to generate the powerpoint presentation.

  
At the time being it can be downloaded as a .jar/.xml file library used in b4j. For the b4xlib, it can be requested by PM for a donation of $25.  
An example code using the myScript.txt file (attached) is down.  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Button1 As B4XView  
    Private genpptx As pptxGen  
    
    
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
    Button1.Text="generate pptx"  
End Sub  
  
Sub Button1_Click  
  
    genpptx.Initialize  
    genpptx.scrFileDirName=File.DirApp  
    genpptx.scrFileName="myScript.txt"  
    genpptx.PptxDirFileName=File.DirApp   'If the file is saved in assets dir, it will not be shown.  
    genpptx.PptxFileName="demoPresentation2.pptx"  
    genpptx.showFile=True 'If 'showFile' is set to false, the pptx file will not be shown  
    'If you want to show the file in powerpoint, It should be installed and 'showFile' is set to true.  
    genpptx.genPptx  
End Sub
```

  
  
copy the jar/xml files to the additional libraries folder, and the myScript.txt file to Objects folder and set the *scrFileDirName* to *File.DirApp* or place it where you like.  
The app will show the powerpoint presentation after it is generated if you have Powerpoint installed on you system.