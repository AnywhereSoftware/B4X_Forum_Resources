###  ComboBoxPlus - ComboBox with individual color configurable items by gregchao
### 02/25/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/133167/)

I wanted to be able to change the color of individual items in the Combobox list (playing card application) so I created my own ComboBox based on xCustomlistview. The result is a highly configurable ComboBox. I put some additional effort to make it cross platform. Feel free to modify the code for your own use. Just rename .b4xlib to .zip and extract module and layout files.  
  
  
  
  
[SIZE=5]**Installation Instructions**[/SIZE]  

1. [SIZE=4]Download and put in your additional libraries folder - ComboBoxPlusL.b4xlib[/SIZE]
2. [SIZE=4]It should appear as one of your libraries - Check it[/SIZE]
3. [SIZE=4]Add these additional libraries[/SIZE]

- B4J - ByteConverter, XUI Views
- B4A - ByteConverter, Reflection, xCustomListView
- B4I - iRandomAccessFile, iXUI Views

  
[SIZE=5]**Setting Colors for ComboBox Items**[/SIZE]  

1. In Designer View, you should be able to access under Add View>CustomView>ComboBoxPlus and place it on you layout.
2. [SIZE=4]You can set the colorkey colors. You have 6 configurable choices with index = 0 to 5[/SIZE]

![](https://www.b4x.com/android/forum/attachments/117454)  
  
[SIZE=5]**Loading ComboBoxPlus**[/SIZE]  

1. [SIZE=4]Use the additems function. For each item, you can now assign a text and color (colorkey = 0-5).[/SIZE]

[SIZE=4].[/SIZE]  

```B4X
For x =  0  To  10  
        ComboBoxPlusL1.AddItems(“text here”, “colorkey here”, "enabled" - true,false)  
Next
```

  
  
  
**[SIZE=5]ComboBoxPlusL  
**Author:** Gregory Chao[/SIZE]**  

- **Events**

- **selected** (index as int, value As string) - *triggers when user makes selection*
- **changed** (index as int, value As string) - *triggers when user changes selection or selection is changed through code (I.e. SetSelected).*
- **opened**() **-** *triggers when user opens combobox*

- **Functions/Properties**

- **AddItems** (cd As String, colorkey As Int, enabled as boolean) - *Adds item to ComboBox along with color defintion*
- **AddItemAt** (Position As Int, cd As String, colorkey As Int, enabled as boolean) - *Inserts an item to ComboBox*
- **RemoveItemAt** (Position As Int) - *Removes an item from ComboBox*
- **Clear -** *Clears all items from ComboBox*
- **SetSelected** (Index As Int) - *Sets the selected item.*
- **SetItemColor** (Index as Int, colorkey as int) *- Changes color of an item*
- **SetEnable** (Index as int, enabled as boolean) - *sets enabled of an item*
- **GetItemColorkey** (Index as int) as int - Gets colorkey of an item
- **GetSelectedIndex** As Int - *Gets the selected index*
- **GetSelectedValue** As String - *Gets the selected item*
- **GetValue** (Index As Int) As String - *Gets an item given its index*
- **GetIndex** (Value As String) As Int - *Gets an index given an item*
- **GetEnable** (Index as int) as boolean - *Gets enabled of an item*
- **GetVersion** as String *- Gets the version*
- **Visible** as Boolean - Get or setsthe visible state
- **GetItems** As List - *Gets all items*
- **ExpandedHeight** As Float - *Gets or sets height when expanded*
- **FontSize** as Float - *Gets or sets Fontsize*
- **Close -** forces the Combobox to close
- **AutoClose** as Boolean - *Gets or sets whether combobox will close after selection (default is true)*
- **Enabled** as Boolean - *Gets or sets enable of combobox*

**[SIZE=5]Changelog[/SIZE]**  

- **[SIZE=4]1.00 - [/SIZE]**[SIZE=4]Release[/SIZE]
- [SIZE=4]**2.00** - Added enabled feature[/SIZE]
- [SIZE=4]**3.00** - Added Show, Hide, IsVisible, and GetItems[/SIZE]
- [SIZE=4]**4.00** - Fixed Library reference in B4i version. Incorrect reference to iXUI and ByteConverter, Fixed B4i pull down visibility[/SIZE]
- [SIZE=4]**5.00** - Added GetItemColorkey feature[/SIZE]
- [SIZE=4]**6.00** - Disable can now be signified by graying entry string or background (use Designer to choose). Designer size is now compact size, you must enter expanded height in Designer (in line with standard practice).[/SIZE]
- [SIZE=4]**8.00** - fixed button size scaling; in B4i, allow only graying box (no gray text) when disabled; added GetExpandedHeight and SetExpandedHeight[/SIZE]
- [SIZE=4]**9.00** - fixed fontscaling to respond to "Autoscale All", added Get/Set Fontsize[/SIZE]
- [SIZE=4]**10.00** - fixed a minor bug related to label BBLabel size[/SIZE]
- [SIZE=4]**15.00 -** added close and autoclose feature[/SIZE]
- [SIZE=4]**16.00 -** Speed up optimizations (removed BBLabel, CLV item layout), Font type by list selection[/SIZE]
- [SIZE=4]**17.00** - Event Opened, added enabled feature on Combobox[/SIZE]
- **18.00 -** Fixed Error if Event Open not defined in code
- **19.00 -** Fixed fontsize issue in B4a
- **20.00 -** Fixed error occuring if you don't define callback

[SIZE=5]**Example**[/SIZE]  
  
[SIZE=4]Follow this link for a full example. ComboBoxPlusL is a module in the example so you can see/modify the code if you like. To use library version, you will need download the library below and place it in your library folder. Then, select the library to include it and delete the ComboBoxPlusL module.[/SIZE]  
  
[[SIZE=4]https://www.dropbox.com/scl/fi/3q1jkmif2qjozkot2mfgn/ComboBoxLibraryLite-20240224v20.zip?rlkey=p7nd4xc1ijkhpnpizwrsdkj2c&dl=0[/SIZE]](https://www.dropbox.com/scl/fi/3q1jkmif2qjozkot2mfgn/ComboBoxLibraryLite-20240224v20.zip?rlkey=p7nd4xc1ijkhpnpizwrsdkj2c&dl=0)  
  
You will need to enable following libraries:  
  
B4J.DependsOn=ByteConverter, XUI Views  
B4A.DependsOn=ByteConverter, xCustomListView  
B4i.DependsOn=iRandomAccessFile, XUI Views  
  
[SIZE=4]Special Note: It is highly advised to load the ComboBoxPlusL in the B4Xpages\_Appear subroutine. For B4i, this is especially important with the "Autoscale All" engaged. This is due to the fact that the size changes from "Autoscale All" do not register until the Appear occurs. For B4a, if you load in B4Xpages\_Create, you need to put a sleep(0) before loading. B4j does not seem to have these issues so you can load in B4Xpages\_Create or B4X\_Appear without a sleep(0).[/SIZE]