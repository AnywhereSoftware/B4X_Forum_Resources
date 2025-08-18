### FirebaseRealtimeDatabase create Listener by musaso
### 06/17/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/141270/)

(Google translate)  
Create listener to receive data from FirebaseRealtimeDatabase every time it changes.  
  
  

```B4X
'en pagina Main  
  
Sub DatosRecibidos_Fire(Value As String)'recibe un string en formato json  
    Dim parser As JSONParser  
    parser.Initialize(Value)  
    Dim RootFB As Map = parser.NextObject  
    If RootFB = Null Or RootFB.IsInitialized = False Then  
        'error  
    Else  
        'RootFB    ………..     
    End If         
End Sub  
  
  
#If Java  
  
import com.google.firebase.database.DatabaseReference;   
import com.google.firebase.database.FirebaseDatabase;  
import com.google.firebase.database.DataSnapshot;  
import com.google.firebase.database.DatabaseError;  
import com.google.firebase.database.ValueEventListener;  
  
import anywheresoftware.b4a.keywords.B4AApplication;  
import android.content.pm.PackageManager.NameNotFoundException;  
  
  
public static class MyFirebaseListener {  
  
private String NombreEvento = "DatosRecibidos";//nombre del evento que recibira los datos en pagina Main (OJO NO en B4XPages.MainPage)  
      
    // Enviar datos a B4A en mi caso Sub DatosRecibidos_Fire(Value As String) en pagina Main  
    public void NotificarDatosCambiados(String txt) throws IOException {  
           processBA.raiseEventFromUI(this, NombreEvento.toLowerCase(BA.cul) + "_fire", txt);//evento DatosRecibidos_Fire en pagina Main  
    }  
  
    FirebaseDatabase database = FirebaseDatabase.getInstance("https://tureferencia-xxxx.firebaseio.com/");//aqui tu referencia de RealtimeDatabase  
    DatabaseReference myRef = FirebaseDatabase.getInstance().getReference();//en este caso leo todos los datos (puedes leer el nodo que quieras)  
  
  
     public void IniciarListener() throws IOException {  
      myRef.addValueEventListener(new ValueEventListener() {  
      @Override  
      public void onDataChange(DataSnapshot dataSnapshot) {  
        //String name = dataSnapshot.toString();//leer como string  
        //BA.Log(name);//           
        try {  
            Map<String, Object> td = (HashMap<String, Object>) dataSnapshot.getValue();//leer datos  
            NotificarDatosCambiados(td.toString());//devolver datos a B4A  
            } catch(Exception e) {  
                BA.Log("ERROR");  
            }//catch         
      }//onDataChange  
  
      @Override  
      public void onCancelled(DatabaseError databaseError) {  
        BA.Log("Error al leer: " + databaseError.getCode());  
        }  
    });//myRef.addValueEventListener             
     }//IniciarListener()  
}//MyFirebaseListener  
  
#End If  
'———————————————————————————  
  
en B4XPages.MainPage  
  
'despues de haberte logeado en Firebase inicializar Listener  
Sub IniciarFirebase  
    Dim streamMeta, jo As JavaObject  
    streamMeta = jo.InitializeNewInstance(Application.PackageName & ".main$MyFirebaseListener", Null)  
    streamMeta.RunMethod("IniciarListener",Null)  
End Sub  
  
'I am not very expert in Java, if someone can improve it …… welcome.
```