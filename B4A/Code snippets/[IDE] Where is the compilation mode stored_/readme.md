### [IDE] Where is the compilation mode stored? by Erel
### 10/11/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/135030/)

I've been asked privately, but maybe the answer will help others.  
  
ini file: %AppData%\Anywhere Software\Basic4android\b4xV5.ini  
  
There is a CompileMode key.  
The values are:  
0 - debug  
1 - release  
2 - release (obfuscated)  
  
It is only read when the IDE opens.