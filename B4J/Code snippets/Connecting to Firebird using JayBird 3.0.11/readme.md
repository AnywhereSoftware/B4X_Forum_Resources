### Connecting to Firebird using JayBird 3.0.11 by virpalacios
### 10/25/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/135429/)

Hi, Everyone for all of you that want to connect to Firebird 2.1 here is my code and is 100% functional (Your JayBird version has to be compatible with your java version) in my case Java 8  
I have a very hard time using this version it came with two files jaybird-3.0.11.jar and jaybird-full-3.0.11.jar. I started with the regular one with no success, however using the full version, it works like a charm  
  

```B4X
'Non-UI application (console / server application)  
#Region Project Attributes  
    #CommandLineArgs:  
    #MergeLibraries: True  
#End Region  
    #CommandLineArgs:  
    #MergeLibraries: True  
    #additionaljar:jaybird-full-3.0.11.jar  
Sub Process_Globals  
    Private SQL As SQL  
End Sub  
  
Sub AppStart (Args() As String)  
      
    Private FBUsername As String = "SYSDBA"  
    Private FBPassword As String = "masterkey"  
    SQL.InitializeAsync("FireBirdDB","org.firebirdsql.jdbc.FBDriver","jdbc:firebirdsql://192.168.1.10:3050/C:/sistema/prolacsa.FDB?encoding=WIN1254", FBUsername, FBPassword)  
    StartMessageLoop  
      
End Sub  
Sub FireBirdDB_Ready (Success As Boolean)  
    If Success Then  
        Dim RS As ResultSet = SQL.ExecQuery("SELECT CADENA_DESCRIPCION FROM cadenas")  
        Do While RS.NextRow  
            Log(RS.GetString2(0))  
        Loop  
        RS.Close  
    End If  
    StopMessageLoop 'only required in a console app  
    SQL.Close  
End Sub
```