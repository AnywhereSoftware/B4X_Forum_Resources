### TTSFunctions by hatzisn
### 08/23/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/94306/)

Hi everyone,  
  
I gathered in a Codefile a lot of the code about TTS that goes around in the Forum and I added to it some code and changed it a bit to fit my needs. I created this Codefile with a bunch of Subs and Functions that would be useful (I believe) to all of you. So here is it…  
  
(23/8/2023)  
\*Changed the SynthesizeToFile sub to adapt the changes in the newer androids (\* the zip file with the example has not been changed so please do replace the TTSFunction code module)  
  
(1/3/2019)  
\* Changed the GetListOfAvailableLanguages function which now accepts the TTS package and returns the available language of the given TTS or accepts just "" for the default TTS.  
\* Added SpeakLongText function which speaks text without limit in length  
\* Added StopSpeakingLongText function to make the Speaking of a Long Text Stop  
\* Added SetVoice function which sets one of the voices you have got as a return from the function GetVoices. See the example of usage in the zip file  
\* Added GetVoices function which returns all the voices available in the TTS or just the voices of the given locale if we set the OnlyCurrentLocale boolean to true. See the example of usage in the zip file  
\* Added GetTTSCurrentLocale function which returns the current locale set to the TTS  
(28-10-2018)  
\* Added the GetListOfAvailableLanguages function which gets the available locales in the TTS engine…  
(27-6-2018)  
\* Added the StartTextToSpeechSettings function to show the text to speech settings to the user  
\* Changed the SetEngineByPackage to return a TTS object {now it is called as tts = SetEngineByPackage(ttspackage, tts) }  
  
Thanks to the excellent [Martin Pearman's tool](http://b4a.martinpearman.co.uk/xml2bb/), here is my code module's current version documentation:  
  
**TTSFunctions**  
Code module  
Subs in this code module will be accessible from all modules.  

- **GetTTSNamesAndPackages** (t As TTS) **As List**
Get the names, packages and default state (if the tts is default) of the TTSs
Uses TTS Lib, Reflection Lib, Phone Lib- **SetEngineByPackage** (sPackage As String, t As TTS) **As TTS**
Set TTS engine by packagename
Uses Reflection Lib, TTS Lib
Returns a TTS object- **StartTextToSpeechSettings**
Open the Text to speech engine settings to set what you want- **IsTTSSpeaking** (t As TTS) **As Boolean**
Check if TTS is speaking
Uses JavaObject Lib, TTS Lib- **GetDefaultEngine** (t As TTS) **As String**
Get Default Engine of TTS
Uses JavaObject Lib, TTS Lib- **GetMaxInputLength** (t As TTS) **As Long**
Get max input length of TTS
Uses JavaObject Lib, TTS Lib- **SynthesizeToFile** (t As TTS, subFolderToPutTheFile As String, filename As String, textToSpeak As String)
TTS - synthesize to file
Uses JavaObject Lib, TTS Lib, RuntimePermissions Lib- **PlaySynthesizedFile** (subFolderWhereTheFileIsLocated As String, fileName As String)
Play synthesized File From TTS
Uses RuntimePermissions Lib- **GetListOfAvailableLanguages** (sPackage As String) **As ResumableSub**
Get all available languages of the TTS
Uses Reflection Lib, JavaObject Lib
———————————————————————————
Requires API 21 (Android 5.0) and above
It is called like this:
Wait For (TTSFunctions.GetListOfAvailableLanguages(package or "")) Complete (sLangs As String)
manipulate the sLangs variable- **SpeakLongText** (t As TTS, TextToSpeak As String)
Speaks long texts more than MaxLength of TTS
Uses TTS Lib- **StopSpeakingLongText** (t As TTS)
Stops the speaking of long texts more than MaxLength of TTS
Uses TTS Lib- **SetVoice** (t As TTS, Voice As String)
Set a voice to the TTS
Uses TTS Lib, JavaObject Lib- **GetVoices** (t As TTS, OnlyCurrentLocale As Boolean) **As String()**
Get Voices of Current Engine of TTS with option to get the voices of current locale only.
Uses JavaObject Lib, TTS Lib- **GetTTSCurrentLocale** (t As TTS) **As String**
Gets the current locale of the TTS
Uses JavaObject Lib, TTS Lib, Phone Lib
  
  
  
  
Cheers