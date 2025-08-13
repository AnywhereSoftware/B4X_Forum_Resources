### [SithasoDaisy TailwindCSS] Navmenu for Desktop, Navdraw for mobile by MichalK73
### 03/30/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/147130/)

Welcome.  
  
Sometimes we want the desktop version of a website to have a menu in a bar at the top without a side menu. Likewise for the side menu to appear on the mobile version without a menu in the top.  
You can use this code that I have applied to mine. Simple and effective.  
In addition, there is an animation of moving the mouse through the top menu and colour-coding the selected item.  
  

```B4X
Sub Process_Globals  
    Public app As SDUIApp        'ignore  
    Public BANano As BANano        'ignore  
    Public appnavbar As SDUINavBar        'ignore  
    Public appdrawer As SDUIDrawer        'ignore  
    Private menu2 As SDUIButtonGroup  
End Sub  
  
'define the menu items fo dawe  
Sub CreateDrawerMenu  
      
    If BANano.IsPhone Then 'We check that the screen corresponds to the phone  
        Log("navmenu hiden")  
        appdrawer.Clear("")  
        appdrawer.AddItemPage(Home)  
        appdrawer.AddItemPage(galery)  
        appdrawer.AddItemPage(shop)  
        appdrawer.AddItemPage(contakt)  
    Else  
        Log("navmenu show")  
        appdrawer.Hide  
        appnavbar.Hamburger.Hide  
      
        Dim item As Map = CreateMap( _  
     "home":"Home", _  
     "gallery":"Gallery", _  
     "shop":"Shop", _  
     "contact":"Contact")  
  
        For i=0 To item.Size-1  
            menu2.AddItem(item.GetKeyAt(i), item.GetValueAt(i))  
            menu2.Button(item.GetKeyAt(i)).Outline.Root.addClass("border-0").hoverBGColor("#483D8B")  
        Next  
    End If  
  
End Sub  
  
'an item in the menu is clicked  
Private Sub appdrawer_menu_Click (item As String)  
    'hide the drawer (wont hide if set to mobile)  
    appdrawer.Hide  
   
    'if this is a page  
    'navigate to it and exit  
    If app.ShowPage(item) Then Return  
   
    'we have code that does not open a page  
    Select Case item  
    End Select  
  
End Sub  
  
'Top menu operation.  
'item must be suitable For menudrawer, Or call in your own pages.  
Private Sub menu2_Click (item As String)  
    appdrawer_menu_Click(item)  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/140765)  
  
For mobile  
![](https://www.b4x.com/android/forum/attachments/140761)![](https://www.b4x.com/android/forum/attachments/140762)  
  
For desktop  
![](https://www.b4x.com/android/forum/attachments/140763)![](https://www.b4x.com/android/forum/attachments/140764)  
  
Enjoy your programming :)