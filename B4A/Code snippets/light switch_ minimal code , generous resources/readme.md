### light switch: minimal code , generous resources by jkhazraji
### 11/16/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/157428/)

With less than 25 lines of code, a light switch transition effect is shown:  
![](https://www.b4x.com/android/forum/attachments/147808)  
Edit: A video demo link: [video](https://mydrawer.000webhostapp.com/lightswitch.mp4)  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: Light Switch  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    '  
End Sub  
  
Sub Globals  
    Private x As XmlLayoutBuilder  
    Private tButton As B4XView  
    Dim tButtonJO As JavaObject  
    Private image As B4XView  
    Dim imageJO As JavaObject  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    x.LoadXmlLayout(Activity, "main")  
    image=x.GetView("image")  
    tButton=x.GetView("button")  
    Dim event As Object = tButton.As(JavaObject).CreateEventFromUI("android.view.View.OnClickListener","toggleBulb",Null)  
    tButton.As(JavaObject).RunMethod("setOnClickListener",Array(event))  
End Sub  
  
Private Sub toggleBulb_Event(MethodName As String, Args() As Object)  
    Dim drawable As JavaObject=(Me).As(JavaObject).InitializeStatic("android.graphics.drawable.TransitionDrawable")  
    imageJO=image.As(JavaObject)  
    drawable=imageJO.RunMethod("getDrawable",Null)  
    tButtonJO = tButton.As(JavaObject)  
    If tButtonJO.RunMethod("isChecked",Null) = True Then  
        drawable.RunMethod("startTransition",Array(1000))  
    Else  
        drawable.RunMethod("reverseTransition",Array(1000))  
    End If  
End Sub
```

  
You have to make sure that all resources are included: