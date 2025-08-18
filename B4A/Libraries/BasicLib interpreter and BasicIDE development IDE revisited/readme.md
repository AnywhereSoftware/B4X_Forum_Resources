### BasicLib interpreter and BasicIDE development IDE revisited by agraham
### 05/08/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/101419/)

**BasicIDE is now deprecated in favour of the newer BasicIDE Suite 3**  
[BasicIDE Suite 3 - Now further improved | B4X Programming Forum](https://www.b4x.com/android/forum/threads/basicide-suite-3-now-further-improved.130483/)  
  
  
Nearly six years ago I posted the original B4A versions of this library and project that were in fact a port to Java from the original Basic4ppc .Net C# versions that I wrote even earlier. Shortly after that I gave up Android development out of disgust with Google and returned to playing with Basic4ppc and C# under Windows.  
  
I now find myself back having to use Android for mobile work owing to the now almost total unavailability of small (seven and eight inch) Windows tablets with reasonable amounts of memory and decent performance. In fact even small (seven inch) Android tablets with a decent amount of memory and storage seem to have gone missing from the market :(  
  
I like to be able to actually knock up small ad hoc programs on a mobile device but have found nothing in the Play Store appropriate for my use (apart from perhaps DroidScript but that’s a different discussion). So I got the Basic4Android trunk down from the attic and blew the dust off it.  
  
So in case anyone is interested in playing with it here we have an updated, polished and reasonably documented version of my mobile development environment that is easily customized with your own additions. Download the zip and before extracting it unblock it by right clicking on it in File Explorer, selecting Properties and checking Unblock at the lower right of the General tab otherwise the CHM help files will need to be individually unblocked.  
  
At the top level of the zip you will find a Readme.txt file so I suggest you do just that!  
  
NOTE: This project will not work when run in Release(Obfuscated) mode without renaming all the extension Subs in the Script module to contain underscores. It will also not run with the rapid debugger for reasons described in the help.  
  
NOTE: If on Android 8.1 or later you are getting unwanted underlining in the editor try adding the following two lines to Main.Activity\_Create after the other edtSource property assignments.  

```B4X
edtSource.InputType = 0x00080000 ' TYPE_TEXT_FLAG_NO_SUGGESTIONS  
edtSource.SingleLine = False
```

  
  
I have posted a complementary B4J [BalToBasicIDE project](https://www.b4x.com/android/forum/threads/baltobasicide-project-template-generator.101631/) which can use the .bal layout file from a B4A project to provide a control layout for a BasicIDE project.  
  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
NOTE THAT THIS VERSION OF BASICIDE IS SUPERSEDED BY BASICIDE SUITE HERE  
<https://www.b4x.com/android/forum/threads/basicide-suite-on-device-development-ide.107975/>  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*