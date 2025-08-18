### jPOI how to get the Active sheet by Christian75
### 11/19/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/124747/)

Hi,  
  
I did not find any explantion of how to get the active sheet in B4X jPOI in this forum but I found a way to get it.  
  

```B4X
Dim excel_wb As PoiWorkbook  
Dim j_wb As JavaObject  
  
excel_wb.InitializeExisting("", FileName, "")  
j_wb = excel_wb  
active_sheet = j_wb.RunMethod("getActiveSheetIndex", Null)
```

  
  
/Christian