### From Drawable to Bitmap by GeoT
### 07/16/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/171574/)

[HEADING=2][SIZE=4]Hello everyone![/SIZE][/HEADING]  
  
Google Gemini AI gave me these two similar routines to convert a Drawable into a Bitmap, and I'd like to share them with you.  
  
They partly expand on Erel's answer in **android.graphics.drawable.Drawable to Bitmap**:  
<https://www.b4x.com/android/forum/threads/android-graphics-drawable-drawable-to-bitmap.10582/>  
  
Usage:  
  

```B4X
' Instantiate the resource loader  
    Dim xml As XmlLayoutBuilder  
    Dim itemRotate As B4AMenuItem = B4XPages.AddMenuItem(Me, "Rotate")  
    itemRotate.AddToBar = True  
    itemRotate.Bitmap = DrawableToBitmapPureB4A(xml.GetDrawable("ic_rotate_90_degrees_right_white"))
```

  
  
Before calling DrawableToBitmapPureB4A, Android detects the current device's screen density, selects the appropriate drawable resource from the corresponding resource folder (for example, drawable-xxhdpi), loads it, and automatically scales it if necessary to match the device's actual screen density.  
  
  
[HEADING=2]DrawableToBitmapPureB4A VERSION:[/HEADING]  
  

```B4X
Sub DrawableToBitmapPureB4A(Drawable As Object) As B4XBitmap  
    Dim joDrawable As JavaObject = Drawable  
  
    ' If it is already a BitmapDrawable, extract the Bitmap directly.  
    Dim className As String = joDrawable.RunMethod("getClass", Null)  
  
    If className.Contains("BitmapDrawable") Then  
        Return joDrawable.RunMethod("getBitmap", Null)  
    End If  
  
    ' If it is a VectorDrawable, draw it onto an in-memory canvas  
    ' Returns the drawable's intrinsic size for the current screen density  
    Dim width As Int = joDrawable.RunMethod("getIntrinsicWidth", Null)  
    Dim height As Int = joDrawable.RunMethod("getIntrinsicHeight", Null)  
  
    ' The code only uses the default value (100 pixels) as a safety fallback  
    ' if the loaded resource is a solid color, which mathematically has no dimensions  
    ' (a "borderless color").  
    If width <= 0 Then width = 100  
    If height <= 0 Then height = 100  
  
    ' Initialize the Android classes required to create the Bitmap.  
    Dim joBitmapClass As JavaObject  
    joBitmapClass.InitializeStatic("android.graphics.Bitmap")  
    Dim configClass As JavaObject  
    configClass.InitializeStatic("android.graphics.Bitmap$Config")  
    Dim configARGB As Object = configClass.GetField("ARGB_8888")  
  
    ' Create a mutable Bitmap.  
    Dim bmp As JavaObject = joBitmapClass.RunMethod("createBitmap", Array(width, height, configARGB))  
  
    ' Create the Android Canvas associated with that Bitmap.  
    Dim joCanvas As JavaObject  
  
    joCanvas.InitializeNewInstance("android.graphics.Canvas", Array(bmp))  
  
    ' Draw the Drawable.  
    joDrawable.RunMethod("setBounds", Array(0, 0, width, height))  
    joDrawable.RunMethod("draw", Array(joCanvas))  
  
    Return bmp  
End Sub
```

  
  

---

  
[HEADING=2]DrawableToBitmap Java VERSION:[/HEADING]  
  
Example of use:  
  

```B4X
' Instantiate the resource loader.  
Dim xml As XmlLayoutBuilder  
Dim drawable As Object = xml.GetDrawable("ic_delete_white_24") ' Returns a Drawable  
  
' Use JavaObject to execute the conversion function.  
Dim jo As JavaObject = Me  
Dim bmpNative As Object = jo.RunMethod("drawableToBitmap", Array(drawable))  
  
' Assign it to a B4XBitmap (so it can be used with any view or class).  
Dim myBitmap As B4XBitmap = bmpNative
```

  
  

```B4X
#If Java  
import android.graphics.Bitmap;  
import android.graphics.Canvas;  
import android.graphics.drawable.Drawable;  
import android.graphics.drawable.BitmapDrawable;  
  
public Bitmap drawableToBitmap(Drawable drawable) {  
    if (drawable instanceof BitmapDrawable) {  
        return ((BitmapDrawable)drawable).getBitmap();  
    }  
  
    // If it is a VectorDrawable (XML) or another drawable type,  
    // draw it onto a Bitmap-backed Canvas.  
    int width = drawable.getIntrinsicWidth();  
    int height = drawable.getIntrinsicHeight();  
  
    // If the drawable has no physical dimensions (for example, a solid color),  
    // assign a default base size.  
    if (width <= 0) width = 100;  
    if (height <= 0) height = 100;  
  
    Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);  
    Canvas canvas = new Canvas(bitmap);  
    drawable.setBounds(0, 0, canvas.getWidth(), canvas.getHeight());  
    drawable.draw(canvas);  
  
    return bitmap;  
}  
#End If
```