###  XUI Views - Cross platform views and dialogs by Erel
### 11/26/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/100836/)

[MEDIA=vimeo]311915599[/MEDIA]  
  
XUI Views is a b4x library (<https://www.b4x.com/android/forum/threads/100383/#content>). The same b4xlib library is compatible with B4A, B4i and B4J  
  
It is a collection of custom views and dialogs. Everything is written in B4X. The source code is included inside the b4xlib file, which is a zip file.  
  
Views:  
  
- B4XRadioButton - Cross platform radio button.  
- B4XComboBox - Cross platform ComboBox / Spinner / ActionSheet.  
- ScrollingLabel - A label that scrolls the text when it is wider than the label. Search for BBScrollingLabel for a similar view that supports rich text.  
- AnotherProgressBar - Vertical or horizontal animated progress bar.  
- B4XLoadingIndicator - 6 different animated loading indicators.  
- RoundSlider - A round slider.  
- SwiftButton - 3d button  
- AnimatedCounter  
- B4XFloatTextField - A TextField / EditText with a floating hint  
- B4XSwitch - Nice looking two state control.  
- B4XPlusMinus - Allows the user to select a number or item from a previously set list.  
- B4XBreadCrumb - Navigation control.  
- B4XSeekBar - Horizontal or vertical seek bar / slider.  
- MadeWithLove - Show your love to B4X :)  
- B4XImageView - ImageView with useful resize modes: <https://www.b4x.com/android/forum/threads/b4x-b4ximageview-imageview-resize-modes.121359/>  
- XUIViewsUtils - Static code module with various utility methods.  
  
Dialogs:  
  
- B4XDialog - A class that provides the features required to show a dialog. There are three methods to show dialogs: Show - Shows a simple dialog with text, ShowCustom - Allows you to pass a layout of your own and show it as a dialog, ShowTemplate - Shows a dialog based on a template class. See the source code for the template structure. It is quite simple.  
  
Available templates:  
  
- B4XDateTemplate - Based on AnotherDatePicker.  
- B4XColorTemplate - Nice color picker.  
- B4XLongTextTemplate - Scrollable text.  
- B4XListTemplate - A list of items. The user can choose one of the items.  
- B4XSignatureTemplate - Captures the user signature and adds a timestamp to the bitmap.  
- B4XInputTemplate - Template for text and numeric inputs.  
- B4XSearchTemplate - A list with a search field. An evolution of SearchView.  
- B4XTimedTemplate - A template that wraps other templates and creates a dialog that closes automatically after the set time with a nice animated progress bar.  
- B4XProgressDialog - A template + its own dialog. Cross platform alternative to B4A ProgressDialogShow.  
  
It is simple to add more templates.  
Tutorial about B4XDialogs: <https://www.b4x.com/android/forum/threads/101197>  
  
More views and templates will be added in future versions.  
  
The examples projects are quite simple. Don't miss the following snippets:  
  
B4i:  

```B4X
Private Sub Page1_Resize(Width As Int, Height As Int)  
   If Dialog.Visible Then Dialog.Resize(Width, Height)  
End Sub  
  
Private Sub Application_Background  
   Dialog.Close(XUI.DialogResponse_Cancel)  
End Sub
```

  
B4A:  

```B4X
Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event  
  If KeyCode = KeyCodes.KEYCODE_BACK And Dialog.Close(XUI.DialogResponse_Cancel) Then Return True  
   Return False  
End Sub  
  
Sub Activity_Resume  
   'required to continue the animation after the activity is paused (only needed when not using B4XPages)  
   AnotherProgressBar1.Visible = True  
   B4XLoadingIndicator1.Show  
   B4XLoadingIndicator2.Show  
   ScrollingLabel1.Text = ScrollingLabel1.Text  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
   Dialog.Close (XUI.DialogResponse_Cancel)  
End Sub
```

  
B4J:  

```B4X
Sub MainForm_Resize (Width As Double, Height As Double)  
   If Dialog.Visible Then Dialog.Resize(Width, Height)  
End Sub
```

  
  
**Updates**  
  
