### Firebase RealtimeDatabase B4A interaction with Inline Java code Part - 1 by jkhazraji
### 10/26/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/172376/)

To prepare b4a for interaction you should add the following:  

```B4X
#AdditionalJar: com.google.firebase:firebase-database  
#AdditionalJar: com.google.firebase:firebase-database-collection
```

  
at the top of the main module  
Integrate Firebase services in manifest:  

```B4X
CreateResourceFromFile(Macro, FirebaseAnalytics.GooglePlayBase)  
CreateResourceFromFile(Macro, FirebaseAnalytics.Firebase)
```

  
Define a Javaobject called (FBBridge)  

```B4X
Private fbBridge As JavaObject
```

  
Define the class in inline Java:  

```B4X
import com.google.firebase.database.*;  
…  
public static class FirebaseBridge {  
…  
}
```

  
First, we define FirebaseDatabase then DatabaseReference classes  

```B4X
private FirebaseDatabase database;  
private DatabaseReference roomsRef;
```

  
   
The constructor should define BA for Event raising:  
Our reference is called 'rooms'  

```B4X
public FirebaseBridge(B4AClass me) {  
        this.ba = me.getBA();   
        database = FirebaseDatabase.getInstance();  
        roomsRef = database.getReference("rooms");  
    }
```

  
Let's now start the listener:  

```B4X
public void startRoomListener() {  
        roomsRef.addValueEventListener(new ValueEventListener() {  
            @Override  
            public void onDataChange(DataSnapshot snapshot) {  
                try {  
                    Object value = snapshot.getValue();  
                    String json = value == null ? "{}" : new JSONObject((java.util.Map) value).toString();  
                    ba.raiseEventFromUI(FirebaseBridge.this, "onroomschanged", json);  
                } catch (Exception e) {  
                    BA.Log("JSON error: " + e.getMessage());  
                }  
            }  
  
            @Override  
            public void onCancelled(DatabaseError error) {  
                BA.Log("Firebase cancelled: " + error.getMessage());  
            }  
        });  
      
    }
```