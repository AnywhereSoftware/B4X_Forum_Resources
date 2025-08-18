### MonoBuilder - Compile B4J programs on Linux or Mac by Erel
### 02/07/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/60923/)

**Don't use this builder. It is no longer maintained.**  
  
Mono is a Mac / Linux port of .Net Framework: <http://www.mono-project.com/>  
  
Using Mono it is possible use B4JBuilder, the command line compiler, to compile B4J projects on Linux or Mac.  
(The IDE only runs on Windows.)  
  
Installation instructions:  
  
1. Install Mono on the Mac or Linux computer.  
2. Install Java JDK. You can check whether it is installed by running javac.  
3. Download MonoBuilder: [www.b4x.com/b4j/files/MonoBuilder.zip](https://www.b4x.com/b4j/files/MonoBuilder.zip) and unzip it.  
4. You can now compile the project with the following commands:  

```B4X
export MONO_IOMAP=all  
<path to MonoBuilder>/B4JBuilder.exe -task=build
```

  
  
If javac is not found then you should edit b4xV5.ini and set the path to the JDK bin folder.  
  
More information about B4JBuilder: <https://www.b4x.com/android/forum/threads/50154/#content>  
  
The package includes the libraries that come with the IDE. You can copy other libraries to the libraries folder. **The jar files names must be lowercased.**  
  
![](https://www.b4x.com/basic4android/images/SS-2015-12-01_15.56.09.png)