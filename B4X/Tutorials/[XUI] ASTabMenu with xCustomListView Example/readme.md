###  [XUI] ASTabMenu with xCustomListView Example by Alexander Stolte
### 07/14/2022
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/115287/)

![](https://www.b4x.com/android/forum/attachments/90470)  
Hello Forum,  
  
in this Example i want to show you, how to use the [ASTabMenu](https://www.b4x.com/android/forum/threads/b4x-xui-as-tab-menu-bottom-menu.114317/) togehther with the [xCustomListView](https://www.b4x.com/android/forum/threads/b4x-xui-xcustomlistview-cross-platform-customlistview.84501/), to handle a lot of Tabs without getting into layout problems.  
Attached is a B4A Example.  
Result:  
How to use?  
it is easy.  

1. Add a xCustomListView to the form
2. Add a new Form with only the ASTabMenu inside
3. create a dummy panel in code, in this example the width of the xcustomlistview \* 2 to have 2 times more space:

1. ```B4X
   Dim xpnl_horizontal As B4XView = xui.CreatePanel("")
   ```
xpnl\_horizontal.SetLayoutAnimated(0,0,0,xclv\_horiontal.GetBase.Width \* 2,xclv\_horiontal.GetBase.Height)
xpnl\_horizontal.LoadLayout("frm\_tabmenu\_1")
xclv\_horiontal.Add(xpnl\_horizontal,"")
4. Load the ASTaBMenu Layout to this panel
5. Add the panel to the xCustomListView
6. **Finish**

Have Fun :)