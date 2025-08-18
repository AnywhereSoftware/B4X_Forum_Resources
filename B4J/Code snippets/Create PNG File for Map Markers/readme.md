### Create PNG File for Map Markers by Harris
### 01/30/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/127056/)

I needed a method to create .png files "on the fly" - to be used as custom map markers in my AB Material app.  
Normally, this data is exposed when hovering over the current map marker - but I wanted to show this info for every marker shown, as an additional marker along side…  
  
Borrowing from many examples found on this forum, I managed this.  
  
These files are just temporary in the app, and are periodically cleaned out (deleted).  
  
The B4XMainPage Class file…  

```B4X
Sub Class_Globals  
    Private mCanvas As Canvas  
    Private fx As JFX  
    Type TextMetric (Width As Double,Height As Double)  
    
End Sub  
  
Public Sub Initialize  
  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    
    File.MakeDir(File.DirApp,"tmplbl")  
    
    Dim rand As Int = Rnd(1,5000)  
    Dim t As String = " Spd: "&rand&"  Time: "&DateTime.Time(DateTime.Now)&" Truck #: ( "&(rand+376)&" )"  
    Dim ret As String = Makelabel(t,rand)   
    
    Log(" File created: "&ret)  
  
    ExitApplication2(0)  
    
End Sub  
  
  
Sub Makelabel(t As String, rand As Int) As String  
    
    mCanvas.Initialize("")  
    Dim fs As Double = 16  
    
    Dim TM As TextMetric = MeasureText(t,fx.DefaultFont( fs))  
  
    Log(" Height: "&TM.Height & "   Width: " & TM.Width)  
  
    Dim width, height As Double  
    width = TM.Width + 6  
    height = TM.Height + 1  
    
    mCanvas.SetSize(width,height)  
    mCanvas.DrawRect( 0  , 0,  width, height,  fx.Colors.White,  True,  1) 'check size  
    mCanvas.DrawText2(t,   1, 16 ,fx.DefaultFont(fs),fx.Colors.Black,"LEFT",TM.Width)  
    
    
    Dim fn As String = rand&"_"&DateTime.Now  
    Dim Dir As String  
    Dir = File.DirApp&"\tmplbl"  
    Dim Out As OutputStream  
    Out = File.OpenOutput(Dir, fn&".png", False)  
    
    mCanvas.Snapshot.WriteToStream(Out)  
    Out.Close  
    Return fn&".png"  
    
End Sub  
  
  
Sub MeasureText(Text As String,TFont As Font) As TextMetric  
    Dim TB,Bounds As JavaObject  
    Dim TM As TextMetric  
  
    TB.InitializeStatic("javafx.scene.text.TextBuilder")  
    Bounds = TB.RunMethodJO("create",Null).RunMethodJO("text",Array(Text)).RunMethodJO("font",Array(TFont)).RunMethodJO("build",Null).RunMethodJO("getLayoutBounds",Null)  
  
    TM.Width = Bounds.RunMethod("getWidth",Null)  
    TM.Height = Bounds.RunMethod("getHeight",Null)  
    Return TM  
End Sub
```

  
  
  
**New Project attached: mkpng.zip**