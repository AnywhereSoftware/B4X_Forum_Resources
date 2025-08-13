###  AS Settings - SelectionList Property by Alexander Stolte
### 03/10/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/159217/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/>  
  
With this property, you can offer the user several options and he can then select either one or more.  
![](https://www.b4x.com/android/forum/attachments/150766)  
**Example**  

```B4X
    'Second Page  
    SettingPage2.Initialize(AS_Settings1,"Page #2")  
    
    SettingPage2.AddGroup("MultiOptionExample","Multi Option")  
    
    Dim lst_Items As List  
    lst_Items.Initialize  
    lst_Items.Add(AS_Settings1.CreateSelectionListItem("Option #1",Null,1))  
    lst_Items.Add(AS_Settings1.CreateSelectionListItem("Option #2",Null,2))  
    lst_Items.Add(AS_Settings1.CreateSelectionListItem("Option #3",Null,3))  
    lst_Items.Add(AS_Settings1.CreateSelectionListItem("Option #4",Null,4))  
    lst_Items.Add(AS_Settings1.CreateSelectionListItem("Option #5",Null,5))  
    
    SettingPage2.AddProperty_SelectionList("MultiOptionExample","OptionsExample1",lst_Items,Array(),True,True)
```

  
**Default Value**  
The default value is an array, if you dont want a default value, then put an empty array.  

```B4X
    Dim lst_Items As List  
    lst_Items.Initialize  
    lst_Items.Add(AS_Settings1.CreateSelectionListItem("Option #1",Null,1))  
    lst_Items.Add(AS_Settings1.CreateSelectionListItem("Option #2",Null,2))  
    lst_Items.Add(AS_Settings1.CreateSelectionListItem("Option #3",Null,3))  
    lst_Items.Add(AS_Settings1.CreateSelectionListItem("Option #4",Null,4))  
    lst_Items.Add(AS_Settings1.CreateSelectionListItem("Option #5",Null,5))  
    
    'Option #1 is default value  
    SettingPage2.AddProperty_SelectionList("MultiOptionExample","OptionsExample1",lst_Items,Array(1),True,True)  
    
    'Option #1 and Option #5 is default value  
    SettingPage2.AddProperty_SelectionList("MultiOptionExample","OptionsExample1",lst_Items,Array(1,5),True,True)  
    
    'No default value  
    SettingPage2.AddProperty_SelectionList("MultiOptionExample","OptionsExample1",lst_Items,Array(),True,True)
```

  
**MultiSelect**  
If true more than one item can selected. If false only one item is selected if you click, it deselect the previous item  
![](https://www.b4x.com/android/forum/attachments/150772) ![](https://www.b4x.com/android/forum/attachments/150773)  
**CanDeselectAll**  
If false, then the last item cannot be deselected, it need min one selected  
  
**Icons  
![](https://www.b4x.com/android/forum/attachments/150767)**  

```B4X
    SettingPage2.Initialize(AS_Settings1,"Theme")  
    
    SettingPage2.AddGroup("MultiOptionExample","Accent Color")  
    
    Dim lst_Items As List  
    lst_Items.Initialize  
    lst_Items.Add(AS_Settings1.CreateSelectionListItem("Green",AS_Settings1.FontToBitmap(Chr(0xF111),False,30,xui.Color_RGB(45, 136, 121)),1))  
    lst_Items.Add(AS_Settings1.CreateSelectionListItem("Blue",AS_Settings1.FontToBitmap(Chr(0xF111),False,30,xui.Color_RGB(73, 98, 164)),2))  
    lst_Items.Add(AS_Settings1.CreateSelectionListItem("Red",AS_Settings1.FontToBitmap(Chr(0xF111),False,30,xui.Color_RGB(221, 95, 96)),3))  
    lst_Items.Add(AS_Settings1.CreateSelectionListItem("Purple",AS_Settings1.FontToBitmap(Chr(0xF111),False,30,xui.Color_RGB(141, 68, 173)),4))  
    lst_Items.Add(AS_Settings1.CreateSelectionListItem("Magenta",AS_Settings1.FontToBitmap(Chr(0xF111),False,30,xui.Color_Magenta),5))  
    lst_Items.Add(AS_Settings1.CreateSelectionListItem("Cyan",AS_Settings1.FontToBitmap(Chr(0xF111),False,30,xui.Color_Cyan),6))  
    
    SettingPage2.AddProperty_SelectionList("MultiOptionExample","OptionsExample1",lst_Items,Array(1),False,False)
```