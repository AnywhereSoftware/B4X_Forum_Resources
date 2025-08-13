### DOTips 2.7 - show an overlay for app tips by Dave O
### 12/03/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/54331/)

**Class Module: DOTips  
Author: Dave O'Brien  
Code Version: 2.7  
Last Mod: 29 Nov 2022  
  
Changes in this version:**  
- Fixed crash on showing tips for views on certain versions of Android (e.g. Android 11 Go Edition)  
  
  
**DOTips is a free B4A class for showing "spotlight" tips in your app.**  
  
These are commonly used for tutorials, onboarding, or showing users what's new. The tips are overlaid on your UI using a semi-transparent background, and can highlight a UI control or an arbitrary area, show a picture, or just show text.  
  
**To use, first add this class and its required libraries:**  
- Add this class module to your B4A project using "Add Existing Modules".  
- In the Libraries Manager, make sure these internal (and free) libraries are ticked:  
[INDENT]- JavaObject[/INDENT]  
[INDENT]- StringUtils[/INDENT]  
 - Accessibility  
  
**Create a variable for the tips:**  
- In the activity's Sub Globals, add **Dim tips As DOTips**  
- In the activity's Activity\_Create, add **tips.Initialize(Me, Activity, "tips")  
  
To show tips, add them to the tips list and call Show:**  

```B4X
tips.addGeneralTip("Insert title here", "Insert description here")  
tips.addPictureTip("picture.png", "Insert description here")  
tips.addTipForView(someView, "Insert title here", "Insert description here")  
tips.addTipForArea(someRect, someScrollview, "Insert title here", "Insert description here")  
tips.show
```

  
This will show the tips in order, using the default color, text, and automatic positioning (which adjusts to the location of the view).  
  
Note: If a view is not visible when Show is called, that tip is skipped.  
  
**To customize tips:**  
- Set the properties you want first. All tips you add after that will use those settings.  

```B4X
tips.HighlightColor = Colors.Magenta  
tips.LandscapePosition = tips.POSITION_LEFT  
tips.addTipForView(someView, "Insert title here", "Insert description here")
```

  
  
**To hide the tips when the device's Back button is tapped, add this:**  

```B4X
Sub activity_KeyPress(KeyCode As Int) As Boolean  
   If (tips.Visible = True) And (tips.CanSkip) Then  
      tips.hide(True)  
      Return True  
   else…
```

  
  
**To trigger something after the tips are closed, use the OnHide event:**  

```B4X
sub tips_OnHide(tipsSkipped As Int)  
   'do something here if desired  
end sub
```

  
  
**To resume tips after orientation changes, use GetIndexOfCurrentTip and Resume.**  
In the demo code, see the activity\_pause and activity\_resume subs.  
  
To hide the Skip All button, set **canSkip** to false.  
  
For help on the properties and methods, use the automatic tooltips in B4A or inspect the source code.  
  
**Demo code**  
I've attached a demo app that lets you play with all of the properties and see the tips in action.  
  
**Compatibility:**  
Works with B4A 4.3+. Not sure about earlier versions.  
Tested on Android 4.x and later, on various phones and tablets.  
  
**Not yet implemented:**  
- auto-size buttons to text  
- add animated transitions between tips  
- change string parameters to CSBuilder  
- make this a customView?  
  
**Usage:**  
- Creative Commons Attribution license  
(You can do whatever you like with this, as long as you credit me as the creator.)  
  
**Thanks to:**  
- [USER=1]@Erel[/USER] for the GetARGB code (and lots more besides)  
- [USER=904]@klaus[/USER] for the drawRoundRect code  
- [USER=11412]@thedesolatesoul[/USER] for porting MSShowTips, which wasn't quite what I needed, but motivated me to give it a go myself. :)  
- [USER=9800]@stevel05[/USER] for the GetRelativeLeft and GetRelativeTop code  
  
Questions, suggestions, bugs? Please post in this thread.  
  
Thanks!  
  
![](https://www.b4x.com/android/forum/attachments/34429) ![](https://www.b4x.com/android/forum/attachments/45134) ![](https://www.b4x.com/android/forum/attachments/45135)