###  B4XDaisyPicker - Stunning Ionic v8 Inspired Pickers (Date, Time & Custom Multi-Column!) by Mashiane
### 07/05/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171468/)

Hello Fam!  
  
Are you looking to modernize your application's user interface with sleek, highly customizable item pickers? I'd like to introduce the **B4XDaisyPicker**!  
This component offers **100% parity with the Ionic v8 ion-picker** and uses an inline compositional architecture that makes it incredibly flexible. Whether you need a simple item selector, a multi-column picker, or an automatic Date/Time wheel, this component handles it seamlessly.  
  
![](https://www.b4x.com/android/forum/attachments/172196) ![](https://www.b4x.com/android/forum/attachments/172197) ![](https://www.b4x.com/android/forum/attachments/172198) ![](https://www.b4x.com/android/forum/attachments/172199) ![](https://www.b4x.com/android/forum/attachments/172200) ![](https://www.b4x.com/android/forum/attachments/172201) ![](https://www.b4x.com/android/forum/attachments/172203)  
  
**Key Features:**  

- **Ionic v8 Parity:** Emulates the highly sought-after ion-picker feel.
- **Auto Date/Time Wheels:** No need to build complex date logic! Simply set the PickerType to "auto" and use flatpickr-style InputFormat tokens (e.g., Y-m-d H:i for Date-Time) and the component automatically generates the correct wheels.
- **DaisyUI Theming:** Easily theme the picker using DaisyUI variants like primary, secondary, success, or error to colorize text, highlight bands, and selections.
- **Highly Customizable:** Easily adjust corner rounding (e.g., rounded-lg), add shadow elevations, change column alignments, and configure the number of visible rows.
- **Flexible Presentation:** Use it directly inline on your page or pop it up inside a modal.

**Beginner-Friendly Usage Example:** Adding this component to your app is very straightforward. Here is a simple code snippet demonstrating how to initialize the component programmatically, set up custom styling, add columns with options, and trap the change event.  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private myPicker As B4XDaisyPicker  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
      
    ' 1. Initialize the component and set the callback and event name  
    myPicker.Initialize(Me, "myPicker") [11]  
  
    ' 2. Customize the appearance (Optional)  
    myPicker.setHighlightVariant("primary") ' Highlights the selected row using the primary DaisyUI variant [2]  
    myPicker.setRounded("rounded-lg") ' Applies beautiful rounded corners [8]  
      
    ' 3. Add the picker to your layout  
    ' AddToParent(Parent, Left, Top, Width, Height)  
    myPicker.AddToParent(Root, 20dip, 50dip, 300dip, 200dip) [11]  
  
    ' 4. Create a custom column and populate it with options  
    ' AddColumn(ColumnName, Prefix, Suffix, Disabled)  
    myPicker.AddColumn("animals", "", "", False) [12]  
      
    ' AddOption(ColumnName, Text, Value, Disabled, ColorVariant)  
    myPicker.AddOption("animals", "Dog", "dog", False, "primary") [12]  
    myPicker.AddOption("animals", "Cat", "cat", False, "primary")  
    myPicker.AddOption("animals", "Bird", "bird", False, "primary")  
      
    ' Note: To generate a Date/Time picker instead, just skip manually adding columns  
    ' and configure the picker type:  
    ' myPicker.setPickerType("auto")  
    ' myPicker.setInputFormat("Y-m-d")  
End Sub  
  
' 5. Trap the event whenever the user selects a new item  
Private Sub myPicker_ColumnChanged(ColumnName As String, Value As Object) [1]  
    Log("Column: " & ColumnName & " was changed to: " & Value) [13]  
    ' Example output: Column: animals was changed to: cat  
End Sub
```

  
  
Jump in and try it out to instantly elevate your app's UX! Let me know if you have any questions or feedback below.  
  
[MEDIA=youtube]vmxJ2ObgaZY[/MEDIA]