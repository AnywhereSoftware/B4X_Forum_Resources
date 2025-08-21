### Shrinking that SQLite JDBC library! by tchart
### 08/04/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/120883/)

**NOTE**: This isnt recommened for everyone, this is just something that works for me. Removing support for specific platforms could cause your app to stop working.  
  
I use SQLite for a lot of server projects and I've noticed over the years that the SQLite JDBC library has gotten bigger and bigger (3mb -> 7mb). Nowadays it actually accounts for more than 60-80% of my apps final size.  
  
![](https://www.b4x.com/android/forum/attachments/98049)  
  
While this isnt hugely problematic it is a bit frustrating having all of that extra file size. I could set my B4J project to not merge the libraries but thats just a pain as I have to maintain all the libraries manually.  
  
So whats special about this library? Why is it so big?  
  
If you've ever used SQLite on Windows via command line you wouldve seen there is a sqlite3.dll file specifically for Windows. In fact if you go to the offical SQLite download page you'll see many different binaries for different operating systems and architectures. Windows, Linux, 32bit vs 64bit, ARM, Android etc.  
  
These binaries are all platform specific so when you get a library like the SQLite JDBC library it has to support many platforms. This is where the size comes from as each platform requires a different binary.  
  
If we open the latest SQLite JDBC library JAR file in 7-zip you will see the "native" folder is what makes up the majority of the overall file size.  
  
![](https://www.b4x.com/android/forum/attachments/98050)  
  
If you go into the "native" folder you will see sub-folders for every different platform supported.  
  
![](https://www.b4x.com/android/forum/attachments/98051)  
  
Even within the "Linux" folder there are multiple folders for different CPU architectures.  
  
![](https://www.b4x.com/android/forum/attachments/98052)  
  
Each of these folder contains a platform specific binary which adds to the overall library file size. The list of binaries has grown over time - for example if you check sqlite-jdbc-3.7.2 there are only 6 binaries, for the latest release there are 14! Each of these is roughly 500kb in size.  
  
Using 7-zip we can remove the native libraries we dont need and effectively shrink the final file size.  
  
For my projects I know I only need x86\_64 support for Linux and Windows. This means I can delete all the other folders out of the "native" folder and reduce the file size from 7mb to 1.1mb. I renamed this to \_min (in case I need the full file) and reference that in my B4J project!  
  
![](https://www.b4x.com/android/forum/attachments/98053)  
  
Now my compiled project is half the size it used to be!