V2.66 - B4XFloatTextField.ShowAcceptButtonWhenEmpty field. If True then the V button appears even if the text field is empty. It is True by default in B4i. This is useful to allow the user to hide the keyboard.  
V2.65 - B4XProgressDialog - new dialog, B4XLoadingIndicator - style can be changed programmatically, B4XFloatTextField.Enabled property.  
V2.60 - B4XDateTemplate.MonthsNames is public. You can use it to customize the names.  
V2.59 - B4XBreadCrumb.Base\_Resize and mBase are public now.  
V2.58 - B4XSeekBar.Base\_Resize is public now. You should call it in B4A after modifying B4XSeekBar.mBase size (it is called automatically in B4i, B4J).  
V2.56 - RoundSlider.SetRange - new method to set the min/max values at runtime.  
V2.55 - B4XFloatTextField - Fixes issue where TextChanged event is ready before the view is ready.  
V2.54 - Fixes a bug with B4XSeekBar in vertical mode, when min value > 0.  
V2.53 - SearchTemplate.PrefixOnly field. Set to true before setting the items to limit the index to prefix only matches. The index will be built much faster (~1000%).  
V2.52 - RoundSlider.RollOver designer property - roll over from min to max and vice versa is optional now. Roll over is unchecked by default.  
V2.51 - SwiftButton - Fix issue in B4A where a button in a ScrollView or CLV remains pushed when the list is scrolled.  
V2.50 - ScrollingLabel respects the designer text color property. Fix for error when ValueChanged event is not implemented.  
V2.49 - AnotherProgressBar.ProgressColor field - changes the color. Note that for the effect to look properly the three color channels should be less than 208 (D0).  
V2.48 - B4XDateTemplate.DaysOfWeekNames list. Allows changing the days titles: <https://www.b4x.com/android/forum/threads/b4xdatetemplate-replace-days-in-week-text.130842/post-823849>  
V2.47 - B4XSignatureTemplate.NumberOfPoints field - counts the number of points in the signature. Can be used to verify that the user actually drew something.  
V2.46 - B4XDateTemplate.CloseOnSelection field. Default value is True. True should be used when the Ok / Cancel buttons are hidden.  
Set to False if you want the user to select Ok or Cancel.  
V2.45 - New B4XRadioButton control:  
  
