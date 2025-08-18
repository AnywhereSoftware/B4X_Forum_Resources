### Linux + B4JPackager11: Cannot run program "objcopy": error=2, No such file or directory by Erel
### 10/04/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/123076/)

The jlink tool relies on a system tool named objcopy. If you get the above error message then it is not installed.  
  
On Ubuntu it can be installed with:  

```B4X
sudo apt install binutils
```