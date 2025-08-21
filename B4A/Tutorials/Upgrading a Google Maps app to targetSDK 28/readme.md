### Upgrading a Google Maps app to targetSDK 28 by junglejet
### 11/09/2019
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/111242/)

I decided to become Google's darling. After a very old B4A app, that went perfect for many many years (API 8, targetSDK 14), was threatened to be thrown out of the app store, I decided to waste my spare time to upgrade to API/targetSDK 28.  
  
This is a frustrating and annoying exercise. It has nothing to do with B4A, but much more with the chaos Google creates with its new APIs (while these are not completely useless).  
  
For the purpose I purchased an Android 9 smartphone with 3 years upgrade monthly service. I am not deep in B4A, nor programming at all. I upgraded to B4A 9.50. I use B4ABridge. So the things I tell below may be well below your professional standard. In that case just ignore.  
  
I installed API 28 with the B4A SDK manager (how can Google throw away the old sdkmanager.exe?), which went more or less ok.  
  
Then the drama started. Here is my take. If you want to do the same, it may be helpful.  
  
- Make a REAL backup of your old app, I mean real. Do not patch around, make a copy of the app's folder.  
  
- Make a backup copy of your old "additional libs" folder. When you have to go back to your old app, you can easily switch between the folders in B4A Tools | Configure Paths menu.  
  
- From the Google Maps tutorial be sure to download and install/overwrite GoogleMaps and GoogleMapsExtra libraries in your "additional libs" folder. It is unlikely these are up-to-date.  
  
- Download the GoogleMaps sample app from the Google Maps V2 tutorial, load to B4A and install to your smartphone. Run it in Release mode with #BridgeLogger:True. If this is running you are on a good way. You should NOT see any red messages in the log window. If so it is probably not worth continuing.  
  
- Copy the manifest (from the B4A's internal editor) to the clipboard.  
  
- Open your own app in B4A that you want to upgrade and replace the manifest in B4A editor with the one you've just copied. Be sure to update your API key.  
  
- For now change targetSDKversion to 23. This will make the first attempts easier. Save the manifest.  
  
- Replace the apps "regions" on top of the source by the one from the sample app, unless there is anything very special to your app that should stay. NO additional library entries or references to google-play-services are allowed here.  
  
- Change your "configure paths" in B4A tools to the NEW libs and android.jar API 28  
  
- Now, make your app's code that deals with Google Maps as close as possible to the sample's code. Do not forget the runtime permission code.  
  
- If MapFragment is not defined in the designer, do so now and reference it correctly in your code. MapFragement is used as it is defined, it does not need to be placed on a panel by code. However Mapfragment may be placed on a panel in the designer, but it MUST be loaded through Activity.LoadLayout.  
  
- When you think you are ready to run: do the following. Repeat the 4 steps below whenever you have changed targetSDKversion in manifest, lib path or android.jar path, or you think all the error messages make no sense (typically line number reference are out of order then). Omitting these steps may waste hours.  
  
>> Deinstall the app on your smartphone  
  
>> Close B4A  
  
>> In Windows Task Manager if there is adb.exe present: kill it.  
  
>> Start B4A  
  
- Run your app from B4A, smartphone should ask for location service approval.  
  
- You will probably see error messages in the log window. If you cannot find out their reason, then strip your app down in steps to become as close as possible to the sample app.  
  
- If error messages are like "should be initialized: (Google Maps)" repeat the 4 >> steps above.  
  
- After you're done with API 23, step up to API 28 in the manifest targetSDKversion.  
  
- Do not forget the 4 >>, then try.  
  
- API 28 will accept https:// calls by default only. To use http:// you have to add a line to the manifest, which you will find in the forum.  
  
This all is from my personal experience. I may be slow and stupid but this is how I got there after many hours. I may have omitted one or the other step.  
  
References to the samples and manifest code:  
  
[Google Maps Tutorial, Sample and Libs](https://www.b4x.com/android/forum/threads/google-maps.63930/)  
[API 28 manifest code for http:// access](https://www.b4x.com/android/forum/threads/android-jar-targetsdkversion-minsdkversion.87610/)