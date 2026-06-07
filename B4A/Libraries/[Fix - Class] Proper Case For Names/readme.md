### [Fix - Class] Proper Case For Names by T201016
### 06/04/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/171018/)

First of all, a thank you [USER=9800]@stevel05[/USER] for sharing an interesting source of this [class](https://www.b4x.com/android/forum/threads/proper-case-for-names.41189/#content).  
I took the liberty of placing a slight correction in the indicated place,  
which eliminates the error on line: 67 (Proper) - see original class.  
The fix in this form will handle one event omitted by the author, namely:  
- when the length of the Word variable is zero.  
In my case it works for now…  
  
My modified library based on this source: [HERE](https://www.b4x.com/android/forum/threads/lib-eproper-v3-08.171163/)  
  
Error occurred on line: 67 (Proper)  
java.lang.StringIndexOutOfBoundsException: String index out of range: 1  
 at java.lang.String.substring(String.java:1963)  
….  

```B4X
'#####################################################################################  
'  
'                        PROPER Name Capitalization Class  
'  
'                            Stevel05 9 March 2014  
'                  V 1.1 - Added Roman Numerals - 23/01/2016  
'  
'#####################################################################################  
'Class module  
Sub Class_Globals  
    Private Delimeters,Exclude As List  
    Private RomanRegexALL As String = "([ivxlcdm]*(?:th|rd|\b))*"  
    Private RomanRegexNUM As String = "[ivxlcdm]*"  
    Private fx As JFX  
End Sub  
  
'Initializes the object. You can add parameters to this method if needed.  
Public Sub Initialize  
    Delimeters.Initialize  
    Exclude.Initialize  
    'Always capitalize after one of these  
    Delimeters.AddAll(Array As String("'","Mc","-"))  
  
    'We want these words in the name to always appear in lower case.  
    Exclude.AddAll(Array As String("van","von","de"))  
End Sub  
  
Public Sub NameToProperCase(Name As String) As String  
    Dim Pos As Int  
    Dim Result As String  
    'Set the whole string to lowercase  
    Name = Name.ToLowerCase  
    'Make sure there is no more than one space between words.  
    Do While Name.Contains("  ")  
        Name = Name.Replace("  "," ")  
    Loop  
    'Process  
    'Break the name into words  
    Dim Words() As String = Regex.Split(" ",Name)  
    For i = 0 To Words.Length - 1  
        Dim Word As String = Words(i)  
        'Ignore excluded words  
        If Exclude.IndexOf(Word) > -1 Then Continue  
        For Each Delim As String In Delimeters  
            'Check for Roman Numerals  
            Dim M As Matcher  
            M = Regex.Matcher2(RomanRegexALL,Regex.CASE_INSENSITIVE,Word)  
            If M.Find And M.Match <> "" Then  
                'Capitalize just the Numerals  
                M = Regex.Matcher2(RomanRegexNUM,Regex.CASE_INSENSITIVE,Word)  
                If M.Find And M.Match <> "" Then  
                    Dim W As String = M.Match.ToUpperCase  
                    'Add the suffix  
                    W = W & Word.SubString(W.Length).ToLowerCase  
                    Word = W  
                    Pos = Word.IndexOf(Delim)  
                    If Pos > -1 Then  
                        If Word.Length > Pos + Delim.Length Then  
                            Word = Word.SubString2(0,Pos + Delim.Length) & Word.SubString2(Pos + Delim.Length,Pos + Delim.Length + 1).ToUpperCase & Word.SubString(Pos + Delim.Length + 1).ToLowerCase  
                        End If  
                    End If  
                End If  
            Else  
                'Capitalize the first letter of each word  
                If Word.Length = 1 Then  
                    Word = Word.ToUpperCase  
                Else If Word.Length > 1 Then '———- place of adding my fix  
                    'If the word is longer than 1 character, capitalize after each delimiter it contains  
                    Word = Word.SubString2(0,1).ToUpperCase & Word.SubString(1)  
                    Pos = Word.IndexOf(Delim)  
                    If Pos > -1 Then  
                        If Word.Length > Pos + Delim.Length Then  
                            Word = Word.SubString2(0,Pos + Delim.Length) & Word.SubString2(Pos + Delim.Length,Pos + Delim.Length + 1).ToUpperCase & Word.SubString(Pos + Delim.Length + 1).ToLowerCase  
                        End If  
                    End If  
                End If  
            End If  
        Next  
        Words(i) = Word  
    Next  
    For i = 0 To Words.Length - 1  
        Result = Result & Words(i)  
        If i < Words.Length - 1 Then Result = Result & " "  
    Next  
    Return Result  
End Sub
```