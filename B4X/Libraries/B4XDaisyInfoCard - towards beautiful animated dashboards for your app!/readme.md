###  B4XDaisyInfoCard - towards beautiful animated dashboards for your app! by Mashiane
### 07/13/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171538/)

Hi Fam!  
  
I'm excited to introduce the **B4XDaisyInfoCard**—a highly customizable, feature-packed UI component designed to make displaying metrics absolutely beautiful and incredibly easy.  
Whether you're building a finance app, an admin panel, or a health tracker, B4XDaisyInfoCard takes the heavy lifting out of creating professional-grade UI elements.  
  
![](https://www.b4x.com/android/forum/attachments/172376) ![](https://www.b4x.com/android/forum/attachments/172377)  
  
**✨ Key Features:**  

- **Animated Count-Ups:** Watch your numbers organically roll up from a starting value to a target value (e.g., from 0 to 45,678). You can easily configure decimal places, prefixes (like $), and suffixes (like %).
- **Multiple Layout Styles:** Choose between distinct layout families: "Icon Left" (with colored or subtle columns) or modern "Watermark" layouts featuring large, faint icons in the background.
- **Built-in Theme Variants:** Instantly color your cards using standard UI variants like primary, success, warning, or error.
- **Interactive Effects:** Includes Material-style wave ripples on touch and beautiful hover-zoom press effects to make your app feel alive and responsive.
- **Cross-Platform Ready:** Built as a custom B4XView wrapper, making it adaptable for your B4A and B4X projects!

---

  
👨‍💻 Beginner-Friendly Usage Example  
Here is a quick snippet showing how easy it is to initialize a card, set its properties, and trap the click event.  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
     
    ' Declare our InfoCard component  
    Private myStatsCard As B4XDaisyInfoCard  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
     
    ' 1. Initialize the component with a callback (Me) and an EventName ("StatsCard")  
    myStatsCard.Initialize(Me, "StatsCard") ' [8]  
     
    ' 2. Add it directly to your parent view (Parent, Left, Top, Width, Height)  
    myStatsCard.AddToParent(Root, 20dip, 20dip, 300dip, 100dip) ' [9]  
     
    ' 3. Customize the look and feel!  
    myStatsCard.Title = "Total Revenue" ' [10]  
    myStatsCard.Value = "45678" ' Target value [10]  
    myStatsCard.StartFrom = 0 ' Animation start point [10]  
    myStatsCard.Prefix = "$" ' Add a dollar sign before the number [11]  
     
    ' 4. Configure animation & style  
    myStatsCard.Animated = True ' Enable count-up [12]  
    myStatsCard.Duration = 2 ' 2 seconds animation duration [12]  
    myStatsCard.InforType = "1" ' Layout Type 1: Icon Left colored column [3]  
    myStatsCard.Variant = "success" ' Make it green! [13]  
    myStatsCard.Effect = "hover-zoom" ' Add a neat zoom effect on press [14]  
     
    ' 5. Important: Call Refresh to apply properties and start the animation!  
    myStatsCard.Refresh ' [15]  
End Sub  
  
' 6. Trap the Click Event using the EventName we defined earlier!  
Private Sub StatsCard_Click (Tag As Object) ' [1]  
    ' By default, the Tag holds a reference to the InfoCard instance  
    Dim clickedCard As B4XDaisyInfoCard = Tag ' [16]  
     
    Log("You clicked on: " & clickedCard.Title)  
    Log("The current value is: " & clickedCard.Value)  
     
    ' Bonus trick: Re-run the count-up animation when clicked!  
    clickedCard.StartAnimation ' [16, 17]  
End Sub
```

  
  
  
Stop spending hours manually drawing boxes, placing labels, and writing timer loops for number animations. Drop a B4XDaisyInfoCard into your project and watch your UI transform instantly.  
  
Let me know what you think below, and feel free to share screenshots of how you use it in your apps! Happy coding! 🚀  
  
[MEDIA=youtube]ggyolb\_Mt8w[/MEDIA]