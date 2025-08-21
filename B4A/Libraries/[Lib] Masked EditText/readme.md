### [Lib] Masked EditText by Informatix
### 01/23/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/30712/)

This EditText fixes a few issues with the standard EditText and adds new features:  
- Filter: you can transform any input before the text is changed;  
- Mask: you can define an input mask;  
- Read-only: you can protect your EditText against changes;  
- Floating hint: the hint moves above the EditText when the user starts typing;  
- Error popup: you can display a message in a popup to warn the user:  
  
![](https://www.b4x.com/android/forum/attachments/18195)  
  
v1.1:  
- It is now a custom view supported by the designer  
- I fixed a bug when Format was set after WithSuggestions  
  
v1.2:  
- I moved the CompactText function from the example to the library;  
- I fixed a bug with SelectionStart;  
- I fixed a bug when InputType is set to NONE.  
  
v1.3:  
- WithSuggestions works now as expected on Samsung devices.  
- Suggestions are automatically disabled in password mode.  
  
v1.4:  
- I added the EnableFloatingHint function;  
- I added the custom view properties for the designer.  
  
v1.41:  
- I improved the animation of the floating hint;  
- I fixed an issue with the hint color.  
  
v1.42:  
- I fixed a bug with the floating hint when the EditText is moved.  
  
v1.5:  
- I rewrote the code of floating hints to make it more robust and fix a few issues;  
- I added the SetFromHTML function.  
  
v1.51:  
- A few properties set in the designer were not taken into account.  
  
v1.52:  
- There was an issue with the background drawable as it was set by default by the designer to a white colored drawable. The support of this property in the designer was removed to keep the original default background.  
  
This library does not work with Android versions < 2.