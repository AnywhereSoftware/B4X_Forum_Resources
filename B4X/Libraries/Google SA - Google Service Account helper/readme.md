###  Google SA - Google Service Account helper by gladosxe
### 07/05/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171465/)

I originally created this library for a friend to work with Google Sheets using a service account. Now I'm wondering what to do with the code. It would be a shame to throw it away, so I've decided to make it public. I might even continue working on it for a while if there's enough interest, as I haven't found anything similar online (although I could be wrong, so feel free to correct me).  
  
For those who don't know, a service account provides direct access to your Google data (of course, only the data you explicitly grant access to). No annoying sign-in screens and no need to configure countless OAuth settings.  
  
So here's my question: **Would anyone be interested in a library like this?**  
  
Maybe someone would even be willing to turn it into a proper library for all B4X platforms and continue developing and maintaining it. I'm releasing the code completely free of charge, and you're welcome to do whatever you like with it.  
  
At the moment, everything is available on this simple website:  
  
<https://sites.google.com/view/glados/b4x>  
  
There you'll find the library itself, the documentation, and an example project.  
  
If you'd like to try it, here's a quick guide:  

1. Create a service account JSON file. Enable the Google Sheets API, download the credentials, and rename the file to **service.json**.
2. Create a Google Spreadsheet and share it with your service account (that's the long email address that was generated in the first step). Make a note of your spreadsheet ID.
3. Create a new B4X project.
4. Extract the library ZIP file into your project's main folder and link the BAS file to your project.
5. Copy **service.json** into the **Files** folder.
6. Use the example from my website as a starting point, or write your own code. Just don't forget to replace the spreadsheet ID in the code with your own.

That's it. I hope you get it up and running, and if you run into any issues, I'm sure the community will be happy to help.  
  

```B4X
' ============================================================  
' GoogleSA - Google Service Account helper  
'  
' Setup:  
'   Dim GSA As GoogleSA  
'   GSA.Initialize("GSA", Me)          ' "GSA" is the event-name prefix  
'   GSA.LoadCredentialsFromJson(File.ReadString(File.DirAssets, "service.json"))  
'  
' ── READ a sheet range ────────────────────────────────────────  
'   GSA.FetchSheet(SpreadsheetId, "Sheet1", "A1:E10")  ' specific range  
'   GSA.FetchSheet(SpreadsheetId, "Sheet1", "")         ' entire sheet (empty range)  
'   Wait For GSA_SheetReady(Result As Map)  
'   If Result.Get("Success") Then  
'       Dim Rows As List = Result.Get("Rows")   ' List of Lists  
'       …  
'   Else  
'       Log("Error: " & Result.Get("Error"))  
'   End If  
'  
' ── WRITE cells ───────────────────────────────────────────────  
'   Data is a List of Lists (rows → columns). Values can be  
'   String or Number (B4X numeric types).  
'  
'   SheetRange:  
'     single cell  "B3"      → top-left anchor, data expands freely  
'     range        "B3:E10" → data is clipped to fit the range  
'  
'   Locale controls number formatting:  
'     "DOT"   – decimal point  (1234.56)  USER_ENTERED  
'     "COMMA" – decimal comma  (1234,56)  USER_ENTERED  
'     "RAW"   – JSON numbers   (1234.56)  RAW (no sheet parsing)  
'  
'   Dim Rows As List  
'   Rows.Initialize  
'   Dim R1 As List : R1.Initialize : R1.Add("Name") : R1.Add("Score")  
'   Dim R2 As List : R2.Initialize : R2.Add("Alice") : R2.Add(9.5)  
'   Rows.Add(R1) : Rows.Add(R2)  
'   GSA.UpdateCells(SpreadsheetId, "Sheet1", "B3", Rows, "DOT")  
'   Wait For GSA_UpdateComplete(Result As Map)  
'   If Result.Get("Success") Then  
'       Log("Updated cells: " & Result.Get("UpdatedCells"))  
'   Else  
'       Log("Error: " & Result.Get("Error"))  
'   End If  
'  
' ── ADD rows ──────────────────────────────────────────────────  
'   GSA.AddRows(SpreadsheetId, "Sheet1", 3, 2, True)  
'   ' inserts 2 blank rows above row 3  
'   Wait For GSA_RowsAdded(Result As Map)  
'   If Result.Get("Success") Then  
'       Log("Rows inserted.")  
'   Else  
'       Log("Error: " & Result.Get("Error"))  
'   End If  
'  
' ── DELETE rows ───────────────────────────────────────────────  
'   GSA.DeleteRows(SpreadsheetId, "Sheet1", 3, 2)  
'   ' deletes 2 rows starting at row 3  
'   Wait For GSA_RowsDeleted(Result As Map)  
'   If Result.Get("Success") Then  
'       Log("Rows deleted.")  
'   Else  
'       Log("Error: " & Result.Get("Error"))  
'   End If  
'  
' ── ADD columns ────────────────────────────────────────────  
'   GSA.AddCols(SpreadsheetId, "Sheet1", 5, 3, True)  
'   ' inserts 3 blank columns to the left of column 5 (E)  
'   Wait For GSA_ColsAdded(Result As Map)  
'   If Result.Get("Success") Then  
'       Log("Columns inserted.")  
'   Else  
'       Log("Error: " & Result.Get("Error"))  
'   End If  
'  
' ── DELETE columns ─────────────────────────────────────────  
'   GSA.DeleteCols(SpreadsheetId, "Sheet1", 5, 3)  
'   ' deletes 3 columns starting at column 5 (E)  
'   Wait For GSA_ColsDeleted(Result As Map)  
'   If Result.Get("Success") Then  
'       Log("Columns deleted.")  
'   Else  
'       Log("Error: " & Result.Get("Error"))  
'   End If  
'  
' ── CREATE SHEET ───────────────────────────────────────────  
'   GSA.CreateSheet(SpreadsheetId, "NewTab")  
'   ' creates a new sheet tab; if the tab already exists returns Success=True, AlreadyExists=True  
'   Wait For GSA_SheetCreated(Result As Map)  
'   If Result.Get("Success") Then  
'       If Result.Get("AlreadyExists") Then  
'           Log("Sheet already existed.")  
'       Else  
'           Log("Sheet created.")  
'       End If  
'   Else  
'       Log("Error: " & Result.Get("Error"))  
'   End If  
'  
' ── DELETE SHEET ───────────────────────────────────────────  
'   GSA.DeleteSheet(SpreadsheetId, "OldTab")  
'   ' deletes a sheet tab; if the tab does not exist returns Success=False  
'   Wait For GSA_SheetDeleted(Result As Map)  
'   If Result.Get("Success") Then  
'       Log("Sheet deleted.")  
'   Else  
'       Log("Error: " & Result.Get("Error"))  
'   End If  
'  
' NOTE: To use different event prefixes for multiple instances:  
'   GSA1.Initialize("Accounts", Me)  → Wait For Accounts_SheetReady / Accounts_UpdateComplete  
'                                         Accounts_RowsAdded / Accounts_RowsDeleted  
'                                         Accounts_ColsAdded / Accounts_ColsDeleted  
'                                         Accounts_SheetCreated / Accounts_SheetDeleted  
'   GSA2.Initialize("Products", Me)  → Wait For Products_SheetReady / Products_UpdateComplete  
'                                         Products_RowsAdded / Products_RowsDeleted  
'                                         Products_ColsAdded / Products_ColsDeleted  
'                                         Products_SheetCreated / Products_SheetDeleted  
' ============================================================
```

  
  

```B4X
#Region Shared Files  
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"  
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True  
#End Region  
  
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip  
  
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private GSA As GoogleSA  
    Dim SpreadsheetId As String  
End Sub  
  
Public Sub Initialize  
'    B4XPages.GetManager.LogEvents = True  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
  
    ' Initialise the GoogleSA library and load credentials  
    GSA.Initialize("GSA", Me)  
    If File.Exists(File.DirAssets, "service.json") = False Then  
        Log("ERROR: service.json not found in the Files folder!")  
        Return  
    End If  
    If GSA.LoadCredentialsFromJson(File.ReadString(File.DirAssets, "service.json")) = False Then  
        Log("ERROR: Failed to load service account credentials.")  
    End If  
    SpreadsheetId = " * * * your spreadsheet ID * * * "  
End Sub  
  
' TEST: Read and log the contents from sheet TestSheet  
Private Sub Button1_Click  
    Dim SheetName As String = "TestSheet"  
    Dim SheetRange As String = ""  
    Log("Fetching sheet: " & SheetName & "  from: " & SpreadsheetId & "  range: " & SheetRange)  
    GSA.FetchSheet(SpreadsheetId, SheetName, SheetRange)  
    Wait For GSA_SheetReady(Result As Map)  
    Dim RSheetName As String = Result.Get("SheetName")  
    If Result.Get("Success") = False Then  
        Log("ERROR [" & RSheetName & "]: " & Result.Get("Error"))  
        Return  
    End If  
    Dim Rows As List = Result.Get("Rows")  
    If Rows.Size = 0 Then  
        Log("[" & RSheetName & "] contains no data.")  
        Return  
    End If  
    Log("SUCCESS [" & RSheetName & "]: " & Rows.Size & " rows received.")  
    For i = 0 To Rows.Size - 1  
        Log($"Row ${i}: ${Rows.Get(i)}"$)  
    Next  
End Sub  
  
' TEST: Write sample data (header + 3 rows) to TestSheet starting at cell B3  
Private Sub Button2_Click  
    ' Build sample data: header row + 3 data rows, written from cell B3  
    Dim Rows As List  
    Rows.Initialize  
  
    Dim Header As List : Header.Initialize  
    Header.Add("Product") : Header.Add("Qty") : Header.Add("Price") : Header.Add("Total")  
    Rows.Add(Header)  
  
    Dim R1 As List : R1.Initialize  
    R1.Add("Widget A") : R1.Add(10) : R1.Add(3.99) : R1.Add(39.90)  
    Rows.Add(R1)  
  
    Dim R2 As List : R2.Initialize  
    R2.Add("Widget B") : R2.Add(5) : R2.Add(12.50) : R2.Add(62.50)  
    Rows.Add(R2)  
  
    Dim R3 As List : R3.Initialize  
    R3.Add("Widget C") : R3.Add(20) : R3.Add(1.75) : R3.Add(35.00)  
    Rows.Add(R3)  
  
    Log("Writing sample data to TestSheet!B3 …")  
    GSA.UpdateCells(SpreadsheetId, "TestSheet", "B3", Rows, "COMMA")  
    Wait For GSA_UpdateComplete(Result As Map)  
    Dim SheetName As String = Result.Get("SheetName")  
    If Result.Get("Success") = False Then  
        Log("UPDATE ERROR [" & SheetName & "]: " & Result.Get("Error"))  
        Return  
    End If  
    Log("UPDATE OK [" & SheetName & "]: " & Result.Get("UpdatedCells") & " cells written.")  
End Sub  
  
' TEST: Insert 2 blank rows above row 5 in TestSheet  
Private Sub Button3_Click  
    Log("Inserting 2 rows above row 5 in TestSheet …")  
    GSA.AddRows(SpreadsheetId, "TestSheet", 5, 2, True)  
    Wait For GSA_RowsAdded(Result As Map)  
    Dim SheetName As String = Result.Get("SheetName")  
    If Result.Get("Success") = False Then  
        Log("ADD ROWS ERROR [" & SheetName & "]: " & Result.Get("Error"))  
        Return  
    End If  
    Log("ADD ROWS OK [" & SheetName & "]: 2 rows inserted above row 5.")  
End Sub  
  
' TEST: Insert 3 blank columns to the left of column E in TestSheet  
Private Sub Button4_Click  
    ' Insert 3 blank columns to the left of column E (column 5) in TestSheet  
    Log("Inserting 3 columns to the left of column E in TestSheet …")  
    GSA.AddCols(SpreadsheetId, "TestSheet", 5, 3, True)  
    Wait For GSA_ColsAdded(Result As Map)  
    Dim SheetName As String = Result.Get("SheetName")  
    If Result.Get("Success") = False Then  
        Log("ADD COLS ERROR [" & SheetName & "]: " & Result.Get("Error"))  
        Return  
    End If  
    Log("ADD COLS OK [" & SheetName & "]: 3 columns inserted to the left of column E.")  
End Sub  
  
' TEST: Delete 2 rows starting at row 5 in TestSheet  
Private Sub Button5_Click  
    Log("Deleting 2 rows starting at row 5 in TestSheet …")  
    GSA.DeleteRows(SpreadsheetId, "TestSheet", 5, 2)  
    Wait For GSA_RowsDeleted(Result As Map)  
    Dim SheetName As String = Result.Get("SheetName")  
    If Result.Get("Success") = False Then  
        Log("DELETE ROWS ERROR [" & SheetName & "]: " & Result.Get("Error"))  
        Return  
    End If  
    Log("DELETE ROWS OK [" & SheetName & "]: 2 rows deleted starting at row 5.")  
End Sub  
  
' TEST: Delete 3 columns starting at column E in TestSheet  
Private Sub Button6_Click  
    Log("Deleting 3 columns starting at column E in TestSheet …")  
    GSA.DeleteCols(SpreadsheetId, "TestSheet", 5, 3)  
    Wait For GSA_ColsDeleted(Result As Map)  
    Dim SheetName As String = Result.Get("SheetName")  
    If Result.Get("Success") = False Then  
        Log("DELETE COLS ERROR [" & SheetName & "]: " & Result.Get("Error"))  
        Return  
    End If  
    Log("DELETE COLS OK [" & SheetName & "]: 3 columns deleted starting at column E.")  
End Sub  
  
' TEST: Create a new sheet tab "TestSheet" (reports already-exists if it is there)  
Private Sub Button0_Click  
    Dim NewSheet As String = "TestSheet"  
    Log("Creating sheet '" & NewSheet & "' in spreadsheet …")  
    GSA.CreateSheet(SpreadsheetId, NewSheet)  
    Wait For GSA_SheetCreated(Result As Map)  
    Dim SheetName As String = Result.Get("SheetName")  
    If Result.Get("Success") = False Then  
        Log("CREATE SHEET ERROR [" & SheetName & "]: " & Result.Get("Error"))  
        Return  
    End If  
    If Result.Get("AlreadyExists") Then  
        Log("CREATE SHEET [" & SheetName & "]: Sheet already exists, nothing to do.")  
    Else  
        Log("CREATE SHEET OK [" & SheetName & "]: Sheet created successfully.")  
    End If  
End Sub  
  
' TEST: Delete sheet tab "TestSheet" from the spreadsheet  
Private Sub Button8_Click  
    Dim DelSheet As String = "TestSheet"  
    Log("Deleting sheet '" & DelSheet & "' from spreadsheet …")  
    GSA.DeleteSheet(SpreadsheetId, DelSheet)  
    Wait For GSA_SheetDeleted(Result As Map)  
    Dim SheetName As String = Result.Get("SheetName")  
    If Result.Get("Success") = False Then  
        Log("DELETE SHEET ERROR [" & SheetName & "]: " & Result.Get("Error"))  
        Return  
    End If  
    Log("DELETE SHEET OK [" & SheetName & "]: Sheet deleted successfully.")  
End Sub
```