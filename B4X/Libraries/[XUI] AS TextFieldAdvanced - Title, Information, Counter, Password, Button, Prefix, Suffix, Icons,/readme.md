###  [XUI] AS TextFieldAdvanced - Title, Information, Counter, Password, Button, Prefix, Suffix, Icons, Multiline by Alexander Stolte
### 07/01/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/141337/)

With this view you can quickly and easily add good looking text fields, with title and or bottom text. Additionally you can make the TextField a button, so that you can open menus, but still keep the design of the text fields.  
The view speeds up development because you don't have to worry about almost anything, it looks nice by default and is functional.  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
In B4J the view does not work properly yet, I am working on fixing the bugs. **B4J works now**  
![](https://www.b4x.com/android/forum/attachments/131718)  
  
**[SIZE=5]Password strength indicator[/SIZE]**[SIZE=5] V1.20+[/SIZE]  
![](https://www.b4x.com/android/forum/attachments/142346)  
<https://www.b4x.com/android/forum/threads/b4x-as-textfieldadvanced-password-strength-indicator.148173/#post-939151>  
  
**[SIZE=5]Required Fields V1.21+[/SIZE]**  
![](https://www.b4x.com/android/forum/attachments/142577)  
<https://www.b4x.com/android/forum/threads/b4x-as-textfieldadvanced-text-validation-required-fields-example.148306/>  
  
**[SIZE=5]Underline Style[/SIZE]**  
![](https://www.b4x.com/android/forum/attachments/149502)  
<https://www.b4x.com/android/forum/threads/b4x-as-textfieldadvanced-underline-style.158548/>  
  
**[SIZE=5]ComboBox[/SIZE]**  
![](https://www.b4x.com/android/forum/attachments/151767)  
<https://www.b4x.com/android/forum/threads/b4x-as-textfieldadvanced-combobox.159854/#post-981407>  
  
**[SIZE=5]TitleMode[/SIZE]**  
<https://www.b4x.com/android/forum/threads/b4x-as-textfieldadvanced-titlemode-abovetextfield-floattext-and-beforetextfield.161184/>  
![](https://www.b4x.com/android/forum/attachments/160972)  
![](https://www.b4x.com/android/forum/attachments/160974)  
  
**ASTextFieldAdvanced  
Author: Alexander Stolte  
Version: 1.23**  
[SPOILER="Properties, Functions, Events, etc."]  

- **ASTextFieldAdvanced\_Counter**

- **Fields:**

- **CounterMax** As Int
- **IgnoreProperties** As Boolean
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int
- **View** As ASTextFieldAdvanced\_ViewCounter
- **Visible** As Boolean
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASTextFieldAdvanced\_Hint**

- **Fields:**

- **FocusedTextColor** As Int
- **IgnoreProperties** As Boolean
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **NonFocusedTextColor** As Int
- **Text** As String
- **View** As ASTextFieldAdvanced\_ViewHint
- **Visible** As Boolean
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASTextFieldAdvanced\_Information**

- **Fields:**

- **IgnoreProperties** As Boolean
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Text** As String
- **TextColor** As Int
- **View** As ASTextFieldAdvanced\_ViewInformation
- **Visible** As Boolean
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASTextFieldAdvanced\_LeadingIcon**

- **Fields:**

- **Icon** As B4XBitmap
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **View** As ASTextFieldAdvanced\_ViewLeadingIcon
- **Visible** As Boolean

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASTextFieldAdvanced\_Prefix**

- **Fields:**

- **Gap** As Float
- **IgnoreProperties** As Boolean
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Text** As String
- **TextColor** As Int
- **View** As ASTextFieldAdvanced\_ViewPrefixSuffix
- **Visible** As Boolean
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASTextFieldAdvanced\_Suffix**

- **Fields:**

- **Gap** As Float
- **IgnoreProperties** As Boolean
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Text** As String
- **TextColor** As Int
- **View** As ASTextFieldAdvanced\_ViewPrefixSuffix
- **Visible** As Boolean
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASTextFieldAdvanced\_Title**

- **Fields:**

- **FocusedTextColor** As Int
- **Height** As Float
- **IgnoreProperties** As Boolean
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **NonFocusedTextColor** As Int
- **Text** As String
- **TextColor** As Int
- **View** As ASTextFieldAdvanced\_ViewTitle
- **Visible** As Boolean
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASTextFieldAdvanced\_TrailingIcon**

- **Fields:**

- **Icon** As B4XBitmap
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **View** As ASTextFieldAdvanced\_ViewTrailingIcon
- **Visible** As Boolean

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASTextFieldAdvanced\_ViewCounter**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **xlbl\_Counter** As B4XView

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASTextFieldAdvanced\_ViewHint**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **xlbl\_Hint** As B4XView

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASTextFieldAdvanced\_ViewInformation**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **xlbl\_Information** As B4XView

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASTextFieldAdvanced\_ViewLeadingIcon**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **xiv\_Icon** As B4XView
- **xpnl\_Background** As B4XView

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASTextFieldAdvanced\_ViewPrefixSuffix**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **xlbl\_PrefixSuffix** As B4XView

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASTextFieldAdvanced\_ViewTitle**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **xlbl\_Title** As B4XView

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASTextFieldAdvanced\_ViewTrailingIcon**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **xiv\_Icon** As B4XView
- **xpnl\_Background** As B4XView

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_TextFieldAdvanced**

- **Events:**

- **ButtonClick**
- **ClearButtonClick**
- **EnterPressed**
- **FocusChanged** (HasFocus As Boolean)
- **LeadingIconClick**
- **PasswordRevealChanged** (Revealed As Boolean)
- **TextChanged** (Text As String)
- **TrailingIconClick**

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Class\_Globals** As String
- **CreateASTextFieldAdvanced\_Counter** (Visible As Boolean, CounterMax As Int, IgnoreProperties As Boolean, xFont As B4XFont, TextColor As Int, View As ASTextFieldAdvanced\_ViewCounter) As ASTextFieldAdvanced\_Counter
- **CreateASTextFieldAdvanced\_Hint** (Visible As Boolean, Text As String, IgnoreProperties As Boolean, FocusedTextColor As Int, NonFocusedTextColor As Int, xFont As B4XFont, View As ASTextFieldAdvanced\_ViewHint) As ASTextFieldAdvanced\_Hint
- **CreateASTextFieldAdvanced\_Information** (Visible As Boolean, Text As String, IgnoreProperties As Boolean, xFont As B4XFont, TextColor As Int, View As ASTextFieldAdvanced\_ViewInformation) As ASTextFieldAdvanced\_Information
- **CreateASTextFieldAdvanced\_LeadingIcon** (Visible As Boolean, Icon As B4XBitmap, View As ASTextFieldAdvanced\_ViewLeadingIcon) As ASTextFieldAdvanced\_LeadingIcon
- **CreateASTextFieldAdvanced\_Prefix** (Visible As Boolean, Text As String, IgnoreProperties As Boolean, xFont As B4XFont, TextColor As Int, Gap As Float, View As ASTextFieldAdvanced\_ViewPrefixSuffix) As ASTextFieldAdvanced\_Prefix
- **CreateASTextFieldAdvanced\_Suffix** (Visible As Boolean, Text As String, IgnoreProperties As Boolean, xFont As B4XFont, TextColor As Int, Gap As Float, View As ASTextFieldAdvanced\_ViewPrefixSuffix) As ASTextFieldAdvanced\_Suffix
- **CreateASTextFieldAdvanced\_Title** (Visible As Boolean, Text As String, Height As Float, IgnoreProperties As Boolean, xFont As B4XFont, FocusedTextColor As Int, NonFocusedTextColor As Int, View As ASTextFieldAdvanced\_ViewTitle) As ASTextFieldAdvanced\_Title
- **CreateASTextFieldAdvanced\_TrailingIcon** (Visible As Boolean, Icon As B4XBitmap, View As ASTextFieldAdvanced\_ViewTrailingIcon) As ASTextFieldAdvanced\_TrailingIcon
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **Focus** As Boolean
*Sets input focus  
 Returns True if the focus has shifted  
 Always retuns True in B4J*- **FontToBitmap** (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
*<https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250>*- **getBackgroundColor** As Int
- **getBackgroundPanel** As B4XView
- **getBottomHeight** As Float
*Call Refresh if you change something*- **getButtonTextLabel** As B4XView
- **getClearAndRevealButtonColor** As Int
*Call Refresh if you change something*- **getClearButtonLabel** As B4XView
- **getCounter** As ASTextFieldAdvanced\_Counter
*Call Refresh if you change something*- **getFocusedShapeColor** As Int
- **getHint** As ASTextFieldAdvanced\_Hint
*Call Refresh if you change something*- **getInformation** As ASTextFieldAdvanced\_Information
*Call Refresh if you change something*- **getisPasswordMode** As Boolean
- **getisRevealed** As Boolean
- **getKeyboardType** As String
- **getLeadingIcon** As ASTextFieldAdvanced\_LeadingIcon
*Call Refresh if you change something*- **getLeftGap** As Float
*Default: 10dip  
 Call Refresh if you change something*- **getMaskText** As String
- **getNativeTextField** As TextField
*Gets the native TextField view*- **getNativeTextFieldMultiline** As TextArea
- **getNativeTextFieldPassword** As TextField
*Gets the native TextField view*- **getNonFocusedShapeColor** As Int
- **getPrefix** As ASTextFieldAdvanced\_Prefix
*Call Refresh if you change something*- **getReadOnly** As Boolean
*Call Refresh if you change something*- **getRequiredField** As Boolean
- **getRequiredFieldColor** As Int
- **getRevealButtonLabel** As B4XView
- **getShowClearButton** As Boolean
*Call Refresh if you change something*- **getShowRevealButton** As Boolean
*Call Refresh if you change something*- **getSuffix** As ASTextFieldAdvanced\_Suffix
*Call Refresh if you change something*- **getText** As String
- **getTextField** As B4XView
- **getTextFieldCornerRadius** As Float
- **getTextFieldMultiline** As B4XView
- **getTextFieldPassword** As B4XView
- **getTextFull** As String
*Gets the full text, with Prefix and Suffix*- **getTitle** As ASTextFieldAdvanced\_Title
*Call Refresh if you change something*- **getTrailingIcon** As ASTextFieldAdvanced\_TrailingIcon
*Call Refresh if you change something*- **HideDisplayMissingField** As String
*<code>AS\_TextFieldAdvanced\_1.HideDisplayMissingField</code>*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **PasswordScore** As Int
*1 = Weak  
 2 = Medium  
 3 = Strong*- **Refresh** As String
- **setBackgroundColor** (Color As Int) As String
- **setBottomHeight** (Height As Float) As String
- **setButtonText** (Text As String) As String
- **setButtonText2** (Text As String)
*Without TextChanged Event*- **setClearAndRevealButtonColor** (Color As Int) As String
- **setFocusedShapeColor** (Color As Int) As String
- **setLeftGap** (Gap As Float) As String
- **setMaskText** (Mask As String) As String
- **setNonFocusedShapeColor** (Color As Int) As String
- **setReadOnly** (ReadOnly As Boolean) As String
- **setRequiredField** (Required As Boolean) As String
*Call Refresh if you change something*- **setRequiredFieldColor** (Color As Int) As String
*Call Refresh if you change something*- **setReveale** (Revealed As Boolean) As String
- **setShowClearButton** (Show As Boolean) As String
- **setShowRevealButton** (Show As Boolean) As String
- **setText** (Text As String) As String
- **setText2** (Text As String)
*Without TextChanged Event*- **setTextColor** (Color As Int) As String
- **setTextFieldCornerRadius** (CornerRadius As Float) As String
- **ShowDisplayMissingField** (InformationText As String) As String
*Call this function to inform the user that not all required fields are filled in.  
 Call HideDisplayMissingField to remove it  
 <code>AS\_TextFieldAdvanced\_1.ShowDisplayMissingField("This field is required")</code>*
- **Properties:**

- **BackgroundColor** As Int
- **BackgroundPanel** As B4XView [read only]
- **BottomHeight** As Float
*Call Refresh if you change something*- **ButtonText**
- **ButtonText2**
*Without TextChanged Event*- **ButtonTextLabel** As B4XView [read only]
- **ClearAndRevealButtonColor** As Int
*Call Refresh if you change something*- **ClearButtonLabel** As B4XView [read only]
- **Counter** As ASTextFieldAdvanced\_Counter [read only]
*Call Refresh if you change something*- **FocusedShapeColor** As Int
- **Hint** As ASTextFieldAdvanced\_Hint [read only]
*Call Refresh if you change something*- **Information** As ASTextFieldAdvanced\_Information [read only]
*Call Refresh if you change something*- **isPasswordMode** As Boolean [read only]
- **isRevealed** As Boolean [read only]
- **KeyboardType** As String [read only]
- **LeadingIcon** As ASTextFieldAdvanced\_LeadingIcon [read only]
*Call Refresh if you change something*- **LeftGap** As Float
*Default: 10dip  
 Call Refresh if you change something*- **MaskText** As String
- **NativeTextField** As TextField [read only]
*Gets the native TextField view*- **NativeTextFieldMultiline** As TextArea [read only]
- **NativeTextFieldPassword** As TextField [read only]
*Gets the native TextField view*- **NonFocusedShapeColor** As Int
- **Prefix** As ASTextFieldAdvanced\_Prefix [read only]
*Call Refresh if you change something*- **ReadOnly** As Boolean
*Call Refresh if you change something*- **RequiredField** As Boolean
*Call Refresh if you change something*- **RequiredFieldColor** As Int
*Call Refresh if you change something*- **RevealButtonLabel** As B4XView [read only]
- **Reveale**
- **ShowClearButton** As Boolean
*Call Refresh if you change something*- **ShowRevealButton** As Boolean
*Call Refresh if you change something*- **Suffix** As ASTextFieldAdvanced\_Suffix [read only]
*Call Refresh if you change something*- **Text** As String
- **Text2**
*Without TextChanged Event*- **TextColor**
- **TextField** As B4XView [read only]
- **TextFieldCornerRadius** As Float
- **TextFieldMultiline** As B4XView [read only]
- **TextFieldPassword** As B4XView [read only]
- **TextFull** As String [read only]
*Gets the full text, with Prefix and Suffix*- **Title** As ASTextFieldAdvanced\_Title [read only]
*Call Refresh if you change something*- **TrailingIcon** As ASTextFieldAdvanced\_TrailingIcon [read only]
*Call Refresh if you change something*
[/SPOILER]  
**Changelog**  
[SPOILER="Version 1.00-1.37"]  

- **1.00**

- Release

- **1.01 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-textfieldadvanced-title-information-counter-password-button.141337/post-895827)**)**

- Add Designer Property LeadingIcon - An icon which is placed in front of the text and has its own click event
- Add Designer Property TrailingIcon - An icon which is placed behind the text and has its own click event
- Add Event LeadingIconClick
- Add Event TrailingIconClick
- Add some more properties

- **1.02**

- Add Type ASTextFieldAdvanced\_Title
- Add Type ASTextFieldAdvanced\_Information
- Add Type ASTextFieldAdvanced\_Counter
- Add Type ASTextFieldAdvanced\_Hint
- Add Type ASTextFieldAdvanced\_LeadingIcon
- Add Type ASTextFieldAdvanced\_TrailingIcon
- Removed some properties, they are now in the new types
- BugFixes

- **1.03 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-textfieldadvanced-title-information-counter-password-button.141337/post-896104)**)**

- Add Type ASTextFieldAdvanced\_Prefix
- Add Type ASTextFieldAdvanced\_Suffix
- Add Designer Properties Prefix, PrefixText, Suffix, SuffixText
- Add get TextFull - Gets the full text, with Prefix and Suffix
- BugFixes

- **1.04**

- BugFixes

- **1.05**

- BugFixes

- **1.06**

- BugFixes
- Add Designer Property ReadOnly - Disables the user input

- Default: False

- **1.07**

- BugFixes
- Add "Multiline" to the designer property "Mode"
- New Multiline mode

- **1.08**

- Multiline BugFixes

- **1.09**

- Add Focus - Sets input focus

- **1.10**

- BugFixes
- get Reveale is renamed to isRevealed

- **1.11**

- Add Designer Property TextAlignment

- Default: Left

- **1.12**

- Add set Text2 - Sets the text, without TextChanged Event
- Add set ButtonText2 - Sets the button text, without TextChanged Event

- **1.13**

- BugFixes

- **1.14**

- ClearButtonClick

- **1.15**

- BugFix

- **1.16**

- BugFixes
- Performance improvements

- **1.17**

- BugFixes - Character delimiter (Counter = True)
- B4J Only - Click on the TextField to focus it

- **1.18**

- BugFix - ReadOnly = True - ClearButton and RevealButton are now also read only

- **1.19 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-textfieldadvanced-title-information-counter-password-button-prefix-suffix-icons-multiline.141337/post-938416)**)**

- Add FocusedShapeColor

- Default: White with alpha 0 = Transparent

- Add set TextColor
- Add Designer Property TextFieldCornerRadius

- Default: 5dip

- B4J BugFix - The EnterPressed Event was not triggered

- **1.20 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-textfieldadvanced-title-information-counter-password-button-prefix-suffix-icons-multiline.141337/post-939152)**)**

