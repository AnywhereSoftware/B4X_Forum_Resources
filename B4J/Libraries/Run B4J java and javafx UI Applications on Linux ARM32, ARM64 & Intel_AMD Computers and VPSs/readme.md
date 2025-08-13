### Run B4J java and javafx UI Applications on Linux ARM32, ARM64 & Intel/AMD Computers and VPSs by aminoacid
### 01/10/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/159928/)

To run a B4J console or GUI Application on any 32-bit or 64-bit ARM computer, follow these steps:  
  
Have tested it on Raspberry Pi 4 and Orange Pi Zero 3, 2W running Ubuntu 21.04 and 22.04 respectively:  
  
[edit - Also works with 32-bit Raspberry Pi OS on RPI 3 - see [USER=27763]@dave4cbu[/USER] post below]  
  
[edit - 21-09-2024: This will not work (for obvious reasons) with Libraries such as "ControlsFX" that require Java 8]  
  
[edit 10-01-2025: Tested and works with Ubuntu Linux running on x64 Intel processor based computers and VPSs. So it's not just limited to ARM - See Post#6 ]  
  
**STEP 1: Install openjfx11+**  
  
sudo apt-get update  
sudo apt-get install openjfx  
  
**STEP 2: Find out where openJfx is installed**  
  
dpkg-query -L openjfx  
  
NOTE: ….. should be installed in /usr/share/openjfx  
  
**STEP 3: Install OpenJDK11+ JRE (or whatever version the default JRE is) and check version**  
  
sudo apt install default-jre  
  
sudo java -version  
  
**STEP 4: Run Program**  
  
sudo java -jar –module-path /usr/share/openjfx/lib –add-modules javafx.controls **yourB4Jprogram.jar**  
  
*NOTE: You can run B4J jar files compiled with **Oracle** **Java 8** as well as **OpenJDK11+***  
  
Note [10-01-2025]: If you get the error message "*Authorization required, but no authorization protocol specified*" run the above command without the "sudo"  
  
Instead of typing the long command line, you can create a shell script with the above command line and pass your jar file as a parameter:  
  
1. Create a file called "**jrun**" with the following two lines:  
  
**#!/bin/bash  
sudo java -jar –module-path /usr/share/openjfx/lib –add-modules javafx.controls $1**  
  
2. Make the file executable:  
  
**chmod +x jrun**  
  
3. Run the program with a simplified command line:  
  
**./jrun** **yourB4Jprogram.jar  
  
  
Enjoy! :)**  
  
  
  
—————————————————————————-