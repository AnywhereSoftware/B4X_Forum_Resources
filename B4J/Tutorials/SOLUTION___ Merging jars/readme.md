### SOLUTION??? Merging jars by JackKirk
### 04/26/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/170893/)

After searching the forums [**and asking around**](https://www.b4x.com/android/forum/threads/jar-in-a-jar.170890/#post-1045872) there seems to be no common, simple solution to this.  
  
**SCENARIO**  
  
You have created some java **mywrapper.java** that wraps an existing jar **wrapped.jar**  
  
You do not have the source of **wrapped.jar**  
  
You set up a source folder structure like:  
  
D:\mywrapper  
 |  
 +— src\**mywrapper.java**  
 |  
 +— libs\**wrapped.jar**  
  
You compile **mywrapper.java** using B4J\_LibraryCompiler.exe and end up with **mywrapper.jar** and **mywrapper.xml** in your B4J ….\Additional Libraries folder  
  
But **mywrapper.jar** does not have **wrapped.jar** embedded in it, if you want to use the new B4J library **mywrapper** in a B4J project you have to include this in the project:  
  
#Region Project Attributes  
#AdditionalJar: **wrapped.jar**  
#End Region  
  
and there has to be a copy of **wrapped.jar** in the B4J ….\Additional Libraries folder  
  
All very messy.  
  
**SOLUTION**  
  
[**I had this scenario here**](https://www.b4x.com/android/forum/threads/an-ssh-library-courtesy-of-ms-copilot-b4jssh-now-the-ferrari-version.170667/post-1045846) and was able to find a solution courtesy of Claude which I present in a more generalised form here:  
  
Create a folder structure, say:  
  
D:\mywrapper\_merge  
 |  
 +— **mywrapper.jar** (from B4J …\Additional Libraries)  
 |  
 +— **wrapped.jar**  
 |  
 +— **merge.bat**  
  
Where **merge,bat** contains:  
  

```B4X
@echo on  
:: Post-build fat JAR builder  
:: Place this .bat next to both JARs  
  
set OUTPUT=mywrapper.jar  
set DEP=wrapped.jar  
set WORK=_fatjar_tmp  
  
:: Extract dependency  
mkdir %WORK%  
cd %WORK%  
jar xf ..\%DEP%  
cd ..  
  
:: Extract your library into same temp dir (dependency goes first so your classes win)  
cd %WORK%  
jar xf ..\%OUTPUT%  
cd ..  
  
:: Remove META-INF signatures from wrapped (causes SecurityException if left in)  
del /q %WORK%\META-INF\*.SF 2>nul  
del /q %WORK%\META-INF\*.RSA 2>nul  
del /q %WORK%\META-INF\*.DSA 2>nul  
  
:: Repack everything into the output JAR  
cd %WORK%  
jar cf ..\%OUTPUT% .  
cd ..  
  
:: Clean up  
rmdir /s /q %WORK%  
  
echo Done. %OUTPUT% now contains wrapped classes.  
pause
```

  
  
after running **merge.bat** you should now have a updated D:\mywrapper\_merge\**mywrapper.jar** with **wrapped.jar** embedded in it.  
  
Copy D:\mywrapper\_merge\**mywrapper.jar** …\Additional Libraries\**mywrapper.jar**  
  
Now you can use the **mywrapper** library without having to use:  
  
#Region Project Attributes  
#AdditionalJar: **wrapped.jar**  
#End Region  
  
and no need for a copy of **wrapped.jar** in the B4J ….\Additional Libraries folder