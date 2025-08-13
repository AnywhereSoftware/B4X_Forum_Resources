### STT - Offline Speech Recognization with Vosk (JavaObject/Inline) by Douglas Farias
### 05/14/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/161102/)

[MEDIA=youtube]uxOlvQlcLBU[/MEDIA]  
  
Hello everybody.  
  
I made an example of how to use vosk in B4J.  
In this example we use vosk to listen to our microphone and play the words it understands on the screen.  
  
the example is very simple and functional (at least on my PC xD)  
  
In the example you will see two labels, the top one is what vosk is understanding in real time, and the bottom one is the final phrase already formed and adjusted.  
  
In the video above, despite being in Portuguese, you can see that I am speaking in real time and the words are placed on the label in real time as I speak.  
  
**It works offline**, I recommend you download the recognition files for your language.  
  
<https://alphacephei.com/vosk/models>  
  
In the link above you can find all available languages.  
I recommend you download the larger files to test, in Brazil for example there are 2 models, a small and a large one, the small one didn't have good accuracy, but the large 1gb+ one was great, you understand very well what I'm saying.  
  
After downloading the file for your language, simply extract the folder into the objects folder and point to the path in the code  
  

```B4X
'LOAD THE MODEL  
model.InitializeNewInstance("org.vosk.Model", Array As Object(File.Combine(File.DirApp, "language_folder_path_here")))
```

  
  
[MEDIA=googledrive]19lN6GfJOsvdgl3aYvCgsPdBGSeFaQ2AK[/MEDIA]  
  
  
thxx