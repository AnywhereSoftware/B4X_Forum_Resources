### Barbutton events by bobbruns
### 09/08/2021
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/134091/)

Just a reminder that the event caused by pressing the iphone barbuttons using B4Xpages is now:  

```B4X
Private Sub B4XPage_MenuClick (Tag As String)  
    Log(Tag)  
End Sub
```

  
The old way:  

```B4X
Private Sub BarButton_Click  
    Dim b As Button = Sender  
    Log("Toolbar Click Tag = " & b.Tag)  
End Sub
```

  
no longer works.  
  
The old way is shown on many posts in the forum. The Documentation for this in B4xPages is correct, but does not contain examples I could find.  
  
Side note: This forum is great, I find a lot of good stuff here.