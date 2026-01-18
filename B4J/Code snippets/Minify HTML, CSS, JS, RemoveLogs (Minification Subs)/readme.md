### Minify HTML, CSS, JS, RemoveLogs (Minification Subs) by Magma
### 01/14/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/170019/)

Hi there…  
  
I wanna share some techniques for Server/web apps, minimizing usage of bandwidth…  
  
Before of all you must have splitted the handler page (responses) - at css, scripts-js, html  
  
Then you can use for your "strings" my subs… about 20~25% smaller HTML/Scripts/JS strings  
  

```B4X
'B4J Minification Subs  
  
Sub MinifyCSS(css As String) As String  
    Dim result As String = css  
    
    'Αφαίρεση comments /* */  
    Do While result.Contains("/*")  
        Dim start As Int = result.IndexOf("/*")  
        Dim end1 As Int = result.IndexOf("*/")  
        If end1 > start Then  
            result = result.SubString2(0, start) & result.SubString(end1 + 2)  
        Else  
            Exit  
        End If  
    Loop  
    
    'Αφαίρεση περιττών whitespace  
    result = result.Replace(CRLF, " ")  
    result = result.Replace(Chr(10), " ")  
    result = result.Replace(Chr(13), " ")  
    result = result.Replace(TAB, " ")  
    
    'Αφαίρεση spaces γύρω από σύμβολα  
    result = result.Replace(" {", "{")  
    result = result.Replace("{ ", "{")  
    result = result.Replace(" }", "}")  
    result = result.Replace("} ", "}")  
    result = result.Replace(" :", ":")  
    result = result.Replace(": ", ":")  
    result = result.Replace(" ;", ";")  
    result = result.Replace("; ", ";")  
    result = result.Replace(" ,", ",")  
    result = result.Replace(", ", ",")  
    
    'Αφαίρεση πολλαπλών spaces  
    Do While result.Contains("  ")  
        result = result.Replace("  ", " ")  
    Loop  
    
    Return result.Trim  
End Sub  
Sub MinifyJS(js As String) As String  
    Dim result As String = js  
    
    'Αφαίρεση single-line comments //  
    Dim lines() As String = Regex.Split(CRLF, result)  
    Dim sb As StringBuilder  
    sb.Initialize  
    
    For Each line As String In lines  
        Dim pos As Int = line.IndexOf("//")  
        If pos >= 0 Then  
            'Έλεγχος αν το // είναι μέσα σε string  
            Dim beforeComment As String = line.SubString2(0, pos)  
            Dim quoteCount As Int = CountChar(beforeComment, Chr(34)) 'Double quotes  
            Dim singleQuoteCount As Int = CountChar(beforeComment, Chr(39)) 'Single quotes  
            
            If quoteCount Mod 2 = 0 And singleQuoteCount Mod 2 = 0 Then  
                line = beforeComment  
            End If  
        End If  
        sb.Append(line).Append(CRLF)  
    Next  
    result = sb.ToString  
    
    'Αφαίρεση multi-line comments /* */  
    Do While result.Contains("/*")  
        Dim start As Int = result.IndexOf("/*")  
        Dim end1 As Int = result.IndexOf("*/")  
        If end1 > start Then  
            result = result.SubString2(0, start) & result.SubString(end1 + 2)  
        Else  
            Exit  
        End If  
    Loop  
    
    'Αφαίρεση περιττών whitespace  
    result = result.Replace(CRLF & CRLF, CRLF)  
    result = result.Replace(CRLF, " ")  
    result = result.Replace(Chr(10), " ")  
    result = result.Replace(Chr(13), " ")  
    result = result.Replace(TAB, " ")  
    
    'Αφαίρεση spaces γύρω από operators  
    result = result.Replace(" = ", "=")  
    result = result.Replace(" == ", "==")  
    result = result.Replace(" === ", "===")  
    result = result.Replace(" + ", "+")  
    result = result.Replace(" - ", "-")  
    result = result.Replace(" * ", "*")  
    result = result.Replace(" / ", "/")  
    result = result.Replace(" { ", "{")  
    result = result.Replace(" } ", "}")  
    result = result.Replace(" ( ", "(")  
    result = result.Replace(" ) ", ")")  
    result = result.Replace(" ; ", ";")  
    result = result.Replace(" , ", ",")  
    
    'Αφαίρεση πολλαπλών spaces  
    Do While result.Contains("  ")  
        result = result.Replace("  ", " ")  
    Loop  
    
    Return result.Trim  
End Sub  
Sub MinifyHTML(html As String) As String  
    Dim result As String = html  
    
    'Αφαίρεση HTML comments <!– –>  
    Do While result.Contains("<!–")  
        Dim start As Int = result.IndexOf("<!–")  
        Dim end1 As Int = result.IndexOf("–>")  
        If end1 > start Then  
            result = result.SubString2(0, start) & result.SubString(end1 + 3)  
        Else  
            Exit  
        End If  
    Loop  
    
    'Αφαίρεση whitespace μεταξύ tags  
    result = result.Replace(CRLF, "")  
    result = result.Replace(Chr(10), "")  
    result = result.Replace(Chr(13), "")  
    result = result.Replace(TAB, "")  
    
    'Αφαίρεση spaces μεταξύ tags  
    result = result.Replace("> <", "><")  
    
    'Αφαίρεση πολλαπλών spaces  
    Do While result.Contains("  ")  
        result = result.Replace("  ", " ")  
    Loop  
    
    Return result.Trim  
End Sub  
Sub RemoveLogJS(js As String) As String  
    Dim result As String = js  
    
    Do While result.Contains("console.log(")  
        Dim startPos As Int = result.IndexOf("console.log(")  
        If startPos < 0 Then Exit  
        
        'Βρες το matching closing parenthesis  
        Dim openPos As Int = startPos + 11 'Μήκος του "console.log"  
        Dim depth As Int = 1  
        Dim i As Int = openPos + 1  
        Dim inDoubleQuote As Boolean = False  
        Dim inSingleQuote As Boolean = False  
        Dim closePos As Int = -1  
        
        Do While i < result.Length  
            Dim c As String = result.SubString2(i, i + 1)  
            
            'Check for quotes  
            If c = """" And Not(inSingleQuote) Then  
                'Check if escaped  
                If i > 0 And result.SubString2(i - 1, i) <> "\" Then  
                    inDoubleQuote = Not(inDoubleQuote)  
                End If  
            Else If c = "'" And Not(inDoubleQuote) Then  
                'Check if escaped  
                If i > 0 And result.SubString2(i - 1, i) <> "\" Then  
                    inSingleQuote = Not(inSingleQuote)  
                End If  
            End If  
            
            'Count parentheses only if not in string  
            If Not(inDoubleQuote) And Not(inSingleQuote) Then  
                If c = "(" Then  
                    depth = depth + 1  
                Else If c = ")" Then  
                    depth = depth - 1  
                    If depth = 0 Then  
                        closePos = i  
                        Exit  
                    End If  
                End If  
            End If  
            
            i = i + 1  
        Loop  
        
        If closePos > openPos Then  
            'Αφαίρεση του console.log(…) και του ; αν υπάρχει  
            Dim endPos As Int = closePos + 1  
            If endPos < result.Length And result.SubString2(endPos, endPos + 1) = ";" Then  
                endPos = endPos + 1  
            End If  
            
            result = result.SubString2(0, startPos) & result.SubString(endPos)  
        Else  
            'Αν δεν βρέθηκε closing parenthesis, skip αυτό το console.log  
            Exit  
        End If  
    Loop  
    
    Return result  
End Sub  
'Helper function για count characters  
Private Sub CountChar(text As String, char1 As Char) As Int  
    Dim count As Int = 0  
    For i = 0 To text.Length - 1  
        If text.CharAt(i) = char1 Then count = count + 1  
    Next  
    Return count  
End Sub
```