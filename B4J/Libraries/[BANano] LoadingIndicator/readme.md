### [BANano] LoadingIndicator by FabioRome
### 09/21/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/172115/)

By adding the attached file, when using the BANano.Await function, the LoadingIndicator starts automatically.  
  
How to use it:  
From B4J, go to FileManager, then AddFiles → loading-indicator.js  
  

```B4X
Sub AppStart (Form1 As Form, Args() As String)  
      
    ' With this little snippet, the new B4J 9.30 logs with jump are activated  
    #if Debug  
        ' MUST be literally this line if you want to use the B4J Logs jump to code feature!  
        Log("BANanoLOGS")  
    #End if  
    ' some general settings like the name of your PWA  
    BANano.Initialize("BANano", …")  
    BANano.Header.Title=".."  
    BANano.Header.Author =".."  
    BANano.Header.Description = "…"  
    BANano.Header.Keywords = "…"  
  
    BANano.Header.AddJavascriptFile("loading-indicator.js")  
  
    ' DateTime.Now is to make sure our app is reloaded on ReBuild  
    BANano.JAVASCRIPT_NAME = "app" & DateTime.Now & ".js"  
    ' a PWA must have a service worker. Will be built automatically caching everything used in your Web App  
    BANano.SERVICEWORKER_NAME = "service-worker.js"  
      
    ' some directives for the Transpiler  
    BANano.TranspilerOptions.MergeAllCSSFiles = True  
    BANano.TranspilerOptions.MergeAllJavascriptFiles = True  
    BANano.TranspilerOptions.RemoveDeadCode = True  
    BANano.TranspilerOptions.ShowWarningDeadCode = True  
    BANano.TranspilerOptions.EnableLiveCodeSwapping = True  
      
    ' this line makes sure our Web App becomes a PWA  
    #if Release  
    BANano.TranspilerOptions.UseServiceWorkerWithUpdateMessage(True, "#26AE60", $"Update available"$, $"Click here to update the app to the latest version"$)  
    #end if     
      
    ' optional: if your WebApp is not in the root  
    ' BANano.TranspilerOptions.SetPWAStartUrl("myPWA/index.html")  
    BANano.Header.BackgroundColor = "#1e1e1e"  
  
    ' additional JavaScript and CSS files we want to include  
    ' BANano.Header.AddJavascriptFile("jsstore.min.js")  
  
    ' settings needed for the PWA app icons, splash screens, etc…  
    BANano.Header.AddMSTileIcon("logo-150x150.png", "150x150")  
    BANano.Header.MSTileColor = "#ffc40d"  
      
    BANano.Header.AddManifestIcon("android-chrome-192x192.png", "192x192")  
    BANano.Header.AddManifestIcon("android-chrome-512x512.png", "512x512")  
    BANano.Header.SetAndroidMaskIcon("maskable_icon.png", "731x731")  
    BANano.Header.MaskIconColor = "#1e1e1e"  
      
    BANano.Header.AddAppleTouchIcon("apple-touch-icon.png", "")  
    BANano.Header.SetAppleMaskIcon("safari.png")  
    BANano.Header.AddAppleTouchStartupImage("iphone5_splash.png", "320px", "568px", "2")  
    BANano.Header.AddAppleTouchStartupImage("iphone6_splash.png", "375px", "667px", "2")  
    BANano.Header.AddAppleTouchStartupImage("iphoneplus_splash.png", "621px", "1104px", "3")  
    BANano.Header.AddAppleTouchStartupImage("iphonex_splash.png", "375px", "812px", "3")  
    BANano.Header.AddAppleTouchStartupImage("iphonexr_splash.png", "414px", "896px", "2")  
    BANano.Header.AddAppleTouchStartupImage("iphonexsmax_splash.png", "414px", "896px", "3")  
    BANano.Header.AddAppleTouchStartupImage("ipad_splash.png", "768px", "1024px", "2")  
    BANano.Header.AddAppleTouchStartupImage("ipadpro1_splash.png", "834px", "1112px", "2")  
    BANano.Header.AddAppleTouchStartupImage("ipadpro2_splash.png", "834px", "1194px", "2")  
    BANano.Header.AddAppleTouchStartupImage("ipadpro3_splash.png", "1024px", "1366px", "2")  
          
    BANano.Header.AddFavicon("favicon-16x16.png", "16x16")  
    BANano.Header.AddFavicon("favicon-32x32.png", "32x32")  
          
    ' write the theme  
    SKTools.WriteTheme  
      
    ' start the actual build  
    BANano.Build(File.DirApp)  
      
    ' stop running. We do not need the .jar file running anymore  
    ' in release mode  
    #if Release  
        ExitApplication         
    #End if  
End Sub
```