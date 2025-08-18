B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
Sub Class_Globals
	Private NativeMe As JavaObject
End Sub

Public Sub Initialize
	NativeMe = Me
	NativeMe.RunMethod( "initialaudio", Null)
End Sub

Public Sub StartAudioPlayer
	NativeMe.RunMethod( "startaudio", Null)
End Sub

Public Sub StopAudioPlayer
	NativeMe.RunMethod( "stopaudio", Null)
End Sub

Public Sub SendDataPlayer (data() As Byte)
	NativeMe.RunMethod( "playaudio", Array(data,data.Length))
End Sub


#IF JAVA
import javax.sound.sampled.*;

	SourceDataLine _speaker;

    public void initialaudio() throws LineUnavailableException{
        //  specifying the audio format
        AudioFormat _format = new AudioFormat(44100.F,// Sample Rate
                16,     // Size of SampleBits
                1,      // Number of Channels
                true,   // Is Signed?
                true   // Is Big Endian?
        );

        //  creating the DataLine Info For the speaker format
        DataLine.Info speakerInfo = new DataLine.Info(SourceDataLine.class, _format);

        //  getting the mixer For the speaker
        _speaker = (SourceDataLine) AudioSystem.getLine(speakerInfo);
        _speaker.open(_format, 44100);
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