### SQLiteJDBC and slf4j by Claudio Oliveira
### 05/28/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/161370/)

Hi all!  
  
An important observation about SQLiteJDBC.  
  
Starting with version 3.43.2.0, the authors of the SQLiteJDBC library added the SLF4J logging framework as a dependency. You can find more information about this [HERE](https://github.com/xerial/sqlite-jdbc/issues/802).  
Therefore, applications using SQLiteJDBC version 3.43.2.0 and higher must add references to the following SLF4J libraries (latest stable version files):  
[slf4j-api-2.0.13.jar](https://repo1.maven.org/maven2/org/slf4j/slf4j-api/2.0.13/slf4j-api-2.0.13.jar)  
[slf4j-nop-2.0.13.jar](https://repo1.maven.org/maven2/org/slf4j/slf4j-nop/2.0.13/slf4j-nop-2.0.13.jar)  
  
Download files; save in your additional libraries folder and add the following lines to your project:  

```B4X
#AdditionalJar: slf4j-api-2.0.13  
'The reference to slf4j-nop is not mandatory. However SLF4J will issue a warning, that can be ignored.  
'So, for a cleaner log add this   
#AdditionalJar: slf4j-nop-2.0.13.jar
```

  
  
Main repository of SLF4 files can be found [HERE](https://repo1.maven.org/maven2/org/slf4j/).  
  
I should have posted this when version 3.43.2.0 was released, but I totally forgot to do so.  
I do apologize for my forgetting! ?  
  
Regards!