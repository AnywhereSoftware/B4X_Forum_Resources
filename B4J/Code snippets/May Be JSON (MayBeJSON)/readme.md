### May Be JSON (MayBeJSON) by tchart
### 03/30/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/129197/)

B4X implementation of the "mayBeJSON" method from JSON Lib - <https://github.com/jenkinsci/json-lib>  
  
The method tests if the input String possibly represents a valid JSON String. This is handy as a check before running the JSONParser.  
  

```B4X
Sub MayBeJSON(Input As String) As Boolean  
    If Input.Length = 0 Then Return False  
    If Input = Null Then Return False  
    If Input.ToLowerCase = "null" Then Return False  
    If Input.StartsWith("{") And Input.EndsWith("}") Then Return True  
    If Input.StartsWith("[") And Input.EndsWith("]") Then Return True     
    Return False     
End Sub
```