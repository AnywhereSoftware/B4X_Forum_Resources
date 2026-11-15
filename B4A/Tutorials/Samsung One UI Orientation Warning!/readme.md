### Samsung One UI Orientation Warning! by stevel05
### 11/08/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/172514/)

I am currently working on a cross platform B4XPages app using my Galaxy Tab A9+ to test and was tearing my hair out (what little I have left) because setting #SupportedOrientations: landscape was not locking the orientation. I also tried locking the orientation using the phone library [ICODE]ph.SetScreenOrientation(0)[/ICODE] which was also ignored. I did try it on Bluestacks which worked as expected.  
  
It turns out that the Samsung (not so) 'Smart' Setup decided that it should ignore the directive and set the flag for 'Landscape view for portrait apps' on for this application. Which meant that the orientation is changed regardless whenever the tablet is turned. This setting can be found in Settings / Advanced features / Labs. The good news is that if you manually turn this off, the orientation gets locked as expected and you can continue testing.  
  
Updating the app does not reset the flag, but if you uninstall it and reinstall it, you will need to check the flag again.  
  
I tried a few things guided by Google Gemini, but could not figure out how to get the Samsung to not apply this automatically.  
  
Gemini also 'assured' me that installing through the Play store would not give this result. But as a warning and for something to test as, if it does unexpectedly allow orientation changes with a B4xPages app, there will be bugs.  
  
I can't test it as I have no plans to publish anything soon.  
  
I did search the forum, but could find no reports of this issue, hence my post.