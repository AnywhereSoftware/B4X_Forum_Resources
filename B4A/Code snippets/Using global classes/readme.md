### Using global classes by Cadenzo
### 10/31/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/163866/)

This is a part of [my Code Snippets collection](https://www.b4x.com/android/forum/threads/create-and-navigate-to-b4xpage.163854/), needed in many projects.  
  
It is useful to have at least one global class in the project for all the things, you want to access and to call from every page and every class. I use an object "cG" from a class "xGlobalClass".  
In menu "Project / Add New Module / Class Module / Standard Class" give the name "xGlobalClass" and choose "Add module to parent folder".  
  

```B4X
Sub Class_Globals  
    Public s_MyGlobalString as String  
    Public i_MyVersion as Int = 12  
End Sub  
  
'Initializes the object. You can add parameters to this method if needed.  
Public Sub Initialize  
    
End Sub  
  
Public Sub MyGlobalMethod  
    
End Sub
```

  
  

```B4X
Sub Process_Globals  
    Public ActionBarHomeClicked As Boolean  
    Public cG As xGlobalClass 'global  
End Sub
```

  
  

```B4X
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Main.cG.Initialize  
End Sub
```

  
  
I also use an helper module "mH" ("Add New Module / Code Module") for all global methods that only take and return parameters without saving any value. From here I also like to access the GlobalClass, because, for example, "mH.GetVersion" is shorter than "main.cG.i\_MyVersion.  
  

```B4X
Public Sub GetVersion() as Int  
   Return Main.cG.sMyVersion  
End Sub
```

  
  
Some things needs [OS Specific code](https://www.b4x.com/android/forum/threads/using-os-specific-code-in-global-classes-cross-platform.163867/)