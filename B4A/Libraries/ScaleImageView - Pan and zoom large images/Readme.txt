Move ScaleImage.jar, ScaleImageView.jar and ScaleImageView.xml to your Additional Libraries folder.

I can't put a large file in the archive as it becomes too big to upload to the forum, so find your own large image, place it in the File.DirRootExternal & "/Download/" or wherever takes your fancy and adjust filenames in the project to match.

The large image file is opened from a folder in File.DirRootExternal and not in File.DirAssets because ScaleImageView constantly accesses this file to build its image tiles and this is not possible from File.DirAssets.

Tap the Press Me button to open the image and then tap and long press on the image.
Supported gestures are:
    One finger drag to pan
    Two finger pinch to zoom and double tap to zoom in and out.
    Quick scale (one finger zoom) - quick double tap then drag) 

ScaleImageView.htm documents the library.

