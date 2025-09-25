### Check for FortAwesome / Material Icon by Robert Valentino
### 09/22/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/168741/)

```B4X
Private Sub CheckForFontAwesome(str As String) As Boolean  
            ' Regex pattern to match "fa-" followed by a name.  
            ' This will match strings like "fa-star", "fa-user-circle", etc.  
            Dim faPattern As String = "fa-[a-z0-9-]+"  
  
            Dim m As Matcher  
            m = Regex.Matcher(faPattern, str)  
  
            ' Matcher.Find returns True if any part of the string matches the pattern.  
            Return m.Find  
End Sub             
  
Private Sub CheckForMaterialIcon(str As String) As Boolean  
            ' Regex pattern to match "material-icons" or "mi-" followed by a name.  
            Dim MaterialPattern As String = "(material-icons|mi)-[a-z0-9_]+"  
  
            Dim m As Matcher  
            m = Regex.Matcher(MaterialPattern, str)  
  
            ' Matcher.Find returns True if any part of the string matches the pattern.  
            Return m.Find  
End Sub
```