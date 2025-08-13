###  XUI Views B4XDateTemplate amendment to autochange the year by Chris2
### 01/18/2023
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/145544/)

Just a small change to the B4XDateTemplate class that is in [XUI Views](https://www.b4x.com/android/forum/threads/b4x-xui-views-cross-platform-views-and-dialogs.100836/)  
This just makes the year change +/-1 if the month changes from Jan to Dec, or vice versa.  

```B4X
'Original  
Private Sub btnMonth_Click  
    Dim btn As B4XView = Sender  
    Dim m As Int = 12 + month - 1 + btn.Tag  
    month = (m Mod 12) + 1  
    DrawDays  
End Sub  
  
'New  
Private Sub btnMonth_Click  
    Dim btn As B4XView = Sender  
    Dim m As Int = 12 + month - 1 + btn.Tag  
    Dim oldMonth as int = month    'line added  
    month = (m Mod 12) + 1  
    If oldMonth=12 and month=1 Then year=year+1    'line added  
    If oldMonth=1 and month=12 Then year=year-1    'line added  
    DrawDays  
End Sub
```