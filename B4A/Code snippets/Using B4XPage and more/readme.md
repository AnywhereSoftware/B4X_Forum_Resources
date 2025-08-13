### Using B4XPage and more ... by Cadenzo
### 04/24/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/163854/)

This is a try, to collect the (to me) most important samples of B4X code here. I love to develop with B4X, but I often have bigger breaks in between and really then plenty of time to go back to the basics. I hope it is also helpful to others. I need solutions that works for B4A and B4i, so [B4XPages](https://www.b4x.com/android/forum/threads/b4x-b4xpages-cross-platform-and-simple-framework-for-managing-multiple-pages.118901/) are ideal to me. Everything that is special in B4i I will describe in the iOS code snippets.  
  
In Menu "Project / Add New Module / Class Module / B4XPage" choose a name like "FrmPage1" (choose "Add module to parent folder", as it is the same file for B4i)  
In Menu "Designer / Open Designer" save the design for the new form with a name like "viewFrmPage1"  
Of course you can choose every name, but with this system you always know, what layout is for what page and you see all layouts together in the files manager.  
  

```B4X
Sub Class_Globals  
    Main.cG.Initialize 'object of "GlobalClass" for easy (global) access from every page (in Main/Process_Globals: Public cG As GlobalClass)  
  
    Root = Root1  
    Root.LoadLayout("viewFrmPage1")  
    B4XPages.SetTitle(Me, "My Page1")  
   
    'declare other B4X-Pages here  
    Public pgPage1 As FrmPage1  
    'other pages …  
  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
  
    'add other B4X-Pages here  
    pgPage1.Initialize  
    B4XPages.AddPage("pgPage1", pgPage1)  
     'other pages …  
  
End Sub  
  
  
'Navigate to page:  
B4XPages.ShowPage("pgPage1")
```

  
  
I use [my global Class](https://www.b4x.com/android/forum/threads/using-global-classes.163866/) ("cG" from "xGlobalClass") for all code and data that I want to access from every page.  
  
[Using SQLite](https://www.b4x.com/android/forum/threads/using-sqlite.163877/)  
  
[Load a List from SQLite and show it in xCustomListView](https://www.b4x.com/android/forum/threads/xcustomlistview.163859/)  
  
[Resumable Subs and some basic dialogs](https://www.b4x.com/android/forum/threads/using-b4xdialog.163871/)  
  
[Multi selection list with B4XPreferencesDialog](https://www.b4x.com/android/forum/threads/multi-selection-list-with-b4xpreferencesdialog.133295/#content)  
  
[Prevent the display from turning off](https://www.b4x.com/android/forum/threads/prevent-the-display-from-turning-off.163874/)  
  
[Managing color themes](https://www.b4x.com/android/forum/threads/managing-color-themes-with-designer-script-extensions.163896/)  
  
[Localizator with assets](https://www.b4x.com/android/forum/threads/localizator-with-assets-for-every-language-instead-of-db.166513/), [Collecting all keys for translation in Localizator](https://www.b4x.com/android/forum/threads/collecting-all-keys-for-translation-in-localizator.166512/), [Localisation with CSV-File](https://www.b4x.com/android/forum/threads/b4x-localizator-with-csv-files.114404/#post-714794),