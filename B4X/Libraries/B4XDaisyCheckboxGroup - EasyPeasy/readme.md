###  B4XDaisyCheckboxGroup - EasyPeasy... by Mashiane
### 06/17/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171307/)

Hello Fam! 👋  
  
Are you tired of plain, rigid checkbox lists? Let me introduce you to **B4XDaisyCheckboxGroup**—a sleek, feature-packed custom UI component designed to make your app interfaces pop with almost zero effort.  
  
Built with extensive designer properties and easy programmatic control, this component takes the heavy lifting out of modern UI design. Whether you want a simple vertical list, a modern settings-menu style with "labels on the left, checkboxes on the right", or dynamic size scaling where your title legends scale perfectly with your checkboxes, this view handles it all effortlessly.  
  
**🌟 Key Features at a Glance:**  

- **Highly Customizable Styling:** Adjust padding, border styles (outlined, ghost, inset), rounded corners, and drop shadows right from the designer.
- **Rich Color Controls:** Easily override background colors, text colors, border colors, and use variants like success, primary, or neutral for the checkboxes.
- **Flexible Layouts:** Align checkboxes at the start or end of the label.
- **Smart Scaling:** Choose from sizes like xs, sm, md, lg, or xl—the legend text can couple directly to your size choices.
- **Auto Height:** Automatically grows to fit the content you add dynamically.

  
![](https://www.b4x.com/android/forum/attachments/171899) ![](https://www.b4x.com/android/forum/attachments/171900)  
  
  
  
💻 Beginner-Friendly Usage Example  
  
It is incredibly easy to get started. Here is a simple, beginner-friendly code snippet showing how to initialize the component programmatically, add items, set up some styles, and trap the user's selections.  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
      
    ' Declare our Checkbox Group  
    Private myGroup As B4XDaisyCheckboxGroup  
End Sub  
  
Private Sub B4XPage_Created(Root1 As B4XView)  
    Root = Root1  
    Root.Color = xui.Color_RGB(245, 247, 250) ' Nice light background [4]  
      
    ' 1. Initialize the component (Pass the callback module and the event name prefix) [5]  
    myGroup.Initialize(Me, "myGroup")  
      
    ' 2. Set some properties programmatically   
    myGroup.Legend = "Select Notifications" ' Set the fieldset title [6]  
    myGroup.CheckboxColor = "success" ' Make them a nice green color! [1, 7]  
    myGroup.Alignment = "end" ' Places text on the left, checkbox on the right [1, 8]  
    myGroup.BorderStyle = "inset" ' Give it a cool inset card look [1, 9]  
      
    ' 3. Add the component to the page/parent [10]  
    myGroup.AddToParent(Root, 20dip, 20dip, 300dip, 250dip)  
      
    ' 4. Add items to our group (ID, Display Text) [11]  
    myGroup.AddItem("email", "Email Alerts")  
    myGroup.AddItem("sms", "SMS Messages")  
    myGroup.AddItem("push", "Push Notifications")  
      
    ' 5. Pre-check an item by its ID [6]  
    myGroup.CheckItem("email")  
End Sub  
  
' ==========================================  
' EVENT TRAPPING  
' ==========================================  
  
' Fires when a single checkbox is toggled [12]  
Private Sub myGroup_ItemChanged(Item As Map)  
    Dim id As String = Item.Get("id")  
    Dim isChecked As Boolean = Item.Get("checked")  
      
    Log($"Item Clicked: ${id} is now ${isChecked}"$)  
End Sub  
  
' Fires and provides a list of ALL currently checked IDs [11, 13]  
Private Sub myGroup_SelectionChanged(SelectedIds As List)  
    Log("Current selections: " & SelectedIds)  
End Sub
```

  
  
Jump in, try it out in your projects, and let me know what you think! Happy coding! 🚀  
  
#SharingTheGoodness  
  
[MEDIA=youtube]VAC4QLIguZQ[/MEDIA]