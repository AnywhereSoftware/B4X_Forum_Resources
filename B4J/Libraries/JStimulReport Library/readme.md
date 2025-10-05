### JStimulReport Library by shahryarifar
### 10/02/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/168892/)

Hello everyone,   
  
Based on my own needs, I have created a **B4J library** that allows you to use Stimulsoft Reports inside your B4J applications.   
With this library, you can easily **design, render, show and print reports** directly in your app.   
  
✅ I tested it on **Windows, macOS, and Linux** – it works perfectly on all platforms.   
  

---

  
  
  
**🔧 How to use:**   
1. Copy the files from the [lib](https://www.dropbox.com/scl/fi/4u5mvzx9xlj2iomjwckck/Lib.zip?rlkey=c2z4dq9kkitrgg0it53xjc8fg&st=hogb9z7v&dl=0) folder into your **B4J Libraries** folder.   
2. Design your report with **Stimulsoft Designer**.   
3. Load the report file in your code using the LoadReport method.   
  
The library is very simple and practical, you just need to check the available methods.   
  

---

  

```B4X
#Region Project Attributes   
    #MainFormWidth: 600  
    #MainFormHeight: 600   
    #AdditionalJar: sqlite-jdbc-3.7.2  
#End Region  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private tblCustomers As TableView  
    Private txtTitle As TextField  
    Private sql As SQL  
    Private ReportData As List  
    Dim rep As StimulReport  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
      
    If File.Exists(File.DirApp ,"db.db") = False Then File.Copy(File.DirAssets ,"db.db",File.DirApp ,"db.db")  
    sql.InitializeSQLite(File.DirApp ,"db.db",False)  
      
    ReportData.Initialize  
      
    rep.Initialize  
    rep.LicenseKey  = "YOUR_LICENSE_KEY"   
      
      
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1") 'Load the layout file.  
       
    tblCustomers.SetColumns(Array As String( "ID", "Name", "Phone", "Address"))  
    tblCustomers.SetColumnWidth(0,50)  
    tblCustomers.SetColumnWidth(1,150)  
    tblCustomers.SetColumnWidth(3,300)  
      
      
    MainForm.Show  
      
    Dim res As ResultSet  
    res= sql.ExecQuery("select *  from Customers")  
      
    Do While res.NextRow  
        tblCustomers.Items.Add(Array (res.GetInt("CustomerID"),res.GetString("CustomerName"),res.GetString("CustomerPhone"),res.GetString("CustomerAddress")))  
        Dim mp As Map = CreateMap("CustomerID":res.GetInt("CustomerID"),"CustomerName":res.GetString("CustomerName"),"CustomerPhone":res.GetString("CustomerPhone"),"CustomerAddress":res.GetString("CustomerAddress"))  
        ReportData.Add(mp) 'fill report data  
    Loop  
End Sub  
  
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean  
    Return True  
End Sub  
  
Sub btnShowReport_Click  
    rep.LoadReport(File.Combine(File.DirApp ,"Report.mrt"))  
    rep.SetVariable("ReportLogo",fx.LoadImage(File.DirAssets , "logo.png"))  
    rep.SetVariable("ReportTitle",txtTitle.Text)  
    rep.SetVariable("ReportDate","Date: " & DateTime.Date(DateTime.Now))  
      
    rep.RegData(ReportData,"Data","Customers")  
    rep.Render (True)  
    rep.ShowReport("Stimulsoft Report Viewer")  
    rep.Reset   
End Sub  
  
Sub btnDirectPrint_Click  
    rep.LoadReport(File.Combine(File.DirApp ,"Report.mrt"))  
    rep.SetVariable("ReportLogo",fx.LoadImage(File.DirAssets , "logo.png"))  
    rep.SetVariable("ReportTitle",txtTitle.Text)  
    rep.SetVariable("ReportDate","Date: " & DateTime.Date(DateTime.Now))  
      
    rep.RegData(ReportData,"Data","Customers")  
    rep.Render (True)  
    rep.PrintReport(True)  
    rep.Reset  
End Sub  
  
Sub btnJsonData_Click  
    rep.LoadReport(File.Combine(File.DirApp ,"Report.mrt"))  
    rep.SetVariable("ReportLogo",fx.LoadImage(File.DirAssets , "logo.png"))  
    rep.SetVariable("ReportTitle","Customers 1list From Json")  
    rep.SetVariable("ReportDate","Date: " & DateTime.Date(DateTime.Now))  
      
    rep.RegJsonData(File.ReadString(File.DirAssets,"Customers.json"),"Data")  
    rep.Render (True)  
    rep.ShowReport("Stimulsoft Report Viewer From Json")  
    rep.Reset  
End Sub
```

  
  
Thanks to the **B4X team and community** 🙏