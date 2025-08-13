### select image from device and upload in server by jaber103
### 06/28/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/161859/)

well hi too all .  
As the title suggests, I want to teach you how to upload photos  
I had searched a lot about it myself and had not found any results. By changing other people's codes, I was able to get the answer and select the photo and send and save it to my host, which is Linux.  
I will give you sample codes, if you have any questions, I am at your service  
firest example cod for select image by library ContentChooser  
  

```B4X
    Dim PicChooser As ContentChooser  
    PicChooser.Initialize("PicChooser")  
    PicChooser.Show("image/*", "Select a pic")
```

  
  
  
Note that in order to get the address of a selected photo, you must use the method below that Eral took pains to use  
  

```B4X
Sub GetPathFromContentResult(UriString As String) As String  
    If UriString.StartsWith("/") Then Return UriString 'If the user used a file manager to choose the image  
    Dim Cursor1 As Cursor  
    Dim Uri1 As Uri  
    Dim Proj() As String = Array As String("_data")  
    Dim cr As ContentResolver  
    cr.Initialize("")  
    If UriString.StartsWith("content://com.android.providers.media.documents") Then  
        Dim i As Int = UriString.IndexOf("%3A")  
        Dim id As String = UriString.SubString(i + 3)  
        Uri1.Parse("content://media/external/images/media")  
        Cursor1 = cr.Query(Uri1, Proj, "_id = ?", Array As String(id), "")  
    Else  
        Uri1.Parse(UriString)  
        Cursor1 = cr.Query(Uri1, Proj, "", Null, "")  
    End If  
    Cursor1.Position = 0  
    Dim res As String  
    res = Cursor1.GetString("_data")  
    Cursor1.Close  
    Return res  
    End Sub
```

  
  
ok   
Well, now we have to use this method  
The contentChooser library uses another method to get the result, which is as follows  

```B4X
Sub PicChooser_Result (Success As Boolean, Dir As String, FileName As String)  
    If Success Then  
        allpaths=Regex.Split("/",  GetPathFromContentResult(FileName))  
        directionselectimage= GetPathFromContentResult(FileName).Replace(allpaths(allpaths.Length-1),"")  
         File.Copy(directionselectimage,allpaths(allpaths.Length-1),File.DirRootExternal,allpaths(allpaths.Length-1))  
   
   '    This code is for displaying the selected photo with imageview  
   '     Dim bmp As Bitmap  
   '     bmp.Initialize(directionselectimage, allpaths(allpaths.Length-1))  
   '     imgviewpostupload.SetBitmap(bmp)  
  
  Else  
        If LastException.IsInitialized Then ToastMessageShow(LastException.Message, True)  
    End If  
End Sub
```

  
  
  
Well, now we go to the button to send information. Note: You can send unlimited information, that is, as you are sending the photo, you can also send other information. I will now give you the sample code. The type of sending other information is Get  
  

```B4X
  PNUpload.StartUpload("","",File.Combine(File.DirRootExternal,allpaths(allpaths.Length-1)), _  
            "https:yourDomain?idmusic=1" ,"filename",1)  
    ProgressDialogShow2("is uploading…",False)
```

  
  
  
Well, the information has been sent. Now we need to control the return information, add these codes to the end of your codes  
  

```B4X
Sub PNUpload_OnFileUploaded(ServerMessage As String,Tag As Object) 'Payami ke baadAz payan amaliat az PHP Echo mishe  
    ProgressDialogHide  
      
    Dim matn As String="missin complate"  
    pnlboxpost.Visible=False  
    Log(ServerMessage)  
    Msgbox(matn,"ok")  
End Sub  
Sub PNUpload_OnError(ErrorMessage As String,Tag As Object)  
    ProgressDialogHide  
      
    Dim matn As String="error"&"later try again "  
    Log(ErrorMessage)  
    Msgbox(matn,"error")  
End Sub
```

  
  
Now we go to php  
  

```B4X
<?php  
   
if (isset($_FILES['filename'])){  
    $file = $_FILES['filename'];  
    $fileName = $file['name'];  
    $filType = $file['type'];  
    $fileTmp = $file['tmp_name'];  
    $fileSize = $file['size'];  
    $uploadOk = 1;  
    $target = 'uploadimage/'; // folder name  
    $newName = 'https:ayandehyafzararya.ir' . time();  
   $idmusic=$_GET["idmusic"];  
  
    //Check FileSize  
    if ($fileSize > 700000) {  
        $uploadOk = 0;  
        echo  "You can upload up to 5 MB";  
    }  
  
    //if $uploadOk=1  
    if ($uploadOk == 1){  
        $ext = pathinfo($fileName, PATHINFO_EXTENSION);  
        $target = $target . $newName . '.' . $ext;  
        move_uploaded_file($fileTmp,$target);  
        echo "ok";  
    }  
else{  
        echo "error";  
}  
}  
?>
```

  
  
  
  
This training was based on the fact that you are proficient in coding and it is a bit confusing for beginners. Please contact me if you have any questions.