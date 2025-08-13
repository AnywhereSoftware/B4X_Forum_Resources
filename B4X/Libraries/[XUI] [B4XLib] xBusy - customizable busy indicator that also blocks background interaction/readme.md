###  [XUI] [B4XLib] xBusy - customizable busy indicator that also blocks background interaction. by Segga
### 10/05/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/143333/)

For use in B4A, B4J, B4i.  
Copy b4xlib file to: *\B4X Additional Libraries\B4X*.  
  
v1.01 update: xBusy.Base\_Resize now handles bitmap resizing correctly on iOS devices.  
  
Properties:  

- **BackgroundAlpha** - transparency of the overlay.
- **BackgroundImage** - Assign a custom B4XBitmap for a background image.
- **TextColor** - color of text displayed.
- **SpinnerImage** - Assign a custom B4XBitmap to the spinner.
- **TapToClose** - closes xBusy when tapped – to be used for development purposes only.

```B4X
Sub Class_Globals  
    Private Busy As xBusy  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Busy.Initialize(Root)  
End Sub  
  
Private Sub B4XPage_Resize (Width As Int, Height As Int)  
    Busy.Base_Resize(Width, Height)  
End Sub  
  
Private Sub ShowIndicatorOnly  
    Busy.Show  
        'Do stuff here (eg.Wait For/Sleep etc.)  
    Busy.Hide  
End Sub  
  
Private Sub ShowIndicatorAndText  
    Busy.ShowWithText("myText")  
        'Do stuff here (eg.Wait For/Sleep etc.)  
    Busy.Hide  
End Sub  
  
Private Sub ChangeProperties  
    Busy.BackgroundAlpha=220 'Set transparency from 0 to 255 (void if BackGroundImage is loaded)  
    Busy.BackgroundImage=xui.LoadBitmap(File.DirAssets,"filename.png") 'Load a custom background image  
    Busy.BackgroundImage=Null 'Remove background image  
    Busy.TextColor=xui.Color_White 'Set the color of the text to be displayed  
    Busy.SpinnerImage=xui.LoadBitmap(File.DirAssets,"filename.png") 'Load a custom spinner image  
End Sub  
  
Private Sub UpdateStatus  
    Busy.ShowWithText("loading data 0%")  
    For i=0 To 100  
        Busy.UpdateText($"loading data ${i}%"$)  
        Sleep(20)  
    Next  
    Busy.Hide  
End Sub
```