###  FirebaseFirestore by Claude Obiri Amadu
### 08/01/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/156968/)

Good day & evening  
This is a Firestore Library I've been perfecting since late last year since most of my projects I use Firebase.  
I used Firebase REST APIs and made it Look, Feel & Work like the original.  
Does not conflict with other Firebase Libraries  
Works the same way as: <https://www.b4x.com/android/forum/threads/firebaseadmin-library.155115/>  
  
If you wanna support my work you can do that [by buying me a coffee☕](https://www.buymeacoffee.com/claudeamadu)  
  
**FirebaseFirestore  
Author: Claude Amadu  
Version: 3.01**  

- **Firestore**

- **Events**

- Ready
- Error(Code As Int, Status As String)
- DocumentChanged(Data As Map)
- CollectionChanged(Data As Map)
- ListenerDisconnected

- **Fields**

- TYPE\_ADDED
- TYPE\_MODIFIED
- TYPE\_REMOVED

- **Functions**

- Initialize(EventName As String,Module As Object, Token As String, Database As String, ProjectId As String)
- GetDocument(Collection As String, Document As String) As ResumableSub
- GetCollection(Collection As String) As ResumableSub
- GetCollection2(Collection As String, Limit As Int) As ResumableSub
- CreateDocument(Collection As String, Document As String, Fields As Map) As ResumableSub
- UpdateDocument(Collection As String,Document As String, Fields As Map) As ResumableSub
- DeleteDocumentFields(Collection As String, Document As String, Fields As List) As ResumableSub
- DeleteCollection(Collection As String) As ResumableSub
- DeleteDocument(Collection As String, Document As String) As ResumableSub
- GetFileURL(Path As String) As String
- RunQuery(StructuredQuery As Query) As ResumableSub
- CollectionListen(Collection As String) As ListenerRegistration
- DocumentListen(Collection As String, Document As String) As ListenerRegistration
- GenerateDocumentId As String

- **FieldFilter**

- **Functions**

- Initialize As FieldFilter
- IsIn(Field As String, Value As List) As FieldFilter
- NotIn(Field As String, Value As List) As FieldFilter
- ArrayContainsAny(Field As String, Value As Object) As FieldFilter
- ArrayContains(Field As String, Value As Object) As FieldFilter
- NotEqual(Field As String, Value As Object) As FieldFilter
- EqualTo(Field As String, Value As Object) As FieldFilter
- LessThan(Field As String, Value As Object) As FieldFilter
- GreaterThan(Field As String, Value As Object) As FieldFilter
- GreaterThanOrEqualTo(Field As String, Value As Object) As FieldFilter
- LessThanOrEqualTo(Field As String, Value As Object) As FieldFilter
- Complete As Object

- **CompositeFilter**

- **Functions**

- Initialize As CompositeFilter
- Filters(Filter As FieldFilter) As CompositeFilter
- Filters2(Filter As FieldFilter) As CompositeFilter
- Complete As Map

- **UnaryFilter**

- **Fields**

- IN As String
- CONTAINS As String
- IS\_NOT\_NAN As String
- IS\_NOT\_NULL As String

- **Functions**

- Initialize As UnaryFilter
- SetOperator(Operator As String)As UnaryFilter
- SetField(Field As String) As UnaryFilter
- Complete As Map

- **ListenerRegistration**

- **Fields**

- Enabled

- **Functions**

- Initialize(Module As Object, EventName As String,Project As String)
- CollectionListen(Collection As String)
- DocumentListen(Collection As String, Document As String)
- Remove

- **Query**

- **Fields**

- SubCollection
- DESCENDING
- ASCENDING

- **Functions**

- Initialize As Query
- AddField(Field As String) As Query
- AddFields(Fields As List) As Query
- OrderBy(Field As String, Direction As String) As Query
- From(CollectionPath As String) As Query
- CollectionIn(DocumentPath As PathBuilder) As Query
- StartAt(Values As List) As Query
- EndAt(Values As List) As Query
- Offset(Position As Int) As Query
- Limit(LimitBy As Int) As Query
- Where(Filter As CompositeFilter) As Query
- Where2(Filter As FieldFilter) As Query
- Where3(Filter As UnaryFilter) As Query
- Complete As Map

- **PathBuilder**

- **Functions**

- Append(path As String) As PathBuilder
- Collection(path As String) As PathBuilder
- Document(path As String) As PathBuilder
- Complete As String

- **FirestoreUtils**

- **Functions**

- ParseFirestoreJson(firestoreJson As String) As Map
- ParseFirestoreMap(firestoreJsonMap As Map) As Map
- CreateFirestoreMap(normalJsonMap As Map) As Map
- CreateFirestoreValue(Value As Object) As Map
- UrlEncodeMap(input As Map) As String

**Examples:**  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Store.Initialize("Firestore",Me,Token,"",projectID)  
End Sub  
  
Private Sub Store_Ready  
    'Perform some task here  
End Sub
```

  

```B4X
Wait For(Store.GetDocument("products","items")) Complete(Map As Map)  
  
Wait For (Store.createDocument("users","ugXJFOC9GHZsOtlpW9Vc", Fields)) Complete(m As Map)  
  
Wait For(Store.GetCollection("products")) Complete(Map As Map)  
  
Wait For(Store.UpdateDocument("users","ugXJFOC9GHZsOtlpW9Vc",Fields)) Complete(Map As Map)  
  
Dim dFields As List  
dFields.Initialize  
dFields.AddAll(Array As String("rider","lines","price"))  
Wait For(Store.DeleteDocumentFields("delivery_requests",DocumentID,dFields)) Complete(dMap As Map)  
Log(dMap)
```

  
  

```B4X
Dim Filter As FieldFilter  
Filter.Initialize.EqualTo("user_name","TECNO")  
Dim Comp As CompositeFilter  
Comp.Initialize.Filters(Filter)  
Dim Qry As Query  
Qry.Initialize.AddFields(Array As String("user_name","user_id")).OrderBy("user_id",Qry.DESCENDING).From("users").Where2(Filter)  
Wait For(Store.RunQuery(Qry)) Complete(Map As Map)  
Log(Map)  
  
Dim Filter As FieldFilter  
Filter.Initialize  
Filter.GreaterThan("end",DateTime.Now)  
Dim Qry As Query  
Qry.Initialize  
Qry.OrderBy("end",Qry.DESCENDING).OrderBy("date",Qry.DESCENDING).Where2(Filter).Limit(10)  
Qry.From("promos")  
Wait For (Store.RunQuery(Qry)) Complete(Data As Map)  
Log(Data)  
  
Dim Qry As Query  
Qry.Initialize  
Qry.OrderBy("store_name",Qry.ASCENDING).Limit(10)  
Qry.From("users")  
Wait For (Store.RunQuery(Qry)) Complete(Data As Map)  
Log(Data)  
  
Dim Filter As FieldFilter  
Filter.Initialize.EqualTo("age",30)  
Dim Comp As CompositeFilter  
Comp.Initialize.Filters(Filter)  
Dim Qry As Query  
Qry.Initialize.OrderBy("age",Qry.DESCENDING).From("users").Where(Comp)  
Wait For(Store.RunQuery(Qry)) Complete(Map As Map)
```

  
  

```B4X
Dim Map As Map = CreateMap( _  
"sender_id": MainPage.key.Get("uid"), _  
"sender": MainPage.key.Get("user_name"), _  
"message": TextField.Text, _  
"timestamp": DateTime.Now _  
)  
Dim path As PathBuilder  
path.Initialize  
path.Collection("chats").Document(ChatDocID).Collection("messages")'Sub collection in chats  
Log(path.Complete)  
Wait For(store.CreateDocument(path.Complete,"",Map)) Complete(Data As Map)  
Log(Data)
```

  
  

```B4X
Public Sub StartListen  
    UsersListerner = Store.CollectionListen("users")  
    ChatsListener = Store.CollectionListen(ChatDocCollection)  
End Sub
```

  
  

```B4X
Dim ChatsListener As ListenerRegistration  
Dim QueryMap As Map = CreateMap("orderBy":"timestamp","direction":"asc")  
ChatsListener = Store.CollectionListen2(path.Complete,QueryMap)
```

  
  

```B4X
Public Sub EndListen  
    If UsersListerner.Enabled Then UsersListerner.Remove  
    If ChatsListener.Enabled Then ChatsListener.Remove  
End Sub  
  
Private Sub Store_CollectionChanged(Data As Map)  
    Log("Collection changed: " & Data)  
    If Data.IsInitialized Then  
        Dim Params As Map = Data.Get("data")  
        Select Data.Get("type")  
            Case Store.TYPE_ADDED  
                Dim Left As Boolean = False  
                If Params.Get("sender_id") == Key.get("uid") Then  
                    Left = True  
                End If  
                Chat1.AddItem(Params.Get("message"),Params.Get("sender"), Left)  
        End Select  
    End If  
End Sub  
  
Private Sub Firestore_DocumentChanged(Data As Map)  
        Select Data.Get("collection")  
            Case "delivery_requests"  
                Dim request As Map = Data.Get("data")  
                DeliveryRequest = request  
                GetRequestState(request.Get("status").As(Int))  
            Case "rider_coordinates"  
                Dim ride As Map = Data.Get("data")  
'                Dim geo As Map = ride.Get("geopoint")  
                CameraPosition.Initialize(ride.Get("latitude"),ride.Get("longitude"),Zoom)  
                If Marker.IsInitialized == False Then  
                    Marker = gmap.AddMarker3(ride.Get("latitude"),ride.Get("longitude"),"Rider",FontUtils.FontToBitmap(Chr(0xF21C),False,20,Colors.red))  
                End If  
                OreebaUtils.AnimateTo(Marker,2000,ride.Get("latitude"),ride.Get("longitude"),CameraPosition,gmap)  
        End Select  
End Sub
```

  
  

```B4X
PrescriptionFile = $"prescriptions/${UserID}/${Product.Get("id")}/${FileResult.RealName}"$  
Storage.UploadFile(FileResult.Dir,FileResult.FileName, $"/${PrescriptionFile}"$)  
Wait For (Storage) Storage_UploadCompleted (ServerPath As String, success As Boolean)  
Store.GetFileurl(PrescriptionFile)  
'Result: https://firebasestorage.googleapis.com/v0/b/project-id.appspot.com/o/prescriptions%2FDj0pOcizCDVqeZk8DssQCmSeXCr1%2FT3yw5j7jgocqFwIVWWQ3%2FIMG-20231022-WA0003.jpg?alt=media  
Fields.Put("photo_url",Store.GetFileurl(PrescriptionFile))  
Wait For (Store.UpdateDocument("users",DocumentID,Fields)) Complete(m As Map)
```

  
  
Inspired By: <https://www.b4x.com/android/forum/threads/firestore-api-rest-support.129551/> & <https://firebase.google.com/docs/firestore/reference/rest/v1>  
  
**HOSTING THE HTML**  
First you'll need to install [Firebase CLI](https://firebase.google.com/docs/cli?authuser=0#install_the_firebase_cli)  

1. Create a folder and open the folder in VS Code
2. In the terminal run **firebase init hosting**
3. When its done copy the **index.html** to the **public** folder
4. Edit the paste your firebase config
5. In the terminal run **firebase deploy –only hosting**
6. Check if it works by visiting **<https://PROJECT_ID.web.app/?collection=>[A collection here]** in a browser
7. View the browser console if you see logs as below of your collection then you're set to go

  
![](https://www.b4x.com/android/forum/attachments/149208)  
**Change Log**:  

- v2.12

- Forum release

- v2.52

- Queries, Collection & Documents can be stored for re-use
- ListenterRegistration updated to use Websockets instead of timer

- v3.00

- Websocket Removed due to constant disconnection
- Listener works by loading a webpage on your firebase hosting to read changes(See attached **hosting.zip**)
- See [Deploying Firebase Hosting](https://firebase.google.com/docs/hosting/quickstart?authuser=0)

- v3.01

- Listen to a collection by order in asc or desc (CollectionListen2)
- Disconnect/Stop listening fixed

- v3.03

- DeleteCollection fixed

- v3.06

- Bug fixes