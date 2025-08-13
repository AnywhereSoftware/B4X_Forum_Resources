### Using OS specific code in global classes (cross platform) by Cadenzo
### 10/31/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/163867/)

This is a part of [my Code Snippets collection](https://www.b4x.com/android/forum/threads/create-and-navigate-to-b4xpage.163854/), needed in many projects.  
  
Some things (like sound recording, GPS tracking, …) works different in iOS with different libraries.  
To build cross platform projects we need to implement for that cases classes with same name and public methods, but different implementations for Android and iOS. Only this classes are not in the parent folder (which is for B4A and B4i together).  
  
For this things I like to use an class "OSspecClass" inside of my [xGlobalClass](https://www.b4x.com/android/forum/threads/using-global-classes.163866/) and define an cOS object in B4XMainPage.  
  

```B4X
Sub Class_Globals  
    Public cOS As OSspecClass 'for platform-specific things  
End Sub
```

  
  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Main.cG.Initialize  
    Main.cG.cOS.Initialize  
End Sub
```

  
  
Cases for the OSspecClass are getting the app version (in B4A with "Application"-object) or keeping the display alive (in B4A with "PhoneWakeState").  
  
  
   

```B4X
    #if B4A  
    'Code only for Android  
    #else if B4i  
    'Code only for iOS  
    #End If     
  
    'or version 2:  
    If xui.IsB4A Then  
           'Code only for Android  
    Else If xui.IsB4i Then  
           'Code only for iOS  
    End If  
    'only in version 1 the OS foreign code is ignored by compiler. (if you use classes in the other OS, that the compiler don't know)
```