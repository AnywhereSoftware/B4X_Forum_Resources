###  AndroidPages - B4XPages alternative with orientation support by Spavlyuk
### 04/15/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/147459/)

![](https://i.imgur.com/STS3RLE.gif)  
  
When a configuration change is performed in Android (such as an orientation change), the current activity is destroyed and recreated with the updated configuration. The obvious downside of this is the loss of state in your application. However, Android provides a few ways of [saving ui states](https://developer.android.com/topic/libraries/architecture/saving-states). AndroidPages in coordination with the included library implement ViewModel and Saved instance state.  
  
AndroidPages keeps the naming convetions of B4XPages for compatibility reasons, however, there are a few changes you need to make in existing B4A projects. Download the attatched library and extract the files in your additional libraries folder. Remove B4XPages and add AndroidPages in the libaries manager.  
  
In the manifest editor, add:  

```B4X
SetApplicationAttribute(android:theme, "@style/Theme.AppCompat.Light")
```

  
  
In your Main class, remove:  

```B4X
#SupportedOrientations: portrait
```

  
  
Add:  

```B4X
#Extends: spavlyuk.viewmodel.AppCompatActivity
```

  
  
And:  

```B4X
Private Sub Activity_SaveInstanceState(OutState As Object)  
    B4XPages.Delegate.Activity_SaveInstanceState(OutState)  
End Sub
```

  
  
These changes will allow simple views (such as EditTexts) to automatically save and restore their state. For more complex views you can use either ViewModel or Saved instance state. In short, ViewModel should be used for complex or large data structures, while Saved instance state should be used for simple data structures. You can find more details in the link above.  
  

```B4X
Sub Class_Globals  
    ' …  
    Private Model As Map  
End Sub  
  
Public Sub SetImage(Value As Object)  
    Model.Put("ImageView1", Value)  
    ImageView1.SetBitmap(Value)  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    ' …  
    Model = ViewModelProvider.Get  
  
    If Model.ContainsKey("ImageView1") Then  
        ImageView1.SetBitmap(Model.Get("ImageView1"))  
    End If  
End Sub
```

  
  

```B4X
Private Sub B4XPage_SaveInstanceState (OutState As Object)  
    OutState.As(JavaObject).RunMethod("putString", Array("AuthenticationToken", "123"))  
End Sub  
  
Private Sub B4XPage_RestoreInstanceState (SavedInstanceState As Object)  
    Dim AuthenticationToken As String = SavedInstanceState.As(JavaObject).RunMethod("getString", Array("AuthenticationToken"))  
    Log("Saved AuthenticationToken: " & AuthenticationToken)  
End Sub
```

  
  
Attached you will also find a modified ThreePagesExample where some additional changes had to be made.