### Play short sound clip using inline java by jkhazraji
### 08/18/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/133543/)

Here is a code to play sounds by frequency and duration using inline java .. A stream of sounds can be played in queue to compose a short sound clip as I demonstrate here, with the 'Happy Birthday tune.  
I hope it is of use.  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Button1 As B4XView  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
      
End Sub  
Private Sub playSound(hz As Int,dur As Int)  
    Dim MyJO As JavaObject = Me  
    MyJO.RunMethod("tonePlay",Array(hz,dur,0.5))  
    Log($"playing ${hz} for ${dur} milliseconds"$)  
  
End Sub  
Sub Button1_Click  
Dim freq() As Int= Array As Int(262,262,294,262,349,330,262,262,294,262,392, _  
                                  349,262,262,524,440,349,330,294,466,466,440, _  
                                  349,392,349)  
 Dim dur() As Int= Array As Int(1000,1000,2000,2000,2000,3000,1000,1000,2000, _  
                                2000,2000,3000,1000,1000,2000,2000,2000,2000, _  
                                2000,1000,1000,2000,2000,2000,3000)  
   
 For n=0 To 24  
   playSound(freq(n),dur(n)/4)           
 Next  
End Sub  
#If java  
import javax.sound.sampled.*;  
public static float SAMPLE_RATE = 8000f;  
  
public static void tonePlay(int hz, int msecs, double vol)  
     throws LineUnavailableException  
  {  
     tone(hz, msecs, vol);  
  }  
  
public static void tone(int hz, int msecs, double vol)  
      throws LineUnavailableException  
  {  
    byte[] buf = new byte[1];  
    AudioFormat af =  
        new AudioFormat(  
            SAMPLE_RATE, // sampleRate  
            8,           // sampleSizeInBits  
            1,           // channels  
            true,        // signed  
            false);      // bigEndian  
    SourceDataLine sdl = AudioSystem.getSourceDataLine(af);  
    sdl.open(af);  
    sdl.start();  
    for (int i=0; i < msecs*8; i++) {  
      double angle = i / (SAMPLE_RATE / hz) * 2.0 * Math.PI;  
      buf[0] = (byte)(Math.sin(angle) * 127.0 * vol);  
      sdl.write(buf,0,1);  
    }  
    sdl.drain();  
    sdl.stop();  
}  
#End If
```