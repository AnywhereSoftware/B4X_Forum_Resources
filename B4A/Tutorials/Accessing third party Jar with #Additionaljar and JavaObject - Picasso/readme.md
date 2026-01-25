### Accessing third party Jar with #Additionaljar and JavaObject - Picasso by Erel
### 01/19/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/40904/)

The #AdditionalJar module attribute (introduced in B4A v3.80) allows us to reference external jars.  
With the help of JavaObject it is now possible to integrate third party jars without a wrapper.  
  
This solution is good for "simple" libraries. If the API is complicated with many interfaces then it will be easier to create a wrapper.  
  
As an example we will use Picasso image downloader to download images: <http://square.github.io/picasso/>  
  
![](https://www.b4x.com/android/forum/attachments/24962)  
  
The first step is to download the third party jar and put it in the additional libraries folder.  
We then use #AdditionalJar to tell the compiler to add a reference to this jar:  

```B4X
#AdditionalJar: picasso-2.2.0
```

  
Note that the jar extension is omitted. You can call #AdditionalJar multiple times if multiple jars are required.  
  
The following two subs will usually be required. They allow you to get the "context" (it will be an android.app.Activity when called from an Activity module).  
  
This code should be added to an activity or service directly.  

```B4X
Sub GetContext As JavaObject  
   Return GetBA.GetField("context")  
End Sub  
  
Sub GetBA As JavaObject  
  Dim jo As JavaObject  
  Dim cls As String = Me  
  cls = cls.SubString("class ".Length)  
  jo.InitializeStatic(cls)  
  Return jo.GetFieldJO("processBA")  
End Sub
```

  
  
![](http://www.b4x.com/basic4android/images/SS-2014-05-12_13.15.19.png)  
  
As you can see in their examples we always start by calling Picasso static method 'with'. It is more clear in the JavaDocs page: <http://square.github.io/picasso/javadoc/com/squareup/picasso/Picasso.html>  
  
This sub will call the static method:  

```B4X
Sub GetPicasso As JavaObject  
   Dim jo As JavaObject  
   'com.squareup.picasso.Picasso.with(context)  
   Return jo.InitializeStatic("com.squareup.picasso.Picasso").RunMethod("with", Array(GetContext))  
End Sub
```

  
  
Now we will implement the above Java code:  

```B4X
GetPicasso.RunMethodJO("load", Array(url)).RunMethodJO("into", Array(img1))
```

  
  
In the second example we call a more complex API:  

```B4X
'second example: Picasso.with(context).load(url).resize(50, 50).centerCrop().into(ImageView)  
GetPicasso.RunMethodJO("load", Array(url)).RunMethodJO("resize", Array(50, 50)) _  
   .RunMethodJO("centerCrop", Null).RunMethodJO("into", Array(img2))
```

  
  
The third example is more interesting. We download an image with a callback event that is raised when download completes.  
  
The first step it to create the interface. This is done with JavaObject.CreateEvent (or CreateEventFromUI).  
In this case we are implementing com.squareup.picasso.Callback: <http://square.github.io/picasso/javadoc/com/squareup/picasso/Callback.html>  

```B4X
Dim callback As Object = jo.CreateEvent("com.squareup.picasso.Callback", "Callback", Null)
```

  
The last parameter is the default return value. This value will be used if the event cannot be raised (activity is paused for example). In this case we return Null.  
The event sub:  

```B4X
Sub Callback_Event (MethodName As String, Args() As Object) As Object  
   If MethodName = "onSuccess" Then  
     ToastMessageShow("Success!!!", True)  
   Else If MethodName = "onError" Then  
     ToastMessageShow("Error downloading image.", True)  
   End If  
   Return Null  
End Sub
```

  
MethodName - The interface method name (onSuccess or onError in this case).  
Args - An array of parameters passed to this method. In this case there are no parameters.  
All this information is from Picasso JavaDocs: <http://square.github.io/picasso/javadoc/index.html?com/squareup/picasso/Callback.html>  
  
The last step is to call the method that expects the callback:  

```B4X
GetPicasso.RunMethodJO("load", Array(url)).RunMethodJO("into", Array(img1, callback))
```

  
  
As this library requires the INTERNET permission we need to manually add it to the manifest editor:  

```B4X
AddPermission(android.permission.INTERNET)
```

  
  
The complete code:  

```B4X
#Region  Project Attributes  
   #ApplicationLabel: B4A Example  
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
  
#AdditionalJar: picasso-2.2.0  
  
Sub Process_Globals  
  
End Sub  
  
Sub Globals  
   Dim img1, img2 As ImageView  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
   img1.Initialize("")  
   Activity.AddView(img1, 0, 0, 100%x, 50%y)  
   img2.Initialize("")  
   Activity.AddView(img2, 0, 50%y, 100%x, 50%y)  
   Dim url As String = "http://i.imgur.com/DvpvklR.png"  
   'first example: Picasso.with(context).load(url).into(imageView);  
   GetPicasso.RunMethodJO("load", Array(url)).RunMethodJO("into", Array(img1))  
   
   'second example: Picasso.with(context).load(url).resize(50, 50).centerCrop().into(ImageView)  
   GetPicasso.RunMethodJO("load", Array(url)).RunMethodJO("resize", Array(50, 50)) _  
     .RunMethodJO("centerCrop", Null).RunMethodJO("into", Array(img2))  
   
   'third example: download image with callback  
   Dim jo As JavaObject = GetPicasso  
   Dim callback As Object = jo.CreateEvent("com.squareup.picasso.Callback", "Callback", Null)  
   GetPicasso.RunMethodJO("load", Array(url)).RunMethodJO("into", Array(img1, callback))  
End Sub  
  
Sub Callback_Event (MethodName As String, Args() As Object) As Object  
   If MethodName = "onSuccess" Then  
     ToastMessageShow("Success!!!", True)  
   Else If MethodName = "onError" Then  
     ToastMessageShow("Error downloading image.", True)  
   End If  
   Return Null  
End Sub  
  
Sub GetPicasso As JavaObject  
   Dim jo As JavaObject  
   'com.squareup.picasso.Picasso.with(context)  
   Return jo.InitializeStatic("com.squareup.picasso.Picasso").RunMethod("with", Array(GetContext))  
End Sub  
  
Sub GetContext As JavaObject  
   Return GetBA.GetField("context")  
End Sub  
  
Sub GetBA As JavaObject  
  Dim jo As JavaObject  
  Dim cls As String = Me  
  cls = cls.SubString("class ".Length)  
  jo.InitializeStatic(cls)  
  Return jo.GetFieldJO("processBA")  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub
```

  
  
JavaObject is an internal library. v2.07 is available here: <https://www.b4x.com/android/forum/threads/updates-to-internal-libraries.59340/>