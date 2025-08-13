### [Web] SithasoDaisy SDUITable Inline Editing - Calculations by Mashiane
### 07/10/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/162035/)

Hi Fam  
  
[Download](https://github.com/Mashiane/SithasoDaisy---SDUITable-Inline-Editing-with-Computations)  
  
NB: This project is built with SithasoDaisy 2.5 BETA, however the same principles discussed here still apply.  
  
This demo project is about how inline editing works. When some values in the table change, we calculate some other values. This is also effected when we make changes in our modal.  
  
![](https://www.b4x.com/android/forum/attachments/155376)  
  
When inline editing is enabled, i.e. each table row has input components like textboxes, selects, radio etc, one is able to trap changes in each row. This is done by adding a change event on the table.  
  
In this table, when any value of the table is changed, the qta, listno are multipled and the importo field updated with the result of the computation. The database is also updated with the changes.  
  
In this example, the table is reloaded again, but that part can be excluded from the operations.  
  

```B4X
'trap changes on table inline edits  
Private Sub tblcart_ChangeRow (Row As Int, Value As Object, Column As String, item As Map)  
    Dim sid As String = item.get("id")  
    Dim sqta As String = item.get("qta")  
    Dim slistino As String = item.get("listino")  
    Dim simporto As String = item.get("importo")  
    Dim snome As String = item.get("nome")  
    '  
    sqta = SDUIShared.CInt(sqta)  
    slistino = SDUIShared.CInt(slistino)  
    simporto = banano.parseint(sqta) * banano.parseInt(slistino)  
       
    'update the map column with value  
    item.Put("importo", simporto)  
    item.Put(Column, Value)  
    'update the row contents at this position  
    tblcart.UpdateRow(Row, item)  
    '  
    'get the CurrentPage  
    tblcart.SaveLastAccessedPage  
    'process the old Cart  
    dbcart.SetRecord(item)  
    'update the new changes  
    dbcart.SetField(Column, Value)  
    'execute an update  
    Dim newid As String = banano.Await(dbcart.UPDATE)  
    If newid <> "" Then  
        app.ShowToastSuccess("The Cart has been saved!")  
    Else  
        app.ShowToastError("The Cart could not be saved, please try again!")  
        Return  
    End If  
    're-load the Carts  
    banano.Await(mounted_cart)  
    'go to the last page  
    banano.Await(tblcart.ShowLastAccessedPage)  
    Dim summary As Map = tblcart.SetFooterTotalSumCountColumns(Array("qta","listino","importo"))  
    'get the total number of processed rows  
    srowcount = summary.Get("rowcount")  
    'format the value to be a thousand  
    srowcount = SDUIShared.Thousands(srowcount)  
    'set the first column to show the total  
    tblcart.SetFooterColumn(tblcart.FirstColumnName, $"Total (${srowcount})"$)  
End Sub
```

  
  
  
  
[MEDIA=youtube]5Cax2-p7lzs[/MEDIA]