### Create shared folders in Virtual Box Ubuntu 20.04 machine to transfer files to compile in Linux your B4J Apps and how to use B4J Bridge by hatzisn
### 12/03/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/124724/)

I recently tried to create a shared folder for an Ubuntu machine in Virtual Box with the host to transfer the jar files to be compiled and packed using the external (not integrated) B4JPackager11.jar. I googled a lot and saw YT videos and gathered these instructions for my personal use as a knowledge base. I am posting them here and it might be useful to someone else in the forum:  
  
Instructions:  
  
1) Right click on Ubuntu desktop and open terminal  
2) Write:  
sudo apt-get update  
sudo apt-get install build-essential gcc make perl dkms linux-headers-$(uname -r)  
reboot  
  
3) Select Devices > Insert Virtual Box Host additions disk  
4) It will open a window asking you if you want it to run it automatically. Select Yes  
5) It will Install  
6) Power off the machine  
7) Create the folder you want to share in Windows  
8) Go to to virtual machine settings in the section Shared Folders and add the folder to the Shared Folders of the machine selecting also automount.  
9) Power up the virtual machine  
10) Right click on desktop and open terminal  
11) Write:  
whoami  
(It will reply with current user)  
sudo adduser {urername} vboxsf  
(Insert password for this user)  
12) Reboot  
13) You are good to go