### B4J - Menu by T201016
### 05/31/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/148235/)

Hi,  
Another way to create your own menu with an added icon and shortcut,  
Based on the contents of the "MyMenu.css" file, attached to the thread.  
  

```B4X
Private MenuBar1 As MenuBar  
  
Private Sub CreateMenu  
    MenuBar1.Menus.Clear  
    MainForm.Stylesheets.Add(File.GetUri(File.DirAssets,"MyMenu.css"))  
      
    Dim M As Menu  
    M.Initialize("File","")  
    Dim MI As MenuItem  
    MI.Initialize("New DeployData","Menu")  
    BLD_Utils.SetShortCutKey(MI,Array As String("Ctrl","N"))  
    M.MenuItems.Add(MI): MI.Image = fx.LoadImageSample(File.DirAssets, "deploynew.png",24,24)  
    Dim MI As MenuItem  
    MI.Initialize("Load DeployData","Menu")  
    BLD_Utils.SetShortCutKey(MI,Array As String("Ctrl","O"))  
    M.MenuItems.Add(MI): MI.Image = fx.LoadImageSample(File.DirAssets, "deploy.png",24,24)  
    Dim MI As MenuItem  
    MI.Initialize("Save DeployData","Menu")  
    BLD_Utils.SetShortCutKey(MI,Array As String("Ctrl","S"))  
    M.MenuItems.Add(MI): MI.Image = fx.LoadImageSample(File.DirAssets, "save.png",24,24)  
    Dim MI As MenuItem  
    MI.Initialize("Save DeployData As","Menu")  
    BLD_Utils.SetShortCutKey(MI,Array As String("Ctrl","D"))  
    M.MenuItems.Add(MI): MI.Image = fx.LoadImageSample(File.DirAssets, "saveas.png",24,24)  
    Dim MI As MenuItem  
    M.MenuItems.Add(BuildDocCV1.MenuSeparatorItem)  
    Dim MI As MenuItem  
    MI.Initialize("File Locations","Menu")  
    BLD_Utils.SetShortCutKey(MI,Array As String("Ctrl","L"))  
    M.MenuItems.Add(MI): MI.Image = fx.LoadImageSample(File.DirAssets, "location.png",24,24)  
    Dim MI As MenuItem  
    M.MenuItems.Add(BuildDocCV1.MenuSeparatorItem)  
    Dim MI As MenuItem  
    MI.Initialize("Add Folder To Zip","Menu")  
    BLD_Utils.SetShortCutKey(MI,Array As String("Ctrl","Z"))  
    M.MenuItems.Add(MI): MI.Image = fx.LoadImageSample(File.DirAssets, "folder.png",24,24)  
    Dim MI As MenuItem  
    MI.Initialize("UnZips Files","Menu")  
    BLD_Utils.SetShortCutKey(MI,Array As String("Ctrl","U"))  
    M.MenuItems.Add(MI): MI.Image = fx.LoadImageSample(File.DirAssets, "unzip.png",24,24)  
    Dim MI As MenuItem  
    M.MenuItems.Add(BuildDocCV1.MenuSeparatorItem)  
    Dim MI As MenuItem  
    MI.Initialize("Exit","Menu")  
    BLD_Utils.SetShortCutKey(MI,Array As String("Ctrl","X"))  
    M.MenuItems.Add(MI): MI.Image = fx.LoadImageSample(File.DirAssets, "exit.png",24,24)  
      
    MenuBar1.Menus.Add(M)  
      
    Dim M As Menu  
    M.Initialize("Options","")  
    Dim CMI As CheckMenuItem  
    CMI.Initialize("Logs a message","CheckMenuItem")  
    CMI.Selected = True  
    BLD_Utils.SetShortCutKey(CMI,Array As String("Ctrl","M"))  
    M.MenuItems.Add(CMI)     
  
    MenuBar1.Menus.Add(M)  
      
    Dim M As Menu  
    M.Initialize("Help","")  
    Dim MI As MenuItem  
    MI.Initialize("About B4JProject","Menu")  
    BLD_Utils.SetShortCutKey(MI,Array As String("F1"))  
    M.MenuItems.Add(MI): MI.Image = fx.LoadImageSample(File.DirAssets, "image.png",24,24)  
      
    MenuBar1.Menus.Add(M)  
End Sub  
  
'Set a shortcut key for this menu item  
'Returns the menu item  
Public Sub SetShortCutKey(MI As JavaObject,Combination() As String) As MenuItem  
    Dim KC As JavaObject  
    KC.InitializeStatic("javafx.scene.input.KeyCombination")  
    Dim KCS As String  
    For i = 0 To Combination.Length - 1  
        If i > 0 Then KCS = KCS & "+"  
        KCS = KCS & Combination(i)  
    Next  
    MI.RunMethod("setAccelerator",Array(KC.RunMethod("keyCombination",Array(KCS))))  
    Return MI  
End Sub
```