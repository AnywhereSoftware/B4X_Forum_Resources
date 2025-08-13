### B4A/B4I: How to know if the application is installed on device? (WhatsApp/Telegram example) by Sergio Haurat
### 06/21/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/161732/)

Important: In this example I only need WhatsApp, WhatsApp Business and Telegram. On Android WhatsApp (com.whatsapp) and WhatsApp Business (com.whatsapp.w4b) have different identifiers, I have not found the #QueriesSchemes for WhatsApp Business. If you know him, please leave a message so I can edit the post again and add it to the example.  
  
[SIZE=7]Prerequisites for Android (B4A)[/SIZE]  

```B4X
AddManifestText(  
  <queries>  
        <package android:name="com.whatsapp"/>  
        <package android:name="com.whatsapp.w4b"/>  
        <package android:name="org.telegram.messenger"/>  
    </queries>  
)
```

  
  
[SIZE=7]Prerequisites for iOS (B4I)[/SIZE]  

```B4X
#Region  Project Attributes  
    #ATSEnabled: True 'Change to true if its current value is false  
    'WhatsApp  
    #QueriesSchemes: whatsapp  
    'Telegram  
    #QueriesSchemes: telegram  
    #QueriesSchemes: tg  
    #QueriesSchemes: tgapp  
  
    #PlistExtra: <key>LSApplicationQueriesSchemes</key>  
    #PlistExtra: <array>  
    #PlistExtra:   <string>whatsapp</string>  
    #PlistExtra:   <string>telegram</string>  
    #PlistExtra:   <string>tg</string>  
    #PlistExtra:   <string>tgapp</string>  
    #PlistExtra: </array>  
#End Region
```

  
  
GitHub - [iOS URL Schemes](https://github.com/bhagyas/app-urls)  
Another GitHub (Use search, it's a mess) - [Reference: List of iOS App URL Scheme Names & Paths for Shortcuts](https://gist.github.com/roachhd/c5d9c9dee45c73568daff94b343f5170)  
  
Attention: #QueriesSchemes maximum 50 items, more info:  
<https://www.b4x.com/android/forum/threads/ios-9-important-changes.59457/#content>  
  

```B4X
Public Sub GetIMApps() As Map  
    Dim mapApps As Map  
    mapApps.Initialize  
    Try  
        #IF B4A  
        Dim pm As PackageManager  
        Dim packages As List  
        packages = pm.GetInstalledPackages  
        For i = 0 To packages.Size - 1  
            Select Case packages.Get(i)  
                Case "com.whatsapp", "com.whatsapp.w4b", "org.telegram.messenger"  
                    mapApps.Put(packages.Get(i), pm.GetApplicationLabel(packages.Get(i)))  
            End Select  
        Next  
        #Else If B4I  
        If Main.App.CanOpenURL("whatsapp://") Then  
            mapApps.Put("whatsapp", "WhatsApp")  
        End If  
        If Main.App.CanOpenURL("telegram://") Then  
            mapApps.Put("telegram", "Telegram")  
        End If  
        #End If  
    Catch  
        Log(LastException)  
    End Try  
    Return mapApps  
End Sub
```