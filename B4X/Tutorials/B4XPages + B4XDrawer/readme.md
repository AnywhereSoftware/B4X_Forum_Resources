###  B4XPages + B4XDrawer by Erel
### 09/19/2021
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/120246/)

B4XDrawer v1.53 adds support for B4J. This is a good opportunity to create a B4XPages example using B4XDrawer.  
It does require some configuration so pay attention.  
  
![](https://www.b4x.com/android/forum/attachments/97232)  
  
The example is based on the three pages example: <https://www.b4x.com/android/forum/threads/b4x-b4xpages-cross-platform-and-simple-framework-for-managing-multiple-pages.118901/#content>  
A drawer is added to the second page. Everything is implemented in the attached example.  
  
1. **This is already part of the template.**   
Only required in B4A and will be part of the template in the next version of B4XPages.b4xtemplate:  
In Main module:  

```B4X
'modify the existing subs  
Sub Process_Globals  
    Public ActionBarHomeClicked As Boolean  
End Sub  
  
Sub Activity_ActionBarHomeClick  
    ActionBarHomeClicked = True  
    B4XPages.Delegate.Activity_ActionBarHomeClick  
    ActionBarHomeClicked = False  
End Sub
```

  
  
2. In the page where you want to add the drawer:  
Add to B4XPage\_Created:  

```B4X
HamburgerIcon = xui.LoadBitmapResize(File.DirAssets, "hamburger.png", 32dip, 32dip, True) 'global B4XBitmap  
#if B4i  
Dim bb As BarButton  
bb.InitializeBitmap(HamburgerIcon, "hamburger")  
B4XPages.GetNativeParent(Me).TopLeftButtons = Array(bb)  
#Else If B4J  
Dim iv As ImageView  
iv.Initialize("imgHamburger")  
iv.SetImage(HamburgerIcon)  
Drawer.CenterPanel.AddView(iv, 2dip, 2dip, 32dip, 32dip)  
iv.PickOnBounds = True  
#end if
```

  
  
And add these subs:  

```B4X
#if B4J  
Sub imgHamburger_MouseClicked (EventData As MouseEvent)  
    Drawer.LeftOpen = True  
End Sub  
#else if B4i  
Private Sub B4XPage_MenuClick (Tag As String)  
    If Tag = "hamburger" Then  
        Drawer.LeftOpen = Not(Drawer.LeftOpen)  
    End If  
End Sub  
#end if  
  
Private Sub B4XPage_CloseRequest As ResumableSub  
    #if B4A  
    'home button  
    If Main.ActionBarHomeClicked Then  
        Drawer.LeftOpen = Not(Drawer.LeftOpen)  
        Return False  
    End If  
    'back key  
    If Drawer.LeftOpen Then  
        Drawer.LeftOpen = False  
        Return False  
    End If  
    #end if  
    Return True  
End Sub  
  
Private Sub B4XPage_Appear  
    #if B4A  
    Sleep(0)  
    B4XPages.GetManager.ActionBar.RunMethod("setDisplayHomeAsUpEnabled", Array(True))  
    Dim bd As BitmapDrawable  
    bd.Initialize(HamburgerIcon)  
    B4XPages.GetManager.ActionBar.RunMethod("setHomeAsUpIndicator", Array(bd))  
    #End If  
End Sub  
  
Private Sub B4XPage_Disappear  
    #if B4A  
    B4XPages.GetManager.ActionBar.RunMethod("setHomeAsUpIndicator", Array(0))  
    #end if  
End Sub  
  
Private Sub B4XPage_Resize (Width As Int, Height As Int)  
    Drawer.Resize(Width, Height)  
End Sub
```