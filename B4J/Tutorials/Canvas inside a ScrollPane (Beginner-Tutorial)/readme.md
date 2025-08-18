### Canvas inside a ScrollPane (Beginner-Tutorial) by Midimaster
### 10/23/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/123782/)

As my research in the forum for this combination needed 2 hours, I offer here a tutorial for future newbies not to waste such a long time for a actually easy-to-solve problem.  
  
**[SIZE=3]A window with a Scroll-Pane and inside a graphics that can be scrolled horizontally:[/SIZE]**  
![](https://www.b4x.com/android/forum/attachments/101960)  
  
  
The use of the Scroll-Pane in B4J is a little bit trickys, because you cannot add children in the designer. So you have to create a second layout and then load this at runtime:  
**[SIZE=3]First main layout holds your views and only the ScrollPane without content:[/SIZE]**  
![](https://www.b4x.com/android/forum/attachments/101955)  
Define here the outer dimensions of the graphic. Later you will get Scrollbars to move the inner graphic. We save the Layout as **"Layout1"  
  
[SIZE=3]Second layout contains only a canvas directly (and full) on the main form:[/SIZE]**  
![](https://www.b4x.com/android/forum/attachments/101956)  
Define the anchors to fit the form completely. We save the layout as **"Inner"**  
  
Now the code:  
  
  

```B4X
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Button1 As B4XView  
    Private Scroll As ScrollPane  
    Private Canvas As Canvas  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
    Scroll.LoadLayout("Inner",1000,200)  
    DrawGraph  
End Sub
```

  
This is very normal: **MainForm** load the first layout. Then you can load the inner layout to **Scroll.** Here you now should define the inner size (here: 1000x200pix) of the canvas. As I could read in the forum it should not adjusted a second time. So set the values and do not change them anymore in your code.  
  
Now you can paint on the canvas as you like. Here it is a random graphics:  

```B4X
Sub DrawGraph  
    Dim Random, High, Low As Int  
    Canvas.DrawRect(0,0,1000,200,fx.colors.black,True, 0 )  
    For i=0 To 800 Step 2  
        Random =Rnd(-50,50)  
        If Random<0 Then  
            High=100+Random  
            Low=-Random  
        Else  
            High=100  
            Low=Random  
        End If  
        Canvas.DrawRect(i,High,2,Low,fx.Colors.Yellow ,True,0)  
    Next  
End Sub
```

  
In the description of DrawRect we can read the parameters: X, Y, Width and Height are easy to understand, But the fifth parameter is **Paint As javafx.scene.paint.Paint…**  
![](https://www.b4x.com/android/forum/attachments/101957)  
  
But you simply can define a JFX-Color here:  

```B4X
Canvas.DrawRect(0,0,1000,200,fx.colors.black,True, 0 )
```

  
  
That's all. Now you can call the Sub as often as you want. Press the button to draw a complete different graph. The first Canvas.DrawRect works like an CLS (here in black). Then you can combine as many drawing commands as you like. You do not have to care about resfreshing, etc…  
  
Here is the complete project as ZIP: