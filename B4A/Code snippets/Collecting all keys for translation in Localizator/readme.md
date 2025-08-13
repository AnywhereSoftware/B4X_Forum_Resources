### Collecting all keys for translation in Localizator by Cadenzo
### 04/08/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/166512/)

I want to localize some of my apps with the [Localizator class](https://www.b4x.com/android/forum/threads/b4x-localizator-localize-your-b4x-applications.68751/), and was looking for a good way, to find all the keys for translation. There are lots of texts in views and dialogs. So the idea was, to define and declare also a map "strings\_missing" where the map "strings" is and change the sub "Localize" a bit, to collect all keys that have no value yet.  
  
So I can start the app, go through all pages and catch the keys in the end like "Log(Main.loc.GetMissingStrings)". Copy & Paste this keys in the strings excel file for translations would be the next step.  
  

```B4X
'Localizes the given key.  
'If the key does not match then the key itself is returned.  
'Note that the key matching is case insensitive.  
Public Sub Localize(Key As String) As String  
    Dim value As Object = strings.Get(Key.ToLowerCase)  
    If value = Null Then  
        value = Key  
        strings_missing.Put(Key, "") 'Collect Keys without value in beginning of app localisation, later can be deactivated. Value is not important here  
    End If  
    Return value  
End Sub  
  
Public Sub GetMissingStrings() As String  
    Dim sb As StringBuilder : sb.Initialize  
    For Each sKey As String In strings_missing.Keys  
        sb.Append(sKey & CRLF)  
    Next  
    Return sb.ToString  
End Sub
```