###  Nested layouts by Erel
### 04/19/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/116545/)

![](https://www.b4x.com/android/forum/attachments/92075)  
  
Lets say that we want to build a layout such as the above where the screen is split into two halves.   
  
If we try to build this layout with a single layout file we will quickly meet a problem.   
We will add this designer script to split the screen:  

```B4X
pnlTop.SetTopAndBottom(0, 50%y)  
pnlBottom.SetTopAndBottom(50%y, 100%y)
```

  
The problem is that anchors are applied right before the designer script is executed, so the anchors will not be updated when the panels are resized.  
This means that we will not be able to use anchors and will need to set the size of all the views in the designer script.   
  
However there is a better solution, we can split the layout into three nice and clean layout files and load them with:  

```B4X
Sub Globals  
    Private WebView1 As WebView  
    Private pnlTop As B4XView  
    Private pnlBottom As B4XView  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Main")  
    pnlTop.LoadLayout("Top")  
    pnlBottom.LoadLayout("Bottom")  
End Sub
```

  
The only designer script needed is for the two panels in the main layout.  
Note that the variant size doesn't matter. The nested layouts will be resized based on the parent panels sizes.