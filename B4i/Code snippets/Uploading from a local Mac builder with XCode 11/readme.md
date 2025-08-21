### Uploading from a local Mac builder with XCode 11 by nwhitfield
### 09/24/2019
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/109885/)

In case anyone else runs into this (my Mac auto-updated this morning), here's how to do it:  
  
First, after you've built the code, find the directory where your ipa file is; since my username in B4i is set to nigel, and the build server is in my Downloads folder, it's a case of   
  

```B4X
cd ~/Downloads/B4iBuildServer/UploadedProjects/nigel
```

  
  
Now, you need the app-specific password you were using with Application Loader, and you run this command (replacing my email address with your own, and Navigator.ipa with the name of your own ipa):  
  

```B4X
xcrun altool –upload-app -f Navigator.ipa -t ios -u nigel.whitfield@bluf.ltd.uk -p app-specific-pass
```

  
  
There's no progress display; it'll just sit there for a bit and then say "No errors uploading 'Navigator.ipa'"