### Dropbox Chooser by stevel05
### 03/11/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/61064/)

As Dropbox sync is apparently deprecated, I though I would have a go at wrapping the Android Native version of The Dropbox chooser, and here it is.  
  
It's simple enough to use, you first need to register an app with dropbox and get an app key from here:  
<https://www.dropbox.com/developers> , follow the process of creating a new app and get your app key.  
  
To use the chooser, you don't need an HTTPS site and no need to apply for approval as all data transfer is done under user control.  
  
**Required Files:**  
  
The three attached files are:  
  
**DropboxChooserSource.zip** - contains the source for the DropboxChooserWrapper (in B4a) and an example of it's use.  
  
**DropboxChooserExample.zip** - contains just the main activity example (same as in the source without the Library classes)  
  
**DropboxChooserLibJars.zip** - Contains the compiled library from the source zip - DropboxChooserWrapper.jar and xml files.  
  
You also need the **DropboxChooserLib** which is the API from dropbox exported from an Eclipse project. It is just over 3MB so too large to upload to the forum, you can get it from my google drive here: [DropboxChooserLib](https://drive.google.com/file/d/0B2r-tSygjxB7eERFbkN4cWw2U2c/view?usp=sharing&resourcekey=0-7T9GDMJJK_Rq16l0xbqtuQ)  
  
Finally, you also need the **android-support-v4.jar** which you can get via your SDK manager if you haven't already.  
  
  
  
Copy the 3 jar files and 1 XML file to your addl libs folder. **Don't select the DropboxChooserWrapper in the libs tab if you are running the full source project.**  
  
Also depends on JavaObject.  
  
  
**Classes:**  
  
There are two classes in the Dropbox chooser Lib:  
  
**DropboxChooser** which has two methods:  
  
 Initialize(Module As Object,EventName As string,AppKey As String)  
  
 Show(ShowType As String)  
 See the [Dropbox documentation](https://www.dropbox.com/developers/chooser#android) for explanation of the types  
  
**DropboxChooserResult** which has 5 methods:  
  
 GetLink As String  
  
 GetIcon As String  
  
 GetName As String  
  
 GetSize As Long  
  
 GetThumbnails As Map  
  
 Again see the [Dropbox documentation](https://www.dropbox.com/developers/chooser#android) (or source project) for an explanation  
  
**Results:**  
  
All results return a URL which you can then download using [HTTPUtils2](https://www.b4x.com/android/forum/threads/httputils2-web-services-are-now-even-simpler.18992/)  
  
Unfortunately it appears that the Dropbox Saver API for Android is a long time coming, it was supposed to be being released soon in 2013.  
  
Have fun