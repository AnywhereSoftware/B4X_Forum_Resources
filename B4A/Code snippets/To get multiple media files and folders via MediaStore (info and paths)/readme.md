### To get multiple media files and folders via MediaStore (info and paths) by GeoT
### 03/07/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/146608/)

Hi.  
  
[MEDIA=youtube]65-E7LUttms[/MEDIA]  
  
  
  
First I tried to make a gallery, trying a recursive algorithm to find all the folders with images and/or videos inside. But it takes forever to search.  
  
I then tried to take advantage of the Android Gallery with an ACTION\_GET\_CONTENT intent to select multiple images or videos. But you have no control from where the Gallery starts. It only opens it from the last folder used. Although I managed to get all the real routes with my Android 11. From almost all normal and local starting points.  
  
And I think ContentChooser only allows to choose one file at a time per intent  
  
For more control and less hassle, build these basic samples that work with the Android database through the MediaStore.  
  
The MediaStoreRecents exercise shows the images or thubnails of the recent videos.  
  
The MediaStoreMediaFolders exercise is a simulation of folders that contain images and/or videos, showing the first contained image or thumbnail of the first contained video.  
  
In both exercises, later you would have to put those images in a grid and give them behavior of single or multiple selection, and opening "folders" in the second.  
  
These examples work best in Release mode.  
  
[MEDIA=youtube]B26xcbmMYdM[/MEDIA]  
  
I don't know yet if they will work on all versions of Android, especially from 12. I would appreciate if you could tell me if it didn't work for you with your version.  
  
I couldn't manage to put the LIMIT or OFFSET clauses to the queries.  
  
Any idea to improve the operation of the codes is welcome. Above all to speed up the creation and display of the thumbnails of the videos.  
  
  
Dependencies: the ContentResolver, JavaObject, Reflection, RuntimePermissions and SQL libraries.  
  
  
Regards.