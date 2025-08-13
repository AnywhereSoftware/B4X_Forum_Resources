### FirebaseAdmin Library by Claude Obiri Amadu
### 10/11/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/155115/)

I learnt Java in the past few months to build this library to get real-time updates from Firestore.  
The Library has 5 classes:  

- **Firebase**
- **Firestore**
- **ListenerRegistration**
- **Query**
- **Filter**
- Except **RealtimeDatabase** (Coming soon)

firebase-adminsdk.json(Service account file) from your Firebase console in Files/Assets  
*I had wanted it to be in the project folder like google-services.jon but couldn't figure how*  
  
In Sub Globals  

```B4X
Dim Firestore As Firestore  
Public Firebase As  Firebase  
Dim Listener As ListenerRegistration
```

  
  
In Activity\_Create  

```B4X
Firebase.Initialize("Firebase","projectId")
```

  
  
An event is triggered when Firebase is Initialized which returns true or false where we can now Initialize Firestore  
  

```B4X
Private Sub Firebase_Ready(Success As Boolean)  
    If Success Then  
        Firestore.Initialize("Firestore",Firebase.GetFirebase,"(default)")  
    End If  
End Sub
```

  
  
Example Use:  
**Listen to changes in a collection or Document**  

```B4X
Firestore.CollectionListen("products") 'Fetches the collection and its changes in real-time
```

  

```B4X
Firestore.DocumentListen("products","documentID")
```

  

```B4X
Private Sub Firestore_CollectionChanged(Data As Map)'Workds  
    Log("Collection changed: " & Data)  
    If Data.IsInitialized Then  
        Dim Params As Map = Data.Get("data")  
        Log(Data.Get("type"))  
        Select Data.Get("type")  
            Case Firestore.TYPE_ADDED  
                ListView1.Add(AddPane(Params),Data.Get("id"))  
            Case Firestore.TYPE_MODIFIED  
                For i = 0 To ListView1.Size-1  
                    Dim ID As String = ListView1.GetValue(i)  
                    If ID == Data.Get("id") Then  
                        Log($"Modifying: ${Data.Get("id")}"$)  
                        ListView1.ReplaceAt(i,AddPane(Params),50dip,Data.Get("id"))  
                        Return  
                    End If  
                Next  
            Case Firestore.TYPE_REMOVED  
                For i = 0 To ListView1.Size-1  
                    Dim ID As String = ListView1.GetValue(i)  
                    If ID == Data.Get("id") Then  
                        ListView1.RemoveAt(i)  
                        Return  
                    End If  
                Next  
        End Select  
    End If  
End Sub
```

  
**Get, Update** or **Delete Document**  

```B4X
Dim map As Map  
map.Initialize  
map.Put("name","name_new")  
map.Put("number",1234)  
Dim list As List  
list.Initialize  
list.Add("item"&Rnd(10,100))  
list.Add("item3")  
map.Put("list",list)  
Firestore.UpdateDocument("products","documentID",map)  
Firestore.CreateDocument("products","",map)'Document ID can be empty  
Firestore.DeleteDocument("products","documentID")
```

  
**Remove Listener**  

```B4X
Listener.Get(Firestore.CollectionListen("products"))'Must be called before removing  
  
If Firestore.IsInitialized Then  
    Listener.Remove  
    Log("removed")  
End If
```

  
  
**Query & Filter**  

```B4X
Dim query As Query  
query.Initialize(Firestore.GetFirestore,"products").Limit(1).OrderBy("name").Get
```

  

```B4X
Dim query As Query  
Dim filter As Filter  
filter.EqualTo("name","yes").GreaterThanOrEqualTo("number",10)  
query.Initialize(Firestore.GetFirestore,"products").Where(filter).OrderBy("name").Get
```

  
  
  
**Demo:**  
[MEDIA=youtube]k8msufsdvTA[/MEDIA]  
  
*Note: This is new not advisable to use in projects yet and will conflict with existing firebase libraries  
Will work on resolving that*  
I will work towards a B4X Library too if this is good ?  
  
**Version: 1.09:**  

```B4X
Dim Path As PathBuilder  
Path.Initialize.Append("users").Append("chats").Append("messages")  
Log(Path.Complete)
```

  

```B4X
Firebase.Initialize("Firebase","fir-*****")  
Firestore.Initialize("Firestore","(default)") OR Firestore.Initialize("Firestore","")
```

  
  

```B4X
Firebase.Initialize2("Firebase","fir-*****","https://fir-*****-rtdb.firebaseio.com",False)  
Realtime.Initialize("Realtime")  
Realtime.Child("users").SetValue("Claude Amadu")
```

  
  
Chat App Demo:  
[MEDIA=youtube]rGEzFax34fs[/MEDIA]