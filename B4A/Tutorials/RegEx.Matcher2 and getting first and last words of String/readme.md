### RegEx.Matcher2 and getting first and last words of String by mfstuart
### 05/18/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/147973/)

This example not only retrieves the first and last word of a String, but also sets a Label with the first letters of both the first and last words.  
I use it to populate a CustomListView with Account Names and the Ltr1 & Ltr2 in a Label that is positioned to the left of the Account Name.  
This is kind of like a reproduction of Outlook for Android.  
  
I got the RegEx expressions from [HERE](https://www.autoitscript.com/forum/topic/168113-how-to-find-first-and-last-word-of-sentence-with-regular-expression/).  
Use B4A's Regex [PAGE](https://b4x.com:51041/regex_ws/index.html) to not only see how your expressions work, but it also produces the B4X code to use to put in your app.  
  
Hope it helps someone.  
  

```B4X
Sub Set_Words(name as String)  
    If txt <> "" Then  
        Dim firstWordPattern As String = "(?:^|(?:\.\s))(\w+)"    '1st word expression'  
        Dim lastWordPattern As String = "\s(\w+)$"                'last word expression  
        Dim Word1 As String = ""  
        Dim Word2 As String = ""  
        Dim Ltr1 As String = ""  
        Dim Ltr2 As String = ""  
         
        'first Word  
        Dim m1 As Matcher = Regex.Matcher2(firstWordPattern,Regex.CASE_INSENSITIVE,name)  
        Do While m1.Find  
            Word1 = m1.Match.Trim  
            Ltr1 = Word1.ToUpperCase.CharAt(0)  
        Loop  
                 
        'last Word  
        Dim m2 As Matcher = Regex.Matcher2(lastWordPattern,Regex.CASE_INSENSITIVE,name)  
        Do While m2.Find  
            Word2 = m2.Match.Trim  
            Ltr2 = Word2.ToUpperCase.CharAt(0)  
        Loop  
        lblFirstWord.Text = Word1  
        lblLastWord.Text = Word2  
        lblLetters.Text = Ltr1 & Ltr2  
    End If  
End Sub
```

  
  
Mark Stuart