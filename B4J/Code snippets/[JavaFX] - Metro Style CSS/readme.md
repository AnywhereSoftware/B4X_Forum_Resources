### [JavaFX] - Metro Style CSS by Brian Michael
### 04/02/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/114932/)

Hello, I will show you how to install this Metro skin in your projects.  
It is a JavaFX css style that allows you to modify the controls, giving it a metro effect.  
  
I use JMetro CSS files from:  
  
> <https://github.com/JFXtras/jfxtras-styles/tree/master/jmetro/src/main/resources/jfxtras/styles/jmetro>

  
  
Some Issues you have to know.  
Thanks to [USER=12970]@tchart[/USER]   
  
> - There are some definitions for jfx controls that are specified under "sun.com.javafx…" these need to be relabelled to just "javafx…" (for open jdk).
> - I had to comment out any definitions with "impl.jfxtras.styles."
> - Some of the B4J controls dont seem to be defined (eg slider) so I had to remove those from the demo form

  

**[FONT=verdana]DEMO:[/FONT]**

  
  
[FONT=arial]DEFAULT B4J:[/FONT]  
  
![](https://www.b4x.com/android/forum/attachments/89964)  
  
**[FONT=arial]METRO STYLE LIGHT:  
  
![](https://www.b4x.com/android/forum/attachments/89965)  
  
METRO STYLE DARK:[/FONT]**  
  
![](https://www.b4x.com/android/forum/attachments/89966)  
  
  
**STEP 1:**  
  
Download [B4J] - METRO STYLE attach ZIP and Unzip.  
  
  
> NOTE: The screenshot lang its spanish, but are the same options.

  
  
**STEP 2:**  
  
![](https://www.b4x.com/android/forum/attachments/89967)  
  
Add a new group on Files tab.  
  
![](https://www.b4x.com/android/forum/attachments/89978)  
  
Add all CSS file of the zip file.  
  
![](https://www.b4x.com/android/forum/attachments/89970)  
  
You should have all these files added in the list.  
  
  
**STEP 3:**  
  
  
![](https://www.b4x.com/android/forum/attachments/89971)  
  
Now go to the modules tab, and right click on Main and click on Add Existing Module.  
Select the .bas file on the zip.  
  
![](https://www.b4x.com/android/forum/attachments/89972)  
  
Select "Copy to project folder" and click OK  
  
You should have this code.  
  
![](https://www.b4x.com/android/forum/attachments/89973)  
  
Now just use this code:  
  

```B4X
' For the Light style  
Metro.ApplyTheme(MainForm,"Light")
```

  
  

```B4X
' For the Dark style  
Metro.ApplyTheme(MainForm,"Dark")
```

  
  
  
I hope it will be you useful.  
Regards!