### ZXingLib by icefairy333 - modified by Johan Schoeman (Scan QR Codes and other 1D/2D Barcodes) by Johan Schoeman
### 11/25/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/49084/)

![](https://www.b4x.com/android/forum/attachments/31000)  
  
See the attached project (**with library files in the /files folder of the project**). This is based on the original work of [EMAIL='I@cefairy333'][USER=24057]@icefairy333[/USER][/EMAIL]. I have modified [EMAIL='I@cefairy333'][USER=24057]@icefairy333[/USER][/EMAIL]'s library so that it can do the following:  
  
1. Set the color of the border of the framing rectangle from B4A code  
2. Set the color of the laser from B4A code  
3. Set the color of the mask around the framing rectangle from B4A code  
4. Set the color of the result points from B4A code  
5. Set the color of the final panel being displayed before control is being returned to the B4A project from B4A code  
6. Ability to switch on/off the torch when making use of the back camera scanner by means of the volume up/down buttons. Use the volume up/down buttons to toggle the torch on/off when the scanner is active.  
  
a. It retains the Portrait /Landscape option as per [USER=24057]@icefairy333[/USER] 's version 1.5 posted in post #1 of his original post.  
b. It retains use of the front / back camera (not sure if it supports all types of devices)  
  
See post #5 for changes that might be required to the Manifest of the project.  
  
Edit: Posting JohanIceFairyZxingWidthMod.zip that will allow you to change the width / height of the ViewFinder. New library files are in the /files folder of the attached project. Replace the old lib files with the new ones.  
  
Edit: Posting JohanIceFairyZxingWidthModAndTextMod.zip that will allow you also add text to the mask around the viewfinder of the scanner.  
  
Edit: Posting JohanIceFairyZxingWidthTextBitmap.zip that will allow you to also add a bitmap to the mask around the viewfinder of the scanner.  
  
Edit: Posting JohanIcefairyZxingWidthTextBitmapTouchTorch.zip that retains all previously added functionality but you can now also switch on/off the flash when using the back camera by either using the volume up/down buttons or just touch the screen while the scanner is active.  
  
Edit: attached file src.zip contains the java source code. It can be compiled into a B4A library with Simple Library Compiler (SLC) as is, provided you set up the directory structure correctly and you set up SLC correctly. See elsewhere in this thread how to do it.  
  
Edit: Attached JohanIcefairyZxingTimeout.zip with all the previously added functionality but adding an option to specify a timeout duration. Default timeout duration is 15 seconds (should you not specify any timeout duration). Also posting src\_2.zip with the amended java source code  
  
eg of Button1\_Click for project in JohanIcefairyZxingTimeout.zip  

```B4X
Sub Button1_Click  
  zx.isportrait = True  
  zx.useFrontCam = False  
  
  'set the timeoutDuration to a very high value (such as 2000000000) if you dont want it to time out  
  '2000000000 = 63 years+  
  zx.timeoutDuration = 30  
  
  'change these factors between 0 and 1 to change the size of the viewfinder rectangle  
  'the library will limit the minimum size to 240 x 240 pixels and the maximum to (screen width) x   (screen height) pixels  
  zx.theViewFinderXfactor = 0.7  
  zx.theViewFinderYfactor = 0.5  
  
  zx.theFrameColor = Colors.Blue  
  zx.theLaserColor = Colors.Yellow  
  zx.theMaskColor = Colors.argb(95, 0, 0, 255)  
  zx.theResultColor = Colors.Green  
  zx.theResultPointColor = Colors.Red  
  
  'set the prompt messages  
  zx.theTopPromptMessage = "This was done……"  
  zx.theTopPromptTextSize = 5%y'text size in pixels  
  zx.topPromptColor = Colors.Red  
  zx.topPromptDistanceFromTop = 1%y'pixel distance from top  
  
  zx.theBottomPromptMessage = "Just for fun……"  
  zx.theBottomPromptTextSize = 5%y'text size in pixels  
  zx.bottomPromptColor = Colors.Blue  
  zx.bottomPromptDistanceFromBottom = 5%y'pixel distance from top  
  
  'add a bitmap  
  zx.theBitMap = bm  
  zx.theBitMapLeft = 40%x  
  zx.theBitMapTop = 10%y  
  zx.theBitMapWidth = 20%x  
  zx.theBitMapHeight = 20%x  
  
  zx.BeginScan("myzx")  
End Sub
```

  
  
Enjoy!