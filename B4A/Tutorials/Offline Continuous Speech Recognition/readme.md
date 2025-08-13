### Offline Continuous Speech Recognition by stevel05
### 08/28/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/42898/)

**This is a very old project which is unlikely to function correctly on newer versions of Android. The link to the project should still be active and if you want to use it for reference to update to a newer version feel free.**  
  
This is a proof of concept port of CMU PocketSphinx for Android demo app.  
  
It's written in B4a using JavaObject to access the PocketSphinx library.  
  
There is a wealth of information on the website : <http://cmusphinx.sourceforge.net/> on tailoring the dictionaries, grammar and models.  
  
If you want to control simple tasks or games with a few keywords, it doesn't look like it would be too difficult to implement. I'll let you know in a few weeks when I have integrated it into a current project.  
  
I've used B4a 3.82, so if you're using an older version you will have to change some of the JavaObject calls relating to the array definitions i.e. change them to Array As Object(..) instead of Array(…)  
  
In line with recommendations from CMU the setup copies the files from the assets directory to the apps default directory if it's not there, or the MD5 ID has changed. This is done in a thread in a separate class that has the #ExcludeFormDebugger: True directive, so you should be able to debug the rest of the app.  
  
  
  
Download and unzip the library file and copy it to your additional libraries folder.  
  
The project is located on my Google Drive as, with the dictionaries, it is too large (about 10 MB) to upload to the forum you can download it here : [SpeechRecognizerContinuous](https://drive.google.com/drive/folders/0B2r-tSygjxB7ci1vYnVDWDFYSHc?resourcekey=0-7_BaY0qzZKcPL5UzRkY5wA&usp=sharing)  
  
  
It's a bit confusing to download if you haven't done it before (as I just found out), click on the file, then there will be a download icon somewhere at the top middle of the screen.  
  
The copyright.txt file contains the original copyright notice from the demo app.  
  
**Update to V1.1**  

- Replaced threading with wait for
- Replaced File.DirExternal with RuntimePermissions GetSafeDirDefaultExternal
- Changed listener event handler (not quite sure why that needed changing)
- Changed manifest to android:targetSdkVersion="29"
- Recognizer object is passed back on configuration completion instead of being shared.

  

- Updated link to project on Google drive due to their change in security.

  
  
Download the new project from [SpeechRecognizerContinuous](https://drive.google.com/file/d/1hRUSEKYL6w6UhER_Ml6lwpDa8jAofyPq/view?usp=sharing). The library zip is unchanged if you already have it.  
  
Have fun, and let me know how you get on with it.