### Dialogs2 library - an update to the original Dialogs library by agraham
### 10/07/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/106938/)

**Note the separate download for an updated Dialogs2 class that fixes a bug in the original.**  
  
I wrote the original Dialogs library many moons ago and it has suffered with age owing to the changes made to Android and B4A over the years despite the administrations of several other people.  
  
Although modal dialogs are deprecated in general they are still very convenient for use with my BasicIDE on-device development environment which does not implement Wait For, although there is an ugly workaround. Therefore I have taken the Dialogs v4.01 source code and updated it into a new Dialogs2 library.  
  
Every dialog, except CustomLayoutDialog now supports both Show and ShowAsync. In past editions of B4A events raised by views on a CustomDialog or CustomDialog2 would run while the dialog was shown modally but over the years Erel has had to change the Msgbox mechanism as Android has (d)evolved and now custom dialogs that relied on events from views on the dialog no longer work as expected. For example in the reworked CustomDialog2 example in the DialogsDemo file the ListView ItemClick no longer works when Show is invoked but is fine with ShowAsync while a Button Click works in both cases.  
  
Several of the dialogs would also not work properly in landscape on modern devices with tall narrow screens and higher display densities, I hope they all do now.  
  
The DateDialog and TimeDialog are also problematic in landscape mode which Google doesn't seem to want to fix so I have included alternative TimeDialog2 and DateDialog2 classes in the demo which work for me and hopefully also for you.  
  
EDIT: Dialogs 1.2 Posted. FileDialog now has a TextSize property.  
  
EDIT2: See this link for a fix for a fix to a problem in DateDialog2.  
<https://www.b4x.com/android/forum/threads/dialogs2-library-always-returns-day-1-of-the-month.134884/>  
  
EDIT3: Replace the Dialogs2.bas class in the demo with the separately posted one below to fix the above bug.