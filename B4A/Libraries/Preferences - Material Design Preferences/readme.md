### Preferences - Material Design Preferences by corwin42
### 07/21/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/75482/)

This library provides a framework to create nice looking Material Design Preferences down to API9. It uses [this GitHub project](https://github.com/consp1racy/android-support-preference) to fix some bugs in the android support preferences stuff. It also adds some nice features like simple icon tinting, simple menu list preferences and a color picker.  
  
For a guide on how to implement settings for Material Design read [this](https://material.io/guidelines/patterns/settings.html).  
  
**[SIZE=4]Installation:[/SIZE]**  

- Extract all of the PreferencesLibX\_XX.zip file to your additional libraries folder. These are .xml, .jar, 4 .aar files.
- Requires [AppCompat library](https://www.b4x.com/android/forum/threads/appcompat-make-material-design-apps-compatible-with-older-android-versions.48423/).
- Requires B4A 6.31+

minimum SDK Version: 14  
Needs support library 27  
  
If you are updating you can delete the old library aar files.  
  
[SIZE=4]****[SIZE=4]Your Support:[/SIZE]****[/SIZE]  
  
> Creating libraries and wrappers for existing library projects is a lot of work. The use of this library is totally free and you even don't need to mention in your app that you use it.

  
> [SIZE=4]But if you use this library in your projects and you think it is useful to you please consider to make a donation: [![](https://www.paypalobjects.com/en_GB/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=DXVM82RPLJZS8)  
>   
> Thanks very much for your support.[/SIZE]

  
**[SIZE=4]Usage:[/SIZE]**  
  
You need to use AppCompat Library together with this library.  
Don't forget to add the Preference library to your project.  
  
1. Enhance your theme in manifest editor  
Add a preferenceTheme item and the two items for the IconTint:  

```B4X
CreateResource(values, theme.xml,  
<resources>  
    <style name="MyAppTheme" parent="@style/Theme.AppCompat.Light.DarkActionBar">  
        <item name="colorPrimary">#0098FF</item>  
        <item name="colorPrimaryDark">#007CF5</item>  
        <item name="colorAccent">#FF5522</item>  
        <item name="windowNoTitle">true</item>  
        <item name="windowActionBar">false</item>  
        <item name="preferenceTheme">@style/PreferenceThemeOverlay.Material</item>  
        <item name="asp_preferenceIconTint">?colorAccent</item>  
        <item name="asp_preferenceDialogIconTint">?asp_preferenceIconTint</item>  
        <item name="windowActionModeOverlay">true</item>  
    </style>  
</resources>  
)
```

  
  
2. Extend from AppCompatPreferenceActivity  

```B4X
#Extends: de.amberhome.preferences.AppCompatPreferenceActivity
```

  
  
3. Add PreferenceView to your Layout (with designer or by code)  
![](https://www.b4x.com/android/forum/attachments/52214)  
  
4. Load the Layout in Activity\_Create() as normal  
  
5. Create your Preference elements in PreferenceView\_Ready() event.  
  
See the example for detailed usage.  
  
The example has minSdkVersion set to 14. This is because the MaterialDateTimePicker needs this. The Preference library itself will work with a minimal SDK version of 9.  
  
The example projects additionally needs MaterialDateTimePicker, XMLLayoutBuilder and DateUtils libraries.  
  
**[SIZE=4]Reference:[/SIZE]**  
> **Preferences  
> Author:** Markus Stipp  
> **Version:** 1.11  
>
> - **CheckBoxPreference**
> Events:
>
> - **PreferenceChanged** (Preference As Preference, NewValue As Object)
> - **PreferenceClicked** (Preference As Preference)
>
> - **Methods:**
>
> - **Initialize** (PreferenceView As PreferenceViewWrapper, EventName As String, Key As String, DefaultValue As Object)
> *Initializes the object*- **IsInitialized As Boolean**
>
> - **Properties:**
>
> - **Checked As Boolean**
> - **DefaultValue As Object** *[write only]*
> - **Dependency As String**
> - **DisableDependentsState As Boolean**
> - **Enabled As Boolean**
> - **Icon As Drawable**
> - **IconPaddingEnabled As Boolean** *[write only]*
> - **IconTintEnabled As Boolean** *[write only]*
> - **Intent As Intent**
> - **Key As String**
> - **Order As Int**
> - **Persistent As Boolean**
> - **Selectable As Boolean**
> - **Summary As String**
> - **SummaryOffText As CharSequence**
> - **SummaryOnText As CharSequence**
> - **SummaryTextColor As Int** *[write only]*
> - **Title As String**
> - **TitleTextColor As Int** *[write only]*
> - **Visible As Boolean**
>
> - **ColorPreference**
> Events:
>
> - **PreferenceChanged** (Preference As Preference, NewValue As Object)
> - **PreferenceClicked** (Preference As Preference)
>
> - **Methods:**
>
> - **GetNameForColor** (Color As Int) **As CharSequence**
> - **Initialize** (PreferenceView As PreferenceViewWrapper, EventName As String, Key As String, DefaultValue As Object)
> *Initializes the object*- **IsInitialized As Boolean**
>
> - **Properties:**
>
> - **Color As Int**
> - **ColorNames()() As CharSequence**
> - **ColorValues()() As Int**
> - **ColumnCount As Int**
> - **DefaultValue As Object** *[write only]*
> - **Dependency As String**
> - **DialogIcon As Drawable**
> - **DialogIconTintEnabled As Boolean** *[write only]*
> - **DialogTitle As CharSequence**
> - **Enabled As Boolean**
> - **Icon As Drawable**
> - **IconPaddingEnabled As Boolean** *[write only]*
> - **IconTintEnabled As Boolean** *[write only]*
> - **Intent As Intent**
> - **Key As String**
> - **NegativeButtonText As CharSequence**
> - **Order As Int**
> - **Persistent As Boolean**
> - **PositiveButtonText As CharSequence**
> - **Selectable As Boolean**
> - **Summary As String**
> - **SummaryTextColor As Int** *[write only]*
> - **SwatchSize As Int**
> - **Title As String**
> - **TitleTextColor As Int** *[write only]*
> - **Visible As Boolean**
>
> - **EditTextPreference**
> Events:
>
> - **EditTextCreated** (Edit As EditText)
> - **PreferenceChanged** (Preference As Preference, NewValue As Object)
> - **PreferenceClicked** (Preference As Preference)
>
> - **Methods:**
>
> - **Initialize** (PreferenceView As PreferenceViewWrapper, EventName As String, Key As String, DefaultValue As Object)
> *Initializes the object*- **IsInitialized As Boolean**
>
> - **Properties:**
>
> - **DefaultValue As Object** *[write only]*
> - **Dependency As String**
> - **DialogIcon As Drawable**
> - **DialogIconTintEnabled As Boolean** *[write only]*
> - **DialogMessage As CharSequence**
> - **DialogTitle As CharSequence**
> - **Enabled As Boolean**
> - **Icon As Drawable**
> - **IconPaddingEnabled As Boolean** *[write only]*
> - **IconTintEnabled As Boolean** *[write only]*
> - **Intent As Intent**
> - **Key As String**
> - **NegativeButtonText As CharSequence**
> - **Order As Int**
> - **Persistent As Boolean**
> - **PositiveButtonText As CharSequence**
> - **Selectable As Boolean**
> - **Summary As String**
> - **SummaryTextColor As Int** *[write only]*
> - **Text As String**
> - **Title As String**
> - **TitleTextColor As Int** *[write only]*
> - **Visible As Boolean**
>
> - **ListPreference**
> Events:
>
> - **PreferenceChanged** (Preference As Preference, NewValue As Object)
> - **PreferenceClicked** (Preference As Preference)
>
> - **Fields:**
>
> - **MENU\_MODE\_DIALOG As Int**
> - **MENU\_MODE\_SIMPLE\_ADAPTIVE As Int**
> - **MENU\_MODE\_SIMPLE\_DIALOG As Int**
> - **MENU\_MODE\_SIMPLE\_MENU As Int**
>
> - **Methods:**
>
> - **Initialize** (PreferenceView As PreferenceViewWrapper, EventName As String, Key As String, DefaultValue As Object)
> *Initializes the object*- **IsInitialized As Boolean**
>
> - **Properties:**
>
> - **DefaultValue As Object** *[write only]*
> - **Dependency As String**
> - **DialogIcon As Drawable**
> - **DialogIconTintEnabled As Boolean** *[write only]*
> - **DialogTitle As CharSequence**
> - **Enabled As Boolean**
> - **Entries As Map**
> - **Icon As Drawable**
> - **IconPaddingEnabled As Boolean** *[write only]*
> - **IconTintEnabled As Boolean** *[write only]*
> - **Intent As Intent**
> - **Key As String**
> - **MenuMode As Int**
> - **NegativeButtonText As CharSequence**
> - **Order As Int**
> - **Persistent As Boolean**
> - **PositiveButtonText As CharSequence**
> - **Selectable As Boolean**
> - **SimpleMenuPreferredWidthUnit As Float**
> - **Summary As String**
> - **SummaryTextColor As Int** *[write only]*
> - **Title As String**
> - **TitleTextColor As Int** *[write only]*
> - **Value As String**
> - **Visible As Boolean**
>
> - **MultiSelectListPreference**
> Events:
>
> - **PreferenceChanged** (Preference As Preference, NewValue As List)
> - **PreferenceClicked** (Preference As Preference)
>
> - **Methods:**
>
> - **Initialize** (PreferenceView As PreferenceViewWrapper, EventName As String, Key As String, DefaultValue As List)
> *Initializes the object*- **IsInitialized As Boolean**
>
> - **Properties:**
>
> - **DefaultValue As Object** *[write only]*
> - **Dependency As String**
> - **DialogIcon As Drawable**
> - **DialogIconTintEnabled As Boolean** *[write only]*
> - **DialogTitle As CharSequence**
> - **Enabled As Boolean**
> - **Entries As Map**
> - **Icon As Drawable**
> - **Intent As Intent**
> - **Key As String**
> - **NegativeButtonText As CharSequence**
> - **Order As Int**
> - **Persistent As Boolean**
> - **PositiveButtonText As CharSequence**
> - **Selectable As Boolean**
> - **SelectedItems() As Boolean** *[read only]*
> - **Summary As String**
> - **Title As String**
> - **Values As List**
> - **Visible As Boolean**
>
> - **Preference**
> Events:
>
> - **PreferenceChanged** (Preference As Preference, NewValue As Object)
> - **PreferenceClicked** (Preference As Preference)
>
> - **Methods:**
>
> - **Initialize** (PreferenceView As PreferenceViewWrapper, EventName As String, Key As String, DefaultValue As Object)
> *Initializes the object*- **IsInitialized As Boolean**
>
> - **Properties:**
>
> - **DefaultValue As Object** *[write only]*
> - **Dependency As String**
> - **Enabled As Boolean**
> - **Icon As Drawable**
> - **Intent As Intent**
> - **Key As String**
> - **Order As Int**
> - **Persistent As Boolean**
> - **Selectable As Boolean**
> - **Summary As String**
> - **Title As String**
> - **Visible As Boolean**
>
> - **PreferenceCategory**
> Events:
>
> - **PreferenceChanged** (Preference As Preference, NewValue As Object)
> - **PreferenceClicked** (Preference As Preference)
>
> - **Methods:**
>
> - **AddCategory** (EventName As String, Key As String, Title As String) **As PreferenceCategoryWrapper**
> - **AddCheckBoxPreference** (EventName As String, Key As String, Title As String, SummaryOn As String, SummaryOff As String, Default As Boolean) **As CheckBoxPreferenceWrapper**
> - **AddColorPreference** (EventName As String, Key As String, Title As String, Summary As String, Default As Int, Colors() As Int, Names() As String) **As ColorPreferenceWrapper**
> - **AddEditTextPreference** (EventName As String, Key As String, Title As String, Summary As String, Default As String) **As EditTextPreferenceWrapper**
> - **AddListPreference** (EventName As String, Key As String, Title As String, Summary As String, Default As String, Values() As String, Texts() As String) **As ListPreferenceWrapper**
> - **AddMultiSelectListPreference** (EventName As String, Key As String, Title As String, Summary As String, Default As List, Values() As String, Texts() As String) **As MultiSelectListPreferenceWrapper**
> - **AddPreference** (Pref As Preference) **As Boolean**
> - **AddSeekBarDialogPreference** (EventName As String, Key As String, Title As String, Summary As String, Default As Int, Min As Int, Max As Int) **As SeekBarDialogPreferenceWrapper**
> - **AddSeekBarPreference** (EventName As String, Key As String, Title As String, Summary As String, Default As Int, Min As Int, Max As Int) **As SeekBarPreferenceWrapper**
> - **AddSimplePreference** (EventName As String, Key As String, Title As String, Summary As String, Default As String) **As SimplePreferenceWrapper**
> - **AddSwitchPreference** (EventName As String, Key As String, Title As String, SummaryOn As String, SummaryOff As String, Default As Boolean) **As SwitchPreferenceWrapper**
> - **FindPreference** (Key As String) **As Preference**
> - **GetPreference** (Index As Int) **As Preference**
> - **Initialize** (PreferenceView As PreferenceViewWrapper, EventName As String, Key As String, DefaultValue As Object)
> *Initializes the object*- **IsInitialized As Boolean**
> - **RemoveAll**
> - **RemovePreference** (Pref As Preference)
>
> - **Properties:**
>
> - **DefaultValue As Object** *[write only]*
> - **Dependency As String**
> - **Enabled As Boolean**
> - **Icon As Drawable**
> - **IconPaddingEnabled As Boolean** *[write only]*
> - **IconTintEnabled As Boolean** *[write only]*
> - **Intent As Intent**
> - **Key As String**
> - **Order As Int**
> - **Persistent As Boolean**
> - **PreferenceCount As Int** *[read only]*
> - **Selectable As Boolean**
> - **Summary As String**
> - **SummaryTextColor As Int** *[write only]*
> - **Title As String**
> - **TitleTextColor As Int** *[write only]*
> - **Visible As Boolean**
>
> - **PreferenceManager**
> Methods:
>
> - **ClearAll**
> *Clears all stored entries.*- **GetAll As Map**
> *Returns a Map with all the Keys and Values. Note that changes to this map will not affect the stored values.*- **GetBoolean** (Key As String) **As Boolean**
> *Returns the Boolean value mapped to the given key. Returns False if the key is not found.*- **GetBoolean2** (Key As String, Default As Boolean) **As Boolean**
> *Returns the Boolean value mapped to the given key. Returns the default value if the key is not found.*- **GetInt** (Key As String) **As Int**
> - **GetInt2** (Key As String, Default As Int) **As Int**
> - **GetList** (Key As String) **As List**
> - **GetList2** (Key As String, Default As List) **As List**
> - **GetLong** (Key As String) **As Long**
> *Returns the Long value mapped to the given key. Returns -1 if the key is not found.*- **GetLong2** (Key As String, Default As Long) **As Long**
> *Returns the Long value mapped to the given key. Returns the default value if the key is not found.*- **GetString** (Key As String) **As String**
> *Returns the String value mapped to the given key. Returns an empty string if the key is not found.*- **GetString2** (Key As String, Default As String) **As String**
> *Return the String value mapped to the given key. Returns the default value if the key is not found.*- **GetUpdatedKeys As List**
> *Returns a list with the keys that were updated since the last call to GetUpdatedKeys.  
>  Note that the updated keys may include keys with unchanged values.*- **SetBoolean** (Key As String, Value As Boolean)
> *Maps the given key to the given Boolean value.*- **SetInt** (Key As String, Value As Int)
> - **SetList** (Key As String, Values As List)
> *Maps the given key to the given List.*- **SetLong** (Key As String, Value As Long)
> *Maps the given key to the given Long value.*- **SetString** (Key As String, Value As String)
> *Maps the given key to the given String value.*
> - **PreferenceView**
> Events:
>
> - **Ready** (Preference As PreferenceView)
>
> - **Methods:**
>
> - **AddCategory** (EventName As String, Key As String, Title As String) **As PreferenceCategoryWrapper**
> - **AddCheckBoxPreference** (EventName As String, Key As String, Title As String, SummaryOn As String, SummaryOff As String, Default As Boolean) **As CheckBoxPreferenceWrapper**
> - **AddColorPreference** (EventName As String, Key As String, Title As String, Summary As String, Default As Int, Colors() As Int, Names() As String) **As ColorPreferenceWrapper**
> - **AddEditTextPreference** (EventName As String, Key As String, Title As String, Summary As String, Default As String) **As EditTextPreferenceWrapper**
> - **AddListPreference** (EventName As String, Key As String, Title As String, Summary As String, Default As String, Values() As String, Texts() As String) **As ListPreferenceWrapper**
> - **AddMultiSelectListPreference** (EventName As String, Key As String, Title As String, Summary As String, Default As List, Values() As String, Texts() As String) **As MultiSelectListPreferenceWrapper**
> - **AddPreference** (Pref As Preference)
> - **AddSeekBarDialogPreference** (EventName As String, Key As String, Title As String, Summary As String, Default As Int, Min As Int, Max As Int) **As SeekBarDialogPreferenceWrapper**
> - **AddSeekBarPreference** (EventName As String, Key As String, Title As String, Summary As String, Default As Int, Min As Int, Max As Int) **As SeekBarPreferenceWrapper**
> - **AddSimplePreference** (EventName As String, Key As String, Title As String, Summary As String, Default As String) **As SimplePreferenceWrapper**
> - **AddSwitchPreference** (EventName As String, Key As String, Title As String, SummaryOn As String, SummaryOff As String, Default As Boolean) **As SwitchPreferenceWrapper**
> - **DesignerCreateView** (base As PanelWrapper, lw As LabelWrapper, props As Map)
> - **Initialize** (EventName As String, Parent As ViewGroup)
>
> - **SeekBarDialogPreference**
> - **Events:**
>
> - **PreferenceChanged** (Preference As Preference, NewValue As Object)
> - **PreferenceClicked** (Preference As Preference)
>
> - **Methods:**
>
> - **Initialize** (PreferenceView As PreferenceViewWrapper, EventName As String, Key As String, DefaultValue As Object)
> *Initializes the object*- **IsInitialized As Boolean**
>
> - **Properties:**
>
> - **DefaultValue As Object** *[write only]*
> - **Dependency As String**
> - **DialogIcon As Drawable**
> - **DialogIconTintEnabled As Boolean** *[write only]*
> - **DialogMessage As CharSequence**
> - **DialogTitle As CharSequence**
> - **Enabled As Boolean**
> - **Icon As Drawable**
> - **IconPaddingEnabled As Boolean** *[write only]*
> - **IconTintEnabled As Boolean** *[write only]*
> - **Intent As Intent**
> - **Key As String**
> - **Max As Int**
> - **Min As Int**
> - **NegativeButtonText As CharSequence**
> - **Order As Int**
> - **Persistent As Boolean**
> - **PositiveButtonText As CharSequence**
> - **Progress As Int**
> - **Selectable As Boolean**
> - **Summary As String**
> - **SummaryTextColor As Int** *[write only]*
> - **Title As String**
> - **TitleTextColor As Int** *[write only]*
> - **Visible As Boolean**
>
> - **SeekBarPreference**
> Events:
>
> - **PreferenceChanged** (Preference As Preference, NewValue As Object)
> - **PreferenceClicked** (Preference As Preference)
> - **ProgressChanged** (Progress As Int, UserChanged As Boolean)
>
> - **Methods:**
>
> - **Initialize** (PreferenceView As PreferenceViewWrapper, EventName As String, Key As String, DefaultValue As Object)
> *Initializes the object*- **IsInitialized As Boolean**
>
> - **Properties:**
>
> - **Adjustable As Boolean**
> - **DefaultValue As Object** *[write only]*
> - **Dependency As String**
> - **Enabled As Boolean**
> - **Icon As Drawable**
> - **IconPaddingEnabled As Boolean** *[write only]*
> - **IconTintEnabled As Boolean** *[write only]*
> - **Info As CharSequence**
> - **Intent As Intent**
> - **Key As String**
> - **Max As Int**
> - **Min As Int**
> - **Order As Int**
> - **Persistent As Boolean**
> - **SeekBarIncrement As Int**
> - **Selectable As Boolean**
> - **ShowValue As Boolean**
> - **Summary As String**
> - **SummaryTextColor As Int** *[write only]*
> - **Title As String**
> - **TitleTextColor As Int** *[write only]*
> - **Value As Int**
> - **Visible As Boolean**
>
> - **SimplePreference**
> Events:
>
> - **PreferenceChanged** (Preference As Preference, NewValue As Object)
> - **PreferenceClicked** (Preference As Preference)
> - **PreferenceLongClicked** (Preference As Preference))
>
> - **Methods:**
>
> - **Initialize** (PreferenceView As PreferenceViewWrapper, EventName As String, Key As String, DefaultValue As Object)
> *Initializes the object*- **IsInitialized As Boolean**
>
> - **Properties:**
>
> - **DefaultValue As Object** *[write only]*
> - **Dependency As String**
> - **Enabled As Boolean**
> - **Icon As Drawable**
> - **IconPaddingEnabled As Boolean** *[write only]*
> - **IconTintEnabled As Boolean** *[write only]*
> - **Intent As Intent**
> - **Key As String**
> - **Order As Int**
> - **Persistent As Boolean**
> - **Selectable As Boolean**
> - **Summary As String**
> - **SummaryTextColor As Int** *[write only]*
> - **Title As String**
> - **TitleTextColor As Int** *[write only]*
> - **Visible As Boolean**
>
> - **SwitchPreference**
> Events:
>
> - **PreferenceChanged** (Preference As Preference, NewValue As Object)
> - **PreferenceClicked** (Preference As Preference)
>
> - **Methods:**
>
> - **Initialize** (PreferenceView As PreferenceViewWrapper, EventName As String, Key As String, DefaultValue As Object)
> *Initializes the object*- **IsInitialized As Boolean**
>
> - **Properties:**
>
> - **Checked As Boolean**
> - **DefaultValue As Object** *[write only]*
> - **Dependency As String**
> - **DisableDependentsState As Boolean**
> - **Enabled As Boolean**
> - **Icon As Drawable**
> - **IconPaddingEnabled As Boolean** *[write only]*
> - **IconTintEnabled As Boolean** *[write only]*
> - **Intent As Intent**
> - **Key As String**
> - **Order As Int**
> - **Persistent As Boolean**
> - **Selectable As Boolean**
> - **Summary As String**
> - **SummaryOffText As CharSequence**
> - **SummaryOnText As CharSequence**
> - **SummaryTextColor As Int** *[write only]*
> - **Title As String**
> - **TitleTextColor As Int** *[write only]*
> - **Visible As Boolean**

  
**[SIZE=4]History:[/SIZE]**  
V1.00:  

- Initial version

V1.01:  

- Fix: Change packagename to anywheresoftware.b4a.orbjects to reduce resource fields

V1.10:  

- New: MultiSelectListPreference

V1.11  

- Fix: Removed DialogMessage property from dialogs with lists (not supported)
- Fix: Added missing properties to MultiSelectPreference

V1.12  

- Fix: PreferenceCategory.AddMultiSelectListPreference() should work now
- Fix: AddPreference() should work with all preferences
- New: Added RemoveKey() to PreferenceManager
- Fix: Remove internal resource files

V1.14  

- Fix: Fix crash on screen rotation
- Fix: Updated to support-preferences library 1.2.7 (fixes crash with ringtone manager on Samsung devices, fixes memory leak)
- New: Better support for CharSequences

V2.00  

- Fix: Updated to support-preferences library 2.2.0 (fixes crashes with support libraries 27)

V3.00  

- Fix: Should work with androidx support libraries.
- Fix: Updated to support-prefernces library 3.0.0dev
- Attention: Removed RingtonePreference since it is not supported by androidx support library anymore!

**[SIZE=4]ToDo:[/SIZE]**  

- Currently there is nearly no popup help.

  
**Erel:**   
  
With B4A v13+ you need to add:  

```B4X
#AdditionalJar: androidx.customview:customview-poolingcontainer  
#MultiDex: true
```

  
<https://www.b4x.com/android/forum/threads/error-with-beta-13.162150/post-994887>