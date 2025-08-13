### Replacement TitleBar by stevel05
### 09/29/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/84586/)

I've seen a few questions on the forums about changing the titlebar color. The answer is that you have to replace the title bar.  
  
This gives the problem of then losing all of the form controls, resizing minimising, maximising and close buttons.  
  
This is a customview, that does all of this. Just add the titlebarCV customview to the top of a layout and it will replace the existing titlebar with one defined int the titlebar layout.  
  
The title color is controlled by the color selected for the background on the TitlebarBG pane. The font can be changed on the TitleLabel.  
  
There are no methods available for the titlebar. Through listeners, the title and icon are updated when the title and icon are changed on the Form that the customview is added to.  
  
There are three custom properties, 1 displays a dropshadow and another to choose the dropshadow color. The thirds allows turning off the minimize animation.  
  
If you choose to add a drop shadow, the layout must be inset by 8 pixels all round. This is because the shadow is actually drawn on the form in it's transparent borders. See the layout in the demo for an example.  
  
I've tried to recreate the look and behaviour of a Windows form, I don't have access to a Mac or linux box, so if you create a layout for either of these I would be grateful if you would share it.  
  
The code is one class and a utility class (FormUtils) and is all in the attached project.  
  
![](https://www.b4x.com/android/forum/attachments/60243)  
  
  
**Update to V1.0**  
  
[MEDIA=youtube]QnEuk3c08WY[/MEDIA]  

- Reworked the drag logic
- Added Emulation of windows snap to screen
- Added more designer properties
- Added method ResetMouseListeners

  
The added properties include options to turn off the windows snapping, icon state colours and specify a layout name.  
  
The layout must include all of the views that are in the provided titlebar layout.  
  
Emulated snap to screen does not integrate with the windows snap to screen, but is still quite useful and you can temporarily disable it by pressing the Ctrl key. Works with multiple screens.  
  
Resizing is now done using additional panes added to the forms.rootpane. If you add a lot of views in code, you may need to call ResetMouseListeners which will ensure that the listening panes are at the front.(Not required from v1.1) The listening panes are 5px wide, So you cannot capture mouseclicks within 5 px of the form edges, but they are transparent so you can see anything that is under them.  
  
**Depends on:**  
CssUtils  
JavaObject  
  
**Update: v1.1**  

- Added listener to getChildrenUnmodifiable to automatically call ResetMouseListeners as needed.
- Made important Titlebar views public for styling.
- Removed redundant code
- Added CloseRequst(EventData as Event) Event to delegate to MainForm\_CloseRequest(EventData as Event)
- Set default icon so that it's click can be captured if required.
- Stop the form closing on Right mouse button click
- Added override for Maximize size, mainly for Mac users.

The Titlebar close request callback should be delegated directly to the Form CloseRequest sub  
  

```B4X
Private Sub TitleBarCV1_CloseRequest (EventData As Event)  
    'Delegate the call to MainForm_CloseRequest  
    MainForm_CloseRequest(EventData)  
End Sub  
  
Private Sub MainForm_CloseRequest (EventData As Event)  
  
  
End Sub
```

  
  
**Using the Override Maximum size**  
[INDENT]If you change the left or top, you also need to make the opposite change to the width or height.[/INDENT]  
[INDENT][/INDENT]  
[INDENT]You could selectively implement this in case the app is running on a Mac with this code:[/INDENT]  
[INDENT][/INDENT]  

```B4X
If TB_Utils.isMac Then  
    TitleBarCV1.OverrideMaximizedLayout(0,30,0,-30)  
End If
```

  
  
I don't have a mac to try it on but I believe it should work.  
  
**Update V1.2**  

- Implemented FullScreen Mode
- Bug Fixes

**Update V1.3**  

- Added Snapping background and border colors to designer properties.
- Fixed bug on Snapping background for multiple screens
- improved Linux compatibility (see [post#25](https://www.b4x.com/android/forum/threads/replacement-titlebar.84586/post-781436))

**Update V1.4**  

- Fixed a bug that stopped the titlebar taking the full width of the window particularly when dropped in a corner of the screen.

**Update V1.5** - 29-Sep-2023  
[INDENT]Added option to designer UsingStylesheet to stop colors being updated in code.[/INDENT]  
[INDENT]Renamed class Popup to TB\_Popup to minimize the risk of the same class being loaded in multiple libraries.[/INDENT]  
[INDENT]Added Class TB\_DSE containing : ClearAllStyles & AddStyleClass[/INDENT]  
[INDENT]Added some styleclassnames to the views in the layouts[/INDENT]  
[INDENT]Changed default icon[/INDENT]  
[INDENT]Added width adjustment to layout to allow border all around the Rootpane[/INDENT]  
[INDENT]Added ResetScreen Sub for use as panic mode if the titlebar becomes inaccessible.[/INDENT]  
[INDENT]Added option to manage window position on shutdown / startup which maintains the Maximized property[/INDENT]  
299,299  
[SPOILER="Example css for dark mode"]  
.root {  
 -fx-base: rgba(60, 63, 65, 255); /\* dark \*/  
   
}  
.title-bar-bg{  
 -fx-background-color: Black;  
}  
.title-bar-icon{  
}  
.title-bar-title-label{  
 -fx-text-fill:lightgray;  
}  
.title-bar-control-btn-pane{  
}  
.title-bar-minimize-icon{  
   
}  
.title-bar-minimize-icon-pressed,  
.title-bar-maximize-icon-pressed{  
 -fx-background-color:rgba(205,205,205,0.55) ;  
}  
.title-bar-minimize-icon-hover,  
.title-bar-maximize-icon-hover{  
 -fx-background-color: rgba(205,205,205,0.35);  
}  
.title-bar-maximize-icon{  
}  
.title-bar-close-icon{  
}  
.title-bar-close-icon-hover{  
 -fx-background-color:rgba(255,0,0,0.7);  
}  
.title-bar-close-icon-pressed{  
 -fx-background-color:#FF0000;  
}  
[/SPOILER]  
  
Let me know how you get on with it.