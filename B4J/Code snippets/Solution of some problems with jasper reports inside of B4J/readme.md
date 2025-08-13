### Solution of some problems with jasper reports inside of B4J by DarkoT
### 06/01/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/161460/)

Hi,  
  
For some time now, I have been dealing with a variety of issues related to Jasper reports in the B4j system. I have been using Jasper Studio for some time, but I have had several issues, mainly related to distributing the project that included Jasper reports. Here are some practical tips that might help solve problems with Jasper reports:  
  
1. The JasperReports2 library is very useful and works well.  
2. A number of issues (especially in the release version) are related to compiling JRxml into a Jasper report if you are doing this within the B4j project. Therefore, I advise using the following instead of the compileXML function:  

```B4X
Private Sub ExecReport As ResumableSub  
  
      
    Dim jasper As JasperReports  
    Dim report As JasperReport  
    Dim print As JasperPrint  
    Dim conn As JasperConnection  
      
    jasper.InitializeParameters  
    ' report = jasper.CompileXML(File.Combine(rptStr.ReportFolder, rptStr.ReportFile))  
    report = jasper.LoadJRReport(File.Combine(rptStr.ReportFolder, rptStr.ReportFile))  
    ' conection type can be mysql or mssql (is in config file)  
    Dim ConnType As String = Utility.GetValueFromTextFile(rptStr.ReportFolder, rptStr.CfgFile, "ConnType")  
      
    If ConnType.ToLowerCase.Contains("mysql") Then  
        conn = jasper.getConnectionMySQL(Main.Server, Main.Port, Main.Db, Main.Username, Main.Password, False)  
    Else  
        conn = jasper.getConnectionMSSQLServerNoInstance(Main.Sql_Server, Main.Sql_Port, Main.Sql_Db, Main.Sql_Username, Main.Sql_Password)  
    End If  
  
      
    Dim Parameter As Map  
    Parameter.Initialize  
  
    ' for all key in option module which is b4xdialog (user can input parameters)  
    For x = 0 To mapOptData.Size -1  
          
        Dim fldType As String = Utility.GetFieldType(rptStr.ReportFolder, rptStr.CfgFile, mapOptData.GetKeyAt(x))  
        Dim strVal As String  
          
        Select Case fldType  
              
            ' convert of date field   
            Case "D"  
                DateTime.DateFormat = "yyyy-MM-dd"  
                Dim value As Long = mapOptData.GetValueAt(x)  
                strVal = DateTime.Date(value)  
            Case Else  
                strVal = mapOptData.GetValueAt(x)  
              
        End Select  
        Parameter.Put(mapOptData.GetKeyAt(x), strVal)  
    Next  
    print = jasper.Print(report, Parameter, conn)  
    jasper.JasperViewer(print, False)  
      
    Return True  
      
End Sub
```

  
  
 a) Create the Jasper report in Jasper Studio and compile it there so that it generates report.jasper. Then, in the source code, instead of using the CompileXML function, simply use loadJRReport. In this case, there is no need to add the Groovy library. I also recommend using Java directly instead of the Groovy language in Jasper Studio. It works faster and better.  
3. When creating a JAR (or a Windows Exe) with the IDE's Build Standalone project function, you need to add to the packager property so the system does not report an error…  
  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 1024  
    #MainFormHeight: 768  
    #AdditionalJar: mysql-connector-java-5.1.48-bin.jar  
    #AdditionalJar: mssql-jdbc-9.4.0.jre11.jar  
    ' #AdditionalJar: groovy-4.0.21.jar  
      
    #PackagerProperty: IconFile = ..\Files\truck.ico  
    #PackagerProperty: ExeName = OptDnCheck  
    #PackagerProperty: VMArgs = –add-opens b4j/net.sf.jasperreports.engine.fill=ALL-UNNAMED  
    ' #PackagerProperty: VMArgs = –add-opens b4j/net.sf.jasperreports.engine.fill=ALL-UNNAMED –add-opens b4j/net.sf.jasperreports.compilers=ALL-UNNAMED  
      
#End Region
```

  
  
  
These are the basic principles I have followed, and the system works without issues - and I certainly recommend it for use…