### B4Xsources: a B4X source code viewer using command line tools to extract and decompile the files. by PaulMeuris
### 03/15/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/146813/)

[SIZE=4]In this tutorial you can learn how to extract files from a B4Xlib or Jar file.  
![](https://www.b4x.com/android/forum/attachments/140287)[/SIZE]  
You can select in the file menu the library type to open and extract.  
![](https://www.b4x.com/android/forum/attachments/140288)  
For each library type there is a folder (b4xlibfiles and jarfiles). The extraction process creates a folder in these library type folders with the same name as the library. The files from the library are extracted in this folder using the command line tool 7za.exe.  
![](https://www.b4x.com/android/forum/attachments/140289)  
When you click on the (blue) library name you can expand or collapse the list of files.  
When you click on a filename then that file will be opened in a tab page from the right pane.  
The source code is displayed and a summary web view is available for \*.bas and \*.java files.  
![](https://www.b4x.com/android/forum/attachments/140290)  
This summary is a filter from the source code and shows the available methods or subroutines.  
![](https://www.b4x.com/android/forum/attachments/140291)  
When you click on a \*.class file (from a Jar library) then that file is decompiled using the commandline tool jd-cli.jar. The resulting file is a \*.java file that replaces the \*.class file in the list. You can find the resulting files in the folder c:\users\<your name>\AppData\…  
![](https://www.b4x.com/android/forum/attachments/140292)  
The \*.xml file that usually accompanies the \*.jar file is NOT automatically copied to the library folder. This \*.xml file is not always updated and it will only confuse you. You can however view the file after you have copied it.  
![](https://www.b4x.com/android/forum/attachments/140293)  
You can view files with the following extensions:  
".txt",".html",".bas",".b4a",".b4i",".b4j",".xml",".java",".css",".MF",".SF",".js",  
".b4x\_excluded".  
Reading the source code of the B4X programming language can help you find answers to your questions.  
Learning from the B4X programmers can help you improve your programming skills.  
You can find the source code here: [B4XSources.zip](https://cursustekst.be/vw/afb/b4a/B4XSources.zip)  
Happy coding!