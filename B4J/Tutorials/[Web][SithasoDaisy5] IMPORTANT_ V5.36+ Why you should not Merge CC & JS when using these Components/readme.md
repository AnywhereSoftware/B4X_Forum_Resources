### [Web][SithasoDaisy5] IMPORTANT: V5.36+ Why you should not Merge CC & JS when using these Components by Mashiane
### 05/10/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/166856/)

Hi Fam  
  
**NB: Loading CSS & JS files ONLY when needed**  
  
With BANano.LoadAssets, one is able to load CSS and JS files on demand, i.e. when they are needed. There are some components that are not configured to load CSS and JS files on demand. This is also inclusive of some methods.  
  
Why is this necessary? When you use AddCSSFile() and AddJavascriptFile(?), the specified CSS and JS files will be added to the index.html file to be loaded when your app starts. With BANano.AssetsLoad(Wait), one is able to load the CSS and JS only when needed.  
  
The CSS and JS files should then be sitting \*individually\* in your styles and scripts folder.  
  
In affected methods and custom views, on the Initialize method we have added a check to see if the CSS & JS files needed are loaded. If not, an error will be thrown.  
  

```B4X
If BANano.AssetsIsDefined("Crypto") = False Then  
If BANano.AssetsIsDefined("Crypto") = False Then  
If BANano.AssetsIsDefined("BarCode") = False Then  
If Banano.AssetsIsDefined("HTMLParser") = False Then  
If Banano.AssetsIsDefined("CSV") = False Then  
If BANano.AssetsIsDefined("Code") = False Then  
If BANano.AssetsIsDefined("Devices") = False Then  
If BANano.AssetsIsDefined("DropZone") = False Then  
If BANano.AssetsIsDefined("MDE") = False Then  
If BANano.AssetsIsDefined("JSONEditor") = False Then  
If BANano.AssetsIsDefined("JSONTree") = False Then  
If BANano.AssetsIsDefined("LottiePlayer") = False Then  
If BANano.AssetsIsDefined("Pivot") = False Then  
If BANano.AssetsIsDefined("QRCode") = False Then  
If BANano.AssetsIsDefined("SignaturePad") = False Then  
If BANano.AssetsIsDefined("TreeSpider") = False Then  
If BANano.AssetsIsDefined("TrendCharts") = False Then  
If BANano.AssetsIsDefined("VideoAudio") = False Then  
If BANano.AssetsIsDefined("WhatsApp") = False Then  
If BANano.AssetsIsDefined("DocXTemplate") = False Then  
If BANano.AssetsIsDefined("Excel") = False Then  
If BANano.AssetsIsDefined("PocketBase") = False Then  
If BANano.AssetsIsDefined("SQLiteBrowser") = False Then
```

  
  
**Affected Methods and stuff to add in your Show sub routine of your module**  
  

```B4X
ImportCSV - app.UsesCSVParser  
AESEncrypt - app.UsesAES  
AESDecrypt- app.UsesAES  
ParseHTML - app.UsesHTMLParser
```

  
  
**Affected Components - if an app.Uses?? call is not added for a component, an error will be thrown. Below are some useful methods needed for other components**  
  

```B4X
Sub UsesPocketBase  
Sub UsesDevices  
Sub UsesPivot  
Sub UsesColorWheel  
Sub UsesWhatsApp  
Sub UsesTreeSpider  
Sub UsesExcel  
Sub UsesMarkDownEditor  
Sub UsesLottiePlayer  
Sub UsesQRCode  
Sub UsesBarCodeReader  
Sub UsesDropZone  
Sub UsesVideoAudioPlayer  
Sub UsesSQLiteBrowser  
Sub UsesHTMLParser  
Sub UsesDocxTemplate  
Sub UsesCode  
Sub UsesSignaturePad  
Sub UsesDatePicker  
Sub UsesJSONEditor  
Sub UsesJSONTree  
Sub UsesTrendCharts
```

  
  
NB: Ensure these transpiler options are added and set to false.  
  

```B4X
BANano.TranspilerOptions.MergeAllCSSFiles = False  
    BANano.TranspilerOptions.MergeAllJavascriptFiles = False
```