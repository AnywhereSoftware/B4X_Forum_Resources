### FilePicker Library for Android Wrapper -InlineJAVA by hongthuanjsc
### 09/18/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/122492/)

A FilePicker library for Android for selecting multiple types of files and also to capture Images and Videos.  
This wrapper of : <https://github.com/jaiselrahman/FilePicker>  
[MEDIA=youtube]GB-ItXdy0lM[/MEDIA]  
  
[SIZE=6]**Configuration:**[/SIZE]  
  
[TABLE]  
[TR]  
[TH]Methods[/TH]  
[TH]Default value[/TH]  
[TH]Uses[/TH]  
[/TR]  
[TR]  
[TD]setShowImages(boolean)[/TD]  
[TD]true[/TD]  
[TD]Whether to load Images files[/TD]  
[/TR]  
[TR]  
[TD]setShowVideos(boolean)[/TD]  
[TD]true[/TD]  
[TD]Whether to load Videos files[/TD]  
[/TR]  
[TR]  
[TD]setShowAudios(boolean)[/TD]  
[TD]false[/TD]  
[TD]Whether to load Audio files[/TD]  
[/TR]  
[TR]  
[TD]setShowFiles(boolean)[/TD]  
[TD]false[/TD]  
[TD]Whether to load Files for given suffixes[/TD]  
[/TR]  
[TR]  
[TD]enableImageCapture(boolean)[/TD]  
[TD]false[/TD]  
[TD]Enables camera for capturing of images[/TD]  
[/TR]  
[TR]  
[TD]enableVideoCapture(boolean)[/TD]  
[TD]false[/TD]  
[TD]Enables camera for capturing of videos[/TD]  
[/TR]  
[TR]  
[TD]setCheckPermission(boolean)[/TD]  
[TD]false[/TD]  
[TD]Whether to request permissions on runtime for API >= 23 if not granted[/TD]  
[/TR]  
[TR]  
[TD]setSuffixes(String…)[/TD]  
[TD]"txt", "pdf", "html", "rtf", "csv", "xml",  
"zip", "tar", "gz", "rar", "7z","torrent",  
"doc", "docx", "odt", "ott",  
"ppt", "pptx", "pps",  
"xls", "xlsx", "ods", "ots"[/TD]  
[TD]Suffixes for file to be loaded, overrides default value[/TD]  
[/TR]  
[TR]  
[TD]setMaxSelection(int)[/TD]  
[TD]-1[/TD]  
[TD]Maximum no of items to be selected, -1 for no limits[/TD]  
[/TR]  
[TR]  
[TD]setSingleChoiceMode(boolean)[/TD]  
[TD]false[/TD]  
[TD]Can select only one file, overrides setMaxSelection(int)  
use setSelectedMediaFile(MediaFile) to set default selection[/TD]  
[/TR]  
[TR]  
[TD]setSelectedMediaFile(MediaFile)[/TD]  
[TD]null[/TD]  
[TD]Default file selection in singleChoiceMode[/TD]  
[/TR]  
[TR]  
[TD]setSelectedMediaFiles(ArrayList<MediaFile>)[/TD]  
[TD]null[/TD]  
[TD]Default files to be marked as selected[/TD]  
[/TR]  
[TR]  
[TD]setSingleClickSelection(boolean)[/TD]  
[TD]true[/TD]  
[TD]Start selection mode on single click else on long click[/TD]  
[/TR]  
[TR]  
[TD]setSkipZeroSizeFiles(boolean)[/TD]  
[TD]true[/TD]  
[TD]Whether to load zero byte sized files[/TD]  
[/TR]  
[TR]  
[TD]setLandscapeSpanCount(int)[/TD]  
[TD]5[/TD]  
[TD]Grid items in landscape mode[/TD]  
[/TR]  
[TR]  
[TD]setPortraitSpanCount(int)[/TD]  
[TD]3[/TD]  
[TD]Grid items in portrait mode[/TD]  
[/TR]  
[TR]  
[TD]setImageSize(int)[/TD]  
[TD]Screen width/portraitSpanCount[/TD]  
[TD]Size of height, width of image to be loaded in Px[/TD]  
[/TR]  
[TR]  
[TD]setRootPath(String)[/TD]  
[TD]External storage[/TD]  
[TD]Set custom directory path to load files from[/TD]  
[/TR]  
[TR]  
[TD]setIgnorePaths(String… ignorePaths)[/TD]  
[TD]null[/TD]  
[TD]Regex patterns of paths to ignore[/TD]  
[/TR]  
[TR]  
[TD]setIgnoreNoMedia(boolean)[/TD]  
[TD]true[/TD]  
[TD]Whether to ignore .nomedia file[/TD]  
[/TR]  
[TR]  
[TD]setIgnoreHiddenFile(boolean)[/TD]  
[TD]true[/TD]  
[TD]Whether to ignore hidden file[/TD]  
[/TR]  
[/TABLE]  
  
  
How to use:  
- Download all AAR and JAR from here <https://www.dropbox.com/s/vg3k1zpnd89v8gw/LibAAR.zip?dl=1>  
(Too BIG for upload attachment)  
- Use Appcompat library 4.0  
- Add to Manifest :  

```B4X
AddApplicationText(<activity  
            android:name="com.jaiselrahman.filepicker.activity.FilePickerActivity"       >  
        </activity>  
    <activity  
            android:name="com.jaiselrahman.filepicker.activity.DirSelectActivity"       >  
        </activity>     
          
        )
```

  
- Config FilePickerConfigurations  
- StartActivityForResult and wait for IOnActivityResult  
- Please use example zip to start it!