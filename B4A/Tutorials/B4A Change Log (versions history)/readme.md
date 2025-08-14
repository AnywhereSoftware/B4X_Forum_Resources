### B4A Change Log (versions history) by Erel
### 07/16/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/19332/)

**v13.4** - July 16, 2025 - <https://www.b4x.com/android/forum/threads/b4a-v13-4-is-available-for-download.167803/>  

- New command line tools and prepackaged SDK.
- SDK handling improved.
- Many internal libraries updated to support updated SDK.

**v13.3**  - June 9, 2025 - <https://www.b4x.com/android/forum/threads/b4a-v13-3-is-available-for-download.167352/>  

- #Macro attribute. Defined in B4XMainPage or Main modules. Format: <type>, <name>, <link>. Type can be *Title* or *After Save*. More to come in the future. Link is based on the comment link feature: <https://www.b4x.com/android/forum/threads/119897/#content>
Examples:

```B4X
#Macro: Title, B4XOrderedMap Doc, https://www.b4x.com/android/forum/threads/b4x-b4xorderedmap-get-first-item-nth-item-and-last-item.118642/  
#Macro: Title, B4XPages Export, ide://run?File=%B4X%\Zipper.jar&Args=Project.zip  
'open Objects folder after saving project:  
#Macro: After Save, open objects folder, ide://run?File=%WINDIR%\explorer.exe&Args=%PROJECT%\Objects
```

- New command line options for the IDE:
-INI=<ini file path> - allows running the IDE with an alternative INI file. Note that that standard INI file is stored under: C:\Users\<user name>\AppData\Roaming\Anywhere Software\b4xV5.ini
-INI\_<property key here>=<property value>
Example:

```B4X
"c:\Program files\Anywhere Software\b4a\b4a.exe" -INI_CodeTheme=Dark "-INI_TitleNotEmpty=This is the second IDE: $FILE_NAME$"
```

- New TitleEmpty and TitleNotEmpty INI keys. Can be used to customize the main window title. Support three replacement variables: $PRODUCT$ - B4A/B4J…, $FILE\_NAME$ - project name, $FILE\_PATH$ - project path.
- New internal keywords: Initialized and NotInitialized:

```B4X
If Map1 <> Null And Map1.IsInitialized Then … 'boring  
If Initialized(Map1) Then … 'less boring
```

- B4XCollections: new helper methods: EmptyList, EmptyMap, MergeMaps, MergeLists, CreateList, CopyOnWriteMap and CopyOnWriteList.
- Updated internal libraries: XUI Views v2.66, B4XCollections v1.15, Core v13.2.
- Other bug fixes and minor improvements.

**v13.1** - January 13, 2025 - <https://www.b4x.com/android/forum/threads/b4a-v13-1-is-available-for-download.165079/>  
  
This is a small update that fixes the designer issue with Android 15.  
Updated internal libraries: Core v13.01, BCTextEngine v1.96, LiveWallpaper v1.1, SIP v1.02  
New WebView.AllowFileAccess property. It is needed with targetSdkVersion >= 30 to allow file system access.  
#CustomBuildAction arguments are expanded with environment variables and other variables (%PROJECT%, %B4X%, %JAVABIN%, %PROJECT\_NAME% and %ADDITIONAL%): <https://www.b4x.com/android/forum/threads/b4x-comment-links.119897/#content>  
  
**v13.0** - August 26, 2024 - <https://www.b4x.com/android/forum/threads/b4a-v13-0-is-available-for-download.162746/#post-998257>  
  
The Android SDK and the underlying toolchain where updated with preparation for Android 14 (targetSdkVersion=34) requirements.  
Many of the internal libraries and also external libraries were updated and now depend on the latest Android SDK resources.  
  
The new version depends on Java 19.  
Many of the features depend on an updated Android SDK.  
Both are available here: <https://www.b4x.com/b4a.html>  
  
