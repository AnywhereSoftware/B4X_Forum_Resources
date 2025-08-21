B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
Sub Class_Globals
	Private nativeMe As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

	nativeMe = Me
	nativeMe.RunMethod( "initialaudio", Null)
End Sub

Public Sub StartAudioPlayer
	nativeMe.RunMethod( "startaudio", Null)
End Sub

Public Sub StopAudioPlayer
	nativeMe.RunMethod( "stopaudio", Null)
End Sub

Public Sub SendDataPlayer (data() As Byte)
	nativeMe.RunMethod( "playaudio", Array(data,data.Length))
End Sub

#IF JAVA
import javax.sound.sampled.*;

	SourceDataLine _speaker;

    public void initialaudio() throws LineUnavailableException{
        //  specifying the audio format
        AudioFormat _format = new AudioFormat(22050.F,// Sample Rate
                16,     // Size of SampleBits
                1,      // Number of Channels
                true,   // Is Signed?
                false   // Is Big Endian?
        );

        //  creating the DataLine Info For the speaker format
        DataLine.Info speakerInfo = new DataLine.Info(SourceDataLine.class, _format);

        //  getting the mixer For the speaker
        _speaker = (SourceDataLine) AudioSystem.getLine(speakerInfo);
        _speaker.open(_format);
    }

    public void startaudio() {
        try {
            _speaker.start();
        } catch (Exception e) {
            e.printStackTrace();
        }
		
    }		
    public void playaudio(byte[] data, int readCount) {
        try {
			if(readCount > 0){
                    _speaker.write(data, 0, readCount);
             }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
		
	public void stopaudio() {
        try {
            _speaker.drain();
            _speaker.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


#End If