### Unescape Unicode sequences for Spanish language by GeoT
### 09/15/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/151728/)

Erel created a sub for unescape or decode Unicode sequences to transform unicode characters, with the structure \uXXXX, into real characters.  
In <https://www.b4x.com/android/forum/threads/when-getting-query-results-i-cant-read-hebrew.27461/post-159533>  
Is good for processing texts that come from scraping web pages, for example.  
  
But he created it to handle Hebrew characters, which can contain several Unicode sequences in a row.  
I have corrected it for the Spanish language by adding the condition  
  

```B4X
And unicode.Length < 4
```

  
  
So that it only processes the 6 characters that make up a Unicode sequence, to avoid mistakes in case there are more characters after between 0 and 9 or between a and f  
  
His code would look like this at the end:  
  

```B4X
Log(UnescapeUnicode("p\u00fablico.")) 'prints: público.    (Or pass a text with several words, in Unicode or not)  
  
Sub UnescapeUnicode(s As String) As String  
   
    Dim sb As StringBuilder  
    sb.Initialize  
    Dim i As Int  
   
    Do While i < s.Length  
        Dim c As Char = s.CharAt(i)  
        If c = "\" And i < s.Length - 1 And s.CharAt(i + 1) = "u" Then  
            Dim unicode As StringBuilder  
            unicode.Initialize  
            i = i + 2  
         
            Do While i < s.Length  
             
                Dim cc As String = s.CharAt(i)  
                Dim n As Int = Asc(cc.ToLowerCase)  
             
                'Only up to 4 hexadecimal characters are accepted after \u  
                If (n >= Asc("0") And n <= Asc("9")) Or (n >= Asc("a") And n <= Asc("f") And unicode.Length < 4) Then  
                    unicode.Append(s.CharAt(i))  
'                    Log(unicode.ToString)  
'                    Log(unicode.Length)  
                Else  
                    i = i - 1  
                    Exit  
                End If  
  
                i = i + 1  
            Loop  
         
            sb.Append(Chr(Bit.ParseInt(unicode.ToString, 16)))  
        Else  
            sb.Append©  
        End If  
        i = i + 1  
    Loop  
   
    Return sb.ToString  
End Sub
```