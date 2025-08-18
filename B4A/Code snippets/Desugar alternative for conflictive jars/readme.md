### Desugar alternative for conflictive jars by JordiCP
### 04/10/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/129584/)

Hi all,  
  
If you've ever had to desugar some libraries that use Java 8 features, there's a great B4J utility that [USER=1]@Erel[/USER] posted [**HERE**.](https://www.b4x.com/android/forum/threads/desugar-fix-the-invokedynamic-requires-error.107278/#content)  
It does the job after following the instructions, adding the needed dependencies, and outputs a desugared Merged.jar   
  
However, there are some specific libraries that seem to use some (more recent?) Java 8 features where the desugarer fails to work with. See [HERE](https://www.b4x.com/android/forum/threads/solved-desugaring-error-with-lambdas.129438/#content) and [HERE](https://www.b4x.com/android/forum/threads/desugar-problem.127963/).   
  
After spending lots of hours trying to find a solution, I finally could manage it (there may be other ways. This has worked for me, and may work or fail in other cases). –> So I decided to post the relevant clues in case someone also runs into the same situation. If this is the case, please give feedback  
  
(Note: this procedure does NOT replace the whole B4J's utility desugaring process -unpacking aars, merging classfiles, desugaring…- but is intended to individually deal with the 'conflictive' .jar class files)  
  
How to proceed:  
- Identify the conflictive jar file (the one that outputs a similar error as reported in the linked threads above, or perhaps others)  
- Download an updated r8.jar from the maven repository. I used [**r8-2.1.96.jar**](https://maven.google.com/com/android/tools/r8/2.1.96/r8-2.1.96.jar)    
 - (Starting from some version, R8-D8 includes a non-official but functional support to produce .jar class outputs, instead of DEX)  
- Place them in the same folder to simplify things  
- Execute the following line (note: it's just a use-case example, broken into lines for clarity. Adapt it to your specific use case)  
  

```B4X
java -cp r8-2.1.96.jar com.android.tools.r8.D8                            '<– specify D8 classpath entry to r8-2.1.96.jar (or the version you have)  
  –output C:\Develop\B4J-Desugar\tests\classes2.jar                            '<– path+name of the desired output .jar  
  C:\Develop\B4J-Desugar\tests\classes.jar                                               '<– path+name of the input jar  
   –lib C:\Develop\Basic4android\B4A_AndroidSDK\platforms\android-30\android.jar       '<– Path to android.jar  
   –classpath C:\Develop\Basic4android\B4A_AndroidSDK\extras\b4a_remote\androidx\core\core\1.3.1\unpacked-core-1.3.1\jars\classes.jar         '<– Add one line like this for each dependency  
   –classpath C:\Develop\Basic4android\B4A_AndroidSDK\extras\b4a_remote\androidx\lifecycle\lifecycle-common\2.2.0\lifecycle-common-2.2.0.jar  
   –classpath C:\Develop\Basic4android\B4A_AndroidSDK\extras\b4a_remote\androidx\lifecycle\lifecycle-extensions\2.2.0\lifecycle-extensions-2.2.0\classes.jar   
   –classpath C:\Develop\Basic4android\B4A_AndroidSDK\extras\b4a_remote\androidx\lifecycle\lifecycle-process\lifecycle-process-2.3.1\classes.jar  
   –classfile                                                                                   '<–Note the last –classfile option at the end. If it is not added. it will output a compiled .dex file instead of a .jar
```

  
  
Good luck with it! :)