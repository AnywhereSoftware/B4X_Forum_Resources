### simple way to hide/show a TabStrip tab by toby
### 07/12/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/141712/)

If you don't need a tab temporarily, Instead of disabling it or removing it, you can simply hide it. When it's needed again, unhide it.  
  

```B4X
'visible->hidden, or hidden->visible  
Public Sub toggleTab(TabStrip1 As TabStrip, tabName As String) As Boolean  
    For Each lbl As Label In GetAllTabLabels(TabStrip1)  
        If lbl.Text=tabName Then  
            lbl.Visible= lbl.Visible=False  
            Return True  
        End If  
    Next  
    Return False 'incorrect tab name provided  
End Sub  
  
Public Sub GetAllTabLabels (tabstrip As TabStrip) As List  
    Dim jo As JavaObject = tabstrip  
    Dim r As Reflector  
    r.Target = jo.GetField("tabStrip")  
    Dim tc As Panel = r.GetField("tabsContainer")  
    Dim res As List  
    res.Initialize  
    For Each v As View In tc  
        If v Is Label Then res.Add(v)  
    Next  
    Return res  
End Sub
```