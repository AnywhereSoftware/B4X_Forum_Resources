### SQL Server with no-ip by Wendell Carneiro Mendes
### 12/31/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/126052/)

Good morning everyone,  
I would like to thank you for the library, it helped me a lot.  
I don't know if anyone has done this but I managed to adapt it on my system to access SQL SERVER remotely.  
Using no-ip and dynamic port …  
I know the use of dynamic Port has already been explained, but maybe it will help someone.  
  

```B4X
#AdditionalJar: jtds-1.3.1.jar  
  
Sub Process_Globals  
    Public msSQLDADOS As JdbcSQL  
    Private MSLocation As String  
    Private MSUsername As String  
    Private MSPassword As String  
    Private MSPort As String  
    Private lbMyConexion as Label  
End Sub  
  
Sub Globals  
    Private driver As String = "net.sourceforge.jtds.jdbc.Driver"  
    Private bdDADOS As String  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("1")  
    MSLocation = "test.ddns.net"  
    MSUsername = "sa"  
    MSPassword = "******"  
    MSPort = "51434"  
  
    ProgressDialogShow("Conectando ao Banco de Dados")  
        bdDADOS = "jdbc:jtds:sqlserver://" & MSLocation & ":" & MSPort & "/DADOS"  
        msSQLDADOS.InitializeAsync("msSQLDADOS", driver, bdDADOS, MSUsername, MSPassword)  
    ProgressDialogHide  
End Sub  
  
Sub LoadVendedor  
    ProgressDialogShow("Loading…")  
        Dim sf As Object = msSQLDADOS.ExecQueryAsync("msSQLDADOS", "SELECT * FROM Vendedores", Null)  
        Wait For (sf) msSQLDADOS_QueryComplete (Success As Boolean, Crsr As JdbcResultSet)  
        If Success = True Then  
            Do While Crsr.NextRow  
                lbNomeVendedor.Text = Crsr.GetString("Nome do Vendedor")  
            Loop  
        End If  
    ProgressDialogHide  
End Sub  
  
Sub msSQLDADOS_Ready (Success As Boolean)  
    If Success = False Then  
        ToastMessageShow("Error connecting to " & bdDADOS, True)  
        Log(LastException)  
        Return  
    End If  
    lbMyConexion.Text = MSLocation & ":" & MSPort  
  
    ProgressDialogHide  
End Sub
```

  
  
Espero que ajude…