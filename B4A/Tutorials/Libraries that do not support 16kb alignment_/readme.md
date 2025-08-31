### Libraries that do not support 16kb alignment? by mcqueccu
### 08/29/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/168440/)

Many have gotten the information about their Apps not aligned with the 16KB. Here is how to check which specific libraries are causing the issue  
  
Note: You have to check for each app individually, on your PLAY CONSOLE DASHBOARD  
  
  
1. Goto your plays console Dashboard,  
2. Select your App,  
3. Click ***TEST AND RELEASE*  
ONLY the apps that have the issue will have the information about Recompile your App.**   
4. Click ***READ MORE*** at the Right  
  
![](https://www.b4x.com/android/forum/attachments/166391)  
  
Next a popup appear. Select VIEW BUNDLE  
5. On the View Bundle Page, goto Memory page size and click SHOW DETAILS  
6. The libraries that are affected will be listed as show below. This is showing sqlcipher  
  
Libraries that do not support 16 KB:  
base/lib/arm64-v8a/libsqlcipher.so  
base/lib/x86\_64/libsqlcipher.so  
  
  
  
![](https://www.b4x.com/android/forum/attachments/166390)