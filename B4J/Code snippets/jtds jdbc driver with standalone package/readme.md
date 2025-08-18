### jtds jdbc driver with standalone package by Erel
### 08/25/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/133728/)

1. Download the attached zip. Put the jar file in the additional libraries folder and Charsets.properties in your project folder.  
2. jtds-1.3.1-a.jar replaces jtds-1.3.1.jar.  

```B4X
#AdditionalJar: jtds-1.3.1-a  
#CustomBuildAction: After Packager, %WINDIR%\System32\robocopy.exe, ..\ temp\build\bin\ Charsets.properties
```

  
  
Full example:  

```B4X
#AdditionalJar: jtds-1.3.1-a  
#CustomBuildAction: After Packager, %WINDIR%\System32\robocopy.exe, ..\ temp\build\bin\ Charsets.properties  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Button1 As B4XView  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
    Dim sql As SQL  
    sql.Initialize("net.sourceforge.jtds.jdbc.Driver", "jdbc:jtds:sqlserver://localhost:1433/test;instance=SQLEXPRESS;?user=test&password=test")  
    For i = 1 To 10  
        sql.AddNonQueryToBatch("INSERT INTO table1 VALUES(?, ?)", Array(i.As(String), i))  
    Next  
    Dim SenderFilter As Object = sql.ExecNonQueryBatch("SQL")  
    Wait For (SenderFilter) SQL_NonQueryComplete (Success As Boolean)  
    Log("NonQuery: " & Success)  
End Sub
```

  
  
If you get an error such as: "SSO Failed: Native SSPI library not loaded" then you should download the package: <https://sourceforge.net/projects/jtds/files/latest/download>  
Copy x64\sso\ntlmauth.dll to Windows\System32.