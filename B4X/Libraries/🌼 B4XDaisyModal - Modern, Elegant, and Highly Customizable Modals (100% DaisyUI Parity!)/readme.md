###  🌼 B4XDaisyModal - Modern, Elegant, and Highly Customizable Modals (100% DaisyUI Parity!) by Mashiane
### 03/18/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170624/)

Hi Fam  
  
Are you looking to give your app a fresh, modern facelift with minimal effort? I am thrilled to introduce **B4XDaisyModal**, a highly customizable and elegant modal component designed with **100% parity with DaisyUI documentation examples**!  
  
![](https://www.b4x.com/android/forum/attachments/170706) ![](https://www.b4x.com/android/forum/attachments/170707) ![](https://www.b4x.com/android/forum/attachments/170708) ![](https://www.b4x.com/android/forum/attachments/170709) ![](https://www.b4x.com/android/forum/attachments/170710) ![](https://www.b4x.com/android/forum/attachments/170711)  
  
Built natively as a B4X class (Version 13.4), B4XDaisyModal makes it incredibly easy to display beautiful alerts, side-panel menus, and full-screen dialogs in your B4XPages applications.  
  
**✨ Key Features & Designer Properties:**  

- **Flexible Placement:** Snap your modals to the top, middle, or bottom of the screen.
- **Sidebar Mode:** Need a navigation drawer or a side-panel? Toggle Sidebar to true, choose left or right for SidebarSide, and easily control the animation speed with SidebarDuration.
- **Glassmorphism Effects:** Apply stunning blur and glass styles effortlessly with GlassSize presets ranging from glass-xs to glass-2xl.
- **Complete Styling Control:** Completely customize your BackgroundColor, Rounded corners (e.g., rounded-box, rounded-full), and Padding via simple DaisyUI utility classes.
- **Backdrop & Interactivity:** Built-in support for adjustable BackdropOpacity (0-100) and BackdropColor, plus a handy ClickOutsideToClose feature to improve user experience.

**🛠️ Simple Usage Code Snippet:** Here is a quick example of how to initialize and show a B4XDaisyModal programmatically inside a B4XPage:  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private myModal As B4XDaisyModal  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.Color = xui.Color_White  
    B4XPages.SetTitle(Me, "Modal Demo")  
      
    ' 1. Initialize the modal with a Callback and EventName  
    myModal.Initialize(Me, "myModal")  
      
    ' 2. Add the modal to the Root view  
    myModal.AddToParent(Root, 0, 0, Root.Width, Root.Height)  
      
    ' 3. Configure properties programmatically  
    myModal.setTitle("Hello!")  
    myModal.setPlacement("middle")  
    myModal.setClickOutsideToClose(True)  
    myModal.setShowCloseButton(True)  
      
    ' 4. Show the modal  
    myModal.Show  
End Sub  
  
' Handle the close button event  
Private Sub myModal_CloseClick (Tag As Object)  
    myModal.Close  
End Sub
```

  
  
Whether you want a simple "Hello!" dialog, a bottom sheet, or a full-screen sliding panel, B4XDaisyModal has you covered.  
Enjoy, and let me know your thoughts or feature requests in the thread below! Happy coding!   
  
[MEDIA=youtube]cBwc22toHa0[/MEDIA]  
  
Related Content  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>