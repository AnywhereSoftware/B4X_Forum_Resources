### PanelBarNize Library by Eng. Nizar
### 08/13/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/171790/)

```B4X
Sub Globals  
    …  
    Private ABAR As PanelBarNize  
  
End Sub  
Sub Activity_Create(FirstTime As Boolean)  
    …  
    ABAR.Initialize(Activity)  
'    ABAR.Initialize(root.parent)  
  
    ABAR.Add_Sidepopup(Chr(0xE148),"title1",Array("Pop1",2,3,4),"Side_Pop1")  
    ABAR.Add_SideContinue(1)  
    ABAR.Add_SideAction("","Label1","Side_aaa")  
    ABAR.Add_SideContinue(1)  
    ABAR.Add_SideAction(Chr(0xE148),"lbl2","Side_LblAct2")  
    ABAR.Add_SideContinue(1)  
    ABAR.Add_SideEmpty(1)  
    ABAR.Add_SideAction("","Label3","Side_LblAct3")  
    ABAR.Add_SideContinue(2)  
    ABAR.Set_isIconAbove(True)  
      
    'to write Even Subs watch the Logs…  
    'you Can for (SideBar, PanelBar, PanelMenu) :  
    ' - get it as Panel:  
'    Dim SideBar1 As Panel = ABAR.get_SideBar("t",12,Colors.white,Colors.Cyan,Colors.black) 'Way0 as Panel  
    'OR 'Dim SideBar1 As Panel = ABAR.Show_SideBar(root,"t",12,Colors.white,Colors.Cyan,Colors.black)  
      
    ' - Add SideBar To Aview Direct :  
'    ABAR.Show_SideBar(root,"t",14,Colors.white,Colors.Cyan,Colors.black) 'Way1  
      
    ' - Use ExtraForScroll :  
    ABAR.Set_ExtraForScroll(100dip) 'Way2  
    ABAR.Show_SideBar(Activity,"t",14,Colors.white,Colors.Cyan,Colors.black) 'Way2  
  
    ' - for Auto Scroll :  
'    ABAR.Show_SideBar(root,"t",-14,Colors.white,Colors.Cyan,Colors.black) 'Way3  
  
  
End Sub
```

![](https://www.b4x.com/android/forum/attachments/172886)