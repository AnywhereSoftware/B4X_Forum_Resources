### Managing color themes with Designer Script Extensions by Cadenzo
### 11/05/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/163896/)

I am glad, that I found now a solution for my [wish](https://www.b4x.com/android/forum/threads/color-management-for-designer-and-runtime.163848/), managing the colors in designer and at runtime. It's still not 100% what I was looking for, but it is possible to change colors in one place, no need to go through all views of all designer files. It works with the [Designer Script Extensions](https://www.b4x.com/android/forum/threads/b4x-dse-designer-script-extensions.141312/), using my own class "MyDDD", so the DDD / DesignerUtils are not needed for this. Just having a method with parameters (DesignerArgs As DesignerArgs) makes the class and the method visible in the Designer Script.   
  

```B4X
Sub Class_Globals  
    Private xui As XUI  
    Public i_Colors() As Int 'Public, if you also want to change color themes at runtime  
End Sub  
  
'Initializes the object. You can add parameters to this method if needed.  
Public Sub Initialize  
    'Define color themes here  
    Dim iColors() As Int = Array As Int(xui.Color_Black, xui.Color_Gray, 0x37AFE100, 0x4CC9FE00, 0xF5F4B300, 0xFFFECB00)  
    i_Colors = iColors  
End Sub  
  
Public Sub GetColor(colorType As Int) As Int  
    If colorType = -1 Then Return -1 'no setting  
    Return i_Colors(colorType)  
End Sub  
  
'Parameters: BackColorID, TextColorID, View(s)  
Private Sub SetColor(DesignerArgs As DesignerArgs)  
    'In B4i and B4J the script will run multiple times. We want to run this code once.  
    If DesignerArgs.FirstRun Then  
        Dim iBackColor As Int = GetColor(DesignerArgs.Arguments.Get(0))  
        Dim iTextColor As Int = GetColor(DesignerArgs.Arguments.Get(1))  
        For i = 2 To DesignerArgs.Arguments.Size - 1  
            Dim v As B4XView = DesignerArgs.GetViewFromArgs(i)  
            If iBackColor <> -1 Then  v.Color = iBackColor  
            If iTextColor <> -1 Then  v.TextColor = iTextColor  
        Next  
    End If  
End Sub
```

  
  

```B4X
MyDDD.SetColor(2, 4, Label1, Label2, Button1)  
MyDDD.SetColor(3, -1, Panel1)  
MyDDD.SetColor(-1, 4, Label3, Label4)
```

  
  

```B4X
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
     
    'only, if runtime changes are needed (Public MyDD As MyDDD in Main Process_Globals)  
    Main.MyDD.Initialize  
     
    Root = Root1  
    Root.LoadLayout("MainPage") 'all colors are already as defined in MyDDD class  
     
    'also change colors at runtime  
    Label2.TextColor = Main.MyDD.GetColor(0)  
    SwiftButton1.SetColors(Main.MyDD.GetColor(4), Main.MyDD.GetColor(5))  
     
End Sub
```