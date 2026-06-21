###  B4XDaisyToggleGroup - Effortless Switches by Mashiane
### 06/17/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171310/)

Hello Fam!  
  
Are you looking for an easy way to group toggle switches with a clean, modern aesthetic in your B4A, B4J, or B4i projects? Allow me to introduce the **B4XDaisyToggleGroup**!  
This versatile UI component takes the hassle out of building settings pages, privacy toggles, and form inputs. Instead of manually positioning dozens of switches and labels, the B4XDaisyToggleGroup automatically handles layout, scaling, and alignment for you.  
  
**Key Features Include:**  

- **Flexible Alignments:** Stack your items vertically or horizontally. You can even set the alignment so labels appear on the left while toggles are perfectly aligned on the right.
- **Dynamic Size Coupling:** Easily scale your component from XS to LG. The legend size automatically couples with the toggle size for a perfectly proportioned UI.
- **Extensive Styling:** Customize padding, gap sizes, background colors, border styles (outlined, ghost, inset), and corner radius (rounded, rounded-box).
- **Simple Event Trapping:** Instantly trap when an individual item changes or retrieve the full list of currently selected IDs.

**Getting Started (Beginner Friendly Example)**  
  
![](https://www.b4x.com/android/forum/attachments/171906) ![](https://www.b4x.com/android/forum/attachments/171907)  
  
  
Here is a simple usage code snippet showing how to initialize the component, configure properties, add items, and listen for events. It’s perfect for getting up and running in minutes!  
  

```B4X
#Region Project Attributes  
    ' … standard attributes …  
#End Region  
  
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
     
    ' 1. Declare the component  
    Private myToggleGroup As B4XDaisyToggleGroup  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
     
    ' 2. Initialize the component with its callback and event name  
    myToggleGroup.Initialize(Me, "myToggleGroup")  
     
    ' 3. Add it to the parent view programmatically (You can also use the Designer!)  
    ' Format: AddToParent(Parent, Left, Top, Width, Height)  
    myToggleGroup.AddToParent(Root, 20dip, 20dip, 300dip, 250dip)  
     
    ' 4. Set visual properties  
    myToggleGroup.setLegend("Select Notification Channels")  
    myToggleGroup.setToggleColor("primary")  
    myToggleGroup.setToggleSize("md")  
    myToggleGroup.setAlignment("end") ' Puts labels on the left, toggles on the right  
    myToggleGroup.setBorderStyle("outlined")  
     
    ' 5. Add Items (ID, Display Text)  
    myToggleGroup.AddItem("email", "Email Updates")  
    myToggleGroup.AddItem("sms", "SMS Alerts")  
    myToggleGroup.AddItem("push", "Push Notifications")  
     
    ' Optional: Check a specific item by default  
    myToggleGroup.CheckItem("email")  
End Sub  
  
' — Event Trapping —  
  
' Traps when an individual toggle switch is turned on or off  
Private Sub myToggleGroup_ItemChanged(Id As String, Text As String, Checked As Boolean)  
    Log($"Item Changed! ID: ${Id}, Text: ${Text}, New State: ${Checked}"$)  
End Sub  
  
' Traps whenever the overall selection in the group changes  
Private Sub myToggleGroup_Changed(SelectedIds As List)  
    Log("Currently active toggles: " & SelectedIds)  
End Sub
```

  
  
Whether you are a beginner looking to build your first professional settings screen, or a veteran aiming to save time on UI boilerplate, the B4XDaisyToggleGroup is ready for your next project.  
  
#SharingTheGoodness!  
  
[MEDIA=youtube]9FmmZ43IfO8[/MEDIA]