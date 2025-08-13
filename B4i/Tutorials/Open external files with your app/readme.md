### Open external files with your app by Erel
### 12/19/2022
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/50525/)

Also see: [List of methods to access external resources or share to external apps](https://www.b4x.com/android/forum/threads/list-of-methods-to-access-external-resources-or-share-to-external-apps.99368/)  
  
Many applications that deal with files show a standard file handling dialog. One of the options in this dialog is to open the file with another app. This tutorial explains how you can add your app to this list and then open the file.  
  
For example you can use this to open CSV files received by mail in your app or from Dropbox app (useful for debugging this).  
  
The first step is to register the file types that you would like to handle in your app. You need to find the correct identifier. Some of the standard identifiers are listed here: <https://developer.apple.com/library/ios/documentation/Miscellaneous/Reference/UTIRef/Articles/System-DeclaredUniformTypeIdentifiers.html#//apple_ref/doc/uid/TP40009259-SW1>  
  
For CSV the type is: public.comma-separated-values-text  
  
Use the PListExtra attribute to add the required declaration:  

```B4X
#PlistExtra:<key>CFBundleDocumentTypes</key>  
#PlistExtra:<array>  
#PlistExtra:    <dict>  
#PlistExtra:        <key>CFBundleTypeName</key>  
#PlistExtra:            <string>CSV File</string>  
#PlistExtra:        <key>LSHandlerRank</key>  
#PlistExtra:            <string>Alternate</string>  
#PlistExtra:        <key>LSItemContentTypes</key>  
#PlistExtra:            <array>  
#PlistExtra:                <string>public.comma-separated-values-text</string>  
#PlistExtra:            </array>  
#PlistExtra:    </dict>  
#PlistExtra:</array>
```

  
  
When the user will click on the Open in… option and choose your app, your app will start and OpenUrl will be called:  

```B4X
Private Sub Application_OpenUrl (Url As String, Data As Object) As Boolean  
   If Url.StartsWith("file://") Then  
     Dim f As String = Url.SubString(7) 'remove the file:// scheme.  
      Dim su As StringUtils  
     f = su.DecodeURL(f, "utf8")  
     Try  
       Msgbox(File.ReadString("", f), "")  
     Catch  
       Msgbox("Error loading file", "")  
     End Try  
   End If  
   Return True  
End Sub
```

  
  
You can run and test this in debug mode however if your program is in the background for too long (+-1 minute) then the process will be killed and later when your app will start it will wait for the debugger to connect (which will not happen).  
  
If you want to register a custom file type you will need to add a few more declarations. See the answer here: <http://stackoverflow.com/questions/4186401/how-do-i-register-a-custom-filetype-in-ios>  
  
The other side of this tutorial: <https://www.b4x.com/android/forum/threads/open-local-files-with-external-apps.51941/>