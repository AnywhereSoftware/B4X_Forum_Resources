### B4J Text-to-Speech snippet by jkhazraji
### 08/28/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/149858/)

Hi everyone,  
Here is a newbie ? b4jcode of text-to-speech using freetts:  
Find the video demo   
[MEDIA=youtube]lQkyoROshG4[/MEDIA]  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
#AdditionalJar:.\freetts\cmudict04.jar  
'.  
'.  
'.  
  
#AdditionalJar: .\freetts\jsapi.jar  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Button1 As B4XView  
    Private TextArea1 As TextArea  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
      
      
End Sub  
  
Sub Button1_Click  
    Dim jo As JavaObject = Me  
    Dim textToSpeak As String=TextArea1.Text  
    jo.RunMethod("tts",Array As String(textToSpeak))  
      
End Sub  
  
#if JAVA  
    import java.io.File;  
    import java.io.FileInputStream;  
    import java.io.InputStream;  
    import com.sun.speech.freetts.Voice;  
    import com.sun.speech.freetts.VoiceManager;  
    import com.sun.speech.freetts.audio.SingleFileAudioPlayer;  
    import javax.sound.sampled.AudioFileFormat.Type;  
  
  private static final String voiceName ="kevin16";  
   
  public static void tts(String anystring)  
  {  
        
    VoiceManager voiceManager = null;  
    Voice voice = null;  
    voiceManager = VoiceManager.getInstance();  
    voice = voiceManager.getVoice(voiceName);  
    voice.allocate();  
      
    try  
    {  
       voice.speak(anystring);  
       voice.deallocate();  
      
    }  
      
    catch(Exception e)  
    {  
        String message = " missing speech.properties in " + System.getProperty("user.home") + "\n";  
        System.out.println(""+e);  
        System.out.println(message);  
        e.printStackTrace();  
  
    }  
        
  }  
#End If
```