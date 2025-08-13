### Draw on top of other apps permission by Erel
### 09/05/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/90513/)

Starting from Android 6 a special permission is required if you want to use the SYSTEM\_ALERT\_WINDOW permission. This permission is not related to the runtime permissions.  
  
You can put this code in a class to check whether your app has permission and open the settings page if needed:  

```B4X
Sub Class_Globals  
   Private ion As Object  
   Private phone As Phone  
End Sub  
  
Public Sub Initialize  
End Sub  
  
Public Sub GetPermission As ResumableSub  
   If phone.SdkVersion >= 23 Then  
       Dim settings As JavaObject  
       settings.InitializeStatic("android.provider.Settings")  
       Dim ctxt As JavaObject  
       ctxt.InitializeContext  
       If settings.RunMethod("canDrawOverlays", Array(ctxt)) = True Then  
           Return True  
       End If  
       Dim i As Intent  
       i.Initialize("android.settings.action.MANAGE_OVERLAY_PERMISSION", "package:" & Application.PackageName)  
       StartActivityForResult(i)  
       Wait For ion_Event (MethodName As String, Args() As Object)  
       Return settings.RunMethod("canDrawOverlays", Array(ctxt))  
   Else  
       Return True  
   End If  
End Sub  
  
Private Sub StartActivityForResult(i As Intent)  
   Dim jo As JavaObject = GetBA  
   ion = jo.CreateEvent("anywheresoftware.b4a.IOnActivityResult", "ion", Null)  
   jo.RunMethod("startActivityForResult", Array As Object(ion, i))  
End Sub  
  
Private Sub GetBA As Object  
   Dim jo As JavaObject = Me  
   Return jo.RunMethod("getBA", Null)  
End Sub
```

  
  
It is an example of how to use StartActivityForResult in a class.  
Note that in this case there isn't any result. We just use it to know when the user clicked on the back button.  
  
Usage example:  

```B4X
Sub Button1_Click  
   Dim c As RequestDrawOverPermission 'this is the name of the class  
   c.Initialize  
   Wait For (c.GetPermission) Complete (Success As Boolean)  
   Log("Permission: " & Success)  
End Sub
```

  
  
And you should add the permission to the manifest editor:  

```B4X
AddPermission(android.permission.SYSTEM_ALERT_WINDOW)
```

  
  
Depends on: JavaObject and Phone libraries.