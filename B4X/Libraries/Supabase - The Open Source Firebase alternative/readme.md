###  Supabase - The Open Source Firebase alternative by Alexander Stolte
### 03/18/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/149855/)

![](https://www.b4x.com/android/forum/attachments/145254)  
Supabase is an open source Firebase alternative. It provides all the backend services you need to build a product. Supabase uses Postgres database with real-time capabilities. Basically, supabase provides an interface to manage postgres database that you can use to create table and insert, edit and delete data in the table.  
  
We can use REST API or client libraries from supabase to access the data in the postgres database. Supabase is not just about accessing the database. it also provides some solutions out of the box such as Authentication, File Storage and Real-time capabilities.  
<https://supabase.com/>  
  
—————————————————————————————————————————————————————————-  
  
I am a huge fan of this project and wanted to develop a client library for B4X 2 years ago. With supabase you can develop an online app without having your own backend, no VPS or other server is needed. No matter how many users the app has, the API can scale.  
  
A big goal of the client library for b4x is to be listed [on the website](https://supabase.com/docs/guides/api/rest/client-libs) among the programming languages that have a community client library. But until then there is still a lot to do.  
<https://github.com/StolteX/B4X-Supabase>  
  
[TABLE]  
[TR]  
[TD]

**Feature**

[/TD]  
  
[TD]

**Components**

[/TD]  
  
[TD]

**Status**

[/TD]  
[/TR]  
[TR]  
[TD]Authentication[/TD]  
[TD]E-Mail +Password, SignIn with oauth (Google and Apple)[/TD]  
[TD]Alpha test[/TD]  
[/TR]  
[TR]  
[TD]Database[/TD]  
[TD]Create, Read, Update, Delete, RPC[/TD]  
[TD]Beta test[/TD]  
[/TR]  
[TR]  
[TD]Storage[/TD]  
[TD]CRUD Buckets and CRUD Files[/TD]  
[TD]Beta test[/TD]  
[/TR]  
[TR]  
[TD]Realtime[/TD]  
[TD]PostgresChanges, Broadcast and Presence[/TD]  
[TD]Alpha test[/TD]  
[/TR]  
[/TABLE]  
  
**Roadmap**  

- Authentification (Social Login)

- [✅Signin with Google](https://www.b4x.com/android/forum/threads/b4x-supabase-authentification-signin-with-google.149955/)
- ✅[Signin with Apple](https://www.b4x.com/android/forum/threads/b4x-supabase-authentification-signin-with-apple.149977/)
- Signin with Facebook
- Signin with Github
- SignIn with Azure

- Storage

- ✅[Buckets](https://www.b4x.com/android/forum/threads/b4x-supabase-storage-bucket.151198/)
- ✅[Files](https://www.b4x.com/android/forum/threads/b4x-supabase-storage-files.151199/)

- Authentification (Phone login)
- ✅Realtime

**Examples and Tutorials**  

- [Authentication](https://www.b4x.com/android/forum/threads/b4x-supabase-authentification.149856/)

- [SignIn with Google](https://www.b4x.com/android/forum/threads/b4x-supabase-authentification-signin-with-google.149955/)
- [SignIn with Apple](https://www.b4x.com/android/forum/threads/b4x-supabase-authentification-signin-with-apple.149977/)
- [Sign In Anonymously](https://www.b4x.com/android/forum/threads/b4x-supabase-sign-in-anonymously.160566/)

- [Database](https://www.b4x.com/android/forum/threads/b4x-supabase-database.149857/)

- [Joins](https://www.b4x.com/android/forum/threads/b4x-supabase-database-joins.157039/)
- [OrderBy](https://www.b4x.com/android/forum/threads/b4x-supabase-database-orderby.157292/)
- [Limit and Offset](https://www.b4x.com/android/forum/threads/b4x-supabase-database-limit-and-offset.157293/)
- [Alias Column Name](https://www.b4x.com/android/forum/threads/b4x-supabase-column-alias.158531/)
- [INSERT or UPDATE a record and return it](https://www.b4x.com/android/forum/threads/b4x-supabase-insert-or-update-a-record-and-return-it.158532/)
- [Call a Postgres function (RPC)](https://www.b4x.com/android/forum/threads/b4x-supabase-call-a-postgres-function-rpc.161815/)

- Storage

- [Buckets](https://www.b4x.com/android/forum/threads/b4x-supabase-storage-bucket.151198/#post-953063)
- [Files](https://www.b4x.com/android/forum/threads/b4x-supabase-storage-files.151199/#post-953065)
- [Download file with progress](https://www.b4x.com/android/forum/threads/b4x-supabase-storage-download-file-with-progress.151210/)
- [Image Transformations](https://www.b4x.com/android/forum/threads/b4x-supabase-storage-image-transformations.151321/)

- [Realtime](https://www.b4x.com/android/forum/threads/b4x-supabase-realtime.156354/)

- [Postgres Changes - Listen to Postgres changes using Supabase Realtime](https://www.b4x.com/android/forum/threads/b4x-supabase-realtime-postgres-changes.157673/)
- [Broadcast - Send and receive messages using Realtime Broadcast](https://www.b4x.com/android/forum/threads/b4x-supabase-realtime-broadcast.157674/)
- [Presence - Share state between users with Realtime Presence](https://www.b4x.com/android/forum/threads/b4x-supabase-realtime-presence.157679/)

- [Supabase Chat Example](https://www.b4x.com/android/forum/threads/b4x-supabase-supachat-chat-example-app.157350/)
- [Supabase Broadcast Example](https://www.b4x.com/android/forum/threads/b4x-supabase-realtime-broadcast-example-app.157783/)

**Supabase  
Author: Alexander Stolte  
Version: 1.25**  
[SPOILER="Properties, Functions, Events, etc."]  

- **Supabase**

- **Events:**

- **AuthStateChange** (StateType As String)
- **RangeDownloadTracker** (Tracker As SupabaseRangeDownloadTracker)

- **Functions:**

- **Class\_Globals** As String
- **getApiKey** As String
- **getAuth** As Supabase\_Authentication
- **getDatabase** As Supabase\_Database
- **getLogEvents** As Boolean
- **getStorage** As Supabase\_Storage
- **getURL** As String
- **Initialize** (URL As String, AnonKey As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **InitializeEvents** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setLogEvents** (Enabled As Boolean) As String

- **Properties:**

- **ApiKey** As String [read only]
- **Auth** As Supabase\_Authentication [read only]
- **Database** As Supabase\_Database [read only]
- **LogEvents** As Boolean
- **Storage** As Supabase\_Storage [read only]
- **URL** As String [read only]

- **SupabaseDatabaseResult**

- **Fields:**

- **Columns** As Map
- **Error** As SupabaseError
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Rows** As List
- **Tag** As Object

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **SupabaseError**

- **Fields:**

- **ErrorMessage** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **StatusCode** As Int
- **Success** As Boolean

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **SupabaseRangeDownloadTracker**

- **Fields:**

- **Cancel** As Boolean
- **Completed** As Boolean
- **CurrentLength** As Long
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TotalLength** As Long

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **SupabaseRealtime**

- **Events:**

- **BroadcastDataReceived** (BroadcastData As SupabaseRealtime\_BroadcastData)
- **Connected**
- **DataReceived** (Data As SupabaseRealtime\_Data)
- **Disconnected**
- **PresenceDataReceived** (PresenceData As SupabaseRealtime\_PresenceData)
- **Subscribed**

- **Fields:**

- **Filter\_Equal** As String
- **Filter\_GreatherThan** As String
- **Filter\_GreatherThanOrEqual** As String
- **Filter\_In** As String
- **Filter\_LessThan** As String
- **Filter\_LessThanOrEqual** As String
- **Filter\_NotEqual** As String
- **SubscribeType\_Broadcast** As String
- **SubscribeType\_PostgresChanges** As String
- **SubscribeType\_Presence** As String

- **Functions:**

- **BuildFilter** (Column As String, FilterName As String, Value As String) As String
- **Channel** (Schema As String, Table As String, Filter As String) As SupabaseRealtime\_Channel
*Creates an realtime channel  
 Postgres changes example:  
 <code>  
 Realtime \_  
 .Channel("public","dt\_Chat",Realtime.BuildFilter("room\_id",Realtime.Filter\_Equal,"3")) \_  
 .On(Realtime.SubscribeType\_PostgresChanges) \_  
 .Event(Realtime.Event\_ALL) \_  
 .Subscribe  
 </code>  
 Broadcast example:  
 <code>  
 Realtime \_  
 .Channel("Room1","","") \_  
 .On(Realtime.SubscribeType\_Broadcast) \_  
 .ReceiveOwnBroadcasts(False) \_  
 .AcknowledgeBroadcasts(False) \_  
 .Subscribe  
 </code>  
 Presence example:  
 <code>  
 Realtime \_  
 .Channel("Room1","","") \_  
 .On(Realtime.SubscribeType\_Presence) \_  
 .Event(Realtime.Event\_Sync) \_  
 .On(Realtime.SubscribeType\_Presence) \_  
 .Event(Realtime.Event\_Join) \_  
 .On(Realtime.SubscribeType\_Presence) \_  
 .Event(Realtime.Event\_Leave) \_  
 .Subscribe  
 </code>*- **Close** As String
- **Connect** As String
- **getEvent\_ALL** As String
*PostgresChanges only*- **getEvent\_DELETE** As String
*PostgresChanges only*- **getEvent\_INSERT** As String
- **getEvent\_Join** As String
*Presence only*- **getEvent\_Leave** As String
*Presence only*- **getEvent\_Sync** As String
*Presence only*- **getEvent\_UPDATE** As String
*PostgresChanges only*- **getisConnected** As Boolean
*Returns true if the websocket is connected to the database*- **Initialize** (Callback As Object, EventName As String, ThisSupabase As Supabase) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **RemoveChannel** (ThisChannel As SupabaseRealtime\_Channel) As String

- **Properties:**

- **Event\_ALL** As String [read only]
*PostgresChanges only*- **Event\_DELETE** As String [read only]
*PostgresChanges only*- **Event\_INSERT** As String [read only]
- **Event\_Join** As String [read only]
*Presence only*- **Event\_Leave** As String [read only]
*Presence only*- **Event\_Sync** As String [read only]
*Presence only*- **Event\_UPDATE** As String [read only]
*PostgresChanges only*- **isConnected** As Boolean [read only]
*Returns true if the websocket is connected to the database*
- **SupabaseRealtime\_BroadcastData**

- **Fields:**

- **DatabaseError** As SupabaseError
- **Event** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Payload** As Map

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **SupabaseRealtime\_Channel**

- **Functions:**

- **AcknowledgeBroadcasts** (Enabled As Boolean) As SupabaseRealtime\_Channel
*Whether the server should send an acknowledgment message for each broadcast message*- **Class\_Globals** As String
- **Close** As String
- **Event** (EventName As String) As SupabaseRealtime\_Channel
*<code>Realtime.Event\_DELETE</code>  
 <code>Realtime.Event\_INSERT</code>  
 <code>Realtime.Event\_UPDATE</code>  
 <code>Realtime.Event\_ALL</code>  
 <code>Realtime.Event\_Sync</code>  
 <code>Realtime.Event\_Join</code>  
 <code>Realtime.Event\_Leave</code>*- **getTopic** As String
- **Initialize** (Client As SupabaseRealtime\_Client, Topic As String, SchemaName As String, TableName As String, Filter As String, ThisSupabase As Supabase) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **On** (SubscribeType As String) As SupabaseRealtime\_Channel
*Broadcast - Send ephemeral messages from client to clients with low latency  
 Presence - Track and synchronize shared state between clients  
 Postgres\_Changes - Listen to Postgres database changes and send them to authorized clients  
 <code>Realtime.SubscribeType\_Broadcast</code>  
 <code>Realtime.SubscribeType\_Presence</code>  
 <code>Realtime.SubscribeType\_PostgresChanges</code>*- **ReceiveOwnBroadcasts** (Enabled As Boolean) As SupabaseRealtime\_Channel
*Whether you should receive your own broadcasts*- **SendBroadcast** (EventName As String, Payload As Map) As String
*<code>Channel1.SendBroadcast("cursor-pos",CreateMap("x":"198","y":"50"))</code>*- **Subscribe** As SupabaseRealtime\_Channel
- **Track** (UserStatus As Map) As String
*Presence only  
 A client will receive state from any other client that is subscribed to the same topic.  
 It will also automatically trigger its own sync and join event handlers.*- **Unsubscribe** As SupabaseRealtime\_Channel
- **Untrack** As String
*Presence only  
 You can stop tracking presence using the untrack() method. This will trigger the sync and leave event handlers.*
- **Properties:**

- **Topic** As String [read only]

- **SupabaseRealtime\_Client**

- **Functions:**

- **Channel** (SchemaName As String, TableName As String, Filter As String) As SupabaseRealtime\_Channel
*SchemaName - public  
 Available Events:  
 "\*" | "INSERT" | "UPDATE" | "DELETE"  
 Default: \**- **Class\_Globals** As String
- **Close** As String
- **Connect**
- **getisConnected** As Boolean
- **Initialize** (Callback As Object, EventName As String, ThisSupabase As Supabase, RealTime As SupabaseRealtime) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **RemoveChannel** (ThisChannel As SupabaseRealtime\_Channel) As String
- **SendMessage** (jSonMessage As String)

- **Properties:**

- **isConnected** As Boolean [read only]

- **SupabaseRealtime\_Data**

- **Fields:**

- **Columns** As List
- **CommitTimestamp** As Long
- **DatabaseError** As SupabaseError
- **EventType** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **OldRecord** As Map
- **Records** As Map
- **Schema** As String
- **Table** As String

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **SupabaseRealtime\_PresenceData**

- **Fields:**

- **DatabaseError** As SupabaseError
- **Event** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Joins** As Map
- **Leaves** As Map

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **SupabaseRpcResult**

- **Fields:**

- **Data** As Object
- **Error** As SupabaseError
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Tag** As Object

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **SupabaseStorageBucket**

- **Fields:**

- **AllowedMimeTypes** As List
- **CreatedAt** As Long
- **Error** As SupabaseError
- **FileSizeLimit** As Int
- **Id** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **isPublic** As Boolean
- **Name** As String
- **Owner** As String
- **UpdatedAt** As Long

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **SupabaseStorageFile**

- **Fields:**

- **Error** As SupabaseError
- **FileBody** As Byte()
- **Id** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Key** As String
- **PublicUrl** As String
- **SignedURL** As String

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **SupabaseStorageResult**

- **Fields:**

- **Error** As SupabaseError
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **SupabaseTokenInformations**

- **Fields:**

- **AccessExpiry** As Long
- **AccessToken** As String
- **Email** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **RefreshToken** As String
- **Tag** As Object
- **TokenType** As String
- **Valid** As Boolean

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **SupabaseUser**

- **Fields:**

- **Aud** As String
- **ConfirmationSentAt** As Long
- **ConfirmedAt** As Long
- **CreatedAt** As Long
- **Email** As String
- **EmailConfirmedAt** As Long
- **Error** As SupabaseError
- **Id** As String
- **isAnonymous** As Boolean
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **json** As JSONConverter
- **LastSignInAt** As Long
- **Metadata** As Map
- **Phone** As String
- **Role** As String
- **UpdatedAt** As Long

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **Supabase\_Authentication**

- **Functions:**

- **GetAccessToken** As ResumableSub
- **getProvider\_Apple** As String
*B4I Only*- **getProvider\_Google** As String
- **GetUser** As ResumableSub
*Gets the user object  
 <code>Wait For (xSupabase.Auth.GetUser) Complete (User As SupabaseUser)</code>*- **Initialize** (ThisSupabase As Supabase, EventName As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **isUserLoggedIn** As ResumableSub
*Checks if the user is logged in, renews the access token if it has expired  
 <code>Wait For (xSupabase.Auth.isUserLoggedIn) Complete (isLoggedIn As Boolean)</code>*- **LogIn\_Anonymously** As ResumableSub
*Allow your users to sign up without requiring users to enter an email address, password  
 It is strongly recommended to enable invisible Captcha or Cloudflare Turnstile to prevent abuse for anonymous sign-ins, you can more read about in the forum thread.  
 <code>  
 Wait For (xSupabase.Auth.LogIn\_Anonymously) Complete (AnonymousUser As SupabaseUser)  
 If AnonymousUser.Error.Success Then  
 Log("Successfully created an anonymous user")  
 Else  
 Log("Error: " & AnonymousUser.Error.ErrorMessage)  
 End If  
 </code>*- **Login\_EmailPassword** (Email As String, Password As String) As ResumableSub
*If an account is created, users can login to your app.  
 <code>  
Wait For (xSupabase.Auth.LogIn\_EmailPassword("[EMAIL]test@example.com[/EMAIL]","Test123!!")) Complete (User As SupabaseUser)  
 If User.Error.Success Then  
 Log("successfully logged in with " & User.Email)  
 Else  
 Log("Error: " & User.Error.ErrorMessage)  
 End If  
 </code>*- **LogIn\_MagicLink** (Email As String) As ResumableSub
*Send a user a passwordless link which they can use to redeem an access\_token.  
 code>  
Wait For (xSupabase.Auth.LogIn\_MagicLink("[EMAIL]test@example.com[/EMAIL]")) Complete (Result As SupabaseError)  
 If Result.Success Then  
 Log("magic link successfully sent")  
 Else  
 Log("Error: " & Result.ErrorMessage)  
 End If  
 </code>*- **Logout** As ResumableSub
*User tokens are removed from the device  
 After calling log out, all interactions using the Supabase B4X client will be "anonymous".  
 <code>  
 Wait For (xSupabase.Auth.Logout) Complete (Result As SupabaseError)  
 If Result.Success Then  
 Log("User successfully logged out")  
 Else  
 Log("Error: " & Result.ErrorMessage)  
 End If  
 </code>*- **PasswordRecovery** (Email As String) As ResumableSub
*<code>  
wait for (xSupabase.Auth.PasswordRecovery("[EMAIL]test@example.com[/EMAIL]")) Complete (Response As SupabaseError)  
 If Response.Success Then  
 Log("Recovery email sent successfully")  
 Else  
 Log("Error: " & Response.ErrorMessage)  
 End If  
 </code>*- **RefreshToken** As ResumableSub
- **SaveToken** As String
- **SignInWithOAuth** (ClientId As String, Provider As String, Scope As String, ClientSecret As String) As ResumableSub
*Signs the user in using third party OAuth providers.  
 <code>  
 #If B4A  
Wait For (xSupabase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email <https://www.googleapis.com/auth/userinfo.email>")) Complete (User As SupabaseUser)  
 #Else If B4I  
Wait For (xSupabase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email <https://www.googleapis.com/auth/userinfo.email>")) Complete (User As SupabaseUser)  
 #Else If B4J  
Wait For (xSupabase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email <https://www.googleapis.com/auth/userinfo.email>","xxx")) Complete (User As SupabaseUser)  
 #End If  
 If User.Error.Success Then  
 Log("successfully logged in with " & User.Email)  
 Else  
 Log("Error: " & User.Error.ErrorMessage)  
 End If  
 </code>*- **SignUp** (Email As String, Password As String, Options As Map) As ResumableSub
*Allow your users to sign up and create a new account.  
 <code>  
wait for (xSupabase.Auth.SignUp("[EMAIL]test@example.com[/EMAIL]","Test123!",Null)) Complete (NewUser As SupabaseUser)  
 If NewUser.Error.Success Then  
 Log("successfully registered with " & NewUser.Email)  
 Else  
 Log("Error: " & NewUser.Error.ErrorMessage)  
 End If  
 </code>  
 Options - additional user metadata  
 <code>  
 Dim AdditionalUserMetadata As Map = CreateMap("first\_name":"Alexander","age":25)  
Wait For (xSupabase.Auth.SignUp("[EMAIL]test@gmail.com[/EMAIL]","Test123!",AdditionalUserMetadata)) Complete (NewUser As SupabaseUser)  
 </code>*- **TokenInformations** As SupabaseTokenInformations
- **UpdateUser** (NewEmail As String, NewPassword As String) As ResumableSub
*Update the user with a new email or password. Each key (email, password, and data) is optional  
 If you don't want to change the password and only the email address, just leave the password blank  
 If you don't want to change the email address and only the password, just leave the email blank  
 <code>  
Wait For (xSupabase.Auth.UpdateUser("[EMAIL]test@example.com[/EMAIL]","")) Complete (Result As SupabaseError)  
 If Result.Success Then  
 Log("User data successfully changed")  
 Else  
 Log("Error: " & Result.ErrorMessage)  
 End If  
 </code>*
- **Properties:**

- **Provider\_Apple** As String [read only]
*B4I Only*- **Provider\_Google** As String [read only]

- **Supabase\_Database**

- **Functions:**

- **CallFunction** As Supabase\_DatabaseRpc
*<code>  
 Dim CallFunction As Supabase\_DatabaseRpc = xSupabase.Database.CallFunction  
 CallFunction.Rpc("hello\_world")  
 Wait For (CallFunction.Execute) Complete (RpcResult As SupabaseRpcResult)  
 If RpcResult.Error.Success Then  
 Log(RpcResult.Data)  
 End If  
 </code>*- **DeleteData** As Supabase\_DatabaseDelete
*<code>  
 Dim Delete As Supabase\_DatabaseDelete = xSupabase.Database.DeleteData  
 Delete.From("dt\_Tasks")  
 Delete.Eq(CreateMap("Tasks\_Id":15))  
 Wait For (Delete.Execute) Complete (Result As SupabaseError)  
 </code>*- **Initialize** (ThisSupabase As Supabase) As String
*Initializes the object. You can add parameters to this method if needed.*- **InsertData** As Supabase\_DatabaseInsert
*One Row:  
 <code>  
 Dim Insert As Supabase\_DatabaseInsert = xSupabase.Database.InsertData  
 Insert.From("dt\_Tasks")  
Dim InsertMap As Map = CreateMap("Tasks\_Name":"Task 07","Tasks\_Checked":False,"Tasks\_CreatedAt":DateUtils.TicksToString(DateTime.Now),"Tasks\_UpdatedAt":DateUtils.TicksToString(DateTime.Now))  
 Wait For (Insert.Insert(InsertMap).Upsert.Execute) Complete (Result As SupabaseDatabaseResult)  
 </code>  
 Bulk Insert:  
 <code>  
 Dim Insert As Supabase\_DatabaseInsert = xSupabase.Database.InsertData  
 Insert.From("dt\_Tasks")  
 Dim lst\_BulkInsert As List  
 lst\_BulkInsert.Initialize  
lst\_BulkInsert.Add(CreateMap("Tasks\_Name":"Task 05","Tasks\_Checked":True,"Tasks\_CreatedAt":DateUtils.TicksToString(DateTime.Now),"Tasks\_UpdatedAt":DateUtils.TicksToString(DateTime.Now)))  
lst\_BulkInsert.Add(CreateMap("Tasks\_Name":"Task 06","Tasks\_Checked":True,"Tasks\_CreatedAt":DateUtils.TicksToString(DateTime.Now),"Tasks\_UpdatedAt":DateUtils.TicksToString(DateTime.Now)))  
 Wait For (Insert.InsertBulk(lst\_BulkInsert).Execute) Complete (Result As SupabaseDatabaseResult)  
 </code>*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **PrintTable** (Table As SupabaseDatabaseResult) As String
- **SelectData** As Supabase\_DatabaseSelect
*<code>  
 Dim Query As Supabase\_DatabaseSelect = xSupabase.Database.SelectData  
 Query.Columns("\*").From("dt\_Tasks")  
 Wait For (Query.Execute) Complete (DatabaseResult As SupabaseDatabaseResult)  
 xSupabase.Database.PrintTable(DatabaseResult)  
 </code>*- **UpdateData** As Supabase\_DatabaseUpdate
*<code>  
 Dim Update As Supabase\_DatabaseUpdate = xSupabase.Database.UpdateData  
 Update.From("dt\_Tasks")  
 Update.Update(CreateMap("Tasks\_Name":"Task 08"))  
 Update.Eq(CreateMap("Tasks\_Id":15))  
 Wait For (Update.Execute) Complete (Result As SupabaseDatabaseResult)  
 </code>*
- **Supabase\_DatabaseDelete**

- **Functions:**

- **Class\_Globals** As String
- **Eq** (ColumnValue As Map) As Supabase\_DatabaseDelete
- **Execute** As ResumableSub
- **From** (TableName As String) As Supabase\_DatabaseDelete
- **Initialize** (ThisSupabase As Supabase) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
- **Supabase\_DatabaseInsert**

- **Functions:**

- **Class\_Globals** As String
- **Execute** As ResumableSub
- **From** (TableName As String) As Supabase\_DatabaseInsert
- **Initialize** (ThisSupabase As Supabase) As String
*Initializes the object. You can add parameters to this method if needed.*- **Insert** (ColumnValue As Map) As Supabase\_DatabaseInsert
*Insert one row  
<code>Dim InsertMap As Map = CreateMap("Tasks\_Name":"Task 01","Tasks\_Checked":True,"Tasks\_CreatedAt":DateUtils.TicksToString(DateTime.Now))</code>*- **InsertBulk** (ColumnValueList As List) As Supabase\_DatabaseInsert
*Insert many rows  
 <code> Dim lst\_BulkInsert As List  
 lst\_BulkInsert.Initialize  
lst\_BulkInsert.Add(CreateMap("Tasks\_Name":"Task 01","Tasks\_Checked":True,"Tasks\_CreatedAt":DateUtils.TicksToString(DateTime.Now)))  
lst\_BulkInsert.Add(CreateMap("Tasks\_Name":"Task 02","Tasks\_Checked":False,"Tasks\_CreatedAt":DateUtils.TicksToString(DateTime.Now)))  
 </code>*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **SelectData** As Supabase\_DatabaseInsert
- **Upsert** As Supabase\_DatabaseInsert
*Upserting is an operation that performs both: Inserting a new row if a matching row doesn't already exist. Either updating the existing row, or doing nothing, if a matching row already exists.*
- **Supabase\_DatabaseRpc**

- **Functions:**

- **Class\_Globals** As String
- **Execute** As ResumableSub
- **Filter\_Equal** (ColumnValue As Map) As Supabase\_DatabaseRpc
*Finds all rows whose value on the stated column match the specified value*- **Filter\_GreatherThan** (ColumnValue As Map) As Supabase\_DatabaseRpc
*Finds all rows whose value on the stated column is greater than the specified value*- **Filter\_GreatherThanOrEqual** (ColumnValue As Map) As Supabase\_DatabaseRpc
*Finds all rows whose value on the stated column is greater than or equal to the specified value*- **Filter\_Ilike** (ColumnValue As Map) As Supabase\_DatabaseRpc
*Finds all rows whose value in the stated column matches the supplied pattern (case insensitive)*- **Filter\_In** (ColumnValue As Map) As Supabase\_DatabaseRpc
*Finds all rows whose value on the stated column is found on the specified values*- **Filter\_Is** (ColumnValue As Map) As Supabase\_DatabaseRpc
*A check for exact equality (null, true, false), finds all rows whose value on the stated column exactly match the specified value*- **Filter\_LessThan** (ColumnValue As Map) As Supabase\_DatabaseRpc
*Finds all rows whose value on the stated column is less than the specified value*- **Filter\_LessThanOrEqual** (ColumnValue As Map) As Supabase\_DatabaseRpc
*Finds all rows whose value on the stated column is less than or equal to the specified value*- **Filter\_Like** (ColumnValue As Map) As Supabase\_DatabaseRpc
*Finds all rows whose value in the stated column matches the supplied pattern (case sensitive)*- **Filter\_NotEqual** (ColumnValue As Map) As Supabase\_DatabaseRpc
*Finds all rows whose value on the stated column doesn't match the specified value.*- **Filter\_Or** (ColumnValue As Map) As Supabase\_DatabaseRpc
- **Filter\_TextSearch** (ColumnValue As Map, FilterType As String) As Supabase\_DatabaseRpc
*FilterType:  
 <code>plain</code>  
 <code>phrase</code>  
 <code>websearch</code>  
 <code>""</code>*- **Initialize** (ThisSupabase As Supabase) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Limit** (RowLimit As Int) As String
- **Offset** (RowOffset As Int) As String
*Says to skip that many rows before beginning to return rows. OFFSET 0 is the same as omitting the OFFSET clause, as is OFFSET with a NULL argument.*- **OrderBy** (ColumnSortDirection As String) As String
*Example:  
 <code>"Task\_Id.desc"</code>  
 <code>"Task\_Id.desc,Task\_Name.asc"</code>  
 Available sorting commands:  
 <code>desc</code>  
 <code>asc</code>  
 <code>nullsfirst</code>  
 <code>nullslast</code>*- **Parameters** (ParamValue As Map) As Supabase\_DatabaseRpc
*The arguments to pass to the function call.  
 <code>CallFunction.Parameters(CreateMap("ParameterName":"ParameterValue"))</code>*- **Range** (FirstPage As Int, LastPage As Int) As Supabase\_DatabaseRpc
- **Rpc** (FunctionName As String) As Supabase\_DatabaseRpc
*Perform a function call.  
 You can call Postgres functions As Remote Procedure Calls, logic in your database that you can Execute From anywhere.  
 Functions are useful when the logic rarely changes—like For password resets And updates.*
- **Supabase\_DatabaseSelect**

- **Functions:**

- **Class\_Globals** As String
- **Columns** (Column As String) As Supabase\_DatabaseSelect
- **Execute** As ResumableSub
- **Filter\_Equal** (ColumnValue As Map) As Supabase\_DatabaseSelect
*Finds all rows whose value on the stated column match the specified value*- **Filter\_GreatherThan** (ColumnValue As Map) As Supabase\_DatabaseSelect
*Finds all rows whose value on the stated column is greater than the specified value*- **Filter\_GreatherThanOrEqual** (ColumnValue As Map) As Supabase\_DatabaseSelect
*Finds all rows whose value on the stated column is greater than or equal to the specified value*- **Filter\_Ilike** (ColumnValue As Map) As Supabase\_DatabaseSelect
*Finds all rows whose value in the stated column matches the supplied pattern (case insensitive)*- **Filter\_In** (ColumnValue As Map) As Supabase\_DatabaseSelect
*Finds all rows whose value on the stated column is found on the specified values*- **Filter\_Is** (ColumnValue As Map) As Supabase\_DatabaseSelect
*A check for exact equality (null, true, false), finds all rows whose value on the stated column exactly match the specified value*- **Filter\_LessThan** (ColumnValue As Map) As Supabase\_DatabaseSelect
*Finds all rows whose value on the stated column is less than the specified value*- **Filter\_LessThanOrEqual** (ColumnValue As Map) As Supabase\_DatabaseSelect
*Finds all rows whose value on the stated column is less than or equal to the specified value*- **Filter\_Like** (ColumnValue As Map) As Supabase\_DatabaseSelect
*Finds all rows whose value in the stated column matches the supplied pattern (case sensitive)*- **Filter\_NotEqual** (ColumnValue As Map) As Supabase\_DatabaseSelect
*Finds all rows whose value on the stated column doesn't match the specified value.*- **Filter\_Or** (ColumnValue As Map) As Supabase\_DatabaseSelect
- **Filter\_TextSearch** (ColumnValue As Map, FilterType As String) As Supabase\_DatabaseSelect
*FilterType:  
 <code>plain</code>  
 <code>phrase</code>  
 <code>websearch</code>  
 <code>""</code>*- **From** (TableName As String) As Supabase\_DatabaseSelect
- **Initialize** (ThisSupabase As Supabase) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Limit** (RowLimit As Int) As String
- **Offset** (RowOffset As Int) As String
*Says to skip that many rows before beginning to return rows. OFFSET 0 is the same as omitting the OFFSET clause, as is OFFSET with a NULL argument.*- **OrderBy** (ColumnSortDirection As String) As String
*Example:  
 <code>"Task\_Id.desc"</code>  
 <code>"Task\_Id.desc,Task\_Name.asc"</code>  
 Available sorting commands:  
 <code>desc</code>  
 <code>asc</code>  
 <code>nullsfirst</code>  
 <code>nullslast</code>*- **Range** (FirstPage As Int, LastPage As Int) As Supabase\_DatabaseSelect

- **Supabase\_DatabaseUpdate**

- **Functions:**

- **Class\_Globals** As String
- **Eq** (ColumnValue As Map) As Supabase\_DatabaseUpdate
- **Execute** As ResumableSub
- **From** (TableName As String) As Supabase\_DatabaseUpdate
- **Initialize** (ThisSupabase As Supabase) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **SelectData** As Supabase\_DatabaseUpdate
- **Update** (ColumnValue As Map) As Supabase\_DatabaseUpdate

- **Supabase\_Functions**

- **Functions:**

- **CreateDatabaseResult** (JsonString As String) As SupabaseDatabaseResult
- **GenerateResult** (j As b4j.example.httpjob) As Map
- **getErrorCode** (root As Map) As Int
*code: 400*- **getErrorMap** (root As Map) As Map
*reason: invalid  
 domain: global  
 message: EMAIL\_NOT\_FOUND*- **getErrorMessage** (root As Map) As String
*message: EMAIL\_NOT\_FOUND*- **GetFileExt** (FileName As String) As String
- **GetFilename** (fullpath As String) As String
- **GetMimeTypeByExtension** (Extension As String) As String
*<https://www.b4x.com/android/forum/threads/b4x-get-mime-type-by-extension.150330/>*- **ParseDateTime** (DateString As String) As Long
- **Process\_Globals** As String
- **SubExists2** (Target As Object, TargetSub As String, NumbersOfParameters As Int) As Boolean

- **Supabase\_Storage**

- **Functions:**

- **BytesToImage** (bytes As Byte()) As B4XBitmap
- **ConvertFile2Binary** (Dir As String, FileName As String) As Byte()
- **CopyFile** (BucketName As String, FromPath As String, ToPath As String) As Supabase\_StorageFile
*Copies an existing file to a new path in the same bucket.  
 FromPath - The original file path, including the current file name. For example `folder/image.png`  
 ToPath - The new file path, including the new file name. For example `folder/image-copy.png`  
 <code>  
 Wait For (xSupabase.Storage.CopyFile("Avatar","public/avatar1.png", "private/avatar2.png").Execute) Complete (StorageFile As SupabaseStorageFile)  
 If StorageFile.Error.Success Then  
 Log($"Files successfully copied "$)  
 Else  
 Log("Error: " & StorageFile.Error.ErrorMessage)  
 End If  
 </code>*- **CreateBucket** (Name As String) As Supabase\_StorageBucket
*Creates a new Storage bucket  
 Name - A unique identifier for the bucket you are creating  
 <code>  
 Dim CreateBucket As Supabase\_StorageBucket = xSupabase.Storage.CreateBucket("Avatar")  
 CreateBucket.Options\_isPublic(False)  
 CreateBucket.Options\_FileSizeLimit(1048576 )  
 CreateBucket.Options\_AllowedMimeTypes(Array("image/png","image/jpg"))  
 Wait For (CreateBucket.Execute) Complete (Bucket As SupabaseStorageBucket)  
 If Bucket.Error.Success Then  
 Log($"Bucket ${Bucket.Name} successfully created "$)  
 Else  
 Log("Error: " & Bucket.Error.ErrorMessage)  
 End If  
 </code>*- **CreateSignedUrl** (BucketName As String, Path As String, ExpiresInSeconds As Int) As Supabase\_StorageFile
*Create signed url to download file without requiring permissions. This URL can be valid for a set number of seconds.  
 <code>  
 Wait For (xSupabase.Storage.CreateSignedUrl("Avatar","test.png",60).Execute) Complete (StorageFile As SupabaseStorageFile)  
 If StorageFile.Error.Success Then  
 Log(StorageFile.SignedURL)  
 Dim DownloadFile As Supabase\_StorageFile = xSupabase.Storage.DownloadFile("Avatar")  
 DownloadFile.Path("test.png")  
 DownloadFile.SignedURL(StorageFile.SignedURL)  
 Wait For (DownloadFile.Execute) Complete (StorageFile As SupabaseStorageFile)  
 If StorageFile.Error.Success Then  
 Log($"File from signed URL successfully downloaded "$)  
 ImageView1.SetBitmap(xSupabase.Storage.BytesToImage(StorageFile.FileBody))  
 Else  
 Log("Error: " & StorageFile.Error.ErrorMessage)  
 End If  
 Else  
 Log("Error: " & StorageFile.Error.ErrorMessage)  
 End If  
 </code>*- **DeleteBucket** (Name As String) As Supabase\_StorageBucket
*Deletes an existing bucket. A bucket can't be deleted with existing objects inside it. You must first empty() the bucket.  
 <code>  
 Dim DelteBucket As Supabase\_StorageBucket = xSupabase.Storage.DeleteBucket("Avatar")  
 Wait For (DelteBucket.Execute) Complete (Bucket As SupabaseStorageBucket)  
 If Bucket.Error.Success Then  
 Log($"Bucket ${Bucket.Name} successfully deleted "$)  
 Else  
 Log("Error: " & Bucket.Error.ErrorMessage)  
 End If  
 </code>*- **DownloadFile** (BucketName As String, Path As String) As Supabase\_StorageFile
*Downloads a file.  
 <code>  
 Dim DownloadFile As Supabase\_StorageFile = xSupabase.Storage.DownloadFile("Avatar","test.png")  
 Wait For (DownloadFile.Execute) Complete (StorageFile As SupabaseStorageFile)  
 If StorageFile.Error.Success Then  
 Log($"File ${"test.jpg"} successfully downloaded "$)  
 ImageView1.SetBitmap(xSupabase.Storage.BytesToImage(StorageFile.FileBody))  
 Else  
 Log("Error: " & StorageFile.Error.ErrorMessage)  
 End If  
 </code>*- **DownloadFileProgress** (BucketName As String, Path As String, EventCallback As Object, EventName As String, DownloadPath As String) As Supabase\_StorageFile
*<code>  
 xui.SetDataFolder("supabase")  
 Dim DownloadFile As Supabase\_StorageFile = xSupabase.Storage.DownloadFileProgress("Avatar","test.png",Me,"DownloadProfileImage",xui.DefaultFolder)  
 Wait For (DownloadFile.Execute) Complete (StorageFile As SupabaseStorageFile)  
 If StorageFile.Error.Success Then  
 Log($"File ${"test.jpg"} successfully downloaded "$)  
 B4XImageView1.SetBitmap(xSupabase.Storage.BytesToImage(StorageFile.FileBody))  
 If File.Exists(xui.DefaultFolder,"test.png") Then File.Delete(xui.DefaultFolder,"test.png") 'Clean the download path, or do what ever you want  
 Else  
 Log("Error: " & StorageFile.Error.ErrorMessage)  
 End If  
 Private Sub DownloadProfileImage\_RangeDownloadTracker(Tracker As SupabaseRangeDownloadTracker)  
 Log($"$1.2{Tracker.CurrentLength / 1024 / 1024}MB / $1.2{Tracker.TotalLength / 1024 / 1024}MB"$)  
 AnotherProgressBar1.Value = Tracker.CurrentLength / Tracker.TotalLength \* 100  
 End Sub  
 </code>*- **EmptyBucket** (Name As String) As Supabase\_StorageBucket
*Removes all objects inside a single bucket.  
 <code>  
 Wait For (xSupabase.Storage.EmptyBucket("Avatar").Execute) Complete (Bucket As SupabaseStorageBucket)  
 If Bucket.Error.Success Then  
 Log($"Bucket ${Bucket.Name} successfully cleared "$)  
 Else  
 Log("Error: " & Bucket.Error.ErrorMessage)  
 End If  
 </code>*- **GetBucket** (Name As String) As Supabase\_StorageBucket
*Retrieves the details of an existing Storage bucket.  
 <code>  
 Dim GetBucket As Supabase\_StorageBucket = xSupabase.Storage.GetBucket("Avatar")  
 Wait For (GetBucket.Execute) Complete (Bucket As SupabaseStorageBucket)  
 If Bucket.Error.Success Then  
 Log($"Bucket ${Bucket.Name} was created at ${DateUtils.TicksToString(Bucket.CreatedAt)}"$)  
 Else  
 Log("Error: " & Bucket.Error.ErrorMessage)  
 End If  
 </code>*- **GetPublicUrl** (BucketName As String, Path As String) As String
*Retrieve public URL  
 A simple convenience function to get the URL for an asset in a public bucket. If you do not want to use this function, you can construct the public URL by concatenating the bucket URL with the path to the asset.  
 This function does not verify if the bucket is public. If a public URL is created for a bucket which is not public, you will not be able to download the asset.  
 <code>Log(xSupabase.Storage.GetPublicUrl("Avatar","test.png"))</code>*- **Initialize** (ThisSupabase As Supabase) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **MoveFile** (BucketName As String, FromPath As String, ToPath As String) As Supabase\_StorageFile
*Moves an existing file to a new path in the same bucket.  
 FromPath - The original file path, including the current file name. For example `folder/image.png`  
 ToPath - The new file path, including the new file name. For example `folder/image-copy.png`  
 <code>  
 Wait For (xSupabase.Storage.MoveFile("Avatar","public/avatar1.png", "private/avatar2.png").Execute) Complete (StorageFile As SupabaseStorageFile)  
 If StorageFile.Error.Success Then  
 Log($"Files successfully moved "$)  
 Else  
 Log("Error: " & StorageFile.Error.ErrorMessage)  
 End If  
 </code>*- **UpdateBucket** (Name As String) As Supabase\_StorageBucket
*Updates a new Storage bucket  
 <code>  
 Dim UpdateBucket As Supabase\_StorageBucket = xSupabase.Storage.UpdateBucket("Avatar")  
 UpdateBucket.Options\_isPublic(True)  
 UpdateBucket.Options\_FileSizeLimit(1048576 )  
 UpdateBucket.Options\_AllowedMimeTypes(Array("image/png"))  
 Wait For (UpdateBucket.Execute) Complete (Bucket As SupabaseStorageBucket)  
 If Bucket.Error.Success Then  
 Log($"Bucket ${Bucket.Name} successfully updated "$)  
 Else  
 Log("Error: " & Bucket.Error.ErrorMessage)  
 End If  
 </code>*- **UpdateFile** (BucketName As String, Path As String) As Supabase\_StorageFile
*Replaces an existing file at the specified path with a new one.  
 <code>  
 Dim UpdateFile As Supabase\_StorageFile = xSupabase.Storage.UpdateFile("Avatar","test.png")  
 UpdateFile.FileBody(xSupabase.Storage.ConvertFile2Binary(File.DirAssets,"test2.jpg"))  
 Wait For (UpdateFile.Execute) Complete (StorageFile As SupabaseStorageFile)  
 If StorageFile.Error.Success Then  
 Log($"File ${"test.jpg"} successfully updated "$)  
 Else  
 Log("Error: " & StorageFile.Error.ErrorMessage)  
 End If  
 </code>*- **UploadFile** (BucketName As String, Path As String) As Supabase\_StorageFile
*Uploads a file to an existing bucket.  
 <code>  
 Dim UploadFile As Supabase\_StorageFile = xSupabase.Storage.UploadFile("Avatar","test.png")  
 UploadFile.FileBody(xSupabase.Storage.ConvertFile2Binary(File.DirAssets,"test.jpg"))  
 Wait For (UploadFile.Execute) Complete (StorageFile As SupabaseStorageFile)  
 If StorageFile.Error.Success Then  
 Log($"File ${"test.jpg"} successfully uploaded "$)  
 Else  
 Log("Error: " & StorageFile.Error.ErrorMessage)  
 End If  
 </code>*
- **Supabase\_StorageBucket**

- **Functions:**

- **Class\_Globals** As String
- **Execute** As ResumableSub
- **Initialize** (ThisSupabase As Supabase, Name As String, Mode As String) As String
*Initializes the object. You can add parameters to this method if needed.  
 Name - A unique identifier for the bucket*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Options\_AllowedMimeTypes** (MimeTypes As Object()) As Supabase\_StorageBucket
*specifies the allowed mime types that this bucket can accept during upload. The default value is null, which allows files with all mime types to be uploaded. Each mime type specified can be a wildcard, e.g. image/\*, or a specific mime type, e.g. image/png.*- **Options\_FileSizeLimit** (Limit As Int) As Supabase\_StorageBucket
- **Options\_isPublic** (isPublic As Boolean) As Supabase\_StorageBucket
*The visibility of the bucket. Public buckets don't require an authorization token to download objects, but still require a valid token for all other operations. By default, buckets are private.*
- **Supabase\_StorageFile**

- **Fields:**

- **Tag** As Object

- **Functions:**

- **Class\_Globals** As String
- **CopyFile** (FromPath As String, ToPath As String) As Supabase\_StorageFile
- **DownloadOptions\_TransformFormat** (Format As String) As Supabase\_StorageFile
*Specify the format of the image requested. When using 'origin' we force the format to be the same as the original image. When this option is not passed in, images are optimized to modern image formats like Webp.  
 <code>origin</code>*- **DownloadOptions\_TransformHeight** (Height As Int) As Supabase\_StorageFile
*The height of the image in pixels.*- **DownloadOptions\_TransformQuality** (Quality As Int) As Supabase\_StorageFile
*Set the quality of the returned image. A number from 20 to 100, with 100 being the highest quality. Defaults to 80*- **DownloadOptions\_TransformResize** (ResizeMode As String) As Supabase\_StorageFile
*The resize mode can be cover, contain or fill. Defaults to cover. Cover resizes the image to maintain it's aspect ratio while filling the entire width and height. Contain resizes the image to maintain it's aspect ratio while fitting the entire image within the width and height. Fill resizes the image to fill the entire width and height. If the object's aspect ratio does not match the width and height, the image will be stretched to fit.  
 <code>cover</code>  
 <code>contain</code>  
 <code>fill</code>*- **DownloadOptions\_TransformWidth** (Width As Int) As Supabase\_StorageFile
*The width of the image in pixels.*- **Execute** As ResumableSub
- **ExpiresInSeconds** (Seconds As Int) As Supabase\_StorageFile
- **FileBody** (Data As Byte()) As Supabase\_StorageFile
- **Initialize** (ThisSupabase As Supabase, BucketName As String, Mode As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **MoveFile** (FromPath As String, ToPath As String) As Supabase\_StorageFile
- **Options\_CacheControl** (CacheControl As Int) As Supabase\_StorageFile
*Only for UploadFile and UpdateFile  
 The number of seconds the asset is cached in the browser and in the Supabase CDN. This is set in the `Cache-Control: max-age=<seconds>` header. Defaults to 3600 seconds.*- **Options\_Upsert** (isUpsert As Boolean) As Supabase\_StorageFile
*Only for UploadFile and UpdateFile  
 When upsert is set to true, the file is overwritten if it exists. When set to false, an error is thrown if the object already exists. Defaults to false.*- **Path** (FileName As String) As Supabase\_StorageFile
*The file path, including the file name. Should be of the format `folder/subfolder/filename.png`. The bucket must already exist before attempting to upload.*- **RangeDownloader\_CreateTracker** As SupabaseRangeDownloadTracker
- **RangeDownloader\_Download** (Dir As String, FileName As String, URL As String, Tracker As SupabaseRangeDownloadTracker) As ResumableSub
- **Remove** (FileNames As Object()) As Supabase\_StorageFile
- **SignedURL** (Url As String) As Supabase\_StorageFile

[/SPOILER]  
**Setup**  

```B4X
Private xSupabase As Supabase  
xSupabase.Initialize("YOUR_SUPABASE_URL","YOUR_SUPABASE_ANON_KEY")  
xSupabase.InitializeEvents(Me,"Supabase")
```

  
**Changelog  
[SPOILER="Version 1.00-1.24"][/SPOILER][SPOILER="Version 1.0-1.24"][/SPOILER][SPOILER="Version 1.0-1.24"][/spoiler][SPOILER="Version 1.0-1.24"][/SPOILER]**[SPOILER="Version 1.0-1.24"]  

- **1.00**

- Release

- **1.01 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-supabase-the-open-source-firebase-alternative.149855/post-949865)**)**

- BugFixes
- Add InitializeEvents
- Add Event AuthStateChange
- StateType

- passwordRecovery, signedIn, signedOut, tokenRefreshed, userUpdated

- **1.02**

- **General**

- BugFixes

- **Auth**

- Add SignInWithOAuth - Signs the user in using third party OAuth providers

- Adds Google

- Add Enum Provider\_Google

- so you always know which providers are already implemented
- xSupabase.Auth.Provider\_Google

- **1.03**

- **General**

- BugFixes

- **Auth**

- Add SignInWithOAuth with the Apple Provider
- Add xSupabase.Auth.Provider\_Apple - B4I only

- **1.04**

- **General**

- BugFixes

- **Auth**

- Add isUserLoggedIn - Checks if the user is logged in, renews the access token if it has expired

- **1.05**

- **Storage**

- CRUD operations with buckets can now be performed
- CRUD operations with files can now be performed

- **1.06**

- **Storage**

- BugFixes
- Add DownloadFileProgress - Download large files with a progress indicator

- DownloadFileProgress uses http range feature to download the file in chunks. It will resume the download from the previous point, even if the app was previously killed.
- It first sends a HEAD request to test whether this feature is supported.
- Note that you need to delete the target file if you want to restart the download.

- **1.07**

- **Storage**

- Add DownloadOptions\_Transform…

- height, width, resize,format,quality

- **1.08**

- BugFixes

- **1.09**

- **Realtime**

- Add SupabaseRealtime

- You can now subscribe to topics and get database changes in real time

- **1.10**

- **Database**

- RLS and Auth error message removed when no rows are present
- Removed unnecessary log messages

- **Realtime**

- Works now with B4J

- Update the [jWebSocketClient to V2.0](https://www.b4x.com/android/forum/threads/jwebsocketclientv2.156357/post-963635)
- Thanks to [USER=97072]@OliverA[/USER] and [USER=1]@Erel[/USER]

- Add get isConnected - Returns true if the websocket is connected to the database
- Removed unnecessary log messages
- BugFixes

- **1.11 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-supabase-the-open-source-firebase-alternative.149855/post-964185)**)**

- **Auth**

- Add the "Options" parameter to the SignUp function

- sign up with additional user metadata

- Add "Metadata" to SupabaseUser
- BugFixes

- **Database**

- Select - Joins are now supportet

- **1.12**

- **Realtime**

- Complete workflow redesigned to be closer to the official libraries
- Add Filters

- Filter\_Equal, Filter\_NotEqual, Filter\_GreatherThan, Filter\_GreatherThanOrEqual, Filter\_LessThan, Filter\_LessThanOrEqual, Filter\_In

- Add SubscribeType - Broadcast

- Send ephemeral messages from client to clients with low latency.

- Add SubscribeType - Presence

- Track and synchronize shared state between clients.

- Add SubscribeType - PostgresChanges

- Listen to Postgres database changes and send them to authorized clients.

- **1.13 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-supabase-the-open-source-firebase-alternative.149855/post-965586)**)**

- **General**

- Add get and set LogEvents - If true then you get debugging infos in the log
- Add Some infos to log messages

- **Auth**

- BugFix

- **Database**

- Add OrderBy
- Add Limit
- Add Offset

- **1.14**

- Compatibility for server applications

- **1.15**

- **Realtime**

- Add support for Presence and Broadcast

- Presence: Share state between users with Realtime Presence.
- Broadcast: Send and receive messages using Realtime Broadcast

- Add new enums

- get Event\_Sync - Presence only
- get Event\_Join - Presence only
- get Event\_Leave - Presence only

- Add support for multi event subscribe
- Add SendBroadcast
- Add Event BroadcastDataReceived
- Add Event PresenceDataReceived

- **1.16**

- **Auth**

- BugFixes

- **Realtime**

- Add Event Disconnected

- **1.17**

- Removes the dependency of the xui library so that the library can also work in server apps (non ui)

- **1.18**

- Database

- Filter Ilike BugFix

- **1.19 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-supabase-the-open-source-firebase-alternative.149855/page-3#post-973157)**)**

- **Database**

- Add SelectData to INSERT - Create a record and return it
- Add SelectData to UPDATE - Update a record and return it
- **BreakingChange** on Supabase\_DatabaseInsert

- The return value for execute is no longer of type SupabaseError it is now **SupabaseDatabaseResult**

- **BreakingChange** on Supabase\_DatabaseUpdate

- The return value for execute is no longer of type SupabaseError it is now **SupabaseDatabaseResult**

- **1.20**

- **Database**

- Support for json columns

- the json string of the column must look like this to be recognized: [{"name":"Volleyball","id":1}]

- Important that it starts with [ and ends with ]

- **1.21**

- **Auth**

- BugFix - in GetUser, if the retrieval was successful, the data set was still marked as "False" in the error object

- **1.22**

- **Auth**

- BugFixes on SignUp
- Add LogIn\_Anonymously - Allow your users to sign up without requiring users to enter an email address, password
- Add isAnonymous to SupabaseUser
- BugFixes on oAuth

- **1.23**

- **Database**

- Add rpc support - Call a Postgres function
- BugFixes

- **1.24**

- **Database**

- The RPC FunctionName is now automatically set to lowercase

- **Auth**

- BugFixes on LogIn\_Anonymously

- User is now automatically logged out if they are still logged in with a real account
- A new anonymous account is now not created each time this function is called up, the existing anonymous account is used

[/SPOILER]  

- **1.25**

- **Database**

- BugFix - RPC filters now work

- **1.26**

- Supabase\_Functions

- Better Error Handling on the GenerateResult function

- **1.27**

- **Storage**

- BugFixes

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.me/stoltex)