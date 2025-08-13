### B4J Change Log (version history) by Erel
### 03/17/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/37448/)

**v10.2** - March 17, 2025 - <https://www.b4x.com/android/forum/threads/b4j-v10-2-with-support-for-python-is-available-for-download.166169/>  
  

- PyBridge - support for Python libraries.
- Many internal libraries were updated since last release.
- New internal keywords: Initialized and NotInitialized:

```B4X
If Map1 <> Null And Map1.IsInitialized Then … 'boring  
If Initialized(Map1) Then … 'less boring
```

- #CustomBuildAction arguments are expanded with environment variables and other variables (%PROJECT%, %B4X%, %JAVABIN%, %PROJECT\_NAME% and %ADDITIONAL%): <https://www.b4x.com/android/forum/threads/b4x-comment-links.119897/#content>
- LogColors withs in b4xlibs
- Fix for logs encoding issue in Java 19+. Note that the following attribute should be added for the same fix with standalone packages (if the terminal output is important):

```B4X
#PackagerProperty: VMArgs = -Dfile.encoding=UTF-8 -Dsun.stdout.encoding=UTF-8 -Dsun.stderr.encoding=UTF-8
```

- B4XCollections: new helper methods: EmptyList, EmptyMap, MergeMaps, MergeLists, CreateList, CopyOnWriteMap and CopyOnWriteList.
- Panel.LoadLayout no longer deletes the previous tag.

  
**v10.0** - October 16, 2023 - <https://www.b4x.com/android/forum/threads/b4j-v10-0-is-available-for-download.155241/>  

- Code snippets: <https://www.b4x.com/android/forum/threads/b4x-code-snippets.152450/>
- For Each iterator works with Java HashMap and other non-standard maps.
- Image.WriteToStream disposes resources properly.
- IDE shortcut to go to a layout file: 'ide://goto?Layout=MainPage
- New #ModuleVisibility attribute. Value can be Public - default visibility, or B4XLib. B4XLib means that the module methods and fields will not be visible once the module is packed as a b4xlib. Note that it is an IDE feature and is ignored by the compiler (might be changed in the future).
- B4XView.Alpha / SetAlphaAnimated property and method.
- B4XLibs modules and files can be overridden. This is done by adding the module or file to the project. The compiler now accepts it and gives higher precedence to the project files.
- Debugger improvements including performance improvements and bug fixes.
- Ctrl + Alt + W closes the current code window.
- OBFUSCATED automatic conditional symbol - note that it is set at compilation time, never during editing.
- Internal libraries updated since last version released: B4XFormatter v1.04, BCTextEngine v1.95, Xml2Map v1.01, SimpleMediaManager v1.14, jOkHttpUtils2 v3.03, B4XPages v1.12, DesignerUtils v1.04
- Bug fixes and other minor improvements.

  
**v9.80** - July 7, 2022 - <https://www.b4x.com/android/forum/threads/b4j-v9-80-is-available-for-download.141577/>  
  

- Designer script extensions: <https://www.b4x.com/android/forum/threads/b4x-dse-designer-script-extensions.141312/#content>
- jServer 4: <https://www.b4x.com/android/forum/threads/jserver-v4-0-based-on-jetty-11.140437/#content>
Note that the previous version, now named jServer3, is available here: <https://www.b4x.com/android/forum/threads/141323/#content>- New DesignerUtils (DDD) library. This is the beginning of a framework for designer scripts extensions.
- Updated libraries: BCTextEngine v1.92, jCore v9.80, jFX v9.80, jXUI 2.20, SimpleMediaManager v1.13.
- Other minor improvements and bug fixes. Note that scene builder option was removed.

  
**v9.50** - April 25, 2022 - <https://www.b4x.com/android/forum/threads/b4j-v9-50-first-64-bit-version.140171/>  

- First 64 bit IDE!
- TextField (and B4XView) - text alignment.
- RUNTIME conditional symbol - this is an automatic symbol that is added during compilation. It can be used to exclude code from the IDE case-corrector.
- Bug fixes, including a fix for a bug in the logs that caused the IDE to misfunction.

**v9.30** - November 2, 2021 - <https://www.b4x.com/android/forum/threads/b4j-v9-30-is-available-for-download.135672/>  
  

