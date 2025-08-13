### [Tool] Bal2Bil - B4A Layouts Converter by Erel
### 08/03/2023
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/50197/)

**Don't use this tool. More powerful and simpler feature is available inside the IDE: <https://www.b4x.com/android/forum/threads/b4x-sharing-layouts-between-platforms.109296/#content>**  
  
This is a small command line tool that converts B4A layout files (bal files) to B4i layout files.  
  
It is written in B4J. The source code is attached.  
  
The purpose of this tool is to help you with the conversion. Not all views and properties will be converted as there are views such as TabHost that are not available in B4i (and iOS).  
  
Using this tool is simple. It expects two parameters: the input file (bal) and the output file (bil).  
java -jar Bal2Bil.jar <input.bal> <output.bal>  
  
![](https://www.b4x.com/basic4android/images/SS-2017-01-01_14.20.14.png)  
  
Bal2Bil.zip - source code  
Bal2Bil.jar - executable jar (not a library).