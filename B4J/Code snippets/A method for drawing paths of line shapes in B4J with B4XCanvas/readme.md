### A method for drawing paths of line shapes in B4J with B4XCanvas by William Lancee
### 07/26/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/132874/)

This is not a problem you might say. Try it and you'll find that nothing appears to be drawn. If you do the same thing in B4A it works as expected.  
The reason is that the JavaFx designers differentiated between lines and line shapes. The DrawLine method draws lines, the DrawPath method draws closed shapes.  
  
In B4J if you draw a shape, the points in the path describe the outside edge of the shape. So the inside of a closed path of a line is empty, no matter how thick you make the stroke width.  
The solution is to turn the line into a line shape by making it a thin rectangle. That is fairly easy if the line is horizontal or vertical, but if it is on an angle, it requires some trigonometry.  
  
I knew that, but a recent question by [USER=21153]@labcold[/USER] <https://www.b4x.com/android/forum/threads/b4x-canvas-path-differences-between-b4a-and-b4j.132810/>  
made me revisit the issue and wrote a sub ("listToPath") that adjusts the path of a shape if the path describes a line. Because the points in a loaded path are not available, the method works if you generate the points on the path as a List of points (2 element Arrays). The Sub converts the List into an path that makes an adjustment for lines.  
  
Edit: I changed the name of the path in the subroutine, the earlier name was from a previous version which would cause confusion. The change is tested.  
  

```B4X
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Main")  
    MainForm.Show  
    cvs.Initialize(pnlGraph)  
     
    Dim fromCenter As List: fromCenter.Initialize  
    fromCenter.Add(Array(-0.4, 0.0))  
    fromCenter.Add(Array(-0.2, 0.0))  
    fromCenter.Add(Array(0.0, 0.0))  
    fromCenter.Add(Array(0.2, 0.0))  
    fromCenter.Add(Array(0.4, 0.0))  
    drawRotatedShape (fromCenter, 250, 250, 2, 200, 30)  
End Sub  
  
Private Sub drawRotatedShape(FromCenter As List, CenterX As Float, CenterY As Float, Thickness As Float, Radius As Float, Angle As Float)  
    Dim pntList As List: pntList.Initialize  
    For Each pt() As Object In FromCenter  
        pntList.Add(Array(CenterX + pt(0).As(Float) * Radius, CenterY + pt(1).As(Float) * Radius))  
    Next  
    cvs.DrawPathRotated(listToPath(pntList, Thickness), xui.Color_Black, True, Thickness, Angle, CenterX, CenterY)  
End Sub  
  
Private Sub listToPath(pntList As List, thickness As Float) As B4XPath  
    'This method works for all shapes - it determines whether the shape is a line shape and then adjusts the path  
    Dim aPath As B4XPath  
    Dim epsilon As Float = .001  
    Dim firstPt(2), lastPt(2), prevPt(2) As Object  
    Dim isHorizontalLine = True, isVerticalLine = True, isOtherLine = True As Boolean  
    For i = 0 To pntList.Size - 1  
        Dim pt() As Object = pntList.Get(i)  
        Select i  
            Case 0  
                firstPt(0) = pt(0)  
                firstPt(1) = pt(1)  
            Case pntList.Size - 1  
                lastPt(0) = pt(0)  
                lastPt(1) = pt(1)  
        End Select  
        If i = 0 Then  
            aPath.Initialize(pt(0), pt(1))  
        Else  
            aPath.LineTo(pt(0), pt(1))  
            If Abs(prevPt(0) - pt(0)) > epsilon Then isVerticalLine = False  
            If Abs(prevPt(1) - pt(1)) > epsilon Then isHorizontalLine = False  
        End If  
        prevPt(0) = pt(0)  
        prevPt(1) = pt(1)  
    Next  
    If isVerticalLine Then  
        aPath.LineTo(lastPt(0) + thickness, lastPt(1))  
        aPath.LineTo(firstPt(0) + thickness, firstPt(1))  
    Else If isHorizontalLine Then  
        aPath.LineTo(lastPt(0), lastPt(1) + thickness)  
        aPath.LineTo(firstPt(0), firstPt(1) + thickness)  
    Else  
        Dim deltaX As Float = lastPt(0) - firstPt(0)  
        Dim deltaY As Float = lastPt(1) - firstPt(1)  
        If Abs(deltaX) < epsilon Then  
            isOtherLine = False  
        Else If Abs(deltaY) < epsilon Then  
            isOtherLine = False  
        Else  
            Dim overallSlope As Float = deltaY / deltaX  
            Log(overallSlope)  
            prevPt(0) = firstPt(0)  
            prevPt(1) = firstPt(1)  
            For i = 1 To pntList.Size - 1  
                Dim pt() As Object = pntList.Get(i)  
                Dim thisSlope As Float = (pt(1) - prevPt(1)) / (pt(0) - prevPt(0))  
                If Abs(overallSlope - thisSlope) > epsilon Then  
                    isOtherLine = False  
                    Exit  
                End If  
                prevPt(0) = pt(0)  
                prevPt(1) = pt(1)  
            Next  
        End If  
        If isOtherLine Then  
            Dim offsetX, offsetY As Float  
            Dim angle As Float = cPI / 2 + ATan(overallSlope)  
            offsetX = thickness * Cos(angle)  
            offsetY = thickness * Sin(angle)  
            aPath.LineTo(lastPt(0) + offsetX, lastPt(1) + offsetY)  
            aPath.LineTo(firstPt(0) + offsetX, firstPt(1) + offsetY)  
        End If  
    End If  
    Return aPath  
End Sub
```