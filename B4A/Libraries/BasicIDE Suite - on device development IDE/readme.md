### BasicIDE Suite - on device development IDE by agraham
### 05/08/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/107975/)

**BasicIDE Suite is now deprecated in favour of the newer BasicIDE Suite 3**  
[BasicIDE Suite 3 - Now further improved | B4X Programming Forum](https://www.b4x.com/android/forum/threads/basicide-suite-3-now-further-improved.130483/)  
  
  
Introduction  
  
The BasicIDE Suite is a significant upgrade to both my previous BasicIDE and BalToBasicIDE projects. As a reminder these projects implement a programming IDE that runs independently of B4A on the device itself. Please read these original postings for a bit of background.  
  
BasicIDE  
<https://www.b4x.com/android/forum/threads/basiclib-interpreter-and-basicide-development-ide-revisited.101419/#content>  
  
BalToBasicIDE  
<https://www.b4x.com/android/forum/threads/baltobasicide-project-template-generator.101631/>  
  
In this latest version the projects have been packaged in a single project folder together with several B4A projects that provide layouts and sample code for use with the BalToBasicIDE. The project folder also includes all the required additional libraries to avoid the need to individually locate them in the forum.  
  
  
BasicIDE Improvements  
  
BasicIDE programs can now have both landscape and portrait variants, can save and restore the state of their views and data, cope with rotation and chain to other BasicIDE programs to implement the equivalent of several Activities in a single application.  
  
The original BasicIDE included almost all the user interaction views and input mechanisms that might be required for a program, albeit in a somewhat austere manner – but that is what I like. Fancy shaped, coloured and animated GUIs are most definitely not my thing.  
  
The IDE editor has been enhanced but it still not up to the standard of a dedicated code editor – there is a limit to what one can do with an EditText. I wish we had a code editor view for B4A.  
  
I have added the obvious omission of a data table view with Table2D together with my ScaleImageView, which I feel is rather better than ImageView for displaying images on a small screen, and ScrollView2D to provide a two way scrolling control. Alternative InputDate2 and InputTime2 dialogs are provided because InputDate and InputTime don't work well in landscape mode owing to bugs in Google’s implementation of them.  
  
Table2D owes a lot to Erels’ original Table View  
<https://www.b4x.com/android/forum/threads/class-tableview-supports-tables-of-any-size.19254/>  
  
and TableV3\_02 by Klaus et al.  
<https://www.b4x.com/android/forum/threads/class-flexible-table.30649/>  
  
Unfortunately I found TableV3\_02 a bit over-complicated for my use and it did not properly behave as I required under dynamic conditions so I took Erel’s original Table code, adapted it to use ScrollView2D and then plundered some code from TableV3\_02 as well as adding bits of my own. The result is a streamlined Table2D Custom View with about one third the lines of code of TableV3\_02, not as capable but elegantly suitable for the austere environment of BasicIDE. You can also use it in B4A projects if you wish. Thanks to all who contributed to TableV3\_02.  
  
Also included is an example of how to run a debugged B4Script program comprising several .b4s files as a standalone application.  
  
  
BalToBasicIDE utility  
  
The BalToBasicIDE B4J project is an extension to Erel's [BalConverter project](https://www.b4x.com/android/forum/threads/b4x-balconverter-convert-the-layouts-files-to-json-and-vice-versa.41623/#content) that converts between the B4Adesigner layout files and JSON format. It has been extended to convert the Json layout file to a BasicIDE .b4s script file.  
  
BalToBasicIDE adds layout code to a BasicIDE .b4s file which can then be moved to the device for further development. By using the B4A Designer to lay out the controls much laborious typing and experimentation on the device can be avoided. The resulting layout can contain both a landscape and a portrait layout and will Autoscale, though in a slightly different manner to B4A, and will also contain and run any designer script in the B4A layout.  
  
There is a Help file for BalToBasicIDE in the Help folder of the BalToBasicIDE project.  
  
  
Download and Installation  
  
The entire suite is too large to upload to the forum and so is available for download from this OneDrive link.  
  
BasicIDE Suite version 1.00  
<https://1drv.ms/u/s!AtB5C8AtMSe-kVElk9iJw-S8KBtt?e=ipbB67>  
  
**UPDATED VERSION 2 OF BASICIDE SUITE AVAILABLE HERE**  
<https://www.b4x.com/android/forum/threads/basicide-suite-2-now-with-on-device-visual-designer.122607>  
  
  
The downloaded archive should be unblocked, right click in File Explorer -> Properties -> General and check Unblock at the lower right corner. This allows Windows to open the .chm help files in the suite.  
  
Extract the archive to a convenient location, not a protected one such as Program Files, and read BasicIDE.chm that is in the BasicIDE project help folder. That should get you on your way.  
  
  
Final Caveats  
  
This is quite a big project and writing code that writes code that runs standalone on the device can be interesting at times. There will probably be bugs! At least you have the entire source code available so you can fix them yourself when you find them :).  
  
Enjoy!