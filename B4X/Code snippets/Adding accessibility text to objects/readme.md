###  Adding accessibility text to objects by Andrew (Digitwell)
### 10/11/2019
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/110397/)

Turning on the screen reader in iOS and Android will automatically read out labels and text strings, but it does not work for other items such as button which only have an image in them.  
  
To do this you need to add accessibility text.  
  
Here is a cross platform way of doing that. This works for B4i & B4A only.  
  
It seems that iOS allows accessibility text on all objects, e.g. polygons on Google Maps, whilst Android only allows it for views.  
  

```B4X
public Sub SetAccessibilityText(v As Object,text As String)  
    Try  
#if B4A  
        ' Can only set content descriptions on views  
        If (v Is View) Then  
            SetContentDescription(v,text)  
        End If  
#else if B4I  
    SetAccessbilityLabel(v,text)  
#End If  
          
    Catch  
        Log(LastException.Message)  
    End Try  
End Sub  
  
#if B4A     
private Sub SetContentDescription(v As View, Text As String) 'ignore  
    Dim r As Reflector  
    r.Target = v  
    r.RunMethod2("setContentDescription", Text, "java.lang.CharSequence")  
End Sub  
#else if B4i  
private Sub SetAccessbilityLabel(view As Object, data As String)  
    Private no As NativeObject = view  
      
    no.SetField("accessibilityLabel",data)  
End Sub  
#end if
```