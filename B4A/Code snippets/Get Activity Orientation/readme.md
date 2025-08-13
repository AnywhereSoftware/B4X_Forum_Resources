### Get Activity Orientation by Hamied Abou Hulaikah
### 06/19/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/148597/)

```B4X
Sub Button1_Click     
    'check javaobject library  
    Dim jo As JavaObject  
    jo.InitializeContext  
    Label1.Text=jo.RunMethod("getDeviceOrientation",Array As Object(jo.InitializeContext))  
    ' 0 = portrait  
    ' 1 = landscape left  
    ' 2 = portrait reverse  
    ' 3 = landscape right  
End Sub  
  
#if java  
      
    import android.content.Context;  
    import android.view.WindowManager;  
  
    public static int getDeviceOrientation(Context context) {  
            WindowManager windowManager = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);  
            int rotation = windowManager.getDefaultDisplay().getRotation();  
            return rotation;  
    }  
  
#End If
```