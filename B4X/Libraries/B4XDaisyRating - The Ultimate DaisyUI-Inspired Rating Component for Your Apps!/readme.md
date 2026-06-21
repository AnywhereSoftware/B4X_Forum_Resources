###  B4XDaisyRating - The Ultimate DaisyUI-Inspired Rating Component for Your Apps! by Mashiane
### 06/17/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171305/)

Hello Fam! 👋  
  
Are you tired of plain, boring rating bars? Want to give your app's UI a massive visual upgrade with just a few clicks? I am thrilled to introduce **B4XDaisyRating**, a beautiful, fully customizable, DaisyUI-inspired rating component that will make your applications look stunning!  
  
Whether you need a classic 5-star review system, a multi-colored heart rating, or half-star precision, **B4XDaisyRating** handles it flawlessly out of the box.  
  
![](https://www.b4x.com/android/forum/attachments/171894) ![](https://www.b4x.com/android/forum/attachments/171895)  
  
**✨ Key Features:**  

- **Fully Customizable Shapes:** Choose from star, star-2, heart, squircle, diamond, and many more mask shapes.
- **Flexible Sizing:** Easily adjust the component size using Tailwind-inspired sizing variants from xs (extra small) all the way to xl (extra large).
- **Half-Star Support:** Enable precise ratings with native half-star parity.
- **Beautiful Color Variants:** Apply built-in color variants like primary, warning, success, error, or assign custom active/inactive colors—including multi-colored items!.
- **Interactive & Read-Only Modes:** Allow users to submit ratings, allow clearing of ratings, or lock the component to simply display existing scores.

**🚀 Quick Start Guide (Beginner Friendly!)**  
  
Using custom views in B4X is incredibly easy. While it is highly recommended to add B4XDaisyRating via the **Visual Designer** (where you can set most properties instantly without code), you can also completely customize it dynamically through your code!  
  
Here is a simple example showing how to reference the component, set up its properties, and trap the rating event to know exactly what your user selected.  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
      
    ' 1. Declare the component (Assuming you added a CustomView to your layout in the Designer)  
    Private myRatingView As B4XDaisyRating  
End Sub  
  
Public Sub Initialize As Object  
    Return Me  
End Sub  
  
Private Sub B4XPage_Created(Root1 As B4XView)  
    Root = Root1  
    ' 2. Load your layout  
    Root.LoadLayout("MainPage")   
      
    ' 3. Customize the component programmatically!  
    myRatingView.setMaxValue(5)        ' Set to 5 total items [9]  
    myRatingView.setHalf(True)         ' Enable half-star increments [4]  
    myRatingView.setValue(3.5)         ' Set the initial default score [9]  
    myRatingView.setSize("lg")         ' Make it large (xs, sm, md, lg, xl) [2]  
    myRatingView.setVariant("warning") ' Give it a beautiful yellow/orange color [2]  
    myRatingView.setIconStyle("star-2")' Choose the icon shape [4]  
End Sub  
  
' 4. Trap the event when the user interacts with the rating component!  
' The event name matches your component's name followed by "_Changed"  
Private Sub myRatingView_Changed(Value As Float)  
    Log("User selected a rating of: " & Value)  
      
    #If B4A  
        ' Show a quick popup to the user on Android [10]  
        ToastMessageShow("Thank you for the " & Value & " star rating!", False)  
    #End If  
End Sub
```

  
  
Drop the library into your project, add the view in the designer, and elevate your app's user experience today. Let me know what you think, and please share screenshots of how you use it in your apps!  
  
  
#SharingTheGoodness  
  
[MEDIA=youtube]dc6vhydmqj0[/MEDIA]