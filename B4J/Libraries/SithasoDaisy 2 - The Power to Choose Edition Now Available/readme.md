### SithasoDaisy 2 - The Power to Choose Edition Now Available by Mashiane
### 11/03/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/149186/)

Hi there  
  
[Demo on Vercel](https://sithaso-daisy-ptc-edition.vercel.app/)  
  
**NB: Merging of CSS & JS SHOULD BE FALSE**  
  

```B4X
BANano.TranspilerOptions.MergeAllCSSFiles = False  
BANano.TranspilerOptions.MergeAllJavascriptFiles = False
```

  
  
It is with pleasure to announce **The Power to Choose Edition** of **SithasoDaisy**. Basically this collection of b4xlibs gives you the developer the power to choose which plugins you want included in your project. There is the core SithasoDaisy b4xlib and then additional b4xlibs that you can include in your project.  
  
This project makes heavy use of the BANano "…later" directive to load css/js resources, for as and when needed.  
  
The attached document shows you whats new and how to migrate your projects. You can also explore the attached "demo" app to explore more functionality of how we have done it.  
  
As a SithasoDaisy user, please feel free to explore, make suggestions, critisize in a kind way. Get it from the same location. **The files are suffixed with 2.**  
  
Yours  
  
Mashy  
  
PS: The demo application contains everything on SithasoDaisy. Please test the beta with your own projects and then please comment / ask question down here on anything you experience I humbly thank you.  
  
  
![](https://www.b4x.com/android/forum/attachments/143992)  
  
**Update: Migrating from V1 to V2**  
  
1. Ensure that all the b4xlibs from SithasoDaisy are sitting in your Additional Libraries folder.  
  
2. Add this sub to pgIndex  
  

```B4X
Sub AddUses  
    'uncomment unused  
    BANano.Await(app.UsesPDF)  
    BANano.Await(app.UsesExcel)  
    BANano.Await(app.UsesCSV)  
    BANano.Await(app.UsesEnjoyHint)  
    BANano.Await(app.UsesFlatPickDateTime)  
    BANano.Await(app.UsesRollDate)  
    BANano.Await(app.UsesPocketBase)  
    BANano.Await(app.UsesFlipPage)  
    BANano.Await(app.UsesTimeLine)  
    BANano.Await(app.UsesGridNav)  
    BANano.Await(app.UsesChartKick)  
    BANano.Await(app.UsesQRCode)  
    BANano.Await(app.UsesBarCodeReader)  
    BANano.Await(app.UsesWebCam)  
    BANano.Await(app.UsesAxios)  
    BANano.Await(app.UsesLottiePlayer)  
    BANano.Await(app.UsesDocxTemplator)  
    BANano.Await(app.UsesHTMLParser)  
    BANano.Await(app.UsesLZCompressString)  
    BANano.Await(app.UsesFullCalendar)  
    BANano.Await(app.UsesDevice)  
    BANano.Await(app.UsesKanBan)  
    BANano.Await(app.UsesAES)  
    BANano.Await(app.UsesGMaps)  
    BANano.Await(app.UsesAES4PHP)  
    BANano.Await(app.UsesToastChart)  
    BANano.Await(app.UsesMockupCode)  
    BANano.Await(app.UsesFireBase)  
    BANano.Await(app.UsesSupaBase)  
    BANano.Await(app.UsesRelax)  
    BANano.Await(app.UsesGijgo)  
    BANano.Await(app.UsesJustGage)  
    BANano.Await(app.UsesFluidMeter)  
    BANano.Await(app.UsesFrappeGantt)  
    BANano.Await(app.UsesEvoCalendar)  
    BANano.Await(app.UsesDropZone)  
    BANano.Await(app.UsesCollectJS)  
    BANano.Await(app.UsesSwiper)  
End Sub
```

  
  
Please note, you can remove the Use calls of the libs you wont use.  
  
Update the pgIndex.Initialize call to include a call to the new sub  
  

```B4X
Sub Initialize                    'ignoreDeadCode  
    'initialize the app  
    BANano.Await(app.AddApp(Me, Main.AppName))  
    BANano.Await(AddUses)
```

  
  
3. Ensure you select all the Libraries starting with SithasoDaisy… in Libraries  
  
![](https://www.b4x.com/android/forum/attachments/146773)  
  
![](https://www.b4x.com/android/forum/attachments/146774)  
  
Also from this list, you can remove the libs you wont need in your app and also the Use calls that wont be needed.  
  
OPTIONAL: DO NOT SELECT THESE LIBRARIES, They are already included internally in SithasoDaisy b4xlib and are part of the core.  
  
![](https://www.b4x.com/android/forum/attachments/146775)  
  
The above Use case is for the SithasoDaisyDemo, depending on your project, the Use calls and b4xlibs used might be different, depending on your needs.  
  
**Related Content**  
  
  
<https://www.b4x.com/android/forum/threads/web-sithasodaisy-deferring-css-js-files-so-that-they-are-loaded-only-when-needed.149123/#post-945111>