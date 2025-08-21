### ShapePoints by OGmac
### 08/01/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/120778/)

This library uses [**OpenCV 3.x**](https://www.b4x.com/android/forum/threads/opencv-3-x.79816/#content) library to identify the shapes in the photo and provide you with the coordinates of the points of each shape.  
  
Thanks to *JordiCP*  
  
**ShapePoints  
  
Author**: OgMac  
**Version**: 1.00  
  
 **ShapePoints**  
  

- **Functions**:

- **Initialize**(PicPath As String, OpenCVPath As String, threshold As Int)

- *Initialize the picture and parameter*

- **Find**(Shape As Int) As List

- *return List Points of Shape*

- **Update**(threshold As Int)

- *Update Points In Shape*

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
Sub Process_Globals  
    Private xui As XUI  
End Sub  
  
Sub Globals  
    Private SP As ShapePoints  
    Private Iv As B4XView  
    Private Pan As B4XView  
    Private cvs As B4XCanvas  
    Private MContours As Map  
    Private SpContour As Spinner  
    Private SpTh As Spinner  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
    cvs.Initialize(Pan)  
    MContours.Initialize  
    For i = 0 To 255  
        SpTh.Add(i)  
    Next  
    SpTh.SelectedIndex = 120  
    Dim bmp As B4XBitmap = xui.LoadBitmap(File.DirAssets, "delta.png")  
    FillImageToView(bmp, Iv)  
    Scan  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Private Sub Scan  
    SP.Initialize(Iv.GetBitmap,SpTh.SelectedItem)  
    For i = 0 To SP.NumShape -1  
        SpContour.Add(i)  
        SpContour.SelectedIndex = i  
    Next  
End Sub  
  
Sub SpTH_ItemClick (Position As Int, Value As Object)  
    SP.Update(Value)  
    SpContour.Clear  
    For i = 0 To SP.NumShape -1  
        SpContour.Add(i)  
        SpContour.SelectedIndex = i  
    Next  
End Sub  
      
Sub DrawPolygon (cvs1 As B4XCanvas, Points As List, Color As Int, Filled As Boolean, StrokeWidth As Double)  
    If Points.Size < 1 Then Return  
    Dim FirstPoint() As Int = Points.Get(0)  
    Dim p As B4XPath  
    p.Initialize(FirstPoint(0), FirstPoint(1))  
    For i = 1 To Points.Size - 1  
        Dim point() As Int = Points.Get(i)  
        p.LineTo(point(0), point(1))  
    Next  
    cvs1.DrawPath(p, Color, Filled, StrokeWidth)  
End Sub  
  
Sub BtnDraw_Click  
    Dim n As Int = SpContour.SelectedIndex  
    If n > SP.NumShape Then Return  
    Dim SPnts As List = SP.Find(n)  
    DrawPolygon(cvs,SPnts,xui.Color_Red, False, 1dip)  
    cvs.Invalidate  
End Sub  
  
Sub BtnClean_Click  
    Dim n As Int = SpContour.SelectedIndex  
    If n > SP.NumShape Then Return  
    Dim SPnts As List = SP.Find(n)  
    DrawPolygon(cvs,SPnts,xui.Color_Black, False, 2dip)  
    cvs.Invalidate  
End Sub  
  
Sub BtnAuto_Click  
    cvs.ClearRect(cvs.TargetRect)  
    cvs.DrawRect(cvs.TargetRect,xui.Color_Black,True,1)  
    For n = 0 To SP.NumShape-1  
        Dim SPnts As List = SP.Find(n)  
        DrawPolygon(cvs,SPnts,xui.Color_Green, False, 1dip)  
        cvs.Invalidate  
    Next  
End Sub  
  
Sub BtnClear_Click  
    cvs.ClearRect(cvs.TargetRect)  
    cvs.DrawRect(cvs.TargetRect,xui.Color_Black,True,1)  
End Sub  
  
Sub FillImageToView(bmp As B4XBitmap, ImageView As B4XView)  
    Dim bmpRatio As Float = bmp.Width / bmp.Height  
    Dim viewRatio As Float = ImageView.Width / ImageView.Height  
    If viewRatio > bmpRatio Then  
        Dim NewHeight As Int = bmp.Width / viewRatio  
        bmp = bmp.Crop(0, bmp.Height / 2 - NewHeight / 2, bmp.Width, NewHeight)  
    Else if viewRatio < bmpRatio Then  
        Dim NewWidth As Int = bmp.Height * viewRatio  
        bmp = bmp.Crop(bmp.Width / 2 - NewWidth / 2, 0, NewWidth, bmp.Height)  
    End If  
    Dim scale As Float = 1  
    ImageView.SetBitmap(bmp.Resize(ImageView.Width * scale, ImageView.Height * scale, True))  
End Sub
```