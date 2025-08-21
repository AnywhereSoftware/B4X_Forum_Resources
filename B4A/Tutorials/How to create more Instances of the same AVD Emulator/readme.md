### How to create more Instances of the same AVD Emulator by Sagenut
### 03/03/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/114543/)

Maybe this info can be useful to someone.  
Normally from B4A AVD Manager it's not possible to start more instances of the same AVD normally.  
We get a Warning that executing many times the same machine is an experimental feature and we need to modify some parameter (I did not tried it).  
And it's not possible to create more times the same emulator because the name is the Android Version and it will not create different machines.  
A solution can be this:  
- create your emulator with B4A AVD Manager  
- go to your Android SDK directory where you will find the folder B4AEmulator and enter it  
- rename the folder of the Emulator as you want and Copy/Remember the new name  
- go to C:\Users\xxxxxx\.android\avd folder to find all the .INI of your emulators  
- rename the relative .INI files with the new name that you used before  
- modify the PATH line inside the .INI file with the same new name  
Restart B4A AVD Manager to update to the new emulators name and then you can restart the process to create another Emulator with the same Android Version.  
They will all be different machines, even if with the same Android Version, and you will be able to run 1 instance of every machine.