###  SimpleMediaManager (SMM) - framework for images, videos and more by Erel
### 05/13/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/134716/)

This is a simple to use, cross platform library, that does many complex things under the hood.  
  
![](https://www.b4x.com/android/forum/attachments/119767)  
  
The developer calls SetMedia with a placeholder panel and a url. The panel will show an image, video or animated gif (more formats will be added).  

```B4X
'Show a remote image / video / animated gif in Panel1  
MediaManager.SetMedia(Panel1, "https://…")
```

  
It uses B4XImageView (or ZoomImageView) for images, B4XGifView for animated gifs, ExoPlayer / MediaView / VideoPlayer for videos and WebView for html or text.  
  
Under the hood features:  

- Maintains a cache of resources.
- Automatically tracks and disposes unused resources.
- Reuses media views and media resources.
- Cancels ongoing http requests when they are no longer relevant.
- Fade-in animation.
- Loading and Error resources. For example, it is simple to show an animated gif while the main resource is loading.
- Images are loaded asynchronously using BitmapsAsync.
- External dependencies are optional.
- And more…

It uses conditional symbols in order to avoid adding dependencies when a feature is not required.  
  
  
[TABLE]  
[TR]  
[TH]

Feature

[/TH]  
  
[TH]

Conditional Symbol

[/TH]  
  
[TH]

Dependencies

[/TH]  
  
[TH]

Mime

[/TH]  
  
[TH]

Comments

[/TH]  
[/TR]  
[TR]  
[TD]Images[/TD]  
[TD][/TD]  
  
[TD]None[/TD]  
[TD]image/\*[/TD]  
[TD][/TD]  
[/TR]  
[TR]  
[TD]Videos[/TD]  
[TD]SMM\_VIDEO[/TD]  
[TD]B4A - [ExoPlayer](https://www.b4x.com/android/forum/threads/exoplayer-mediaplayer-videoview-alternative.72652/#content)  
B4J - [MediaView](https://www.b4x.com/android/forum/threads/134666/#content)  
B4i - iUI8 (internal library)[/TD]  
[TD]video/\*[/TD]  
[TD][/TD]  
[/TR]  
[TR]  
[TD]Animated Gifs[/TD]  
[TD]SMM\_GIF[/TD]  
[TD][B4XGifView](https://www.b4x.com/android/forum/threads/b4x-b4xgifview-cross-platform-animated-gif-view.118550/#content)[/TD]  
[TD]image/gif[/TD]  
[TD]This is also required for non-animated gifs[/TD]  
[/TR]  
[TR]  
[TD]Cancellation of ongoing http requests[/TD]  
[TD]HU2\_PUBLIC[/TD]  
[TD]None[/TD]  
[TD][/TD]  
  
[TD]Not mandatory but you should always add it[/TD]  
[/TR]  
[TR]  
[TD]WebP images[/TD]  
[TD]SMM\_WEBP[/TD]  
[TD][WebP](https://www.b4x.com/android/forum/threads/b4x-webp-images.119990/#content)[/TD]  
[TD]image/webp[/TD]  
[TD]Pay attention to the B4J instructions.  
Android 9+ supports animated WebP images.[/TD]  
[/TR]  
[TR]  
[TD]Proper handling of Jpeg orientation attribute[/TD]  
[TD]SMM\_META (B4J only)[/TD]  
[TD]B4J - see post #3[/TD]  
[TD]image/jpeg[/TD]  
[TD]Also works in B4A / B4i.[/TD]  
[/TR]  
[TR]  
[TD]Debug messages[/TD]  
[TD]SMM\_DEBUG[/TD]  
[TD][/TD]  
  
[TD][/TD]  
  
[TD][/TD]  
[/TR]  
[TR]  
[TD]WebView[/TD]  
[TD][/TD]  
  
[TD]None[/TD]  
[TD]text/\*[/TD]  
[TD][/TD]  
[/TR]  
[TR]  
[TD]Ico images[/TD]  
[TD]SMM\_IMAGE4J (B4J only)[/TD]  
[TD]B4J - see post #8[/TD]  
[TD]image/vnd.microsoft.icon  
image/x-icon[/TD]  
[TD]Natively supported in B4A and B4i[/TD]  
[/TR]  
[TR]  
[TD]ZoomImageView[/TD]  
[TD]SMM\_ZOOM[/TD]  
[TD]ZoomImageView[/TD]  
[TD][/TD]  
  
[TD]Set with REQUEST\_ZOOMIMAGEVIEW[/TD]  
[/TR]  
[/TABLE]  
  
  
Notes:  

- The placeholder panels are expected to be empty from other views. You can reuse a placeholder panel, don't remove the added views in that case.
- SMM was built to work with B4XPages. It wasn't tested and not all features will work in non-B4XPages projects.
- SMM is an internal library.

  
Start with the two examples. More information next week.  
  
**Updates**  
  
- v1.17 - New MaxImageFileSize property that sets the maximum size of image files that will be loaded. Default value is 8mb.  
- v1.16 - Allows adding headers to the http requests. This is done with the new REQUEST\_HEADERS extra field: <https://www.b4x.com/android/forum/threads/b4x-simplemediamanager-smm-framework-for-images-videos-and-more.134716/post-984079>  
- v1.15 - Adds support for HLS video streams (mime = application/vnd.apple.mpegurl). Supported on B4A and B4i.  
- v1.12 - New DefaultRequestTimeout field. Default value is 30000 (=30 seconds).  
- v1.11 - Fixes an issue where a corrupted image can crash the app.  
- v1.10 - Adds support for animated WebP images on Android 9+.  
- v1.09 - Fixes issue with missing layout file.  
- v1.08 - Adds support for showing images with ZoomImageView instead of B4XImageView: <https://www.b4x.com/android/forum/threads/b4x-simplemediamanager-smm-framework-for-images-videos-and-more.134716/post-857972>  
- v1.07 - Adds a SMM\_MediaReady event, that is raised after the media was loaded, the views created and the fade-in effect ended. It requires adding a special parameter to the request.  
Many improvements to the cache management.  
- v1.06 - Fixes an issue where the old WebView content was visible when a WebView was reused.  
- v1.05 - Adds support for web sites and other text that can be displayed with WebView. Adds support for Ico images in B4J (it is natively supported in B4A and B4i).  
- v1.04 - Fixes a bug introduced in v1.03. BitmapsAsync module was added to the library. BitmapsAsync library is no longer required.  
- v1.03 - SetMediaFromFile - new method to load local resources. Don't confuse with AddLocalMedia, which is used to replace the default *loading* and *error* media.  
- v1.02 - Adds support for WebP images.  
- v1.01 - Adds support for handling JPEG orientation attributes. It requires some configuration in B4J. See post #3.