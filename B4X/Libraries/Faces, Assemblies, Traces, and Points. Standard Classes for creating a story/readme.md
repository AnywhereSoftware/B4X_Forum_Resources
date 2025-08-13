###  Faces, Assemblies, Traces, and Points. Standard Classes for creating a story. by William Lancee
### 02/05/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/145930/)

Since retiring some time ago, I have been thinking about creating stories that involve  
computer operated robots which carry out actions and speech - like actors in a drama.  
  
It would have at least two mobile robotic platforms that can move on a stage - about the size of a dining table.  
Each platform would have a Android tablet on-board that receives instructions from a desktop or laptop.  
Those instructions would determine movements on the stage.  
Each tablet would also show a human-like face on the screen.  
This face would display emotions and lipsync to sound tracks.  
  
I have been working intermittently on pieces of this project.  
For me, the journey is definitely more fun than getting there.  
  
Here I present some of my experiences. I will concentrate on things one can do with B4X  
on the Desktop and Android tablet. Most of the code should also run on B4i.  
  
First a taste of what we can achieve. A very short video.  
  
<https://youtube.com/shorts/ag_u-x9Lta8?feature=share>  
  
For now, I will discuss the software building blocks of this ambitious project.  
There are other discussions I can have about hardware and inter-device communication.  
I'll leave that for another time.  
  
Let's create a set of structures - each will be implemented as one or more standard classes.  
 Story: a set of ordered scenes  
 Scene: a collection of Faces  
 Face: a collection of Assemblies  
 Assembly: a collection of Traces  
 Trace: a set of ordered Points  
 Point: a pair of ordered Numbers  
  
This tutorial comes in sections A, B, C, D, E, anf F  
  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_Tutorial A.\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  
  
Let's start from the bottom.  
One could define a "Point" as a custom type. I have done that in the past, and that works well.  
But as a class, it can have time-saving methods such as adding points and finding the distance between points.  
  
One note about terminology. It is very cumbersome to always distinguish between the instances of a class and the class itself.  
My convention here is to use lowercase and mostly plural for instances and ProperCase and singular for classes.  
For example points are instances of the class Point.  
  
In B4X, an instance of a class can spawn instances of itself and other classes. This is very useful.  
If we start with a generator instance, we can use it to generate new instances, without cluttering up modules with extra methods.  
  
Copy the following in a new project or download the attached.zip  
  
  

```B4X
'B4XMainPage  
'_____________________________________  
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private CV As B4XCanvas  
    Private Pnt As Point            'generator instance  
End Sub  
  
Public Sub Initialize  
    Pnt.Initialize  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    CV.Initialize(Root)  
   
    Dim center As Point = Pnt.New(Root.Width / 2, Root.Height / 2)  
    Log(center.X & TAB & center.Y)    '300    300  
   
    CV.drawCircle(center.X, center.Y, 50dip, xui.Color_Blue, False, 3)  
  
    Log(2 * center.DistanceTo(Pnt.New(0, 0)))    'length of screen diagonal  
'Or  
    Log(2 * Pnt.New(0, 0).DistanceTo(center))    'length of screeen diagonal  
   
'You could also define center as halfway down the diagonal  
    Dim TopLeft As Point = Pnt.New(0, 0)  
    Dim BottomRight As Point = Pnt.New(Root.Width, Root.Height)  
    center = TopLeft.halfwayTo(BottomRight)  
    Log(center.X & TAB & center.Y)    '300    300  
  
'Or as the centroid  
    center = TopLeft.Add(BottomRight).MultBy(1 / 2)  
    Log(center.X & TAB & center.Y)    '300    300  
End Sub  
  
Point  
___________________________________  
Sub Class_Globals  
    Public X, Y As Float  
End Sub  
  
Public Sub Initialize  
End Sub  
  
'Spawns a new instance of Point  
Public Sub New(X_ As Float, Y_ As Float) As Point  
    Dim P As Point  
    P.Initialize  
    P.X = X_  
    P.Y = Y_  
    Return P  
End Sub  
  
'Copies a Point  
Public Sub Copy As Point  
    Return New(X, Y)  
End Sub  
  
'Subtract second Point from first  
Public Sub Minus(p As Point) As Point  
    Return New(X - p.X, Y - p.Y)  
End Sub  
  
'Multiplies a Point by a constant  
Public Sub MultBy(factor As Float) As Point  
    Return New(factor * X, factor * Y)  
End Sub  
  
'Adds two Points  
Public Sub Add(p As Point) As Point  
    Return New(X + p.X, Y + p.Y)  
End Sub  
  
'Finds distance between two Points  
Public Sub distanceTo(p As Point) As Float  
    Dim dx As Float = p.X - X  
    Dim dy As Float = p.Y - Y  
    Return Sqrt(dx * dx + dy * dy)  
End Sub  
  
'Finds the mid-Point between two Points  
Public Sub halfwayTo(p As Point) As Point  
    Return New((X + p.X) / 2, (Y + p.Y) / 2)  
End Sub  
  
'Returns a point that is partway (fraction) along the line between two points  
Public Sub partwayTo(p As Point, fraction As Float) As Point  
    Return New(X + fraction * (p.X - X), Y + fraction * (p.Y - Y))  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/138909)