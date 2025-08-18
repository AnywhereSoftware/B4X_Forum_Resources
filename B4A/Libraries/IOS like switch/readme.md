### IOS like switch by Guenter Becker
### 11/18/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/124698/)

Version: 1  
Name: **IOSswitch**  
Language: B4A  
(C): TechDoc G. Becker, Royalty free for personel and commercial use only for Froum Members.  
  
***IOSswitch*** is a custom control with designer support. I mimmicks and IOS/Apple like switch.  
  
![](https://www.b4x.com/android/forum/attachments/103202)  
  
Attached Files:  

- IOSswitch.ZIP - Example Project (B4A)
- IOSswitch.b4xlib - the library
- IOSswitchRessources.ZIP - a set of background Images

  
To use the control first check all needed referencies in the libraries tab:  

- Core
- XUI
- IOSswitch

  
2nd drop the control from the designer customview tab onto the layout and fillout the custom properties:  
  
**Custom Properties:  
ID**: The ID to identified the switch operated used only if more then one switch is on the layout. It has to be a unique String.  
**Image On**: Background Image State ON  
**Image OFF**: Background Image State OFF  
**Image Disabled**: Background Image if switch is disabled  
**Text Off**: Text in State OFF  
**Text On**: Text in State ON  
**Text Size**: Text size  
**Text color Off:** textcolor state OFF  
**Text color On:** textcolor state On  
  
3rd copy the unzipped Filed ***IOSswitchRessources.ZIP*** to the \Files Folder.  
  

```B4X
Sub IOSswitch_click (State As Boolean,ID As String)  
    Log(State & " - " & ID)  
End Sub
```

  
  
Each time the user toggles the switch the event is fired.  
  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
      
    IOSswitch7.enabled(False)  
End Sub
```