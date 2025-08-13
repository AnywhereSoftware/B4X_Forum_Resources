###  [XUI] AS CardSlider by Alexander Stolte
### 01/14/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/153204/)

A simple card slider with advanced customization options.  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/146258)![](https://www.b4x.com/android/forum/attachments/146260)  
**SideGap**  
The width in dip, how much should the next item be visible. e.g. 80dip left and 80dip right  
![](https://www.b4x.com/android/forum/attachments/146261)  
**ItemWidth**  
Here you can set the width of the page, then the SideGap will be calculated automatically.  
**Important**: Set the property before adding pages, because it clears the list.  
e.g you want a page width of 100dip  
![](https://www.b4x.com/android/forum/attachments/146262)  
**Examples**  

```B4X
    AS_CardSlider1.ItemWidth = 100dip'overrides the SideGap property in the designer  
  
    For i = 0 To 5 -1  
   
        Dim xpnl As B4XView = xui.CreatePanel("")  
        xpnl.SetLayoutAnimated(0,0,0,AS_CardSlider1.ItemWidth,AS_CardSlider1.mBase.Height)  
        'xpnl.Color = xui.Color_ARGB(255,Rnd(0,256),Rnd(0,256),Rnd(0,256))  
        xpnl.LoadLayout("frm_Item1")  
   
        Dim xlbl_Text As B4XView = xpnl.GetView(0)  
        xlbl_Text.Text = "Item #" & (i+1)  
   
        AS_CardSlider1.AddPage(xpnl,i)  
   
    Next
```

  
**Lazy Loading**  
You can enable lazy loading in the designer  
![](https://www.b4x.com/android/forum/attachments/146263)  

```B4X
    For i = 0 To 5 -1  
   
        Dim xpnl As B4XView = xui.CreatePanel("")  
        xpnl.SetLayoutAnimated(0,0,0,AS_CardSlider1.ItemWidth,AS_CardSlider1.mBase.Height)  
        AS_CardSlider1.AddPage(xpnl,i)  
   
    Next  
  
Private Sub AS_CardSlider1_LazyLoadingAddContent(Parent As B4XView, Value As Object)  
   
    Parent.LoadLayout("frm_Item1")  
   
    Dim xlbl_Text As B4XView = Parent.GetView(0)  
    xlbl_Text.Text = "Item #" & (Value+1)  
   
End Sub
```

  
**Text Example**  
![](https://www.b4x.com/android/forum/attachments/146350)  
<https://www.b4x.com/android/forum/threads/b4x-as-cardslider-text-animation.153523/#post-957279>  
  
**AS\_CardSlider  
Author: Alexander Stolte  
Version: 1.00**  

- **AS\_CardSlider**

- **Events:**

- **LazyLoadingAddContent** (Parent As B4XView, Value As Object)
- **PageChanged** (OldIndex As Int, NewIndex As Int)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddPage** (LayoutPanel As B4XView, Value As Object) As String
- **Base\_Resize** (Width As Double, Height As Double)
- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getBase** As B4XView
*gets the base view (mBase)*- **getCustomListView** As b4a.example3.customlistview
- **getIndex** As Int
*gets the selected index*- **getItemWidth** As Float
*If you set this, then it overrides the SideGap property  
 The SideGap is calculated automatically  
 Set this,before you add pages*- **getLazyLoadingExtraSize** As Int
- **getLoadingPanelColor** As Int
- **GetPanel** (Index As Int) As B4XView
- **getSize** As Int
- **GetValue** (Index As Int) As Object
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **NextPage** As String
- **PreviousPage** As String
- **Refresh** As String
- **RefreshLite** As String
*Refresh the visible area*- **setCornerRadius** (Radius As Int) As String
*sets the corner radius of the view*- **setIndex** (Index As Int) As String
- **setItemWidth** (Width As Float) As String
- **setLazyLoadingExtraSize** (ExtraSize As Int) As String
- **setLoadingPanelColor** (Color As Int) As String
*The color of the Loading panel If Base\_Resize Is executed*
- **Properties:**

- **Base** As B4XView [read only]
*gets the base view (mBase)*- **CornerRadius**
*sets the corner radius of the view*- **CustomListView** As b4a.example3.customlistview [read only]
- **Index** As Int
*gets the selected index*- **ItemWidth** As Float
*If you set this, then it overrides the SideGap property  
 The SideGap is calculated automatically  
 Set this,before you add pages*- **LazyLoadingExtraSize** As Int
- **LoadingPanelColor** As Int
*The color of the Loading panel If Base\_Resize Is executed*- **Size** As Int [read only]

**Changelog**  

- **1.00**

- Release

- **1.01**

- Add RemovePageAt

- **1.02**

- Add Clear

**Github:** [github.com/StolteX/AS\_CardSlider](https://github.com/StolteX/AS_CardSlider)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)