### ROT13 Function by Douglas Farias
### 04/12/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/160291/)

Hello everybody.  
  
I'm posting this simple function here, I needed it today and I hadn't found it here on the forum.  
  
ROT13 (Rotate by 13 places) is a simple letter substitution cipher that replaces a letter with the 13th letter after it in the alphabet. It is a special case of the Caesar cipher which was developed in ancient Rome. ROT13 is not a secure encryption method, but rather a form of obfuscation used to hide text, especially spoilers or punchlines in online forums. It works by shifting each letter 13 positions in the alphabet, looping back to the beginning if needed (e.g., 'Z' becomes 'M', 'A' becomes 'N'). The same function is used for both encoding and decoding, as ROT13 is its own inverse.  
  
  

```B4X
'encrypt = true (encrypt), encrypt = false (Decrypt)  
Sub Rot13(input As String, encrypt As Boolean) As String  
    Dim output As StringBuilder  
    output.Initialize  
    Dim alphabet As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"  
    Dim rot13Alphabet As String = "NOPQRSTUVWXYZABCDEFGHIJKLMnopqrstuvwxyzabcdefghijklm"  
    
    Dim sourceAlphabet As String  
    Dim targetAlphabet As String  
    
    If encrypt Then  
        sourceAlphabet = alphabet  
        targetAlphabet = rot13Alphabet  
    Else  
        sourceAlphabet = rot13Alphabet  
        targetAlphabet = alphabet  
    End If  
    
    For i = 0 To input.Length - 1  
        Dim c As Char = input.CharAt(i)  
        Dim index As Int = sourceAlphabet.IndexOf©  
        If index <> -1 Then  
            output.Append(targetAlphabet.CharAt(index))  
        Else  
            output.Append©  
        End If  
    Next  
    Return output.ToString  
End Sub
```

  
  
  
thx