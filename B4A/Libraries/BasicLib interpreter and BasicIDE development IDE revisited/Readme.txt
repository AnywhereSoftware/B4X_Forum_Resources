Introduction
------------

Before extracting the BasicIDE.zip project file it should be  unlocked by right clicking on it in File Explorer, selecting Properties and checking Unblock at the lower right of the General tab.

This application requires the BasicLib and CollectionsExtra additional libraries and also the Dialogs, IME, JavaOobject, Phone, Reflection and RuntimePermissions standard libraries. The BasiLib jar and xml files alongside this file in the project folder should be moved to your B4A Additional Libraries folder as should those for CollectionsExtra if they do not already exist.

The BasicIDE project implements a Basic language IDE that runs on a mobile device. Programs may be loaded into the IDE and saved from the IDE to a folder named "BasicIDE" which should be located in the root of the SD card of the Android device. To set up the project follow these instructions.

The following steps are most easily done using the FTP capability of B4A-Bridge. Make a folder "BasicIDE"  in the root of the external memory and copy the *.b4s fles from the project Scripts folder into it. Make a folder "Help" in the device BasicIDE folder and copy BasicIDEScriptHelp.html and B4ScriptHelp.html from the BasicIDE project Help folder into it. Any files located in this Help folder can be selected for display by means of the Help menu item so if you have a CHM viewer on the device you can copy the *.chm files as well.

After setting up as above compile and run BasicIDE on your device. Load (via the Open menu item) and run IdeTest.src to see a somewhat scrappy demo of most of what is implemented in the device IDE. Press both buttons and check the check box in the demo Activity to see more and examine the script.

The IDE menus include "Add Line Nos" and "Remove Line Nos". which do what they imply. When editing a line numbered script there is no need to manually type in any line numbers. After finishing the edit just select "Add Line Nos." again and the script will be renumbered. There is no need to remove the line numbers before running the script and line numbers are never saved with the script.

A reasonably comprehensive set of host platform functions is provided by the BasicIDE Script module for scripts to use, with those functions being modelled as closely as possible on the Basic4android syntax. Additional functions are readily provided by adding them to the Script module of the IDE source where they can be accessed by the "Sys" or "CallHostSub" functions or they can be called as keywords by their name if added to the Script module AddNewSysCalls Sub.

A script consists of an initial code block optionally followed by one or more Subs. This initial code block is called whenever the script activity Activity_Create occurs. "GetFirstTime" returns True when the script is run for the first time. On subsequent invocations of Activity_Create it returns False.

When the script activity pauses the script "Sub activity_pause(userclosed)" is called if it is present. 

When the script activity resumes the script "Sub activity_resume" is called if it is present.

A script with GUI events can terminate itself by calling either the core function "AppClose" and a simle script with noevents can close after running the initial code block by calling "CloseAfterThis" anywhere in that initial code block.

The IDE provides one each of the following predefined objects for scripts to use.
Bitmap,  Canvas, Typeface, InputStream, OutputStream and Timer. These are not limited to a single use and may be re-initialised and reused when required

If necessary a measure of debugging may be obtained by using the Step and Break checkboxes.


Help
----

Look in the Help folder in the project folder for more help. If the compiled help files will not display properly then the BasicIDE.zip file was not unlocked before extraction. Either go back and do that or individually unclock each help file. The compiled help files can be viewed on the device with a suitable app. The author uses 'CHM Viewer ACHM by Peter PingChen' from the appstore but there are others available.

BasicLib.chm documents the methods, properties and events implemented by the BasicLib library object.

B4Script.chm documents the B4Script language implemented by the BasicLib library object.

BasicLibIDE.chm documents the BasicLibIDE B4A project.


There are two help files in a simple html format for use on the device.

B4ScriptHelp.html contains much the same contents as BasicLib.chm and documents the B4Script language implemented by the BasicLib library object.

BasicIDEScriptHelp.html is a help file that documents the B4Script language extensions implemented in the Script module of the BasiciDE project. It was produced from comments in the Script.bas file by running BasicIDEScriptHelp.exe. The formatting of the html file is very simple. Any comment in Script.bas beginning with two apostrophes is output to BasicIDEScriptHelp.html. Any such line beginning "@N:" output with a preceding newline, any such line beginning "@H:" output in bold with a preceding newline, any such line beginning "@" is output in bold. Any other such line is output as-is and so may include further html code if required.
