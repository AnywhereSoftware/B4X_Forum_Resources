### Simple text editor class with text styles and colors using ONLY an EditText view by B G
### 04/17/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/166446/)

I was recently writing a project that needed to include a simple text editor for the user which was capable of displaying various styles and colors.  
I tried using the SMMRichEditor library but I found it to be unreliable on some machines and also did not have all the features I desired.  
SMMRichEditor I believe, also uses a Webview in the background. I tried to get answers to some of my problems with it on the forum but received no replies.  
I also tried CSBuilder and the RichString library but wasn't able to achieve what I really wanted.  
So I set about to create a simple text editor that didn't rely on any external libraries and so this is it.  
It does not require CSBuilder, RichString, SMMRichEditor, CSS, HTML or a Webview. It is all done in a standard EditText view.  
  
**Features:**  
\* Allows user to type text and format it in any of the shown styles and colors.  
\* Allows images to be inserted. They can be fixed size or automatically resize when the view is zoomed.  
\* Can save and read the formatted text from a custom file format. Conversion to Html is also possible.  
\* Can Copy/Cut/Paste formatted text.  
\* Has Undo/Redo functionality for formatted text.  
\* Class has methods to create the Color selector and Style selector as well as the Zoom bar.  
\* If you use the inbuilt selectors, then the class will look after most of the work for you, you will only need to call a few methods to set it up.  
\* Can genuinely make the EditText read only. (Sometimes 'ReadOnly' doesn't work on a standard EditText)  
\* Has custom Context menus.  
\* Comes with a range of Shortcuts if used with an external keyboard. (eg. Ctrl-B Bold, Ctrl-I Italic).  
\* ETEditor is a class and not a library, so it can be easily integrated into a project and can be customized to meet your individual requirements.  
  
  
![](https://www.b4x.com/android/forum/attachments/163489)  
  
Color selector and Style selector (both of which are based on standard spinners).  
  
![](https://www.b4x.com/android/forum/attachments/163168)  
  
Zoom slider which is based on the ASSlider library on the forum.  
  
![](https://www.b4x.com/android/forum/attachments/163169)  
  
The 'SetEnabled' method genuinely makes the EditText readonly by placing a transparent panel over it and setting the cursor to invisible.  
  
![](https://www.b4x.com/android/forum/attachments/163176)  
  
Custom Context menus.  
  
![](https://www.b4x.com/android/forum/attachments/163171)  
  
It is best used on a tablet with an external keyboard attached. You are then able to use all of the shortcut keys.  
  
![](https://www.b4x.com/android/forum/attachments/163172)  
  
**Limitations:  
\*** Styles and Colors can only be applied to existing text. i.e you need to type the text first and then format it.  
**\*** The alignment is only 'fake'. i.e alignment is achieved by inserting or deleting spaces at the beginning of a line. (EditText is NOT in wrap mode)  
**\*** The 'SaveToFile' format is custom.  
\* The 'SaveToHtml' method does not support all styles (eg Relative size and ScaleX) in the html conversion.. It also does not capture the Zoom factor.  
**\*** The Zoom slider effects the text size of the entire text. Although if you do want text of different sizes then you can apply 'Relative Size'.  
 eg. If you set the 'RelativeSize' of some text to .5, then it will always be half the size of the main text. So if the main text is zoomed, then the relative sized text zooms with it but will still be half the size of the main text.  
  
Example usage:  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Dim Panel1 As Panel  
    Dim ET As EtEditor  
End Sub  
  
Public Sub Initialize  
'    B4XPages.GetManager.LogEvents = True  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")                                    ' Which has a single panel (Panel1) on it  
    ET.Initialize(Panel1,0, 10%y,100%x,90%y, 0)                    ' Initialize class with size, position and scale (normally set to 0)  
    ET.CreateStyleSpinner(Panel1,100%x - 8%x,2%y,Colors.Black)     ' Create Style spinner (If using the inbuilt one)  
    ET.CreateColorSpinner(Panel1,100%x - 17%x,2%y,Colors.Black)    ' Create Color spinner (If using the inbuilt one)  
    ET.CreateZoomSlider(Panel1,100%x - 42%x,1%y,23%x,8%y)          ' Create Zoom slider (If using the inbuilt one)  
    'ET.EditText.Text = "Welcome to ETEditor"                      ' Set a default text if required  
    If File.Exists(File.DirAssets,"Sample.et") Then                ' Or read from a file  
        Wait for (ET.ReadFromFile(File.DirAssets,"Sample.et")) Complete (bResult As Boolean)  
    End If  
End Sub
```

  
  
****Commonly used Methods:****   
**Public Sub Initialize** *(Parent As Panel, Left As Int, Top As Int, Width As Int, Height As Int, DeviceScale As Float)*  
 'Initializes the object and specifies the EditText position and size. Pass a 0 as scale for the class to calculate the correct scale for you.  
**Public Sub CreateColorSpinner** *(Parent As Panel, Left As Int, Top As Int, BorderColor As Int)*  
 ' Creates a Color Selector from a standard spinner.  
 ' If used, this class will handle all of the selections made automatically.  
 ' Set BorderColor to Transparent if not required..  
**Public Sub CreateStyleSpinner** *(Parent As Panel, Left As Int, Top As Int, BorderColor As Int)*  
 ' Creates a formatted Style Selector with Edit functions from a standard spinner  
 ' If used, this class will handle all of the selections made automatically.  
**Public Sub CreateZoomSlider** *(Parent As Panel, Left As Int, Top As Int, Width As Int, Height As Int)*  
 ' Creates a Zoom slider using the inbuilt 'Slider' pseudoclass (Code at the end)  
 ' If used, this class will handle all of the adjustments made with the slider automatically.  
**Public Sub InsertImage** *(ImageDir As String, ImageFile As String, Width As Int, Height As Int)*  
 ' Inserts an image into the EditText. For a non-zoomable image have '[NZ]' somewhere in the file name.  
 ' Width and Height can be in one of 4 formats;  
 ' 0, 0 (No Width or Height specified: Will clear the EditText and fill it with the image)  
 ' W, 0 (Width specified but no Height: Will resize the image to Width and set the Height according to the Aspect Ratio)  
 ' 0, H (Height specified but no Width: Will resize the image to Height and set the Width according to the Aspect Ratio)  
 ' W, H (Width and Height specified: Will resize the image to the specified size regardless of Aspect Ratio)  
**Public Sub ReadFromFile** *(Dir As String, Filename As String)*  
 ' Reads text with formatting from file and displays in EditText  
**Public Sub ReadFromHtml** *(Dir As String, Filename As String)*  
 ' Reads a html file and displays it in the EditText. Note: not all styles (eg Relative size and ScaleX) are supported by the html conversion.  
**Public Sub SaveToFile** *(Dir As String, Filename As String)*  
 ' Saves the displayed text with formatting in a custom format.  
**Public Sub SaveToHtml** *(Dir As String, Filename As String)*  
 ' Saves the displayed text with formatting as html. Note: not all styles (eg Relative size and ScaleX) are supported by the html conversion.  
**Public Sub SetReadOnly** *(ReadOnly As Boolean, BackColor As Int)*  
 ' Sets whether the EditText is in read only mode or not. Optionally pass a new Background color (or 1 to leave unchanged).  
 ' The 'ReadFromFile' method will still work in Read Only mode.  
   
***Sometimes used methods:*  
Public Sub EditText** *As EditText*  
 ' Returns the EditText view so the user can view or change it's properties.  
 ' Do NOT change the Text property. Doing so will kill all the formatting.  
**Public Sub GetScale**   
 ' Returns the scale being used by the class  
**Public Sub GetSpnColorsLayout**  
 ' Get the position and dimensions of the Colors spinner  
**Public Sub GetSpnStylesLayout**  
 ' Get the position and dimensions of the Styles spinner  
**Public Sub GetZoomSliderLayout**  
 ' Get the Slider size and position  
**Public Sub GetReadOnly**   
 ' Returns the ReadOnly state of the EditText  
**Public Sub SetZoomSliderTextSize** *(NewSize As Int)*  
 ' Sets the textsize for the Slider (correct size should have already been selected but just in case it needs to be changed)  
  
***Rarely used methods: (Note; These Methods are not required if using the internal Color, Style selector and Zoom slider as the class will call these subs by itself)*  
Public Sub AddSpanToET** *(ETSpanType As Int, Parameter As Float)*  
 ' Add a span (Color or Textstyle) on the currently selected text.  
 ' Note: This is called automatically if using the inbuilt Style Spinner  
**Public Sub AddToUndoRedoHistory**  
 ' Add the current state (text and formatting) of the EditText to the UndoRedoHistory  
 ' Note: This class will automatically call this sub when required.  
**Public Sub Align** *(ETAlignType As Int)*  
 ' Aligns text in the selected line by adding or deleting spaces in front. ONLY works if EditText is NOT in wrap mode.  
 ' Note: This is called automatically if using the inbuilt Style Spinner  
**Public Sub Clear** *(ClearUndoHistoryAsWell As Boolean)*  
 ' Clears the EditText of all text and spans  
**Public Sub Copy**  
 ' Copies the selected text complete with formatting  
 ' Note: Call this sub if using Custom Context Menus (Copy+)  
**Public Sub Cut**  
 ' Cuts the selected text complete with formatting  
 ' Note: Call this sub if using Custom Context Menus (Cut+)  
**Public Sub Delete**  
 ' Deletes the selected text.  
 ' Note: Only required when need to delete text via code. The EditText will take care of text deleted by the user.  
**Public Sub InsertText** *(NewText As String)*  
 ' Inserts text at the cursor position  
 ' Note: Only required when need to insert text via code. The EditText will take care of text inserted by the user.  
**Public Sub Paste**  
 ' Pastes the copied text and it's formatting  
 ' Note: Call this sub if using Custom Context Menus (Paste+)  
**Public Sub Redo**  
 ' Performs an Redo operation.  
 ' Note: This is called automatically if using the inbuilt Style Spinner  
**Public Sub RemoveSpans**  
 ' Removes any spans for the selected text (i.e. turns the text back to Normal)  
 ' Note: This is called automatically if using the inbuilt Style Spinner  
**Public Sub Replace** *(ReplacementText As String)*  
 ' Replaces the selected text with the replacement text  
 ' Note: Only required when need to replace text via code. The EditText will take care of text replaced by the user.  
**Public Sub ShowShortcuts**  
 ' Displays a summary of all the shortcuts (when using an external keyboard)  
 ' Note: Automatically called via shortcut key  
**Public Sub Undo**  
 ' Performs an Undo operation.  
 ' Note: This is called automatically if using the inbuilt Style Spinner  
  
**Final note:** This class is fully functional as I have supplied it but some portions of it can be tweaked to meet individual requirements.  
eg. The only other class required is my 'XUIViewsBG' class (supplied in the sample project). This is just a collection of dialogs that automatically scale to a given textsize.  
You can replace these with your own dialogs if you wish.  
You may also wish to have the class raise events or expose other properties.