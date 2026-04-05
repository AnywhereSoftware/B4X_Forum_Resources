###  Show Photo_MouseClicked by T201016
### 04/01/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/170733/)

The code below is an example for single or double clicking on a view, e.g. **ImageView**.  
Pretty good code. You can be sure that clicking will execute only one selected group of code.  
  

```B4X
Sub Process_Globals | Sub Class_Globals  
    Private ClickIndex As Int  
End Sub  
  
Private Sub showPhoto_MouseClicked (EventData As MouseEvent)  
  
'    Dim tagIV As ImageView = Sender 'if required in the project, set it at the beginning!  
  
    ClickIndex = ClickIndex + 1  
    If EventData.ClickCount > 2 Then Return  
    If EventData.ClickCount = 1 Then  
        Dim MyIndex As Int = ClickIndex  
        Sleep(250) 'You need to work out the time for the correct reaction of the mouse (>=250 ms)  
        If MyIndex <> ClickIndex Then Return  
    End If  
  
    If EventData.ClickCount > 1 Then ' Double-click;  
'        Select tagIV.Tag.As(Int)  
'          Case 1  
'            showPhotoNo1.SetImage(…)  
'          Case Else  
'            showPhotoNo4.SetImage(…)  
'        End Select  
          
        … code block …  
          
    Else ' Single-click;  
      
        … code block …  
          
    End If  
      
End Sub
```

  
  
And here is the effect:  
  
![](https://www.b4x.com/android/forum/attachments/170988)![](https://www.b4x.com/android/forum/attachments/170989)  
![](https://www.b4x.com/android/forum/attachments/170990)