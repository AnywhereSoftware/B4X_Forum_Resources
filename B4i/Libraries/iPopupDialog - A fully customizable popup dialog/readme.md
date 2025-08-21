### iPopupDialog - A fully customizable popup dialog by Biswajit
### 05/11/2020
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/117622/)

This is a fully customizable popup dialog which supports Image, Video, Custom View, Simple text, Long Scrollable text and many more.  
  
![](https://www.b4x.com/android/forum/attachments/93818)![](https://www.b4x.com/android/forum/attachments/93819)![](https://www.b4x.com/android/forum/attachments/93820)![](https://www.b4x.com/android/forum/attachments/93821)![](https://www.b4x.com/android/forum/attachments/93822)  
  
**iPopupDialog  
Author:** [USER=100215]@Biswajit[/USER]   
**Version:** 1.0  
**Dependency:** iUI8  
  
**Features:**  

1. Image Alert
2. Video Alert (remote video) with video pause play functionality
3. Simple text Alert (Supports very long text)
4. Customizable

1. Background Color
2. Corner Radius
3. Button Font
4. Button Text Color
5. Button Color
6. Blurry Overlay Style
7. Title Text Label
8. Body Text Label

5. Supports both orientations

**Usage:**  

1. Copy xml file to library folder
2. Copy .a and .h file to B4IBuilder Libs folder
3. Copy the attached popupvideo.bil file to your project files folder (if you want to use video option)
4. Initialize iPopupDialog with title, body, and button list
5. Set all properties like image, video button color, back color etc
6. Call Show function with Style Constant to show the dialog
7. Wait for the Result event
8. Result event will return the button text or CLOSE\_WITHOUT\_RESULT constant (See below documentation for details.

- **iPopupDialog**

- **Events:**

- **Eventname\_Result** (button As String)

- **Fields:**

- **BodyLabel** As Label
- **CLOSE\_WITHOUT\_RESULT** As String
- **STYLE\_DARK** As Int
- **STYLE\_EXTRALIGHT** As Int
- **STYLE\_LIGHT** As Int
- **STYLE\_REGULAR** As Int
- **TitleLabel** As Label

- **Functions:**

- **Class\_Globals** As String
- **ClosePopup** As String
*Close the popup without result.  
 This will return CLOSE\_WITHOUT\_RESULT constant in popup result event*- **Initialize** (Eventname As String, Callback As Object, Title As String, Body As String, Buttons As List, Cancelable As Boolean) As iPopupDialog
*Initialize the popup everytime you need a new one  
Eventname: Sub name that will handle the popup result event [ Eventname\_Result(button as string) ]  
Callback: Set the module in which you want to catch the result event  
Title: Title of the popup. Leave blank if you dont want.  
Body: Body text of the popup. Leave blank if you dont want.  
Buttons: List of button name. You will get this name in result sub  
 Cancelable: Set if it is cancelable by clicking outside of the popup*- **IsInitialized** As BOOL
*Tests whether the object has been initialized.*- **PopupWidth** As Int
*Get the popup width (useful for custom popup)*- **Resize** As String
*Call it from Page\_Resize event if your application support both orientation*- **Show** (style As Int) As String
*Style must be any of the style constant  
 You should set all properties you need before calling this*- **UpdatePostion** (NewHeight As Float) As String
*Update the popup position relative to keyboard (only requrired if popup contains input field).  
 Call it from Page\_KeyboardStateChanged event*
- **Properties:**

- **ButtonBackgroundColor**
*Set button color  
 Default: Transparent Black*- **ButtonFont**
*Set button text font.  
 Default font size is 14*- **ButtonTextColor**
*Set button text color  
 Default: Black*- **CustomView**
*Set the custom view.  
 Setting custom view will hide Body text, Image and Video properties.*- **PopupBackgroundColor**
*Set the popup background color. Default: white*- **PopupCornerRadius**
*Set the popup corner radius.  
Default: 5  
 Max: 15*- **PopupImage**
*Set popup image.  
 If you set popup image then popup video will not work.*- **PopupVideo**
*Set popup video url.  
 If you want to load video from non secure url (http) then make sure that ATS is disable.*