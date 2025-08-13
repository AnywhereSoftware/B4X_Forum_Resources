###  [XUI] AS Settings by Alexander Stolte
### 04/07/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/147435/)

Introducing a new library that allows you to create your own settings page with minimal code. This library comes equipped with automatic saving and loading features, making it incredibly easy to manage your settings. It supports booleans, free text, numbers, comboboxes, action buttons and more, giving you a wide range of options to customize your settings page. With this library, you can quickly and easily create a professional-looking settings page for your application or app without having to worry about complicated coding.  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
 **![](https://www.b4x.com/android/forum/attachments/141207) ![](https://www.b4x.com/android/forum/attachments/141209)  
It uses conditional symbols in order to avoid adding dependencies when a feature is not required.**  
[TABLE]  
[TR]  
[TD]

**Feature**

[/TD]  
  
[TD]**Tutorial**[/TD]  
  
[TD]

**Comments**

[/TD]  
[/TR]  
[TR]  
[TD]Boolean[/TD]  
[TD]<https://www.b4x.com/android/forum/threads/b4x-as-settings-boolean-property.159261/>[/TD]  
[TD]![](https://www.b4x.com/android/forum/attachments/150843)[/TD]  
[/TR]  
[TR]  
[TD]Action[/TD]  
[TD]<https://www.b4x.com/android/forum/threads/b4x-as-settings-action-property.159263/>[/TD]  
[TD]![](https://www.b4x.com/android/forum/attachments/150845)[/TD]  
[/TR]  
[TR]  
[TD]ActionClean[/TD]  
[TD]<https://www.b4x.com/android/forum/threads/b4x-as-settings-actionclean-property.159264/>[/TD]  
[TD]![](https://www.b4x.com/android/forum/attachments/150847)[/TD]  
[/TR]  
[TR]  
[TD]Text[/TD]  
[TD]<https://www.b4x.com/android/forum/threads/b4x-as-settings-text-property.159265/>[/TD]  
[TD]![](https://www.b4x.com/android/forum/attachments/150850)[/TD]  
[/TR]  
[TR]  
[TD]ComboBox[/TD]  
[TD]<https://www.b4x.com/android/forum/threads/b4x-as-settings-combobox-property.159266/#post-977923>[/TD]  
[TD]![](https://www.b4x.com/android/forum/attachments/150853)[/TD]  
[/TR]  
[TR]  
[TD]SelectionList[/TD]  
[TD]<https://www.b4x.com/android/forum/threads/b4x-as-settings-selectionlist-property.159217/>[/TD]  
[TD]![](https://www.b4x.com/android/forum/attachments/158168)[/TD]  
[/TR]  
[TR]  
[TD]SegmentedTab[/TD]  
[TD]<https://www.b4x.com/android/forum/threads/b4x-as-settings-with-segmentedtab.148104/>[/TD]  
  
[TD]

![](https://www.b4x.com/android/forum/attachments/142234)

[/TD]  
[/TR]  
[TR]  
[TD]PlusMinus[/TD]  
[TD]<https://www.b4x.com/android/forum/threads/b4x-as-settings-with-plusminus.148105/>[/TD]  
  
[TD]

![](https://www.b4x.com/android/forum/attachments/142235)

[/TD]  
[/TR]  
[TR]  
[TD]DatePicker[/TD]  
[TD]<https://www.b4x.com/android/forum/threads/b4x-as-settings-with-as-bottomdatepicker.149566/>[/TD]  
  
[TD]

![](https://www.b4x.com/android/forum/attachments/144745)

[/TD]  
[/TR]  
[TR]  
[TD]TimePicker[/TD]  
[TD]<https://www.b4x.com/android/forum/threads/b4x-as-settings-with-as-timepickerdialog.149569/>[/TD]  
  
[TD]

![](https://www.b4x.com/android/forum/attachments/144746)

[/TD]  
[/TR]  
[TR]  
[TD]DescriptionItem[/TD]  
[TD]<https://www.b4x.com/android/forum/threads/b4x-as-settings-descriptionitem.159268/>[/TD]  
[TD]![](https://www.b4x.com/android/forum/attachments/150855)[/TD]  
[/TR]  
[TR]  
[TD]ColorChooser[/TD]  
[TD]<https://www.b4x.com/android/forum/threads/b4x-as-settings-colorchooser-property.163869/>[/TD]  
[TD]![](https://www.b4x.com/android/forum/attachments/158167)[/TD]  
[/TR]  
[TR]  
[TD]Custom[/TD]  
[TD]<https://www.b4x.com/android/forum/threads/b4x-as-settings-custom-property.164967/>[/TD]  
[TD]![](https://www.b4x.com/android/forum/attachments/160469)[/TD]  
[/TR]  
[/TABLE]  
  
**Examples:**  

```B4X
    AS_Settings1.MainPage.AddGroup("Basic","Basic Settings")  
   
    AS_Settings1.MainPage.AddDescriptionItem("","Show sync help: when enabled, you'll see an explanation alert every time you tap 'Sync' on the Today tab.")  
   
    'Boolean  
    AS_Settings1.MainPage.AddProperty_Boolean("Basic","PropertyName_1","Overview in the morning","Your goals for today: Goal1, Goal2, Goal3",Null,True)  
    AS_Settings1.MainPage.AddProperty_Boolean("Basic","PropertyName_2","Boolean Property False","Description Long Long Long Long Long Long Long Long Long Long Long Long Long Long Test Text",Null,False)  
  
    AS_Settings1.MainPage.AddProperty_Boolean("Basic","PropertyName_3","Boolean Property True with a long text","",Null,True)  
    'Action Button  
    AS_Settings1.MainPage.AddProperty_Action("Basic","PropertyName_4","Action Property","",Null,"English")  
    AS_Settings1.MainPage.AddProperty_Action("Basic","PropertyName_5","Icon","",AS_Settings1.FontToBitmap(Chr(0xF179),False,30,xui.Color_White),"English, German, Italian, Spanish, Swedish")  
    AS_Settings1.MainPage.AddProperty_ActionClean("Basic","PropertyName_6","Delete Account","",AS_Settings1.FontToBitmap(Chr(0xE92B),True,34,xui.Color_White))  
    AS_Settings1.MainPage.AddProperty_Action("Basic","PropertyName_7","Pro Feature","",Null,"Pro")  
   
    AS_Settings1.MainPage.AddGroup("Advanced","Advanced Settings")  
   
    'Numeric Example  
    AS_Settings1.MainPage.AddProperty_Text("Advanced","PropertyName_8","Text Example","",Null,"Test",100dip,AS_Settings1.InputType_Text)  
    AS_Settings1.MainPage.AddProperty_Text("Advanced","PropertyName_9","Numeric Example","",Null,24,60dip,AS_Settings1.InputType_Numeric)  
    AS_Settings1.MainPage.AddProperty_Text("Advanced","PropertyName_10","Decimal Example","",Null,24.24,100dip,AS_Settings1.InputType_Decimal)  
    'ComboBox  
    AS_Settings1.MainPage.AddProperty_ComboBox("Advanced","PropertyName_11","ComboBox Example","",Null,1,Array("Option 1","Option 2","Option 3","Option 4"))  
   
    AS_Settings1.MainPage.BottomText = "Alexander Stolte" & CRLF & "V1.0.2"  
   
    AS_Settings1.MainPage.Create  
   
   
    'Second Page  
    SettingPage2.Initialize(AS_Settings1,"Page #2")  
   
    SettingPage2.AddGroup("Page2","Page 2 Settings")  
    SettingPage2.AddProperty_Boolean("Page2","PropertyName_1","Overview in the morning","Your goals for today: Goal1, Goal2, Goal3",Null,True)  
    SettingPage2.AddProperty_Boolean("Page2","PropertyName_2","Overview in the morning","Your goals for today: Goal1, Goal2, Goal3",Null,True)  
    SettingPage2.AddProperty_Boolean("Page2","PropertyName_30","Overview in the morning","Your goals for today: Goal1, Goal2, Goal3",Null,True)  
    SettingPage2.AddProperty_Boolean("Page2","PropertyName_31","Overview in the morning","Your goals for today: Goal1, Goal2, Goal3",Null,True)  
    SettingPage2.AddProperty_Boolean("Page2","PropertyName_32","Overview in the morning","Your goals for today: Goal1, Goal2, Goal3",Null,True)  
    SettingPage2.AddProperty_Boolean("Page2","PropertyName_33","Overview in the morning","Your goals for today: Goal1, Goal2, Goal3",Null,True)  
    SettingPage2.AddProperty_Boolean("Page2","PropertyName_34","Overview in the morning","Your goals for today: Goal1, Goal2, Goal3",Null,True)
```

  

```B4X
'You can call this anywhere in your app without initializing the view first  
AS_Properties.GetProperty("PropertyName_1")  
AS_Properties.GetPropertyDefault("PropertyName_1",True)  
AS_Properties.PutProperty("PropertyName_1",True)
```

  
<https://www.b4x.com/android/forum/threads/b4x-as-settings-master-and-child-switch.158497/>  
<https://www.b4x.com/android/forum/threads/b4x-as-settings-deactivate-a-property-if-a-certain-condition-is-met.158498/>  
<https://www.b4x.com/android/forum/threads/b4x-as-settings-change-description-text-on-the-fly.162452/>  
[SPOILER="Dependencies/Libraries you need for this view"]  
**B4j**: jXUI,jSQL,xCustomListView,XUI Views  
**B4a**: XUi,SQL,xCustomListView,XUI Views  
**B4i**: iXUI,iSQL,xCustomListView,XUI Views  
[/SPOILER]  
**AS\_Settings  
Author: Alexander Stolte  
Version: 1.00  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **ASSettings\_CustomDrawProperty**

- **Fields:**

- **Group** As ASSettings\_Group
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Property** As ASSettings\_Property
- **PropertySettingViews** As ASSettings\_PropertySettingViews
- **PropertyViews** As ASSettings\_PropertyViews

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASSettings\_Group**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Key** As String
- **Name** As String
- **Properties** As List

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASSettings\_Property**

- **Fields:**

- **DisplayName** As String
- **Group** As ASSettings\_Group
- **Icon** As B4XBitmap
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **isLast** As Boolean
- **ItemList** As List
- **PropertyName** As String
- **Value** As Object
- **ValueType** As String
- **ValueTypeTextProperties** As ASSettings\_ValueTypeTextProperties

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASSettings\_PropertySettingViews**

- **Fields:**

- **ActionButtonArrowLabel** As B4XView
- **ActionValueLabel** As B4XView
- **BackgroundPanel** As B4XView
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASSettings\_PropertyViews**

- **Fields:**

- **BackgroundPanel** As B4XView
- **IconImageView** As B4XView
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **NameLabel** As B4XView
- **RootBackgroundPanel** As B4XView

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASSettings\_ValueTypeTextProperties**

- **Fields:**

- **Color** As Int
- **CornerRadius** As Float
- **Height** As Float
- **InputType** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int
- **Width** As Float
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_Properties**

- **Functions:**

- **GetProperty** (PropertyName As String) As Object
- **GetPropertyDefault** (PropertyName As String, DefaultValue As Object) As Object
*Gets a property value, if no value has been stored by this property yet, the default value is returned*- **Initialize** As String
- **process\_globals**
- **PutProperty** (PropertyName As String, Value As Object) As String

- **AS\_Settings**

- **Events:**

- **ActionClicked** (Property As ASSettings\_Property)
- **CustomDrawProperty** (CustomDrawProperty As ASSettings\_CustomDrawProperty)
- **ValueChanged** (Property As ASSettings\_Property, Value As Object)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddGroup** (Key As String, Name As String) As String
- **AddProperty\_Action** (GroupKey As String, PropertyName As String, DisplayName As String, Icon As B4XBitmap, DefaultValue As Object) As String
- **AddProperty\_ActionClean** (GroupKey As String, PropertyName As String, DisplayName As String, Icon As B4XBitmap) As String
- **AddProperty\_Boolean** (GroupKey As String, PropertyName As String, DisplayName As String, Icon As B4XBitmap, DefaultValue As Boolean) As String
*<code>AS\_Settings1.AddProperty\_Boolean("General","PropertyName\_1","Boolean Property True",Null,True)</code>*- **AddProperty\_ComboBox** (GroupKey As String, PropertyName As String, DisplayName As String, Icon As B4XBitmap, DefaultValue As String, ItemList As List) As String
- **AddProperty\_Text** (GroupKey As String, PropertyName As String, DisplayName As String, Icon As B4XBitmap, DefaultValue As Object, Width As Float, InputType As String) As String
- **Base\_Resize** (Width As Double, Height As Double) As String
- **Class\_Globals** As String
- **Create**
- **CreateASSettings\_CustomDrawProperty** (Group As ASSettings\_Group, Property As ASSettings\_Property, PropertyViews As ASSettings\_PropertyViews, PropertySettingViews As ASSettings\_PropertySettingViews) As ASSettings\_CustomDrawProperty
- **CreateASSettings\_Group** (Key As String, Name As String, Properties As List) As ASSettings\_Group
- **CreateASSettings\_Property** (PropertyName As String, DisplayName As String, Icon As B4XBitmap, ValueType As String, Value As Object, ItemList As List, ValueTypeTextProperties As ASSettings\_ValueTypeTextProperties) As ASSettings\_Property
- **CreateASSettings\_PropertySettingViews** (BackgroundPanel As B4XView, ActionButtonArrowLabel As B4XView, ActionValueLabel As B4XView) As ASSettings\_PropertySettingViews
- **CreateASSettings\_PropertyViews** (RootBackgroundPanel As B4XView, BackgroundPanel As B4XView, IconImageView As B4XView, NameLabel As B4XView) As ASSettings\_PropertyViews
- **CreateASSettings\_ValueTypeTextProperties** (Width As Float, Height As Float, xFont As B4XFont, TextColor As Int, Color As Int, InputType As String, CornerRadius As Float) As ASSettings\_ValueTypeTextProperties
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **FontToBitmap** (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
*<https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250>*- **getBackgroundColor** As Int
- **getCornerRadius** As Int
- **getGroupHeight** As Float
- **getGroupNameBackgroundColor** As Int
- **getHapticFeedback** As Boolean
- **getInputType\_Decimal** As String
- **getInputType\_Numeric** As String
- **getInputType\_Text** As String
- **getPadding** As Float
- **getPropertyColor** As Int
- **getPropertyHeight** As Float
- **getPropertySeperator** As Boolean
- **getPropertySeperatorColor** As Int
- **getSaveMode** As String
*<code>AS\_Settings1.SaveMode = AS\_Settings1.SaveMode\_Automatic</code>*- **getSaveMode\_Automatic** As String
- **getSaveMode\_Manual** As String
- **getSwitchFalseColor** As Int
- **getSwitchThumbColor** As Int
- **getSwitchTrueColor** As Int
- **getValueType\_Action** As String
*Displays an arrow, the user can click on it and can be redirected to another page*- **getValueType\_ActionClean** As String
*Same as Action, but without an arrow and description*- **getValueType\_Boolean** As String
*Switch or Checkbox*- **getValueType\_ComboBox** As String
*Mit hoch Runter Icon*- **getValueType\_Custom** As String
- **getValueType\_Text** As String
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Refresh** As String
- **setBackgroundColor** (Color As Int) As String
*Background Color of the view*- **setCornerRadius** (Radius As Int) As String
*The corner radius of a group*- **setGroupHeight** (Height As Float) As String
*Height of a group name*- **setGroupNameBackgroundColor** (Color As Int) As String
*The Background Color of the group name*- **setHapticFeedback** (Enabled As Boolean) As String
*Haptic feedback of the switches and click actions*- **setPadding** (Padding As Float) As String
*The Padding Left and Right  
 Default value: 10dip*- **setPropertyColor** (Color As Int) As String
*Background Color of a property*- **setPropertySeperator** (Show As Boolean) As String
*If true a seperator is shown under a property*- **setPropertySeperatorColor** (Color As Int) As String
*Color of the seperator*- **setSaveMode** (Mode As String) As String
- **setSwitchFalseColor** (Color As Int) As String
- **setSwitchThumbColor** (Color As Int) As String
- **setSwitchTrueColor** (Color As Int) As String

- **Properties:**

- **BackgroundColor** As Int
*Background Color of the view*- **CornerRadius** As Int
*The corner radius of a group*- **GroupHeight** As Float
*Height of a group name*- **GroupNameBackgroundColor** As Int
*The Background Color of the group name*- **HapticFeedback** As Boolean
*Haptic feedback of the switches and click actions*- **InputType\_Decimal** As String [read only]
- **InputType\_Numeric** As String [read only]
- **InputType\_Text** As String [read only]
- **Padding** As Float
*The Padding Left and Right  
 Default value: 10dip*- **PropertyColor** As Int
*Background Color of a property*- **PropertyHeight** As Float [read only]
- **PropertySeperator** As Boolean
*If true a seperator is shown under a property*- **PropertySeperatorColor** As Int
*Color of the seperator*- **SaveMode** As String
*<code>AS\_Settings1.SaveMode = AS\_Settings1.SaveMode\_Automatic</code>*- **SaveMode\_Automatic** As String [read only]
- **SaveMode\_Manual** As String [read only]
- **SwitchFalseColor** As Int
- **SwitchThumbColor** As Int
- **SwitchTrueColor** As Int
- **ValueType\_Action** As String [read only]
*Displays an arrow, the user can click on it and can be redirected to another page*- **ValueType\_ActionClean** As String [read only]
*Same as Action, but without an arrow and description*- **ValueType\_Boolean** As String [read only]
*Switch or Checkbox*- **ValueType\_ComboBox** As String [read only]
*Mit hoch Runter Icon*- **ValueType\_Custom** As String [read only]
- **ValueType\_Text** As String [read only]

[/SPOILER]  
**Changelog  
[SPOILER="Version 1.00-2.10"][/SPOILER][SPOILER="Version 1.0-2.10"][/SPOILER][SPOILER="Version 1.0-2.10"][/spoiler]**[SPOILER="Version 1.0-2.10"]  

- **1.00**

- Release

- **1.01 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/post-938701)**)**

- **AS\_Settings**

- BugFixes
- Add AddProperty\_SegmentedTab - You can now add the AS\_SegmentedTab
- Add AddProperty\_PlusMinus - You can now add the AS\_PlusMinus
- Add get ValueTypeTextProperties - Change the appearance of the text edits
- Breaking Change - Add Description Property to all AddProperty\_ functions

- You can now display a short descripton to your properties

- Add Designer Property ShowMadeWithLove - Shows the Made with Love in B4X Badge at the end of the list

- Default: False

- Add Designer Property MadeWithLoveTextColor - Text Color of the Made with Love Badge

- Default: White

- Add Designer Property BottomText - a custom text on the end of the list

- Default: ""

- Add Designer Property BottomTextTextColor

- Default: White

- **AS\_Properties**

- Add RemoveProperty - Removes a property from the db
- Add ClearProperties - Clears all properties from the db

- **1.02 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/post-947849)**)**

- **AS\_Properties**

- Breaking change - For the intern database i'm now using the KeyValueStore lib.

- This means that all settings are reset by the update

- ClearProperties renamed to DeleteAllProperties
- Add get KeyValueStore

- **AS\_Settings**

- BugFixes in Property\_SegmentedTab

- AS\_SegmentedTab V1.18+ needed

- Add AddProperty\_Chooser - looks like an AddProperty\_Text, but is a label with click event
- Add Event ChooserTextFieldClicked - Is triggered when you click on an AddProperty\_Chooser
- Add AddProperty\_Custom - Is a CustomDrawProperty field, the CustomDrawProperty event is triggered, there you can add your own layout
- Add Event CustomDrawProperty - You can now add your custom property layout
- Add CustomDrawProperty\_Add - You can add any view with this function and It is automatically added to the layout, you don't have to worry about where to put it
- Add CustomDrawProperty\_AddChooser - A chooser view is created
- Add CustomDrawProperty\_AddText - A simple text item

- **1.03**

- **AS\_Settings**

- Add ResetGroups - Removes the groups, so that you can fill the view with new groups, without the groups that were previously visible

- **1.04**

- **AS\_Settings**

- Description BugFixes

- **1.05**

- **AS\_Settings (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/post-972977)**)**

- B4J Focused TextField at start bugfix
- Add SetProperty\_Boolean - Sets the value of a property as if the user had clicked the switch

- The \_ValueChanged event is triggered

- Add GetProperty - Gets the property object

- **2.00 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/post-977288)**)**

- AS\_Settings

- Add AddSpaceItem
- Add AddDescriptionItem
- Add multi page support
- Events should be added again, as all type names have changed

- **2.01 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/post-977603)**)**

- **AS\_SettingsPage**

- Add AddProperty\_SelectionList - You can create single choice or multiple choice options

- MultiSelect - If true more than one item can selected. If false only one item is selected if you click, it deselect the previous item
- CanDeselectAll - If false, then the last item cannot be deselected, it need min one selected

- **AS\_Settings**

- Add Designer Property SelectionItemSelectionColor - Color of the selection indicator

- Default: White

- Add Type AS\_Settings\_Property\_SelectionList
- Add Type AS\_Settings\_SelectionListItem
- Add CreateSelectionListItem - Needed to build the items

- **2.02**

- **AS\_SettingsPage**

- Added seperators to the SelectionList property
- The ValueChanged event works now with the SelectionList Property
- The .Refresh function is now smooth
- BugFixes on the PropertyName height and Description height

- **2.03 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/post-979799)**)**

- **AS\_Settings**

- BugFixes and Improvemets
- Add CreateList - Creates an list with just one line of code
- Add Designer Property PropertyTextColor
- Add set Theme
- Add get Theme\_Dark
- Add get Theme\_Light
- Add Designer Property ThemeChangeTransition

- Default: Fade

- **2.04**

- **AS\_SettingsPage**

- if you now specify your own width for the property AddProperty\_Text, you can now use more space
- BugFixes

- **2.05**

- **AS\_SettingsPage**

- SelectionList is now using more space
- Add Property Custom
- Add Event CustomDrawCustomProperty

- **AS\_Settings**

- Add Event GroupHeaderClicked

- **2.06**

- **AS\_SettingsPage**

- Add AddProperty\_ComboBox2 - The value is displayed in the ComboBox and the key is used for selection and stored in the database

- **AS\_Properties**

- Add SetDefaultValue - Defines the default value globally for this property

- You can call GetProperty and this specified value is taken as the default value
- No need to call GetPropertyDefault anymore

- Add GetDefaultValue - Returns the default value that was set with SetDefaultValue

- **2.07**

- **AS\_SettingsPage**

- BugFix on Refresh

- **2.08**

- **AS\_SettingsPage**

- BugFix - The ComboBox display text can now be multiline

- **2.09**

- **AS\_Settings**

- BugFixes for SaveMode\_Manual
- BugFixes for AddProperty\_Custom

- The specified height is now used
- The CustomDrawCustomProperty Event is now triggered

- **2.10**

- **AS\_Settings**

- Add AS\_Settings\_GroupProperties

- Removed GroupNameTextColor

[/SPOILER]  

- **2.11 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/post-1004928)**)**

- **AS\_SettingsPage**

- BugFixes and Improvements
- Add AddProperty\_ColorChooser
- Add Type AS\_Settings\_ColorItem
- Add Event DisabledItemClicked

- **2.12**

- **AS\_SettingsPage**

- BugFix - GetProperty now also works if the page has not yet been populated
- Add get isPagePopulated - Indicates whether the page has already been filled with your properties

- **2.13**

- **AS\_SettingsPage**

- The Boolean property now uses more space for the title and the description

- **2.14**

- **AS\_SettingsPage**

- BugFix - if you have set “set Height” for a page and then made a ".Refresh", then it came to an ugly behavior

- **2.15 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/post-1009824)**)**

