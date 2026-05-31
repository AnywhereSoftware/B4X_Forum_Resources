### B4AXLUtils PRO - Advanced Excel Generation (Themed ReportBuilder) & Native Word (.docx) powered by Apache POI 5.x by fernando1987
### 05/28/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/171133/)

Hi everyone,  
  
I'm excited to announce the **PRO** version release of [**B4AXLUtils**](https://www.b4x.com/android/forum/threads/b4axlutils-high-performance-excel-manipulation-xls-xlsx-powered-by-apache-poi.171131/). This library has expanded into an all-in-one enterprise office automation solution for Android. It seamlessly combines an advanced spreadsheet core engine supporting **Dynamic Styling Themes** with a fluid Microsoft Word layout processor (.docx), running natively on top of **Apache POI 5.x** optimized through JavaObject.  
  
[HEADING=2]🌟 Premium PRO Key Highlights:[/HEADING]  

- **ExcelReportBuilder**: A production-ready Fluent API builder to compile structured data tables, embed branding corporate logos, auto-evaluate spreadsheet mathematical totals, and assign color palettes instantly (THEME\_BLUE, THEME\_GREEN, THEME\_ORANGE, THEME\_PURPLE).
- **Advanced Workbook Security**: Individual cell management with selective cell unlocking (SetLocked) alongside complete sheet encryption using password protection.
- **WordManager**: An enterprise-grade engine to create clean .docx files. Control overall document typography, custom running headers and footers with images, advanced multi-language pagination ("Page X of Y"), chained text paragraph run decorations, and tables with layout horizontal cells merging.

[HEADING=2]📦 Download Links & Project Requirements[/HEADING]  
To compile this library package, please make sure you enable the following libraries in your B4A IDE manager:  

- **PermissionsManager** (Crucial to properly authorize external storage access on modern SDKs)

