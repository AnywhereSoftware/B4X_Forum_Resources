### Tips or Tricks for using Android Emulator by aeric
### 10/01/2024
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/158120/)

I want to share a few tricks when using the Android Virtual Device or Emulator.  
  
**1. Increase font and icon size**  
Go to Settings (gear icons) from drawer/desktop/slide down menu and choose Display.  
Change the value from the Font size and Display size sliders.  
  
**2. Improve screen resolution**  
While you can change the font size on display settings, the pixels are still too small.  
Add hw.lcd.density=240 to the C:\Users\USERNAME\.android\avd\EMULATOR\_NAME.ini file.  
  
If this doesn't work for you, modify C:\SDK\B4AEmulator\EMULATOR\_NAME.ini  
[ICODE]hw.lcd.density = 240[/ICODE]  
  
**3. Change wallpaper**  
The stock wallpaper is ugly.  
Long click the Home screen until the menu pops up showing and choose "Wallpaper & style".  
Choose a nice wallpaper to apply to Home screen.  
Optionally, activate the Themed icons (beta).  
  
You can also find this setting in Settings.  
  
**4. Add an analog clock widget**  
Add an animated analog clock widget on Home screen  
Long click the Home screen until the menu pops up showing and choose "Widgets"  
Scroll down and choose the Clock. Select the first clock widget.  
  
**5. Editing the skin**  
The dark oval shadow on Nexus 5 skin is big and ugly.  
Edit the png file with image editor and save it.  
  
**6. Follow my timezone**  
The clock always follow GMT +0  
If you change this in Settings->System->Date & time. When the emulator reboots, it will back to default.  
If you are using bat file to start the emulator, you can specify the timezone parameter.  
e.g.  
cd /d C:\SDK\emulator  
emulator -avd 6in\_Phone\_Platform\_34\_google\_apis -timezone Asia/Kuala\_Lumpur  
  
**7. Add a keyboard for another language**  
Invoke the Google keyboard. Click on the gear icon.  
In Languages, you can add a new keyboard.  
You can change the keyboard by clicking on the Globe key.  
  
**8. Taking screenshot that save inside emulator**  
Make sure you have some apps opened. Click the square button (vertical control on the right of emulator if it is in Portrait mode) to see the recent apps list.  
The Screenshot function is at the bottom.  
  
**9. Enable navigation buttons**  
If you missed the classic navigation buttons (Triangle - Circle - Square) or (Back - Home - Recent Apps) then you can show it by modifying the setting in   
config.ini inside C:\SDK\B4AEmulator\6in\_Phone\_Platform\_34\_google\_apis\_playstore  
Set [ICODE]hw.mainKeys=no[/ICODE]  
  
**10. Setting location in Google map**  
Use the 3 dots button to go to the Location setting.  
Search a location or click a point on the map to show a red pin.  
Click SAVE POINT. Give a name and click OK.  
Select a location from the Saved point list and click on button SET LOCATION at the bottom right corner.  
Check on Google map app to see the location is changed.  
  
**11. Power menu**  
In new version of Android, when clicking and holding on the power button, you get "Digital assistant" by default.  
To power off the emulator gracefully, you need to swipe down from the top menu, swipe the notification down then only you will see 3 tiny buttons at the bottom which includes the power button. This is cumbersome.  
Open the Settings, search for "power menu" or go to System > Gestures > Press & hold power button.  
Change to "Power menu".  
  
**12. Reinstall**  
If the emulator fail to start, delete the folder e.g android-34 inside C:\SDK\system-images  
Open B4A SDK Manager, download the new emulator image.  
Once finished download, create a new emulator from B4A AVD Manager.  
  
**13. Play Protect**  
There is no point to enable Play Protect and it's updates. If you are using a Google API Playstore emulator system image, open Play store app and tap on the 3 dots on top right corner and disable any settings that no applicable.  
  
![](https://www.b4x.com/android/forum/attachments/148860)