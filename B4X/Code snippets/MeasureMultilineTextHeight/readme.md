###  MeasureMultilineTextHeight by Alexander Stolte
### 05/11/2023
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/147933/)

I was looking for a way to determine the height of a textview when it has multiline text. This function now makes that possible across platforms.  
From B4J I come from this thread:  
<https://www.b4x.com/android/forum/threads/measure-multiline-text-height.84331/#content>  

```B4X
Private Sub MeasureMultilineTextHeight(xLabel As B4XView) As Double  
    #If B4J  
    'https://www.b4x.com/android/forum/threads/measure-multiline-text-height.84331/#content  
    Dim jo As JavaObject = Me  
    Return jo.RunMethod("MeasureMultilineTextHeight", Array(xLabel.Font, xLabel.Text, xLabel.Width))  
    #Else if B4A  
    Dim su As StringUtils  
    Return su.MeasureMultilineTextHeight(xLabel,xLabel.Text)  
    #Else if B4I  
    Dim tmpLabel As Label  
    tmpLabel.Initialize("")  
    tmpLabel.Font = xLabel.Font  
    tmpLabel.Width = xLabel.Width  
    tmpLabel.Text = xLabel.Text  
    tmpLabel.Multiline = True  
    tmpLabel.SizeToFit  
    Return tmpLabel.Height  
    #End IF  
End Sub  
  
#If B4J  
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
#End If
```