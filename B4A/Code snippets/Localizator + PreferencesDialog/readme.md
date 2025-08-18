### Localizator + PreferencesDialog by arfprogramas
### 07/09/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/132382/)

Hello  
  
If you use Erel's Localizator: <https://www.b4x.com/android/forum/threads/b4x-localizator-localize-your-b4x-applications.68751/#content>  
This piece of code allow you to localizes your **PreferencesDialog**.  
Just add in the class Localizator.  
  

```B4X
'Localizes PreferencesDialog  
Public Sub LocalizePrefDialog(pf As PreferencesDialog)  
    For Each prefitem As B4XPrefItem In pf.PrefItems  
        prefitem.Title = Localize(prefitem.Title)  
        If prefitem.Extra.IsInitialized Then  
            For Each key As String In prefitem.Extra.Keys  
                If prefitem.Extra.Get(key) Is List Then  
                    prefitem.Extra.Put(key, LocalizeList(prefitem.Extra.Get(key)))  
                Else  
                    prefitem.Extra.Put(key, Localize(prefitem.Extra.Get(key)))  
                End If  
            Next  
        End If  
    Next  
End Sub
```