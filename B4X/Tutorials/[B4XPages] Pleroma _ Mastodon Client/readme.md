###  [B4XPages] Pleroma / Mastodon Client by Erel
### 02/24/2021
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/119426/)

Roughly speaking, Mastodon is an open source, distributed, social network a bit similar to Twitter:  
<https://joinmastodon.org/>  
  
Pleroma is a lightweight implementation of Mastodon with some extensions: <https://blog.soykaf.com/post/what-is-pleroma/>  
  
![](https://www.b4x.com/basic4android/images/i_view64_FAQWSjENvw.png)  
  
I'm building an open source client for Pleroma / Mastodon. It will be a good demonstration of B4X features. There are already several products that came out of this project, including B4XPages framework, which is one of the most important features added to B4X.  
  
The focus is on the mobile clients. The B4J client is very useful for development.  
  
  
  
It is based on B4XPages and all of the code is shared between the three platforms.  
Most of the code is based on components that can be reused in other apps.  
  
Features:  

- The rich text content is displayed using BCTextEngine + BBListItem. BBListItem is based on BBCodeView, without the ScrollView and built for lazy loading where only the visible lines are drawn.
- The text is drawn asynchronously (in the background).
- The list itself is a xCLV.
- Items are loaded when needed and the layouts are reused.
- A lot of work was done related to images. Loading hundreds of images from the internet with no control on their size is a challenging task.

- Images usage is carefully tracked.
- Unused images are removed from the cache and are recycled in B4A.
- Images are loaded asynchronously in B4A and B4i.
- Images are downsampled if larger than the maximum allowed size.

- The html from the feed is parsed using MiniHtmlParser class. The output is a tree of nodes. The tree is then converted to BBCode (only a few tags are supported).
- Supports images, animated gifs and videos. Video playback is only implemented in B4A and B4i.

Classes:  

- ListOfStatus - A class that manages a list of statuses. Does many things including: managing the feed reader, the status views, the visibility of all elements and the zoomable image view. Note that the list can appear inside a dialog and in the main page.
- B4XMainPage - Main page.
- ImagesCache - Manages the images, including downloading from the internet, managing a cache and updating the reference counters.
- BitmapsAsync - Class that loads images asynchronously (in B4A and B4i). This is now implemented as a library.
- StatusView - The status custom view.
- BBListItem - A modified version of BBCodeView, mainly without the built-in ScrollView which is not needed here.
- MiniHtmlParser - Html parser. Implemented as a library.
- TextUtils - Converts the parsed html data to BBCode.
- PleromaFeed - Downloads and parses the Pleroma / Mastodon feeds.
- ViewsCache - Manages the video players
- RequestsManager - Cross platform class that can be used to cancel currently running HttpJob requests.
- OAuth - Implements the authentication.
- DrawerManager - Manages the left drawer.
- AccountView - Shows the account item. Can appear inside the list or in a dialog.
- StubView - A simple view that can be added to the statuses list (currently only used to show the "no more items" item but can be extended).
- StackManager - Manages the stack of timelines. Used for the implementation of the back feature and more.
- HtmlToRuns - Converts the parsed html tree to text runs for BCTextEngine.

This project depends on several recent libraries. To make things simpler, the cross platform libraries are attached.  
You will also need to download other resources as explained in these links:  
  
- B4XGifView v1.11+: <https://www.b4x.com/android/forum/threads/b4x-b4xgifview-cross-platform-animated-gif-view.118550/>  
- (B4A) ExoPlayer v1.42+: <https://www.b4x.com/android/forum/threads/exoplayer-mediaplayer-videoview-alternative.72652/#content>  
- WebP: <https://www.b4x.com/android/forum/threads/b4x-webp-images.119990/#post-750224>  
- KSCrash (B4i - if using local builder): <https://www.b4x.com/android/forum/threads/kscrash-simple-and-powerful-crash-reports-framework.120644/#content>  
  
  
The performance is very good. Better than several other clients I've tested. Make sure to test performance in release mode.  
  
Compiled APK: [www.b4x.com/android/files/Pleroma.apk](https://www.b4x.com/android/files/Pleroma.apk)  
  
**Warning: Some of the content is for adults only. Don't download if under 18 or are offended from such images. This is a distributed, open source network which means that the content is not moderated.  
Don't post any image in the forum that is not appropriate for kids.**  
  
Source code: <https://github.com/AnywhereSoftware/B4X-Pleroma>