### Managing Hidden Jar Processes by Philip Chatzigeorgiadis
### 10/29/2019
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/110804/)

Based on Erel's tutorial here:  
  
<https://www.b4x.com/android/forum/threads/killing-forgotten-java-processes.82584/#content>  
  
I made this program mainly to view and kill Jar processes that are hidden (non - UI)  
Of course, the TableView shows both UI and non UI Jar processes.  
  
Note that you might need to edit line 87, to point to your jps.exe.  
  

```B4X
    js.Initialize("js", "C:\java\jdk-11.0.1\bin\jps.exe",  Array As String("-l"))
```