###  [XUI] ToastMessage Class Modifications by gregchao
### 05/21/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/118022/)

Based on the work by UDG in the post: <https://www.b4x.com/android/forum/threads/b4x-xui-toastmessage-class.92476/#content>  
  
This is a cross platform library that will work in B4a, B4i, and B4j. These modifications help to mimic B4a/B4i ToastMessageShow better.  
  
Modified from the original in the following ways:  
  
1. Length of the toast message panel will now vary with the text width.  
2. Made permanent "Center" alignment of text.  
3. Changed the font size according to the platform - 14(B4A), 16(B4I), 14(B4J)  
4. Change the panel radius according to the platform - 24(B4A), 10(B4I, B4J)  
5. Default vertical panel location changed from left to center  
6. Allows for moving the panel location using a new command "VerticalOffset"  
7. You can now set a min. horizontal panel margin 5-49% of the total screen width using the new command "SetHorizontalMinMargin"  
  
Instructions: Copy the .b4xlib to your additional library location. If you would like to see the code, change the extension to .zip and unzip it.  
  
Warning for B4i applications: You need to either put a small delay before initializing (in "Application\_Start") OR put the initialization in the "Sub Page1\_Resize". This is so that the layout has enough time to load before calling the initialization.  
  

```B4X
Sub Process_Globals  
    Private tm As clXToastMessage1  
End sub  
  
'Delay method for initialization'  
Private Sub Application_Start (Nav As NavigationController)  
    Sleep(1000)  
    tm.Initialize(Page1.Rootpanel)  
End Sub  
  
'Resize method for initialization'  
Private Sub Page1_Resize(Width As Int, Height As Int)  
    tm.Initialize(Page1.Rootpanel)  
End Sub
```

  
  
  
  
Enjoy!!!