###  [BCTextEngine] Custom formatting rules by Alexander Stolte
### 01/05/2025
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/164961/)

I am working on a new feature for my app, whatsapp has had this feature for a long time.  
  
If the user enters 2 stars before a word and 2 stars after the word, the text will be displayed in bold. The same if the user enters a dash and a space, then it becomes a list.  
  
![](https://www.b4x.com/android/forum/attachments/160429)  
  
Together with my brain and the neural network of ChatGPT I have written the following function:  

```B4X
Private Sub FormatText(Text As String) As String  
    ' ***TextColor***  
    ' Define the BBCode for the text color based on the current theme  
    Dim LeftText As String = $""$  
    Dim RightText As String = ""  
  
    ' Initialize the result text builder  
    Dim ResultText As StringBuilder  
    ResultText.Initialize  
  
    ' Temporary variables  
    Dim TempText As String = Text  
    Dim IsInList As Boolean = False  ' Flag to track if we are inside a list  
  
    ' Split the input text into lines for line-by-line processing  
    Dim Lines() As String = Regex.Split(CRLF, TempText)  
    For Each Line As String In Lines  
        ' Check if the line is a list item (starts with "- ")  
        If Line.Trim.StartsWith("- ") Then  
            ' Extract the list item content by removing "- " and trimming  
            Dim ListItem As String = Line.Trim.SubString(2).Trim  
            If IsInList = False Then  
                ' If not already in a list, start a new list  
                ResultText.Append("

").Append(CRLF)
                IsInList = True
            End If
            ' Append the list item to the result
            ResultText.Append("- ").Append(ListItem).Append(CRLF)
Else
            ' If the current line is not a list item, close any open list
            If IsInList Then
                ResultText.Append("
").Append(CRLF)  
                IsInList = False  
            End If  
            ' Check for bold text within the current line  
            Dim StartPos As Int = 0  
            Do While StartPos < Line.Length  
                ' Find the start of bold text (indicated by **)  
                Dim BoldStart As Int = Line.IndexOf2("**", StartPos)  
                If BoldStart = -1 Then  
                    ' No more bold text; append the remaining line as plain text  
                    ResultText.Append("[Plain]").Append(Line.SubString(StartPos)).Append("[/Plain]")  
                    Exit  
                End If  
  
                ' Append plain text before the bold text  
                If BoldStart > StartPos Then  
                    ResultText.Append("[Plain]").Append(Line.SubString2(StartPos, BoldStart)).Append("[/Plain]")  
                End If  
  
                ' Find the end of the bold text  
                Dim BoldEnd As Int = Line.IndexOf2("**", BoldStart + 2)  
                If BoldEnd = -1 Then  
                    ' If no closing ** is found, treat the rest of the line as plain text  
                    ResultText.Append("[Plain]").Append(Line.SubString(BoldStart)).Append("[/Plain]")  
                    Exit  
                End If  
  
                ' Append the bold text  
                ResultText.Append("").Append(Line.SubString2(BoldStart + 2, BoldEnd)).Append("")  
  
                ' Move the start position to the end of the bold text  
                StartPos = BoldEnd + 2  
            Loop  
            ' Append a line break after processing the current line  
            ResultText.Append(CRLF)  
        End If  
    Next  
  
    ' If there is an open list at the end of the text, close it  
    If IsInList Then  
        ResultText.Append("").Append(CRLF)  
    End If  
  
    ' Return the final formatted text wrapped with the color tags  
    Return LeftText & ResultText.ToString & RightText  
End Sub  
  
  
Public Sub ColorToHex(clr As Int) As String  
    Dim bc As ByteConverter  
    Dim Hex As String = bc.HexFromBytes(bc.IntsToBytes(Array As Int(clr)))  
    If Hex.Length > 6 Then Hex = Hex.SubString(Hex.Length - 6)  
    Return Hex  
End Sub
```

  
  
The result looks like this:  
![](https://www.b4x.com/android/forum/attachments/160428)  
The input is:  

```B4X
This is a **Test** the text should be bold  
and this is a list:  
- Item 1  
- Item 2  
- Item 3  
nice
```

  
  
If anyone has a more efficient way to achieve this I would be very grateful as it is a lot of code for such a small feature.