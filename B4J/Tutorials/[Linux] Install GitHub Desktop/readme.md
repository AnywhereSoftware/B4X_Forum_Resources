### [Linux] Install GitHub Desktop by aeric
### 09/22/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/172121/)

This is not a B4J Tutorial but it can be useful if you want to install GitHub Desktop on Linux.  
GitHub only provide Windows and MacOS installer. There is no official package you can download and install for Linux.  
However, there is an open source version provided by GitHub username shiftkey.  
  
Here is the command to install the open source GitHub Desktop. I already tested on Linux Mint.  
  

```B4X
wget -qO - https://mirror.mwt.me/shiftkey-desktop/gpgkey | gpg –dearmor | sudo tee /usr/share/keyrings/mwt-desktop.gpg > /dev/null  
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/mwt-desktop.gpg] https://mirror.mwt.me/shiftkey-desktop/deb/ any main" > /etc/apt/sources.list.d/mwt-desktop.list'
```

  
  

```B4X
sudo apt update  
sudo apt install github-desktop
```

  
  
**Quick Alternative**  
If you don't want to deal with adding repositories at all, you can also run this automated installation script provided directly by the mirror maintainer:   
<https://mirror.mwt.me/shiftkey-desktop/>