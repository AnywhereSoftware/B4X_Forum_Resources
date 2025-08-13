### SpeechToText - Continuous Offline Voice Recognition by Biswajit
### 09/27/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/134857/)

This is a wrapper of [Acephei VOSK](https://alphacephei.com/vosk/) , With this, you can add **continuous offline speech recognition** feature to your application,  
  
**NOTE:**  

1. As it works offline the app should be complied with the voice model. It will increase the app size by 30-40Mb.
2. The accuracy depends on the voice model. You can train your own voice model. For more details check the models download link below.
3. Remember to add **RECORD\_AUDIO** permission.

**How to use:**  

1. Download the required voice model from [here](https://alphacephei.com/vosk/models).
2. Change the file name to a simple one like "model.zip"
3. Copy it to the **Files** folder of your project.
4. Now to use that model check the attached example.

  
**SpeechToText  
  
Author:** [USER=100215]@Biswajit[/USER]  
**Version:** 1.5  

- **SpeechToText**

- **Events:**

- **Error** (message As String)
- **FinalResult** (text As String)
- **MicrophoneBuffer** (buffer() As Byte)
- **PartialResult** (text As String)
- **Paused** (paused As Boolean)
- **ReadyToListen**
- **ReadyToListenEx [SIZE=2]**new**[/SIZE]**
- **ReadyToRead**
- **Restarted**
- **Result** (text As String)

- **Fields:**

- **sampleRate** As Int
*Default 16000*
- **Functions:**

- **cancel** As Boolean
*Cancel microphone recognition. Do not post any new events, simply cancel processing.  
 Does nothing if recognition is not active.  
 Return type: @return:true if recognition was actually stopped*- **FeedExternalBuffer** (ExBuffer As Byte()) [SIZE=2]**new**[/SIZE]
*For recognizing the external audio buffer, feed the buffer here.  
 ExBuffer: The external audio byte buffer.*- **Initialize** (eventName As String, modelPath As String)
*Initialize the object.  
 eventName: The event name prefix.  
 modelPath: The model folder path.*- **pause** (pause As Boolean)
*Pause microphone recognition.  
 pause: Pass true to pause and false to continue.*- **prepareAudioFile** (audioPath As String, predefinedWords As String)
*Prepare the audio file for recognition. On success Eventname\_ReadyToRead event will be raised.  
 Call startReading to start reading the file.  
 audioPath: Audio file path.  
 predefinedWords: Add some predefined words/phrase as JSON string. Can be blank.*- **prepareListenerEx** (predefinedWords As String) [SIZE=2]**new**[/SIZE]
*Prepare the listener for external audio buffer. On success Eventname\_ReadyToListenEx event will be raised.  
 Call startListeningEx to start listening.  
 predefinedWords: Add some predefined words/phrase as JSON string. Can be blank.*- **prepareMicrophone** (predefinedWords As String)
*Prepare the microphone for listening. On success Eventname\_ReadyToListen event will be raised.  
 Call startListening to start listening.  
 predefinedWords: Add some predefined words/phrase as JSON string. Can be blank.*- **reset**
*Resets microphone recognizer in a thread, starts microphone recognition over again*- **shutdown**
*Shutdown the microphone recognizer and release the recorder.  
 Call this on activity or service closing event.*- **startListening** (timeout As Int) As Boolean
*Starts microphone recognition. After specified timeout listening stops and the  
 endOfSpeech signals about that. Does nothing if recognition is active.  
 timeout: timeout in milliseconds to listen. -1 = infinite;  
 Return type: @return:true if recognition was actually started*- **startListeningEx** As Boolean [SIZE=2]**new**[/SIZE]
*Starts external audio buffer recognition.  
 Return type: @return:true if recognition was actually started*- **startReading** (timeout As Int) As Boolean
*Starts file recognition. After specified timeout listening stops and the  
 endOfSpeech signals about that. Does nothing if recognition is active.  
 timeout: timeout in milliseconds to listen. -1 = infinite;  
 Return type: @return:true if recognition was actually started*- **stop** As Boolean
*Stops microphone/file recognition. Listener should receive final result if there is  
 any. Does nothing if recognition is not active.  
 Call this on activity or service closing event.  
 Return type: @return:true if recognition was actually stopped*
**Downloads:**  

1. [**Library**](https://drive.google.com/file/d/1x-LE3BgCiy7Bs0AL_BrHtHhVHsoUNAfK/view)
2. [**Example**](https://drive.google.com/file/d/1xA8pKZ7rotUQk5KiYSjCaLkDT8tDPtEX/view?usp=sharing)
3. [**Voice Model**](https://alphacephei.com/vosk/models)
4. [**Test app**](https://drive.google.com/file/d/12gZ5RXeA70SU08Ggc8oaO9vehVF9ltFY/view?usp=sharing)

**Update:**  

- **Version 1.1:**

1. Added audio file to text functionality. (For now only WAV format is supported)
2. Added predefined word/phrase detection functionality.
3. Merged **startListening** and **startListening2** together. Pass -1 for continuous recognition.

- **Version 1.2:**

1. Added **MicrophoneBuffer** event where you will receive the microphone audio buffer while using voice recognition.

- **Version 1.3:**

1. Added method to change the sampling rate.

- **Version 1.4:**

1. Fixed the app crashing issue while calling shutdown without stating the recognizer

- **Version 1.5:**

1. Added option to feed external audio buffer. Instead of using the internal audio recorder you can feed external audio buffer from another audio source.
(C*heck the latest example project*)2. Updated VOSK and JNA library. (*Please delete old dependencies before coping the new ones.)*

  
**If you like my work, please donate. Your donations will encourage me to add more features in the future.  
  
[![](https://www.paypalobjects.com/en_US/GB/i/btn/btn_donateCC_LG.gif)](https://www.paypal.me/thebsk)**