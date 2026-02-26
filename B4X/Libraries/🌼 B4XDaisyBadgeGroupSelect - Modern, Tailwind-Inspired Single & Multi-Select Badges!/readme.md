###  🌼 B4XDaisyBadgeGroupSelect - Modern, Tailwind-Inspired Single & Multi-Select Badges! by Mashiane
### 02/24/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170404/)

Hi Fam  
  
I'm excited to share a brand-new, highly customizable UI component to modernize your B4A and B4X projects: the **B4XDaisyBadgeGroupSelect**.  
If you've been looking for a clean, responsive way to let users select tags, categories, priorities, or skills, this component wraps beautiful "badges" inside a customizable fieldset. It draws heavy inspiration from modern CSS frameworks like Tailwind and DaisyUI, bringing token-based sizing and styling directly to the B4X visual designer!  
  
**🌟 Key Features:**  
• **Two Selection Modes:** Easily switch between single (radio-button style) and multi (checkbox style) selection modes.  
• **Tailwind-Like Styling:** Use familiar tokens for your design. Set legend sizes (text-xs to text-xl), badge sizes (xs to xl), and border styles (outlined, ghost, inset).  
• **Responsive Auto-Height:** Badges automatically wrap to the next row when they run out of space, and the parent container dynamically adjusts its height to fit the content perfectly.  
• **Custom Gaps & Corners:** Full control over horizontal Gap and vertical Row Gap, plus extensive border-radius options (from rounded-none up to rounded-full).  
• **Dead-Simple Item Loading:** Populate your badges using Maps, Lists, or a simple string spec format like: "low:Low|normal:Normal|high:High|urgent:Urgent".  
  
![](https://www.b4x.com/android/forum/attachments/170170)  
  

```B4X
' 1. Initialize and add to parent  
multiGroup.Initialize(Me, "multigroup")  
multiGroup.AddToParent(pnlHost, 12dip, currentY, 200dip, 1dip)  
  
' 2. Customize styling  
multiGroup.setLegend("Skills")  
multiGroup.setBadgeSelectionMode("multi")   
multiGroup.setBadgeCheckedColor(xui.Color_RGB(34, 197, 94))   
  
' 3. Add Items  
multiGroup.setItemsSpec("ui:UI|api:API|db:Database|qa:QA")   
  
' 4. Pre-select items  
Dim selected As List  
selected.Initialize  
selected.AddAll(Array As String("ui", "api"))  
multiGroup.setSelectedIds(selected)
```

  
  
  
[MEDIA=youtube]deH53u0rF0w[/MEDIA]  
  
  
**Related Content  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>**