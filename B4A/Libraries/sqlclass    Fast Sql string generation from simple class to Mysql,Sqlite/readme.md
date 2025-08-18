### sqlclass    Fast Sql string generation from simple class to Mysql,Sqlite by Fabio vega
### 02/24/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/128009/)

Hello, every one  
  
I share them the Fast Sql string generation from simple sqlclass  
  

```B4X
    ' insert example Mysql,Sqlite'  
    Sqlcla1.Initialize("Estudiantes")  
    Sqlcla1.AddColString("NombreApellido","name text")  
    Sqlcla1.AddColString("Doc","doc text")  
    Sqlcla1.AddColString("Grado",1)  
    Sqlcla1.AddColString("FechaIngreso","2021-02-21")  
    Sqlcla1.AddColString("Edad",12)  
    Sqlcla1.AddColString("Telefono", "+573014677797" )  
      
    Dim sql As String = Sqlcla1.GetInsertQuery ' Sql para insertar datos  
    ' generate string'  
    ' sql = "Insert Into Estudiantes (NombreApellido,Doc,Grado,FechaIngreso,Edad,Telefono) Values  ('name text','doc text','1','2021-02-21','12','+573014677797');"'  
      
    ' Select Query mysql,sqlite'  
    Dim Sqlcla1 As Sqlclass     
    Sqlcla1.Initialize("Estudiantes")  
    Sqlcla1.AddColString("NombreApellido","")  
    Sqlcla1.AddColString("Doc","")  
    Sqlcla1.AddColString("Grado",1)  
    Sqlcla1.AddColString("FechaIngreso","")  
    Sqlcla1.AddColString("Edad",0)  
    Sqlcla1.AddColString("Telefono", "" )     
    '————- where condtion  
    Sqlcla1.AddColIndex("Idestudiante", 23 )  
    Dim sql As String = Sqlcla1.GetSelectQuery ' Sql generation  
    'sql="Select   NombreApellido,Doc,Grado,FechaIngreso,Edad,Telefono  From Estudiantes Where Idestudiante='23'"'  
      
    'update example Mysql,Sqlite'  
    Dim Sqlcla1 As Sqlclass     
    Sqlcla1.Initialize("Estudiantes")  
    Sqlcla1.AddColString("NombreApellido","name text")  
    Sqlcla1.AddColString("Doc","doc text")  
    Sqlcla1.AddColString("Grado",1)  
    Sqlcla1.AddColString("FechaIngreso","2021-02-21")  
    Sqlcla1.AddColString("Edad",12)  
    Sqlcla1.AddColString("Telefono", "+573014677797" )  
    '————- update col index  
    Sqlcla1.AddColIndex("Idestudiante", 23 )  
      
    Dim sql As String = Sqlcla1.GetUpdateQuery ' Sql get  
    'sql="Update  Estudiantes Set NombreApellido='name text',Doc='doc text',Grado='1',FechaIngreso='2021-02-21',Edad='12',Telefono='+573014677797' Where Idestudiante='23'; "'  
      
    ' Delete Query example Mysql,Sqlite'  
        Dim Sqlcla1 As Sqlclass     
    Sqlcla1.Initialize("Estudiantes")  
    Sqlcla1.AddColString("NombreApellido","name text")  
        '————- update col index  
    Sqlcla1.AddColIndex("Idestudiante", 23 )  
    Dim sql As String = Sqlcla1.GetDeleteQuery  
    'sql="Delete From  Estudiantes Where Idestudiante='23';"'  
      
    ' example Insert Replace Query Sqlite'  
    Dim Sqlcla1 As Sqlclass     
    Sqlcla1.Initialize("Estudiantes")  
    Sqlcla1.AddColString("NombreApellido","name text")  
    Sqlcla1.AddColString("Doc","doc text")  
    Sqlcla1.AddColString("Grado",1)  
    Sqlcla1.AddColString("FechaIngreso","2021-02-21")  
    Sqlcla1.AddColString("Edad",12)  
    Sqlcla1.AddColString("Telefono", "+573014677797" )  
          
    Dim sql As String = Sqlcla1.GetInsertReplaceQuery ' Sql para insertar datos  
      
    'sql="Insert OR REPLACE INTO Estudiantes (NombreApellido,Doc,Grado,FechaIngreso,Edad,Telefono) Values  ('name text','doc text','1','2021-02-21','12','+573014677797');"'  
  
   ' Insert update query Mysql  
Dim Sqlcla1 As Sqlclass  
    Sqlcla1.Initialize("Estudiantes")  
    Sqlcla1.AddColString("NombreApellido","name text")  
    Sqlcla1.AddColString("Doc","doc text")  
    Sqlcla1.AddColString("Grado",1)  
    Sqlcla1.AddColString("FechaIngreso","2021-02-21")  
    Sqlcla1.AddColString("Edad",12)  
    Sqlcla1.AddColString("Telefono", "+573014677797" )   
      
    Dim sql As String = Sqlcla1.GetInsertUpdateQuery ' Sql generation  
  'sql="Insert Into Estudiantes (NombreApellido,Doc,Grado,FechaIngreso,Edad,Telefono) Values  ('name text','doc text','1','2021-02-21','12','+573014677797') ON DUPLICATE KEY UPDATE NombreApellido='name text',Doc='doc text',Grado='1',FechaIngreso='2021-02-21',Edad='12',Telefono='+573014677797' ;"  
  
  
 ' Ing. Fabio Vega  Colombia..
```