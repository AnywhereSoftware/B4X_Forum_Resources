### B4xEasyTabber - Cross Platform Tabber by Jack Cole
### 12/12/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/112113/)

So, why write another cross-platform tabber? I really didn't want to write one, but I couldn't make the existing tabbers work the way I wanted. What I wanted was a no frills tabber that allowed programmatic alteration of its content in addition to designer support. What I also wanted was a tabber that didn't use multiple "pages" on iOS's NavigationController. This just would not work correctly with the [cross platform class and development strategy](https://www.b4x.com/android/forum/threads/activityclass-a-cross-platform-development-class-and-strategy-for-b4i-b4a.109253/#post-682499) that I use for iOS that allows for sharing nearly 100% of the code between b4a and b4i. I really want others to use both b4a and b4i together more, and that is why I'm sharing this.  
  
How to use in b4a:  
Add the classes B4xEasyTabber and RippleOverlay to your project. RippleOverlay is used to create the click effect when you tap the tab. Add the B4xEasyTabber using the designer and generate the global variable and TabChanged events.  
  
It is very easy to use for adding content to the tab panels and making programmatic alterations.  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("main2_menu")  
    B4xEasyTabber1.GetTabPanel(0).LoadLayout("tabcontent")  
    B4xEasyTabber1.GetTabPanel(1).LoadLayout("tabcontent")  
    B4xEasyTabber1.GetTabTitleLabel(0).Text="Tab 1"  
End Sub  
  
Sub Activity_Resume  
    'restore the tab if returning to the activity or changing orientation  
    If LastTab<>B4xEasyTabber1.CurrentTab Then B4xEasyTabber1.CurrentTab=LastTab  
End Sub  
  
Sub B4xEasyTabber1_TabChanged (ActiveTabNumber As Int)  
    LastTab=ActiveTabNumber  
End Sub
```

  
  
You can easily change properties of the elements.  
![](https://www.b4x.com/android/forum/attachments/86259)  
  
The attached example is a cross platform starter project containing a b4a and b4i project. The b4a project contains all the code and the b4i project shares all the modules.  
  
Here is iOS:  
![](https://www.b4x.com/android/forum/attachments/86260)  
  
Android:  
![](https://www.b4x.com/android/forum/attachments/86261)