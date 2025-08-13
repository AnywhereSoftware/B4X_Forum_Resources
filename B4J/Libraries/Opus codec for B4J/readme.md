### Opus codec for B4J by Gandalf
### 11/10/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/157327/)

Tested on Windows 10 and Linux Mint 21 with JDK 11. Should work with later JDK version hopefully.  
  
1. Download file [opus-jni-java-1.0.3.jar](https://github.com/LabyMod/opus-jni/releases/download/1.0.3/opus-jni-java-1.0.3.jar) from GitHub to your B4J Additional Libraries folder.  
2. Open this file as ZIP archive and extract from "native-binaries" subfolder appropriate file(s) for your operating system(s) to a directory of your choice. Here File.DirApp will be used.  
3. Add to Region Project Attributes:  

```B4X
#AdditionalJar: opus-jni-java-1.0.3
```

  
4. Make sure that JavaObject library is included in your project.  
5. Add the following text to the module where you want to use Opus codec:  

```B4X
#if JAVA  
import net.labymod.opus.OpusCodec;  
import net.labymod.opus.OpusCodecOptions;  
import java.io.File;  
public static Object CreateCodec() {  
    OpusCodec codec = OpusCodec.newBuilder()  
        .withSampleRate(16000)  
        .withChannels(1)  
        .withBitrate(16000)  
        .withFrameSize(160)  
        .withMaxFrameSize(960)  
        .withMaxPacketSize(3828)  
      .build();  
    return codec;  
}  
public static void LoadNativeLib(String dirName, String fileName) {  
    System.load(new File(dirName, fileName).getAbsolutePath());  
}  
#end if
```

  
6. Adjust codec settings in the code above as you require. These settings must match audio system configuration in your project (mic and speaker). See [Opus codec documentation](https://wiki.xiph.org/Opus_Recommended_Settings).  
7. Create codec object in Process\_Globals:  

```B4X
Private Codec As JavaObject
```

  
8. Before using codec you need to load native library and execute CreateCodec method (in AppStart for example):  

```B4X
Dim jo As JavaObject = Me  
jo.RunMethod("LoadNativeLib", Array As Object(File.DirApp, "opus-jni-native-64.dll"))    'For Windows  
Codec = jo.RunMethod("CreateCodec", Null)
```

  
Instead of hardcoding native library filename you may use this sub:  

```B4X
Sub NativeLibName As String  
    Dim osname As String = GetSystemProperty("os.name","-unknown").ToLowerCase  
    Log("Running on " & osname)  
    If osname.Contains("nux") Or osname.Contains("nix") Then  
        Return "libopus-jni-native-64.so"  
    else if osname.Contains("windows") Then  
        Return "opus-jni-native-64.dll"  
    else if osname.Contains("mac") Then  
        Return "libopus-jni-native-64.dylib"  
    Else  
        Log("Unknown system !!!")  
        Return ""  
    End If  
End Sub
```

  
9. Encode and decode your data. Input data size must be FrameSize \* 2. Echo example (using jAudioRecord2):  

```B4X
Do While EchoOn  
    Dim recData(320) As Byte    'For FrameSize 160  
    Microphone.Read(recData, 0, recData.Length)  
    Dim encData() As Byte = Codec.RunMethod("encodeFrame", Array As Object(recData))    'Encoding  
    Dim decData() As Byte = Codec.RunMethod("decodeFrame", Array As Object(encData))    'Decoding  
    Speaker.Write(decData, 0, decData.Length)  
    Sleep(0)    'For UI to be responsive  
Loop
```