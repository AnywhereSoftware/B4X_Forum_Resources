###  B4XDaisyFilter - Beautiful, Animated & Customizable Filter Buttons! by Mashiane
### 06/24/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171375/)

Hello Fam! 👋  
  
Are you looking for a modern, highly customizable, and visually appealing way to let users filter data, select categories, or pick options in your apps? I am thrilled to introduce **B4XDaisyFilter**, a custom UI component that brings beautifully animated filter buttons right into your cross-platform B4A, B4i, and B4J applications!  
Inspired by modern web UI frameworks, B4XDaisyFilter acts as an elegant replacement for standard checkboxes or radio buttons, packing a lot of features into a beginner-friendly package.  
  
**✨ Key Features:**  

- **Dual Modes:** Seamlessly switch between Single-Select (like radio buttons) and Multi-Select (like checkboxes) modes.
- **Integrated Reset Button:** Give users a quick way to clear their filters with a customizable reset button (e.g., an "x" or custom text) that can be positioned on the left or right.
- **DaisyUI Inspired Variants:** Instantly style your buttons using built-in theme variants including neutral, primary, secondary, accent, info, success, warning, and error.
- **Highly Customizable Styling:** Adjust the shape with multiple Rounded options (from rounded-none to rounded-full) and tweak the FilterStyle (choose between solid, soft, outline, dash, or ghost).
- **Smooth Animations:** Enjoy a built-in customizable animation transition when the layout updates.

  
![](https://www.b4x.com/android/forum/attachments/172028) ![](https://www.b4x.com/android/forum/attachments/172029)  
  
  
🚀 Beginner-Friendly Quick Start Guide  
  
Using **B4XDaisyFilter** is incredibly simple! You can easily drop it into your layout using the B4X Designer, or build it entirely via code. Here is a simple example of how to initialize it programmatically, set up its properties, and listen to its events.  
  
**1. Initialization and Setup**  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
     
    ' 1. Declare the component  
    Private myAwesomeFilter As B4XDaisyFilter  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
     
    ' 2. Initialize the component.  
    ' The arguments are the Callback module (usually Me) and the EventName prefix.  
    myAwesomeFilter.Initialize(Me, "myAwesomeFilter")  
     
    ' 3. Configure Properties dynamically  
    ' Pass your options as a comma-separated list of key:value pairs.  
    myAwesomeFilter.setOptions("apple:Apple, banana:Banana, orange:Orange")  
    myAwesomeFilter.setMultiSelect(True)      ' Allow selecting multiple options  
    myAwesomeFilter.setVariant("primary")     ' Set a beautiful primary color theme  
    myAwesomeFilter.setRounded("rounded-full") ' Give the buttons pill-shaped edges  
    myAwesomeFilter.setResetText("Clear All") ' Custom text for the reset button  
     
    ' 4. Add it to your layout (Parent, Left, Top, Width, Height)  
    myAwesomeFilter.AddToParent(Root, 10dip, 10dip, 300dip, 60dip)  
End Sub
```

  
  
**2. Trapping Events (Catching User Interaction)** The component automatically fires intuitive events when a user interacts with it.  
  

```B4X
' Triggered whenever the overall selection changes.  
' Returns a B4X List of the currently selected keys.  
Private Sub myAwesomeFilter_Changed(Keys As List)  
    If Keys.Size > 0 Then  
        Log("User selected the following items: " & Keys)  
    Else  
        Log("No items are currently selected.")  
    End If  
End Sub  
  
' Triggered when a specific individual button is clicked  
Private Sub myAwesomeFilter_ItemChanged(Id As String, Text As String, Checked As Boolean)  
    Log("Item clicked! ID: " & Id & " | Display Text: " & Text & " | Is Checked: " & Checked)  
End Sub  
  
' Triggered when the user clicks the Reset ('Clear All') button  
Private Sub myAwesomeFilter_ResetClick  
    Log("The filter was completely reset by the user!")  
End Sub
```

  
  
Whether you are filtering a list of database results or creating a stylish settings page, **B4XDaisyFilter** is designed to make your B4X UI pop with minimal effort.  
  
  
[MEDIA=youtube]YxMEGBi27AQ[/MEDIA]  
Give it a try and let me know what you build below! Happy coding! 👨‍💻👩‍💻