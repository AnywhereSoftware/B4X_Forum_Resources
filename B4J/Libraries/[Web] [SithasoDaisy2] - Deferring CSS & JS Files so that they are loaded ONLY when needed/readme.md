### [Web] [SithasoDaisy2] - Deferring CSS & JS Files so that they are loaded ONLY when needed. by Mashiane
### 08/07/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/149123/)

Ola  
  
[Demo on Vercel](https://sithaso-daisy-ui.vercel.app/)  
  
One of the nice things about BANano is the built in functionality around LoadJS. I noted this on the console log when I was updating some stuff on the SithasoDaisy b4xlib and trying this "..**ForLater**" terminology.  
  
> LoadJS is a tiny async loading library for modern browsers (IE9+). It has a simple yet powerful dependency management system that lets you fetch JavaScript, CSS and image files in parallel and execute code after the dependencies have been met.

  
How does one make this work? First, one needs to add CSS + JS + Image files (if any) for later loading. This later loading means that your web app loads faster because the css + js files will be loaded when you as a developer loads them. Below is part of how I changed the b4x lib for the next release.  
  
NB: PLEASE ENSURE  
  

```B4X
BANano.TranspilerOptions.MergeAllCSSFiles = False  
BANano.TranspilerOptions.MergeAllJavascriptFiles = False
```

  
  
1. Add the resources and mark them for later usage with ***AddJavascriptFileForLater*** or ***AddCSSFileForLater***  
  

```B4X
BANano.Header.AddCSSFile("loader-1.css")  
BANano.Header.AddCSSFileForLater("daisyui.min.css")  
        BANano.Header.AddJavascriptFileForLater("tailwind.min.js")  
        BANano.Header.AddCSSFileForLater("fontawesome.min.css")  
        BANano.Header.AddJavascriptFileForLater("fileSaver.min.js")  
        BANano.header.AddCSSFileForLater("sweetalert2.min.css")  
        BANano.Header.AddJavascriptFileForLater("sweetalert2.all.min.js")
```

  
  
The second part is then to load the css + js files ONLY on the page they will be used on, like this..  
  
2. Load the resources when needed. For this example, we will take the webcam code module on the SithasoDemo. The code below is the one to show the page.  
  

```B4X
'sub to show the page  
Sub Show(duiapp As SDUIApp)            'ignore  
    'initialize the page  
    'this clears the 'pageview'  
    page.AddPage(Me, name)  
    page.Root.p(6)  
    'get the reference to the app  
    app = duiapp  
    banano.Await(app.UsesWebCam)  
    'build the page, via code or loadlayouts  
    BuildPage  
End Sub
```

  
  
On the above code, we have a new magic call, this is…  
  
> banano.Await(app.UsesWebCam)

  
When one calls the Show method on this page, the resources that were registered for later loading will be loaded and stored. This is done by that line, after I added this code  
  

```B4X
BANano.Header.AddJavascriptFileForLater("webcam.min.js")
```

  
  
and now I need to use that js file. Now, let's look at what **UsesWebCam** does.  
  

```B4X
Sub UsesWebCam  
    Banano.Await(LoadAssetsOnDemand("WebCam", Array("webcam.min.js")))  
End Sub
```

  
  
This loads the js file on the page where it is needed so that it can be used. Let's look behind the scenes. I first created a generic function called **LoadAssetsOnDemand,** this I feed it a list of css and js files i need loaded and it loads them. Here is it.  
  

```B4X
Sub LoadAssetsOnDemand(Key As String, Items As List)  
    Dim iTot As Int = Items.size - 1  
    Dim iCnt As Int = 0  
    For iCnt = 0 To iTot  
        Dim fn As String = Items.Get(iCnt)  
        If fn.EndsWith(".js") Then  
            If fn.StartsWith("./scripts/") = False Then  
                Items.Set(iCnt, $"./scripts/${fn}"$)  
            End If  
        End If  
        If fn.EndsWith(".css") Then  
            If fn.StartsWith("./styles/") = False Then  
                Items.Set(iCnt, $"./styles/${fn}"$)  
            End If  
        End If  
    Next  
    Dim pathsNotFound() As String  
    If Banano.AssetsIsDefined(Key) = False Then  
        'load the assets  
        pathsNotFound = Banano.AssetsLoadWait(Key, Items)  
        If Banano.IsNull(pathsNotFound) = False Then  
            Banano.Console.Warn($"${Key} not fully loaded…"$)  
            For Each path As String In pathsNotFound  
                Log(path)  
            Next  
        Else  
            Banano.Console.Info($"${Key} fully loaded!"$)  
        End If  
    End If  
End Sub
```

  
  
The benefits of this is faster page loads, which helps with the speed and some app efficiency.  
  
The next release of SithasoDaisy follows this approach and is a *breaking change* for projects where the plug-ins are used. If you are using the core functionality in your app, you have nothing to worry about.  
  
Below is a list of all the "Uses" cases for the plugins, which you can use when you load a needed resources. The demo app has been updated to make use of them across the app on the **Show** calls.  
  

```B4X
BANano.Await(app.UsesEnjoyHint)  
BANano.Await(app.UsesFlipPage)  
BANano.Await(app.UsesTimeLine)  
BANano.Await(app.UsesGridNav)  
BANano.Await(app.UsesChartKick)  
BANano.Await(app.UsesQRCode)  
BANano.Await(app.UsesBarCodeReader)  
BANano.Await(app.UsesWebCam)  
BANano.Await(app.UsesAxios)  
BANano.Await(app.UsesFlatPickDateTime)  
BANano.Await(app.UsesLottiePlayer)  
BANano.Await(app.UsesRollDate)  
BANano.Await(app.UsesHTMLParser)  
BANano.Await(app.UsesLZCompressString)  
BANano.Await(app.UsesTable)  
BANano.Await(app.UsesPocketBase)  
BANano.Await(app.UsesFullCalendar)  
BANano.Await(app.UsesSignaturePad)  
BANano.Await(app.UsesCSV)  
BANano.Await(app.UsesDevice)  
BANano.Await(app.UsesKanBan)  
BANano.Await(app.UsesAES)  
BANano.Await(app.UsesPHPEncryption)  
BANano.Await(app.UsesEncryption)  
BANano.Await(app.UsesToastChart)  
BANano.Await(app.UsesMockupCode)  
BANano.Await(app.UsesPDF)  
Banano.Await(app.UsesDocxTemplator)  
BANano.Await(app.UsesExcel)  
BANano.Await(app.UsesFireBase)  
BANano.Await(app.UsesSupaBase)  
BANano.Await(app.UsesRelax)  
BANano.Await(app.UsesTreeView)  
banano.Await(app.UsesJustGage)  
BANano.Await(app.UsesFluidMeter)  
BANano.Await(app.UsesFrappeGantt)  
BANano.Await(app.UsesEvoCalendar)  
BANano.Await(app.UsesDropZone)  
BANano.Await(app.UsesCollectJS)
```

  
  
You can add all these on **pgIndex** immediately after **app.AddApp(Me, Main.AppName)** in your project or just add the call for the resource you need on the page you need it. Its entirely up to you.  
  
In future versions, these plugins will be made available as B4xlibs, thus making the core smaller (less css + js and SDUI code modules), so that one can just include the plugin they need.  
  
Happy coding.  
  
NB: The demo app is the most up to date presentation of how the SithasoDaisy b4xlib works. You can check it to see how all of this code has been used.  
  
You can DM me if you have anything you want about SithasoDaisy or post a question prefixed by [SithasoDaisy] / use this link.  
  
<https://www.b4x.com/android/forum/threads/sithasodaisy-tailwindcss-ui-toolkit-q-a.144271/>  
  
Enjoy!