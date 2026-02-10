### How to handle "java.io.IOException: WaitForMultipleObjects error=6, Invalid handle" by walt61
### 02/05/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/170220/)

As I didn't find anything on the forum regarding this error and it took me a while to solve it, I'm posting this here. I was running a B4J program from the IDE on Linux (under wine) and ran into this exception when trying to execute a shell script with the jShell library, like:  

```B4X
Dim shl As Shell  
shl.Initialize("shl", "myfile.sh", Array As String("a", "b", "c"))  
shl.RunSynchronous(-1) ' <—– This throws the exception; the same happened when using shl.Run
```

  
  
I fixed it by  
1. creating this script to run the jar natively, i.e. not from wine (change the paths to reflect your setup):  

```B4X
#!/bin/bash  
java @release_java_modules.txt –module-path /home/me/java/jdk-14.0.1/javafx/lib –add-modules ALL-MODULE-PATH -Djdk.gtk.version=2 -jar /home/me/path/to/Objects/my.jar
```

  
2. copying file 'release\_java\_modules.txt' from the B4J installation directory to the directory that contains the above script  
  
Note:  
- The script works for both console and UI programs.  
- I added '-Djdk.gtk.version=2' some years ago to avoid the warning message 'XSetErrorHandler() called with a GDK error trap pushed. Don't do that.'. I found this on <https://stackoverflow.com/questions/55446534/how-to-fix-java22494-gdk-warning> ; it may be unnecessary.