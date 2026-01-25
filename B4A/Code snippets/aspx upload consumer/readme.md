### aspx upload consumer by quansofts
### 01/19/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/170054/)

I shared this code in case you need it, this is aspx handller code to consume file upload  

```B4X
<%@ WebHandler Language="VB" Class="UploadHandler" %>  
  
Imports System.IO  
  
Public Class UploadHandler : Implements IHttpHandler  
  
    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest  
        context.Response.ContentType = "text/plain"  
        Dim folderPath As String  
        Dim mPictureFolder As String  
        Dim mTypeFolder As String  
        Dim mItemId As String  
  
        mPictureFolder = Context.Request.QueryString("mPictureFolder")  
        mTypeFolder = Context.Request.QueryString("mTypeFolder")  
        mItemId = Context.Request.QueryString("mItemId")  
  
        ' Kiểm tra nếu có file gửi lên  
        If context.Request.Files.Count > 0 Then  
            Dim uploadedFile As HttpPostedFile = context.Request.Files(0)  
  
            If uploadedFile IsNot Nothing AndAlso uploadedFile.ContentLength > 0 Then  
                ' Pictures folder  
                folderPath = context.Server.MapPath("~/" & mPictureFolder)  
                If Not Directory.Exists(folderPath) Then Directory.CreateDirectory(folderPath)  
  
                ' CashCount folder  
                folderPath = context.Server.MapPath("~/" & mPictureFolder & "/" & mTypeFolder)  
                If Not Directory.Exists(folderPath) Then Directory.CreateDirectory(folderPath)  
  
                'CashCountId folder  
                If mItemId.Trim.Length>0 Then  
                    folderPath = context.Server.MapPath("~/" & mPictureFolder & "/" & mTypeFolder & "/" & mItemId)  
                    If Not Directory.Exists(folderPath) Then Directory.CreateDirectory(folderPath)  
                End If  
  
                ' Lấy tên file gốc  
                Dim fileName As String = Path.GetFileName(uploadedFile.FileName)  
  
                ' Nếu tên file không có extension, thêm .jpg mặc định  
                If String.IsNullOrEmpty(Path.GetExtension(fileName)) Then  
                    fileName &= ".jpg"  
                End If  
  
                ' Ghép đường dẫn đầy đủ  
                Dim savePath As String = Path.Combine(folderPath, fileName)  
  
                ' Lưu file  
                uploadedFile.SaveAs(savePath)  
  
                context.Response.Write("File uploaded successfully: " & fileName)  
            Else  
                context.Response.Write("No file received.")  
            End If  
        Else  
            context.Response.Write("No files in request.")  
        End If  
    End Sub  
  
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable  
        Get  
            Return False  
        End Get  
    End Property  
End Class
```