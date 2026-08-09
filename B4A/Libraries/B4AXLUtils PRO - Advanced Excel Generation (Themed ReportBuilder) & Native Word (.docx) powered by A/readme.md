### B4AXLUtils PRO - Advanced Excel Generation (Themed ReportBuilder) & Native Word (.docx) powered by Apache POI 5.x by fernando1987
### 08/03/2026
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
[HEADING=2]B4AXLUtils Pro Library API Reference Manual[/HEADING]  
This is the complete, comprehensive public API documentation for **B4AXLUtils Pro 3.0**  
  

---

  
[HEADING=2]1. PDF Generation Suite[/HEADING]  
[HEADING=3]PDFManager[/HEADING]  
*High-level PDF document builder and layout engine using native B4X code.*  
  

- **Events**:

- SaveCompleted (Success As Boolean): Raised when the asynchronous compilation finishes.
- PageCreated: Raised whenever a new page is initialized, allowing low-level canvas decoration.

- **Properties**:

- Header As PDFHeader [read only]: Access the automatic page header builder.
- Footer As PDFFooter [read only]: Access the automatic page footer builder.
- PagesCount As Int [read only]: The total number of pages currently in the document.

- **Key Functions**:

- Initialize (Callback As Object, EventName As String, Unit As String) As PDFManager
- SetMargins (Left As Double, Right As Double, Top As Double, Bottom As Double) As PDFManager
- AddParagraph (Text As String) As PDFParagraph
- AddTable () As PDFTable
- AddImage (Dir As String, FileName As String, Width As Double, Height As Double)
- AddImageAbsolute (Dir As String, FileName As String, X As Double, Y As Double, Width As Double, Height As Double)
- Save (Directory As String, FileName As String)

[HEADING=3]PDFTemplateManager[/HEADING]  
*Visual layout decoration engine offering corporate templates.*  
  

- **Functions**:

- DrawPageBackground (ColorInt As Int): Paints the entire page with a solid color.
- DrawFrame (BorderColor As Int, BGColor As Int, BorderWidth As Float): Draws a border frame.
- DrawWaveHeader (ThemeColor As Int): Organic wave-shaped header.
- DrawDiagonalHeader (ThemeColor As Int): Tech-oriented diagonal header.
- DrawSweepHeader (ThemeColor As Int): Elegant curved sweep header.
- DrawRectangleHeader (ThemeColor As Int): Minimalist corporate header.
- DrawCard (X As Double, Y As Double, Width As Double, Height As Double, BGColor As Int, BorderColor As Int, BorderWidth As Float): Draws absolute layout cards.

[HEADING=3]PDFChartHelper[/HEADING]  
*High-definition cross-platform chart generator mapping canvas grids directly to bitmaps.*  
  

- **Properties**:

- ShowGridLines As Boolean: Turns background grids on or off.
- CustomYTicks As List: Sets custom Y-axis markers (e.g. 100, 300, 1000).

- **Functions**:

- CreateLineChart (Title As String, XAxis As List, YValues As List, ValueSuffix As String, Smooth As Boolean, Fill As Boolean) As B4XBitmap
- CreateMultiLineChart (Title As String, XAxis As List, SeriesNames As List, SeriesValues As List, ValueSuffix As String, Smooth As Boolean, Fill As Boolean) As B4XBitmap
- CreateBarChart (Title As String, XAxis As List, YValues As List, ValueSuffix As String) As B4XBitmap
- CreateMultiBarChart (Title As String, XAxis As List, SeriesNames As List, SeriesValues As List, ValueSuffix As String) As B4XBitmap
- CreatePieChart (Title As String, Categories As List, Values As List, ValueSuffix As String) As B4XBitmap
- ClearTempFiles (): Deletes temporary chart PNG files to save storage space.

[HEADING=3]PDFHeader[/HEADING]  
*Represents the automatically rendered page header segment.*  
  

- **Functions**:

