### Get Actionbar Height by Blueforcer
### 04/23/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/166721/)

I needed a way for users to access the OS network settings in a “closed” HMI without being able to access other menus. Therefore I had to cover the actionbar with an own overlay. To find out the height to use, I developed the following function.  
I have not tested whether it works with a non-rooted and other devices.  
  
  

```B4X
Sub GetActionBarHeight As Int  
    Dim r As Reflector  
    Dim context As Object = r.GetContext  
    r.Target = context  
    Dim theme As Object = r.RunMethod("getTheme")  
    r.Target = theme  
  
    Dim outValue As Object  
    outValue = r.CreateObject("android.util.TypedValue")  
  
    Dim args(3) As Object  
    Dim types(3) As String  
  
    args(0) = r.GetStaticField("android.R$attr", "actionBarSize")  
    args(1) = outValue  
    args(2) = True  
  
    types(0) = "java.lang.int"  
    types(1) = "android.util.TypedValue"  
    types(2) = "java.lang.boolean"  
  
    Dim success As Boolean = r.RunMethod4("resolveAttribute", args, types)  
    If success Then  
        r.Target = context  
        Dim resources As Object = r.RunMethod("getResources")  
        r.Target = resources  
        Dim displayMetrics As Object = r.RunMethod("getDisplayMetrics")  
  
        r.Target = outValue  
        Dim data As Int = r.GetField("data")  
  
        Dim args2(2) As Object  
        Dim types2(2) As String  
        args2(0) = data  
        args2(1) = displayMetrics  
        types2(0) = "java.lang.int"  
        types2(1) = "android.util.DisplayMetrics"  
  
        Dim height As Int = r.RunStaticMethod("android.util.TypedValue", "complexToDimensionPixelSize", args2, types2)  
        Return height  
    Else  
        Log("Konnte die ActionBar-Größe nicht ermitteln")  
        Return 64dip  
    End If  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/163586)