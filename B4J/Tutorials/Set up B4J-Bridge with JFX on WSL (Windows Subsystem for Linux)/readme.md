### Set up B4J-Bridge with JFX on WSL (Windows Subsystem for Linux) by knutf
### 06/15/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/171275/)

This guide installs Java with JFX for use with B4J-Bridge on a standard Ubuntu distro in WSL.  
  
This worked for me on Windows 10.  
  
This guide only makes sense if you develop a UI B4J app and for some reason have to run it on Linux during the development process.  
Normally it is good enough to skip B4J-Bridge and simply press F5.  
If you develop a non-UI app: stay with OpenJDK 19.  
  
1) Set up a standard Ubuntu distro in WSL as described here <https://learn.microsoft.com/en-us/windows/wsl/install>  
  
2) Start WSL (in the Windows search field type wsl + [enter]; a window with a WSL command prompt should appear)  
  
3) Install Java with JFX: paste (right click) this command at the WSL prompt and press [Enter].   
If you are askd for a password, it is the password you made during setting up the Ubuntu distro.  
(I had to put a space in the wget command to be allowed to post in the forum, you must remove it before you paste it at the WSL-prompt or copy it from the suplied txt file)  

```B4X
bash -c '  
set -e  
sudo apt-get update  
sudo apt-get install -y wget gnupg  
w get -qO - xx | sudo gpg –dearmor -o /usr/share/keyrings/bellsoft.gpg  
echo "deb [signed-by=/usr/share/keyrings/bellsoft.gpg] https://apt.bell-sw.com/ stable main" | sudo tee /etc/apt/sources.list.d/bellsoft.list  
sudo apt-get update  
sudo apt-get install -y bellsoft-java17-full  
'
```

  
  
4) Confirm JDK installation: paste this command at the WSL prompt:  

```B4X
ls /usr/lib/jvm/ | grep bellsoft  
# expected: bellsoft-java17-full-amd64  
/usr/lib/jvm/bellsoft-java17-full-amd64/bin/java -version
```

  
  
5) Install B4J-Bridge: paste this command at the WSL prompt:  
(You need to remove the space in the wget command here as well., or copy from the suplied txt file)  

```B4X
bash -c '  
set -e  
mkdir -p ~/dev  
cd ~/dev  
w get -O b4j-bridge.jar xx  
ls -l ~/dev/b4j-bridge.jar  
'
```

  
  
6) Test installation with this command: Paste this command at the WSL prompt:  

```B4X
/usr/lib/jvm/bellsoft-java17-full-amd64/bin/java -jar ~/dev/b4j-bridge.jar
```

  
  
7) Make a bat file: paste this code in Notepad and save it with "bat" as the file extension:  

```B4X
@echo off  
REM Opens B4J-Bridge inside WSL in its own console window  
title B4J-Bridge (WSL)  
wsl.exe – bash -lic "/usr/lib/jvm/bellsoft-java17-full-amd64/bin/java -jar ~/dev/b4j-bridge.jar"  
pause
```

  
  
Run the bat file whenever you want to use B4J with B4J-Bridge in Linux for debugging.  
  
Note: every time you start wsl with b4j-bridge with batfile there will be a new ip address. You must enter this in b4j ide