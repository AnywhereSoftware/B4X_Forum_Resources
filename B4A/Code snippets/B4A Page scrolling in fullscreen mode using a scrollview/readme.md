### B4A Page scrolling in fullscreen mode using a scrollview by PaulMeuris
### 06/03/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/161491/)

In this little app example the screen is set in fullscreen mode and doesn't include a title.  

```B4X
#Region  Activity Attributes  
    #FullScreen: True  
    #IncludeTitle: False  
#End Region
```

  
The layout contains a B4XSwitch, a CustomListView, a multiline edittext view and button.  
![](https://www.b4x.com/android/forum/attachments/154283)  
When the switch is off the scrolling of the CustomListView and the EditText view work as expected.  
When the user taps in the EditText view the keyboard will appear and the text automatically scrolls to the tapped line moving the text up if needed.  
![](https://www.b4x.com/android/forum/attachments/154284)  
The click events work as normal in the CustomListView and with the button.  
The button however is hidden under the keyboard and can only be reached if the user closes the keyboard.  
When the user switches the page scrolling on then the whole page can scroll vertically.  
![](https://www.b4x.com/android/forum/attachments/154285) ![](https://www.b4x.com/android/forum/attachments/154286)  
The CustomListView and the EditText view can no longer vertically scroll.  
When the user taps on a visible item in the CustomListView, or in a visible line of the EditText view or on the button then these events will still work.  
Switching off the page scrolling will restore the scrolling in the CustomListView and the EditText.  
You can put as many views in the panel that is used in the scrollview as you want. Horizontal scrolling should also work as usual.  
You can find the source code in the attachment (testenvironment55.zip)