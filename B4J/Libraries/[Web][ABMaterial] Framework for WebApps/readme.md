### [Web][ABMaterial] Framework for WebApps by alwaysbusy
### 05/17/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/60072/)

**TIP:** **For absolute beginners with ABM,** [**Get started with the Mini Template**](https://www.b4x.com/android/forum/threads/abmaterial-abmserver-mini-template-for-absolute-beginners-update-2024-05-17.117237)  
[SIZE=4]**TIP: [Get started with 'ABMaterial For Dummies' by Harris here! (lessons)](https://www.b4x.com/android/forum/threads/abmaterial-abmaterial-for-dummies-lessons.88346/)  
TIP:** [/SIZE][[SIZE=4]**My mini course on Youtube by MichalK73**[/SIZE]](https://www.b4x.com/android/forum/threads/abmaterial-my-mini-course-on-yt.118693/#post-744612)  
  
ABMaterial is a framework combining a tuned Materialize CSS with the free programming tool B4J. It allows creating WebApps that not only look great thanks to Googles Material Design, but can be programmed with the powerful free tool from Anywhere Software without any knowledge of HTML, CSS or Javascript.  
  
![](http://gorgeousapps.com/ABMDragonfly4.00.png)  
  
ABMaterial has over **45 themeable controls** and some useful helpers**.  
  
Components:**  

- ABMActionButton
- ABMAudioPlayer (1.08)
- ABMBadge
- ABMButton
- ABMCanvas
- ABMCalendar
- ABMCard
- ABMChart (Plugin support 2.00)
- ABMChat (2.50)
- ABMCheckbox
- ABMChronologyList (2.00)
- ABMCombo
- ABMCustomControl (1.05)
- ABMChip
- ABMCodeLabel
- ABMDivider
- ABMDateTimeScroller (1.06)
- ABMDateTimePicker (1.06)
- ABMEditor (1.07)
- ABMFileInput (1.20+)
- ABMGoogleMap
- ABMLabel
- ABMList
- ABMImage
- ABMImageSlider
- ABMInputField
- ABMRadioGroup
- ABMPagination (1.04)
- ABMPatternLock (1.20+)
- ABMPDFViewer (1.08)
- ABMPercentSlider (2.50)
- ABMPlanner (2.50)
- ABMPivotTable (1.08)
- ABMRange (1.05)
- ABMSignaturePad
- ABMTimeLine (1.10, depreciated in 4.00)
- ABMSlider (1.05)
- ABMSmartWizard (3.00)
- ABMSocialShare (1.07)
- ABMSocialOAuth
- ABMSVGSurface (1.20+)
- ABMSwitch
- ABMTabs
- ABMTreeTable (1.04)
- ABMUpload
- ABMVideo

  
**Helpers:**  

- ABMContainer
- ABMFlexWall (1.10)
- ABMGenerator (1.07)
- ABMModalSheet
- ABMNavigationBar
- ABMPage
- ABMParallax
- ABMSideBar (2.00)
- ABMTable
- ABMTableMutable (1.20+)

**Other:**  

- Firebase Auth (1.20+)
- Firebase Storage (1.20+)
- Configurable App and Content folders (2.00)
- Lorem Ipsum Generator (2.00)
- **Grid Builder (2.00+)**

**The Grid Builder:**  
With the Grid Builder you can build the responsive framework very easy. This has been the most difficult part for beginners to understand. But now with the builder, you have no reason to not use ABMaterial :)  
  
![](https://alwaysbusycorner.files.wordpress.com/2016/12/gridbuilder1.png?w=490)  
  
There is an **online demo** at <http://abmaterial.com>  
**Alternative url:** <http://prd.one-two.com:51042/demo/>  
  
> ***NEW:** You can now support BANano and ABMaterial here too:  **<https://www.patreon.com/alwaysbusy>***

  
> [SIZE=5]**ABMaterial is DonationWare**[/SIZE].  
>   
> [Click here ![](https://www.paypalobjects.com/en_US/BE/i/btn/btn_donateCC_LG.gif) if you like to donate](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=WZA72W4ZM9TDC)

  
This means it is free to use, but consider this: it took me already thousands of hours to program ABMaterial, all done in my free time early in the morning and deep into the night. Not only will a donation push me to **continue developing** ABMaterial , remember, you'll get a warm and **fuzzy feeling** doing it!  
  
[SIZE=5]**Download version 5.15 - for jServer 4.00 (open source, library only):  
  
ALWAYS TAKE A BACKUP BEFORE USING A NEW VERSION!**[/SIZE]  
  
ABMaterial 5.15 is now available on github and is **open sourced** :cool: (AS IS)! This version has been in heavy use (development and production) within our company for over a year now without major alterations, so I consider it very stable and ready to be open sourced.  
  
I trust no one here will publish a clone or take credit for my work and I would consider it common courtesy if you find a bug/fix/new feature, you report back to me so I can make the same changes in the official library and everyone can benefit from it.  
  
> Github (source + binary release 5.14): <https://github.com/RealAlwaysbusy/ABMaterial-Source-jServer4.00>

  
**Note:** next to downloading the library, you need also to download the accompanying www zip files from the same github (releases) containing the latest javascript/css/font files.  
  
**The procedure from Github for 5.15:**  
  
> 1. Download <https://github.com/RealAlwaysbusy/ABMaterial-Source-jServer4.00/releases/download/v5.15/ABMaterial5.15-bin.zip>  
> 2. Download <https://github.com/RealAlwaysbusy/ABMaterial-Source-jServer4.00/releases/download/v5.15-www/www5.15.zip>  
> 3. Unzip ABMaterial5.14-bin.zip and copy all .xml and .jar files to you B4J Libraries folder  
> 4. Unzip [www5.14.zip](http://www5.14.zip)  
> 5. In the projects you are working on (e.g. a for Dummies project) delete the following folders in \www  
>
> - css
> - font
> - js
>
> 6. Copy from the unzipped [www5.12.zip](http://www5.12.zip) the 3 folder (css/font/js) to the \www folder where you just deleted these 3 folders.

  
**ALTERNATIVE DOWNLOAD:** Download the ABMMini project where everything is included (Library, www and a Template project):  
<https://www.b4x.com/android/forum/threads/abmaterial-abmserver-mini-template-for-absolute-beginners-update-2024-05-17.117237>  
  
**Additional Resources:**  
  
> ABMGridBuilder (with source code): <https://github.com/RealAlwaysbusy/ABMaterial-Source-jServer4.00/releases/download/v4.00-ABMGridBuilder/ABMGridBuilder.zip>

> Demo source code (for v4.51, not yet updated for 5.15, but still usefull to learn ABM): <https://gorgeousapps.com/ABMExtras4.51.zip>

  
I hope you enjoy it as much as I did creating it and I look forward to see the killer apps you will make with ABMaterial!  
  
> [SIZE=6] Also consider [**BANano**](https://www.b4x.com/android/forum/threads/banano-website-app-wpa-library-with-abstract-designer-support.99740/) if you are planning to write Websites/Apps in B4J![/SIZE]

  
Alain Bailleul  
Alwaysbusy's Corner