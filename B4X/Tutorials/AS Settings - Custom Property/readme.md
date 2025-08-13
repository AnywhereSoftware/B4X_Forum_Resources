###  AS Settings - Custom Property by Alexander Stolte
### 01/06/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/164967/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/>  
  
With this property you can add your own view or layout  
  
![](https://www.b4x.com/android/forum/attachments/160466)  
  
In the following example, I add a B4XImageView to a group and the B4XBreadCrumb comes outside the group  
  
**Example**  

```B4X
    AS_Settings1.MainPage.AddGroup("Group1","Group")  
  
    AS_Settings1.MainPage.AddProperty_Boolean("Group1","Prop1","Prop 1","",Null,True)  
    AS_Settings1.MainPage.AddProperty_Boolean("Group1","Prop2","Prop 2","",Null,False)  
      
    AS_Settings1.MainPage.AddProperty_Custom("Group1","Custom1",250dip) 'Custom Property in Group  
      
    AS_Settings1.MainPage.AddProperty_Boolean("Group1","Prop3","Prop 3","",Null,True)  
    AS_Settings1.MainPage.AddProperty_Boolean("Group1","Prop4","Prop 4","",Null,False)  
      
    AS_Settings1.MainPage.AddSpaceItem("MainPage","",20dip)  
      
    AS_Settings1.MainPage.AddProperty_Custom("","Custom2",50dip) 'Custom Property without a group  
      
    AS_Settings1.MainPage.Create
```

  

```B4X
Private Sub AS_Settings1_CustomDrawCustomProperty(CustomProperty As AS_Settings_CustomDrawCustomProperty)  
      
    Select CustomProperty.Property.PropertyName  
        Case "Custom1"  
              
            CustomProperty.BackgroundPanel.LoadLayout("frm_CustomLayout_1")  
              
            Dim xiv_CustomImage1 As B4XImageView = CustomProperty.BackgroundPanel.GetView(0).Tag  
            xiv_CustomImage1.ResizeMode = "FILL_WIDTH"  
            xiv_CustomImage1.Bitmap = xui.LoadBitmap(File.DirAssets,"mycat01.jpg")  
              
        Case "Custom2"  
              
            CustomProperty.BackgroundPanel.LoadLayout("frm_CustomLayout_2")  
            CustomProperty.BackgroundPanel.Color = AS_Settings1.BackgroundColor  
              
            Dim B4XBreadCrumb1 As B4XBreadCrumb = CustomProperty.BackgroundPanel.GetView(0).Tag  
            B4XBreadCrumb1.Items.Add("Item 1")  
            B4XBreadCrumb1.Items.Add("Item 2")  
            B4XBreadCrumb1.Items.Add("Item 3")  
            B4XBreadCrumb1.Items.Add("Item 4")  
            B4XBreadCrumb1.Items.Add("Item 5")  
              
            #If B4A  
            B4XBreadCrumb1.Base_Resize(B4XBreadCrumb1.mBase.Width,B4XBreadCrumb1.mBase.Height) 'is needed in B4A for some reasons  
            #End If  
    End Select  
      
End Sub
```

  
  
You need **V2.18+** for this example