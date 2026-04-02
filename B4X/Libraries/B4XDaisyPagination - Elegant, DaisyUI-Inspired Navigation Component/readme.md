###  B4XDaisyPagination - Elegant, DaisyUI-Inspired Navigation Component by Mashiane
### 03/31/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170724/)

Hi Fam!  
  
I'm excited to share **B4XDaisyPagination**, a highly customizable pagination component based on the popular **DaisyUI** design system. If you want to give your B4X applications a modern, professional look for page navigation, this is for you!  
  
![](https://www.b4x.com/android/forum/attachments/170972) ![](https://www.b4x.com/android/forum/attachments/170973)  
  
**Key Features:**  

- **Fully Responsive:** Choose from 5 sizes ranging from **extra-small (xs)** to **extra-large (xl)**.
- **Flexible Styling:** Support for multiple variants like **solid, outline, ghost, soft, and dash**.
- **Advanced Navigation:** Optional **First/Last** and **Prev/Next** buttons with customizable text or **SVG icons**.
- **Visual Polish:** Built-in **shadow variants** (sm to xl) and the ability to toggle between **square and circular** button shapes.
- **Easy Integration:** Simple event handling via the PageChanged event to track user interaction.

**Simple Usage Example:  
  

```B4X
' 1. Initialize the component (usually in B4XPage_Created)  
Pagination1.Initialize(Me, "Pagination1") ' [11]  
  
' 2. Handle the PageChanged event  
Sub Pagination1_PageChanged (PageIndex As Int, ItemId As String) ' [1]  
    ' PageIndex is 0-based; ItemId helps identify if a nav button was clicked  
    Log("Navigated to Page: " & (PageIndex + 1) & " (ID: " & ItemId & ")") ' [9, 10]  
End Sub  
  
' 3. Programmatic control (Optional)  
Pagination1.GoToPage(2) ' Jump directly to the third page [12]  
Pagination1.NextPage    ' Move to the next page [6]
```

  
  
Check out the screenshots below to see the different sizes and interactive features in action!  
  
[MEDIA=youtube]zi7DzkSo0wk[/MEDIA]  
  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>**