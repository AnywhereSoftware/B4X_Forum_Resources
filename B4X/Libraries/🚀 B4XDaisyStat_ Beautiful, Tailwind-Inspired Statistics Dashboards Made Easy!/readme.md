###  🚀 B4XDaisyStat: Beautiful, Tailwind-Inspired Statistics Dashboards Made Easy! by Mashiane
### 03/04/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170493/)

Hi Fam!  
  
Are your app dashboards looking a bit plain? We are thrilled to introduce the **B4XDaisyStat** and **B4XDaisyStatItem** components as part of the new Daisy UIKit.  
  
Inspired by Tailwind CSS and DaisyUI, these components allow you to build stunning, content-driven statistics widgets with minimal code. It's built with a smart layout engine that mirrors CSS inline-grid behavior, meaning your stats will naturally fit their content and layout perfectly whether you set the orientation to horizontal or vertical.  
  
One is able to scroll the stat card. See 2nd stat card.  
  
![](https://www.b4x.com/android/forum/attachments/170389)![](https://www.b4x.com/android/forum/attachments/170390)![](https://www.b4x.com/android/forum/attachments/170391)  
  
  
  
![](https://www.b4x.com/android/forum/attachments/170392) ![](https://www.b4x.com/android/forum/attachments/170393)  
  
**🌟 Key Features:**  

- **Dynamic Layout:** Automatically calculates preferred widths and heights based on your labels and font metrics.
- **Rich Properties:** Easily set a Title, Value, and Description for each stat item.
- **Color Variants:** Apply semantic DaisyUI colors (e.g., primary, secondary, accent, info, success, warning, error) to text, backgrounds, and figures.
- **Versatile Figures:** Enhance your stats with visual elements by setting the FigureType to svg, image, or even a dynamic radial progress indicator!
- **Custom Styling:** Control shadows (sm, md, lg, etc.) and exact padding using standard Tailwind utility strings like px-6 py-4.
- **Interactive:** Built-in click events with custom Tag payloads to make your dashboards fully interactive.

**💻 Simple Usage Example:** Here is a quick snippet to get a beautiful stat widget up and running:  
  

```B4X
' 1. Initialize the main Stat container  
Dim MyStats As B4XDaisyStat  
MyStats.Initialize(Me, "MyStats")  
MyStats.setOrientation("horizontal") ' Can be horizontal or vertical  
MyStats.setShadow("md")  
  
' Assume MyStats is added to your layout via Designer or AddToParent…  
  
' 2. Create a Stat Item  
Dim Stat1 As B4XDaisyStatItem  
Stat1.Initialize(Me, "Stat1")  
  
' 3. Configure Properties  
Stat1.setTitle("Total Downloads")  
Stat1.setValue("31K")  
Stat1.setDescription("Jan 1st - Feb 1st")  
  
' 4. Add Colors and Figures  
Stat1.setValueColor("primary")  
Stat1.setFigureType("svg") ' Supports svg, image, or radial  
Stat1.setFigureSource("download_icon.svg")  
  
' 5. Add the item to the container and refresh  
MyStats.AddItem(Stat1)  
MyStats.Refresh ' Always call Refresh after adding items or changing properties
```

  
  
For advanced layouts, you can host your B4XDaisyStat inside a ScrollView to perfectly match the CSS overflow-x-auto behavior—allowing your horizontal stats to scroll elegantly if they exceed the screen width.  
Drop your thoughts, feedback, and screenshots of your new dashboards below! Happy coding!  
  
  
[MEDIA=youtube]Tj2XIHLwOSA[/MEDIA]  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>