### MenuBar Icons on MainTitle Menu by Guenter Becker
### 09/29/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/168841/)

Hello,  
my Task was to substitute the Title Menus with an Icon or to add an Icon to the text.  
I found a good solution in the Forum as a base and modfied it to solve the task.  
  

```B4X
private Sub setMnuLabel(MenuNr As Int, Image As String)  
    Dim jo As JavaObject = MenuBar.Menus.Get(MenuNr)  
    Dim imv As ImageView  
    imv.Initialize("MnuTitle")  
    imv.SetImage(fx.LoadImageSample(File.DirAssets,Image,36,36))  
    jo.RunMethod("setGraphic",Array(imv))  
End Sub
```

  
  

```B4X
'Example 1st left Menu'  
setMnuLabel(0,"icons8-application-48.png") 'App
```

  
  
The Title Menus are numbered from left to right startet by 0 for the 1st left menu.  
  
Example: ![](https://www.b4x.com/android/forum/attachments/167420)  
  
Notice! Menu Title Menus do not throw a click event neither do them with this solution.