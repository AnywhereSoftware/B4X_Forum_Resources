### [B4j] CmdTwain Wrapper by stevel05
### 08/12/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/142247/)

This is a B4xlib to control the free command line Twain Scanning app [CmdTwain](http://www.gssezisoft.com/main/cmdtwain/) via jShell. (Windows Only)  
  
It allows selecting a scanner and controlling scanning options, Partial page scanning is particularly useful. You can also select jpg, bmp or pdf outputs. Not all parameters are supported on all scanners. For instance, Black and White and Grayscale scanning is not supported on my Canon MG5750 All in one, but is supported on my older Epson V200. The CmdTwain help page is [here](http://www.gssezisoft.com/Products/CmdTwain/Help/cmdtwain.html).  
  
Basic scanning is pretty simple, you just need to provide the path to the CmdTwain executable and an output file. It uses default parameters "PAPER A4 DPI 200 RGB" and they give you an A4 sized scan at 200 dots per inch in colour. You can override one or all of the default parameters,  
  

![](https://www.b4x.com/android/forum/attachments/132324) ![](https://www.b4x.com/android/forum/attachments/132325) ![](https://www.b4x.com/android/forum/attachments/132326)

  
  
**Usage**  
  
Download and install the CmdTwain app from their [main page](http://www.gssezisoft.com/main/cmdtwain/).  
Update the ST.ScanTwainPath call with your installation path if required (Default is "C:\Program Files (x86)\GssEziSoft\CmdTwain").  
Update the ST.OutputFullPath with your target output file.  
  
**Comments**  
  
I haven't been able to test all of the parameters as my scanners do not have a document hopper, so I can't test anything to do with the document feeder.  
  
I only need a simple scan so it serves my purposes well. There is now a simple Gui as a second b4xlib and a demo app - CmdTwainCV-b4xlib / CmdTwainCV-test  
  
**Demo**  
The attached file CmdTwain-test.zip contains a test project and requires the CmdTwain-b4xlib  
  
**Dependencies**  
CmdTwain app [download](http://www.gssezisoft.com/main/cmdtwain/)  
There are no external B4x Dependencies.  
  
Enjoy, and please report any bugs.  
  
**Library Updates**  
V 0.11 - 11 Aug 2022  

- Tidied debug logging.
- Changed Get/SetDPI to accept strings

  
**New demo** - 11 Aug 2022  
  

![](https://www.b4x.com/android/forum/attachments/132382)

  
[INDENT=2]Simple Gui Form and CustomView example as a separate b4xlib and demo app. CmdTwainCV-b4xlib / CmdTwainCV-test.[/INDENT]  
[INDENT=2]Requires CmdTwain-b4xlib V 0.11+[/INDENT]  
[INDENT=2][/INDENT]  
[INDENT=2]**Demo update**[/INDENT]  
[INDENT=2]V0.12 - 12 Aug 2022[/INDENT]  

- Tidied Debug logging
- Renamed layout files to lowercase
- Save Path to CmdTwain executable if changed
- Added Custom dpi option and field
- Added Scan EventListener(Start,Fail,Complete)

[INDENT=2]Download CmdTwainCV-b4xlib and CmdTwainCV-test.zip[/INDENT]