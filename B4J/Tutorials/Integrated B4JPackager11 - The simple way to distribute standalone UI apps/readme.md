### Integrated B4JPackager11 - The simple way to distribute standalone UI apps by Erel
### 01/29/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/117880/)

B4JPackager11 is a utility written in B4J that uses the underlying Java tools to create a standalone package that doesn't depend on any other software being installed.  
It works with OpenJDK 11 and OpenJDK 14.  
Starting from B4J v8.30 it is integrated in the IDE and available under Project - Build Standalone Package.  
External tool: <https://www.b4x.com/android/forum/threads/b4jpackager11-the-simplest-way-to-distribute-ui-apps.99835/#content>  
  
  
  
The output of this tool looks like this:  
  
![](https://www.b4x.com/basic4android/images/explorer_fa8Z3lAQP3.png)  
  
You need to distribute the executable together with the 4 folders.  
The run\_debug.bat batch file is useful to test the program and see the logs.  
  
An Inno Script template is created in the parent folder. You can use it together with [Inno Script](https://jrsoftware.org/isinfo.php) to build a single file installer.  
  
The integrated packager creates a Windows package. You can however use the external tool with the generated json file (in the project folder) to create Linux and Mac packages.  
  
The packager supports all kinds of settings. You can set them with the new #PackagerProperty attribute.  
  
For example to set the icon file, assuming that the ico file is in the Files tab and is named turtle.ico:  

```B4X
#PackagerProperty: IconFile = ..\Files\turtle.ico
```

  
Also set the executable name:  

```B4X
#PackagerProperty: IconFile = ..\Files\turtle.ico  
#PackagerProperty: ExeName = Turtle
```

  
Note that this will set the executable icon. Set the form icon with the designer. The form icon should be a regular image file (png, jpg, …).  
  
**Tips and special cases**  
  

1. If using jPOI library then you must reference XLUtils.
2. If using WebView or HtmlEditor add:

```B4X
#PackagerProperty: IncludedModules = javafx.web
```

3. If using jGoogleMaps add:

```B4X
#PackagerProperty: IncludedModules = javafx.web  
#PackagerProperty: AdditionalModuleInfoString = exports com.lynden.gmapsfx.javascript.event;
```

There is an issue with Java 14 and Google Maps. Use Java 11 for now if using jGoogleMaps.4. You can use #CustomBuildAction with the new After Packager step to copy files after the package is built. The default target folder should be: temp\build\bin\
5. If using jSerial put the attached jssc.dll file in the project folder and add:

```B4X
#CustomBuildAction: After Packager, %WINDIR%\System32\robocopy.exe, ..\ temp\build\bin\ jssc.dll
```

Note that it is a Windows 64 bit dll.
MacSigner instructions: <https://www.b4x.com/android/forum/threads/mac-and-jssc.135823/post-859095>6. Each PackagerProperty key should appear at most once. So for example if using both WebView and jPOI add: #PackagerProperty: IncludedModules = jdk.charsets, javafx.web
Starting from B4J 9.00, the same property can appear multiple times and the values will be appended.7. If you get an error that looks like: javax.net.ssl.SSLHandshakeException: Received fatal alert: handshake\_failure, add:

```B4X
#PackagerProperty: IncludedModules = jdk.crypto.ec
```

8. If using jWebSocketClient then you need to add:

```B4X
#PackagerProperty: AdditionalModuleInfoString = uses org.eclipse.jetty.websocket.common.RemoteEndpointFactory;
```

9. If you want to copy the generated build to a different folder (C:\Users\H\Downloads\test for example):

```B4X
#CustomBuildAction: After Packager, %WINDIR%\System32\robocopy.exe, /MIR temp\build\ C:\Users\H\Downloads\test
```

**Warning : the destination folder will be deleted recursively.**10. A json file named packager.json is created in the Objects folder. You can use it to run the external packager tool, for example to build Mac or Linux packages.
11. Steps to automatically build the setup file with Inno Script:

- Move the generated InstallerScript-template.iss file to the project folder and rename it to InstallerScript.iss.
- Edit the script, change the app name, publisher and other fields as needed. **You also need to update two paths as explained in post #3**.
- Put the icon file in the project folder.
- Add this attributes:

```B4X
#PackagerProperty: IconFile = ..\turtle.ico  
#CustomBuildAction: After Packager, C:\Program Files (x86)\Inno Setup 6\Compil32.exe, /cc ../InstallerScript.iss
```

- Output after choosing Project - Build standalone package:
![](https://www.b4x.com/basic4android/images/explorer_ZR0Ey83790.png)- Note that the AppId field shouldn't be changed after you distribute your app.

12. By default, not all of the localization data is added to the package. This can cause for example, the dates to appear in English even when the default locale is non-English. You can add the missing data with:

```B4X
#PackagerProperty: IncludedModules = jdk.localedata
```

It will add about 9mb to the built package.
(Don't miss tip #6 if you need to add multiple modules.)13. Packaging of jServer projects: <https://www.b4x.com/android/forum/threads/jserver-v4-0-based-on-jetty-11.140437/>