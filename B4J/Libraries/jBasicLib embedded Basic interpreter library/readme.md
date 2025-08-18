### jBasicLib embedded Basic interpreter library by agraham
### 03/14/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/101471/)

Nearly six years ago I posted the original B4A version of this library that was in fact a port to Java from the original Basic4ppc .Net C# version that I wrote even earlier. Shortly after that I gave up Android development out of disgust with Google and returned to playing with Basic4ppc and C# under Windows.  
  
I now find myself back having to use Android for mobile work and have already posted an updated, polished and reasonably documented version for B4A. I now post here a version that will work with B4J.  
  
Download the zip and before extracting it unblock it by right clicking on it in File Explorer, selecting Properties and checking Unblock at the lower right of the General tab otherwise the CHM help files will need to be individually unblocked.  
  
The zip file contains the library jar and xml files and a relatively trivial demo program that does however show how to load, run and monitor a program. At the top level of the zip you will find a Readme.txt file, you know what to do with it (No! Not that! :)).  
  
EDIT: V2.2 includes a very minor change allowing space characters between the Sub name and the left parenthesis of the parameter list.  
Another very minor change allows Resumable Subs to be invoked on the host without error.  
  
EDIT: In light of the slightly renewed interest I've noticed that the B4Script help file is that for the original Basic4ppc version. B4AScript help file now attached is for the BA/B4J versions. The main difference is the Date and Time formatting functions that match Java rather than the .NET original version. Right click and unblock it after downloading it.