### DotMatrix by Johan Schoeman
### 09/07/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/168557/)

It is based on [**this posting**](https://github.com/HanSolo/dotmatrix). Copy the attached Jar to your B4J library folder.  
Sample project attached  
See how the chars scroll across the DotMatrix - the code (via a timer) will repeat the scroll of the text  
Seems to think that you need to use at least Java 17. I have done this using Java 19.  
  
![](https://www.b4x.com/android/forum/attachments/166614)  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
#AdditionalJar: dotmatrix-17.0.0  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Dim matrix As JavaObject  
    Dim width, height As Double  
    Dim cols, row As Int  
    Dim dm As JavaObject  
    Dim dmb As JavaObject  
    Dim mf As JavaObject  
    Dim x, offset As Int  
    Dim txt As String  
      
    Dim textLengthInPixel As Int  
    Dim textlength As Int  
      
    Dim t As Timer  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
      
    t.Initialize("t", 50)  
      
    txt = "Hello Johan, Belinda, Chris, Stertjie, Peanut, Nunu (Buffel), and Kiki (uiltjie ogies)"  
    textLengthInPixel = txt.Length * 8  
    matrix.InitializeNewInstance("eu.hansolo.fx.dotmatrix.DotMatrix", Null)  
      
    width = 500  
    height = 50  
  
    cols = 128  
    row = 13  
      
    'ROUND, SQUARE, ROUNDED_RECT  
    dm.InitializeStatic("eu.hansolo.fx.dotmatrix.DotMatrix.DotShape")  
      
    dmb.InitializeStatic("eu.hansolo.fx.dotmatrix.DotMatrixBuilder")  
      
    'MatrixFont5x7, MatrixFont8x11, MatrixFont8x8  
    mf.InitializeStatic("eu.hansolo.fx.dotmatrix.MatrixFont8x8")  
      
    matrix = dmb.RunMethodJO("create", Null) _  
                .RunMethodJO("prefSize",  Array(width, height)) _  
                .RunMethodJo("colsAndRows", Array(cols, row)) _  
                .RunMethodJO("activeColor", Array(fx.Colors.RGB(255, 55, 0))) _  
                .RunMethodJO("dotShape", Array(dm.GetField("ROUND"))) _  
                .RunMethodJO("matrixFont", Array(mf.GetField("INSTANCE"))) _  
                .RunMethodJO("useSpacer", Array(False)) _  
                .RunMethod("build", Null)  
                  
    x = matrix.RunMethod("getCols", Null) + 7  
                  
    MainForm.RootPane.AddNode(matrix, 2dip, 2dip, 550dip, 300dip)       
      
      
          
    t.Enabled = True  
  
End Sub  
  
Sub t_tick  
    If x < -1 * textLengthInPixel Then  
        x = matrix.RunMethod("getCols", Null) + 7  
    End If  
    offset = 3             'how far from the top of the matrix do we start  
    textlength = txt.Length  
    textLengthInPixel = textlength * 8  
      
    For i = 0 To txt.Length - 1  
        matrix.RunMethod("setCharAt", Array(txt.CharAt(i), x + i * 8, offset, IIf(i Mod 2 = 0, matrix.runMethod("convertToInt", Array(fx.Colors.Red)), matrix.runMethod("convertToInt", Array(fx.Colors.Blue)))))  
    Next  
    x = x - 1  
  
End Sub
```

  
  
I am leaving any further changes to this sample up to you. Study the attached JAR and classes within by making use of a suitable JAR viewer such as "jd-gui"