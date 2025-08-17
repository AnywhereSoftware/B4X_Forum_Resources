### [Web] Beginning WebApp/WebSite Development with SithasoDaisy5 by Mashiane
### 05/02/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/166741/)

Hi Fam  
  
[Demo](https://sithaso-daisy5.vercel.app/)  
  
**Open Source B4xLib**  
  
<https://www.b4x.com/android/forum/threads/web-sithasodaisy5-create-websites-webapps-with-the-power-of-the-abstract-designer-opensource.165095/#content>  
  

***Faster, cleaner, easier, Tailwind CSS development using the Abstract Designer & b4x code***

  
  
You want to develop a website / webapp. Why not use the same tools you use already for b4x. With the power of the Abstract Designer, you can drop components on a layout, generate members and then create a webapp / website. You dont have to write javascript,css and html to do so either, as BANano will do that for you based on the b4x code you write. Yeah, for real.  
  

![](https://www.b4x.com/android/forum/attachments/163633)  
  
![](https://www.b4x.com/android/forum/attachments/163634)  
  
![](https://www.b4x.com/android/forum/attachments/163635) ![](https://www.b4x.com/android/forum/attachments/163636)

  
  
**What is SithasoDaisy5?**  
  
SithasoDaisy5 is the new and updated SithasoDaisy that we have been using before, but new and also NOT backward compatible. Use it to create new experiences for your end-users. Yes, you can completely write your website / webapp by code, however designing using the Abstract Designer is easier in most cases.  
   
  
**What will you need?**  
  
[b4j](https://www.b4x.com/b4j.html) - Follow the instructions and install it  
[SithasoDaisy5](https://github.com/Mashiane/SithasoDaisy5) - get it from github  
[Laragon](https://github.com/leokhoa/laragon/releases/download/6.0.0/laragon-wamp.exe) (Self Hosted Web Server, this is optional. Please note from V7, laragon requires a license. V6 is still freeware)  
[BANano](https://www.b4x.com/android/forum/threads/web-banano-website-app-pwa-library-with-abstract-designer-support.99740/#content) - b4x to HTML, CSS and JavaScript Transpiler  
  
**Preparing your Development Environment**  
  
Short paths work well, so to make it easy, have these folders created  
  

- [LEFT]c:\b4j\shared[/LEFT]
- [LEFT]c:\b4j\workspace[/LEFT]
- [LEFT]c:\b4j\libraries[/LEFT]

1. [LEFT]From the SithasoDaisy5, copy the contents of the folder "Copy to Additional Libraries" to c:\b4j\libraries.[/LEFT]
2. [LEFT]Unzip the SithasoDaisy5Demo.zip file to the c:\b4j\workspace folder. This folder will contain your projects.[/LEFT]
3. [LEFT]From the BANano download, copy the contents of the libraries and the templates folders to c:\b4j\libraries[/LEFT]

**Running the SithasoDaisy5Demo App [RELEASE MODE]**  
  
To test that our development environment is ready, lets run the SithasoDaisy5Demo WebApp. Open the Demo App. First we need to ensure that our library configuration is perfect. Please ensure that there is no library showing a version **0.0.** If so, it means there is a misconfiguration somewhere. Do not place the b4xlibs in internal libraries also. If SithasoDaisy5 does not work, you might have to get the source code from the repo and then run it in your PC to generate the b4xlib. An edge case like this existed before.  
  
![](https://www.b4x.com/android/forum/attachments/163660)  
  
Also using Short Paths help a great deal. This is my setup. Where I put all my libraries in c:\b4j\libraries.  
  
![](https://www.b4x.com/android/forum/attachments/163661)  
  
  
You will note that in the Views folder, there are bjl files. These are the layout files we used to build each page of the application.  
  
![](https://www.b4x.com/android/forum/attachments/163639)  
  
To create the pages, we added components to the layouts, set some properties, generated members and wrote a few lines of code.  
  
![](https://www.b4x.com/android/forum/attachments/163640)  
  
Each page in the app is a code module. To Show each page, we call Show in each of the pages, this loads a layout and makes the component available. In the example below, we have added some click events to buttons to perform some events.  
  
![](https://www.b4x.com/android/forum/attachments/163641)  
  
In the Main Module, you will find  
  

```B4X
#IgnoreWarnings:12, 15  
Sub Process_Globals  
    Public BANano As BANano 'ignore  
    'the name of the application &  
    'this is the folder on your development server.  
    Public AppName As String = "sd5demo"  
    Public AppTitle As String = "SithasoDaisy 5.28 Demo"  
    Public AppVersion As String = "SithasoDaisy 5.28"  
    'whe the app should  
    Public Publish As String = "C:\laragon\www"  
    Public Version As String = "0.01"  
    Public ServerIP As String = "https://127.0.0.1"  
    Public APIKey As String = ""  
    Public ServerURL As String = ""  
End Sub
```

  
  
**AppName** - this is the name of the app. BANano will create a folder where you publish your app. Publishing your app is running the app which then generates your app as HTML, CSS and JavaScript for you to deploy to your website.  
**Publish** - this is the folder to publish the app to. We are publishing to Laragon.  
  
**AppStart**  
  
This is where your app is built and made readied to be deployed. BANano transpiles (i.e. converts to HTML, CSS and Javascript) all the b4x code you have written, with the exception of what is written in AppStart. As we are running laragon locally, the default web browser will also be opened to show our app.  
  

```B4X
BANano.Build(Publish)  
   
    'open the default browser and show the generated index.html file  
    Dim fx As JFX  
    Dim appPath As String = $"${ServerIP}/${AppName}/index.html"$  
    fx.ShowExternalDocument(appPath)
```

  
  
**Run the Demo App in Release Mode (Removing Dead Code Settings are not On on the Demo App)**  
  
Please check the b4j logs for any errors that might happen. If there is an error, your final app will not work. In normal circumstances, these are the logs that should show.  
  

```B4X
Reading B4J INI in C:\Users\User\AppData\Roaming\Anywhere Software\B4J to find Additional Libraries folder…  
Found Additional Libraries folder: C:\b4j\libraries  
Starting to transpile…  
——————————————————————————  
BANano v9.11 is now converting the B4J code to JavaScript…  
——————————————————————————  
Building C:\laragon\www\sd5demo\scripts\app.js  
Processing b4xlib: sithasodaisy5  
Loading layout chatitemview from library sithasodaisy5…  
Loading layout conversationitemview from library sithasodaisy5…  
Processing b4xlib: bananofontawesome  
Loading layout dockxsview…  
Loading layout dropdownview…  
Loading layout easymdeview…  
Loading layout fieldsetview…  
Loading layout fileinputview…  
Loading layout filterview…  
Loading layout footerview…  
Loading layout gridbuilderview…  
Loading layout gridview…  
Loading layout groupselectview…  
Loading layout heroview…  
Loading layout imageview…  
Loading layout accordionview…  
Loading layout indicatorview…  
Loading layout infoboxview…  
Loading layout inputview…  
Loading layout joinview…  
Loading layout jsoneditorview…  
Loading layout jsontreeview…  
Loading layout jsonview…  
Loading layout kbdview…  
Loading layout labelview…  
Loading layout linkview…  
Loading layout listview…  
Loading layout listviewitem1…  
Loading layout listviewitem2…  
Loading layout listviewitem3…  
Loading layout loadingview…  
Loading layout alertview…  
Loading layout menu1view…  
Loading layout menuview…  
Loading layout modalview…  
Loading layout navbarview…  
Loading layout paginationview…  
Loading layout phoneview…  
Loading layout prefbuilderview…  
Loading layout preferenceview…  
Loading layout progressview…  
Loading layout radialprogressview…  
Loading layout radioview…  
Loading layout rangeview…  
Loading layout ratingview…  
Loading layout selectview…  
Loading layout signaturepadview…  
Loading layout skeletonview…  
Loading layout stackview…  
Loading layout statusview…  
Loading layout statview…  
Loading layout stepsview…  
Loading layout svgview…  
Loading layout swapview…  
Loading layout tablebuilderview…  
Loading layout tableview…  
Loading layout tabsview…  
Loading layout textareaview…  
Loading layout timelineview…  
Loading layout toastview…  
Loading layout avatarview…  
Loading layout toggleview…  
Loading layout tooltipview…  
Loading layout treespiderview…  
Loading layout trendview…  
Loading layout typographyview…  
Loading layout validationview…  
Loading layout whatsappview…  
Loading layout windowview…  
Loading layout wizard1…  
Loading layout wizard2…  
Loading layout wizard3…  
Loading layout wizard4…  
Loading layout wizardview…  
Loading layout badgeview…  
Loading layout baselayout…  
Loading layout blankview…  
Loading layout bottomdrawerview…  
Loading layout breadcrumbsview…  
Loading layout browserview…  
Loading layout buttonsview…  
Loading layout cardview…  
Loading layout carouselview…  
Loading layout chatbubbleview…  
Loading layout checkboxview…  
Loading layout codeview…  
Loading layout collapseview…  
Loading layout colorpickerview…  
Loading layout countdownview…  
Loading layout datetimelineview…  
Loading layout devicesview…  
Loading layout diffview…  
Loading layout dividerview…  
Loading layout dockcolorview…  
Loading layout dockview…  
Adding Layout chatitemview used by sdui5whatsapp  
Adding Layout chatitemview used by sdui5whatsapp  
Adding Layout chatitemview used by sdui5whatsapp  
Adding Layout conversationitemview used by sdui5whatsapp  
Adding Layout conversationitemview used by sdui5whatsapp  
Adding Layout chatitemview used by sdui5whatsapp  
Adding Layout buttonsview used by pgbuttons  
Adding Layout cardview used by pgcard  
Adding Layout carouselview used by pgcarousel  
Adding Layout chatbubbleview used by pgchatbubble  
Adding Layout checkboxview used by pgcheckbox  
Adding Layout codeview used by pgcode  
Adding Layout collapseview used by pgcollapse  
Adding Layout colorpickerview used by pgcolorpicker  
Adding Layout countdownview used by pgcountdown  
Adding Layout datetimelineview used by pgdatetimeline  
Adding Layout devicesview used by pgdevices  
Adding Layout diffview used by pgdiff  
Adding Layout dividerview used by pgdivider  
Adding Layout dockview used by pgdock  
Adding Layout dockcolorview used by pgdockcolor  
Adding Layout dockxsview used by pgdockxs  
Adding Layout dropdownview used by pgdropdown  
Adding Layout easymdeview used by pgeasymde  
Adding Layout fieldsetview used by pgfieldset  
Adding Layout accordionview used by pgaccordion  
Adding Layout fileinputview used by pgfileinput  
Adding Layout filterview used by pgfilter  
Adding Layout footerview used by pgfooter  
Adding Layout gridview used by pggrid  
Adding Layout gridbuilderview used by pggridbuilder  
Adding Layout groupselectview used by pggroupselect  
Adding Layout heroview used by pghero  
Adding Layout imageview used by pgimage  
Adding Layout baselayout used by pgindex  
Adding Layout alertview used by pgalert  
Adding Layout indicatorview used by pgindicator  
Adding Layout infoboxview used by pginfobox  
Adding Layout inputview used by pginput  
Adding Layout joinview used by pgjoin  
Adding Layout jsoneditorview used by pgjsoneditor  
Adding Layout jsonview used by pgjsonquery  
Adding Layout jsontreeview used by pgjsontree  
Adding Layout kbdview used by pgkbd  
Adding Layout labelview used by pglabel  
Adding Layout linkview used by pglink  
Adding Layout avatarview used by pgavatar  
Adding Layout listview used by pglist  
Adding Layout listviewitem1 used by pglist  
Adding Layout listviewitem3 used by pglist  
Adding Layout listviewitem2 used by pglist  
Adding Layout loadingview used by pgloading  
Adding Layout menuview used by pgmenu  
Adding Layout menu1view used by pgmenu1  
Adding Layout modalview used by pgmodal  
Adding Layout navbarview used by pgnavbar  
Adding Layout paginationview used by pgpagination  
Adding Layout phoneview used by pgphone  
Adding Layout prefbuilderview used by pgpreferencebuilder  
Adding Layout preferenceview used by pgpreferences  
Adding Layout badgeview used by pgbadge  
Adding Layout progressview used by pgprogress  
Adding Layout radialprogressview used by pgradialprogress  
Adding Layout radioview used by pgradio  
Adding Layout rangeview used by pgrange  
Adding Layout ratingview used by pgrating  
Adding Layout selectview used by pgselect  
Adding Layout signaturepadview used by pgsignaturepad  
Adding Layout skeletonview used by pgskeleton  
Adding Layout stackview used by pgstack  
Adding Layout statview used by pgstat  
Adding Layout bottomdrawerview used by pgbottomdrawer  
Adding Layout statusview used by pgstatus  
Adding Layout stepsview used by pgsteps  
Adding Layout svgview used by pgsvg  
Adding Layout swapview used by pgswap  
Adding Layout tableview used by pgtable  
Adding Layout tableview used by pgtable2  
Adding Layout tableview used by pgtable3  
Adding Layout tablebuilderview used by pgtablebuilder  
Adding Layout tabsview used by pgtabs  
Adding Layout textareaview used by pgtextarea  
Adding Layout breadcrumbsview used by pgbreadcrumbs  
Adding Layout timelineview used by pgtimeline  
Adding Layout toastview used by pgtoast  
Adding Layout toggleview used by pgtoggle  
Adding Layout tooltipview used by pgtooltip  
Adding Layout treespiderview used by pgtreespider  
Adding Layout trendview used by pgtrendcharts  
Adding Layout typographyview used by pgtypography  
Adding Layout validationview used by pgvalidation  
Adding Layout whatsappview used by pgwhatsapp  
Adding Layout windowview used by pgwindow  
Adding Layout browserview used by pgbrowser  
Adding Layout wizardview used by pgwizard  
Adding Layout wizard1 used by pgwizard  
Adding Layout wizard2 used by pgwizard  
Adding Layout wizard3 used by pgwizard  
Adding Layout wizard4 used by pgwizard  
OPTIMISATION: 5513 method(s) appear to be unused. You should set RemoveDeadCode=True to speed up the WebApp considerably!  
OPTIMISATION: 13 class(es) appear to be unused. You should set RemoveDeadCode=True to speed up the WebApp considerably!  
Copying CSS files to WebApp assets…  
Copying Javascript files to WebApp assets…  
Copying ES6 Modules to WebApp assets…  
Building C:\laragon\www\sd5demo\index.html  
OPTMIZATION TIPS  
———————-  
You are using A LOT of seperate CSS and JS files! This demands a lot of server roundtrips which can slow down your website/webapp considerably  
This results in fewer page views, a decreased customer satisfaction and ultimately a loss in sales conversions  
EnableLiveCodeSwapping ignored.  Only applicable for Build in Debug mode.  
—————————————————————————————-  
BANano detected over 1981.7KB of UNUSED TRANSPILED CODE in the WebApp!  
Activate the RemoveDeadCode in TranspilerOptions to speed up the WebApp considerably.  
—————————————————-  
BANano v9.11: conversion finished!  
—————————————————-
```

  
  
**Publish Folder**  
  
We run the Demo App, it will generate the needed WebApp to publish to our webserver. This will be the output.  
  
![](https://www.b4x.com/android/forum/attachments/163637)  
  
**Demo Running in Browser**  
  
If all goes well, your browser should be showing this…  
  
![](https://www.b4x.com/android/forum/attachments/163638)  
  
**Deploying your WebApp**  
  
We will build webapps/websites that will be generated by BANano and then output generated. What will be deployed to your webserver, is what was generated and published by BANano as indicated above. This is how our Demo App was deployed to Vercel and is now running here.  
  
<https://sithaso-daisy5.vercel.app/>  
  
**Related Content**  
  

1. SithasoDaisy5 is built using the MIT based TailwindCSS Component Library [Daisy](https://daisyui.com/)
2. SithasoDaisy5 needs the MIT based JavaScript Library named [TailwindCSS](https://tailwindcss.com/)
3. Internal to SithasoDaisy5, there are other JavaScript Libraries sourced from the Web. Thanks to the developers of those libraries as they made this possible.