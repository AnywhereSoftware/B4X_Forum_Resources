### Media Store class - created with assistance of Microsoft Copilot by JackKirk
### 05/19/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/167055/)

Below is the source of a class that has the following methods:  
  
Initialize - works out if media store or "traditional" storage is to be used. According to Copilot there are some devices that do not support RELATIVE\_PATH when SDK >= 29. Initialize checks for this and drops back to "traditional" storage if detected.  
Media\_Store\_Uri\_String - returns a string used by other methods, can be used to check if a file is stored.  
Save\_To\_Media\_Store - saves a file to the store.  
Retrieve\_From\_Media\_Store - reverse of Save\_To\_Media\_Store.  
Retrieve\_From\_Media\_Store\_Bitmap - similar to Retrieve\_From\_Media\_Store but returns a bitmap.  
Delete\_Media\_Store - deletes a file from the store.  
  
I have limited the class to these and only handle ,jpg and ,mp4 because this is my use case.  
  
I would appreciate any and all feedback - I have been able to extensively test it on SDK 30 and SDK 35 - if some one could test it on a SDK < 29 device that would be great,  
  
According to Copilot the following needs to be added to the Manifest editor:  

```B4X
AddPermission(android.permission.READ_EXTERNAL_STORAGE)  
AddManifestText(<uses-permission  
    android:name="android.permission.READ_EXTERNAL_STORAGE"  
    android:maxSdkVersion="28" />  
)  
AddPermission(android.permission.WRITE_EXTERNAL_STORAGE)  
AddManifestText(<uses-permission  
    android:name="android.permission.WRITE_EXTERNAL_STORAGE"  
    android:maxSdkVersion="28" />  
)  
AddPermission(android.permission.MANAGE_EXTERNAL_STORAGE)  
AddManifestText(<uses-permission  
    android:name="android.permission.MANAGE_EXTERNAL_STORAGE"  
    android:maxSdkVersion="30" />)
```

  
Elsewhere in your code you need to have something like:  

```B4X
            'If Android version is less than 10, (SDK < 29, see: https://apilevels.com/)…  
            If Obj_host_phone.SdkVersion < 29 Then  
               
                'Get run time permission, see:  
                'https://www.b4x.com/android/forum/threads/runtime-permissions-android-6-0-permissions.67689/  
                Starter.RunPermissions.CheckAndRequest(Starter.RunPermissions.PERMISSION_WRITE_EXTERNAL_STORAGE)  
  
                'Wait for RunPermissions to finish processing permission  
                Wait For Activity_PermissionResult(Permission As String, Result As Boolean)
```

  
And the class code is:  

