### HTML PC>Android convertor by Jerryk
### 02/05/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/164463/)

For my application I have a Help written in HTML. The entire simple code is written in an html editor on a PC, it contains three subfolders css, img and js. However, the code written in this way does not work in the WebView component. If a css style or images are to be loaded, the links to the relevant subfolders must be modified.  
  
e.g. href="css/main.css" must be modified to href="file:///android\_asset/css%5Cmain.css",  
src="img/IMG1.png" to src="file:///android\_asset/img%5CIMG1.png" etc.  
  
That is why I wrote a tool that automates this.  
  
![](https://www.b4x.com/android/forum/attachments/159194)  
  
**Instructions:**  

- select the html file to be modified
- select the file where the result should be saved
- if you have other subfolders than css, img and js, add them according to the pattern
- press Convert
- the changed lines will appear in the list
- use #DebuggerForceStandardAssets: true

  

```B4X
WebView1.loadhtml(File.ReadString(File.DirAssets,"index.html"))
```

  
  
[Download](https://drive.google.com/file/d/10hTzN9weYCEy0NkldffbN48NBwgmvL7_/view?usp=sharing)