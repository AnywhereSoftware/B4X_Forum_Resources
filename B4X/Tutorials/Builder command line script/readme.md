###  Builder command line script by Chris Lee
### 06/25/2021
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/131996/)

Hi all,  
  
Attached are txt files that are really windows .bat files. These are to help with building multiple libraries.  
  
If you are building a large project with multiple libraries it can get hard to manage the compilation of everything.  
  
The command line builders are your friend in such cases.   
  
Over time I've built a helper batch file. The main advantage of this is that it will stop trying to compile further projects, if the previous one failed.  
This saves time and makes it more obvious as to which library compilation failed. It also handles the folder issues that the builder has.  
  
Documentation is included in the scripts. You basically set the path to the builder, indicate the list of projects to build and run it.  
  
I've included examples for b4a and b4j, I've not included b4i as I've not tested it, although if may well work ok.  
  
Like I mentioned the files will need to be renamed from .txt files to .bat. files. This is because the forum doesn't allow upload of .bat files.