- BugFixes
- Add Designer Property StrengthIndicator - Password strength indicator

- None|Line|Segmented
- Default: None

- **1.21 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-textfieldadvanced-title-information-counter-password-button-prefix-suffix-icons-multiline.141337/post-939871)**)**

- Add Designer Property RequiredField - if True the field is a required field and is marked with a colored star

- Default: False

- Add Designer Property RequiredFieldColor

- Default: Red

- Add ShowDisplayMissingField - Call this function to inform the user that not all required fields are filled in

- Call HideDisplayMissingField to remove it

- Add HideDisplayMissingField - Removes the user notification from ShowDisplayMissingField
- Add Designer Property Mask - You can use masks now

- Default: None

- Add Designer Property MaskText

- Example: XXX.XXX.XXX-XX

- **1.22**

- Add get and set MaskText

- **1.23**

- BugFixes
- RevealButton and ClearButton TextColor - Can now also be seen in light mode
- Add Designer Property ClearAndRevealButtonColor - is per default transparent

- If the alpha value is set to 0, then a color that matches the background color is automatically used

- Add Designer Property FocusedTitleTextColor

- Default: White

- Add Deigner Property NonFocusedTitleTextColor

- Default: White
- Would interfere too much with the design of already existing layouts if another white would be used

- Add Designer Property NonFocusedShapeColor

