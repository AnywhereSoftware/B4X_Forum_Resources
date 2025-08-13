### (Local Mac) - Upload ipa to Apple Connect without Application Loader by aaronk
### 10/12/2023
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/110105/)

Hi,  
  
In the past I used Application Loader to upload my .ipa file to Apple Connect. Looks like since Xcode 11, Apple decided to remove it.  
  
*Application Loader is no longer included with Xcode. (29008875)*  
<https://developer.apple.com/documentation/xcode_release_notes/xcode_11_release_notes?language=objc>  
  
This tutorial is for people who have a local Mac and upload the .ipa file themselves without using the hosted builder.  
  
First you need to have your app ready to upload. Follow the following tutorial first: <https://www.b4x.com/android/forum/threads/publishing-your-app-to-the-app-store.57528/>  
  
Once you have followed the above tutorial (and used your store certificate and not your development certificate) you then need to do the following:  
  
The easy way to upload the app (.ipa) is to use Apple's Transporter app:   
<https://apps.apple.com/us/app/transporter/id1450874784?mt=12>  
  
Or you can do the following..  
  
1. Make sure you have the latest Xcode installed on your Mac.  
  
2. Open the [terminal window](https://www.idownloadblog.com/2019/04/19/ways-open-terminal-mac/) on your MAC (not Windows PC).  
  
3. Enter in the following:  
(don't press enter yet)  
  

```B4X
xcrun altool –upload-app –type ios –file "path/to/application.ipa" –username "YOUR_ITMC_USER" –password "YOUR_APP_PASSWORD"
```

  
  
4. Replace the /parth/to/application.ipa with the location to your .ipa file on your MAC.  
I put my ipa file on my desktop and the name of the file was app.ipa so I would change it to desktop/app.ipa  
  
5. Change YOUR\_ITMC\_USER with the username you sign into Apple Connect with (most likely your Apple ID username).  
  
6. Change YOUR\_APP\_PASSWORD with the App password.  
This is the password assigned to your app in Apple Connect. Also known as app-specific password.  
(This is not the password you sign into Apple Connect with or your Apple ID Password.)  
  
7. Once the above values have been changed, press enter.  
  
It may look like it's doing nothing and just sitting there, but it's actually uploading the app to Apple Connect. I let it sit there for a good 5-10 minutes (don't close the window even knowing it looks like it's doing nothing)  
  
Once it finishes uploading it will display in the terminal window (providing it was successful):  
*No errors uploading 'desktop/app.ipa'*  
  
Then in Apple Connect you can see the file being processed once it's finished uploading.