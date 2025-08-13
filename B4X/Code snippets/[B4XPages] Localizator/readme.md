###  [B4XPages] Localizator by aeric
### 04/05/2025
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/142775/)

I can't find an example of using Localizator in B4XPages so I tried to make it work in B4XPages with a simple example.  
  
![](https://www.b4x.com/android/forum/attachments/133391) ![](https://www.b4x.com/android/forum/attachments/133392) ![](https://www.b4x.com/android/forum/attachments/133395)  
  

```B4X
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Public Loc As Localizator  
End Sub
```

  
  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    Main.Loc.Initialize(File.DirAssets, "strings.db")  
    LocalizePage ' apply Localization  
     
    B4XPage2.Initialize  
    B4XPages.AddPage("Page2", B4XPage2)  
End Sub  
  
Sub LocalizePage  
    Log("Localizing MainPage…")  
    Main.Loc.ForceLocale("zh")  
    Main.Loc.LocalizeLayout(Root)  
End Sub
```

  
  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("Page2")  
    Log("Localizing Page2…")  
    Main.Loc.LocalizeLayout(Root)  
    Label1.Text = Main.Loc.LocalizeParams(Label1.Text, Array(2))  
    B4XPages.SetTitle(Me, Label1.Text)  
End Sub
```