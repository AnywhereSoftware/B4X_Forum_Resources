### [tool] Compile project with different version of Java by Erel
### 01/31/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/120584/)

**Don't use this. Starting from B4J v8.80 there is a built-in option** (#JavaCompilerPath): <https://www.b4x.com/android/forum/threads/b4j-v8-80-has-been-released-%F0%9F%8D%BE.125536/#content>  
  
  
1. Download the attached jar and put it in B4J internal folder. Not in the libraries folder.  
  
2. Add these comments to your project:  

```B4X
'Compile with Java 8:  ide://run?file=%B4X%\ProjectCompiler.jar&VMArgs=-Db4x%3D%B4X%&Args=-Task%3DBuild&Args=-BaseFolder%3D..&VMArgs=-Djavabin%3DC:\Program+Files\Java\jdk1.8.0_211\bin  
'Compile with Java 14: ide://run?file=%B4X%\ProjectCompiler.jar&VMArgs=-Db4x%3D%B4X%&Args=-Task%3DBuild&Args=-BaseFolder%3D..&VMArgs=-Djavabin%3DC:\jdk-14.0.1\bin
```

  
  
3. Change the last parameter based on your java path. Note that you need to replace spaces with + and (, ) with %28 and %29.  
4. Ctrl + click on the links to compile.