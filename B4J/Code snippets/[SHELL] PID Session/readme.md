### [SHELL] PID Session by T201016
### 04/24/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/166713/)

I present on the forum  
**PID Session** for possible use in private projects.  
  
This small project uses the Shell manual in the form of:  
  
> Js.initialize ("Js", "Tasklist.exe", Array as string ("/v")))  
> Js.run (60000)

  
With the help of **PID Session** - you will receive a text file with some interesting information in it.  
All data is saved to the list from which you can easily extract **PID** for the application you are looking for currently launched in Windows.  
And because the text file mentioned above It will contain confidential data, so you also have a safe way in my project  
removing such a collection from the disk.  
  
**PID** will allow you, among others for the interruption of a working process.  
  
Data from the execution of the Shell instructions:  
  
> ========= Image Name (25 Chars)  
> ========= PID (8 Chars)  
> ========= Session Name (16 Chars)  
> ========= Session# (11 Chars)  
> ========= Mem Usage (12 Chars)  
> ========= Status (15 Chars)  
> ========= User Name (50 Chars)  
> ========= CPU Time (12 Chars)  
> ========= Window Title (72 Chars)

  
You can find my example from application in the snowy project.  
**V2 version** skipping the text file.