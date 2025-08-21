### Export data from a MS Access database to MS Excel by DMW
### 08/13/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/121191/)

This tutorial shows how we can export data from a MS Access database to MS Excel workbook.  
As a former professional Excel developer I highly recommend to use templates in MS Excel.  
Although jPOI cannot handle real templates (\*.xlt) in MS Excel there are some advantages  
of using a standard workbook as a template:  
  
\* Less code to write  
\* Overcome shortcomings of jPOI  
\* Easier to maintenance  
\* More professional Excel reports are created when using templates.  
  
However, when using formulas and calculation functions in the template files we must be aware  
of that before saving a copy of the template we must force a recalculation of the whole  
workbook. Otherwise the formulas and functions will not be updated. Of course, if it  
something that I like to be added to the jPOI library it is the recalculation. As it is now,  
we need to explicit write Java code to execute the recalculation (see the code below).  
  
The first picture shows the template in use. In the E column a custom formula is  
added. To reduce the code (no need to initialize any Excel object) I have added a  
running number in the first column. By doing so each row is created per definition.  
  
![](https://www.b4x.com/android/forum/attachments/98490)  
  
Personally I dislike to operate with the cell object. Instead I use the row object.  
I have not done any tests to see if the code is executed faster by using only the  
row object.  
  
Anyway, here is the full code:  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
    
    #AdditionalJar: ucanaccess-5.0.0  
    #AdditionalJar: commons-lang3-3.8.1  
    #AdditionalJar: commons-logging-1.2  
    #AdditionalJar: hsqldb-2.5.0  
    #AdditionalJar: jackcess-3.0.1-B4J  
    #IgnoreWarnings: 15  
  
#End Region  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Button1 As B4XView  
    
    Private stTitle As String = $"Export data from MS Access to MS Excel"$  
    
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Title = stTitle  
    MainForm.Show  
End Sub  
  
Sub Button1_Click  
    AddDataToReport   
End Sub  
  
Private Sub AddDataToReport()  
    
    Dim aSQL As SQL  
    Dim Cursor As ResultSet  
    
    Dim wbData As PoiWorkbook  
    Dim wsData As PoiSheet  
    Dim row As PoiRow  
        
        
    Dim stWBook As String = $"Order_Report.xlsx"$  
    Dim stReport As String = $"SELECT [ID], [Quantity], [Unit Cost] FROM [Purchase Order Details];"$  
    Dim inRow As Int = 1 'Starting from the 2nd row in the sheet.  
    Dim inRowFormula As Int = 0 'Counter for adding formulas in the last column E (Total Amount).  
    
    Dim stDriver As String = $"net.ucanaccess.jdbc.UcanaccessDriver"$  
    Dim stURL As String = $"jdbc:ucanaccess://C:\Users\consu\Favorites\Documents\Access DBs\NW.accdb"$  
    
    Try  
            
        aSQL.Initialize(stDriver,stURL)  
    
        wbData.InitializeExisting(File.DirApp,stWBook,"")  
        wsData = wbData.GetSheet(0)  
    
         Cursor = aSQL.ExecQuery(stReport)  
  
        Do While Cursor.NextRow  
    
            inRowFormula = inRowFormula + 1  
        
            row = wsData.GetRow(inRow)  
            row.GetCell(1).ValueNumeric = Cursor.GetInt("ID")  
            row.GetCell(2).ValueNumeric = Cursor.GetInt("Quantity")  
            row.GetCell(3).ValueNumeric = Cursor.GetDouble("Unit Cost")  
            
            inRow = inRow +1  
            
        Loop  
    
        Cursor.Close  
    
        'Force recalculation to update formulas in the workbook.  
        Dim joXL As JavaObject = wbData  
        joXL.RunMethod("setForceFormulaRecalculation", Array (True))  
        
        'By using date & time stamps in the file name we create unique reportfiles.  
        DateTime.DateFormat= "MMddyy"  
        DateTime.TimeFormat="HHmmss"  
                
        Dim stFileName As String = $"Order_Report_$Date{DateTime.Now}_$Time{DateTime.Now}.xlsx"$  
    
        wbData.Save(File.DirApp,stFileName)  
        wbData.Close  
    
        xui.MsgboxAsync($"Data Export successful!"$,stTitle)  
  
    Catch  
        
        Log(LastException)  
        xui.MsgboxAsync($"Unable to execute the instructions!"$, stTitle)  
  
    End Try
```

  
  
The below picture shows the result after executing the code:  
![](https://www.b4x.com/android/forum/attachments/98491)  
  
Enjoy!