### XSpeechRecognizer Android 11+ (Fix isRecognitionAvailable always false) by Mike1970
### 02/18/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/138561/)

Hi everyone, i came across for the first time in a problem related to Android 11+  
I'm using the XSpeechRecognizer library to detect words from the user to text. On my phone (Android 9) is ok, but on another was always failing the "isRecognitionAvailable()" test.  
  
thanks to [this post](https://www.b4x.com/android/forum/threads/question-about-library-speechtotext.133700/#post-845313) i solved by adding the following code to the manifest.  
  
  

```B4X
AddManifestText(  
<queries>  
  <intent>  
    <action android:name="android.intent.action.TTS_SERVICE" />  
  </intent>  
  <intent>  
    <action android:name="android.speech.RecognitionService" />  
  </intent>  
</queries>  
)
```