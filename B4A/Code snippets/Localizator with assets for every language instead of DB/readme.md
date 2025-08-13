### Localizator with assets for every language instead of DB by Cadenzo
### 04/08/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/166513/)

The [B4XLocalizator](https://www.b4x.com/android/forum/threads/b4x-localizator-localize-your-b4x-applications.68751/) is a tool, to create sqlite db from excel file with keys and values of supported languages. The created db file than can added in app projects as asset, with the localizator class copied to another file location and fills a "strings" map with keys and values depending on the selected language.   
  
For my needs I changed it a bit. Beside "BuildDatabase" the Localizator tool creates in "BuildMapFiles" an array of maps (for each supported language) and writes it in files like "strings\_en.dat, "strings-de.dat". Now I can add this files as assets in my projects and depending on the selected language the "strings" map reads all data directly. No need for copy asset files and I also have better control and access to the results of Localizator tool, as I can open the files in normal texteditors.  
  

```B4X
Private Sub BuildMapFiles (Xls As String, Output As String)  
    Try  
        Dim result As XLReaderResult = xl.Reader.ReadSheetByIndex(Xls, "", 0)  
          
        Dim langs As List  
        langs.Initialize  
        Dim iCols As Int = result.BottomRight.Col0Based  
        Dim mapArr(iCols) As Map 'Array of maps one for each language  
        For col = 1 To iCols  
            Dim val As String = result.Get(xl.AddressZero(col, 0))  
            langs.Add(val)  
            mapArr(col - 1).Initialize  
        Next  
        For row0 = 1 To result.BottomRight.Row0Based  
            Dim key As String = result.Get(xl.AddressZero(0, row0))  
            For col0 = 1 To result.BottomRight.Col0Based  
                Dim val As String = result.Get(xl.AddressZero(col0, row0))  
                mapArr(col0 - 1).Put(key, val) 'add key-value pair from excel column to the map of this language  
            Next  
        Next  
        For langNr = 0 To iCols - 1  
            Dim sFile As String = Output & "_" & langs.Get(langNr) & ".dat"  
            If File.Exists(sFile, "") Then File.ReadMap2(sFile, "", mapArr(langNr)) 'use also data of older map file or delete it, if not wanted  
            File.WriteMap(sFile, "", mapArr(langNr))  
        Next  
        LogMessage("MapFiles created successfully!")  
    Catch  
        Log(LastException)  
        LogMessage("Error: " & LastException)  
    End Try  
End Sub
```

  
  

```B4X
Private Sub LoadStrings  
    Dim sAvailableLangs As String = "en de" 'supported languages (asset files like "strings_en.dat" are included)  
    If sAvailableLangs.Contains(Locale) = False Then Locale = "en" 'Default  
    strings.Clear  
    strings = File.ReadMap(File.DirAssets, "strings_" & Locale & ".dat")  
      
    Log($"Found ${strings.Size} strings."$)  
End Sub
```