Tutorial about new requirements related to services and targetSdkVersion=34+: [https://www.b4x.com/android/forum/t...getsdkversion-34-and-services.162140/#content](https://www.b4x.com/android/forum/threads/android-14-targetsdkversion-34-and-services.162140/#content)  
  
Note that ExoPlayer (<https://www.b4x.com/android/forum/threads/exoplayer-media3-video-player.158204/>), the ML Kit based libraries and a few others were updated to support the new SDK. Older versions will not work with the new SDK.  
  
The updated Google / Firebase SDK is considerably larger than before. B4A only adds the components that are part of the dependency tree, still you will see an increase in the app size in many cases. There isn't much that can be done about it. In some of the cases you can keep using the old Android SDK, however you might encounter compatibility issues.  
  
  
**v12.8** - December 6, 2023 - <https://www.b4x.com/android/forum/threads/b4a-v12-8-is-available-for-download.157840/>  
  

- Code snippets: <https://www.b4x.com/android/forum/threads/b4x-code-snippets.152450/>
- Important fixes for two issues, one in OkHttpUtils2 that caused requests to fail in some cases and the second related to a behavioral change in Android 14 that could cause the starter service to misbehave.
- Updated libraries: Core v12.8, OkHttpUtils2 v3.04, XUI Views v2.59, XUI v2.32, Network v1.54, NB6 v1.05, SimpleMediaManager v1.14
- Other bug fixes and minor improvements.

  
**v12.5** - June 14, 2023 - <https://www.b4x.com/android/forum/threads/b4a-v12-5-targetsdkversion-33.148501/>  
  

- Default targetSdkVersion set to 33.
- RuntimePermissions library updated with the new and a bit special POST\_NOTIFICATIONS permission: <https://www.b4x.com/android/forum/threads/notifications-permission-with-targetsdkversion-33.148233/>
- New B4XView.Alpha property and SetAlphaAnimated method. These will also be added to B4J and B4i in the next update.
- Debugger improvements including performance improvements and bug fixes.
- B4XLibs modules and files can be overridden. This is done by adding the module or file to the project. The compiler now accepts it and gives higher precedence to the project files.
- New #ModuleVisibility attribute. Value can be Public - default visibility, or B4XLib. B4XLib means that the module methods and fields will not be visible once the module is packed as a b4xlib. Note that it is an IDE feature and is ignored by the compiler (might be changed in the future).
- #ExcludeFromDebugger attribute removed.
- ADB installation allows downgrading apps, based on the #VersionCode value.
- Comment link to go to layout: 'main page layout - ide://goto?Layout=MainPage
- Updated internal libraries: XUI v2.3, RuntimePermissions v1.2, Core v12.5, SimpleMediaManager v1.13, BCTextEngine v1.95, B4XFormatter v1.04, XUI Views v2.56, OkHttpUtils2 v3.02
- Other bug fixes and minor improvements

  
**v12.2** - January 23, 2023 - <https://www.b4x.com/android/forum/threads/b4a-v12-2-is-available-for-download.145649/>  
  

- Receivers: <https://www.b4x.com/android/forum/threads/receivers-and-services-in-2023.145370/#content>
- Home screen widgets and firebase notifications updated to work with receivers.
- StartReceiver, StartReceiverAt methods.
- Run without ADB - when B4A-Bridge is connected, the compiler will not fail if ADB is missing or throwing an error.
- Ctrl + Alt + W closes the current code window.
- OBFUSCATED automatic conditional symbol - note that it is set at compilation time, never during editing.
- Bug fixes and other minor improvements.

  
**v12.0** - November 17, 2022 - <https://www.b4x.com/android/forum/threads/b4a-v12-0-has-been-released.144207/>  
  

- This version brings an updated Android, Google, AndroidX and Firebase SDKs.
- Follow these instructions to update the various components: <https://www.b4x.com/b4a.html>
- Updated libraries: B4XTable v1.23, B4XPages template, FirebaseAdmob2 v3.0, FirebaseAnalytics v3.0, FirebaseAuth v3.0, FirebaseStorage v3.0, FirebaseNotifications v3.0, AppCompat v4.02, USB v1.01, BCTextEngine v1.94, Phone v2.53, GooglePlayBilling v5.0, Core v11.81, NFC v2.02, DesignerUtils v1.04, Facebook v2.01 (external library.
- Bug fixes and minor improvements.

**v11.8** - July 5, 2022 - <https://www.b4x.com/android/forum/threads/b4a-v11-80-is-available-for-download.141578/>  
  

- Designer script extensions: <https://www.b4x.com/android/forum/threads/b4x-designer-script-extensions.141312/#content>
- This is the first 64 bit version of B4A IDE, which means that it will handle better large projects.
It will be installed by default under Program Files\Anywhere Software\B4A.
It will not run on 32 bit Windows. Note that the CPU architecture doesn't affect the compiled apps.- RUNTIME conditional symbol - an automatic symbol that is added during compilation. It can be used to exclude code from the IDE case-corrector.
- Updated libraries: B4XPages v1.11, XUI Views v2.55, BCTextEngine v1.92, XUI v2.2, SMM v1.13.
- New DesignerUtils (DDD) library with a new designer script framework.
- Bug fixes and other minor improvements.

  
  
**v11.5** - March 21, 2022 - <https://www.b4x.com/android/forum/threads/b4a-v11-50-has-been-released.139288/>  

- Optimized dexer replaced with D8 tool.
- Support for targetSdkVersion=31.
- New #ExcludedLib attribute that is required in some cases when multiple native libraries with different versions are referenced.
- Updated internal libraries: OkHttp v1.50, OkHttpUtils2 v3.00, PreoptimizedCLV v1.21, Network v1.53, B4XTable v1.22, KeyValueStore v2.31, SMM v1.12, NB6 v1.02, FirebaseNotifications v2.01, B4XCollections v1.13
- #ExcludedClasses attribute removed.
- Bug fixes and other minor improvements.

  
**v11.2** - December 14, 2021 - <https://www.b4x.com/android/forum/threads/b4a-v11-20-is-available-for-download.136834/>  

- Long hex literal numbers: 0xff00ff00ff00
- New methods: Bit.OrLong / AndLong / XorLong / ShiftLeftLong / ShiftRightLong / NotLong / UnsignedShiftRightLong / ParseLong
- Fix the "incompatible types" warning with the relatively new Json type.
- Json.ToCompactString method.
- Several debugger fixes: crash on startup, missed assignments in some cases, single field objects were not always observable.
- Code editor jumps to a sub when adding an event with the designer, including when the sub already exists.
- Fix issue with compilation of large projects.
- More descriptive errors when a maven artifact is missing, including the artifact origin.
- bundleconfig.json - configuration file that is used when building an AAB package, can be overridden by putting such file in the project folder (you can find the default one in the installation folder).
- SimpleMediaManager (v1.09) is included as an internal library.
- Updated internal libraries: B4XCollections (v1.10), B4XTable (v1.21), B4XPreferencesDialog (v1.75), XUI Views (v2.54), JSON (v1.21), BCTextEngine (v1.92), Core (v11.2), KeyValueStore (v2.31).
- Bug fixes and other minor improvements.