- Long hex literal numbers: 0xff00ff00ff00
- New methods: Bit.OrLong / AndLong / XorLong / ShiftLeftLong / ShiftRightLong / NotLong / UnsignedShiftRightLong / ParseLong
- Fix the "incompatible types" warning with the relatively new Json type.
- Json.ToCompactString method.
- Several debugger fixes: crash on startup, missed assignments in some cases, single field objects were not always observable.
- Code editor jumps to a sub when adding an event with the designer, including when the sub already exists.
- LogColor and "jump to line" feature.
- SimpleMediaManager (v1.08) is included as an internal library.
- Updated internal libraries: jCore (9.30), Json (1.21), B4XPreferencesDialog (1.74), BCTextEngine (1.92), XUI Views (2.53), KeyValueStore (2.31), jRandomAccessFile (2.34)
- Bug fixes and other minor improvements.

  
**v9.10** - July 13, 2021 - <https://www.b4x.com/android/forum/threads/b4j-v9-10-is-available-for-download.132498/>  
  
This update adds two new language features: IIf and As (inline casting).  
  
**v9.00** - June, 3, 2021 - <https://www.b4x.com/android/forum/threads/b4j-v9-00-is-available-for-download.131308/>  

- IDE performance - several cases where the typing speed became slow were fixed. The speed difference in those cases is significant.
- #PackagerProperty can be used multiple times with the same key.
- Internal packager supports packaging non-ui apps (windows only for now). The size of a zipped non-ui package is around 14mb.
- File.DirData / XUI.DefaultFolder on Mac point to ~/Library/Application Support/[AppName] where AppName is the value set with XUI.SetDataFolder. This is similar to the behavior in Windows.
It is required when running packed apps.- b4xlibs - manifest file supports an Extra field. The value is a single line json string. For now it is used in B4J to add #PackagerProperty attributes automatically. It will be used for other features in the future. See XLUtils.b4xlib for an example.
- Fixed several cases where javafx.web module was required even when not using WebView.
- Add existing modules dialog - option to copy module(s) to parent folder.
- New "before packager" custom build action step.
- Other bug fixes and minor improvements.

  
**v8.90** - February 11, 2021 - <https://www.b4x.com/android/forum/threads/b4j-v8-90-is-available-for-download.127548/>  
  

1. Latest version of each library is displayed in the libraries tab. Clicking on the version will take you to the library thread.
2. Find all references feature was rewritten. Previously it couldn't handle more complex cases, where a sub or field are called indirectly.
3. The various IDE notifications also appear in the logs.
4. #CustomBuildAction - direct support for jar files, including Java 11+ UI jars.
5. New %PROJECT\_NAME% file variable for comment links and custom build actions.
6. Updated internal libraries: jXUI, B4XPages, jOkHttpUtils2 and XUI Views.
7. Bug fixes including a fix to a debug issue where process global variables in code modules, packed as b4xlibs, weren't initialized properly.

**v8.80** - December 14, 2020 - <https://www.b4x.com/android/forum/threads/125536/>  
  

- Libraries tab improvements.
- Indicators to help understand the code flow with resumable subs.
- IDE performance improvements related to handling of b4xlibs.
- The deprecated jHttp and jHttpUtils2 libraries were removed.
- OkHttp updated.
- #JavaCompilerPath attribute. Allows setting a JDK other than the one set in the global settings. Syntax: <java version>, <path to javac.exe>. The exact version isn't important.

```B4X
#JavaCompilerPath: 8, C:\Program Files\Java\jdk1.8.0_211\bin\javac.exe
```

- #CustomBuildAction - direct support for jar files, including Java 11+ UI jars.
- Many internal libraries were updated including: B4XDrawer, B4XPages, B4XCollections, XUI Views and jFX.
- New internal libraries: KeyValueStore, BCToast
- Bug fixes and other minor improvements.

  
  
**v8.50** - July 13, 2020 - <https://www.b4x.com/android/forum/threads/b4j-v8-50-has-been-released.120126/#post-751087>  
  

- Project templates: <https://www.b4x.com/android/forum/threads/b4x-projects-templates.119901/>
- Comment links: <https://www.b4x.com/android/forum/threads/b4x-comment-links.119897/>
- New project dialog.
- Other bug fixes and minor improvements.

  
**v8.31** - June 15, 2020 - <https://www.b4x.com/android/forum/threads/b4j-v8-31-has-been-released.119047/>  

- This update includes several bug fixes and updates to internal libraries.
- New internal libraries: B4XPages, PreoptimizedCLV, B4XPreferencesDialog and X2.

  
**v8.30** - May 24, 2020 - <https://www.b4x.com/android/forum/threads/b4j-v8-30-is-available-for-download.118160/#post-739648>  
  

