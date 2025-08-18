### Normalizing Text  (change áéőűú to aeouu) by Knoppi
### 12/13/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/136809/)

```B4X
'B4J, Library: JavaObject  
'Log( GetNormalize( "Tĥïŝ ĩš â fůňķŷ Šťŕĭńġ")) '=> This is a funky String  
Private Sub GetNormalize( StringToNormalize As String) As String  
    Dim jo As JavaObject = Me  
    Return jo.RunMethod( "javaNormalize", Array( StringToNormalize))  
End Sub  
#if Java  
import java.text.Normalizer;  
public static String javaNormalize(String s) {  
    return Normalizer.normalize(s, Normalizer.Form.NFD)  
        .replaceAll("\\p{InCombiningDiacriticalMarks}+", "");  
}  
#End If  
'
```