### B4A on Linux 2022 by Raboebie
### 06/04/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/140978/)

Hello everyone!  
  
I thought I would share my experience on getting B4A running and Linux. I use Manjaro but this should work on any distro. Also, just to make managing your wine prefixes easier use PlayOnLinux or something similar.  
  
1) Create a new 64 bit prefix with wine 6.17  
2) Run winetricks inside prefix winetricks dotnet452 vcrun2010  
3) Disable Avalon 3D acceleration. This makes the GUI behave normally without flashing and popping. -> <https://docs.microsoft.com/en-us/previous-versions/dotnet/netframework-4.0/aa970912(v=vs.100)?redirectedfrom=MSDN>. You need DisableHWAcceleration set to 1. If the key does not exist, simply create it and kill all processes in the prefix afterward.  
5) Download all the tools from the B4A site as normal  
6) Place Android SDK on the prefix C drive, same with OpenJdk 11  
7) Install android-tools for your distribution. Just noting that it's important to use version Android Debug Bridge version 1.0.40  
8) Test adb by running adb devices and checking that your devices shows up in a linux termimal.  
9) Install B4A by running the setup inside your wine prefix. The setup should complete without errors  
10) Run B4A and configure your paths to point to the extracted android sdk and java directories in your prefix C drive  
11) Create a test project and see if it builds and connects to your device!  
12) If the build fails with an unknown error, this normally means you have a custom build command in Main. In my case it had a reference to robocopy. Comment out that line or install robocopy to wine (This is not tested but it should work)  
13) Have fun!  
  
Final note, before you build a project you must make sure that the adb server is running on your linux machine. You can just run adb devices again and if it's not running it will start up.