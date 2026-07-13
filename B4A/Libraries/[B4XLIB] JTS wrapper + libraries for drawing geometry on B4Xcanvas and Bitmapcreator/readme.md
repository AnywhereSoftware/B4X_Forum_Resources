### [B4XLIB] JTS wrapper + libraries for drawing geometry on B4Xcanvas and Bitmapcreator by knutf
### 07/04/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/171452/)

I am happy to share two b4xlibs that makes key parts of JTS (Java Topology Suite) easily accessible in B4J and B4A.  
  
In addition, I am sharing two b4xlibs that make it easy to present JTS geometry on B4Xcanvas and in BitmapCreator, respectively.  
  
The JTS Topology Suite is a Java library for creating and manipulating vector geometry.  
  
Please provide feedback and suggestions.  
  
This is the libraries:  
  
**JTSWrapper.b4xlib**  
This is the main wrapper library.  
It depends on [jna-5.14.0.jar](https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.14.0/). The jar must be in your additional libraries folder and the main module ned to reference it like this:  

```B4X
#AdditionalJar: jna-5.14.0.jar
```

  
  
With this library you can:  

- create geometry in various ways
- retrieve wkb and wkt representation of the geometries
- manipulate the geometries in various ways
- examine interactions between 2 or more geometries (overlap, contain, etc.)
- combine 2 or more geometries in various ways (create collections, union, intersection, etc.)
- search for geometries that are within a defined rectangle (STRtree)

**JTSAffineTransformation.b4xlib**   
This library depends on and are companion to JTSWrapper.b4xlib  
  
With this library you can manipulate the geometries in more advanced wayes. You Build the desired transformation by chaining: Rotate, Scale, Translate, Shear, Reflect, Compose, ComposeBefore, SetTransformation, CreateFromControlVectors, or CreateFromBaseLines. Then you can use the transformation on one or more geometries.  
  
**JTSDrawer.b4xlib**  
This library depends on JTSWrapper.b4xlib  
With this library you can define a drawing style and draw the geometries on a B4XCanvas.  
You specify the coordinates for a viewport into JTS's world and coordinates for a target area on the b4xcanvas for drawing the geometry.  
Then you can use the drawer to draw the geometry as you like.  
  
**JTSBCDrawer.b4xlib**  
This library depends on JTSWrapper.b4xlib and JTSDrawer.b4xlib (It shares the JTSStyle class that belongs to JTSDrawer)  
[Edit]It also depends on version 4.74 of bitmapcreator. While you wait for new versions of B4J and B4A to be released, you can download latest version of bitmapcreator [here](https://www.b4x.com/android/forum/threads/bitmapcreator-drawpath2-arrayindexoutofboundsexception-in-drawwuline.171114/post-1047063).  
The library uses the asynchronous drawing methods of bitmapcreator, but the interface has still been tried to be as similar as possible to JTSDrawer's.  
   
**JTSDemo.zip**  
I have made a demo app. I suggest that if you want to use these libraries you should study the demo app to understand how to use them.  
[Edit]The demo app also depends on version 4.74 of bitmapcreator. While you wait for new versions of B4J and B4A to be released, you can download latest version of bitmapcreator [here](https://www.b4x.com/android/forum/threads/bitmapcreator-drawpath2-arrayindexoutofboundsexception-in-drawwuline.171114/post-1047063).  
  
It is a B4Xpages project that runs on B4A and B4J. You must have all the b4Xlib files attached to this post and  [jna-5.14.0.jar](https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.14.0/). installed in your additional libraries folder  
  
The gif animations below give a small taste of the demo app.  
  
  
Interactive demo of using the libraries to animate geometries. It calculates fps and load on ui thread  
![](https://www.b4x.com/android/forum/attachments/172176)  
  
  
Interactive demo of STRtree  
![](https://www.b4x.com/android/forum/attachments/172177)