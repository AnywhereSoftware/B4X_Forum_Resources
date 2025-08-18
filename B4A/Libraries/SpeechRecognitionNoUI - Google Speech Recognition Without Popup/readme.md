### SpeechRecognitionNoUI - Google Speech Recognition Without Popup by Biswajit
### 10/06/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/117640/)

**A better alternative for offline recognition is available [here](https://www.b4x.com/android/forum/threads/speechtotext-continuous-offline-voice-recognition.134857/).**  
  
With this, you can add speech recognition feature to your application without google speech recognition popup (check attached example),  
  
**SpeechRecognitionNoUI  
  
Author:** [USER=100215]@Biswajit[/USER]  
**Version:** 1.6  

- **SpeechRecognitionNoUI**

- **Events:**

- **ReadyForSpeech**
*Called when the endpointer is ready for the user to start speaking.*- **BeginningOfSpeech**
*The user has started to speak.*- **EndOfSpeech**
*The user stops speaking.*- **Error** (Msg As String)
*A network or recognition error occurred.*- **PartialResults** (Texts As List)
*Partial recognition results are available.*- **Results** (Texts As List)
*Recognition results are ready.*- **RmsChanged** (RmsValue As Int)
*The sound level in the audio stream has changed. There is no guarantee that this method will be called.*- **BufferReceived**(buffer() As Byte)
*The purpose of this function is to allow giving feedback to the user regarding the captured audio. There is no guarantee that this method will be called.*
- **Functions:**

- **NoRecognizerBeep** As Boolean
*Set true if you dont want beep sound before and after speech recognition.  
 Starting from Android 7+ this method will throw an exception if the user set the Do Not Disturb mode,  
 unless your app has requested a special permission with NOTIFICATION\_POLICY\_ACCESS\_SETTINGS.  
 (Check example)*- **Initialize** (eventname As String, callback As Object) As Boolean
- **IsInitialized** As Boolean
- **IsRecognitionAvailable** As Boolean
*Check if Speech Recognition is available or not*- **StartListening** (LANGUAGE As String, PARTIAL\_RESULTS As Boolean, PREFER\_OFFLINE As Boolean) As String
*Start listening.  
 LANGUAGE : Recognition language. IETF language tag (as defined by BCP 47), for example "en-US"  
 PARTIAL\_RESULTS : indicate whether partial results should be returned by the recognizer as the user speaks.  
 PREFER\_OFFLINE : indicate whether to only use an offline speech recognition engine. If false then either network or offline recognition engines may be used*- **StopListening** As String

  
[Here](https://www.b4x.com/android/forum/threads/android-speech-recognition-api-wrapper.62959/#content) is the original thread. I took some ideas and codes to build this library.  
  
**Note:** Remember to **INTERNET**, **RECORD\_AUDIO** and **NOTIFICATION\_POLICY\_ACCESS\_SETTINGS** permission.  
**For SDK v30:** Add this following code to your project manifest.  

```B4X
AddManifestText(  
<queries>  
    <intent>  
        <action android:name="android.speech.RecognitionService" />  
    </intent>  
</queries>)
```

  
  
**Update 1.1:** Added NoRecognizerBeep option. Set true if you don't want beep sound before and after speech recognition.  
**Update 1.2:**  

1. Added ReadyForSpeech event.
2. Fixed recognition language problem

**Update 1.3:** Fixed crashing issue in DND mode.  
**Update 1.4:** Added proper error handling and warning message for DND mode. (Check the example)  
**Update 1.5:** Added BufferReceived event.  
**Update 1.6:** Fixed an issue with the offline voice recognition.