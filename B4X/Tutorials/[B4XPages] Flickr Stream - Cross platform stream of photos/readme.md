###  [B4XPages] Flickr Stream - Cross platform stream of photos by Erel
### 06/11/2021
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/118486/)

**Better to use BitmapsAsync: <https://www.b4x.com/android/forum/threads/b4x-bitmapsasync.119589/#content>**  
  
[MEDIA=vimeo]424762462[/MEDIA]  
  
Example of showing online images, which are downloaded from flickr as the user scrolls the list.  
The list is smooth and works very nice (in release mode).  
  
This example demonstrates several interesting things and I'm pretty sure that most developers will learn a trick or two from the code.  

1. It is cross platform and all the important code is shared between the three projects (<https://www.b4x.com/android/forum/threads/114125/#content>).
2. The program is made of two classes:

- FlickrFeedReader - This class downloads the meta information - FlickrPhotos, and downloads the images when needed. It manages the images cache.
It doesn't show any UI. In B4A, where the UI is recreated together with the activity, the reader is a process global variable that is initialized in the starter service.
It uses a timer that checks the current list index every 100ms and then tests whether the relevant images are available. If not, it downloads the images.- FlickrFeedUI - This class manages the CLV list. In this example the items are only created when the user scrolls the list. This can be useful in all kinds of cases, such as implementations of endless lists. In this case there is a limit of 500 items related to the meta information.
In B4A, the FlickFeedUI is a Global object that is created when the activity is created.
3. Resizing bitmaps is a heavy operation, which is done on the CPU. Instead of resizing the bitmaps we resize the ImageViews to make the image fill the CLV item. This way the operation is hardware accelerated.
4. The CLV implements the good old lazy loading method based on VisibleRangeChanged.
5. The images are cached with B4XOrderedMap from B4XCollections.
When an image is used, we check its current index and move it to the back of the list if needed. Later we will remove "old" images started from the beginning.

```B4X
If DownloadedPhotos.ContainsKey(item.Id) Then  
Dim index As Int = DownloadedPhotos.Keys.IndexOf(item.Id)  
If index < DownloadedPhotos.Size - 10 Then  
'move it to the back of the list  
DownloadedPhotos.Keys.RemoveAt(index)  
DownloadedPhotos.Keys.Add(item.Id)  
End If  
Else If CurrentlyDownloadingIds.Contains(item.Id) = False Then  
DownloadPhoto (item)  
End If
```

6. AnotherProgressBar is displayed whenever there are visible items waiting for images.

  
Note that the feed might include images not appropriate for kids.