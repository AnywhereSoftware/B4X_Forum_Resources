###  B4XDaisyIndicator - Modern DaisyUI-Inspired Notification Badges & Counters! by Mashiane
### 02/24/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170413/)

Hi Fam  
  
Are you looking to add a touch of modern design to your application's user interface? Today, I'm thrilled to introduce the **B4XDaisyIndicator**—a brand new custom class designed to bring beautiful, Tailwind/DaisyUI-inspired badges, notification dots, and unread counters straight into your B4A and cross-platform projects!  
Whether you need a tiny "online" status dot on an avatar, or a vibrant red "99+" unread message counter pinned to a bell icon, this component handles it all effortlessly.  
  
![](https://www.b4x.com/android/forum/attachments/170219) ![](https://www.b4x.com/android/forum/attachments/170220) ![](https://www.b4x.com/android/forum/attachments/170221)  
  
**🌟 Key Features:**  
• **Smart Placements:** Position your indicator precisely using HorizontalPlacement (start, center, end) and VerticalPlacement (top, middle, bottom).  
• **Custom Offsets:** Need a little nudge? Easily fine-tune positioning using Tailwind size tokens for X and Y offsets.  
• **Rich Variants & Styling:** Choose from 8 built-in semantic color variants including primary, secondary, success, warning, and error. You can even override with custom background and text colors!  
• **Counter Mode:** Set setCounter(True) to automatically format numbers (e.g., dynamically converting values > 99 to "99+") and instantly transform the indicator into a perfect circular badge.  
• **Seamless Target Attachment:** The true magic of B4XDaisyIndicator is its AttachToTarget() method. Simply pass it an existing B4XView (like an image, button, or panel), and the indicator will automatically calculate the bounds and sync itself to the target's corners or edges!  
**👨‍💻 Simple Usage Example:** Here is a quick snippet demonstrating how to add an unread counter to a basic division panel or avatar view:  
  

```B4X
' 1. Initialize your target view (e.g., a simple Box/Panel)  
Dim baseDiv As B4XDaisyDivision  
baseDiv.Initialize(Me, "")  
Dim baseView As B4XView = baseDiv.AddToParent(Root, 50dip, 50dip, 128dip, 128dip)  
baseDiv.setBackgroundColorVariant("bg-base-300")  
  
' 2. Initialize the B4XDaisyIndicator  
Dim countInd As B4XDaisyIndicator  
countInd.Initialize(Me, "indicator")  
countInd.setCounter(True)       ' Enables counter formatting mode  
countInd.setText("5")           ' Set the badge text/value  
countInd.setVariant("error")    ' Red notification styling  
countInd.setSize("sm")  
countInd.setHorizontalPlacement("end") ' Places it on the Right  
countInd.setVerticalPlacement("top")   ' Places it on the Top  
  
' 3. Add to layout and attach it to the target!  
countInd.AddToParent(Root, 50dip, 50dip, 128dip, 128dip)  
countInd.AttachToTarget(baseView)      ' Snaps the indicator directly to the baseView
```

  
  
  
[MEDIA=youtube]4EGUzKcwfiA[/MEDIA]  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>