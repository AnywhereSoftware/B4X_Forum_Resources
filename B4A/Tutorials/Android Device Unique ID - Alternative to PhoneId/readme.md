### Android Device Unique ID - Alternative to PhoneId by Erel
### 06/10/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/14759/)

**This is an old tutorial. It will not work on new versions of Android. You should either generate a random value when the app starts for the first time or use the advertising id: <https://www.b4x.com/android/forum/threads/advertising-id.101050/#content>**  
  
This tutorial is based on the following blog post: [Identifying App Installations | Android Developers Blog](http://android-developers.blogspot.com/2011/03/identifying-app-installations.html)  
  
The standard way to get a unique id is using PhoneId.GetDeviceId. However this method has several disadvantages:  
- It requires the "android.permission.READ\_PHONE\_STATE" permission which is quite a sensitive permission.  
- It doesn't work on devices without phone functionality.  
- Apparently there is a bug in some devices which return the same id.  
  
Starting from Android 2.3 there is a new field that returns a unique id and should work on all devices (without requiring any permission).  
  
A general solution is to use this field for modern devices and to use a "fake" id for older devices. The fake id is randomly created when the application first runs.  
  
Here is the code (requires the [Reflection](http://www.b4x.com/forum/additional-libraries-official-updates/6767-reflection-library.html) library):  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
   Log(GetDeviceId)  
End Sub  
  
Sub GetDeviceId As String  
   Dim r As Reflector  
   Dim Api As Int  
   Api = r.GetStaticField("android.os.Build$VERSION", "SDK_INT")  
   If Api < 9 Then  
      'Old device  
      If File.Exists(File.DirInternal, "__id") Then  
         Return File.ReadString(File.DirInternal, "__id")  
      Else  
         Dim id As Int  
         id = Rnd(0x10000000, 0x7FFFFFFF)  
         File.WriteString(File.DirInternal, "__id", id)  
         Return id  
      End If  
   Else  
      'New device  
      Return r.GetStaticField("android.os.Build", "SERIAL")  
   End If  
End Sub
```