> 📥 **Download the PRO Library:** [B4AXLUtils\_Pro\_v1.00.zip](https://b4xapp.com/en/producto/409) *(B4X Store link)* 📑 **Required Support Thread:** [PermissionsManage](https://www.b4x.com/android/forum/threads/permissionsmanager.145185/)r

  
  
  
[HEADING=1]📑 Technical Class Reference Documentation (API)[/HEADING]  
[HEADING=2]1. ExcelManager[/HEADING]  
The core component managing the workbook life cycle and IO persistence.  
  

- **Initialize**(CallBack As Object, EventName As String)
- **CreateWorkbook**()
- **ReadWorkbook**(Directory As String, FileName As String) As ExcelManager
- **CreateSheet**(Name As String) As ExcelSheet

- *Return Type Usage:* <code>Dim sheet As ExcelSheet = excel.CreateSheet("Inventory")</code>

- **GetSheetAt**(Index As Int) As ExcelSheet

- *Return Type Usage:* <code>Dim sheetSection As ExcelSheet = excel.GetSheetAt(0)</code>

- **AddPicture**(Directory As String, FileName As String, PictureType As Int) As Int

- *Return Type Usage:* <code>Dim picId As Int = excel.AddPicture(File.DirAssets, "logo.png", excel.PICTURE\_TYPE\_PNG)</code>

- **Save**(Directory As String, FileName As String)
- **SearchAndReplace**(SearchText As String, ReplaceText As String) As ExcelManager
- **Close**()

[HEADING=2]2. ExcelSheet[/HEADING]  
Represents a single sheet grid workspace section inside the open workbook document.  
  

- **GetRow**(RowIndex As Int) As ExcelRow

- *Return Type Usage:* <code>Dim row As ExcelRow = sheet.GetRow(3)</code>

- **AddPictureRange**(PictureId As Int, StartCol As Int, StartRow As Int, EndCol As Int, EndRow As Int)
- **AutoSizeColumns**(StartCol As Int, EndCol As Int)
- **ProtectSheet**(Password As String)

[HEADING=2]3. ExcelRow[/HEADING]  
Represents an horizontal layout record row inside a specific worksheet.  
  

- **GetCell**(ColIndex As Int) As ExcelCell

- *Return Type Usage:* <code>Dim cell As ExcelCell = row.GetCell(1)</code>

[HEADING=2]4. ExcelCell[/HEADING]  
Granular element containing cell formats, direct alignments, protection tags, and safe mathematical values.  
  

- **SetLocked**(Locked As Boolean)
- **GetOrCloneStyle**() As JavaObject

- *Return Type Usage:* <code>Dim style As JavaObject = cell.GetOrCloneStyle</code>

- **clear**()
- **toString**() As String

- *Return Type Usage:* <code>Dim txt As String = cell.toString</code>

- **Value Property**(Object): Dynamic evaluation injection layer.

- *Reading extraction usage:* <code>Dim value As Object = cell.Value</code>

- **Formula Property** (String)
- **Reference Property**As String

- *Return Type Usage:* <code>Dim ref As String = cell.Reference</code>

[HEADING=2]5. ExcelReportBuilder[/HEADING]  
Automated tabular design utility utilizing corporate presets for fast deployments.  
  

- **Initialize**(Manager As ExcelManager, Sheet As ExcelSheet)
- **SetTheme**(ThemeConstant As Int) As ExcelReportBuilder
- **SetLogo**(Directory As String, FileName As String) As ExcelReportBuilder
- **SetLogoRange**(StartRow As Int, StartCol As Int, EndRow As Int, EndCol As Int) As ExcelReportBuilder
- **SetTitle**(Title As String) As ExcelReportBuilder
- **SetSubtitle**(Subtitle As String) As ExcelReportBuilder
- **AddColumn**(HeaderName As String, CellType As Int) As ExcelReportBuilder
- **AddColumnEx**(HeaderName As String, CellType As Int, FormatPattern As String) As ExcelReportBuilder
- **AddTotalColumn**(TableColumnIndex As Int) As ExcelReportBuilder
- **AddRow**(Data() As Object) As ExcelReportBuilder
- **Build**()

[HEADING=2]6. WordManager[/HEADING]  
Main processing wrapper to write and restructure native OpenXML .docx Word structures.  
  

- **Initialize**(Callback As Object, EventName As String)
- **SetDocumentFont**(FontName As String)
- **CreateParagraph**() As WordParagraph

- *Return Type Usage:* <code>Dim p As WordParagraph = word.CreateParagraph</code>

- **CreateTable**(Rows As Int, Cols As Int) As WordTable

- *Return Type Usage:* <code>Dim t As WordTable = word.CreateTable(5, 3)</code>

- **GetHeader**() As WordHeader

- *Return Type Usage:* <code>Dim h As WordHeader = word.GetHeader</code>

- **GetFooter**() As WordFooter

- *Return Type Usage:* <code>Dim f As WordFooter = word.GetFooter</code>

- **AddPageNumberExt**(Alignment As String, PageLabel As String, OfLabel As String)
- **Save**(Directory As String, FileName As String)

[HEADING=2]7. WordParagraph[/HEADING]  
Fluid styling wrapper to create customized text run structures inline.  
  

- **AddText**(Text As String) As WordParagraph
- **SetBold**(Enabled As Boolean) As WordParagraph
- **SetItalic**(Enabled As Boolean) As WordParagraph
- **SetTextColor**(Color As Int) As WordParagraph
- **ApplyStyle**() As WordParagraph
- **SetSpacingAfterPoints**(Points As Int) As WordParagraph

[HEADING=2]8. WordTable[/HEADING]  
Grid structure wrapper handling rows and explicit styling elements inside text documents.  
  

- **SelectCell**(Row As Int, Col As Int) As WordTable
- **AddText**(Text As String) As WordTable
- **MergeCellsHorizontal**(Row As Int, FromCol As Int, ToCol As Int) As WordTable
- **AddRow**(Data() As String) As WordTable
- **SetAutoFit**() As WordTable

[HEADING=1]💻 Full Code Implementation Example[/HEADING]  

```B4X
 Sub Process_Globals  
Private xui As XUI  
End Sub  
  
Sub Globals  
  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
Activity.LoadLayout("Layout")  
 Dim PM As PermissionsManager  
PM.CheckAndRequestPermission(PermissionsManager.SPECIAL_MANAGE_EXTERNAL_STORAGE)  
Wait For Activity_PermissionResult (Permission As String, Result As Boolean)  
If Result Then  
 Log("Storage permission granted")  
Else Log("Storage permission denied")  
End If  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Sub Button1_Click  
GenerateExactMantaReport  
' CreateMultipleSheetReport  
' CreateProfessionalReport  
' ReadQuickExample  
End Sub  
  
Sub ReadQuickExample  
Dim em As ExcelManager  
em.Initialize(Me, "em")  
em.ReadWorkbook(File.DirRootExternal, "Themed_Multisheet_Report_2026.xlsx")  
  
Dim firstSection As ExcelSheet = em.GetSheetAt(0)  
Dim row As ExcelRow = firstSection.GetRow(9)  
  
If row.IsInitialized Then  
    Dim id As Object = row.GetCell(3).Value  
    Log("ID Found: " & id)  
End If  
em.Close  
  
End Sub  
  
Sub CreateMultipleSheetReport  
 Dim excel As ExcelManager  
excel.Initialize(Me, "excel")  
excel.CreateWorkbook  
  
Dim sheetNames() As String = Array As String("North Consumption", "South Consumption", "Central Consumption", "Special Consumption")  
  
For i = 0 To sheetNames.Length - 1  
    Dim name As String = sheetNames(i)  
    Dim sheet As ExcelSheet = excel.CreateSheet(name)  
    Dim report As ExcelReportBuilder  
    report.Initialize(excel, sheet)  
   
    Select i  
        Case 0: report.SetTheme(report.THEME_BLUE)  
        Case 1: report.SetTheme(report.THEME_GREEN)  
        Case 2: report.SetTheme(report.THEME_ORANGE)  
        Case 3: report.SetTheme(report.THEME_PURPLE)  
    End Select  
   
    report.SetLogo(File.DirAssets, "LOGO_CNEL_WEB_440x194.png") _  
          .SetLogoRange(0, 1, 1, 3) _  
          .SetTitle("MONTHLY CONSUMPTION REPORT - " & name.ToUpperCase) _  
          .SetSubtitle("Manta, Manabi - Period 2026") _  
          .SetShowDate(True, "Issue Date:") _  
          .SetShowTotals(True, "TOTALS SUMMARY:") _  
          .SetStartColumn(1)  
   
    report.AddColumn("ID", excel.TYPE_NUMERIC) _  
          .AddColumn("Client", excel.TYPE_STRING) _  
          .AddColumnEx("Reading Date", excel.TYPE_DATE, "dd/mmm/yyyy") _  
          .AddColumn("kWh", excel.TYPE_NUMERIC) _  
          .AddColumnEx("Subtotal", excel.TYPE_CURRENCY, "$#,##0.00")  
   
    report.AddTotalColumn(3)  
    report.AddTotalColumn(4)  
   
    report.AddRow(Array As Object(1001, "User A - " & name, "2026-05-10", 125.50, 18.25))  
    report.AddRow(Array As Object(1002, "User B - " & name, "2026-05-11", 450.00, 72.10))  
    report.AddRow(Array As Object(1003, "User C - " & name, "2026-05-12", 89.20, 12.40))  
    report.AddRow(Array As Object(1004, "User D - " & name, "2026-05-13", 1200.00, 210.00))  
   
    report.Build  
Next  
  
Dim fileName As String = "Themed_Multisheet_Report_2026.xlsx"  
excel.Save(File.DirRootExternal, fileName)  
Log("✅ Themed multi-sheet report created successfully: " & fileName)  
  
End Sub  
  
Sub CreateProfessionalReport  
Dim ex As ExcelManager  
 ex.Initialize(Me, "ex")  
ex.CreateWorkbook  
Dim sheet As ExcelSheet = ex.CreateSheet("Inventory 2026")  
  
Dim picture As Int = ex.AddPicture(File.DirAssets, "art.png", ex.PICTURE_TYPE_PNG)  
sheet.AddPictureRange(picture, 0, 0, 2, 5)  
  
Dim headers() As String = Array As String("ID", "Product", "Current Stock", "Audit Notes")  
Dim headerRow As ExcelRow = sheet.GetRow(3)  
  
For i = 0 To headers.Length - 1  
    Dim cell As ExcelCell = headerRow.GetCell(i)  
    cell.Value = headers(i)  
Next  
  
For r = 4 To 10  
    Dim row As ExcelRow = sheet.GetRow(r)  
    row.GetCell(0).Value = "PROD-" & r  
    row.GetCell(1).Value = "Electronic Component " & r  
    row.GetCell(2).Value = Rnd(10, 100)  
   
    Dim auditCell As ExcelCell = row.GetCell(3)  
    auditCell.Value = ""  
    auditCell.SetLocked(True)  
Next  
  
sheet.AutoSizeColumns(0, 3)  
  
Dim fileName As String = "Protected_Report.xlsx"  
ex.Save(File.DirRootExternal, fileName)  
Log("Report created successfully at: " & fileName)  
  
End Sub  
  
Sub GenerateExactMantaReport  
Dim wr As WordManager  
wr.Initialize(Me, "wr")  
wr.SetDocumentFont(wr.FONT_TIMES)  
  
Dim head As WordHeader = wr.GetHeader  
head.AddText("MANABI BUSINESS UNIT - ENERGY CONTROL", True, 10, "004A99")  
head.AddImage(File.DirAssets, "Header.jpg", 620, 80)  
  
Dim footer As WordFooter = wr.GetFooter  
footer.AddImage(File.DirAssets, "footer.jpg", 620, 80)  
  
wr.AddPageNumberExt(wr.ALIGN_CENTER, "Page", "of")  
  
Dim p1 As WordParagraph = wr.CreateParagraph  
p1.SetAlignment(wr.ALIGN_BOTH) _  
  .AddText("Collection of Non-Energy Items for Labor and Materials from client GABRIELA MERCEDES LOOR VELASQUEZ contract account 200055262477 belonging to MANTA district") _  
  .SetBold(True).SetFontSize(11).ApplyStyle  
  
p1.SetSpacingAfterPoints(40)  
  
Dim p2 As WordParagraph = wr.CreateParagraph  
p2.AddText("BACKGROUND").SetBold(True).SetFontSize(12).ApplyStyle  
wr.CreateParagraph  
  
Dim p3 As WordParagraph = wr.CreateParagraph  
p3.SetAlignment(wr.ALIGN_BOTH)  
p3.AddText("According to the technical inspection carried out by the personnel of CNELEP UN Manabi on ").ApplyStyle  
p3.AddText("01/13/2026").SetBold(True).SetFontSize(11).ApplyStyle  
p3.AddText(", evidence of ").ApplyStyle  
p3.AddText("meter tampering").SetBold(True).SetItalic(True).SetTextColor(Colors.Red).SetFontSize(11).ApplyStyle  
p3.AddText(" was found at the electricity service facility under contract account 200055262477 (CUEN 1100498204), registered to ").ApplyStyle  
p3.AddText("GABRIELA MERCEDES LOOR VELASQUEZ").SetBold(True).SetFontSize(11).ApplyStyle  
p3.AddText("; by virtue of this, unbilled consumption was re-liquidated.").ApplyStyle  
p3.SetSpacingAfterPoints(15)  
  
Dim p5 As WordParagraph = wr.CreateParagraph  
p5.AddText("DEVELOPMENT").SetBold(True).SetFontSize(12).ApplyStyle  
wr.CreateParagraph  
  
Dim p6 As WordParagraph = wr.CreateParagraph  
p6.SetAlignment(wr.ALIGN_BOTH)  
p6.AddText("During the technical inspection, issues related to the manipulation of the measurement system were identified, prompting the correction and normalization of the electrical service. ").ApplyStyle  
p6.AddText("This led to the rebilling of unbilled energy, the execution of a fine penalty, and the billing for materials and labor employed.").ApplyStyle  
p6.SetSpacingAfterPoints(15)  
  
Dim p8 As WordParagraph = wr.CreateParagraph  
p8.AddText("ACTIONS AND SANCTIONS TO BE APPLIED").SetBold(True).SetFontSize(12).ApplyStyle  
wr.CreateParagraph  
  
Dim t1 As WordTable = wr.CreateTable(2, 2)  
t1.SetAutoFit  
t1.SetCellPadding(100, 100, 100, 100)  
t1.SelectCell(0, 0).SetBold(True).AddText("Consumer Infractions").ApplyStyle  
t1.SelectCell(0, 1).SetBold(True).AddText("Action / Sanction").ApplyStyle  
t1.SelectCell(1, 0).AddText("Consuming energy through installations that alter the normal operation of measurement instruments").ApplyStyle  
t1.SelectCell(1, 1).SetAlignment("CENTER").AddText("1/2/4/6/7/9").ApplyStyle  
  
wr.CreateParagraph  
  
Dim pSanc2 As WordParagraph = wr.CreateParagraph  
pSanc2.SetAlignment(wr.PAGE_LOC_LEFT)  
pSanc2.AddText("2. Payment for repair or replacement of facilities, equipment, and materials owned by the DISTRIBUTOR.").AddLineBreak.AddLineBreak  
pSanc2.AddText("4. Payment for consumed energy, calculated and billed in accordance with current regulations, up to 12 months prior to the determination of the infraction.").AddLineBreak.AddLineBreak  
pSanc2.AddText("6. Payment of three hundred percent 300% of the value of the effective billing of the consumption month prior to the determination of the illicit act…")  
pSanc2.SetItalic(True).SetFontSize(11).ApplyStyle  
pSanc2.SetSpacingAfterPoints(15)  
  
Dim p18 As WordParagraph = wr.CreateParagraph  
p18.AddText("CONCLUSION AND REQUEST").SetBold(True).SetFontSize(12).ApplyStyle  
  
Dim p19 As WordParagraph = wr.CreateParagraph  
p19.AddText("It is requested that the customer be billed through miscellaneous cash accounts for the items detailed for ").ApplyStyle  
p19.AddText("04/06/2026").SetBold(True).SetFontSize(11).ApplyStyle  
p19.AddText(":").ApplyStyle  
wr.CreateParagraph  
  
Dim tVal As WordTable = wr.CreateTable(6, 3)  
tVal.SetAutoFit  
tVal.SelectCell(0, 0).SetBold(True).AddText("ITEM").ApplyStyle  
tVal.SelectCell(0, 1).SetBold(True).SetAlignment(wr.ALIGN_CENTER).AddText("DESCRIPTION").ApplyStyle  
tVal.SelectCell(0, 2).SetBold(True).AddText("VALUE").ApplyStyle  
  
tVal.AddRow(Array As String("1", "Value of equipment and materials", "$ 0.29"))  
tVal.AddRow(Array As String("2", "Value of labor costs", "$ 10.84"))  
  
tVal.SelectCell(1, 2).SetTextColor(xui.Color_Blue).SetBold(True).ApplyStyle  
tVal.SelectCell(2, 2).SetTextColor(xui.Color_Red).SetBold(True).ApplyStyle  
  
tVal.MergeCellsHorizontal(3, 0, 1)  
tVal.SelectCell(3, 0).SetAlignment(wr.ALIGN_LEFT).AddText("SUB TOTAL").ApplyStyle  
tVal.SelectCell(3, 1).AddText("$ 11.13").ApplyStyle  
  
tVal.MergeCellsHorizontal(4, 0, 1)  
tVal.SelectCell(4, 0).SetAlignment(wr.ALIGN_LEFT).AddText("VAT 15%").ApplyStyle  
tVal.SelectCell(4, 1).AddText("$ 1.67").ApplyStyle  
  
tVal.MergeCellsHorizontal(5, 0, 1)  
tVal.SelectCell(5, 0).SetAlignment(wr.ALIGN_LEFT).SetBold(True).AddText("TOTAL").ApplyStyle  
tVal.SelectCell(5, 1).SetBold(True).AddText("$ 12.80").ApplyStyle.SetBackgroundColor(xui.Color_RGB(93, 201, 165))  
  
wr.CreateParagraph  
  
Dim pFinal As WordParagraph = wr.CreateParagraph  
pFinal.SetSpacingAfterPoints(10)  
pFinal.AddText("In view of the foregoing, we would appreciate initiating and concluding the process for billing the aforementioned values.")  
pFinal.ApplyStyle  
  
wr.Save(File.DirRootExternal, "Final_Loor_Report.docx")  
  
End Sub  
  
Private Sub wr_SaveCompleted(Success As Boolean)  
Log("Word Document Save Success: " & Success)  
End Sub
```