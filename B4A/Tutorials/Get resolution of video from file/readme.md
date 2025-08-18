### Get resolution of video from file by Paolodc
### 09/07/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/134084/)

```B4X
    Dim metaRetriver As JavaObject  
    metaRetriver.InitializeNewInstance("android.media.MediaMetadataRetriever", Null)  
    metaRetriver.RunMethod("setDataSource", Array($"${File.Dir}/name.mp4"$))  
    Log("height :"&metaRetriver.RunMethod("extractMetadata", Array(metaRetriver.GetField("METADATA_KEY_VIDEO_HEIGHT"))))  
    Log("width :"&metaRetriver.RunMethod("extractMetadata", Array(metaRetriver.GetField("METADATA_KEY_VIDEO_WIDTH"))))
```

  
  
To detect the orientation of the video we need this field.   

```B4X
Log("ROTATION: "&metaRetriver.RunMethod("extractMetadata", Array(metaRetriver.GetField("METADATA_KEY_VIDEO_ROTATION"))))
```

  
  
For whose are more interested let's look at this forum:  
<https://blog.addpipe.com/mp4-rotation-metadata-in-mobile-video-files/>