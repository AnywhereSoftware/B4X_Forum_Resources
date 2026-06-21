###  B4XDaisyRadioGroup - Modern, Responsive & Highly Customizable Radio Buttons! by Mashiane
### 06/17/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171309/)

Hello Fam!  
  
Are you tired of basic radio buttons that don't match your app's modern design? I'd like to introduce the **B4XDaisyRadioGroup**, a highly customizable and aesthetically pleasing component designed to bring a modern UI feel directly to your B4A, B4J, and B4i applications.  
  
The **B4XDaisyRadioGroup** wraps your standard radio options in a beautiful fieldset with a built-in customizable legend (like "Select your gender" or "Choose a plan"). It is designed with responsive UI principles, allowing your form inputs to automatically adjust and scale gracefully.  
  
**Key Features Include:**  

- **Coupled Size Scaling:** Easily scale your component using simple tokens (xs, sm, md, lg, xl). Your legend text and radio dots scale together flawlessly.
- **Flexible Layouts:** Display your items in a standard vertical stack or horizontally. You can even align the radio dots to the left or right of your labels.
- **Deep Customization:** Tweak the styling using built-in theme variants (primary, secondary, accent, success, warning, error), override border and text colors, or switch border styles from outlined to inset or ghost.
- **Auto Height & Padding:** Let the component manage itself! It can automatically grow to fit dynamically added content while respecting your custom padding and gap rules.

![](https://www.b4x.com/android/forum/attachments/171904) ![](https://www.b4x.com/android/forum/attachments/171905)  
  
  
**🚀 Quick Start Example**  
  
We wanted to make onboarding as beginner-friendly as possible. Here is a simple snippet showing how to initialize the view, customize it, populate it with data, and trap the selection event.  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    ' 1. Declare the component  
    Private myRadioGroup As B4XDaisyRadioGroup  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
     
    ' 2. Initialize the component and bind events to this module  
    myRadioGroup.Initialize(Me, "myRadioGroup")  
     
    ' 3. Add to parent view (Parent, Left, Top, Width, Height)  
    myRadioGroup.AddToParent(Root, 20dip, 20dip, 300dip, 200dip)  
     
    ' 4. Customize properties  
    myRadioGroup.setLegend("Choose a plan")  
    myRadioGroup.setRadioColor("primary")  
    myRadioGroup.setRadioSize("md")  
     
    ' 5. Add options (ID, Label Text)  
    myRadioGroup.AddItem("free", "Free Plan")  
    myRadioGroup.AddItem("pro", "Pro Plan")  
    myRadioGroup.AddItem("enterprise", "Enterprise")  
     
    ' Set a default selection  
    myRadioGroup.setSelectedId("pro")  
End Sub  
  
' 6. Trap the ItemChanged event to see what the user picked  
Private Sub myRadioGroup_ItemChanged(Item As Map)  
    Dim id As String = Item.Get("id")  
    Dim checkedState As Boolean = Item.Get("checked")  
     
    ' Only log when an item is selected (not when unselected)  
    If checkedState Then  
        Log("User successfully selected plan: " & id)  
    End If  
End Sub
```

  
  
Let me know what you think below! #SharingTheGoodness!  
  
  
[MEDIA=youtube]OJgbIXr7P5Q[/MEDIA]