### OkapiBarcode (ZINT) by Johan Schoeman
### 03/18/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/146910/)

It is based on this [**Github project**](https://github.com/woo-j/OkapiBarcode). Have stripped it bare and compiled the code to a new Jar (OkapiJHS.jar) so that it will only handle DataMatrix barcodes (a pm request that I have done for a member of the forum). The library brings back X and Y positions as well as width and height of the BLACK modules that I then use to draw the modules of the DataMatrix 2D barcode on a B4J canvas.  
  
Attached the B4J sample project (it should also work in B4A - have not tested it for B4A) and the JAR - copy the Jar to your additional library folder.  
  
Sample code:  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
#AdditionalJar: OkapiJHS  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Canvas1 As Canvas  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")                                             'it holds the Canvas that we will draw the DataMatrix on  
    MainForm.Show  
         
    Dim dm As JavaObject  
    dm.InitializeNewInstance("uk.org.okapibarcode.backend.DataMatrix" , Null)            'initialize a new instance of DataMatrix using B4A / B4J JavaObject  
     
    '******************************************************************************************************************************************************  
    'THIS IS THE STRING THAT WILL BE CONVERTED INTO A DATAMATRIX 2D BARCODE  
    dm.RunMethod("setContent", Array("Johan Schoeman" & CRLF & "19 Prospecton Rd" & CRLF & "Prospecton" & CRLF & "Durban" & CRLF & "South Africa" & CRLF & "Cell: 082 783 6322" & CRLF & "email: johan@barrierfilm.co.za" & CRLF & "The World" & CRLF & "The Universe" & CRLF & "The Milky Way"))  
    '*********************************************************************************************************************************************************  
     
    Dim rec As List = dm.RunMethod("getRectangles", Null)                                 'get the List of rectangles that need to be drawn of the Canvas  
    For i = 0 To rec.Size - 1  
        Log(rec.Get(i))                                                                   'Log the entries in the list  
    Next  
     
    Dim maxsize As Int  = 2500                                                            'this will allow 2500 entries in the list that will hold X, Y, WIDTH, HEIGHT values  
    Dim coordx(maxsize) As Int  
    Dim coordy(maxsize) As Int  
    Dim wdth(maxsize) As Int  
    Dim hght(maxsize) As Int  
     
    For i = 0 To maxsize - 1  
        coordx(i) = -1  
        coordy(i) = -1  
        wdth(i) = -1  
        hght(i) = -1  
    Next  
     
    For i = 0 To rec.Size - 1  
        Dim str As String = rec.Get(i)  
        str = str.Replace("Rectangle[", "")  
        str = str.Replace("]", "")  
        Dim components(4) As String = Regex.Split("," , str)  
        components(0) = components(0).Replace("x=", "")  
        components(1) = components(1).Replace("y=", "")  
        components(2) = components(2).Replace("width=", "")  
        components(3) = components(3).Replace("height=", "")  
        Dim xpos, ypos, modw, modh As Int  
        xpos = components(0).As(Int)  
        ypos = components(1).As(Int)  
        modw = components(2).As(Int)  
        modh = components(3).As(Int)  
         
        coordx(i) = xpos  
        coordy(i) = ypos  
        wdth(i) = modw  
        hght(i) = modh    
    Next  
     
    Dim barwidth As Double = 10dip  
    Dim lft As Double = 50dip  
    Dim tp As Double = 50dip  
     
    For i = 0 To maxsize - 1  
        If coordx(i) <> -1 Then  
            lft = lft + coordx(i) * barwidth  
            tp = tp + coordy(i) * barwidth  
            Canvas1.DrawRect(lft, tp, barwidth * wdth(i), barwidth * hght(i), fx.Colors.Black, True, 0)  
            lft = 50dip  
            tp = 50dip  
        End If  
    Next  
     
     
End Sub
```

  
  
  
  
![](https://www.b4x.com/android/forum/attachments/140377)