###  PocketBase - Open Source backend in 1 file by Alexander Stolte
### 03/18/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/165213/)

![](https://www.b4x.com/android/forum/attachments/161032)  
PocketBase was created to assist building self-contained applications that can run on a single server without requiring to install anything in addition.  
The basic idea is that the common functionality like crud, auth, files upload, auto TLS, etc. are handled out of the box, allowing you to focus on the UI and your actual app business requirements.  
  
Please note that PocketBase is neither a startup, nor a business. There is no paid team or company behind it. It is a personal open source project with intentionally limited scope and developed entirely on volunteer basis. There are no promises for maintenance and support beyond what is already available  
<https://pocketbase.io>  
  
—————————————————————————————————————————————————————————-  
  
After writing the Supabase client library for B4X, it's now time for a simpler self-hosting variant, for smaller projects that need a backend, but you don't want to write a complex API. Again, the goal is to get mentioned on the official Github repo with the B4X-Pocketbase library.  
<https://github.com/StolteX/B4X-PocketBase>  
  
**Roadmap**  
a list of open tasks and issues you can find [here](https://github.com/StolteX/B4X-PocketBase/issues)  

- Authentification (Social Login)

- Signin with Google
- Signin with Apple
- OTP
- Sign In Anonymously

- Database

- Batch
- Realtime
- Push Notifications

- Storage

- Download with progress

**Examples and Tutorials**  

- General

- [How to reach api via smartphone on the same network when hosted locally](https://www.b4x.com/android/forum/threads/b4x-pocketbase-how-to-reach-api-via-smartphone-on-the-same-network-when-hosted-locally.165548/)

- [Authentification](https://www.b4x.com/android/forum/threads/b4x-pocketbase-authentification.165333/)
- [Database](https://www.b4x.com/android/forum/threads/b4x-pocketbase-database-crud.165269/)
- [Storage](https://www.b4x.com/android/forum/threads/b4x-pocketbase-storage.165280/)

- [Deleting files](https://www.b4x.com/android/forum/threads/b4x-pocketbase-deleting-files.165554/)

- Admin

- Backups

  
**PocketBase  
Author: Alexander Stolte  
Version: 1.00**  
[SPOILER="Properties, Functions, Events, etc."]  

- **Pocketbase**

- **Events:**

- **AuthStateChange** (StateType As String)
- **RangeDownloadTracker** (Tracker As PocketbaseRangeDownloadTracker)

- **Functions:**

- **Initialize** (URL As String)
*Initializes the object. You can add parameters to this method if needed.*- **InitializeEvents** (Callback As Object, EventName As String)

- **Properties:**

- **Auth** As Pocketbase\_Authentication [read only]
- **Database** As Pocketbase\_Database [read only]
- **LogEvents** As Boolean
- **Storage** As Pocketbase\_Storage [read only]
- **URL** As String [read only]

- **Pocketbase\_Authentication**

- **Functions:**

- **ConfirmEmailChange** (Token As String, Password As String) As ResumableSub
*Confirms the password reset with the verification token from the e-mail  
 <code>  
 Wait For (xPocketbase.Auth.ConfirmEmailChange("xxx","Test123!")) Complete (Response As PocketbaseError)  
 If Response.Success Then  
 Log("E-Mail change successfully")  
 Else  
 Log("Error: " & Response.ErrorMessage)  
 End If  
 </code>*- **ConfirmPasswordReset** (Token As String, NewPassword As String, NewPasswordConfirm As String) As ResumableSub
*Confirms the password reset with the verification token from the e-mail  
 <code>  
 Wait For (xPocketbase.Auth.ConfirmPasswordReset("xxx","Test123!","Test123!")) Complete (Response As PocketbaseError)  
 If Response.Success Then  
 Log("Password change successfully")  
 Else  
 Log("Error: " & Response.ErrorMessage)  
 End If  
 </code>*- **ConfirmVerification** (VerificationToken As String) As ResumableSub
*Confirms the user account with the verification token from the e-mail  
 <code>  
 Wait For (xPocketbase.Auth.ConfirmVerification("xxx")) Complete (Success As PocketbaseError)  
 If Success.Success Then  
 Log("verification sucessfull")  
 Else  
 Log("Error: " & Success.ErrorMessage)  
 End If  
 </code>*- **DeleteUser** As ResumableSub
*Delete a single users record  
 <code>Wait For (xPocketbase.Auth.DeleteUser) Complete (Success As PocketbaseError)</code>*- **GetAccessToken** As ResumableSub
- **GetUser** As ResumableSub
*Gets the user object  
 <code>Wait For (xPocketbase.Auth.GetUser) Complete (User As PocketbaseUser)</code>*- **Initialize** (ThisPocketbase As Pocketbase, EventName As String)
*Initializes the object. You can add parameters to this method if needed.*- **isUserLoggedIn** As ResumableSub
*Checks if the user is logged in, renews the access token if it has expired  
 <code>Wait For (xPocketbase.Auth.isUserLoggedIn) Complete (isLoggedIn As Boolean)</code>*- **Login\_EmailPassword** (Email As String, Password As String) As ResumableSub
*Authenticate with combination of email and password  
 <code>  
Wait For (xPocketbase.Auth.LogIn\_EmailPassword("[EMAIL]test@example.com[/EMAIL]","Test123!")) Complete (User As PocketbaseUser)  
 If User.Error.Success Then  
 Log("successfully logged in with " & User.Email)  
 Else  
 Log("Error: " & User.Error.ErrorMessage)  
 End If  
 </code>*- **Logout** As ResumableSub
*User tokens and infos are removed from the device*- **RefreshToken** As ResumableSub
- **RequestEmailChange** (NewEmail As String) As ResumableSub
*Sends users email change request  
 On successful email change all previously issued auth tokens for the specific record will be automatically invalidated  
 <code>  
Wait For (xPocketbase.Auth.RequestEmailChange("[EMAIL]test@example.com[/EMAIL]")) Complete (Success As PocketbaseError)  
 If Success.Success Then  
 Log("E-Mail change request sent")  
 Else  
 Log("Error: " & Success.ErrorMessage)  
 End If  
 </code>*- **RequestPasswordReset** (Email As String) As ResumableSub
*Sends users password reset email request  
 On successful password reset all previously issued auth tokens for the specific record will be automatically invalidated  
 <code>  
wait for (xPocketbase.Auth.PasswordRecovery("[EMAIL]test@example.com[/EMAIL]")) Complete (Response As PocketbaseError)  
 If Response.Success Then  
 Log("Recovery email sent successfully")  
 Else  
 Log("Error: " & Response.ErrorMessage)  
 End If  
 </code>*- **RequestVerification** (Email As String) As ResumableSub
*Sends users account verification request  
 <code>  
Wait For (xPocketbase.Auth.RequestVerification("[EMAIL]test@example.com[/EMAIL]")) Complete (Success As PocketbaseError)  
 If Success.Success Then  
 Log("verification code send to email")  
 Else  
 Log("Error: " & Success.ErrorMessage)  
 End If  
 </code>*- **SaveToken**
- **SignUp** (Email As String, Password As String, PasswordConfirm As String, Options As Map) As ResumableSub
*Allow your users to sign up and create a new account.  
 Options - Optional fields  
 A full list of values you find in the dashboard in the “API Preview” in the “users” collection  
 <code>  
Wait For (xPocketbase.Auth.SignUp("[EMAIL]test@example.com[/EMAIL]","Test123!","Test123!",Null)) Complete (NewUser As PocketbaseUser)  
 If NewUser.Error.Success Then  
 Log("successfully registered with " & NewUser.Email)  
 Else  
 Log("Error: " & NewUser.Error.ErrorMessage)  
 End If  
 </code>*- **UpdateUser** (Options As Map) As ResumableSub
*Update a single users record  
 A full list of values you find in the dashboard in the “API Preview” in the “users” collection  
 <code>Wait For (xPocketbase.Auth.UpdateUser(CreateMap("name":"Test Name"))) Complete (Success As PocketbaseError)</code>*
- **Properties:**

- **TokenInformations** As PocketbaseTokenInformations [read only]
- **UserCollectionName** As String
*Change it only if you change the default "users" table name*
- **Pocketbase\_Database**

- **Functions:**

- **DeleteData** As Pocketbase\_DatabaseDelete
*Delete a single collection record  
 <code>Wait For (xPocketbase.Database.DeleteData.Collection("dt\_Task").Execute("43r7071wtp30l5h")) Complete (Result As PocketbaseError)</code>*- **Initialize** (ThisPocketbase As Pocketbase)
*Initializes the object. You can add parameters to this method if needed.*- **InsertData** As Pocketbase\_DatabaseInsert
*<code>  
 Dim Insert As Pocketbase\_DatabaseInsert = xPocketbase.Database.InsertData.Collection("dt\_Task")  
 Insert.Parameter\_Fields("Task\_Name,Task\_CompletedAt")  
Dim InsertMap As Map = CreateMap("Task\_UserId":xPocketbase.Auth.TokenInformations.Id,"Task\_Name":"Task 01","Task\_CompletedAt":pocketbase\_Functions.GetISO8601UTC(DateTime.Now))  
 Wait For (Insert.Insert(InsertMap).Execute) Complete (DatabaseResult As PocketbaseDatabaseResult)  
 xPocketbase.Database.PrintTable(DatabaseResult)  
 </code>*- **PrintTable** (Table As PocketbaseDatabaseResult)
- **SelectData** As Pocketbase\_DatabaseSelect
*<code>  
 Wait For (xPocketbase.Database.SelectData.Collection("dt\_Task").GetList(0,2,"")) Complete (DatabaseResult As PocketbaseDatabaseResult)  
 xPocketbase.Database.PrintTable(DatabaseResult)  
 </code>*- **UpdateData** As Pocketbase\_DatabaseUpdate
*<code>  
 Dim UpdateRecord As Pocketbase\_DatabaseUpdate = xPocketbase.Database.UpdateData.Collection("dt\_Task")  
 UpdateRecord.Parameter\_Fields("Task\_Name,Task\_CompletedAt")  
 UpdateRecord.Update(CreateMap("Task\_Name":"Task 02"))  
 Wait For (UpdateRecord.Execute("77avq8zn44ck37m")) Complete (DatabaseResult As PocketbaseDatabaseResult)  
 xPocketbase.Database.PrintTable(DatabaseResult)  
 </code>*
- **Pocketbase\_DatabaseDelete**

- **Functions:**

- **Collection** (TableName As String) As Pocketbase\_DatabaseDelete
- **Execute** (RecordId As String) As ResumableSub
- **Initialize** (ThisPocketbase As Pocketbase)
*Initializes the object. You can add parameters to this method if needed.*
- **Pocketbase\_DatabaseInsert**

- **Functions:**

- **Collection** (TableName As String) As Pocketbase\_DatabaseInsert
- **Execute** As ResumableSub
- **Initialize** (ThisPocketbase As Pocketbase)
*Initializes the object. You can add parameters to this method if needed.*- **Insert** (ColumnValue As Map) As Pocketbase\_DatabaseInsert
*Insert one row  
<code>Dim InsertMap As Map = CreateMap("Tasks\_Name":"Task 01","Tasks\_Checked":True,"Tasks\_CreatedAt":DateUtils.TicksToString(DateTime.Now))</code>*- **Parameter\_Expand** (Expand As String) As Pocketbase\_DatabaseInsert
*Auto expand record relations.*- **Parameter\_Fields** (Fields As String) As Pocketbase\_DatabaseInsert
*Comma separated string of the fields to return in the JSON response (by default returns all fields).  
 <code>CustomQuery.Parameter\_Fields("Task\_Name,Task\_CompletedAt")</code>*- **Parameter\_Files** (Files As List)

- **Pocketbase\_DatabaseSelect**

- **Functions:**

- **Collection** (TableName As String) As Pocketbase\_DatabaseSelect
- **GetCustom**
*Create your own query with all available filters  
 Use the "Parameter\_" properties  
 <code>  
 Dim CustomQuery As Pocketbase\_DatabaseSelect = xPocketbase.Database.SelectData.Collection("dt\_Task")  
 CustomQuery.Parameter\_Page(0)  
 CustomQuery.Parameter\_PerPage(2)  
 CustomQuery.Parameter\_Fields("Task\_Name,Task\_CompletedAt")  
 CustomQuery.Parameter\_Sort("-Task\_Name") 'DESC  
 Wait For (CustomQuery.GetCustom) Complete (DatabaseResult As PocketbaseDatabaseResult)  
 xPocketbase.Database.PrintTable(DatabaseResult)</code>*- **GetFirstListItem** (Filter As String, Expand As String) As ResumableSub
*Returns the first found list item by the specified filter.  
 <code> Wait For (xPocketbase.Database.SelectData.Collection("dt\_Task").GetFirstListItem("","")) Complete (DatabaseResult As PocketbaseDatabaseResult)  
 xPocketbase.Database.PrintTable(DatabaseResult)</code>*- **GetFullList** (Sort As String) As ResumableSub
*Returns a list with all items batch fetched at once.  
 <code Wait For (xPocketbase.Database.SelectData.Collection("dt\_Task").GetFullList("-Task\_Name")) Complete (DatabaseResult As PocketbaseDatabaseResult)  
 xPocketbase.Database.PrintTable(DatabaseResult)</code>*- **GetList** (Page As Int, PerPage As Int, Filter As String) As ResumableSub
*Returns paginated items list.  
 <code>  
 Wait For (xPocketbase.Database.SelectData.Collection("dt\_Task").GetList(0,2,"")) Complete (DatabaseResult As PocketbaseDatabaseResult)  
 xPocketbase.Database.PrintTable(DatabaseResult)</code>*- **GetOne** (RecordID As String) As ResumableSub
*Returns single item by its ID.  
 <code> Wait For (xPocketbase.Database.SelectData.Collection("dt\_Task").GetOne("77avq8zn44ck37m")) Complete (DatabaseResult As PocketbaseDatabaseResult)  
 xPocketbase.Database.PrintTable(DatabaseResult)</code>*- **Initialize** (ThisPocketbase As Pocketbase)
*Initializes the object. You can add parameters to this method if needed.*- **Parameter\_Expand** (Expand As String) As Pocketbase\_DatabaseSelect
*Only for GetCustom  
 Auto expand record relations.*- **Parameter\_Fields** (Fields As String) As Pocketbase\_DatabaseSelect
*Only for GetCustom  
 Comma separated string of the fields to return in the JSON response (by default returns all fields).  
 <code>CustomQuery.Parameter\_Fields("Task\_Name,Task\_CompletedAt")</code>*- **Parameter\_Filter** (Filter As String) As Pocketbase\_DatabaseSelect
*Only for GetCustom  
 Filter the returned records.  
 Single filter:  
 <code>CustomQuery.Parameter\_Filter("Task\_Name='Task 05'")</code>  
 Multiple filter:  
 <code>CustomQuery.Parameter\_Filter("Task\_Name='Task 05' && Task\_UserId='86jzh49x5k2m387'")</code>*- **Parameter\_Page** (Page As Int) As Pocketbase\_DatabaseSelect
*Only for GetCustom  
 The page (aka. offset) of the paginated list (default to 1).  
 <code>CustomQuery.Parameter\_Page(0)</code>*- **Parameter\_PerPage** (perPage As Int) As Pocketbase\_DatabaseSelect
*Only for GetCustom  
 Specify the max returned records per page (default to 30).  
 <code>CustomQuery.Parameter\_PerPage(4)</CustomQuery.Parameter\_PerPage(4)>*- **Parameter\_SkipTotal** (skipTotal As Boolean) As Pocketbase\_DatabaseSelect
*Only for GetCustom  
 If it is set the total counts query will be skipped and the response fields totalItems and totalPages will have -1 value.  
 This could drastically speed up the search queries when the total counters are not needed or cursor based pagination is used.  
 For optimization purposes, it is set by default for the getFirstListItem() and getFullList() SDKs methods.*- **Parameter\_Sort** (Sort As String) As Pocketbase\_DatabaseSelect
*Only for GetCustom  
 Specify the records order attribute(s).  
 Add - / + (default) in front of the attribute for DESC / ASC order.  
 <code>CustomQuery.Parameter\_Sort("-Task\_Name") 'DESC</code>*
- **Pocketbase\_DatabaseUpdate**

- **Functions:**

- **Collection** (TableName As String) As Pocketbase\_DatabaseUpdate
- **Execute** (RecordId As String) As ResumableSub
- **Initialize** (ThisPocketbase As Pocketbase)
*Initializes the object. You can add parameters to this method if needed.*- **Parameter\_Expand** (Expand As String) As Pocketbase\_DatabaseUpdate
*Auto expand record relations.*- **Parameter\_Fields** (Fields As String) As Pocketbase\_DatabaseUpdate
*Comma separated string of the fields to return in the JSON response (by default returns all fields).  
 <code>CustomQuery.Parameter\_Fields("Task\_Name,Task\_CompletedAt")</code>*- **Parameter\_Files** (Files As List)
- **Update** (ColumnValue As Map) As Pocketbase\_DatabaseUpdate

- **Pocketbase\_Functions**

- **Functions:**

- **BytesToImage** (bytes As Byte) As B4XBitmap
- **ConvertFile2Binary** (Dir As String, FileName As String) As Byte()
- **CreateMultipartFileData** (Dir As String, FileName As String, KeyName As String, ContentType As String) As MultipartFileData
*If you leave ContentType empty then the content type itself is determined using the file extension*- **GetFileExt** (FileName As String) As String
- **GetFilename** (fullpath As String) As String
- **GetISO8601UTC** (Ticks As Long) As String
*ISO8601UTC*- **GetMimeTypeByExtension** (Extension As String) As String
*<https://www.b4x.com/android/forum/threads/b4x-get-mime-type-by-extension.150330/>*- **ParseDateTime** (DateString As String) As Long

- **Pocketbase\_InternFunctions**

- **Functions:**

- **CreateDatabaseResult** (JsonString As String) As PocketbaseDatabaseResult
- **GenerateResult** (j As HttpJob) As Map
- **GetJWTPayload** (Token As String) As Map
- **PatchMultipart** (j As HttpJob, Link As String, NameValues As Map, Files As List)
- **SubExists2** (Target As Object, TargetSub As String, NumbersOfParameters As Int) As Boolean

- **Properties:**

- **ErrorCode** As Int
*code: 400*- **ErrorMap** As Map
*reason: invalid  
 domain: global  
 message: EMAIL\_NOT\_FOUND*- **ErrorMessage** As String
*message: EMAIL\_NOT\_FOUND*
- **Pocketbase\_Storage**

- **Fields:**

- **Tag** As Object

- **Functions:**

- **DownloadFile** (CollectionName As String, RecordId As String, FileName As String) As ResumableSub
*<code>  
 Wait For (xPocketbase.Storage.DownloadFile("dt\_Task","s64f723suu7b1p4","test\_76uuo6rx0u.jpg")) Complete (StorageFile As PocketbaseStorageFile)  
 If StorageFile.Error.Success Then  
 Log($"File ${"test.jpg"} successfully downloaded "$)  
 ImageView1.SetBitmap(xPocketbase.Storage.BytesToImage(StorageFile.FileBody))  
 Else  
 Log("Error: " & StorageFile.Error.ErrorMessage)  
 End If  
 </code>*- **Initialize** (ThisPocketbase As Pocketbase)
*Initializes the object. You can add parameters to this method if needed.*- **Parameter\_Thumb** (Thumb As String) As Pocketbase\_Storage
*If your file field has the Thumb sizes option, you can get a thumb of the image file (currently limited to jpg, png, and partially gif – its first frame)  
 The following thumb formats are currently supported:  
 WxH (e.g. 100x300) - crop To WxH viewbox (from center)  
 WxHt (e.g. 100x300t) - crop To WxH viewbox (from top)  
 WxHb (e.g. 100x300b) - crop To WxH viewbox (from bottom)  
 WxHf (e.g. 100x300f) - fit inside a WxH viewbox (without cropping)  
 0xH (e.g. 0x300) - resize To H height preserving the aspect ratio  
 Wx0 (e.g. 100x0) - resize To W width preserving the aspect ratio  
 <code>  
 Dim GetFile As Pocketbase\_Storage = xPocketbase.Storage  
 GetFile.Parameter\_Thumb("100x300")  
 Wait For (GetFile.DownloadFile("dt\_Task","s64f723suu7b1p4","test\_76uuo6rx0u.jpg")) Complete (StorageFile As PocketbaseStorageFile)  
 </code>*- **UploadFile** (CollectionName As String, RecordId As String, FileData As MultipartFileData) As ResumableSub
*Single file upload  
 <code>  
 Dim FileData As MultipartFileData  
 FileData.Initialize  
 FileData.Dir = File.DirAssets  
 FileData.FileName = "test.jpg"  
 FileData.KeyName = "Task\_Image"  
 FileData.ContentType = "image/png"  
 Wait For (xPocketbase.Storage.UploadFile("dt\_Task","s64f723suu7b1p4",FileData)) Complete (DatabaseResult As PocketbaseDatabaseResult)  
 xPocketbase.Database.PrintTable(DatabaseResult)  
 </code>*- **UploadFiles** (CollectionName As String, RecordId As String, FileData As List) As ResumableSub
*If your file field supports uploading multiple files  
 FileDate - List of MultipartFileData  
 <code>  
 Dim lst\_Files As List : lst\_Files.Initialize  
 lst\_Files.Add(Pocketbase\_Functions.CreateMultipartFileData(File.DirAssets,"test.jpg","Task\_Image",""))  
 lst\_Files.Add(Pocketbase\_Functions.CreateMultipartFileData(File.DirAssets,"test2.jpg","Task\_Image",""))  
 Wait For (xPocketbase.Storage.UploadFiles("dt\_Task","s64f723suu7b1p4",lst\_Files)) Complete (DatabaseResult As PocketbaseDatabaseResult)  
 xPocketbase.Database.PrintTable(DatabaseResult)  
 </code>*
[/SPOILER]  
**Setup  
1. Follow the** [**Introductions docs**](https://pocketbase.io/docs/)  

```B4X
Public xPocketbase As Pocketbase  
#If B4J  
xPocketbase.Initialize("http://127.0.0.1:8090") 'Localhost -> B4J only  
#Else  
xPocketbase.Initialize("http://192.168.188.142:8090") 'IP of your PC  
#End If  
xPocketbase.InitializeEvents(Me,"Pocketbase")  
xPocketbase.LogEvents = True
```

  
  
**Changelog**  

- **1.00**

- Release

- **1.01**

- New some new descriptions for functions
- BugFixes for code snippets
- Change Login\_EmailPassword renamed to AuthWithPassword

- **1.02**

- **Storage**

- New DeleteFiles - To delete uploaded file(s)

- **1.03**

- BugFixes and Improvements
- **Pocketbase**

- New Admin class

- Access to all admin features
- The user must be authenticated as a superuser in order to access it
- Useful to build your own admin tools with B4J or to work with jServer

- **Admin**

- New AuthWithPassword - This allows you to authenticate yourself as a superuser
- New Backups - List, create, edit, delete and download backups (CRUD)

- **Storage**

- New GetToken - Generates a short-lived file token for accessing protected file(s)

- The client must be superuser or auth record authenticated (aka. have regular authorization token sent with the request)

- **1.04**

- **Pocketbase**

- New GetHealth - Returns the health status of the server

- **Admin**

- New Crons - List and execute cron jobs
- New Logs - List, view and get statistics of the logs

- **1.05**

- **Database**

- BugFixes

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.me/stoltex)  
  
**[SIZE=5]Please always create a new thread for questions and problems, thank you[/SIZE]**