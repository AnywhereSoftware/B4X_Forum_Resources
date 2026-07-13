###  🖋️ B4XDaisySignaturePad: A Signature & Drawing View! by Mashiane
### 07/07/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171486/)

Hello Fam! 👋  
  
Are you building an application that requires users to sign documents, or perhaps you just want to add a smooth drawing canvas to your app? I'm excited to introduce the **B4XDaisySignaturePad**!  
  
Inspired by standard signature pads but built strictly adhering to B4XDaisyUIKit Component Development Standards, this cross-platform component delivers incredibly fluid, natural-feeling pen strokes using sub-divided quadratic Bezier curves. It automatically configures the internal Android Paint object to use anti-aliasing, dithering, and ROUND cap/joins—meaning absolutely no jagged "paper-cut" edges on your strokes.  
  
![](https://www.b4x.com/android/forum/attachments/172291) ![](https://www.b4x.com/android/forum/attachments/172292)  
  
**✨ Key Features:**  

- **Ultra-Smooth Drawing:** Uses Bezier curves to interpolate between touch points seamlessly.
- **Fully Customizable:** Change PenColor, BackgroundColor, MinWidth, and MaxWidth dynamically or via the visual designer.
- **Scroll-Friendly:** Built-in DisallowParentIntercept property prevents parent scroll containers (like CustomListViews or ScrollViews) from stealing touch gestures on Android.
- **Easy Exporting & Importing:** Export directly to a B4XBitmap, convert it to a raw BMP/PNG, or export/load raw Base64 strings directly!.

🚀 Quick Start / Usage Example  
  
Here is a beginner-friendly example of how to implement the signature pad in your B4XMainPage. The component is highly customizable, but it works perfectly right out of the box!  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
      
    ' 1. Declare the component (Assuming you added it via the Visual Designer)  
    Private spDemo As B4XDaisySignaturePad   
End Sub  
  
Public Sub Initialize As Object  
    Return Me  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage") ' Load your layout containing the custom view  
      
    ' 2. Customize properties programmatically   
    spDemo.PenColor = xui.Color_Blue ' Set the drawing ink color [11, 12]  
    spDemo.setMinWidth(1.5)          ' Set the minimum line width [5]  
    spDemo.setMaxWidth(4.0)          ' Set the maximum line width [5]  
      
    ' Useful if the pad is inside a ScrollView so it doesn't drag the screen!  
    spDemo.DisallowParentIntercept = True [12]  
End Sub  
  
' 3. Trap component events  
Private Sub spDemo_BeginStroke  
    Log("The user has started signing…")  
End Sub  
  
Private Sub spDemo_EndStroke  
    Log("The user finished a stroke.")  
End Sub  
  
Private Sub spDemo_Changed  
    Log("The signature pad content has changed.")  
End Sub  
  
' 4. Interact with the pad (Exporting and Clearing)  
Private Sub btnSave_Click  
    ' Check if the pad is empty before saving  
    If spDemo.IsEmpty Then [13]  
        Log("Signature pad is empty! Please sign first.")  
        Return  
    End If  
      
    ' Export as a Base64 string for easy database storage!  
    Dim mySignatureData As String = spDemo.GetBase64 [9]  
    Log("Successfully exported Signature to Base64!")  
End Sub  
  
Private Sub btnClear_Click  
    ' Clear the canvas for a retry  
    spDemo.Clear [4, 14]  
    Log("Canvas cleared.")  
End Sub
```

  
  
[MEDIA=youtube]3-6UQVzaje4[/MEDIA]