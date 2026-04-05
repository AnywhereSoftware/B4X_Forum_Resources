###  B4XDaisyBreadcrumbs - Elegant, Scalable, and Icon-Ready Navigation by Mashiane
### 04/01/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170732/)

Hi B4Xers!  
  
I’m excited to share **B4XDaisyBreadcrumbs**, a new cross-platform component designed to bring the modern, clean aesthetic of DaisyUI's breadcrumb system to the B4X ecosystem. Whether you're building a complex file explorer or a multi-step wizard, this component provides a responsive way for users to track their location with ease. The breadcrumb rests inside a horizontal scrollview so that if items are longer one can scroll them.  
  
![](https://www.b4x.com/android/forum/attachments/170986) ![](https://www.b4x.com/android/forum/attachments/170987)  
  
**Key Features:**  

- **Text Size Variants:** Choose from text-sm, text-base, text-lg, and text-xl tokens. The component automatically scales labels, SVG icons, and separators to maintain perfect proportions .
- **SVG Icon Support:** Each breadcrumb can include a Daisy-style icon for enhanced visual cues while maintaining perfect horizontal flow .
- **Smart Scrolling:** No more layout breaks! If your breadcrumb path exceeds the container width, the component enables smooth horizontal scrolling automatically .
- **Theme Awareness:** Fully compatible with theme-aware color tokens and can be refreshed on the fly to match your app’s look .
- **Interactive Design:** Earlier crumbs are clickable for easy backtracking, while the final crumb remains passive to indicate the current location .

**Simple Usage Code Snippet:**  
  

```B4X
' Example: Initializing and adding items programmatically  
Sub CreateBreadcrumbs  
    ' Initialize the component  
    Dim bc As B4XDaisyBreadcrumbs  
    bc.Initialize(Me, "crumbs")  
      
    ' Add to parent (works in Designer too!)  
    bc.AddToParent(Root, 10dip, 10dip, Root.Width - 20dip, 50dip)  
      
    ' Add items: (Id, Text, IconPath, Clickable)  
    ' Earlier crumbs are typically clickable; the last one is not.  
    bc.AddItem("home", "Home", "home-icon.svg", True)  
    bc.AddItem("docs", "Documents", "folder-icon.svg", True)  
    bc.AddItem("current", "Add Document", "", False)   
      
    ' Customize text size (sm, base, lg, xl)  
    bc.TextSize = "text-sm"  
    bc.Refresh  
End Sub  
  
' Handle item clicks  
Sub crumbs_ItemClick (ItemId As String)  
    Log("Breadcrumb clicked: " & ItemId)  
    ' Navigation logic here…  
End Sub
```

  
  
Check out the demo to see it in action across all platforms!   
  
[MEDIA=youtube]mLMDzlFDkrE[/MEDIA]  
  
  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>