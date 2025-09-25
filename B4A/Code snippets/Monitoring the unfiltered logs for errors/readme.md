### Monitoring the unfiltered logs for errors by Erel
### 09/21/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/168727/)

On modern devices the unfiltered logs is extremely busy, making it very difficult to find something relevant.   
  
If using ADB / USB debug mode then you can open command line in <android sdk>\platform-tools and run:  

```B4X
adb logcat *:E
```

  
  
This will show logs of all apps with the "importance level" set to ERROR or higher.  
I will add such a filter to the IDE.