- AddParagraph (Text As String) As PDFParagraph
- AddImage (Dir As String, FileName As String, Width As Double, Height As Double)
- AddLine (X1 As Double, Y1 As Double, X2 As Double, Y2 As Double, Width As Double, ColorInt As Int)
- AddLine2 (Width As Double, ColorInt As Int)
- SetHeight (Height As Double)

[HEADING=3]PDFFooter[/HEADING]  
*Represents the automatically rendered page footer segment supporting page number injection.*  
  

- **Functions**:

- AddParagraph (Text As String) As PDFParagraph
- AddImage (Dir As String, FileName As String, Width As Double, Height As Double)
- AddLine (X1 As Double, Y1 As Double, X2 As Double, Y2 As Double, Width As Double, ColorInt As Int)
- AddLine2 (Width As Double, ColorInt As Int)
- SetHeight (Height As Double)

[HEADING=3]PDFParagraph[/HEADING]  
*Builder-pattern text formatting block for PDF paragraph elements.*  
  

- **Properties (Chained Setters)**:

- Bold As Boolean, Italic As Boolean, Underline As Boolean, StrikeThrough As Boolean
- FontSize As Double, TextColor As Int, FontFamily As String, Alignment As String

- **Functions**:

- AddLineBreak () As PDFParagraph
- ApplyStyle () As PDFParagraph

[HEADING=3]PDFTable[/HEADING]  
*Flow-based PDF table structure builder.*  
  

- **Functions**:

- SetColWidths (Widths() As Double) As PDFTable
- AddRow () As PDFTableRow
- AddCell (Row As PDFTableRow, Text As String) As PDFTableCell
- AddCell2 (Row As PDFTableRow, Paragraph As PDFParagraph) As PDFTableCell
- AddCellSpan (Row As PDFTableRow, Text As String, ColSpan As Int) As PDFTableCell

---

  
[HEADING=2]2. Excel Generation Suite[/HEADING]  
[HEADING=3]ExcelManager[/HEADING]  
*POI-based workbook structure manager.*  
  

- **Events**:

- SaveCompleted (Success As Boolean)

- **Properties**:

- ActiveSheetIndex As Int [read only]
- ActiveSheetName As String [read only]

- **Functions**:

- CreateSheet (Name As String) As ExcelSheet
- GetSheet (Name As String) As ExcelSheet
- GetSheetAt (Index As Int) As ExcelSheet
- GetSheetName (Index As Int) As String
- Save (Directory As String, FileName As String)

[HEADING=3]ExcelSheet[/HEADING]  
*Worksheet layout, locking, formatting, and graphics patriarch placement.*  
  

- **Properties**:

- SheetName As String [read only]
- SheetIndex As Int [read only]

- **Functions**:

- GetRow (RowIndex As Int) As ExcelRow
- ProtectSheet (Password As String)
- SetRangeStyle (RowStart As Int, RowEnd As Int, ColStart As Int, ColEnd As Int, Bold As Boolean, Border As Boolean, Centered As Boolean, BGColor As Short, Italic As Boolean, Strike As Boolean, TextColor As Short, Size As Int)
- AddPictureExact (PictureIndex As Int, Col As Int, Row As Int, ScaleX As Double, ScaleY As Double): Positioned image anchored to MOVE\_DONT\_RESIZE.
- AutoSizeColumns (ColStart As Int, ColEnd As Int)

[HEADING=3]ExcelRow[/HEADING]  
*Excel worksheet row manager.*  
  

- **Functions**:

- GetCell (ColIdx As Int) As ExcelCell
- CreateCellTyped (ColIdx As Int, CellType As Int) As ExcelCell

[HEADING=3]ExcelCell[/HEADING]  
*Excel worksheet cell value, formulas, styles, comments, and smart data type detection.*  
  

- **Properties**:

- CellType As Int, CellTypeName As String [read only], Formula As String [write only]
- Value As Object, SmartValue As Object [write only], Date As Long
- Bold As Boolean [write only], Underline As Boolean [write only]
- TextColor As Short [write only], TextSize As Short [write only], BackgroundColor As Short [write only]

