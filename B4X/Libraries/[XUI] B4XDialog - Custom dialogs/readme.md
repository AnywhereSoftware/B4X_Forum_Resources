###  [XUI] B4XDialog - Custom dialogs by Erel
### 12/19/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/99756/)

**Edit: B4XDialogs is part of XUI Views library. Use that instead: [[B4X] XUI Views - Cross platform views and dialogs](https://www.b4x.com/android/forum/threads/100836/#content)**  
  
B4XDialog class helps with creating cross platform custom dialogs. The dialog is made of a simple panel and it is therefore completely customizable.  
  
![](https://www.b4x.com/android/forum/attachments/74782)  
  
Simple usage (change Activity with MainForm.RootPane or Page1.RootPanel or any other panel you like):  

```B4X
Sub ShowDialog  
   Dim p As B4XView = xui.CreatePanel("")  
   p.SetLayoutAnimated(0, 0, 0, 300dip, 170dip) 'set the content size  
   p.LoadLayout("CustomLayout")  
   Dim rs As ResumableSub = Dialog.Show(Activity, p, "Ok", "", "Cancel")  
   Wait For (rs) Complete (Result As Int)  
   If Result = xui.DialogResponse_Positive Then  
       'do something  
   End If  
End Sub
```

  
  
In most cases it requires a bit more work as you also want to handle keyboard changes:  

```B4X
'B4A  
Sub ime_HeightChanged (NewHeight As Int, OldHeight As Int)  
   If Dialog.Visible Then Dialog.Resize(100%x, NewHeight)  
End Sub  
'B4i  
Sub Page1_KeyboardStateChanged (Height As Float)  
   If Dialog.Visible Then Dialog.Resize(Page1.RootPanel.Width, Page1.RootPanel.Height - Height)  
End Sub
```

  
And in B4A you can handle the back key:  

```B4X
Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event  
   If KeyCode = KeyCodes.KEYCODE_BACK And Dialog.Visible Then  
       Dialog.Close(xui.DialogResponse_Cancel)  
       Return True  
   End If  
   Return False  
End Sub
```

  
  
The attached B4A example shows how to access the default buttons and change their state based on the forms fields.