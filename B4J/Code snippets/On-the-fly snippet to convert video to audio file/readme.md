### On-the-fly snippet to convert video to audio file by jkhazraji
### 09/07/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/150582/)

Put the video file to be converted in the Objects folder of the app  
  

```B4X
'Non-UI application (console / server application)  
#Region Project Attributes  
    #CommandLineArgs:  
    #MergeLibraries: True  
#End Region  
  
#AdditionalJar: jave/jave-core-3.3.1  
#AdditionalJar: jave/jave-nativebin-win64-3.3.1  
#AdditionalJar: jave/slf4j-api-2.0.0  
#AdditionalJar: jave/slf4j-nop-2.0.0  
Sub Process_Globals  
      
End Sub  
  
Sub AppStart (Args() As String)  
    Log("Converting…")  
  
    Dim videoFile As String=File.Combine(File.DirApp,"InputVideo.mp4")  
    Dim audioFile As String=File.Combine(File.DirApp,"outputAudio.mp3")  
      
    Log($" Video converted: ${(Me).As(JavaObject).RunMethod("convertV2A",Array As String(videoFile,audioFile))}"$)  
    StartMessageLoop  
End Sub  
  
#if java  
import java.io.*;  
import ws.schild.jave.encode.AudioAttributes;  
import ws.schild.jave.encode.EncodingAttributes;  
import ws.schild.jave.Encoder;  
import ws.schild.jave.MultimediaObject;  
import ws.schild.jave.info.MultimediaInfo;  
  
   
  static public boolean convertV2A(String vFile, String aFile){   
        boolean succeeded=false;   
        try {                                                           
         File source = new File(vFile);                           
         File target = new File(aFile);                           
                                                                        
         //Audio Attributes                                         
         AudioAttributes audio = new AudioAttributes();               
         audio.setCodec("libmp3lame");                                 
         audio.setBitRate(128000);                                     
         audio.setChannels(2);                                         
         audio.setSamplingRate(44100);                                 
                                                                      
         //Encoding attributes                                         
         EncodingAttributes attrs = new EncodingAttributes();         
         attrs.setOutputFormat("mp3");                                       
         attrs.setAudioAttributes(audio);                             
                                                                      
         //Encode                                                     
         Encoder encoder = new Encoder();             
         encoder.encode(new MultimediaObject(source), target, attrs);  
         succeeded = true;                                                                 
        } catch (Exception ex) {                                       
         ex.printStackTrace();                                         
         succeeded = false;             
      
    }  
    return succeeded;  
    }  
      
#End If
```

  
  
See: <https://github.com/a-schild/jave2/tree/master#converting-any-audio-to-mp3>