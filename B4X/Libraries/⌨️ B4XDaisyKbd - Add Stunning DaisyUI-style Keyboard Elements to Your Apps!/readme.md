###  ⌨️ B4XDaisyKbd - Add Stunning DaisyUI-style Keyboard Elements to Your Apps! by Mashiane
### 03/04/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170497/)

Hello Fam! 👋  
  
Are you looking to add some modern, clean, and elegant UI elements to your cross-platform applications? I'm excited to share the **B4XDaisyKbd**, a brand-new custom view that brings the sleek aesthetic of the popular DaisyUI <kbd> elements right into the B4X framework.  
  
![](https://www.b4x.com/android/forum/attachments/170405)  
  
Whether you're building a tutorial screen, displaying keyboard shortcuts, or just want a stylized button, this component has you covered!  
  
**🌟 Key Features:**  

- **Fully Customizable Sizes:** Scale your elements effortlessly using simple token sizes: xs, sm, md, lg, and xl.
- **Flexible Styling:** Take full control over BackgroundColor, TextColor, Padding, and Margin.
- **Tailwind-style Borders:** Easily adjust the border radius with tokens like rounded-none, rounded-full, rounded-md, or stick to the default theme style.
- **Click Events:** Built-in click event handling allows these visually appealing elements to act as interactive buttons.
- **Seamless Integration:** Fully compatible with B4XView and easily added programmatically or via the Visual Designer.

**🚀 Simple Usage Example:** You can easily add the B4XDaisyKbd via the visual designer, or you can create it dynamically in code. Here is how to create a simple "Ctrl" key element programmatically:  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
End Sub  
  
Private Sub B4XPage_Created(Root1 As B4XView)  
    Root = Root1  
    Root.Color = xui.Color_RGB(245, 247, 250) ' Light background to make the Kbd pop  
      
    ' 1. Initialize the component and set the event name  
    Dim myKey As B4XDaisyKbd  
    myKey.Initialize(Me, "myKey")  
      
    ' 2. Add it to your parent view (Left, Top, Width, Height)  
    ' Note: If Width/Height are 0, it auto-resolves to its minimum size based on the Size property  
    myKey.AddToParent(Root, 20dip, 50dip, 48dip, 28dip)  
      
    ' 3. Customize its properties!  
    myKey.Text = "ctrl"  
    myKey.Size = "md"  
    myKey.Tag = "ctrl_button"  
End Sub  
  
' 4. Handle the click event!  
Private Sub myKey_Click(Tag As Object)  
    Log("Keyboard Element Clicked! Tag: " & Tag)  
End Sub
```

  
  
From single characters to complex "Ctrl + Shift + Del" combinations, the possibilities are endless!  
Let me know what you think below, and feel free to share screenshots of how you implement it in your projects! Happy coding! 🚀  
  
  
[MEDIA=youtube]iaXkRJQYwHw[/MEDIA]  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>