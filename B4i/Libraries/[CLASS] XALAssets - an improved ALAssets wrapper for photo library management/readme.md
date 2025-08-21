### [CLASS] XALAssets - an improved ALAssets wrapper for photo library management by JackKirk
### 11/13/2019
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/82938/)

Hi,  
  
I'm in the middle of a major port B4A=>B4i that needs additional functionality to that supplied by Narek Adonts ALAssets wrapper:  
<https://www.b4x.com/android/forum/threads/alassets-wraps-the-native-alassets-framework-photos.65231/>  
- namely ability to **enumerate photos in a specific album**.  
  
I have shamelessly taken Narek's code as the basis for what follows.  
  
As usual I couldn't resist the temptation to do a major rationalization, tidy up, and documentation on it at the same time.  
  
**Photo library structure**  
  
From playing around with this it would appear that iPhone photo library is structured as follows (at least on my iPhone 5 running 10.3.3):  

- All actual physical photos (e.g. as suppled via MyALAssets.SaveBitmapToAlbum) reside in an album called [Camera Roll], regardless of what you define in Album\_handle parameter of MyALAssets.SaveBitmapToAlbum.
- If you give an Album\_handle parameter to MyALAssets.SaveBitmapToAlbum that was created by MyALAssets.CreateAlbum (or manually?) then that album merely holds a pointer to the actual physical photo stored in [Camera Roll].
- So you can have a photo in multiple albums but only have one physical copy.

**Shortcomings**  

- **Firstly note that the ALAssets framework was deprecated some time ago in favour of PHAsset - someone with some real Objective C skills should put together a PHAsset replacement of this effort.**
- When enumerating photos all you get are photo "handles" which you can plug into various methods:

- there is no mechanism supplied here to tie these handles back to a photos origin info - this might be possible via the metadata stuff but that is way beyond my pay grade.
- so for any bitmaps you put into photo library you will have to maintain your own "origin info" vs "photo handle" correction "photo URL" table - possibly in a Dir…

- For some idiot reason it seems that MyALAssets.CreateAlbum can not recreate an album with a name that has been previously used and subsequently deleted - but you can do this manually in Photo app.

I hope this is of value to someone and sincerely hope it is rapidly superceded by a PHAsset replacement.  
  
Happy coding…  
  
**MAJOR EDIT - please read…**  
  
On implementing this in my own project I discovered that you can not in fact save "photo handles" with the B4i file system.  
  
XALAssets2.Zip has some new features that circumvent this problem:  

- Added GetPhotoURL to create a URL from a photo "handle" (these URL are just strings and therefor can be saved/retrieved by B4i file system).
- Added GetPhotoFromURL to recreate a photo "handle" from its URL so photo can be accessed by its "handle".

**MAJOR UPDATE…**  
  
I have added XALAssets3.zip that handles videos as well as photos.  
  
**SUPERSEDED BY A PHASSETS CLASS - AT LAST!!!…**  
  
See:  
  
<https://www.b4x.com/android/forum/threads/class-photo-management-library-based-on-phasset.110812/>