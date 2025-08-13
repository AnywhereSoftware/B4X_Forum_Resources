### New library for use with remote MySQL and MariaDB servers using Hikari, for development with B4A and B4J by ANTONIO ALBEIRO VALENCIA
### 05/19/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/167054/)

Hello everyone.  
  
I developed a library to access MySQL and MariaDB servers using Hikari. You can create CRUDs quickly, and the same code is used in B4A/B4J with separate libraries for each platform.  
I've provided an example below; you'll see it's very simple and easy to learn. To get the library, just donate $20. It took us some time to develop and test it, and we'd love to share it with you.  
  
Regards  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private Mysql As MYlibreria  
    Private btnRead As Button  
    Private btnIns As Button  
    Private btnUpd As Button  
End Sub  
  
Public Sub Initialize  
'    B4XPages.GetManager.LogEvents = True  
    Mysql.initialize("MYSQL")  
    Mysql.connectMariaDB("IP", "3306", "mibase", "usuArio", "passwrod")  
    '  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
End Sub  
  
'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.  
  
Private Sub MYSQL_OnError( error As Int, msg As String )  
    Log("Error MySQL" & msg)  
End Sub  
  
Private Sub btnRead_Click  
    If Mysql.isConnected  Then  
        If Mysql.Query("SELECT fecha, serial,cerro,autoriza,suma FROM liquidausuariohc", True) Then ' False = no debug , True = show debug string sql  
            Dim i As Int = 1  
            Dim data As List = Mysql.DataList  
            For i = 0 To data.Size - 1  
                Dim item As Map = data.Get(i)  
          
                Log($" contador  ${i   } Fecha  ${item.Get("fecha")} serial  ${item.Get("serial")} "$)  
          
            Next  
            Mysql.closeQuery  
        End If  
    Else  
        Log("No hubo conexion")  
        Mysql.Reconnect  
    End If  
End Sub  
  
  
Private Sub btnIns_Click  
   
    If Mysql.isConnected  Then  
        Dim cols As Map = CreateMap("fecha": "2025-01-01", "serial": "00000", "autoriza":"00000","suma": "0.00" )  
        Mysql.Insert("liquidausuariohc", cols)  
   
    Else  
        Log("No hubo conexion")  
        Mysql.Reconnect  
    End If  
   
End Sub  
  
Private Sub btnUpd_Click  
   
    If Mysql.isConnected  Then  
   
        Dim str As StringBuilder  
        str.Initialize  
        str.Append("UPDATE liquidausuariohc ")  
        str.Append("SET fecha=%0 ")  
        str.Append("WHERE serial=%1 ")  
        str.Append("LIMIT 1")  
   
        Dim cSql As String = str.ToString  
        cSql = Mysql.StrFormat(cSql, Array As Object(Mysql.Value2Sql("2025-12-31"), 0))  
        Log(cSql)  
        Mysql.Execute(cSql)  
    Else  
        Log("No hubo conexion")  
        Mysql.Reconnect  
    End If  
   
End Sub  
  
Private Sub btnDel_Click  
   
    If Mysql.isConnected  Then  
   
        Dim str As StringBuilder  
        str.Initialize  
        str.Append("DELETE FROM  liquidausuariohc ")  
        str.Append("WHERE serial=%0 ")  
   
   
        Dim cSql As String = str.ToString  
        cSql = Mysql.StrFormat(cSql, Array As Object(0))  
        Log(cSql)  
   
        Mysql.Execute(cSql)  
   
    Else  
        Log("No hubo conexion")  
        Mysql.Reconnect  
    End If  
   
   
End Sub  
  
Sub btnCrea_Click  
    Dim query As String = $"CREATE TABLE IF NOT EXISTS demos  (  
        codigoeve           char(30),  
        tipoeve             char(50),  
        cobro                 decimal(12,2),  
        monto                 decimal(12,2),  
        tarifa                 char(15),  
        idbeneficiario       char(70),  
        beneficiario          char(50),  
        idempresa             char(10),  
        nomempresa              char(50),  
        idrubro             char(25),  
        rubro                 char(50),  
        rechazoz             char(1),  
        maquina             char(50),  
        chofer                 char(50),  
        fecha                 date,  
        hora                 char(10),  
        subio                 char(10),  
        proceso                char(30),  
        autorizacion         char(10)) "$  
   
    Mysql.Execute(query)  
    Log(query)  
End Sub
```

  
  
[PAYPAL](https://www.paypal.com/paypalme/valenciaim5)