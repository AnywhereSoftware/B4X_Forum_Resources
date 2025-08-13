### User selection of a voice for Text To Speech. by agraham
### 02/12/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/146105/)

I've just added a speech to text facility to my note taking app using  
<https://www.b4x.com/android/forum/threads/speechtotext-continuous-offline-voice-recognition.134857/#content>  
  
 and text to speech using the internal TTS library. The default voice is a female but I wanted a different voice so I started messing with JavaObject and native code but eventually stumbled across the fact that it is possible for the user to select the default speech to text text to speech voice through Settings! I didn't know this so maybe you don't either.  
  
Settings -> System -> Languages and input -> Text-to-speech output -> Cog icon by 'Preferred engine' -> Install voice data  
  
You now get a list of lots of languages. The one for your locale should already be loaded so tap on it and you are offered a choice of voices. Selecting one will play a short example of the voice. For English(United Kingdom) there is a choice of six, three very similarly accented females and three very similarly accented males.