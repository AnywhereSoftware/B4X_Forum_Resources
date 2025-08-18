### URI decoding by T201016
### 05/02/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/140282/)

Hello everyone!  
I provide the source code of a function that allows URI characters to be decoded into their equivalents.  
  
Application example:  
GetUriToString ("SAMSUNG **%C2%A9**") -> result: 'SAMSUNG **©**'  
  

```B4X
'Change URI to the actual path name.  
'Code in UTF-8 also existing codes in the names.  
Public Sub GetUriToString(uri As String) As String  
    If uri.CompareTo("/") = 0 Then Return uri  
  
    Private target,replacement As List  
    Private toString As String = uri  
  
    target.Initialize2(Array As Object("%20","%2F","%3A","%40","%23","%24","%25","%26","%2B","%60","%E2%80%A2","%E2%88%9A","%CF%80","%C3%B7","%C3%97","%C2%B6","%E2%88%86","%C2%A3","%C2%A2","%E2%82%AC","%C2%A5","%5E","%C2%B0","%3D","%7B","%7D","%C2%A9","%C2%AE","%E2%84%A2","%E2%84%85","%5B","%5D"))  
    replacement.Initialize2(Array As Object(Chr(32),"/","/","@","#","$","%","&","+","`","•","√","π","÷","×","¶","∆","£","¢","€","¥","^","°","=","{","}","©","®","™","℅","[","]"))  
    
    For i = 0 To target.Size - 1  
        toString = toString.Replace(target.Get(i), replacement.Get(i))  
    Next  
    Return toString  
End Sub
```