- **Functions**:

- clear () As Void
- setCurrency (Value As Double, Symbol As String) As Void
- setCurrencyISO (Value As Double, ISO As String) As Void
- setDateFormatted (Value As Long, FormatStr As String) As Void

[HEADING=3]ExcelReportBuilder[/HEADING]  
*Orchestrates complete spreadsheet reports with theme layouts.*  
  

- **Functions**:

- SetTheme (ThemeName As String)
- SetCustomColors (HeaderBG As Short, HeaderText As Short, ZebraColor As Short)
- SetLogoExactPosition (ColOffset As Int, RowStart As Int, WidthPixels As Int, HeightPixels As Int)
- AddColumn (Name As String, ColType As Int)
- AddColumnEx (Name As String, ColType As Int, FormatOrISO As String)
- AddRow (Values() As Object)
- AddTotalColumn (ColumnIndex As Int)
- Build ()

[HEADING=3]ExcelTableBuilder[/HEADING]  
*Dynamic builder for standalone data tables inside worksheets.*  
  

- **Functions**:

- AddColumn (Name As String, ColType As Int)
- AddColumnEx (Name As String, ColType As Int, FormatOrISO As String)
- AddRow (Values() As Object)
- Build ()

---

  
[HEADING=2]3. Word Generation Suite[/HEADING]  
[HEADING=3]WordManager[/HEADING]  
*DOCX Word document builder.*  
  

- **Events**:

- SaveCompleted (Success As Boolean)

- **Properties**:

- Header As WordHeader [read only]
- Footer As WordFooter [read only]

- **Functions**:

- AddParagraph (Text As String) As WordParagraph
- CreateTable (Rows As Int, Cols As Int) As WordTable
- AddImage (Dir As String, FileName As String, WidthPoints As Float, HeightPoints As Float)
- SearchAndReplace (SearchText As String, ReplaceText As String)
- Save (Directory As String, FileName As String)

[HEADING=3]WordParagraph[/HEADING]  
*Text paragraph and typography style runner.*  
  

- **Properties (Chained Setters)**:

- Bold As Boolean, Italic As Boolean, Underline As Boolean
- FontSize As Int, TextColor As Int, Alignment As String, SpacingAfterPoints As Int

- **Functions**:

- AddText (Text As String) As WordParagraph
- AddLineBreak () As WordParagraph
- AddPageBreak () As WordParagraph
- AddImage (Directory As String, FileName As String, WidthPoints As Int, HeightPoints As Int, Align As String)
- ApplyStyle () As WordParagraph

[HEADING=3]WordTable[/HEADING]  
*Word table formatting, dimensions, padding, borders, and cell spans.*  
  

- **Properties**:

- Bold As Boolean [write only], Italic As Boolean [write only], Underline As Boolean [write only]
- FontSize As Int [write only], TextColor As Int [write only], BackgroundColor As Int [write only]

- **Functions**:

- SelectCell (Row As Int, Col As Int) As WordTable
- AddText (Text As String) As WordTable
- AddRow (Data() As String)
- MergeCellsHorizontal (Row As Int, FromCol As Int, ToCol As Int) As WordTable
- SetCellPadding (TwipsTop As Int, TwipsLeft As Int, TwipsBottom As Int, TwipsRight As Int) As WordTable
- SetBorders () As WordTable
- SetAutoFit () As WordTable

[HEADING=3]WordHeader[/HEADING]  
*Represents the automatically rendered page header segment in Word.*  
  

- **Functions**:

- AddText (Text As String, Bold As Boolean, Size As Int, ColorHex As String)
- AddImage (Directory As String, FileName As String, WidthPoints As Int, HeightPoints As Int)

[HEADING=3]WordFooter[/HEADING]  
*Represents the automatically rendered page footer segment in Word.*  
  

- **Functions**:

- AddText (Text As String, Bold As Boolean, Size As Int, ColorHex As String)
- AddImage (Directory As String, FileName As String, WidthPoints As Int, HeightPoints As Int)

  
  
  
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