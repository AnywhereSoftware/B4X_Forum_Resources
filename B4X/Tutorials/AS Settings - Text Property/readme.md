###  AS Settings - Text Property by Alexander Stolte
### 02/14/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/159265/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/>  
  
This property is for text input. Normal text, numbers or decimal numbers.  
  
![](https://www.b4x.com/android/forum/attachments/150848)  
  
![](https://www.b4x.com/android/forum/attachments/150849)  
  
**Example**  

```B4X
'Numeric Example  
AS_Settings1.MainPage.AddProperty_Text("Advanced","PropertyName_9","Text Example","",Null,"Test",100dip,AS_Settings1.InputType_Text)  
AS_Settings1.MainPage.AddProperty_Text("Advanced","PropertyName_10","Numeric Example","",Null,24,60dip,AS_Settings1.InputType_Numeric)  
AS_Settings1.MainPage.AddProperty_Text("Advanced","PropertyName_11","Decimal Example","",Null,24.24,100dip,AS_Settings1.InputType_Decimal)
```

  
with the [ICODE]AS\_Settings1.InputType\_…[/ICODE] enumeration, you specify which format the user may enter.  

```B4X
AS_Settings1.InputType_Text  
AS_Settings1.InputType_Numeric  
AS_Settings1.InputType_Decimal
```

  
**Events**  
If the user changes the text, the **ValueChanged** event is triggered.  

```B4X
Private Sub AS_Settings1_ValueChanged(Property As AS_Settings_Property, Value As Object)  
    'Log("ValueChanged " & Property.PropertyName & ": " & Value)  
    
    Select Property.PropertyName  
        Case "PropertyName_9", "PropertyName_10", "PropertyName_11"  
            Log(Value)  
    End Select  
    
End Sub
```