```B4X
'************************************************************************************  
'  
'This class module has methods for interacting with Media Store  
'  
'Features:  
'  
'   -  
'  
'Methods:  
'  
'   Initialize  
'  
'   Media_Store_Uri_String  
'  
'   Save_To_Media_Store  
'  
'   Retrieve_From_Media_Store  
'  
'   Retrieve_From_Media_Store_Bitmap  
'  
'   Delete_Media_Store  
'  
'Events:  
'  
'   None  
'  
'Properties:  
'  
'   Error_flag  
'    Error_msg  
'   Gen_traditional_mode  
'   Gen_traditional_photo_video_album  
'  
'Requirements:  
'  
'   o B4A libraries:  
'  
'         Phone (version 2.60 or later)  
'  
'Update history:  
'  
'   16 May 25 - 1.0  
'  
'************************************************************************************  
Private Sub Class_Globals  
  
    'Properties  
    Public Error_flag As Boolean  
    Public Error_msg As String  
    Public Gen_traditional_mode As Boolean  
    Public Gen_traditional_photo_video_album As String  
  
End Sub  
  
'************************************************************************************  
'  
'This code module contains procedures for interacting with the media store  
'  
'************************************************************************************  
  
'************************************************************************************  
'  
'This procedure gets control when Initialize method is called by parent module  
'  
'Input parameters are:  
'  
'       None  
'  
'Returns:  
'  
'       -  
'Notes on this procedure:  
'  
'       o None  
'  
'************************************************************************************  
  
'  
'[Method] - initialize  
'  
Public Sub Initialize  
  
    Error_flag = False  
    Error_msg = ""  
  
    'Traditional Storage (SDK < 29, Android <= 9)  
    If Main.Obj_host_phone.SdkVersion < 29 Then  
       
        Gen_traditional_mode = True  
       
        Gen_traditional_photo_video_album = File.DirRootExternal & "/Pictures/" & Main.Gen_photovideo_album  
   
        File.MakeDir(Gen_traditional_photo_video_album, "")  
       
    'Scoped Storage (SDK >= 29, Android >= 10)  
    Else  
  
        Private wrk_jo As JavaObject  
        wrk_jo.InitializeContext  
  
        Try  
  
            'Attempt to retrieve RELATIVE_PATH column reference  
            Private wrk_relative_path_column As String = wrk_jo.InitializeStatic("android.provider.MediaStore$MediaColumns").GetField("RELATIVE_PATH")  
  
        Catch  
  
            'RELATIVE_PATH not supported, use traditional storage  
            Gen_traditional_mode = True  
           
            Gen_traditional_photo_video_album = Starter.RunPermissions.GetSafeDirDefaultExternal(Main.Gen_photovideo_album)  
  
            File.MakeDir(Gen_traditional_photo_video_album, "")  
  
        End Try  
  
'Uncomment to test traditional mode on SDK <29  
'Gen_traditional_mode = True  
'Gen_traditional_photo_video_album = File.DirRootExternal & "/Pictures/" & Main.Gen_photovideo_album  
'File.MakeDir(Gen_traditional_photo_video_album, "")  
'Log(Gen_traditional_photo_video_album)  
'  
'Uncomment to test traditional mode on SDK >=29 with RELATIVE_PATH not supported  
'Gen_traditional_mode = True  
'Gen_traditional_photo_video_album = Starter.RunPermissions.GetSafeDirDefaultExternal(Main.Gen_photovideo_album)  
'File.MakeDir(Gen_traditional_photo_video_album, "")  
'Log(Gen_traditional_photo_video_album)  
   
    End If  
  
End Sub  
  
'************************************************************************************  
'  
'This procedure returns string representation of media Uri of a given media file in  
'Media Store  
'  
'Input parameters are:  
'  
'       Media_File_Name = name of media file in Media Store  
'  
'Returns:  
'  
'       String representation of media Uri  
'       If error:  
'       Error_flag = True  
'        Error_msg = …  
'  
'Notes on this procedure:  
'  
'       o This can be used to check if a file is in Media Store  
'  
'************************************************************************************  
  
'  
'[Method] - Media_Store_Uri_String  
'  
Public Sub Media_Store_Uri_String(Media_File_Name As String) As String  
  
    Error_flag = False  
    Error_msg = ""  
  
    'Traditional Storage (SDK < 29, Android <= 9) or (SDK >= 29. Android >= 10 and  
    'RELATIVE_PATH not supported)  
    If Gen_traditional_mode Then  
     
        If File.Exists(Gen_traditional_photo_video_album, Media_File_Name) Then  
           
            Return Media_File_Name  
           
        Else  
           
            Return ""  
           
        End If  
       
    End If  
   
    'Scoped Storage (SDK >= 29, Android >= 10 and RELATIVE_PATH supported)  
    Private wrk_jo As JavaObject  
    wrk_jo.InitializeContext  
    Private wrk_content_resolver As JavaObject = wrk_jo.RunMethod("getContentResolver", Null)  
   
    'Determine media type based on file extension  
    Private wrk_media_Uri As JavaObject  
    If Media_File_Name.ToLowerCase.EndsWith(".jpg") Then  
  
        wrk_media_Uri = wrk_jo.InitializeStatic("android.provider.MediaStore.Images.Media").GetField("EXTERNAL_CONTENT_URI")  
  
    Else If Media_File_Name.ToLowerCase.EndsWith(".mp4") Then  
  
        wrk_media_Uri = wrk_jo.InitializeStatic("android.provider.MediaStore.Video.Media").GetField("EXTERNAL_CONTENT_URI")  
  
    Else  
  
        Error_flag = True  
        Error_msg = "Unsupported file type: " & Media_File_Name  
        Return ""  
  
    End If  
   
    Private wrk_display_name_column As String = wrk_jo.InitializeStatic("android.provider.MediaStore$MediaColumns").GetField("DISPLAY_NAME")  
    Private wrk_projection As Object = Array As String("_id")  
    Private wrk_selection As String  
    Private wrk_selection_args As Object  
  
    wrk_selection = wrk_display_name_column & " = ? AND " & wrk_jo.InitializeStatic("android.provider.MediaStore$MediaColumns").GetField("RELATIVE_PATH") & " LIKE ?"  
    wrk_selection_args = Array As String(Media_File_Name, "%Pictures/" & Main.Gen_photovideo_album & "%")  
   
    Private wrk_cursor As JavaObject  
  
    Try  
  
        wrk_cursor = wrk_content_resolver.RunMethod("query", Array(wrk_media_Uri, wrk_projection, wrk_selection, wrk_selection_args, Null))  
       
        If wrk_cursor.RunMethod("moveToFirst", Null) Then  
  
            Private wrk_id As String = wrk_cursor.RunMethod("getString", Array(wrk_cursor.RunMethod("getColumnIndex", Array("_id"))))  
            wrk_cursor.RunMethod("close", Null)  
           
            'Convert wrk_media_Uri to a string  
            Private wrk_media_Uri_str As String = wrk_media_Uri.RunMethod("toString", Null)  
            Return wrk_media_Uri_str & "/" & wrk_id  
  
        Else  
  
            wrk_cursor.RunMethod("close", Null)  
            Error_flag = True  
            Error_msg = "Photo/video not found in Media Store: " & Media_File_Name  
            Return ""  
  
        End If  
  
    Catch  
  
        Error_flag = True  
        Error_msg = "Error querying Media Store for photo/video: " & Media_File_Name  
        Return ""  
  
    End Try  
   
End Sub  
  
'************************************************************************************  
'  
'This procedure saves a file (.jpg or .mp4) to Media Store  
'  
'Input parameters are:  
'  
'       File_Path = path to file  
'       File_Name = file name  
'       Media_File_Name = name of media file in Media Store  
'  
'Returns:  
'  
'       If error:  
'       Error_flag = True  
'        Error_msg = …  
'  
'Notes on this procedure:  
'  
'       o None  
'  
'************************************************************************************  
  
'  
'[Method] - Save_To_Media_Store  
'  
Public Sub Save_To_Media_Store(File_Path As String, File_Name As String, Media_File_Name As String)  
  
    Error_flag = False  
    Error_msg = ""  
  
    'Traditional Storage (SDK < 29, Android <= 9) or (SDK >= 29. Android >= 10 and  
    'RELATIVE_PATH not supported)  
    If Gen_traditional_mode Then  
       
        Try  
           
            File.Copy(File_Path, File_Name, Gen_traditional_photo_video_album, Media_File_Name)  
            Return  
           
        Catch  
           
            Error_flag = True  
            Error_msg = "Error saving photo/video: " & File_Path & File_Name  
            Return  
           
        End Try  
       
    End If  
   
    'Scoped Storage (SDK >= 29, Android >= 10 and RELATIVE_PATH supported)  
    Private wrk_jo As JavaObject  
    wrk_jo.InitializeContext  
    Private wrk_content_resolver As JavaObject = wrk_jo.RunMethod("getContentResolver", Null)  
   
    'Determine media mime type based on file extension  
    Private wrk_media_Uri As JavaObject  
    Private wrk_mime_type As String  
  
    If File_Name.ToLowerCase.EndsWith(".jpg") Then  
  
        wrk_media_Uri = wrk_jo.InitializeStatic("android.provider.MediaStore.Images.Media").GetField("EXTERNAL_CONTENT_URI")  
        wrk_mime_type = "image/jpeg"  
   
    Else If File_Name.ToLowerCase.EndsWith(".mp4") Then  
  
        wrk_media_Uri = wrk_jo.InitializeStatic("android.provider.MediaStore.Video.Media").GetField("EXTERNAL_CONTENT_URI")  
        wrk_mime_type = "video/mp4"  
  
    Else  
  
        Error_flag = True  
        Error_msg = "Unsupported file type: " & File_Name  
        Return  
  
    End If  
  
    Private wrk_content_values As JavaObject  
    wrk_content_values.InitializeNewInstance("android.content.ContentValues", Null)  
  
    Private wrk_display_name_column As String = wrk_jo.InitializeStatic("android.provider.MediaStore$MediaColumns").GetField("DISPLAY_NAME")  
    Private wrk_mime_type_column As String = wrk_jo.InitializeStatic("android.provider.MediaStore$MediaColumns").GetField("MIME_TYPE")  
    Private wrk_date_added_column As String = wrk_jo.InitializeStatic("android.provider.MediaStore$MediaColumns").GetField("DATE_ADDED")  
    Private wrk_relative_path_column As String = wrk_jo.InitializeStatic("android.provider.MediaStore$MediaColumns").GetField("RELATIVE_PATH")  
  
    wrk_content_values.RunMethod("put", Array(wrk_display_name_column, Media_File_Name))  
    wrk_content_values.RunMethod("put", Array(wrk_mime_type_column, wrk_mime_type))  
    wrk_content_values.RunMethod("put", Array(wrk_date_added_column, DateTime.Now / 1000))  
    wrk_content_values.RunMethod("put", Array(wrk_relative_path_column, "Pictures/" & Main.Gen_photovideo_album))  
  
    'Insert into Media Store  
    Private wrk_media_Uri_obj As Object = wrk_content_resolver.RunMethod("insert", Array(wrk_media_Uri, wrk_content_values))  
  
    If wrk_media_Uri_obj <> Null Then  
       
        Try  
  
            Private wrk_out_stream As OutputStream = wrk_content_resolver.RunMethod("openOutputStream", Array(wrk_media_Uri_obj))  
            Private wrk_in_stream As InputStream = File.OpenInput(File_Path, File_Name)  
            File.Copy2(wrk_in_stream, wrk_out_stream)  
            wrk_out_stream.Close  
            wrk_in_stream.Close  
  
        Catch  
  
            Error_flag = True  
            Error_msg = "Error saving photo/video to Media Store: " & File_Path & File_Name  
            Return  
  
        End Try  
  
    Else  
  
        Error_flag = True  
        Error_msg = "Error saving photo/video to Media Store: " & File_Path & File_Name  
        Return  
  
    End If  
   
End Sub  
  
'************************************************************************************  
'  
'This procedure retrieves a file (.jpg or .mp4) from Media Store  
'  
'Input parameters are:  
'  
'       Media_File_Name = name of media file in Media Store  
'       File_Path = path to file  
'       File_Name = file name  
'  
'Returns:  
'  
'       If error:  
'       Error_flag = True  
'        Error_msg = …  
'  
'Notes on this procedure:  
'  
'       o None  
'  
'************************************************************************************  
  
'  
'[Method] - Retrieve_From_Media_Store  
'  
Public Sub Retrieve_From_Media_Store(Media_File_Name As String, File_Path As String, File_Name As String)  
  
    Error_flag = False  
    Error_msg = ""  
  
    'Traditional Storage (SDK < 29, Android <= 9) or (SDK >= 29. Android >= 10 and  
    'RELATIVE_PATH not supported)  
    If Gen_traditional_mode Then  
  
        Try  
           
            File.Copy(Gen_traditional_photo_video_album, Media_File_Name, File_Path, File_Name)  
            Return  
           
        Catch  
           
            Error_flag = True  
            Error_msg = "Failed to retrieve photo/video: " & Media_File_Name  
            Return  
       
        End Try  
  
    End If  
  
    'Scoped Storage (SDK >= 29, Android >= 10 and RELATIVE_PATH supported)  
    Private wrk_media_Uri_str As String = Media_Store_Uri_String(Media_File_Name)  
    If Error_flag Then Return  
  
    If Not(File_Name.ToLowerCase.EndsWith(".jpg")) And Not(File_Name.ToLowerCase.EndsWith(".mp4")) Then  
  
        Error_flag = True  
        Error_msg = "Unsupported file type: " & File_Name  
        Return  
  
    End If  
   
    Private wrk_jo As JavaObject  
    wrk_jo.InitializeContext  
    Private wrk_content_resolver As JavaObject = wrk_jo.RunMethod("getContentResolver", Null)  
   
    Try  
  
        Private wrk_media_Uri As JavaObject  
        wrk_media_Uri = wrk_jo.InitializeStatic("android.net.Uri").RunMethod("parse", Array(wrk_media_Uri_str))  
       
        Private wrk_in_stream As InputStream = wrk_content_resolver.RunMethod("openInputStream", Array(wrk_media_Uri))  
        Private wrk_out_stream As OutputStream = File.OpenOutput(File_Path, File_Name, False)  
       
        File.Copy2(wrk_in_stream, wrk_out_stream)  
        wrk_in_stream.Close  
        wrk_out_stream.Close  
       
    Catch  
  
        Error_flag = True  
        Error_msg = "Failed to retrieve photo/video from Media Store: " & Media_File_Name  
       
    End Try  
   
End Sub  
  
'************************************************************************************  
'  
'This procedure retrieves a file (.jpg) from Media Store as a bitmap  
'  
'Input parameters are:  
'  
'       Media_File_Name = name of media file in Media Store  
'  
'Returns:  
'  
'       Bitmap  
'       If error:  
'       Error_flag = True  
'        Error_msg = …  
'  
'Notes on this procedure:  
'  
'       o None  
'  
'************************************************************************************  
  
'  
'[Method] - Retrieve_From_Media_Store_Bitmap  
'  
Public Sub Retrieve_From_Media_Store_Bitmap(Media_File_Name As String) As Bitmap  
  
    Error_flag = False  
    Error_msg = ""  
  
    'Traditional Storage (SDK < 29, Android <= 9) or (SDK >= 29. Android >= 10 and  
    'RELATIVE_PATH not supported)  
    If Gen_traditional_mode Then  
  
        Try  
           
            Private wrk_bmp As Bitmap  
            wrk_bmp.Initialize(Gen_traditional_photo_video_album, Media_File_Name)  
            Return wrk_bmp  
           
        Catch  
           
            Error_flag = True  
            Error_msg = "Failed to retrieve photo: " & Media_File_Name  
            Return Null  
       
        End Try  
  
    End If  
  
    'Scoped Storage (SDK >= 29, Android >= 10 and RELATIVE_PATH supported)  
    Private wrk_media_Uri_str As String = Media_Store_Uri_String(Media_File_Name)  
    If Error_flag Then Return Null  
   
    Private wrk_jo As JavaObject  
    wrk_jo.InitializeContext  
    Private wrk_content_resolver As JavaObject = wrk_jo.RunMethod("getContentResolver", Null)  
   
    Try  
  
        Private wrk_media_Uri As JavaObject  
        wrk_media_Uri = wrk_jo.InitializeStatic("android.net.Uri").RunMethod("parse", Array(wrk_media_Uri_str))  
       
        Private wrk_in_stream As InputStream = wrk_content_resolver.RunMethod("openInputStream", Array(wrk_media_Uri))  
        Private wrk_bmp As Bitmap  
        wrk_bmp.Initialize2(wrk_in_stream)  
        wrk_in_stream.Close  
       
        Return wrk_bmp  
       
    Catch  
       
        Error_flag = True  
        Error_msg = "Failed to retrieve photo from Media Store: " & Media_File_Name  
        Return Null  
       
    End Try  
   
End Sub  
  
'************************************************************************************  
'  
'This procedure deletes a file (.jpg or .mp4) from Media Store  
'  
'Input parameters are:  
'  
'       Media_File_Name = name of media file in Media Store  
'  
'Returns:  
'  
'       If error:  
'       Error_flag = True  
'        Error_msg = …  
'  
'Notes on this procedure:  
'  
'       o None  
'  
'************************************************************************************  
  
'  
'[Method] - Retrieve_From_Media_Store_Bitmap  
'  
Public Sub Delete_Media_Store(Media_File_Name As String)  
  
    Error_flag = False  
    Error_msg = ""  
  
    'Traditional Storage (SDK < 29, Android <= 9) or (SDK >= 29. Android >= 10 and  
    'RELATIVE_PATH not supported)  
    If Gen_traditional_mode Then  
  
        Try  
           
            File.delete(Gen_traditional_photo_video_album, Media_File_Name)  
            Return  
           
        Catch  
           
            Error_flag = True  
            Error_msg = "Failed to delete photo/video: " & Media_File_Name  
            Return  
       
        End Try  
  
    End If  
  
    'Scoped Storage (SDK >= 29, Android >= 10 and RELATIVE_PATH supported)  
    Private wrk_media_Uri As String = Media_Store_Uri_String(Media_File_Name)  
    If Error_flag Then Return  
   
    Private wrk_jo As JavaObject  
    wrk_jo.InitializeContext  
    Private wrk_content_resolver As JavaObject = wrk_jo.RunMethod("getContentResolver", Null)  
   
    Try  
       
        Private wrk_rows_deleted As Int = wrk_content_resolver.RunMethod("delete", Array(wrk_media_Uri, Null, Null))  
        If wrk_rows_deleted = 0 Then  
            Error_flag = True  
            Error_msg = "Failed to delete photo/video from Media Store: " & Media_File_Name  
        End If  
       
    Catch  
       
        Error_flag = True  
        Error_msg = "Failed to delete photo/video from Media Store: " & Media_File_Name  
       
    End Try  
   
End Sub
```

  
  
You may note that the class is absolutely littered with JavaObject stuff - which is nearly all beyond my pay grade.  
  
But Copilot was up to the challenge and this is the result of a 2 day conversation with it.  
  
That is not to say it was anywhere near perfect - for example it persisted with assuming there were FilePath and FileName members of some file functions.  
  
It also took 2 days - but it would have probably never happened without it - unless I could have found some java expert on the forums willing to find the time.  
  
Happy coding…