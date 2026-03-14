###  B4XDaisyList - Modern, Tailwind & DaisyUI Inspired Lists Made Easy! 🚀 by Mashiane
### 03/10/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170548/)

Hi Fam!  
  
I am excited to share a modern UI component that will instantly elevate the look and feel of your applications: **B4XDaisyList**!  
If you love the clean, modern aesthetic of frameworks like Tailwind CSS and DaisyUI, you will love this. B4XDaisyList is designed to take the heavy lifting out of creating beautiful, highly customized list views across B4A, B4i, and B4J.  
  
![](https://www.b4x.com/android/forum/attachments/170511) ![](https://www.b4x.com/android/forum/attachments/170512)  
  
  
**✨ Key Features Out of the Box:**  

- **Tailwind/DaisyUI Sizing & Coloring:** Use familiar tokens like base-100 for backgrounds, and CSS/Tailwind size tokens (e.g., full, h-auto).
- **Built-in Shadows & Radii:** Easily apply shadow-md, shadow-lg, or toggle the RoundedBox property for that modern card-style look.
- **Smart Dividers:** Automatically add and style divider lines between your rows with customizable divider colors (base-content/5).
- **Flexible Layouts:** Add simple text rows, stacked text, or completely custom layouts with multiple B4XViews (like SVGs, avatars, and icons).
- **Familiar Events:** Built-in support for ItemClick and ItemLongClick with payload tags to keep your logic clean and simple.

**🛠️ Simple Usage Example:** Here is a quick snippet showing how easy it is to initialize a list, configure its modern styling properties, and add a few basic text rows.  
  

```B4X
' 1. Declare the component in your Globals  
Private list1 As B4XDaisyList  
  
' 2. Inside your initialization or creation sub (e.g., B4XPage_Created)  
list1.Initialize(Me, "list1")  
  
' 3. Configure the list using DaisyUI/Tailwind inspired properties  
list1.BackgroundColor = "base-100" ' DaisyUI background token [1]  
list1.Shadow = "shadow-md"         ' Apply a nice drop shadow [1]  
list1.RoundedBox = True            ' Give the list container rounded corners [1]  
list1.Padding = 0                  ' Container padding [1]  
list1.RowPadding = 16dip           ' Gap around row content [1]  
list1.RowGap = 16dip               ' Gap between rows [1]  
list1.Divider = True               ' Show dividers between items [1]  
list1.DividerColor = "base-content/5" ' Divider border color [1]  
list1.setHeight("auto")            ' Auto fit the container height to its rows [2, 9]  
  
' 4. Add some simple text rows  
list1.AddTextRow("Welcome to B4XDaisyList", "This is a subtitle") [3]  
list1.AddTextRow("Modern UI Design", "Tailwind styling made easy") [3]  
  
' 5. Handle the click events!  
Private Sub list1_ItemClick(Index As Int, Tag As Object)  
    Log("List Item Clicked! Index: " & Index) [10]  
End Sub
```

  
  
For more advanced usages—like integrating SVG avatars, custom header views, and interactive icons—be sure to check out the full source code and example pages!  
Let me know what you build with it, and feel free to drop any questions or feature requests below! Happy coding!  
  
  
[MEDIA=youtube]hTUt\_Z3P1Kc[/MEDIA]  
  
**Related Content  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>**