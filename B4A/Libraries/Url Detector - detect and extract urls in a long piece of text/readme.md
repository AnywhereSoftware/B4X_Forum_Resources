### Url Detector - detect and extract urls in a long piece of text by tuhatinhvn
### 08/27/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/109038/)

This code is based on <https://github.com/linkedin/URL-Detector>  
First you need download 2 jar:  
  
<https://repo1.maven.org/maven2/com/linkedin/urls/url-detector/0.1.17/url-detector-0.1.17.jar>  
<https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.1/commons-lang3-3.1.jar>  
  
And copy to your add-library folder  
And here code / function to extract list url from any text string  
  

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
#AdditionalJar:url-detector-0.1.17.jar  
#AdditionalJar:commons-lang3-3.1.jar  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
End Sub  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    'Activity.LoadLayout("Layout1")  
    Dim str_input="Just because the.com heheyahoo.com weather is starting to get warm, does not mean that you should look sloppy. Get inspired and check out our collection of men's summer outfits.    famousoutfits    " As String  
    Private NativeMe As JavaObject  
    NativeMe.InitializeContext  
    Dim s As List = NativeMe.RunMethod("url_detect", Array As String(str_input))  
    Log(s.Size)  
  
For i=0 To s.Size-1  
    Log(s.Get(i))  
Next  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
#IF JAVA  
import com.linkedin.urls.Url;  
import com.linkedin.urls.detection.UrlDetector;  
import com.linkedin.urls.detection.UrlDetectorOptions;  
import java.util.List;  
import java.util.ArrayList;  
public  List<String> url_detect(String stringinput){  
        UrlDetector parser = new UrlDetector(stringinput, UrlDetectorOptions.Default);  
        List<Url> found = parser.detect();  
        List<String> itemsToAdd = new ArrayList<String>();  
        for(Url url : found) {  
            itemsToAdd.add(url.getFullUrl());  
        }  
        return itemsToAdd;  
    }  
#End If
```

  
  
library can find and detect any urls such as:  
  
  
  

- HTML 5 Scheme - //[www.linkedin.com](http://www.linkedin.com/)
- Usernames - user:[EMAIL]pass@linkedin.com[/EMAIL]
- Email - [EMAIL]fred@linkedin.com[/EMAIL]
- IPv4 Address - 192.168.1.1/hello.html
- IPv4 Octets - 0x00.0x00.0x00.0x00
- IPv4 Decimal - <http://123123123123/>
- IPv6 Address - ftp://[::]/hello
- IPv4-mapped IPv6 Address - [http://[fe30:4:3:0:192.3.2.1]](http://[fe30:4:3:0:192.3.2.1]/)