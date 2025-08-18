### Simple Combo box (with source) by incendio
### 03/03/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/127539/)

Hi guys,  
  
This is a very simple Custom View Combo box for B4A only. you can modify it to your need.  
  
![](https://www.b4x.com/android/forum/attachments/107805)  
  
**Version** : 1  
  
**Methods**  

- AddSingle(Val As String), add single item to list
- AddMulti(Val() As String), add multi item to list
- AddTwoLines(Val1 As String,Val2 As String,RetVal As String), add to line to list
- GetLv, get List View of the Combo
- Text, set or get Text of the Combo

**Event**  

- Clicked, fired when you choose an item in the combo box

**Sample Codes**  

```B4X
Sub Globals  
    Private dbYear As CustomDB  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    For y = 2017 To 2031  
        dbYear.AddSingle(y)  
    Next  
End Sub  
  
Private Sub dbYear_Clicked  
    Private year as String  
    year = dbYear.Text  
    'add you own codes'  
End Sub
```