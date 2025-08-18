###  [BitmapCreator] BlurredDialog by Erel
### 10/14/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/92214/)

**Edit:** Don't use this class. Similar feature is implemented in B4XDialog (XUI Views). Set Dialog.BlurBackground =True  
  
  
![](https://www.b4x.com/basic4android/images/BlurredDialog.gif)  
  
  
![](https://www.b4x.com/basic4android/images/SS-2018-04-22_16.18.31.png)  
![](https://www.b4x.com/basic4android/images/SS-2018-04-22_16.20.33.png)  
  
This class uses [BitmapCreator](https://www.b4x.com/android/forum/posts/582791/) to blur the background and show a panel at the center of the screen.  
It is compatible with B4A, B4J and B4i.  
  
Call Show to blur the background and show a panel.  
Call Close to hide the panel and remove the blurring.  
  
Usage example:  

```B4X
Sub ShowBlurredDialog_Example  
   Dim p As B4XView = xui.CreatePanel("")  
   p.SetLayoutAnimated(0, 0, 0, 300dip, 300dip)  
   p.LoadLayout("Dialog")  
   DialogCLV.DefaultTextBackgroundColor = xui.Color_Transparent  
   DialogCLV.sv.Color = xui.Color_Transparent  
   p.SetColorAndBorder(0xaa111111, 2dip, 0xFFFFFFFF, 5dip)  
   For i = 1 To 30  
       DialogCLV.AddTextItem("Item #" & i, i)  
   Next  
   BlurredDialog1.Show(BasePanel.Parent, p)  
   Wait For DialogCLV_ItemClick (Index As Int, Value As Object)  
   Log("Selected value: " & Value)  
   Wait For (BlurredDialog1.Close) Complete (Closed As Boolean)  
End Sub
```

  
  
Note that Close is a resumable sub as it first animates the panel. The Closed parameter can be used to decide whether the back key was handled in B4A. See the example here: <https://www.b4x.com/android/forum/threads/b4x-xui-bitmapcreator-pixels-drawings-and-more.92050/#post-582791>  
  
Tips:  
  
1. You can change the BlurScale parameter to make the blurring faster. The higher the value, the faster it will be. Make sure to test performance in release mode.  
2. The effect looks nice when the dialog is semi-transparent. In B4J you need to add a CSS file with this content if you are using xCustomListView:  

```B4X
.scroll-pane{  
   -fx-background-color:transparent;  
}  
.scroll-pane .viewport {  
       -fx-background-color: transparent;  
}
```

  
  
The class is also included in the BitmapCreator example app: <https://www.b4x.com/android/forum/threads/92050>