- **AS\_SettingsPage**

- New - AddProperty\_Link - Identical to AddProperty\_Action only with a different icon
- New - PageScrollChanged Event
- New - CustomDrawGroup Event
- Update - The round corners of a group are no longer created with 2 separate items in the list, but directly on the 1st and last item of a group

- <https://www.b4x.com/android/forum/threads/b4x-setpanelcornerradius-only-for-certain-corners.164567/>

- Update - AS\_Settings\_PropertyViews the LeftBackgroundPanel is renamed to BackgroundPanel
- BugFix - In the Property SelectionList if SelectionMode Single was set and you used the SaveMode Manual, you could select multiple items
- BugFix - In the Property Action more space is now released for the description if no value text is displayed
- BugFix - In the Property ComboBox the complete item can be clicked to open the combobox

- **2.16**

- **AS\_SettingsPage**

- BugFix - Round corner fix for SelectionItems + ColorChooser

- **2.17**

- **AS\_Settings**

- Update AS\_Settings\_GroupProperties added LeftGap

- Default: 5dip

- Update AS\_Settings\_Property\_Properties added NameFont and DescriptionFont

- NameFont Default: Bold 18
- DescriptionFont Default: Normal 15

- **2.18**

- **AS\_Settings**

- New AS\_Settings\_SelectionListItemProperties

- xFont Default: BoldFont(18)
- SeperatorVisible Default: True

- New CustomDrawActionProperty Event - only for Action and Link Property

- **AS\_SettingsPage**

- New get ExitIconImageView - B4J only
- BugFix if the CustomProperty is in a group, the BackgroundPanel now has the correct width

- **2.19**

- **AS\_SettingsPage**

- New get ExitIconBackgroundPanel - B4J only
- New get PageBackgroundPanel
- BugFixes

- **2.20**

- **AS\_SettingsPage**

- BugFix on B4A with many TextFields

- **2.21**

- **AS\_SettingsPage**

- BugFixes

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)