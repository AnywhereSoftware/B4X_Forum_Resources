### JColorChooser : change your colors the Photoshop way by jkhazraji
### 07/31/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/160965/)

One of the virtues of b4j is the ability to communicate with some UI Java libraries without external files. So is the case with javax Swing.  
From which JColorChooser comes into play. *JColorChooser provides a pane of controls designed to allow a user to manipulate and select a color*.  
The dialog has 5 tabs or panes that operate, in choosing the right color, the Photoshop way. They are : Swatches, RGB, HSL,HSV, and CMYV .  
Although it is esthetically not that much attractive, but it is rich with colorful dynamic elements:  
![](https://www.b4x.com/android/forum/attachments/153453)![](https://www.b4x.com/android/forum/attachments/153454)![](https://www.b4x.com/android/forum/attachments/153455)![](https://www.b4x.com/android/forum/attachments/153456)  
![](https://www.b4x.com/android/forum/attachments/153457)  
I think selecting the precise color has not been more practical than this method.  
The dialog also provides an indirect way to convert between the different methods of [color spaces](https://en.wikipedia.org/wiki/Color_space) and show the contrast between the text color and background color(Preview)  
However, the dialog, as the user presses 'OK', returns the color chosen in the RGB values: either as a whole '**Int***'* (**RGB**) or individual components ( **ARGB**).  
*Selecting 'Cancel' may end the app unexpectedly as the error is not caught yet (Try..Catch..End Try).  
Selecting 'Reset' will reset the chosen color to the default value: "RED" in this case. You can change it from the 'showDialog' method third parameter (initialColor).  
Drawing a canvas text ('Welcome') is added to show the contrast between the fore and back color. You can modify it to feel it better.  
Enjoy*.;)  
Well, you can consider it as a tutorial named: '*B4J and javax swing*'.  
If it would solve a problem to any please be generous with a point (+1) or have the kind gesture of donating.  
The code is as follows, it is completely commented for clarification and benefit.  

```B4X
#Region Project Attributes  
  #MainFormWidth: 600  
  #MainFormHeight: 600  
#End Region  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Button1 As B4XView  
    Private jframe As JavaObject  
    Private jcolorchooser As JavaObject  
    Private cvs As B4XCanvas  
    Private fnt As Font  
    Private Button2 As Button  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
    Button1.Text="Choose color"  
    cvs.Initialize(MainForm.RootPane)  
    Dim fnt As Font = fx.CreateFont("Verdana", 40, True, False)  
    Dim ta As JavaObject  
    'I could not figure out how to set the textAlignment field so I used a JavaObject!  
    ta.InitializeStatic("javafx.scene.text.TextAlignment")  
    Dim x As Double=300  
    Dim y As Double=200  
    cvs.DrawText("Welcome",x,y,fnt,xui.Color_Blue, ta.GetField("CENTER")) ' fx.DefaultFont(48.0)  
End Sub  
  
Sub Button1_Click  
    'Initialize a JFrame to host the dialog  
    jframe.InitializeNewInstance("javax.swing.JFrame",Array(""))  
    'Initialize the JColorChooser dialog  
    jcolorchooser.InitializeNewInstance("javax.swing.JColorChooser",Null)  
    'Initialize the third parameter of the show dialog method  
    Dim jcolor As JavaObject  
    jcolor.InitializeStatic("java.awt.Color")  
    'Call the `showDialog` method to pop up the dialog.  
    'The first parameter is the owner of the dialog which will be a JFrame that is set to invisible (default) in order not to obscure the main form.  
    'The second parameter is the title which is "Select a color".  
    'The third parameter is the initial color, chosen by the user, which is "RED" in this case. You can choose any.  
    jcolor=jcolorchooser.RunMethod("showDialog",Array(jframe,"Select a color",jcolor.GetField("RED")))  
    'You have to close (dispose) the JFrame (invisible) window otherwise the process will not end.  
    'see Kill Process button and you have to end the app manually in debug mode.  
    jframe.RunMethod("dispose",Null)  
    'Return the java.awt.Color value for the chosen color  
    Log(jcolor)  
    'Get the individual values (RGB) of the color  
    Dim alpha As Int =jcolor.RunMethod("getAlpha",Null).As(Int)  
    Dim redcolor As Int=jcolor.RunMethod("getRed",Null).As(Int)  
    Dim greencolor As Int=jcolor.RunMethod("getGreen",Null).As(Int)  
    Dim bluecolor As Int =jcolor.RunMethod("getBlue",Null).As(Int)  
    Log($"${alpha}, ${redcolor}, ${greencolor}, ${bluecolor}"$)  
    'Apply to the Form Back Color  
    MainForm.BackColor =fx.Colors.ARGB(alpha,redcolor,greencolor,bluecolor)  
    'Get the whole Int value of the chosen color  
    Dim wholecolor As Int= jcolor.RunMethod("getRGB",Null)  
    Log(wholecolor)  
    'Apply the whole values to the RootPane style.  
      MainForm.RootPane.Style = "-fx-background-color: " & wholecolor  
  
   
End Sub
```