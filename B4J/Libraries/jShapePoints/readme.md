### jShapePoints by OGmac
### 07/15/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/120205/)

This library uses Java OpenCV to identify the contours in the photo and provide you with the coordinates of the points of each contour.  
  
Required opencv\_java 345.dll [ِDownload lib](https://www.dropbox.com/s/1ohd3pd1iwtd4sv/lib.rar?dl=0)  
Copy lib Folder in DirApp  
  
**jShapePoints  
  
Author**: OgMac  
**Version**: 1.00  
  
 **ShapePoints**  
  

- **Functions**:

- **Initialize**(PicPath As String, OpenCVPath As String, threshold As Int)

- *Initializes the path of the image file and OpenCV*

- **Find**(Shape As Int) As List

- *return List Points of Shape*

- **Update**(threshold As Int)

- *update*

- **Hierarchy** (Shape As Int) As List

- *Each contour shows information about what the hierarchy of the list represents as an array of four values (next, previous, first child, parents).*

- **CNext**(Contouer As Int) As Int

- *Next denotes next contour at the same hierarchical level*

- **CPrev**(Contouer As Int) As Int

- *Previous denotes previous contour at the same hierarchical level*

- **CFirst\_Child**(Contouer As Int) As Int

- *First\_Child denotes its first child contour*

- **CParent**(Contouer As Int) As Int

- *Parent denotes index of its parent contour.*

- **TotalPoints**() As Int

- *Return Total Point In Picture*

- **NumShape**() As Int

- *Return Number Shapes In Picture*

- **NumPoint**(Shape As Int) As Int

- *Return Number Points In Shape*

  
  
Sample Code:  

```B4X
#Region  Project Attributes  
    #MainFormWidth: 800  
    #MainFormHeight: 550  
#End Region  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private OpenCVlibPath As String  
    Private SP As ShapePoints  
    Private cvs As B4XCanvas  
    Private Pane As Pane  
    Private MContours As Map  
    Private SpContour As Spinner  
    Private Spthreshold As Spinner  
    Private TfBrowse As TextField  
    Private FileChosen As String  
    Private Iv As ImageView  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.SetFormStyle("UNIFIED")  
    MainForm.RootPane.LoadLayout("Main") 'Load the layout file.  
    MainForm.Title = "OpenCV Shape Point"  
    MainForm.Show  
    cvs.Initialize(Pane)  
    MContours.Initialize  
    OpenCVlibPath = File.DirApp&"\lib"  
    If Not(File.IsDirectory(File.DirApp,"tmp")) Then  
        File.MakeDir(File.DirApp,"tmp")  
    End If  
End Sub  
  
Sub BtnAdd_Click  
    Dim FC As FileChooser  
    FC.Initialize  
    FC.SetExtensionFilter("Image File", Array As String("*.png", "*.jpg", "*.bmp", "*.gif"))  
    FileChosen = FC.ShowOpen(MainForm)  
    FC.Title = "Select an image file"  
    If FileChosen.IndexOf(".") > -1 Then  
        TfBrowse.Text = FileChosen  
        Dim bmp As B4XBitmap = xui.LoadBitmap(FC.InitialDirectory, File.GetName(FileChosen))  
        Iv.SetImage(bmp)  
        TakeSnap(Iv)  
    End If  
End Sub  
  
Private Sub TakeSnap(View As B4XView)  
    Dim snap As Image  
    snap = View.Snapshot  
    Dim Out As OutputStream = File.OpenOutput(File.DirApp, "\tmp\last.png",False)  
    snap.WriteToStream(Out)  
    Out.Close  
    Scan  
End Sub  
  
Private Sub Scan  
    Dim Snap As String = File.DirApp&"\tmp\last.png"  
    Dim th As Int = Spthreshold.Value  
    SP.Initialize(Snap,OpenCVlibPath,th)  
    SpContour.SetNumericItems(0,SP.NumShape-1,1,SP.NumShape-1)  
End Sub  
  
Sub DrawPolygon (cvs1 As B4XCanvas, SPnts As List, Color As Int, Filled As Boolean, StrokeWidth As Double)  
    If SPnts.Size < 1 Then Return  
    Dim jcvs As JavaObject = cvs1  
    jcvs = jcvs.GetFieldJO("cvs").RunMethodJO("getObject", Null).RunMethod("getGraphicsContext2D", Null)  
    jcvs.RunMethod("save", Null)  
    Dim xSPnts(SPnts.Size), ySPnts(SPnts.Size) As Double  
    For i = 0 To SPnts.Size - 1  
        Dim SPnt() As Int = SPnts.Get(i)  
        xSPnts(i) = SPnt(0)  
        ySPnts(i) = SPnt(1)  
    Next  
    Dim paint As Object = fx.Colors.From32Bit(Color)  
    If Filled Then  
        jcvs.RunMethod("setFill", Array(paint))  
        jcvs.RunMethod("fillPolygon", Array(xSPnts, ySPnts, SPnts.Size))  
    Else  
        jcvs.RunMethod("setStroke", Array(paint))  
        jcvs.RunMethod("setLineWidth", Array(StrokeWidth))  
        jcvs.RunMethod("strokePolygon", Array(xSPnts, ySPnts, SPnts.Size))  
    End If  
    jcvs.RunMethod("restore", Null)  
End Sub  
  
Sub BtnDraw_Click  
    Dim n As Int = SpContour.Value  
    If n > SP.NumShape Then Return  
    Dim SPnts As List = SP.Find(n)  
    DrawPolygon(cvs,SPnts,xui.Color_Red, False, 1dip)  
    cvs.Invalidate  
End Sub  
  
Sub BtnClean_Click  
    Dim n As Int = SpContour.Value  
    If n > SP.NumShape Then Return  
    Dim SPnts As List = SP.Find(n)  
    DrawPolygon(cvs,SPnts,xui.Color_Black, False, 2dip)  
    cvs.Invalidate  
End Sub  
  
Sub Spthreshold_ValueChanged (Value As Object)  
    SP.Update(Value)  
    SpContour.SetNumericItems(0,SP.NumShape-1,1,SP.NumShape-1)  
End Sub  
  
Sub BtnAuto_Click  
    cvs.ClearRect(cvs.TargetRect)  
    For n = 0 To SP.NumShape-1  
    Dim SPnts As List = SP.Find(n)  
    DrawPolygon(cvs,SPnts,xui.Color_Green, False, 1dip)  
    cvs.Invalidate  
    Next  
End Sub  
  
Sub BtnClear_Action  
    cvs.ClearRect(cvs.TargetRect)  
End Sub
```

  
  
  
  
![](https://www.b4x.com/android/forum/attachments/97172)