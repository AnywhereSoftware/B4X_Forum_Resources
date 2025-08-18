### Download list of images with HttpUtils2 and CustomListView by Erel
### 12/03/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/26078/)

**Old and irrelevant tutorial. Many better examples, including this one: <https://www.b4x.com/android/forum/threads/b4x-bitmapsasync.119589/>**  
  
  
This example demonstrates an efficient way to download a list of images and show them in a CustomListView.  
  
  
![](http://www.b4x.com/basic4android/images/SS-2013-02-06_14.49.10.png)  
  
The first step is to download the "main" html page: [Lists of Images on Popular Topics (Prints and Photographs Reading Room, Library of Congress)](http://www.loc.gov/rr/print/list/listguid.html#architecture)  
  
The image links are then extracted and downloaded.  
  
The CustomListView items are added after the page is parsed. **The images are added when they are available.**  
  
The links and the images are stored in process global variables. This allows us to reuse these resources instead of downloading them again (after the activity is recreated).  
  
All the downloading code is handled in a service named DownloadListService. It is easier to work with a service compared to an activity as the service life-cycle is much simpler and it doesn't get paused.  
  
CallSubDelayed is used to update the activity whenever there is a new image available. Note that if the activity is currently paused (the user has pressed on the home button for example) then the activity will still be populated correctly.