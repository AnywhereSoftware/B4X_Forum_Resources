### B4i Change Log (versions history) by Erel
### 05/15/2025
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/47187/)

**v8.90** - May 15, 2025 - <https://www.b4x.com/android/forum/threads/b4i-v8-90-is-available-for-download.167009/>  

- Installation process for full deployments and rapid deployments fixed to work with iOS 18.
- Updated internal libraries: iCore v8.90, iAdMob v4.10, XUI Views v2.66, B4XCollections v1.15, BCTextEngine v1.96.
- Mac builder updated to v9.20
- New internal keywords: Initialized and NotInitialized:

```B4X
If Map1 <> Null And Map1.IsInitialized Then … 'boring  
If Initialized(Map1) Then … 'less boring
```

- #CustomBuildAction arguments are expanded with environment variables and other variables (%PROJECT%, %B4X%, %JAVABIN%, %PROJECT\_NAME% and %ADDITIONAL%): <https://www.b4x.com/android/forum/threads/b4x-comment-links.119897/#content>
- B4XCollections: new helper methods: EmptyList, EmptyMap, MergeMaps, MergeLists, CreateList, CopyOnWriteMap and CopyOnWriteList.
- Build server options: use Apple Configurator is mandatory with local builder and the 32 bit option removed.
- Other bug fixes.

  
**v8.80** - December 4, 2024 - <https://www.b4x.com/android/forum/threads/b4i-v8-80-has-been-released.164471/>  
  
The builder and the IDE were updated to better handle the signing process and now identify and support keys created with newer versions of Java.  
The recommended version of Java is updated to Java 19: <https://www.b4x.com/b4j/files/jdk-19.0.2.zip>  
  
Other changes:  

- Map / CreateMap support Nulls as values.
- #SignKeyFolder and #SignKeyPassword attributes - allow overriding the global settings.
- Switch offColor designer property was removed as it no longer has effect. You can use B4XSwitch as a cross platform alternative that supports more customizations.
- Local builder "ip" field accepts host names.
- Bug fixes, including the long time issue with Chars in smart strings returned as numbers.
- Updated internal libraries: iCore (8.81), iStore (1.22), iUI8 (1.63), MediaChooser (1.02), iCPP (1.0), SimpleMediaManager (1.17), B4XTable (1.24), iEventKey (1.1), iGoogleMaps (1.5),
- Current builder version - 9.10

  
Developers who are eligible for a free upgrade will receive an email with download instructions. Developers who are no longer eligible for free upgrade will receive a renewal offer.  
**v8.50** - January 10, 2024 - <https://www.b4x.com/android/forum/threads/b4i-v8-50-has-been-released.158566/>  

- Code snippets: <https://www.b4x.com/android/forum/threads/b4x-code-snippets.152450/>
- Support for Swift frameworks. Note that Objective C bridge headers are required.
This feature is supported by Xcode 15+. The hosted builders were upgrades to Xcode 15.- IDE shortcut to go to a layout file: 'ide://goto?Layout=MainPage
- New #ModuleVisibility attribute. Value can be Public - default visibility, or B4XLib. B4XLib means that the module methods and fields will not be visible once the module is packed as a b4xlib. Note that it is an IDE feature and is ignored by the compiler.
- B4XView.Alpha / SetAlphaAnimated property and method.
- B4XLibs modules and files can be overridden. This is done by adding the module or file to the project. The compiler now accepts it and gives higher precedence to the project files.
- Debugger improvements including performance improvements and bug fixes.
- Minimum version is iOS 11 or higher.
- Updated libraries: B4XFormatter v1.04, BCTextEngine v1.95, XmlMap v1.01, SimpleMediaManager v1.14, iHttpUtils2 3.04, iFacebook v2.1, XUI Views v2.60, iCore v8.50, XUI v2.30, iAdMob 4.00
- Bug fixes and other small improvements.

**v8.30** - March 28, 2023 - <https://www.b4x.com/android/forum/threads/b4i-v8-30-has-been-released.147083/>  

- Support for Java 14, which is now the recommended version: <https://www.b4x.com/b4j/files/java/jdk-14.0.1.zip>
- Firebase 3.00 / iAdMob 3.00 - based on updated SDKs. This is a large change under the hood. **If using hosted builder, and not using B4i v8.30, then you need to update the internal libraries** in order to compile: <https://www.b4x.com/android/forum/threads/firebase-admob-v3-00.144798/#content>
- Improvement to error logs. The IDE will try to select the relevant message in the long text.
- Map.Put / CreateMap support Nulls as values. This is mostly important for Json.
- Updated libraries: iPhone v2.01, iCore v8.30, iFirebaseAnalytics v3.00, iFirebaseAuth v3.00, iFirebaseStorage v3.00, iFirebaseNotifications v3.00
- Ctrl + Alt + W closes the current code window.
- Bug fixes and other small improvements.

**v8.10** - October 18, 2022 - <https://www.b4x.com/android/forum/threads/b4i-v8-10-released-adds-support-for-xcode-14.143598/>  

