###  View names from Views and vice versa. by William Lancee
### 07/28/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/132960/)

I recently had this requirement. Using a simple trick with Smart Strings, it is quick to Map a name to a View and vice versa.  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private Button1, Button2, Button3, Button4, Button5, Button6 As B4XView  
    Private Label1, Label2 , Label3, Label4, Label5, Label6 As B4XView  
    Private ProgressBar1, ProgressBar2, ProgressBar3, ProgressBar4, ProgressBar5, ProgressBar6 As B4XView  
    Private ViewFromName, NameFromView As B4XOrderedMap        'This preserves order cross-platform - include B4XCollection library  
End Sub  
  
Public Sub Initialize  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    Dim allViews() As Object = Array(Button1, Button2, Button3, Button4, Button5, Button6, _  
                                    Label1, Label2 , Label3, Label4, Label5, Label6, _  
                                    ProgressBar1, ProgressBar2, ProgressBar3, ProgressBar4, ProgressBar5, ProgressBar6)  
  
    'Copy lines 4 to 6 into smart string   
    Dim viewNames As String = $"  
    Private Button1, Button2, Button3, Button4, Button5, Button6 As B4XView  
    Private Label1, Label2 , Label3, Label4, Label5, Label6 As B4XView  
    Private ProgressBar1, ProgressBar2, ProgressBar3, ProgressBar4, ProgressBar5, ProgressBar6 As B4XView  
    "$  
    mapViewNames(allViews, viewNames)  
    For Each viewName As String In ViewFromName.Keys  
        Dim view As Object = ViewFromName.Get(viewName)  
        If view Is ProgressBar Then  
            Log(viewName & TAB & "ProgressBar has no text")  
        Else  
            Log(viewName & TAB & view.As(B4XView).Text)  
        End If  
    Next  
End Sub  
  
Private Sub mapViewNames(views() As Object, viewNames As String)  
    ViewFromName.Initialize  
    NameFromView.Initialize  
    Dim s As String = viewNames.Replace(TAB,"").Replace(CRLF, ",").Replace("Private", "").Replace("As B4XView","").Replace(" ", "")  
    Dim v() As String = Regex.Split(",", s)  
    Dim k As Int  
    For i = 0 To v.Length - 1  
        If v(i).Length > 0 Then  
            ViewFromName.Put(v(i), views(k))  
            NameFromView.Put(views(k), v(i))  
            k = k + 1  
        End If  
    Next  
End Sub  
  
Private Sub Button1_Click  
    Log(NameFromView.Get(Sender))  
    xui.MsgboxAsync("Hello world!", "B4X")  
End Sub
```