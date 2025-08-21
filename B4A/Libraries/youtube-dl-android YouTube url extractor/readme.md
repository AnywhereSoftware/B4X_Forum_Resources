### youtube-dl-android YouTube url extractor by tuhatinhvn
### 10/03/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/110150/)

Base this lib but i updated to newest version because this wrapper current dont work because out-update  
<https://www.b4x.com/android/forum/threads/youtube-dl-extract-direct-urls.100793/#content>  
  
This is a wrapper for an Android adaption of YouTube-DL. It was written by *tastelessjolt* and can be found on his/her repository on GitHub:  
<https://github.com/tastelessjolt/youtube-dl-android>  
  
These are the urls to the YouTube video or audio files, so you can stream or download them. It features an age verification circumvention and a signature deciphering method (mainly for vevo videos).  
  
Copy file android-youtubeExtractor-master-SNAPSHOT.aar to your Additional Lib folder  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: B4A Example  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
#AdditionalJar:android-youtubeExtractor-master-SNAPSHOT.aar  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Dim NativeMe As JavaObject  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    'Activity.LoadLayout("Layout1")  
    NativeMe.InitializeContext  
    NativeMe.RunMethod("getlinkyt", Array As Object("https://www.youtube.com/watch?v=nRrXhgEqJMI"))  
    Wait For finishgetlink(listlink As List)  
    For i=0 To listlink.Size-1  
        Log(listlink.Get(i))  
    Next  
    Log("Finish")  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
#If JAVA  
import android.util.SparseArray;  
import java.util.ArrayList;  
import at.huber.youtubeExtractor.VideoMeta;  
import at.huber.youtubeExtractor.YouTubeExtractor;  
import at.huber.youtubeExtractor.YtFile;  
import anywheresoftware.b4a.keywords.Common;  
import anywheresoftware.b4a.objects.collections.List;  
public void getlinkyt(String linkyt){  
        String youtubeLink = linkyt;  
        new YouTubeExtractor(this) {  
            @Override  
            public void onExtractionComplete(SparseArray<YtFile> ytFiles, VideoMeta vMeta) {  
                ArrayList<String> dslink = new ArrayList<String>();  
                List list = new List();  
                if (ytFiles != null) {  
                    for (int i = 0, itag; i < ytFiles.size(); i++) {  
                        itag = ytFiles.keyAt(i);  
                        YtFile ytFile = ytFiles.get(itag);  
                        dslink.add(ytFile.toString());  
                        //BA.Log("Str " + ytFile.toString());  
                        // String downloadUrl = ytFiles.get(itag).getUrl();  
                    }  
                }  
            //    BA.Log("Finish");  
                                        list.setObject((java.util.ArrayList)dslink);  
  
              processBA.raiseEventFromDifferentThread(this, null, 0, "finishgetlink", false, new Object[] {list});  
            }  
        }.extract(youtubeLink, true, true);  
  
    }  
#End If
```