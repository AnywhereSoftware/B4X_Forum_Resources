### B4J app for Raspberry with jdk11 by Andreaserbyte
### 07/06/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/161981/)

This is my shopping list after various installations on Raspberry:  
  
The Runtime for B4J applications for Raspberry differ in the processor version  
If ARM version 7 Use Bellsoft-Jdk11.0.23+12-Linux-Arm32-VFP-HFLT-Full.deb   
If Arm 64 Bit Use Bellsoft-Jdk11.0.23+10-LINUX-ARCH64-FULL.DEB   
To check which is installed, use uname -a  
![](https://www.b4x.com/android/forum/attachments/155223)  
![](https://www.b4x.com/android/forum/attachments/155225)  
On the Desktop Right button of the mouse  
![](https://www.b4x.com/android/forum/attachments/155226)  
  
Install packages then insert password and wait for the end.  
Copy the jar file compiled to release  
![](https://www.b4x.com/android/forum/attachments/155227)  
in the Object folder under the program path  
![](https://www.b4x.com/android/forum/attachments/155228)  
And of course the external files you need for the menu settings type etc. (setcnn.json)  
  
Place the JAR file in the /Home /Pi folder  
![](https://www.b4x.com/android/forum/attachments/155229)  
  
Create a file to make the application in the desktop  
  
[Desktop Entry]  
Terminal=false  
Name=CUcina  
Comment=lista da cucinare  
Icon=  
Exec=java -jar SagraClientJ.jar  
Type=Application  
Encoding=UTF-8  
Categories=None;  
  
![](https://www.b4x.com/android/forum/attachments/155230)