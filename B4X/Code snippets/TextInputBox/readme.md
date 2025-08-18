###  TextInputBox by LucaMs
### 04/12/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/129654/)

I needed a simple cross platform dialog (B4A, B4X, B4i) for entering alphabetic text.  
I don't know if I wasted time and there is already something ready it's simpler than the one I'm about to publish (which could be written much better).  
  
Depends on XUI Views.  
  
**V. 1.0.1** - Added a parameter, DefaultText.  
  

```B4X
' CaseType - Pass: "L" for Lower only, "U" for Upper only, "B" for Both.  
' ExtraChars example: @$!%*?  
'<code>  
'    Wait For (TextInputBox("Name", "Erel" 3, 10, "B", "")) Complete(Name As String)  
'    If Name.Length > 0 Then  
'       Log("Name: " & Name)  
'    Else  
'       Log("Canceled")  
'    End If  
'</code>  
Private Sub TextInputBox(Prompt As String, DefaultText As String, MinLength As Int, MaxLength As Int, CaseType As String, ExtraChars As String) As ResumableSub  
    Dim ReturnedValue As String = ""  
  
    Dim Dialog As B4XDialog  
    Dialog.Initialize(Root)  
  
    Dim InputTemplate As B4XInputTemplate  
    InputTemplate.Initialize  
  
    InputTemplate.lblTitle.Text = Prompt  
    InputTemplate.Text = DefaultText  
  
    Dim RegexPattern As String  
  
    CaseType = CaseType.ToUpperCase  
    Dim PatternLetterCase As String  
    Select CaseType  
        Case "L"  
            PatternLetterCase = "a-z"  
        Case "U"  
            PatternLetterCase = "A-Z"  
        Case "B"  
            PatternLetterCase = "a-zA-Z"  
    End Select  
  
    If ExtraChars.Length > 0 Then  
        ExtraChars = Regex.Replace("([a-zA-Z0-9])", ExtraChars, "")  
        If ExtraChars.Length > 0 Then  
            If Not(ExtraChars.StartsWith("\")) Then  
                ExtraChars = "\" & ExtraChars  
            End If  
            PatternLetterCase = PatternLetterCase & ExtraChars  
        End If  
    End If  
  
    RegexPattern = $"[${PatternLetterCase}]{${MinLength},${MaxLength}}"$  
  
    InputTemplate.RegexPattern = RegexPattern  
  
    Wait For (Dialog.ShowTemplate(InputTemplate, "OK", "", "CANCEL")) Complete (Result As Int)  
  
    If Result = xui.DialogResponse_Positive Then  
        ReturnedValue = InputTemplate.Text  
    End If  
  
    Return ReturnedValue  
End Sub
```

  
  
Usage:  

```B4X
Private Sub Button1_Click  
    Wait For (TextInputBox("Name", "Erel", 3, 10, "B", "")) Complete(Name As String)  
    If Name.Length > 0 Then  
        Log("Name: " & Name)  
    Else  
        Log("Canceled")  
    End If  
End Sub
```