- Support for Java 14. As with Java 11, B4J expects a specific structure. You should download this package (OpenJDK 14 + OpenJFX 14): <https://b4xfiles-4c17.kxcdn.com/jdk-14.0.1.zip>
- Build standalone package - B4JPackager11 is now integrated in the IDE. This makes it simpler to build standalone packages: [Integrated B4JPackager11](https://www.b4x.com/android/forum/threads/integrated-b4jpackager11-the-simple-way-to-distribute-standalone-ui-apps.117880/).
- Add new module - Option to add the new module to the parent folder. This is useful in cross platform projects where the modules are shared between the different platforms.
- Fix for a design issue that existed since B4A v1.0 where in some cases assignment of an object to a variable can also change other variables that point to the same "wrapper".
- New warning:
"Comparison of Object to other types will fail if exact types do not match.
Better to put the object on the right side of the comparison. (warning #35)"
See this post for more information: [https://www.b4x.com/android/forum/t...-is-available-for-download.117877/post-737515](https://www.b4x.com/android/forum/threads/b4j-v8-30-beta-is-available-for-download.117877/post-737515).- Several debugger fixes.
- New "contribute" menu item.
- Current selected line, in the search results and other syntax colored lists, is displayed.
- B4XTurtle and BCTextEngine are now internal libraries.
- Latest versions of all internal libraries are included.
- Other bug fixes and minor IDE improvements.

  
**v8.10** - January 29, 2020 - <https://www.b4x.com/android/forum/threads/b4j-v8-10-is-available-for-download.113447/>  

- IDE shows messages about updates.
- Better handling of errors in the IDE.
- Positions and layouts of all windows are preserved.
- Search results font can be configured from Tools - IDE Options - Font Picker.
- Fixes for several bugs in find all references and search features.

  
**v8.00** - November 27, 2019 - <https://www.b4x.com/android/forum/threads/b4j-v8-00-has-been-released.111727/>  
  
I'm happy to release B4J v8.00. This update includes many important IDE improvements.  

- Find all references, quick search and find subs / modules tool windows were rewritten and are now syntax colored, the text is selectable and you can jump directly to the selected position:
![](https://www.b4x.com/basic4android/images/B4J_g4HdOaZwZY.png)- Subs code appears in the quick info windows:
![](https://www.b4x.com/basic4android/images/firefox_gejSUQYiDX.png)
This code is also selectable and clickable.- Show Sub in window:
![](https://www.b4x.com/basic4android/images/B4J_FFeJi3K1dG.png)
Allows showing subs in a floating windows. The text is selectable and clickable.
This can be triggered from all kinds of places including:
![](https://www.b4x.com/basic4android/images/firefox_5S7dmQl9uv.png)
And:
![](https://www.b4x.com/basic4android/images/B4J_HA5KV1VUy1.png)- Warning and errors do not hide other information.
- Copy warnings from list of warnings.
- Generate 'Create Type' Sub.
- Copy events.
- Modules list is saved in lexicographic order to avoid unexpected changes with source control tools.
- Fixed incorrect missing file warning in some cases.
- Resources in implicitly referenced b4x libs are now accessible.
- Other minor improvements and bug fixes.

  
  
  
[SPOILER="Older versions"]  
**v7.80** - September 11, 2019 - <https://www.b4x.com/android/forum/threads/b4j-v7-80-is-available-for-download.109466>  
  

- Support for copying and pasting controls between the platforms: <https://www.b4x.com/android/forum/threads/b4x-sharing-layouts-between-platforms.109296/#content>
- Ctrl + Click in the designer script to select the control.
- Anchors checker: <https://www.b4x.com/android/forum/threads/new-feature-anchors-checker.108805/>
- Generate B4XViews from the designer. Also supports changing the type of already declared variables.
- Improved tool tips, add views from the views tree and other small improvements and bug fixes in the designer.
- Empty lines will not be copied to the clipboard.
- Regions are listed in the subs list.

  
**v7.51 -** June 11, 2019 - <https://www.b4x.com/android/forum/threads/b4j-v7-50-is-available-for-download.106660/>  
  

- Auto bookmarks feature:
![](https://www.b4x.com/basic4android/images/B4J_AUq1iGgJ6q.png)

- Recent code positions and designer layouts appear as tabs in the window title.
- The IDE decides on the list of tabs based on several factors (recency, modifications and others).
- The list is saved together with the project and restored when the project is loaded.
- The window can be dragged directly from the tabs.

- Ctrl + Click on layout files from the code:
![](https://www.b4x.com/basic4android/images/B4i_lh6eQY0UA6.png)- Issue with BaseFolder in command line builder fixed.
- Latest versions of internal libraries are included.
- Bug fixes and other minor improvements.

  
**v7.32** - April 30, 2019 - <https://www.b4x.com/android/forum/threads/b4j-v7-32-is-available-for-download.105345/>  
  
This update fixes several issues related to the compiler optimizations added in v7.3.  
It also includes the latest versions of all internal libraries.  
  
**v7.31** - March 4, 2019 - <https://www.b4x.com/android/forum/threads/b4j-v7-30-is-available-for-download.103370/>  
  

- Faster compilations. More resources can be reused between compilations. This makes following compilations much faster.
- Bookmarks and breakpoints are listed in the modules tree:
![](https://www.b4x.com/basic4android/images/SS-2019-02-26_13.11.17.png)- Auto backup improvements:

- Project is saved before backup, based on the auto save option.
- Project name added to the backup file.
- The project folder is configurable (AutoBackupFolder in the ini file).

- Warning for unused parameters in private, non-event, subs.
- Additional library folder can be configured with a B4X folder for cross platform libraries: <https://www.b4x.com/android/forum/threads/b4x-additional-libraries-folder.103165/>
- #Event declarations appear in the autocomplete list.
- Fix for a long standing issue that caused scope changes of global variables to not always be detected.
- Other bug fixes and minor improvements.

  
**v7.00** - December 31, 2018 - <https://www.b4x.com/android/forum/threads/b4j-v7-0-is-available-for-download.100938/#content>  
  

- b4x libraries: [[new feature] b4x library - a new type of library](https://www.b4x.com/android/forum/threads/100383/#content)

- XUI Views: [[B4X] XUI Views - Cross platform views and dialogs](https://www.b4x.com/android/forum/threads/100836/#content)
- X2 games framework: [[B4X] X2 / XUI2D (Box2D) - Game engine](https://www.b4x.com/android/forum/threads/95208/#content)

- Auto-backups: <https://www.b4x.com/android/forum/threads/new-feature-auto-backups.100010>
![](https://www.b4x.com/basic4android/images/SS-2018-12-03_17.38.53.png)- Support for compiling libraries with Java 11.
- Debugger improvements:
- Fix for issue where resumable sub could show the wrong value for a global variable.
- Fix for issue where the error message points to the wrong module.- Other bug fixes and minor improvements.

  
**v6.80** - November 29, 2018 - <https://www.b4x.com/android/forum/threads/b4j-v6-80-released-with-support-for-java-11.99862/#content>  
  
Adds support for Java 11 and OpenJDK + OpenJFX  
  
**v6.50 -** September 13, 2018 - <https://www.b4x.com/android/forum/threads/b4j-v6-51-has-been-released.97181/>  

- Debugger improvements and bug fixes.
- #CustomBuildAction:

- Support in all modules.
- Support for environment variables.
- New "folders ready" cross platform compilation step. Useful for updating files.

- The list of subs above the code editor was rewritten. It behaves better (doesn't miss key inputs and always jumps to the clicked sub).
- file:// links can be ctrl + clicked.
- BorderColor attribute added to the IDE theme files.
- BitmapCreator v4.18
- XUI2D v0.99
- jOkHttpUtils2 v2.70
- Code editor jumps to the error line when there are Java compilation errors.
- Bug fixes.

  
**v6.30** - May 24, 2018 - <https://www.b4x.com/android/forum/threads/b4j-v6-30-is-available-for-download.93386/>  
  
I'm happy to release B4J v6.30.  
  
This update includes the same debugger optimizations added in B4i v5.00 which significantly improve the performance of resumable subs in debug mode.  

- Debugger optimizations, mainly with resumable subs.
- jServer v3.00 is included. [Jetty](https://github.com/eclipse/jetty.project), the underlying open source project, was updated from 9.4.6 to [9.4.10](https://github.com/eclipse/jetty.project/releases). This is a large update for Jetty with many bug fixes and improvements.

- jServer can now work with Google Conscrypt as the SSL engine. This provides better performance and makes it very simple to configure Http/2: <https://www.b4x.com/android/forum/threads/server-conscrypt-and-http-2.93040/>
There is an issue with the latest version of conscrypt itself. For now it is recommended to use Java 9+ if you want to enable Http/2 (it is simpler than with previous versions).
- File: CopyAsync, Copy2Async, ReadBytes, WriteBytes, ListFilesAsync.
- Node: MouseEntered and MouseExited events.
- Node: PickOnBounds property - sets whether mouse events are intercepted based on the bounds or the non-transparent region.
- Pane\_Touch event - The Touch event is an alternative to the various mouse events. Its signature is the same as B4A and B4i Panel\_Touch event.
- jControlsFX9 - Fix for notifications.
- MenuItem / Menu - ParentMenu property.
- Bit.ArrayCopy - Same as ByteConverter.ArrayCopy.
- XUI v1.70:

- B4XCanvas: DrawPath, DrawPathRotated and MeasureText.
- B4XView: TOUCH\_ACTION constants for the Touch events.
- XUI: Scale property. Always 1 in B4i and B4J. Same as 100dip / 100 in B4A.
- B4XBitmap: Scale property. Always 1 in B4i and B4J. Same as Bitmap.Scale in B4A.
![](https://www.b4x.com/android/forum/attachments/text-gif.67684/)
- Custom class templates. Any library can add class templates.
- jBitmapCreator v3.11 and xCustomListView v1.62 are included as internal libraries.
- IDE:

- Ctrl + Click on class types and custom types.
- Autocomplete improvements.

- Bug fixes and other minor improvements.

  
Backwards compatibility  

- If you previously used Http/2 with the custom bootclasspath then you need to switch to the new method as explained here: <https://www.b4x.com/android/forum/threads/server-conscrypt-and-http-2.93040/>
It is simpler and better.
  
**v6.00** - December 5, 2017 - <https://www.b4x.com/android/forum/threads/b4j-v6-00-has-been-released.86905>  
  
  
Several important components were rewritten to provide more features and better performance:  

- Visual designer properties grid
- Visual designer views tree
- Modules tree (new component)
- Files tree

The major improvements are:  

- Code modules can be loaded from other folders and can be easily shared between projects (including projects targeting other platforms): <https://www.b4x.com/android/forum/threads/b4x-modules-files-groups-and-folders.86587/>
- Modules and file tree support grouping.
- Modules are monitored for external changes.
- Files tree shows the files icons and allows opening the files with external editors: <https://www.b4x.com/android/forum/threads/b4x-external-editors.86592/>
- Modules, files and views can be renamed directly from the relevant tree.
- Full support for drag and dropping files and modules, including support for dragging multiple items.
- B4A services and activities can be shared with B4J. They will be treated as static code modules.
- New options when adding modules:
![](https://www.b4x.com/basic4android/images/SS-2017-11-26_17.30.03.png)
Copy to folder: Copies the module to the project folder (same as the current behavior).
Link - relative path: Adds a link to the module with a relative path. Useful when the folder is under or close to the project folder.
Link - absolute path: Adds a link to the module with an absolute path.- Deleted files are moved to the recycle bin.
- Properties grid and views tree can be filtered.
- Properties grid is much faster and includes new types of editors:
![](https://www.b4x.com/basic4android/images/SS-2017-11-26_17.15.19.png)
![](https://www.b4x.com/basic4android/images/SS-2017-11-26_17.15.53.png)- Better support for version control. Files are only written when the contents are actually changed.
- The modules internal attributes are sorted in lexicographical order to reduce changes.
- Button Click event. The new event replaces the Action event. The Action event still works but doesn't appear in the autocomplete list. The Click event is the same as in B4A and B4i.
- Previous animations are cancelled when a new animation of the same type starts. This behavior is similar to the behavior in B4A and B4i and it makes it much simpler to work with animations.
- jXUI library is now an internal library.
- Debugger hover window is resizable.
- Add New Modules / Existing modules menu items in modules tree.
- Code editor color picker is based on the designer color picker.
- Open file with default program in Files tree. Also works with double click.
- Support for opening multiple files at once.
- Better handling of locked files.
- Bug fixes and other minor improvements.

  
**v5.90 -** September 5, 2017 - <https://www.b4x.com/android/forum/threads/b4j-v5-90-is-available-for-download.83562/>  
  

- Resumable subs can return values with the new ResumableSub type.
- Improvements to auto-complete and auto-format features.
- #CustomBuildAction 3 - after library creation.
- OkHttpUtil2 / OkHttpUtil2\_NONUI libraries updated to v2.62 (source code: <https://www.b4x.com/android/forum/threads/b4x-okhttputils2-ihttputils2-httputils2-source-code.82632>)
- Bug fixes.

  
**v5.82 - July 26, 2017 -** <https://www.b4x.com/android/forum/threads/b4j-v5-80-has-been-released.81876/>  

- Bug fixes.

**v5.80 - July 20, 2017 -** <https://www.b4x.com/android/forum/threads/b4j-v5-80-has-been-released.81876/>  

- Localizable IDE
- The underlying server library (Jetty) was updated to the latest version (9.4.6). This is a major upgrade.
Note that due to security issues, weaker versions of SSL are disabled by default (TLS 1.0 and TLS 1.1). It is possible to [re-enable them](https://www.b4x.com/android/forum/threads/81704/#content) if needed.- New [TreeTableView](https://www.b4x.com/android/forum/threads/treetableview.81611/#content). A combination of TreeView and TableView:
![](https://www.b4x.com/basic4android/images/SS-2017-07-13_16.15.13.png)- Improvements to the layout loading process. It is a bit faster and more flexible (it will be used in the future for a planned cross platform helper library).

**v5.50 - May 8, 2017 -** <https://www.b4x.com/android/forum/threads/dont-wait-for-v5-50-it-is-already-here.79289/>  
  
Support for resumable subs: <https://www.b4x.com/android/forum/posts/498072/>  
  
**v5.00 - March 27, 2017 -** <https://www.b4x.com/android/forum/threads/b4j-v5-00-is-available-for-download.77810/>  
  

- Variables and subs renaming based on the Find All References feature:
![](https://www.b4x.com/android/forum/attachments/rename-gif.53634/)
<https://www.b4x.com/android/forum/threads/first-refactoring-feature.77122/#content>- Form.AlwaysOnTop - Sets the form to be above all windows.
- Better handling of StartMessageLoop / StopMessageLoop methods in debug mode.
- OkHttp B4J library updated and is based on OkHttp v3.5.
- ConnectionPool updated and is based on c3p0 v0.9.5.2.
- Quick search supports replacing including replace in all modules.
- Icon picker - Filter field (supports filtering by name or hex code), names in tool tips.
- jFX.CreateFontAwesome / CreateMaterialIcons methods.
- Fix for size offset in the WYSIWYG window.
- Accordion container:
![](https://www.b4x.com/android/forum/attachments/accordion-gif.53892/)
<https://www.b4x.com/android/forum/threads/accordion-container.77501/>- Pagination container:
![](https://www.b4x.com/android/forum/attachments/pagination-gif.53895/)
<https://www.b4x.com/android/forum/threads/pagination-container.77505/>- Application\_Error - handler for uncaught exceptions: <https://www.b4x.com/android/forum/posts/490852/>
- LogError - Prints to StdErr.
- jServer - CurrentThreadIndex always returns 0 for the main thread.
Fix for single threaded handlers that could become non-responsive after unhandled errors.- Initial support for Java 9. Java 9 is currently in beta version. Not everything is supported yet.
- Find all references - finds references in layout files and CallSub calls.
- Auto format feature:
![](https://www.b4x.com/android/forum/attachments/test-gif.50326/)
The formatting happens when you paste code (can be disabled) or when clicking on Alt + F. In the later case the enclosing sub will be formatted or the selected code if the selected text is not empty.
  
**v4.70 - November 16, 2016** - <https://www.b4x.com/android/forum/threads/b4j-v4-70-is-available-for-download.73115/>  
  

- Integration of FontAwesome and Material Icons fonts: <https://www.b4x.com/android/forum/threads/fontawesome-material-icons-fonts.72908>
![](https://www.b4x.com/basic4android/images/SS-2016-11-09_14.33.14.png)- IDE improvements as in the latest versions of B4A and B4i: <https://www.b4x.com/android/forum/threads/b4i-v3-00-has-been-released.72316/>
- New Spinner control:
![](https://www.b4x.com/basic4android/images/SS-2016-11-09_16.05.56.png)- Regex.Replace method.
- UNIFIED style has been removed due to incompatibility issues. The default style will be used instead.
- #LcdFontSmoothing attribute - The default font smoothing method has been changed. Smaller fonts look smoother. You can set #LcdFontSmoothing to True to use the previous method.
- Bug fixes.

  
  
**v4.50 - August 16, 2016 -** <https://www.b4x.com/android/forum/threads/b4j-v4-50-is-available-for-download.70088/>  
  
New features and improvements:  
  

- Many improvements to the IDE docking framework, especially with floating documents that now behave like regular windows.
- New themes.
- Support for bookmarks:
![](https://www.b4x.com/basic4android/images/SS-2016-08-03_10.04.28.png)- URLs in comments or strings are clickable.
- jControlsFX library was updated to latest version of ControlsFX.
- Gzip compression for server responses (Server.GzipEnabled).
- DosFilter - A filter that helps with protection against denial of service attacks.

```B4X
srvr.AddDoSFilter("/*", Null)
```

See this link for more information: <http://www.eclipse.org/jetty/documentation/9.4.x/dos-filter.html>- RadioButtons added with the designer are grouped automatically based on their parent.
- Bug fixes and other minor improvements.

  
  
**v4.20 - February 16, 2016** - <https://www.b4x.com/android/forum/threads/b4j-v4-20-is-available-for-download.63591/>  
  
  
This version adds support for custom views.  
  
![](https://www.b4x.com/basic4android/images/SS-2016-01-14_16.16.18.png)  
  
More information: [[B4X] Custom Views with Enhanced Designer Support](https://www.b4x.com/android/forum/threads/62488/#content)  
  
Other improvements:  
  
[- CSSUtils](https://www.b4x.com/android/forum/threads/61824/#content) module is now included as a library.  
- OkHttp and jOkHttpUtils2 are also included. There are two versions of jOkHttpUtils2 included. One for UI apps and one for non-ui apps.  
- View.Parent property.  
- Bugs and other minor improvements.  
  
  
v4.00 - December 23, 2015 - <https://www.b4x.com/android/forum/threads/b4j-v4-00-is-available-for-download.61629>  
  
UI Apps  

- DatePicker control
- SplitPane: <https://www.b4x.com/android/forum/threads/splitpane-tutorial.61418/>
- Msgbox, Msgbox2, InputList (accessible through the fx object): <https://www.b4x.com/android/forum/threads/msgbox-inputlist.61461/>
- Shadows (designer feature)
- Support for right to left orientations.
- ContorlsFX library was updated.

Server solutions  
  

- Support for Http/2: <https://www.b4x.com/android/forum/threads/server-http-2-configuration.61416/#post-387504>
- Server library updated to latest version of Jetty

Other  

- Debugger performance improvements.
- IDE bug fixes.

Starting from v4.00 the minimum version for UI apps is Java 8.40 and for server solutions is Java 8 (make sure to update it under Tools - Configure Paths).  
  
  
  
v3.70 - October 14, 2015 - <https://www.b4x.com/android/forum/threads/b4j-v3-70-is-available-for-download.59286/#post-373501>  
  
  

- The main focus in this update is the debugger performance. Several advanced optimizations were implemented and the overall performance, in most cases, should be significantly better.
- BitmapDrawable in the designer supports more options.
- #DebuggerDisableOptimization: <https://www.b4x.com/android/forum/threads/b4j-v3-70-beta-is-available-for-download.58283/#post-366943>
- Bug fixes.

  
v3.60 - August 23, 2015 - <https://www.b4x.com/android/forum/threads/b4j-v3-6-is-available-for-download.57536/>  
  

- Block code completion: <https://www.b4x.com/android/forum/threads/new-feature-blocks-completion.56983/>
- Slider control added to the designer.
- Password mode added to TextField (in the designer).
- ChoiceBox added - This is a simpler version of ComboBox. Currently there is an issue (in JavaFX) with ComboBox and Windows 10. Consider switching to ChoiceBox until this issue is resolved.
- File.DirData - Built in implementation of this code: <https://www.b4x.com/android/forum/threads/data-folder.56874/#content>
In most cases this is the best place to write data.- Form.IsInitialized method.

  
v3.50 - July 29, 2015 - <https://www.b4x.com/android/forum/threads/b4j-v3-50-is-available-for-download.56693/>  
  

- Internal Visual Designer

v3.00 - June 5, 2015  
  
  

- New IDE with many improvements.

v2.80 - February 10, 2015  
  
  

- Support for inline Java code - <https://www.b4x.com/android/forum/threads/inline-java-code.50141/>
- New Smart String literal - <https://www.b4x.com/android/forum/threads/b4x-smart-string-literal.50135/>
- Command line builder - <https://www.b4x.com/android/forum/threads/b4abuilder-b4jbuilder-command-line-compilation.50154/>
- Files list supports drag & drop.
- Clean project option also refreshes the libraries list. Can be accessed with a new shortcut (Ctrl + P).
- New warning for invalid code in the globals subs.
- Class properties are listed in the Find All References tool (F7).

  
v2.50 - December 11, 2014  
  
  

- Code obfuscation (same as in [B4A](https://www.b4x.com/android/forum/threads/13773/#content)).
- Rapid debugger memory handling was rewritten to provide better performance and to avoid memory leaks.
- Support for constants: Dim Const x As Int = 2
- New animation methods: SetLayoutAnimated and SetAlphaAnimated:
[MEDIA=youtube]fUkIVHuxCA8[/MEDIA]- IsDevTool keyword.
- Libraries list - Checked libraries are listed at the top of the list.
- Duplicate line shortcut - Ctrl + D.
- AutoComplete shortcut - Ctrl + \ (same as Ctrl + Space).
- Hide other modules option when right clicking on the module header.
- CurrentStatement and breakpoints colors are configurable in the xml file.
- New logo.

  
v2.20 - May 18, 2014  
  
This update includes the new features added in [B4A v3.80](http://www.b4x.com/android/forum/threads/b4a-v3-80-beta-is-released.40750/). The main new features are conditional compilation and build configurations.  
New features and improvements:  
  
  

- Conditional Compilation & Build Configurations: <http://www.b4x.com/android/forum/threads/conditional-compilation-build-configurations.40746/>
- Shared code modules: <http://www.b4x.com/android/forum/threads/shared-code-modules.40747/>
- Project meta file - This file stores "dynamic" project state: modules visibility and order, collapsed nodes, bookmarks and breakpoints. This file should be excluded from source controls.
- Array keyword - The type can be omitted. In that case the array type will be Object. The Array keyword now supports creating empty arrays.
- Debugger can optionally show hexadecimal values.
- Auto complete for layouts and assets files.
- Libraries filter box.
- Server - Correct mime types are set based on the file extension.
- jSQL - Fix for a potential memory leak.
- JQueryElement.SetProp method fixed.
- HttpSession.RemoveAttribute was mistakenly named RemoteAttribute. The method name is fixed.
- Add existing modules supports multiple selection.
- Other minor improvements

  
v2.00 - April 16, 2014  
  

- Web apps framework: [[WebApp] Web Apps Overview](http://www.b4x.com/android/forum/threads/webapp-web-apps-overview.39811/)
- Server library supports ssl (https) connections.
- CreateMap keyword: Allows you to easily create new Maps. For example:
Code:
Dim m AsMap = CreateMap ("key1": value2, "key2": value3)- Json library converts arrays to lists automatically.
Together these two features make it easier to build Json strings. Note that these features will also be included in the next version of Basic4android.- Form events: FocusChanged and IconifiedChanged (minimized)
- SQL library was updated to provide safe multithreaded access to SQLite databases:
[[WebApp] Concurrent access to SQLite databases](http://www.b4x.com/android/forum/threads/webapp-concurrent-access-to-sqlite-databases.39904/)- Bug fixes and other minor improvements.

  
v1.80 - March 14, 2014  
  

- Debugger runtime performance is now close to non-debugged applications.
- Watch Expressions feature:
![](http://www.b4x.com/basic4android/images/SS-2014-02-23_14.48.37.png)- B4J-Bridge - Adds support for remote debugging. This allows you to easily debug your projects on a connected Mac computer or Raspberry Pi board: [Remote debugging with B4J-Bridge](http://www.b4x.com/android/forum/threads/38804/#content)
- Server improvements (tutorials will be available next week):

- Support for user sessions and cookies
- [Custom error pages](http://www.b4x.com/android/forum/threads/server-custom-error-pages.38812/)

  

- Quick Search tool (Ctrl + I) - An index based search tool for quick searching (in all modules):

![](http://img22.imageshack.us/img22/9210/k2v8.png)
- Kill Process button added to allow killing processes in Release mode
- Bit.InputStreamToBytes - Reads the data from an InputStream into an array of bytes
- Bug fixes and other minor improvements.

v1.50 - February 3, 2014  
  
  

- Support for web servers: [Building web servers with B4J](http://www.b4x.com/android/forum/threads/server-building-web-servers-with-b4j.37172/)
- Support for Raspberry Pi computers (and other Linux ARM boards): [B4J and Raspberry Pi boards](http://www.b4x.com/android/forum/threads/b4j-and-raspberry-pi-boards.37019/)
- New types of nodes: ScrollPane and ProgressBar
- TableView - single cell selection mode
- MenuItem.Visibile property
- FocusChanged event added to most nodes
- ListView.ScrollTo method
- Http library authentication mode was fixed
- StopMessageLoop keyword (relevant in server applications)
- #MergeLibraries attribute - Allows skipping of the merging step in Release mode

V1.06 - January 8, 2014  
  
This update fixes a set of bugs and also adds support for TabPane (similar to TabHost or TabControl).  
  
V1.05 - December 11, 2013  
  
  

- TreeView
- HtmlEditor

V1.00 - December 4, 2013  
  
[/SPOILER]