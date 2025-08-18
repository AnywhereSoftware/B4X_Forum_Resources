### extDBUtils by Guenter Becker
### 07/08/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/132346/)

Warm welcome to the audiance I hope you are well.  
  
Since Erel published DBUtils development of database driven app has become much easier. Very good job done! But who says that good work could not be polished up to get better? Every time I am using DBUtils I have to develop addional functionality for example to deal with datetime, images, crypto or to retrieve special information like a table row Id. This forces me to take the DBUtils lib Version 2.11 and decompressed it to get the real code to enhance it's functionality.  
  
**Notice!  
I did not touch any basic functions of the DBUtils 2.11 Code from Erel! Use this functions in the same way as before.**  
My Code includes the code from Erels DBUtils and adds seperate additional subs/functions.  
If DBUtils 2.11 is updated I will update *extDBUtils* as well.  
  
**Name:** extDBUtils.b4xlib  
**Version:** 1.5, 06/2021  
**Licence:** same as Erels DBUtils  
  
***extDBUtils* extended Functions overview:**  

- **Provide needed Maps and List (SQLValues, SQLWhere, SQLValuesList) for basic functions**
- **Convert Date or Time Strings to Ticks and vice versa** to store/retrive Date or Time in a BigInt Datacolumn.
- **Convert Bitmap/Image type JPG or PNG and vice versa** to store/ retrive Imagedata in a Blob Datacolumn.
- **Encrypt/Decrypt Information** to store/retrive AES Encryption to Blob Datacolumn.
- **Retrive rowid** from a named table row.
- **Retrive max/min/avg/sum value** from a given Datacolumn.
- **Retrive information to check if named value is unique** in the named Datacolumns to avoid unique violations.
- **Clean Database** to release occupied space from deleted record and repair instable file structure.
- **Open Methode A: Copy Database file to accessable Folder and open it**.
- **Open Methode B: Delete copied Database and Copy changed Database file to accessable Folder and open it (For testing situations if database structure has changed)**.
- **Close Database**

  
The new lib is testet by using B4A but might also work under B4X (not tested).  
To learn or examin code of extended functionality please use the example B4A Project it includes the lib as code module.  
  

```B4X
' ###### TEST extended features #####  
    ' a) opens the database and initialize maps and list  
    ' this will initialize global extDBUtils.sqlDB. use this global  
    ' to set the SQL Parameter in the basic DBUtils functions like  
    ' extDBUtils.InsertMaps(SQL…. -> extDBUtils.InsertMaps(extDBUtils.sqlDB,….  
    ' use globals:  
    ' extDBUtils.SQLValues MAP to transfer Values  
    ' extDBUtils.SQLWhere MAP to transfer WHERE clause values  
    ' extDBUtils.SQLValuesList List to transfer list of SQLValues Maps  
    ' equal to the basic DBUtils functions  
    Log( "DB open: " & extDBUtils.openDB("TEST.db",False,False))  
      
    ' b) clean DB  
    Log("Size new/old: " & extDBUtils.cleanDB("TEST.db"))  
    Log("——-")  
    ' c) Date abd Time Functions  
    DtFunc("yyyy/MM/dd","2021/06/01","HH:mm","13:30")  
    Log("——-")  
      
    ' d) Encrption/Decryption  
    Dim resBlob() As Byte = extDBUtils.EncryptText("Welcome Friend","Good luck")  
    Dim resBlob() As Byte = extDBUtils.EncryptText("Welcome Friend","Good luck")  
    Log(extDBUtils.DecryptText(resBlob,"Good luck"))  
    Log("——-")  
      
    ' e) image  
    ' examin variables for value  
    Dim imgIN, imgOut As Bitmap  
    Dim imgBlob() As Byte  
    imgIN.Initialize(File.DirAssets,"attention.png")  
    imgBlob = extDBUtils.Image2Blob(imgIN,True)  
    Log("Blob Buffer: " & imgBlob.Length)  
    imgOut = extDBUtils.Blob2Image(imgBlob)  
    Log("Image: " & imgOut.Height & " x " & imgOut.Width)  
    Log("——-")  
      
    ' f) isUnique  
    extDBUtils.SQLWHERE.Clear  
    extDBUtils.sqlwhere.put("TextColumn","ABCDEF")  
    Log("unique value:" & extDBUtils.isUnique("TestTable"))  
    Log("——-")  
      
    ' g) get row ID  
    extDBUtils.SQLWHERE.Clear  
    extDBUtils.sqlwhere.put("TextColumn","ABCDEF")  
    Log("rowID = " & extDBUtils.getRowID("TestTable"))  
    Log("——-")  
      
    ' h1) calc column values over all  
    extDBUtils.SQLWHERE.Clear  
    Log(extDBUtils.calcValue("avg","TestTable","IntegerColumn"))  
    Log(extDBUtils.calcValue("max","TestTable","IntegerColumn"))  
    Log(extDBUtils.calcValue("min","TestTable","IntegerColumn"))  
    Log(extDBUtils.calcValue("sum","TestTable","IntegerColumn"))  
    Log("——-")  
      
    ' x) close db  
    extDBUtils.closeDB
```