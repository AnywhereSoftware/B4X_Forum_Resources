### [XLUtils] Reading and writing example by Erel
### 05/06/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/130433/)

You are probably familiar with the [online libraries index](https://docs.google.com/spreadsheets/d/1qFvc3Q70RriJS3m_ywBoJvZ47gSTVAuN_X04SI0_XBw/edit?usp=sharing).  
The table has a column for each of the platforms. This structure is useful as there are many cross platform libraries.  
  
The task that we will solve in this example is to take this single table and split it into four platform specific tables.  
  
The result is:  
  
![](https://www.b4x.com/android/forum/attachments/112870)  
  
I've used a template workbook with a single sheet. The sheet is cloned four times and eventually the original sheet is removed.  
  
Complete code:  

```B4X
Dim Libraries As XLReaderResult = xl.Reader.ReadSheetByIndex(File.DirAssets, "B4X Libraries.xlsx", 0)  
Dim Template As XLWorkbookWriter = xl.CreateWriterFromTemplate(File.DirAssets, "Template.xlsx")  
Dim TemplateSheet As XLSheetWriter = Template.CreateSheetWriterByIndex(0)  
Dim Platforms As List = Array ("B4A", "B4i", "B4J", "B4R")  
Dim Center As XLStyle = Template.CreateStyle.HorizontalAlignment("CENTER")  
For p = 0 To Platforms.Size - 1  
    Dim Platform As String = Platforms.Get(p)  
    Dim sheet As XLSheetWriter = Template.CloneSheet(TemplateSheet, Platform)  
    sheet.PutString(xl.AddressName("A1"), Platform)  
    Dim TargetRow1 As Int = 6  
    For SourceRow1 = 3 To Libraries.BottomRight.Row0Based + 1  
        Dim FileName As String = Libraries.Get(xl.AddressZero(2 + p, SourceRow1 - 1))  
        If FileName = "" Then Continue 'doesn't support this platform  
        sheet.PutString(xl.AddressOne("A", TargetRow1), Libraries.Get(xl.AddressOne("A", SourceRow1)))  
        sheet.PutString(xl.AddressOne("B", TargetRow1), Libraries.Get(xl.AddressOne("B", SourceRow1)))  
        sheet.PutNumber(xl.AddressOne("C", TargetRow1), Libraries.GetDefault(xl.AddressOne("G", SourceRow1), 0)).SetStyle(sheet.LastAccessed, Center)  
        Dim ticks As Long = Libraries.GetDefault(xl.AddressOne("H", SourceRow1), 0)  
        If ticks > 0 Then  
            sheet.PutDate(xl.AddressOne("D", TargetRow1), ticks).SetStyle(sheet.LastAccessed, Template.CreateStyle.DataFormat($"d"-"mmm"-"yyyy"$)).SetStyle(sheet.LastAccessed, Center)  
        End If  
        sheet.PutString(xl.AddressOne("E", TargetRow1), Libraries.Get(xl.AddressOne("I", SourceRow1))).SetStyle(sheet.LastAccessed, Center)  
        sheet.PutString(xl.AddressOne("F", TargetRow1), Libraries.Get(xl.AddressOne("J", SourceRow1)))  
        Dim link As String = Libraries.Get(xl.AddressOne("K", SourceRow1))  
        If link <> "" Then  
            sheet.PutString(xl.AddressOne("G", TargetRow1), link).SetStyle(sheet.LastAccessed, Template.CreateStyle.FontLink(11))  
            sheet.CreateHyperlink(sheet.LastAccessed, "URL", link)  
        End If  
        TargetRow1 = TargetRow1 + 1             
    Next  
    sheet.CreateFreezePane(0, 5)  
Next  
Template.RemoveSheetAt(0)
```

  
  
This quite simple example shows one of the incentives behind building XLUtils. It allows us, the programmers, to manipulate Excel workbooks based on our programming skills. With a few lines of code, we can do things that most Excel users simply cannot do.