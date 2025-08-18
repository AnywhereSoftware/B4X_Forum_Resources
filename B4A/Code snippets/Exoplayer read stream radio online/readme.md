### Exoplayer read stream radio online by musaso
### 05/09/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/130559/)

Sorry for the translation (google translate).:)  
Thanks to [Erel](https://www.b4x.com/android/forum/members/erel.1/) for his new version of [Exoplayer 1.50](https://www.b4x.com/android/forum/threads/exoplayer-mediaplayer-videoview-alternative.72652/#content), without which it would not be possible to do so.  
  
After much testing I have found a way to read the song title directly from the exoplayer stream (IcyInfo).  
Surely the code can be improved since Java is rather fair. But it works for me correctly in my radio app.   
The Java class is copied from the internet and adjusted by me.  
  
Java class:  
  
It has 3 functions:  
- Function to name the event to send the data.  
- Function to send the data (in the same page of the java class).  
- Function that ExoPlayer assigns and receives metadata.  
  

```B4X
#if java  
  
import anywheresoftware.b4a.keywords.Common;       
import java.io.IOException;  
import java.util.List;  
import java.util.Map;  
  
import com.google.android.exoplayer2.metadata.icy.IcyInfo;  
import com.google.android.exoplayer2.metadata.icy.IcyHeaders;  
import com.google.android.exoplayer2.metadata.Metadata;  
import com.google.android.exoplayer2.metadata.MetadataOutput;  
import com.google.android.exoplayer2.SimpleExoPlayer;  
import android.content.Context;  
  
public static class IcyInfoMetaData {  
    private Map<String, List<String>> headers;  
    public SimpleExoPlayer ExoPlayer;  
    public String NombreEvento;  
    public String Titulo;  
      
    // Poner nombre al evento que devuelve titulo  
    public void PonerNombreEvento(String EventName) throws IOException {  
           NombreEvento = EventName;  
    }  
      
    // Enviar titulo a B4A en mi caso Sub CancionCambiada_Fire(Value As String) en pagina Main  
    public void NotificarTituloCambiado(String txt) throws IOException {  
           processBA.raiseEventFromUI(this, NombreEvento.toLowerCase(BA.cul) + "_fire", txt);  
    }  
      
    // Asignar ExoPlayer y recoger metadata  
    public void AsignarExoPlayer(SimpleExoPlayer Exo) throws IOException {  
        SimpleExoPlayer ExoPlayer = Exo;  
        ExoPlayer.addMetadataOutput(new MetadataOutput() {  
              
            public void onMetadata(Metadata metadata) {  
                for (int i = 0; i < metadata.length(); i++) {  
                    Metadata.Entry entry = metadata.get(i);  
                      
                    //Aqui se leen titulo y url  
                    if (entry instanceof IcyInfo){  
                        IcyInfo icyInfo = ((IcyInfo) entry);  
                        BA.Log("Titulo = " + icyInfo.title);  
                        BA.Log("Url = " + icyInfo.url);                         
                        try {  
                            NotificarTituloCambiado(icyInfo.title);//devolver titulo a B4A  
                        } catch(Exception e) {  
                            BA.Log("ERROR");  
                        }//catch                         
                    }//IcyInfo  
                      
                    //Esta parte no se ejecuta nunca  
                    if (entry instanceof IcyHeaders) {  
                            IcyHeaders icyHeaders = ((IcyHeaders) entry);  
                            BA.Log("IcyHeaders nombre " + icyHeaders.name);  
                            BA.Log("IcyHeaders genero " + icyHeaders.genre);  
                    }//IcyHeaders  
                                          
                }//for  
                  
            }//onmetadata  
              
        });//addMetadataOutput  
          
    }//AsignarExoPlayer  
      
      
}//class IcyInfoMetaData  
  
#End If
```

  
  
In B4X code :  
  

```B4X
    Public streamMeta As JavaObject'global variable  
    Dim jo As JavaObject  
    'Initialize the class  
    streamMeta = jo.InitializeNewInstance(Application.PackageName & ".main$IcyInfoMetaData", Null)  
    'name the event  
    streamMeta.RunMethod("PonerNombreEvento",Array As String("CancionCambiada"))  
          
    Exo1.Initialize("mp1")'Initialize ExoPlayer  
    Dim jo As JavaObject = Exo1  
    'assign exoplayer after nitialize  
    streamMeta.RunMethod("AsignarExoPlayer",Array As Object(jo.GetField("player")))  
      
    'Sub that receives the data (in the same page of the java class).  
    Sub CancionCambiada_Fire(Value As String)  
        Log($"Titulo = ${Value}"$)  
        if Value="" Then Value = "Sin informacion"  
        LabelTitle.Text = Value  
    End Sub
```