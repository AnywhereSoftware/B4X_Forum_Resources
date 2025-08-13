### [XCustomListView] Page Indicator by Brian Michael
### 01/11/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/145388/)

Hello everyone in the community, I was looking for a code that would help me indicate the pagination a CustomListView and know in which position the list was indicated.  
  
I managed to create a simple code to be able to do it.  
  
If you can improve it, please follow the thread of this post.  
  
  
  

```B4X
Private Sub xCustomListView1_ScrollChanged (Offset As Int)  
  
    Dim index As Double = Round((Offset / xCustomListView1.AsView.Width) + 1)  
    xCustomListView1.JumpToItem(index-1)  
  
End Sub  
  
Private Sub xCustomListView1_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)  
  
    LabelIndicator.Text = $"${(LastIndex+1)}/${xCustomListView1.Size}"$  
  
End Sub
```