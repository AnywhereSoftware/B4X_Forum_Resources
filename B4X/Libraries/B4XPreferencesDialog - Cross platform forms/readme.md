###  B4XPreferencesDialog - Cross platform forms by Erel
### 11/12/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/103842/)

![](https://www.b4x.com/basic4android/images/SS-2019-04-10_17.33.40.png)  
  
[MEDIA=vimeo]324972426[/MEDIA]  
  
B4XPreferencesDialog makes it easy to create dialogs with all kinds of input fields.  
  
The main steps required to use these dialogs are:  
  
1. Define the list of fields. The recommended way to do it is with Forms Builder tool:  
  
<https://www.b4x.com/android/forum/threads/b4x-forms-builder-designer-for-b4xpreferencesdialog.104670/>  
  
The template file is loaded with:  

```B4X
prefdialog.LoadFromJson(File.ReadString(File.DirAssets, "Example.json"))
```

  
Note that you can either set the list of options inside the template or programmatically by calling SetOptions.  
  
2. Call ShowDialog and pass the data map. It can be an empty map or a map where some of the fields are already set.  

```B4X
'Options1 is a Map object  
Wait For (prefdialog.ShowDialog(Options1, "OK", "CANCEL")) Complete (Result As Int)  
If Result = xui.DialogResponse_Positive Then  
   PrintOptions(Options1, TextArea1)  
End If
```

  
The data map will be updated when the user clicks on the OK button.  
  
You can use the same dialog to show different data maps. See the attached examples. The examples also show how to save and load the data maps using B4XSerializator.  
  
Platform specific instructions:  
  
**B4A**  
  

```B4X
'Handle the back key (see the example project for B4XPages implementation)  
Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event  
   If KeyCode = KeyCodes.KEYCODE_BACK Then  
       If prefdialog.BackKeyPressed Then Return True  
   End If  
   Return False  
End Sub  
  
'Handle keyboard changes:  
Sub IME_HeightChanged (NewHeight As Int, OldHeight As Int)  
   prefdialog.KeyboardHeightChanged(NewHeight)  
End Sub
```

  
  
Manifest editor:  

```B4X
SetActivityAttribute(main, android:windowSoftInputMode, adjustResize|stateHidden)
```

  
  
**B4i**  
  

```B4X
'Handle keyboard changes  
Sub Page1_KeyboardStateChanged (Height As Float)  
   prefdialog.KeyboardHeightChanged(Height)  
End Sub
```

  
  
**Dependencies:**  
  
B4A / B4J - ByteConverter (<https://www.b4x.com/android/forum/threads/6787/#content>). Note that it will be an internal library in the next version.  
  
**Updates**  
  
V1.75 - Fixes a bug where the title of color items was missing.  
V1.74 - Several bug fixes. New BeforeDialogDisplayed event that allows customizing the dialogs buttons. New DefaultHintFont and DefaultHintLargeSize fields.  
V1.73 - Color field accepts text input:  
  
![](https://www.b4x.com/android/forum/attachments/112412)  
New dependency: ByteConverter (B4A and B4J)  
  
V1.71 - Fix issue with 24 hours mode.  
V1.66 - 24 hours mode for time items:  
  
![](https://www.b4x.com/basic4android/images/B4i_0TX3wrm9sF.png)  
Set this mode with forms builder by writing 24 in the options field.  
  
V1.65 - New Explanation item. This is a non-editable item that can be used to provide more information. Note that the explanation text is part of the template. It can be set with the form builder or at runtime (when the item is added or with the new SetExplanation method).  
V1.62 - Fixes an issue in B4A where the dialog can scroll to one of the text fields after returning from an inner dialog.  
V1.61 - Fixes an issue with numeric range fields not being set.  
V1.60 - Two new item types: Time and Numeric Range.  
  
![](https://www.b4x.com/basic4android/images/SS-2019-04-29_12.43.31.png)  
Depends on XUI Views v2.05+.  
  
The Time item returns a Period object. The attached examples show how to use it to get a date and time value.  
  
V1.50 - Two new item types: Multiline Text and Decimal Number.  
- Bug fix related to the light theme and text fields.  
- Empty non-required numeric fields are not treated as invalid values. Note that the returned map will not include keys with empty string values.  
  
V1.40 - Adds an IsValid event that you can use to validate the data before it is committed.  
In order to use it you need to first call:  

```B4X
pref.SetEventsListener(Me, "Pref") 'sets the callback and event name.
```

  
Handle the event:  

```B4X
'Number value should be between 1 to 50. If not we call ScrollToItemWithError and return False.  
'You can check all fields here.  
Sub Pref_IsValid (TempData As Map) As Boolean  
   Dim number As Int = TempData.GetDefault("Number", 0)  
   If number < 1 Or number > 50 Then  
       pref.ScrollToItemWithError("Number")  
       Return False  
   End If  
   Return True  
End Sub
```

  
  
V1.30 - Support for dark and light themes. Set it with the form builder or the Theme property.  
  
XUI Views v2.00+ is now required.  
  
V1.20 - Support for json templates, required fields and other minor improvements.  
V1.10 - New ShortOptions item based on B4XComboBox. This item is useful when there are a few options to choose from (unlike Options item which opens a new dialog and is more suitable for larger lists).  
Other bug fixes and improvements.  
  
**B4XPreferencesDialog is an internal library.**