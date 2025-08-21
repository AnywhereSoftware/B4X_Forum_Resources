### Measure Multiline Text Height by Erel
### 06/11/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/84331/)

Measuring the length of multiline text is simple in B4A with StringUtils.MeasureMultilineTextHeight and in B4i by setting the width of a multiline Label and calling SizeToFit.  
  
There is no similar method available in B4J. One option is to add a label to an AnchorPane and wait for the layout to be set: <https://www.b4x.com/android/forum/threads/measure-text.45750/#post-311358>  
  
Another option is to call a non-public API with the following code:  

```B4X
Sub MeasureMultilineTextHeight (Font As Font, Width As Double, Text As String) As Double  
   Dim jo As JavaObject = Me  
   Return jo.RunMethod("MeasureMultilineTextHeight", Array(Font, Text, Width))  
End Sub  
  
#if Java  
import java.lang.reflect.InvocationTargetException;  
import java.lang.reflect.Method;  
import javafx.scene.text.Font;  
import javafx.scene.text.TextBoundsType;  
public static double MeasureMultilineTextHeight(Font f, String text, double width) throws Exception {  
  Method m = Class.forName("com.sun.javafx.scene.control.skin.Utils").getDeclaredMethod("computeTextHeight",  
  Font.class, String.class, double.class, TextBoundsType.class);  
  m.setAccessible(true);  
  return (Double)m.invoke(null, f, text, width, TextBoundsType.LOGICAL_VERTICAL_CENTER);  
  }  
#End If
```

  
  
Usage example:  

```B4X
Dim height As Double = MeasureMultilineTextHeight(fx.DefaultFont(20), 100, $" jskldf jslkd fjlk wel;fk we;lfk we;lf k  
erg  
erg  
erg  
er  
gsdfj lksdf jlksd fjlksd f"$)  
Log(height)
```

  
  
Note that if you want to add it to a class then you need to remove the 'static' modifier from the Java code.  
  
As this is a non-public API it might change in the future. It does work with Java 8 and Java 9 so it is probably quite safe to use.