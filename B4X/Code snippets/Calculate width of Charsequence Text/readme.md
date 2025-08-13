###   Calculate width of Charsequence Text by epiCode
### 01/26/2023
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/145730/)

Calculate width of Charsequence Text  
Uses Java Function measureText(charSequence , int Start, int End)  
  

```B4X
' textSize is default textsize of label where charsequence is displayed  
Sub getWidthofCS(cx As Object,textSize As Float) As Float  
    Dim jo As JavaObject = Me  
    Return jo.RunMethod("measureCharSequence", Array(cx,textSize))  
End Sub  
      
#if JAVA  
import android.graphics.Paint;  
  
public static float measureCharSequence(CharSequence cs, float fsize) {  
    Paint paint = new Paint();  
    paint.setTextSize(fsize); // set the text size  
    return paint.measureText(cs, 0, cs.length());  
}  
#End If
```