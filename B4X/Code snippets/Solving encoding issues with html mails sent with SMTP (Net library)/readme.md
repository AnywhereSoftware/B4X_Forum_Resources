###  Solving encoding issues with html mails sent with SMTP (Net library) by Erel
### 09/10/2026
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/128146/)

Encoding the html text with base64 avoids encoding issues, especially with MS Outlook.  
This code is compatible with B4A and B4J:  

```B4X
Private Sub SplitBase64WithCRLF (EncodedText As String, LineLength As Int = 76) As String  
    Dim eol As String = Chr(13) & Chr(10)  
    Dim sb As StringBuilder  
    sb.Initialize  
    For i = 0 To EncodedText.Length - 1 Step LineLength  
        Dim line As String = EncodedText.SubString2(i, Min(EncodedText.Length, i + LineLength))  
        sb.Append(line).Append(eol)  
    Next  
    Return sb.ToString  
End Sub  
  
  
Dim su As StringUtils  
smtp.Body = SplitBase64WithCRLF(su.EncodeBase64(html.GetBytes("utf8"))) 'html = the html body  
smtp.AdditionalHeaders.Put("Content-Transfer-Encoding", "BASE64")
```