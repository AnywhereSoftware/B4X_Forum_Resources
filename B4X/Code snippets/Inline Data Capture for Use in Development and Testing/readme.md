###  Inline Data Capture for Use in Development and Testing by William Lancee
### 03/18/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/115075/)

I have done this so many times, I finally decided to formalize it.  
Say you want to create a small data set for testing. You can grab something from Excel, Word, or an old File and copy it to the Clipboard.  
While in the IDE, you can then paste it in the smart string section of the Sub shown below (or if it is reasonable small just type it in).  
It converts it then into a civilized list of string arrays. Of course if you already do this or are used to setting up a separate testing file. Then this is not for you.  
  
Edit: After looking at the CSVParser of [USER=1]@Erel[/USER] I realize I could optimize my routine considerably (surprise, surprise!) The new code below is the result.  
  

```B4X
Sub AppStart (Form1 As Form, Args() As String)  
    'MainForm = Form1        'the example is for B4J but it works the same in B4A and B4i  
    Dim render As List        'used here for efficient log(ging) of arrays (lists can be logged, arrays not)  
    Dim theData As List = InlineData  
     
    'NOTE: If there are headers they will be in first item, so you may take first record (Or NOT, if there are no headers)  
    Dim headers() As String = theData.Get(0): theData.RemoveAt(0)    'for simple related statements, I sometimes combine them, but never more than 2  
    render.Initialize2(headers)        'converts an array of strings to a list - only for easy display in the log  
    Log(render)  
     
    'Now the data is a list of string arrays - use as needed  
    For Each d() As String In theData  
        render.Initialize2(d)  
        Log($"Array size: ${render.Size} item 2 is ${d(2)}"$ & TAB & render)  
        '"" & render.Size & " item 2 is ")  
    Next  
    'MainForm.Show        'If you don't need the form, just don't show it (avoids having separate non-UI modules)  
End Sub
```

  
  

```B4X
#Region Inline Data Capture        'Collapsing regions is a good way to hide auxilliary code  
  
Sub InlineData As List  
    Dim data As String = $"  
______  
field1, field2, field3, field4  
1,2,"a,b,c"  
4,${Chr(13)}  
6,"d""ef",8,9  
______  
"$  
    Return parseCVS(data)  
End Sub  
  
Sub parseCVS(s As String) As List  
    'There are other solutions for doing this - this "state machine" is simpler than using regular expression  
    Dim workingArea As StringBuilder: workingArea.Initialize  
  
    Dim result As List: result.Initialize  
    Dim lastRow As List: lastRow.Initialize  
    result.Add(lastRow)  
  
    Dim maxLineLength As Int = -1  
    Dim skipNext As Boolean = False  
    Dim inQuote As Boolean = False  
    Dim prevChar As String = s.CharAt(0)  
    Dim currentChar As String  
  
    For i = 1 To s.Length - 1  
        currentChar = s.CharAt(i)  
        If skipNext Then  
            skipNext = False  
        Else  
            If inQuote Then  
                If prevChar = QUOTE And currentChar = QUOTE Then  
                    workingArea.Append(QUOTE)  
                    skipNext = True  
                Else if prevChar = QUOTE Then  
                    inQuote = False  
                Else  
                    workingArea.append(prevChar)  
                End If  
            Else if prevChar = QUOTE Then  
                inQuote = True  
            Else  
                If prevChar = "," Or prevChar = TAB Then  
                    lastRow.Add(workingArea.toString)  
                    workingArea.Initialize  
                Else If prevChar = Chr(13) Or prevChar = Chr(10) Then  
                    lastRow.Add(workingArea.toString)  
                    If lastRow.Size > maxLineLength Then maxLineLength = lastRow.Size  
                    Dim lastRow As List: lastRow.Initialize  
                    result.Add(lastRow)  
                    workingArea.Initialize  
                    If currentChar = Chr(13) Or currentChar = Chr(10) Then skipNext = True  
                Else  
                    workingArea.append(prevChar)  
                End If  
            End If  
        End If  
        prevChar = currentChar  
    Next  
    workingArea.append(currentChar)  
    lastRow.Add(workingArea.toString)  
      
    'This section will extract the actual data and normalize the lines to string arrays of the same max line length  
    Dim actualData As Boolean = False  
    Dim cleanResult As List: cleanResult.Initialize  
    For Each line As List In result  
        If line.Size>0 Then  
            Dim firstItem As String = line.get(0)  
            If actualData = False And firstItem.startsWith("____") Then  
                actualData = True  
            Else if firstItem.startsWith("____") Then  
                actualData = False  
            Else if actualData Then  
                Dim w(maxLineLength) As String  
                For j = 0 To line.size - 1                 
                    w(j) = line.Get(j)  
                Next  
                cleanResult.Add(w)  
            End If  
        End If  
    Next  
    Return cleanResult  
End Sub  
  
#End Region
```