- **1.24**

- Add new Type ASTextFieldAdvanced\_TextFieldProperties
- Properties

- FocusedShapeColor
- NonFocusedShapeColor
- CornerWidth - NEW
- CornerRadius

- **1.25**

- BugFixes

- **1.26**

- BugFixes

- **1.27**

- BugFixes

- **1.28**

- Multiline TextFields supports now the clear button
- The action button have now a fixed HeightWidth = 24dip

- **1.29**

- BugFixes

- **1.30**

- Add get and set LeadingWidth
- Add get and set TrailingWidth

- **1.31**

- B4A BugFix

- **1.32**

- Add Designer Property CounterTextColor

- Default: White

- Add Designer Property InfoTextColor

- Default: White

- **1.33**

- Add Designer Property Underline - A line is visible on the textfield

- Default: False
- If true the ShapeColor ist used for this underline

- Add get UnderlinePanel

- **1.34**

- BugFix - If ShowRevealButton = True and PasswordField = False - Then the gap was still present at the end of the textfield

- **1.35**

- BugFix - if you set the Counter or CounterMax, then one emoji is now counting as one

- **1.36**

- BugFix - The hint text was only renewed if the TextField had no text
- B4I BugFix - Readonly on Multiline did not work

- **1.37**

- B4I BugFix - Readonly on Multiline did not work

