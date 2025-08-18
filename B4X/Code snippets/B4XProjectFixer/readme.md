###  B4XProjectFixer by Blueforcer
### 03/30/2022
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/139531/)

Regarding to my problem/wish with merging different branches in git  
<https://www.b4x.com/android/forum/threads/better-meta-handling-for-git-usage.139524/>  
  
I wrote a small tool as a workaround which fixes the meta information in the projectfile cleanly.  
Thereby all files, libraries and modules are rearranged, reindexed and duplicates are deleted.  
  
Just Copy the B4XProjectFixer.jar in your root projectfolder  
  
While merging use "Accept both changes" in the projectfile (e.g .b4a). This will use all metainfos from both branches and combine them.  
After merging run B4XProjectFixer.jar to fix it again.  
  
The fixer automatically use the projectfile (b4a,b4i,b4j or b4r)