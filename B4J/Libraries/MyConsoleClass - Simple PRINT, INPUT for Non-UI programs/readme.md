### MyConsoleClass - Simple PRINT, INPUT for Non-UI programs by Starchild
### 09/04/2019
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/109266/)

I wanted to write myself a simple console (non-UI) program asking the user to enter some information, like an old DOS program. I realised that I needed some quick and dirty PRINT and INPUT functions like QBASIC had.  
  
So I wrote this MyConsoleClass which contains functions:  
Print, Input, PrintString, GetKey, LineFeed, ClearScreen  
  
I also needed a method of providing default keyboard responses so my program could be developed and tested inside the IDE (as the IDE has no keyboard access in non-UI).  
So when running in DEBUG mode, the extra function:  
Default … is used to specify the next default keyboard response to an Input or GetKey function.  
  
Also added a bit of delay when using the Default keyboard responses so you can watch the program progress input by input.  
  
It's not great code, but I think it will be handy to other programmers wanting to do non-UI programs, like little utilities. PS: My application was to ask the user to enter a new fixed IP for my Linux map server.  
  
I Have attached the file MyConsole.zip  
It contains the code for MyConsoleClass as well as a simple demonstration.  
  
Note: When you compile a RELEASE version of your program it can NOT be executed within the IDE as the IDE doesn't support any keyboard input for non-UI programs. You need to execute your JAR file using a JAVA VM. eg. java -jar YourProgramName.jar