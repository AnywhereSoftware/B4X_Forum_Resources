### Multi selection list with B4XPreferencesDialog by Cadenzo
### 08/10/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/133295/)

If you need lists with more than one choice, one beautiful solution is, to use the [B4XPreferencesDialog](https://www.b4x.com/android/forum/threads/b4x-b4xpreferencesdialog-cross-platform-forms.103842/).  

```B4X
Dim mapDaten As Map  
    mapDaten.Initialize  
    pref.Theme= pref.THEME_LIGHT  
    pref.AddSeparator("title")  
    pref.AddExplanationItem("", "?", "some explanation")  
  
Dim rs As ResultSet = SQL1.ExecQuery2("SELECT * FROM Items WHERE …, Array As String(…))  
    Do While rs.NextRow  
        iID = rs.GetInt("ID")  
        sName = rs.GetString("Name")  
        'mapDaten.Put(iID, False) 'only needed, if some of the items are allready aktive  
        pref.AddBooleanItem(iID, sName)  
    Loop  
    rs.Close  
     
    Wait For (pref.ShowDialog(mapDaten, "OK", "CANCEL")) Complete (Result As Int)  
    If Result = xui.DialogResponse_Positive Then  
        For Each key As String In mapDaten.Keys  
            bAktiv = mapDaten.GetDefault(key, False)  
            If bAktiv Then  
                'handling the choosen items …  
            End If  
        Next  
    End If
```