![](https://www.b4x.com/android/forum/attachments/110345)  
  
 new XUIViewsUtils.SetAlpha method  
V2.44 - XUIViewsUtils.CreateLabel and CreateB4XImageView methods. Note that you need to add B4XImageView.mBase to the layout tree.  
V2.43 - Fixes an issue with B4XDateTemplate where the min / max year settings are not handled properly.  
V2.42 - B4XImageView - New CornersRadius property and designer property.  
V2.41 - B4XSearchTemplate.AllowUnlistedText field. If set to true, the user can enter text not in the list.  
V2.40 - B4XImageView - new custom view: <https://www.b4x.com/android/forum/threads/b4x-b4ximageview-imageview-resize-modes.121359/>  
 XUIViewsUtils - code module with utility methods.  
 Haptic feedback added to B4XSwitch, B4XBreadCrumb, SwiftButton and B4XSwitchButton. It is not enabled by default for existing layouts. You need to set it in the designer.  
V2.37 - B4XFloatTextField - Fixes an issue in B4A where the keyboard doesn't appear after clicking on the reveal button. New *PasswordRevealChanged (Revealed As Boolean)* event.  
V2.34 - B4XFloatTextField - New FocusChanged event.  
V2.33 - B4XInputTemplate.SetBorderColor - new method.  
V2.32 - Fixes a bug introduced in V2.31 related to Dialog.GetButton.  
V2.31 - B4XFloatTextField - keyboard suggestions removed in password mode (relevant to B4A).  
v2.30 - SwiftButton - new Button Enabled designer property. Don't use the Enabled property that is under the "Common Properties".  
V2.29 - New MadeWithLove custom view: ![](https://www.b4x.com/basic4android/images/B4A_8vRB3JuB5K.png)  
Show your love to B4X and help us spread the word about B4X :)  
V2.28 - B4XFloatTextField - Tooltip property is honored (B4J only). New fields: HintLabelLargeOffsetX, HintLabelSmallOffsetX / Y - allow changing the hint offset.  
V2.27 - New B4XSeekBar1\_TouchStateChanged (Pressed As Boolean) event. This event is useful when you want to do something when the user started or finished interacting with the seek bar.  
V2.26 - B4XComboBox - Fixed bug with crash on missing event. New properties and methods: Size, IndexOf and SelectedItem.  
V2.24 - Fixes a bug in B4i where disabled B4XDialog buttons can be clicked.  
V2.23 - RoundSlider - New SetThumbColor and SetCircleColor methods.  
V2.22 - Fixed issue with B4XInputTemplate in iOS where the decimal symbol is a comma.  
V2.21 - Fixed issue with B4XSearchTemplate.Resize not working properly.  
V2.19 - SwiftButton.CornersRadius new designer property (and public field).  
V2.18 - B4XSeekBar.Interval field / designer property - Allows changing the values interval. Default value is 1.  
V2.17 - B4XInputTemplate.lblTitle field was previously removed by mistake. This update adds it back.  
V2.16 - Fixes an issue with B4XPlusMinus which caused it to remain in the "rapid" state after reaching the limits.  
  
V2.15 - New B4XSeekBar control: ![](https://www.b4x.com/basic4android/images/firefox_SLBrlt4Hga.png)  
Can be vertical or horizontal. Colors can be changed. Note that the ValueChanged event is only raised when the user changes the value.  
SwiftButton - New ButtonUp and ButtonDown events.  
  
V2.13 - Fixes a crash that happens on old Android devices when B4XFloatTextField HintText is empty.  
V2.12 - AnimatedCounter - Fade Color designer property. You can use it together with the background color property to change the counter colors.  
V2.11 - B4XDialog.ButtonsHeight (default 40dip) and TitleBarHeight (30dip) fields.  
V2.10 - B4XBreadCrumb control: (instructions - <https://www.b4x.com/android/forum/threads/b4x-xui-views-cross-platform-views-and-dialogs.100836/page-3#post-665765>)  
  
![](https://www.b4x.com/basic4android/images/V2LrgKPeKn.gif)  
  
V2.06 - B4XComboBox.B4iCancelButton string (only relevant to B4i). Default value is "Cancel". When this value is not an empty string the action sheet will show a Cancel button and will allow closing the sheet by clicking outside of the menu.  
V2.05 - New B4XPlusMinus control:  
  
![](https://www.b4x.com/basic4android/images/SS-2019-04-29_12.43.31.png)  
Tutorial: <https://www.b4x.com/android/forum/threads/b4x-b4xplusminus-spinner-wheel-alternative.105309/>  
[SPOILER="Older versions"]  
V2.01 - Fixes an issue with animated counter in B4A when targetSdkVersion is set to 28.  
V2.00 - Various internal views are now public. This was required to allow adding a light theme to preferences dialog: <https://www.b4x.com/android/forum/threads/b4x-b4xpreferencesdialog-cross-platform-forms.103842/>  
V1.91 - B4XSwitch.Enabled property. The thumb disappears when the switch is disabled.  
V1.90 - Many small changes and bug fixes.  
- B4XColorTemplate.SelectedColor can be set.  
V1.89 - ScrollingLabel.TextColor property.  
V1.88 - B4XDialog.ButtonsOrder field. Allows changing the order of buttons. For example:  

```B4X
Dialog.ButtonsOrder = Array As Int(XUI.DialogResponse_Cancel, XUI.DialogResponse_Positive, XUI.DialogResponse_Negative)
```

  
V1.87 - B4XListTemplate - support for multi-selection. New fields:  
SelectedItems - Holds the list of selected items. You can also set it to preselect items.  
AllowMultiSelection - Enable multi-selection.  
MultiSelectionMinimum - Minimum number of selected items required. Default value is 0.  
V1.86 - B4XFloatTextField - HintColor and NonFocusedHintColor fields are public. Call Update method after updating these colors.  
V1.85 - B4XComboBox.cmbBox field is public. Note that it only exists in B4J and B4A.  
V1.84 - SwiftButton - New Enabled property. Set to False to disable the button. It will change the button color to the "disabled color", make it flat and the not pressable.  
V1.83 - ScrollingLabel - New StartPositionDelay field. Default value is 800 (ms). Scrolling is paused for the set duration when the scroll position is 0.  
V1.82 - B4XListTemplate.CustomListView1 is public now. This allows changing the colors.  
V1.81 - B4XFloatTextField  
- NextField property. Pressing on enter or on the accept button will move the focus to the set B4XFloatTextField.  
- RequestFocusAndShowKeyboard method.  
  
V1.80 - B4XFloatTextField - Support for multiline fields and new accept button which triggers the EnterPressed event and closes the keyboard (especially important in iOS).  
  
![](https://www.b4x.com/basic4android/images/SS-2019-01-22_16.16.35.png)  
  
V1.77 - SwiftButton.SetColors - allows changing the colors at runtime.  
V1.76 - Keyboard type option added to B4XFloatTextField. It affects the keyboard type in B4A and B4i.  
V1.75 - New B4XSwitch control:  
  
![](https://www.b4x.com/android/forum/attachments/76526)  
  
V1.70 - New B4XTimedTemplate. This template wraps other templates and creates an auto-closing dialog:  
  
![](https://www.b4x.com/android/forum/attachments/76420)  
  
See the "options / select animal" dialog for an example. It is very simple to use.  
- AnotherProgressBar - The change speed can be set with ValueChangePerSecond field. This allows using the progress bar as a visual timer. For example to show 5 seconds progress:  

```B4X
AnotherProgressBar1.ValueChangePerSecond = 100 / 5  
AnotherProgressBar1.SetValueNoAnimation(0) 'set the value immediately.  
AnotherProgressBar1.Value = 100 'animate to 100. It will take 5 seconds.
```

  
  
  
V1.67 - Tag field added to the custom views. You can set it with the designer or at runtime.  
- B4XDialog - New fields: TitleBarTextColor, TitleBarFont and ButtonsFont. See the signature dialog for an example (the buttons font is set to FontAwesome):  
  
![](https://www.b4x.com/basic4android/images/SS-2019-01-16_15.10.12.png)  
  
- B4XDialog - All text fields of B4XDialog accept CSBuilder objects as well as strings (B4A and B4i).  
- AnotherProgressBar is no longer limited to indeterminate state. You can modify the Value field to change its position. Note that the change is animated.  
Click on the Animated Counter button in the example to see it.  
  
  
V1.66 - All mBase views are now public and their tag is set to the custom view instance. This makes it simpler to get a custom view from the layout tree.  
V1.65 - New dialog template: B4XSearchTemplate  
  
![](https://www.b4x.com/basic4android/images/SS-2019-01-15_15.37.09.png)  
  
V1.64 - Better behavior of B4XDialog and B4XInputTemplate with short screens.  
V1.63 - Fixes an issue with B4XLongTextTemplate when the text is shorter than the dialog.  
V1.62 - Small update to B4i ListTemplate layout file.  
  
A custom "list of colors" dialog added to the example:  
  
![](https://www.b4x.com/basic4android/images/SS-2019-01-13_09.14.00.png)  
  
V1.61 - Allows setting the Text property of B4XInputTemplate.  
  
V1.60 - B4XFloatTextField reveal button in password mode:  
  
![](https://www.b4x.com/android/forum/attachments/76134)  
  
V1.55 - B4XComboBox.DelayBeforeChangeEvent - Used to prevent rapid events when scrolling the list with the keyboard. Default value is 500ms in B4J and 0 in other platforms (not used).  
  
V1.50 - B4XInputTemplate - preset configurations for numeric inputs (ConfigureForNumbers)  
  
V1.45 - B4XFloatTextField:  
  
- EnterPressed and TextChanged events.  
- Optional clear button.  
- Bug fixes.  
  
V1.40 - B4XFloatTextField password mode (in the designer)  
  
V1.35 - New B4XFloatTextField:  
  
![](https://www.b4x.com/android/forum/attachments/75867)  
  
V1.30 - New B4XSignatureTemplate:  
  
![](https://www.b4x.com/android/forum/attachments/75787)  
  
V1.20 - New AnimatedCounter custom view:  
  
![](https://www.b4x.com/basic4android/images/animated_counter.gif)  
  
V1.10 - New B4XInputTemplate - See post #2.  
[/SPOILER]  
  
  
**XUI Views is an internal library.**   
  
Notes:  

- B4J only - if you are using B4XFloatTextField in multiline mode and the top padding is too short: <https://www.b4x.com/android/forum/threads/xui-view-2-19-increased-the-top-padding.112630/post-702284>