[/SPOILER]  

- **1.38 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-textfieldadvanced-title-information-counter-password-button-prefix-suffix-icons-multiline.141337/post-981409)**)**

- Breaking Change - ButtonText and ButtonText2 have been removed and now work with .Text and .Text2

- It confuses me every time, especially when I don't know that it's a button

- A few functions have been made private as they should not be public
- Button Mode BugFixes
- Add Mode "ComboBox"
- Add Event ComboBoxSelectedIndexChanged
- Add set SetItems
- Add get and set SelectedIndex

- **1.39**

- BugFixes

- **1.40**

- Add get and set TopGap -Same as LeftGap

- Default: 0

- **1.41**

- BugFixes
- Add Designer Property TitleMode

- Default: Default - Above textfield
- FloatText - Floating animation like in the B4XFloatTextField
- BeforeTextField - Show the title before the textfield

- Add get and set TitleWidth - Works only if the TitleMode is set to BeforeTextField. The Text width of the title
- Add set TitleWidthAll - Sets the width value for all textfields on the parent
- Add HorizontalAlignment to the ASTextFieldAdvanced\_Title type

- Default: LEFT

- Add get and set Underline - Show or hide the underline programmatically
- Add IndexOf - ComboBox - Returns the index of the item with the given value. Returns -1 if not found.
- Add get ComboBox - Gets the B4XComboBox
- Add OpenComboBox
- Add Event TitleClick

- **1.42**

- BugFixes

- **1.43**

- BugFix ReadOnly on Multiline

- **1.44**

- BugFix

- **1.45**

- New get OldText - Returns the text that was there before

**Github:** [github.com/StolteX/AS\_TextFieldAdvanced](https://github.com/StolteX/AS_TextFieldAdvanced)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)