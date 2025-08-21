### displayMessage & Tray App Icon by tchart
### 11/06/2019
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/111141/)

You can use displayMessage to show a task bar message as per below  
  

```B4X
Dim jo As JavaObject = icon1  
        jo.RunMethod("displayMessage",Array As Object("Success", "Changes pushed successfully", "INFO"))
```

  
  
However as you'll see below it says "OpenJDK Platform Binary" which is a bit unhelpful.  
  
![](https://www.b4x.com/android/forum/attachments/85244)  
  
I found on Stack Overflow (<https://stackoverflow.com/a/47851505>) that if you set the icon to "NONE" then it will use your tray icon and not show the OpenJDK text.  
![](https://www.b4x.com/android/forum/attachments/85243)  
  

```B4X
Dim jo As JavaObject = icon1  
    jo.RunMethod("displayMessage",Array As Object("Success", "Changes pushed successfully", "NONE"))
```