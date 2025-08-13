###  Server picture File to B4XImageView VIA SQL Server by MrKim
### 08/15/2023
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/149598/)

Thought I would share this. Sometimes it is just easier to go SQL direct rather than a jrdc server. I can get binary files from the server usually directly, but not always and enabling SMB1 is required and a security risk some clients aren't willing to go for.  
  
This solution is designed for LOCAL networks and works both wired and wireless.  
  
Below is an SQL Server Function that will return a BLOB when passed a filespec and B4X code that will turn that BLOB into an image.  
Also, the T-SQL function has not been ESCAPED for quotes, Single quotes, etc. SO if the FileSpec has these characters it will probably fail. We don't allow our customers to use these characters so it is not an issue for us  
Note what I have is B4J and B4A. Haven't done B4i.  

```B4X
USE [SkDataDemo44]  
GO  
  
/****** Object:  StoredProcedure [dbo].[GetDocFileBinary]    Script Date: 8/14/23 11:45:26 PM ******/  
SET ANSI_NULLS ON  
GO  
  
SET QUOTED_IDENTIFIER ON  
GO  
  
CREATE PROCEDURE [dbo].[GetDocFileBinary] @FileName NVARCHAR(255)  
AS  
BEGIN  
    –SET @FileName  = 'D:\New folder\YourFile.bmp'     –For Testing  
    –SET @FileName = 'D:\YourDir\YourFile.bmp'     –For Testing  
  
BEGIN TRY  
    DECLARE @Pic varbinary(max)  
    DECLARE @SQL NVARCHAR(1000) = '(SELECT @Pic2 = CAST(bulkcolumn AS varbinary(MAX)) FROM OPENROWSET(BULK ''' + @FileName + ''', SINGLE_BLOB) AS ROW_SET)'  
    EXEC sp_executesql @SQL,  N'@Pic2 varbinary(max) OUTPUT', @Pic2 = @Pic OUTPUT;  
    SELECT 'SUCCESS' Result, @Pic Picture –, LEN(@Pic);  
END TRY  
BEGIN CATCH  
SELECT  
    'Failed' Result,  
    ERROR_NUMBER() AS ErrorNumber,  
    ERROR_STATE() AS ErrorState,  
    ERROR_SEVERITY() AS ErrorSeverity,  
    ERROR_PROCEDURE() AS ErrorProcedure,  
    ERROR_LINE() AS ErrorLine,  
    ERROR_MESSAGE() AS ErrorMessage;  
END CATCH;  
END  
GO
```

  
  
You can test this in management studio with:  

```B4X
GetDocFileBinary 'D:\YourFilePath\YourFileName.bmp';
```

  
YOU MUST MAKE SURE YOU HAVE SQL SERVER RIGHTS TO THE FILES!  
If it fails you will get something like this:  

```B4X
Cannot bulk load. The file "D:\YourFilePath\YourFileName.bmp" does not exist or you don't have file access rights.    4860    1    16    NULL    1
```

  
Success will look like this:  

```B4X
SUCCESS    0x424DB6F00400000000003600000028000000190100002001000001002000000000………
```

  
Note that it is my habit in Server Side functions that return small amounts of data to ALWAYS make the first column 'Result' and return either SUCCESS or Failed, or the error message. Makes it easy to know what to do. I ALWAYS return one record. Sometimes it is 'Failed' and column 2 is 'No Data'  
  
Below is the B4A/B4J code to set a B4XImageView. You will need to write your own code to retrieve the data, I have my own way of doing things. I have a routine that gets the data and returns it as a list of maps. This gives me the equivalent of a forward and backwards recordset.  
The Important thing is Res As JdbcResultSet …. Res.GetBlob("Picture")  
  

```B4X
Class_Globals  
    Private TravPic As B4XImageView  
  
.  
.  
'You will need to modify this code to get the data  
Wait For (MP.Ethernet.Getdata("GetDocFileBinary", Array("D:\YourFilePath\YourFileName.JPG"))) Complete (DataRows As List)  
If Not(DataRows.Get(0).As(String).Contains("Request Failed")) Then  
    Dim TMap As Map = DataRows.Get(0)  
    If TMap.Get("Result").As(String).EqualsIgnoreCase("SUCCESS") Then  
'here is where your Res.GetBlob("Picture")  
         Dim Buffer() As Byte  = TMap.Get("Picture")   'here is where your Res.GetBlob("Picture") should go  
        Dim InputStream1 As InputStream  
        InputStream1.InitializeFromBytesArray(Buffer, 0, Buffer.Length)  
        #If B4J  
            Dim Bmp As Image  
            Bmp.Initialize2(InputStream1)  
        #Else  
            Dim Buffer() As Byte  = TMap.Get("Picture")  
            Dim InputStream1 As InputStream  
            InputStream1.InitializeFromBytesArray(Buffer, 0, Buffer.Length)  
            Dim Bmp As Bitmap  
            Bmp.Initialize2(InputStream1)  
            InputStream1.Close  
        #End If  
        TravPic.Bitmap = Bmp  
        TravPic.ResizeMode = "FIT"  
        TravPic.mBase.Visible = True  
    End If  
End If
```

  
  
Hope someone finds this useful.  
If you spot a better way to do any of this I am all ears. Seems like there ought to be a way to turn a BLOB into an image without the #If B4.