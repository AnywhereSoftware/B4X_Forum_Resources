###  B4XYogaLayout - The Power of CSS Flexbox in B4X by Mashiane
### 03/11/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170563/)

Hi Fam  
  
[Download](https://github.com/Mashiane/B4XYogaLayout)  
  
It is with pleasure to give you B4XYogaLayout b4xlib.  
  
*Yoga is an embeddable layout system used in popular UI frameworks like React Native. Yoga itself is not a UI framework, and does not do any drawing itself. Yoga's only responsibility is determining the size and position of boxes.*  
  
Yoga brings the power of CSS Flexbox to multiple platforms, natively calculating layout coordinates so you don't have to manually calculate X and Y positions. Because it is highly portable, it can theoretically be wrapped for use within our beloved B4X ecosystem (B4A, B4i, and B4J) to create responsive, web-standard UIs seamlessly.  
Imagine defining a flexible, responsive UI once and letting Yoga do the heavy lifting to figure out exactly where each view should sit on any screen size.  
  
*![](https://www.b4x.com/android/forum/attachments/170543)  
  
Here is the code that produces this layout. We are using panels to demonstrate, however you can use any b4xview.  
  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView 'ignore  
    Private xui As XUI 'ignore  
    Private fc As YogaContainer  
    Private Styles As Map  
End Sub  
Public Sub Initialize As Object  
    Return Me  
End Sub  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    CreateStyles  
    fc.Initialize(Root, Me, False)  
    fc.SetStyle(Styles.Get("screen"))  
    BuildUI  
    fc.CalculateAndApply  
End Sub  
Private Sub CreateStyles  
    Styles = YogaStyle.StyleSheet(Array( _  
        "screen", CreateMap( _  
            "flexDirection": "column", _  
            "justifyContent": "center", _  
            "alignItems": "center", _  
            "backgroundColor": "#f8fafc", _  
            "flex": 1), _  
        _  
        "shell", CreateMap( _  
            "width": 250, _  
            "height": 475, _  
            "padding": 10, _  
            "backgroundColor": "#e2e8f0", _  
            "borderRadius": 18), _  
        _  
        "content", CreateMap( _  
            "flex": 1, _  
            "rowGap": 10), _  
        _  
        "headerBlock", CreateMap( _  
            "height": 60, _  
            "backgroundColor": "#0f172a", _  
            "borderRadius": 12), _  
        _  
        "bodyBlockOne", CreateMap( _  
            "flex": 1, _  
            "marginInline": 10, _  
            "backgroundColor": "#38bdf8", _  
            "borderRadius": 14), _  
        _  
        "bodyBlockTwo", CreateMap( _  
            "flex": 2, _  
            "marginInline": 10, _  
            "backgroundColor": "#818cf8", _  
            "borderRadius": 14), _  
        _  
        "bottomBar", CreateMap( _  
            "position": "absolute", _  
            "width": "100%", _  
            "bottom": 0, _  
            "height": 64, _  
            "flexDirection": "row", _  
            "alignItems": "center", _  
            "justifyContent": "space-around", _  
            "backgroundColor": "#ffffff", _  
            "borderRadius": 16), _  
        _  
        "navOne", CreateMap( _  
            "width": 40, _  
            "height": 40, _  
            "backgroundColor": "#ef4444", _  
            "borderRadius": 12), _  
        _  
        "navTwo", CreateMap( _  
            "width": 40, _  
            "height": 40, _  
            "backgroundColor": "#f59e0b", _  
            "borderRadius": 12), _  
        _  
        "navThree", CreateMap( _  
            "width": 40, _  
            "height": 40, _  
            "backgroundColor": "#22c55e", _  
            "borderRadius": 12), _  
        _  
        "navFour", CreateMap( _  
            "width": 40, _  
            "height": 40, _  
            "backgroundColor": "#3b82f6", _  
            "borderRadius": 12) _  
    ))  
End Sub  
Private Sub BuildUI  
    Dim shell As YogaView = fc.CreatePanel("shell", Styles.Get("shell"))  
    Dim content As YogaView = fc.CreatePanel("content", Styles.Get("content"))  
    Dim headerBlock As YogaView = fc.CreatePanel("headerBlock", Styles.Get("headerBlock"))  
    Dim bodyBlockOne As YogaView = fc.CreatePanel("bodyBlockOne", Styles.Get("bodyBlockOne"))  
    Dim bodyBlockTwo As YogaView = fc.CreatePanel("bodyBlockTwo", Styles.Get("bodyBlockTwo"))  
    Dim bottomBar As YogaView = fc.CreatePanel("bottomBar", Styles.Get("bottomBar"))  
    Dim navOne As YogaView = fc.CreatePanel("navOne", Styles.Get("navOne"))  
    Dim navTwo As YogaView = fc.CreatePanel("navTwo", Styles.Get("navTwo"))  
    Dim navThree As YogaView = fc.CreatePanel("navThree", Styles.Get("navThree"))  
    Dim navFour As YogaView = fc.CreatePanel("navFour", Styles.Get("navFour"))  
      
    fc.Root.AddChild(shell)  
    shell.AddChild(content)  
    content.AddChild(headerBlock)  
    content.AddChild(bodyBlockOne)  
    content.AddChild(bodyBlockTwo)  
    content.AddChild(bottomBar)  
    bottomBar.AddChild(navOne)  
    bottomBar.AddChild(navTwo)  
    bottomBar.AddChild(navThree)  
    bottomBar.AddChild(navFour)  
End Sub  
Private Sub B4XPage_Resize(Width As Int, Height As Int)  
    fc.Resize(Width, Height)  
End Sub
```*  
  
All the demo examples from the Yoga Page have been reproduced in the attached source code.  
  
You can also get more information on how this works from, <https://www.yogalayout.dev/>  
  
  
[MEDIA=youtube]J2UlurOcom4[/MEDIA]  
  
  
  
When you run and install the code, you are provided with a screen to explore each of the outputs of each of the layouts created.  
  
![](https://www.b4x.com/android/forum/attachments/170555)