### [XLUtils] Templates and Charts by Erel
### 05/03/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/130373/)

Creating new workbooks based on existing workbooks saves a lot of work and also allows adding features that are not directly available in POI / XLUtils, such as charts.  
Templates are regular workbooks.  
Creating a new workbook based on an existing one is very simple, you just need to call XL.CreateWriterFromTemplate instead of CreateWriterBlank.  
  
**Charts**  
  
If the source data size is known then adding a chart is trivial. No need to do anything special.  
  
When the size is unknown, several extra steps are needed.  
It works by creating a **dynamic** named data range and setting it as the chart's data source.  
Later we will overwrite the dynamic data range with a standard named range with the known size.  
  
The steps to create a dynamic named data range are demonstrated in the video.  
It is done with the OFFSET command from the Name Manager dialog (ctrl + F3):  

```B4X
=OFFSET(<top left cell>, 0, 0, <number of rows>, <number of columns>)
```

  
The <top left cell> points to the first data row, not to the header.  
  
[MEDIA=vimeo]544460888[/MEDIA]  
  
The relevant code from the example:  

```B4X
    Workbook = xl.CreateWriterFromTemplate(File.DirAssets, "Template.xlsx")  
    Dim sheet As XLSheetWriter = Workbook.CreateSheetWriterByName("Sheet1")  
    For i = 0 To CustomListView1.Size - 1  
        Dim item() As Object = CustomListView1.GetValue(i)  
        sheet.PutString(xl.AddressOne("B", 3 + i), item(0))  
        sheet.PutNumber(xl.AddressOne("C", 3 + i), item(1))  
    Next  
    Dim LastRow1 As Int = sheet.LastAccessed.Row0Based + 1  
    Workbook.AddNamedRange("Item", xl.CreateXLRangeWithSheet(xl.AddressName("B3"), xl.AddressOne("B", LastRow1), sheet.PoiSheet)) 'overwrite the name range  
    Workbook.AddNamedRange("Amount", xl.CreateXLRangeWithSheet(xl.AddressName("C3"), xl.AddressOne("C", LastRow1), sheet.PoiSheet))  
    Dim f As String = FileChooser.ShowSave(B4XPages.GetNativeParent(Me))  
    If f <> "" Then  
        f = Workbook.SaveAs(f, "", True)  
        xl.OpenExcel(f)  
        CustomListView1.Clear  
    End If  
End Sub
```