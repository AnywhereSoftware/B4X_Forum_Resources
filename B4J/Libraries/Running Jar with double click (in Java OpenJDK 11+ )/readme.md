### Running Jar with double click (in Java OpenJDK 11+ ) by epiCode
### 03/16/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/140605/)

As shared in multiple places in this forum Java 11 OpenJDK does not allow to run jar files directly. ([here](https://www.b4x.com/android/forum/threads/solved-win-10-64-bit-java-11-cannot-run-jar-file.105016/post-658007))  
  
Here is an easy workaround…  
  
1. Run **cmd** with administrator privilege.  
2. Type the following two commands:  

```B4X
ftype JARFile="c:\java\bin\javaw.exe" -jar –module-path c:\java\javafx\lib –add-modules javafx.controls "%1" %*"  
  
assoc .jar=JARFile
```

  
  
Replace the path "c:\java\bin\javaw.exe" and "c:\java\javafx\lib" based on your installed java folder.  
  
UPDATE 16/03/2023:  
  
If you have OpenJDK version greater than 11 and you are still unable to run a GUI based jar then try edit in Registry  
1. Navigate to **Computer\HKEY\_CLASSES\_ROOT\JARFile\Shell\Open\Command**  
2. In Default put this value (replace path with your java and javafx lib path) :  
  

```B4X
"c:\java\bin\javaw.exe" -jar –add-opens javafx.controls/com.sun.javafx.scene.control.skin=ALL-UNNAMED –module-path c:\java\javafx\lib –add-modules javafx.controls,javafx.web "%1" %*
```

  
  
Cheers!