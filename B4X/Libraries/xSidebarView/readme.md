###  xSidebarView by Blueforcer
### 10/04/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/134802/)

A Customview to create a simple Sidebar. Its a modified xCustomlistView and works great with B4X Drawer.  
You can add 4 types of elements: Header, Seperator, headlines and items.  
As Itemicon you can use Bitmaps, Fontawesome or Material Icon.  
  
![](https://www.b4x.com/android/forum/attachments/119867)  
  
  

```B4X
Sub Globals  
    Private drawer As B4XDrawer  
    Private xSidebarView1 As xSidebarView  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
     
    If Activity.Width>Activity.Height Then  
        drawer.Initialize(Me,"drawer",Activity,30%x)  
    Else  
        drawer.Initialize(Me,"drawer",Activity,80%x)  
    End If  
     
    Dim pm As B4XPagesManager  
    pm.Initialize(drawer.CenterPanel)  
    drawer.LeftPanel.LoadLayout("Sidebar")  
     
    xSidebarView1.CreateHeader(100dip)  
    Dim HeaderPic As B4XBitmap = xui.LoadBitmapResize(File.DirAssets,"header.png",xSidebarView1.AsView.Width,100dip,True)  
    xSidebarView1.Header.SetBitmap(HeaderPic)  
     
    xSidebarView1.CreateSeperator  
    xSidebarView1.CreateItem(xui.LoadBitmap(File.DirAssets,"haus.png"),"Home",xui.Color_Red)  
    xSidebarView1.CreateSeperator  
    xSidebarView1.CreateHeadline("Regler")  
    xSidebarView1.CreateItem(Chr(0xE01E),"Chlor",xui.Color_Red)  
    xSidebarView1.CreateItem(Chr(0xE1B8),"pH",xui.Color_Blue)  
    xSidebarView1.CreateItem(Chr(0xE80E),"Termperatur",xui.Color_Green)  
    xSidebarView1.CreateSeperator  
    xSidebarView1.CreateHeadline("Filter")  
    xSidebarView1.CreateItem(Chr(0xE01E),"Zeiten",xui.Color_Magenta)  
    xSidebarView1.CreateItem(Chr(0xE1B8),"Einstellungen",xui.Color_Yellow)  
    xSidebarView1.CreateSeperator  
    xSidebarView1.CreateHeadline("Attraktionen")  
    xSidebarView1.CreateItem(Chr(0xE01E),"Gegenstrom",xui.Color_LightGray)  
    xSidebarView1.CreateItem(Chr(0xE1B8),"Massage",xui.Color_Black)  
     
    xSidebarView1.HighlightItem(2)  
     
End Sub  
  
Sub SidebarView1_ItemClick(Value As String)  
    Log(Value)  
End Sub
```