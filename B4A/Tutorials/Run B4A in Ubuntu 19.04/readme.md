### Run B4A in Ubuntu 19.04 by Songwut K.
### 02/22/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/114251/)

1) sudo apt install -y wine winetricks  
  
2) winetricks dotnet452  
  
3) wine B4A.exe  
![](https://www.b4x.com/android/forum/attachments/89017)  
4) winetricks  
 install windows DLL or component  
 vcrun2010  
![](https://www.b4x.com/android/forum/attachments/89018)  
  
  
5) right click icon B4A "Allow Launching"  
![](https://www.b4x.com/android/forum/attachments/89019)  
6) Download OpenJDK 11  
[https://jdk.java.net/11/](https://jdk.java.net/11/?fbclid=IwAR38zTZw8j_LyO8KZ6SF3lI-GqCDwax2BAeBN3_1W0d3Pa0dBu8RkvDIhJE)  
  
7) Extract file in /home/(user)/.wine/drive\_c/JAVA  
  
8) Click icon B4A to run program   
  
![](https://www.b4x.com/android/forum/attachments/89021)  
  
9) config path to javac.exe   
  
![](https://www.b4x.com/android/forum/attachments/89022)  
  
  
more info …   
  
> <https://www.b4x.com/android/forum/threads/running-b4a-and-b4j-under-linux-with-wine-fully-functional.98431/>