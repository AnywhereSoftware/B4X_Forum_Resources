### [B4J TextArea] Select the text - coordinates for the cursor by T201016
### 10/18/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/169077/)

You can select the text as you know in several ways, but the cursor will change position depending on the selected method of selection.   
My source code is included in the calculations.   
  
*I am providing an example for those who need a proven method.*  
  
![](https://www.b4x.com/android/forum/attachments/167908) ![](https://www.b4x.com/android/forum/attachments/167909)   
![](https://www.b4x.com/android/forum/attachments/167910) ![](https://www.b4x.com/android/forum/attachments/167911)  
  

```B4X
Sub Process_Globals  
…  
    Type MyTypeItems1 (ItemsStart(1) As Int, ItemsEnd(2) As Int, ItemsEquals As Boolean)  
    Type MyTypeItems2 (the_start, the_end, line, column, the_select As Int, the_length, the_str As String, the_isselect As Boolean)  
    Dim caretPosition As MyTypeItems1  
    Dim itemsPosition As MyTypeItems2  
      
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
…  
    caretPosition.Initialize  
    caretPosition.ItemsEquals = False  
      
End Sub  
  
  
#Region Code: Selection words (remove space)  
Private Sub TextArea_MouseClicked (EventData As MouseEvent)  
    Dim tta As TextArea = Sender  
      
    If EventData.ClickCount = 1 Then  
        caretPosition.Initialize  
        caretPosition.ItemsEquals = False  
    End If  
  
    If EventData.PrimaryButtonPressed And EventData.ClickCount > 1 Then  
        If tta.SelectionStart >= tta.SelectionEnd Then Return  
        Dim SelectedText As String = tta.Text.SubString2(tta.SelectionStart,tta.SelectionEnd)  
        If SelectedText.CharAt(SelectedText.Length - 1) = " " Then  
            tta.SetSelection(tta.SelectionStart, tta.SelectionEnd - 1)  
        End If  
    End If  
End Sub  
  
Private Sub TextArea_FocusChanged (HasFocus As Boolean)  
    coordonate.Visible = HasFocus  
    coordonate.Text = ""  
End Sub  
  
Sub SelectionChanged_Event (MethodName As String, Args() As Object) As Object  
    If MethodName = "changed" Then  
        Dim IndexRange As JavaObject = Args(2)  
        Dim StartPosition As Int = IndexRange.RunMethod("getStart", Null)  
        Dim EndPosition As Int = IndexRange.RunMethod("getEnd", Null)  
          
        Dim tta As TextArea = Sender  
        Dim SelectedText As String = tta.Text.SubString2(tta.SelectionStart,tta.SelectionEnd)  
          
        Dim l As List  
        l.Initialize  
        l.AddAll(Regex.Split(CRLF, tta.Text))  
  
        itemsPosition.the_start = 0: itemsPosition.the_end = 0  
        itemsPosition.the_isselect = False  
          
        If caretPosition.ItemsEnd(0) = 0 Then caretPosition.ItemsEnd(0) = EndPosition  
        caretPosition.ItemsEnd(1) = EndPosition  
        caretPosition.ItemsEquals = IIf((caretPosition.ItemsEnd(0) = caretPosition.ItemsEnd(1)), True, False)  
  
        For i = 0 To l.Size-1  
            itemsPosition.the_str = l.Get(i)  
            itemsPosition.the_end = itemsPosition.the_start + itemsPosition.the_str.Length  
              
            If StartPosition >= itemsPosition.the_start And StartPosition <= itemsPosition.the_end Then  
                itemsPosition.line = i + 1  
                itemsPosition.column = StartPosition - itemsPosition.the_start  
            End If  
              
            itemsPosition.the_start = itemsPosition.the_end + 1  
            itemsPosition.the_select = (tta.SelectionEnd - tta.SelectionStart)  
              
            itemsPosition.the_isselect = IIf(SelectedText.Length > 0, True, False)  
            itemsPosition.the_length = NumberFormat((tta.Text.Length+l.Size-1),0,2).Replace(","," ")  
              
            If Not(itemsPosition.the_isselect) Then  
                coordonate.Text = "length : "&itemsPosition.the_length&"   lines : "&l.Size&"            Ln : "&itemsPosition.line&"   Col : "&(itemsPosition.column+1)&"   Pos : "&IIf(itemsPosition.column = 0, EndPosition+itemsPosition.line,EndPosition+itemsPosition.line)  
            Else  
                If caretPosition.ItemsEquals = False Then  
                    coordonate.Text = "length : "&itemsPosition.the_length&"   lines : "&l.Size&"            Ln : "&itemsPosition.line&"   Col : "&((itemsPosition.column+1+itemsPosition.the_select))&"   Sel : "&(itemsPosition.the_select)&" | "&SumLine(SelectedText)  
                Else  
                    coordonate.Text = "length : "&itemsPosition.the_length&"   lines : "&l.Size&"            Ln : "&itemsPosition.line&"   Col : "&(itemsPosition.column+1)&"   Sel : "&(itemsPosition.the_select)&" | "&SumLine(SelectedText)  
                End If  
            End If  
        Next  
    End If  
    Return Null  
End Sub  
  
Private Sub SumLine(st As String) As Int  
    Dim components() As String  
    components = Regex.Split(CRLF, st)  
    Return components.Length  
End Sub  
#End Region
```