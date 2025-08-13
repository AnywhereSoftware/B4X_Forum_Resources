### Get Host (Computer) Name - inline JAVA by jkhazraji
### 11/03/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/143931/)

I came across [www.codegrepr.com](http://www.codegrepr.com) and found this useful snippet  
Hope it will be of benefit  

```B4X
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
    Dim jo As JavaObject = Me  
    Log(jo.RunMethod("getHostName", Null))  
  
End Sub  
  
#if JAVA  
 import java.net.InetAddress;  
import java.net.UnknownHostException;  
  
static String hostname = "Unknown";  
public static String getHostName() throws Exception {  
try  
{  
    InetAddress addr;  
    addr = InetAddress.getLocalHost();  
    String hostname = addr.getHostName();  
    System.out.println(hostname);  
    return hostname;  
}  
catch (UnknownHostException ex)  
{  
    System.out.println("Hostname can not be resolved");  
    return hostname;  
}  
}  
#end if
```