### manipulating panels from an array by 67biscuits
### 08/27/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/171926/)

I am looking for a way to manipulate the visible status of panels by using an array (list) in order to do so.  
I have tried this but the app crashes:  

```B4X
Dim pnls As List = Array As Panel(pnlClient, pnlTime, pnlMtrl, pnlEquip, pnlTasks, pnlNotes)  
  
sub buttonPushed  
      Dim b As Button = Sender  
     Dim t As Int = b.Tag  
           Log(pnls.Size)  'puts the number 6 on the log screen  
     For x = 0 To pnls.Size - 1  
        pnls.Get(x).As (Panel).Visible = False  
    Next  
end sub
```

  
  
Any help would be appreciated