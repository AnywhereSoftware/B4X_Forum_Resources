### Tip: Getting rid of the excessive compiler logs by Erel
### 03/17/2020
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/112763/)

Disabling debug output in the logs is done by editing:  
C:\Program Files (x86)\Arduino\arduino\_debug.l4j.ini  
This requires administrative access.  
  
Add this line at the end:  

```B4X
-DDEBUG=false
```