- Support for Xcode 14
- Bug fixes

  
**v8.00** - July 19, 2022 - <https://www.b4x.com/android/forum/threads/b4i-v8-00-is-available-for-download.141883/>  
  

- 64 bit IDE. This improves performance, especially with large projects.
- [[B4X] [DSE] Designer Script Extensions](https://www.b4x.com/android/forum/threads/141312/#content). This feature was recently added to B4A and B4J. It allows extending the designer script with new functionalities.
- New DesignerUtils (DDD) library.
- RUNTIME and SIMULATOR conditional symbols.
- Updated libraries: SimpleMediaManager (1.13), iXUI (2.2), iUI9 (1.12), XUI Views (2.55), B4XPages (1.11), xCLV (1.74), B4XCollections (1.13), B4XTable (1.22), PreoptimizedCLV (1.21), iHttpUtils (3.00), B4XPreferencesDialog (1.75), iUI8 (1.62), builder (v8.00).
- Bug fixes and other minor improvements.

  
**v7.80** - October 27, 2021 - <https://www.b4x.com/android/forum/threads/b4i-v7-80-has-been-released.135491/>  
  

- Support for Xcode 13.
- Long hex literal numbers: 0xff00ff00ff00
- New methods: Bit.OrLong / AndLong / XorLong / ShiftLeftLong / ShiftRightLong / NotLong / UnsignedShiftRightLong / ParseLong
- List.SortType - stable sort. This means that equal items retain their order. It allows sorting by multiple fields.
- Fix issue with Unicode sorting and string comparison (<https://www.b4x.com/android/forum/threads/b4x-trie-based-search-dialog.134220/#content>)
- Fix the "incompatible types" warning with the relatively new Json type.
- Json.ToCompactString method.
- Compiler verifies that the certificate and the provision profile match during compilation.
- Several debugger fixes: crash on startup, missed assignments in some cases, single field objects were not always observable.
- Code editor jumps to a sub when adding an event with the designer, including when the sub already exists.
- SimpleMediaManager is included as an internal library.
- Updated internal libraries: iCore (7.80), iJSON (1.21), B4XPreferencesDialog (1.74), BCTextEngine (1.92), XUI Views (2.53), iNet (1.81), KeyValueStore (2.31), iBarcode (1.22)
- Bug fixes and other minor improvements.

  
**v7.50** - July 13, 2021 - <https://www.b4x.com/android/forum/threads/b4i-v7-50-has-been-released.132500/>  
  

- IDE performance - several cases where the typing speed became slow were fixed. The speed difference in those cases is significant.
- IIf - Inline If, also called *ternary if* as it is an operator with three arguments.

```B4X
Label1.Text = IIf(TextField1.Text <> "", TextField1.Text, "Please enter value")
```

- As - Inline casting. Allows inline casting from one type to another**.** Some examples:

```B4X
Dim Buttons As List = Array(Button1, Button2, Button3, Button4, Button5)Dim s As String = Buttons.Get(2).As(B4XView).Text  
Buttons.Get(2).As(B4XView).Text = "abc"  
Dim j As String = $"{"data": {  
"key1": "value1",  
"complex_key2": {  
"key": "value2"  
}  
},  
"items": [0, 1, 2]  
}"$  
Dim parser As JSONParser  
parser.Initialize(j)  
Dim m As Map = parser.NextObject  
Dim value1 As String = m.Get("data").As(Map).Get("key1")  
Dim value2 As String = m.Get("data").As(Map).Get("complex_key2").As(Map).Get("key")  
Dim FirstItemInList As String = m.Get("items").As(List).Get(0)  
For Each item As Int In m.Get("items").As(List)  
Log(item)  
Next  
Root.GetView(8).As(WebView).LoadUrl("https://www.google.com")
```

More information: <https://www.b4x.com/android/forum/threads/b4j-v9-10-is-available-for-download.132498/>- b4xlibs support class templates, this makes it possible to add B4XPages classes from B4i.
- Updated internal libraries: iWebSocket, iFirebaseAuth, iFacebook, iDebug2 and iCore.
- Bug fixes and other minor improvements.

  
**v7.20** - March 11, 2021 - <https://www.b4x.com/android/forum/threads/b4i-v7-20-has-been-released.128509/>  
  

- Libraries index: <https://www.b4x.com/android/forum/threads/b4x-libraries-index.127418/#content>
- Installing apps with Apple Configurator 2: <https://www.b4x.com/android/forum/threads/128397/#content>
- Builder was updated with new Apple intermediate certificate.
- Bug fixes and other minor improvements.

  
**v7.00** - January 28, 2021 - <https://www.b4x.com/android/forum/threads/b4i-v7-00-is-available-for-download.127023/#post-795091>  

- New libraries tab.
- Find all references feature was rewritten and it can now handle complex references.
- The various IDE notifications also appear in the logs.
- #CustomBuildAction - direct support for jar files, including Java 11+ UI jars.
- B4X version of KeyValueStore added as an internal library.
- New indicators to help understand the code flow with resumable subs.
- Updated internal libraries: iMedia, iCore, iFirebaseAnalytics, iFirebaseNotifications, iWebSocket, iXUI, iNetwork, B4XCollections, B4XPages, iHttpUtils2, BCTextEngine, B4XDrawer and XUI Views.
- Project size is displayed in the compilation output.
- Bug fixes and performance improvements (including a significant improvements related to projects with many b4xlibs).
- Xcode 12 is required if using a local builder.

  
**v6.80** - July 13, 2020 - <https://www.b4x.com/android/forum/threads/b4i-v6-80-has-been-released.120128/>  
  

- Project templates: <https://www.b4x.com/android/forum/threads/119901/#content>
- Comment links: <https://www.b4x.com/android/forum/threads/b4x-comment-links.119897/>
- Add New Module - Option to add the module in the parent folder. Useful for cross platform projects.
- Fix for a bug related to multiple instances of the same class and resumable subs.
- Fix for an issue related to wrappers (same fix as in B4J and B4A).
- New project dialog.
- Updated / new internal libraries: B4XTurtle, B4XPages, XUI Views, BCTextEngine, B4XCollections, B4XDrawer, iEventKit, iXUI, iXUI2D, iAdMob, Firebase, PreoptimizedCLV, B4XTable, iGoogleMaps and iPhone.
- Selected line is visible in the various syntax colored lists.
- Other minor improvements and bug fixes.

  
  
**v6.50** - March 2, 2020 - <https://www.b4x.com/android/forum/threads/b4i-v6-50-has-been-released.114505/>  

- Internal WebView is now based on WKWebView. There is also a new EvaluateJavaScript method.
- Launch images were removed and replaced with a launch story board. In most cases you can keep the default white one as apps start very quickly anyway.
With this change the apps will run with the full resolution on all devices.- HttpJob.ErrorMessage returns the server response when there are errors and the response is still available.
- IDE shows messages about available updates:
![](https://www.b4x.com/basic4android/images/B4i_4micCFqKIe.png)- All the IDE windows preserve their layout.
- Search results font can be changed in the font picker dialog.
- Support for Swift frameworks with Xcode 11: <https://www.b4x.com/android/forum/threads/swift-libraries.75691/#content>
- Other minor IDE improvements and bug fixes.

Note that there might be subtle behavior differences between UIWebView and WKWebView. Apple will soon reject apps based on UIWebView so the change is mandatory.  
  
  
[SPOILER="Older versions"]  
**v6.30** - December 12, 2019 - <https://www.b4x.com/android/forum/threads/b4i-v6-30-has-been-released.112121/>  
  

- Find all references, quick search and find subs / modules tool windows were rewritten and are now syntax colored, the text is selectable and you can jump directly to the selected position:
![](https://www.b4x.com/basic4android/images/B4i_l8l9oeqOQK.png)- Subs code appears in the quick info windows:
![](https://www.b4x.com/basic4android/images/firefox_SyafEiBjCQ.png)
This code is also selectable and clickable.- Show Sub in window:
![](https://www.b4x.com/basic4android/images/B4i_2hqlw0sYeQ.png)- Warning and errors do not hide other information.
- Copy warnings from list of warnings.
- Generate 'Create Type' Sub.
- Copy events.
- Modules list is saved in lexicographic order to avoid unexpected changes with source control tools.
- Fixed incorrect missing file warning in some cases.
- Resources in implicitly referenced b4x libs are now accessible.
- BarButton with custom font reserved when clicked.
- DateTime formatters locale is set to en\_US\_POSIX.
Use this code to set it to the device locale (less recommended):

```B4X
Sub SetDateTimeLocaleToDeviceLocale  
Dim loc As NativeObject  
loc = loc.Initialize("NSLocale").GetField("currentLocale")  
Dim no As NativeObject = DateTime  
no.GetField("dateFormat").SetField("locale", loc)  
no.GetField("timeFormat").SetField("locale", loc)  
End Sub
```

- Other minor improvements and bug fixes.

  
Developers who are eligible for a free upgrade will receive an email with the download link. Other developers will receive a discount offer.  
  
  
**v6.00 -** September 16, 2019 - <https://www.b4x.com/android/forum/threads/b4i-v6-00-has-been-released.109607/>  
  

- Support for copying and pasting controls between the platforms: <https://www.b4x.com/android/forum/threads/b4x-sharing-layouts-between-platforms.109296/#content>
- Ctrl + Click in the designer script to select the control.
- Anchors checker: <https://www.b4x.com/android/forum/threads/new-feature-anchors-checker.108805/>
- Generate B4XViews from the designer. Also supports changing the type of already declared variables.
- Improved tool tips, add views from the views tree and other small improvements and bug fixes in the designer.
- Empty lines will not be copied to the clipboard.
- Regions are listed in the subs list:
- Latest versions of Firebase and Facebook libraries. See this thread if using a local Mac: <https://www.b4x.com/android/forum/threads/firebase-facebook-v2-0-july-2019.107435/>

**v5.81 -** June 11, 2019 - <https://www.b4x.com/android/forum/threads/b4i-v5-80-has-been-released.106661/>  
  

- Bookmarks and breakpoints are listed in the modules tree.
- Auto bookmarks feature:
![](https://www.b4x.com/basic4android/images/B4i_xaShiTIuJf.png)

- Recent code positions and designer layouts appear as tabs in the window title.
- The IDE decides on the list of tabs based on several factors (recency, modifications and others).
- The list is saved together with the project and restored when the project is loaded.
- The window can be dragged directly from the tabs.

- Auto backup improvements:

- Project is saved before backup, based on the auto save option.
- Project name added to the backup file.
- The project folder is configurable (AutoBackupFolder in the ini file).

- Warning for unused parameters in private, non-event, subs.
- Additional library folder can be configured with a B4X folder for cross platform libraries: <https://www.b4x.com/android/forum/threads/b4x-additional-libraries-folder.103165/>
- #Event declarations appear in the autocomplete list.
- Ctrl + Click on layout files from the code:
![](https://www.b4x.com/basic4android/images/B4i_lh6eQY0UA6.png)- Fix for a long standing issue that caused scope changes of global variables to not always be detected.
- Compilation performance improvements.
- TextView / TextField SpellChecking property.
- Default launch images for iPhone XS Max and iPhone XR were added.
- #CertificateFile attribute supports absolute paths.
- Debugger improvements.
- Simulator builds with the hosted builder (Tools - Build Server - Build Simulator Release App).
The simulator requires a Mac computer. With this improvement, developers using the hosted builder can make a simulator build, download it and then run it on an online service such as <https://appetize.io/> or on any accessible Mac.- Bug fixes and other minor improvements.

**v5.50** - January 17, 2019 - <https://www.b4x.com/android/forum/threads/b4i-v5-50-has-been-released.101586/>  
  

- b4x libraries: [[new feature] b4x library - a new type of library](https://www.b4x.com/android/forum/threads/100383/#content)

- XUI Views: [[B4X] XUI Views - Cross platform views and dialogs](https://www.b4x.com/android/forum/threads/100836/#content)
- X2 games framework: [[B4X] X2 / XUI2D (Box2D) - Game engine](https://www.b4x.com/android/forum/threads/95208/#content)
- B4XCollections: <https://www.b4x.com/android/forum/threads/101071/#content>
This library is especially useful in B4i as the standard B4i map doesn't preserve the order.
- Auto-backups: <https://www.b4x.com/android/forum/threads/new-feature-auto-backups.100010>
- Go to the code line directly from the logs: <https://www.b4x.com/android/forum/threads/new-feature-go-to-the-code-line-directly-from-the-logs.100090>
- Fix for an issue that caused existing files to be missing at runtime in debug mode.
- Fix for issue with provision profiles and Xcode 10.
- Debugger improvements:
- Fix for issue where resumable sub could show the wrong value for a global variable.
- Fix for issue where the error message points to the wrong module.- XUI v1.90 with B4XView.EditTextHint, SetTextSizeAnimated, XUI.CreateFontAwesome and CreateMaterialIcons methods.
- Other bug fixes and minor improvements.

  
  
**v5.30 -** September 13, 2018 - <https://www.b4x.com/android/forum/threads/b4i-v5-30-has-been-released.97196/>  
  
Improvements:  

- Support for C++ / Objective C++ libraries. This is required for iXUI2D which is based on box2d. More information about XUI2D: <https://www.b4x.com/android/forum/threads/xui2d-example-pack.96454/>
- A QR code appears when building B4i-Bridge. Scan this code with the camera to open the installation link:
![](https://www.b4x.com/basic4android/images/SS-2018-05-28_16.11.03.png)- Many debugger optimizations and bug fixes.
- Bitmap.Crop and Resize methods are more accurate.
- Map.Get properly handles cases where there are Null values. Relevant when parsing json strings with nulls.
- Round method behaves as in B4A and B4J (bankers rounding).
- Internal libraries updated:

- iHttpUtils2 2.70
- iBitmapCreator 4.18
- iXUI2D 0.99
- iXUI 1.70
- iGameView 1.05
- iGoogleMaps 1.41

- "folders ready" custom build action step.
- #CustomBuildAction attribute can be used in all modules.
- #CustomBuildAction file parameter can include environment variables.
- Improvements to the subs list behavior (the one above the code editor).
- Bug fixes and other minor changes.

Developers eligible for free upgrades will receive an email with installation instructions.  
  
**v5.00 -** May 17, 2018 - <https://www.b4x.com/android/forum/threads/b4i-v5-00-has-been-released.93129/#post-589309>  
  

- Resumable subs in debug mode are optimized in the same way other subs are optimized.
- Runtime performance improvements including: for loop optimizations, inlined methods, direct field access for properties and others.
These improvements can make a huge difference in processor intensive tasks.
As an example, the number of drawings per second with [BitmapCreator](https://www.b4x.com/android/forum/threads/b4x-xui-bitmapcreator-pixels-drawings-and-more.92050/#content):
**V4.8:**
Draw smilies from BitmapCreator (skip blending): **81,000 per second**
Draw smilies from BitmapCreator (with blending): **700 per second  
   
 V5.0:**
Draw smilies from BitmapCreator (skip blending): **620,000 per second** (7.5x)
Draw smilies from BitmapCreator (with blending): **20,700 per second** (30x)
In most cases the difference will not be so large but it will still help your programs run faster.- Bit.ArrayCopy and FastArrayGet and Set methods that are useful when very fast access is required: <https://www.b4x.com/android/forum/threads/fast-arrays-access.92951/>
- iXUI library v1.70 with [B4XCanvas.MeasureText](https://www.b4x.com/android/forum/threads/b4x-xui-accurate-text-measurement-and-drawing.92810/#content), DrawPath, DrawPathRotated, XUI.Scale, B4XBitmap.Scale and B4XView.TOUCH constants.
![](https://www.b4x.com/basic4android/images/SS-2018-05-09_13.04.52.png)- xCustomListView and iBitmapCreator are included as internal libraries.
- New File methods: CopyAsync, Copy2Async, ReadBytes, WriteBytes and ListFilesAsync.
- Custom class templates:
![](https://www.b4x.com/basic4android/images/SS-2018-05-17_12.13.17.png)- Support for Xcode 9.3.
- Ctrl + Click on class type (Dim rx As RegexBuilder).
- Autocomplete improvements
- Libraries deprecation messages.
- Other minor improvements including fixes for several debugger issues.

  
**v4.80** - January 16, 2018 - <https://www.b4x.com/android/forum/threads/b4i-v4-80-is-released.88357/#post-559146>  
  
Several important components were rewritten to provide more features and better performance:  

- Visual designer properties grid
- Visual designer views tree
- Modules tree (new component)
- Files tree

The major improvements are:  

- Code modules can be loaded from other folders and can be easily shared between projects (including projects targeting other platforms): <https://www.b4x.com/android/forum/threads/b4x-modules-files-groups-and-folders.86587/>
- Modules and file tree support grouping:
- Modules are monitored for external changes.
- Files tree shows the files icons and allows opening the files with external editors: <https://www.b4x.com/android/forum/threads/b4x-external-editors.86592/>
- Modules, files and views can be renamed directly from the relevant tree.
- Full support for drag and dropping files and modules, including support for dragging multiple items.
- B4A services and activities can be shared with B4J and B4i: <https://www.b4x.com/android/forum/threads/b4x-sharing-modules-and-classes.87478/>
- New options when adding modules:
![](https://www.b4x.com/basic4android/images/SS-2017-12-13_11.24.30.png)
Copy to folder: Copies the module to the project folder (same as the current behavior).
Link - relative path: Adds a link to the module with a relative path. Useful when the folder is under or close to the project folder.
Link - absolute path: Adds a link to the module with an absolute path.- Deleted files are moved to the recycle bin.
- Properties grid and views tree can be filtered.
- Properties grid is much faster and includes new types of editors:
![](https://www.b4x.com/basic4android/images/SS-2017-11-26_17.15.19.png)
![](https://www.b4x.com/basic4android/images/SS-2017-11-26_17.15.53.png)- The modules internal attributes are sorted in lexicographical order to reduce random changes.
- iXUI library is now an internal library.
- Debugger hover window is resizable.
- Add New Modules / Existing modules menu items in modules tree.
- Code editor color picker is based on the designer color picker.
- Open file with default program in Files tree. Also works with double click.
- Support for opening multiple files at once.
- Builder - better handling of certificates changes.
- Compiler error for incorrect calls to resumable subs.
- Hosted builder - prefer secondary builder option. Useful if a builder partially fails.
- Page.SafeAreaInsets - Returns the distances from the four edges that are considered safe. This is relevant for devices such as iPhone X where parts of the screen are hidden.
- NativeObject new methods: MakeEdgeInsets, ArrayFromEdgeInsets, ArrayFromPoint, ArrayFromRect, ArrayFromSize, ArrayFromRange
- Bug fixes and other minor improvements.

  
  
  
**v4.40** - October 23, 2017 - <https://www.b4x.com/android/forum/threads/b4i-v4-40-is-available-for-download.85330/>  

- Xcode 9 compatibility.
- Better managements of icons and launch images: <https://www.b4x.com/android/forum/threads/icons-and-launch-images.84591/#content>

- Icons and launch images are packaged in an assets catalog.
- All missing icons are created automatically from the new 1024x1024 app store icon.

- Known issues with iOS 11 fixed.
- Support for iPhone X layouts.
- iNet library updated to work with Wait For: <https://www.b4x.com/android/forum/threads/84821/#content>
- Other minor improvements and bug fixes.

  
**v4.30 -** September 4, 2017 **-**<https://www.b4x.com/android/forum/threads/83520/#content>  
  

- Localizable IDE. Available in more than 20 languages. A big thank you to the great translators!
- B4i-Bridge supports iOS 11.
- All libraries updated to include a 64 bit simulator binary. This allows testing with iOS 11 simulators.
- Initial support for Xcode 9 beta. There is currently an issue with Swift libraries.
- Builder supports multiple Xcode installations.
- ResumableSub object that allows returning values from resumable subs: <https://www.b4x.com/android/forum/threads/b4x-resumable-subs-that-return-values-resumablesub.82670/>
- New bitmap methods:

- LoadBitmapResize / Bitmap.InitializeResize / Resize - Load and resize a bitmap while optionally preserve the aspect ratio.
- Crop
- Rotate

- iCustomDialog library - Makes it simple to create custom dialogs. Similar to B4A CustomLayoutDialog object. <https://www.b4x.com/android/forum/threads/custom-dialogs-with-icustomdialog-library.83526/>
![](https://www.b4x.com/basic4android/images/SS-2017-09-04_15.45.49.png)- LoadLayout is more flexible and allows setting different types to hold views. This will be used in the future to make the UI related code more cross platform.
- iHttpUtils 2.6 - Job.GetBitmapResize and support for HEAD, PATCH and DELETE requests.
- iStore v1.2 - Purchase.RestoredPurchase property.
- Icon picker - aliases added to FontAwesome icons.
- Auto complete and auto format improvements.
- Bug fixes and other minor improvements.

  
  
**v4.01 -** May 24, 2017 - <https://www.b4x.com/android/forum/threads/b4i-v4-01-is-released.79533/>  
- Fixes an issue with try / catch blocks inside resumable subs.  
  
**V4.00 -** May 15, 2017 - <https://www.b4x.com/android/forum/threads/b4i-v4-00-is-released.79533/>  
  

- Resumable subs - Wait For / Sleep: <https://www.b4x.com/android/forum/threads/resumable-subs-sleep-wait-for.78601/#post-498072>
[[B4X] SQL with Wait For](https://www.b4x.com/android/forum/threads/79532/#content)
[[B4X] OkHttpUtils2 with Wait For](https://www.b4x.com/android/forum/threads/79345/#content)
![](https://www.b4x.com/android/forum/attachments/test-gif.55445/)
Complete code:

```B4X
Sub btn_Click  
Dim b As Button = Sender  
For i = 10 To 0 Step - 1  
b.Text = i  
Sleep(100)  
Next  
b.Text = "Takeoff!"  
End Sub
```

- CSBuilder - Builder for attributed strings. Similar to B4A CSBuilder: <https://www.b4x.com/android/forum/threads/csbuilder-attributedstrings-builder.79153/>
![](https://www.b4x.com/basic4android/images/SS-2017-05-04_17.15.18.png)- Debugger improvements:

- Better handling of multiple installed debug apps.
- Bug fixes and better logging.
- Deployment process improved. Auto installation is now the default.
- SetDebugAutoFlushLogs keyword. When enabled a short pause is added in debug mode when internal logs are printed. This is useful for debugging hard crashes.

- Find all references - Finds usages in layout files and CallSub calls.
- Symbols renaming based on Find all references feature: <https://www.b4x.com/android/forum/threads/first-refactoring-feature.77122/#content>
- Replace from Quick Search (ctrl + F) results.
- Icon Picker - Filter results, name tooltips and search by hex value.
- Auto discovery - The IDE finds devices running B4i-Bridge app automatically:
![](https://www.b4x.com/basic4android/images/SS-2017-05-04_12.40.40.png)- Font.CreateMaterialIcons / CreateFontAwesome methods.
- iNetwork library was updated with fixes related to handling of UDP packets.
- Label / TextView / TextField.AttributedText property. Works together with CSBuilder.
- Page.TitleView - Allows to replace the page title with a custom view (such as a label with attributed string).
- TextView\_LinkClick event. Links are created with CSBuilder.
- Other bug fixes and minor improvements.

  
**V3.60 -** February 26, 2017 - <https://www.b4x.com/android/forum/threads/b4i-v3-60-has-been-released.75928/>  
  
This update adds support for Swift frameworks. This is an important feature as Swift is becoming popular and many open source projects are written in Swift.  
  
More information about such libraries: <https://www.b4x.com/android/forum/threads/swift-libraries.75691/>  
  
There are currently two libraries:  
- [iTopNotifications - Sliding notifications](https://www.b4x.com/android/forum/threads/75923)  
- [iSwiftyButton](https://www.b4x.com/android/forum/threads/75551)  
  
- The IDE now distinguishes between store provision profiles and other profiles and will not try to install applications signed with store profiles.  
- Bug fixes and other minor improvements.  
  
  
**V3.50 -** December 27, 2016 - <https://www.b4x.com/android/forum/threads/b4i-v3-50-has-been-released.74593/>  
  
New features and improvements:  

- Integral support for FontAwesome and MaterialIcons font with more than 1500 icons.
<https://www.b4x.com/android/forum/threads/b4x-fontawesome-material-icons-fonts.72908/#content>
<https://www.b4x.com/android/forum/posts/471169/>- Auto formatting:
![](https://www.b4x.com/android/forum/attachments/test-gif.50326/)- **Support for library compilation**. Allows to compile projects as static libraries.
<https://www.b4x.com/android/forum/threads/compile-as-library.74189/>- iHttpUtils2, iCustomListView, iDateUtils and iCallSubUtils libraries are included in the IDE.
- #ATSEnabled is set to True in new projects. This is a new Apple requirement (<https://www.b4x.com/android/forum/threads/74281/#content>)
- Other minor improvements and bug fixes.

  
**V3.00** - October 25, 2016 - <https://www.b4x.com/android/forum/threads/b4i-v3-00-has-been-released.72316/>  
  
This update includes many IDE improvements as well as other improvements related to iOS 10, Xcode 8 and Mac Sierra.  
  

- The docking and layout features are based on a new and improved framework. Floating code editors behave as regular windows.
- Documentation tool tips while hovering over code elements.
- Copy links in the tool tips that allow copying code examples.
- Support for bookmarks.
- New themes.
- Keychain handling was updated as required by Mac Sierra to allow non-intrusive deployments.
- URLs in comments and strings are ctrl-clickable.
- Unused libraries warning.
- Custom views support "nullable colors".
- #Entitlement attribute. Adds a declaration to the entitlement file. This is a new requirement. For example if your app supports push notifications then you need to add this line (assuming that you are using the distribution key, which you should):

```B4X
#Entitlement: <key>aps-environment</key><string>production</string>
```

**Push notifications will not work on iOS 10 without this declaration.**- #AdditionalLib - Similar to B4A #AdditionalJar attribute. Adds a reference to an external library. Note that third party libraries should be in the builder Libs folder.
- iAdMob - Support for mediation and rewarded video ads.
Mediation: <https://www.b4x.com/android/forum/threads/admob-ads-mediation-with-inmobi.71837/>
Rewarded video ads: <https://www.b4x.com/android/forum/threads/admob-rewarded-video-ads.71839/>- Bug fixes and other minor improvements

**V2.80 -** July 27, 2016 - <https://www.b4x.com/android/forum/threads/b4i-v2-80-is-released.69413/>  
  
This update adds support for Firebase backend services.  
  
The following services are currently supported:  
- Analytics: <https://www.b4x.com/android/forum/threads/68623/#content>  
- Authentication (Google + Facebook): <https://www.b4x.com/android/forum/threads/68625/#content>  
- Notifications / push messages: <https://www.b4x.com/android/forum/threads/firebasenotifications-push-messages-server-not-required.68645/>  
- Storage. See the B4A tutorial: <https://www.b4x.com/android/forum/threads/firebasestorage-simple-file-storage-backend.68350/#content>  
  
The libraries are similar to B4A libraries which makes it simple to implement cross platform solutions.  
  
Other improvements:  
  
- Support for localization of the app name. Tutorial will be available soon.  
- Better support for large projects when working with a local Mac (200mb+).  
- Support for latest version of AdMob framework.  
- Bug fixes and other minor improvements.  
  
**V2.51 -** March 08, 2016 - <https://www.b4x.com/android/forum/threads/b4i-v2-51-is-released.64413/>  
  
This update fixes an issue with certSigningRequest.csr file being rejected by Apple.  
  
**V2.50** - February 15, 2016 - <https://www.b4x.com/android/forum/threads/b4i-v2-50-is-released.63538/>  

- Custom views: [[B4X] Custom Views with Enhanced Designer Support](https://www.b4x.com/android/forum/threads/62488/#content)
- iUI8 library: <https://www.b4x.com/android/forum/posts/397891/>

- WKWebView - Replaces WebView with better performance and more features.
- VisualEffectView - A view that creates a blur effect.
- NavControlExtra - Allows showing and hiding the bars with gestures.
- TableView - Implemented as custom view (replaces iTableView2).

- Faster and smoother startup in release mode.
- Launch images for iPhone 4 are included by default.
- Debugger improvements, especially relevant to large projects.
- It is now possible to override main.m and Project-Info.plist by putting the files in the special folder.
- #Target attribute: Allows targeting iPhone, iPad or both (default).
- #MinVersion: Sets the minimum version. Default value is 7.0.
- #CustomBuildAction: Similar to B4J and B4A attribute. Currently the only step available is 1 (beginning of compilation).
- Notification.NotificationTag - A string that is tied to the notification and can be retrieved when the user clicks on the notification.
- View.Parent - Returns the view's parent.
- Support for native libraries packed as tbd.
- New Google Analytics library.
- TextView / TextField: New SetSelection method. SelectionStart property can be set.
- TextView new events: BeginEdit, EndEdit and TextChanged.
- View.CalcRelativeKeyboardHeight: Important new method that helps with the calculation of the keyboard top point relatively to the current view.
- Bug fixes and other minor improvements.

  
**V2.30 -** October 18, 2015 - <https://www.b4x.com/android/forum/threads/b4i-v2-30-has-been-released.59437/>  

- Advanced optimizations were added to the debugger which significantly improve the debugger performance.
- It is now possible to upload applications to iTunes Connect from the hosted builder.
- Support for Xcode 7.
- PageViewController - Controller that contains multiple Pages and allows the user to switch between the pages with a swipe gesture: <https://www.b4x.com/android/forum/threads/59290/#content>
- Refresh button in the designer files tab. Copies the designer files to the device. This is useful when you modify an existing file.
- #DebuggerDisableOptimization attribute: <https://www.b4x.com/android/forum/threads/b4j-v3-70-beta-is-available-for-download.58283/#content>
- #QueriesSchemes attribute - Due to a new security feature in iOS 9 you need to list all the schemes that your app passes to App.CanOpenURL.
- #ATSEnabled attribute - ATS is a security feature introduced in iOS 9 that prevents apps from accessing non-ssl web servers. This feature is disabled by default. You can enable it with this attribute.
- Deployments improvements related to iOS 9.
- Bug fixes.

  
**V2.00** - July 8, 2015 - <https://www.b4x.com/android/forum/threads/b4i-v2-0-has-been-released.55973/#content>  
  
New IDE. Other improvements:  

- Support for iOS simulator. Note that the simulator is a Mac application so this feature requires using a local builder.
The iOS simulator (unlike the Android emulator) is fast and very convenient to work with.
An Apple account is not needed when working with the simulator.- Smart strings literal: <https://www.b4x.com/android/forum/threads/b4x-smart-string-literal.50135/#content>
- Debug symbols. The release build now includes two new components:

- dsym.zip - <http://stackoverflow.com/questions/3656391/whats-the-dsym-and-how-to-use-it-ios-sdk>
- iTunes Connect symbols inside the ipa file. With these symbols crash reports should be "symbolicated" automatically.

- NavigationController.ShowPage2 / RemoveCurrentPage2 - Allow disabling the transition animation.
- Bug fixes.

**V1.80** - January 21, 2015: <https://www.b4x.com/android/forum/threads/b4i-v1-80-has-been-released.49646/>  
  
New features and improvements:  

- B4i UI Cloud. Similar to B4A UI Cloud. Allows developers to easily test their layout on multiple devices (hosted by Anywhere Software). Currently there are 4 devices: iPad, iPhone 6+, iPhone 5 and iPhone 4.
- Take screenshot feature - While debugging you can take a screenshot of the device (Debug - Take Screenshot). Note that the screenshot only includes the app UI elements. Special elements such as camera preview panel will not appear.
- DatePicker view added.
- Support for inline Objective C code. This is a very important feature as it makes it much easier to extend B4i: <https://www.b4x.com/android/forum/threads/inline-objective-c-code.49095/>
- Bug fixes and other minor improvements.

  
  
**V1.50 -** December 23, 2014: <https://www.b4x.com/android/forum/threads/b4i-v1-50-has-been-released.48537/>  
  
This version adds support for **push notifications** as well as other improvements:  

- Debugger memory handling was rewritten to avoid retaining unnecessary objects. This is very important as it can lead to different behavior between debug mode and release mode.
- Const modifier - Allows declaring constants.
- Performance of 2d arrays was improved.
- #ProvisionFile / #CertificateFile attributes - Make it simpler to work with multiple provisions and certificates: <https://www.b4x.com/android/forum/threads/managing-multiple-certificates-provision-files.48539/>
- Phone.AddImageToAlbum / AddVideoToAlbum methods.
- iArchiver library - Zip / Unzip methods.
- iEncryption - Cipher.Encrypt / Decrypt is compatible with B4A / B4J B4XCipher libraries.
- iRandomAccessFile - WriteB4XObject / ReadB4XObject compatible with B4A / B4J similar methods.
- iNetwork - Support for UDP packets (same API as in B4A / B4J).
- Support for displaying and creating PDF documents: <https://www.b4x.com/android/forum/threads/reading-and-writing-pdf-documents.48308/>
- Build server was updated to allow creating the keystore required for push notifications.
- Bug fixes and other minor improvements.

  
**V1.20** - November 20, 2014: <http://www.b4x.com/android/forum/threads/b4i-v1-20-is-released.47186/>  
  
This version adds support for designer script and auto scale: <http://www.b4x.com/android/forum/threads/designer-script-autoscale-tutorial.47184/>  
  
These features make it much simpler to implement flexible layouts.  
  
Other improvements:  

- List.SortType / SortTypeCaseInsensitive - Sorts a list made of user defined types.
- NativeObject.RunMethodWithBlocks, AsBoolean, AsString and AsNumber methods.
- Phone object - Currently with two methods: SetFlashlight and Vibrate.
- Canvas.DrawRectRotated.
- Bug fixes.

  
**V1.00** - November 12, 2014: <http://www.b4x.com/android/forum/threads/b4i-is-released.46786/>  
[/SPOILER]