### Runner to start JAR with Open JDK by tchart
### 09/02/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/106230/)

Note: This wont be for everyone and is not a replacement for B4JPackager11  
  
Also, see [USER=448]@agraham[/USER] post here; <https://www.b4x.com/android/forum/threads/running-jars-under-openjdk-11.106201>  
  
I distribute some executable JAR files with a B4J Server application which has a Open JDK runtime included as part of the package.  
  
While I appreciate what B4JPackager11 does this solution wasn't right for me as I don't want multiple runtimes or have to create a new executable for every JAR I make.  
  
Based on Erels C# B4JPackager11 code I have created a C# "runner" which starts the JAR using Open JDK but the executable uses its name to execute the jar in the same directory.  
  
For example;  
  
1) If you start Runner.exe it will launch Runner.jar  
2) If you rename Runner.exe to bob.exe it will launch bob.jar (assuming bob.jar exists)  
3) If you rename Runner.exe to Config.exe it will launch Config.jar (assuming Config.jar exists)  
  
This way I can have one executable that I can rename to target multiple JAR files.  
  
The code repo is here;  
  
<https://github.com/ope-nz/Runner>  
  
The pre-compiled exe is here; <https://github.com/ope-nz/Runner/blob/master/Runner.exe>  
  
If you want to build your own Runner or change the icon there is a batch file to build the C# code for you (download the project).  
  
IMPORTANT: One thing to note is that by default Open JDK isnt in the OS path so Runner looks for a folder called "runtime" in the same folder as Runner.exe and the JDK should be in the runtime folder (see screenshot). The code will also look for a JDK in C:\Java. You can adjust this in the C# code if you want.  
  
In the screenshot you can see Runner.exe has been renamed to Config.exe and this will launch Config.jar (in the same folder) using the Open JDK runtime under the runtime folder.  
  
![](https://www.b4x.com/android/forum/attachments/80808)