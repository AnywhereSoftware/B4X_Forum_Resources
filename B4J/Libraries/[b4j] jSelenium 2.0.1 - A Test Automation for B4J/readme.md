### [b4j] jSelenium 2.0.1 - A Test Automation for B4J by tummosoft
### 01/27/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/142203/)

This is my very first attempt to create a wrap for a library, It is based on this project:  
- <https://www.selenium.dev/downloads/>  
jSelenium - version 1.0  
  
[HEADING=1]Usage[/HEADING]  
\* Third party Jar:  
  

```B4X
#AdditionalJar: client-combined-3.14.0.jar  
#AdditionalJar: animal-sniffer-annotations-1.14.jar  
#AdditionalJar: byte-buddy-1.8.15.jar  
#AdditionalJar: checker-compat-qual-2.0.0.jar  
#AdditionalJar: commons-codec-1.10.jar  
#AdditionalJar: commons-exec-1.3.jar  
#AdditionalJar: commons-logging-1.2.jar  
#AdditionalJar: error_prone_annotations-2.1.3.jar  
#AdditionalJar: guava-31.1-jre.jar  
#AdditionalJar: httpclient-4.5.5.jar  
#AdditionalJar: httpcore-4.4.9.jar  
#AdditionalJar: j2objc-annotations-1.1.jar  
#AdditionalJar: okhttp-3.10.0.jar  
#AdditionalJar: jsr305-1.3.9.jar  
#AdditionalJar: selenium-api-4.3.0.jar  
#AdditionalJar: selenium-chromium-driver-4.3.0.jar  
#AdditionalJar: selenium-java-3.14.0.jar  
#AdditionalJar: selenium-support-4.3.0.jar  
#AdditionalJar: selenium-remote-driver-4.3.0.jar  
#AdditionalJar: okio-1.14.1.jar  
#AdditionalJar: opentelemetry-sdk-1.16.0.jar  
#AdditionalJar: opentelemetry-sdk-extension-autoconfigure-spi-1.16.0.jar
```

  
  

```B4X
ClassName  
id  
CssSelector  
Xpath  
LinkText  
Name  
Partiallinktext  
Tagname          
  
Example:  
jChrome.SelecElement("//a[contains(text(),'B4J - Desktop, Server and Raspberry Pi')]", "xpath")
```

  
  

```B4X
Sub AppStart (Form1 As Form, Args() As String)  
    jChrome.Initialize("jChrome", "D:\B4J\b4jSelenium\jSelenium\Driver", "chromedriver104.exe")  
    jChrome.Create  
End Sub  
  
Sub Button1_Click    
    'jChrome.HideAutomation(True)  
    jChrome.loadURL("https://www.showmyip.com/")  
    Sleep(1000)  
    jChrome.ReadCookies(File.DirApp, "fb.cookies")  
    Sleep(500)  
    jChrome.Refresh  
End Sub
```

  
  
**[SIZE=7]EVENTS[/SIZE]**  
  

```B4X
Sub jChrome_PageFinished (error As String, success As Boolean)  
    Log("PageFinished:" & success)  
End Sub  
Sub jChrome_AfterClickOn ()  
    Log("AfterClickOn")  
End Sub  
Sub jChrome_BeforeClickOn()  
    Log("BeforeClickOn")  
End Sub  
  
Sub jChrome_BeforeAlertAccept()  
    Log("BeforeAlertAccept")  
End Sub  
     
Sub jChrome_AfterAlertAccept()  
    Log("AfterAlertAccept")  
End Sub  
  
Sub jChrome_BeforeAlertDismiss()  
    Log("BeforeAlertDismiss")  
End Sub  
Sub jChrome_AfterAlertDismiss()  
    Log("AfterAlertDismiss")  
End Sub  
     
Sub jChrome_AfterNavigateTo(url As String)  
    Log(url)  
End Sub  
Sub jChrome_BeforeNavigateTo(url As String)  
    Log(url)  
End Sub  
Sub jChrome_AfterNavigateBack(url As String)  
    Log(url)  
End Sub  
Sub jChrome_BeforeNavigateBack(url As String)  
    Log(url)  
End Sub  
Sub jChrome_BeforeNavigateForward(url As String)  
    Log(url)  
End Sub  
Sub jChrome_AfterNavigateForward(url As String)  
    Log(url)  
End Sub  
Sub jChrome_AfterNavigateRefresh(url As String)  
    Log(url)  
End Sub  
Sub jChrome_BeforeNavigateRefresh(url As String)  
    Log(url)  
End Sub  
Sub jChrome_AfterFindBy()  
    Log("AfterFindBy")  
End Sub  
Sub jChrome_BeforeFindBy()  
    Log("BeforeFindBy")  
End Sub  
  
Sub jChrome_AfterChangeValueOf(keysToSend As String)  
    Log("AfterChangeValueOf")  
End Sub  
  
Sub jChrome_BeforeChangeValueOf(keysToSend As String)  
    Log("BeforeChangeValueOf")  
End Sub  
Sub jChrome_BeforeScript(script As String)  
    Log("BeforeScript")  
End Sub  
  
Sub jChrome_AfterScript(script As String)  
    Log("AfterScript")  
End Sub  
  
Sub jChrome_BeforeSwitchToWindow(windowName As String)  
    Log(windowName)  
End Sub  
  
Sub jChrome_AfterSwitchToWindow(windowName As String)  
    Log(windowName)  
End Sub  
  
Sub jChrome_OnException(throwable As String)  
    Log(throwable)  
End Sub  
  
Sub jChrome_BeforeGetScreenshotAs()  
    Log("BeforeGetScreenshotAs")  
End Sub  
  
Sub jChrome_AfterGetScreenshotAs()  
    Log("AfterGetScreenshotAs")  
End Sub  
  
Sub jChrome_BeforeGetText(value As String)  
    Log("BeforeGetText")  
End Sub  
  
Sub jChrome_AfterGetText(value As String)  
    Log("AfterGetText")  
End Sub
```

  
  
Download: <https://github.com/tummosoft/jSelenium/releases/tag/Selenium>