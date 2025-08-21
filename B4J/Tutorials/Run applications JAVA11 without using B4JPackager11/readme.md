### Run applications JAVA11 without using B4JPackager11 by TILogistic
### 06/01/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/118467/)

Follow these easy steps:  
  
Create a file called Java11.bat and copy it to the c:\ directory  
  
> set JAVA\_HOME=C:\Java\java-11.0.1 <— you directory java11  
> set APP\_PATH=%~p1  
> set APP\_NAME=%~nx1  
>   
> cd %APP\_PATH%  
> %JAVA\_HOME%\bin\java.exe –module-path %JAVA\_HOME%\javafx\lib –add-modules=javafx.controls,javafx.fxml,javafx.web -jar %APP\_NAME%  
> pause

  
You can run in two ways:  
  
**way 1.**
> cmd  
> cd you\_app\_path\Objects  
> c:\Java11.bat app\_name.jar

  
**way 2.  
  
![](https://www.b4x.com/android/forum/attachments/95025) ![](https://www.b4x.com/android/forum/attachments/95026) ![](https://www.b4x.com/android/forum/attachments/95027)   
![](https://www.b4x.com/android/forum/attachments/95028)![](https://www.b4x.com/android/forum/attachments/95029)  
  
For the next time you want to run with java 11, it will be in the list to select and run:  
  
![](https://www.b4x.com/android/forum/attachments/95030)  
  
regards,**