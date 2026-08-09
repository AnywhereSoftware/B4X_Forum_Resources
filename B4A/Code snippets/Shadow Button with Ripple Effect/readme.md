### Shadow Button with Ripple Effect by ganezha
### 08/01/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/171703/)

![](https://www.b4x.com/android/forum/attachments/172729)  
  
  

```B4X
#Region Shared Files  
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"  
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True  
#End Region  
  
#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip  
  
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
      
    Dim mainColorb As Int = 0xFF3B3B3B  
    Dim lightColorb As Int = 0xFF51555B  
    Dim darkColorb As Int  = 0xFF000000  
      
    Dim mainColor As Int = 0xFFE0E5EC  
    Dim lightColor As Int = 0xFFFFFFFF  
    Dim darkColor As Int  = 0xFFA3B1C6  
      
    Private btn1, btn2, btn3, btn4 As Button  
    Private Panel1, Panel2 As Panel  
End Sub  
  
Public Sub Initialize  
'    B4XPages.GetManager.LogEvents = True  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
      
    Panel1.Color = mainColor  
    Panel2.Color = mainColorb  
      
    GenerateViewShadow(btn1, btn1.Width/2, 0.2)  
    GenerateViewShadow(btn2, btn2.Width/24, 0.2)  
      
    GenerateViewShadow1(btn3, btn3.Width/2, 0.2)  
    GenerateViewShadow1(btn4, btn4.Width/24, 0.2)  
    AddRippleToAllButtons  
    AddRippleToAllButtons1  
End Sub  
  
Private Sub AddRippleToAllButtons  
    Dim ripple As RippleView  
    Dim btns As List = Array As B4XView(btn1, btn2)  
      
    For Each btn As B4XView In btns  
        ripple.Initialize(btn, Colors.Black, 300, True)  
    Next  
End Sub  
  
Private Sub AddRippleToAllButtons1  
    Dim ripple As RippleView  
    Dim btns As List = Array As B4XView(btn3, btn4)  
      
    For Each btn As B4XView In btns  
        ripple.Initialize(btn, Colors.White, 300, True)  
    Next  
End Sub  
  
Sub createLabel(myText As String) As Label  
    Dim l As Label  
    l.Initialize("")  
    l.Gravity = Gravity.CENTER  
    l.TextColor = Colors.Red  
    l.TextSize = 20  
    l.Text = myText  
    Return l  
End Sub  
      
      
Sub GenerateViewShadow( P As B4XView, cornerRadius As Int, insetPercentage As Float)  
  
    Dim BigWW As Int  = P.Width  
    Dim BigHH As Int = P.Height  
      
    ' inset percentage will be according to the smallest dim, but will be the same for both direction  
    Dim absInset As Float = insetPercentage*Min(BigWW, BigHH)  
    Dim SmallWW As Int = BigWW - absInset  
    Dim SmallHH As Int = BigHH - absInset  
  
    Dim CVX As B4XCanvas  
    CVX.Initialize(P)  
  
    Dim PX As B4XPath  
    Dim R0 As B4XRect  
    Dim dW As Int = (BigWW-SmallWW)/2  
    Dim dH As Int = (BigHH-SmallHH)/2  
    Dim d As Int = Max(dW, dH)  
      
    ' UPPER (light) shadow  
    For k = 0 To d  
        Dim kW As Float = k*dW/d  
        Dim kH As Float = k*dH/d  
        R0.Initialize( kW , kH, SmallWW+dW-kW, SmallHH+dH-kH)  
        PX.InitializeRoundedRect(R0, cornerRadius)  
        CVX.ClipPath(PX)  
        Dim pColor As Int = FindSolidColorBetween(mainColor, lightColor, 1.0*k*k*k/(d*d*d))  
        CVX.DrawRect(R0, pColor, True, 0)  
        CVX.RemoveClip  
    Next  
  
    ' LOWER (dark) shadow  
    For k = 0 To d  
        Dim kW As Float = k*dW/d  
        Dim kH As Float = k*dH/d  
        R0.Initialize( 2*dW-kW , 2*dH-kH, 2*dW+SmallWW-kW, 2*dH+SmallHH-kH)  
        PX.InitializeRoundedRect(R0, cornerRadius)  
        CVX.ClipPath(PX)  
        Dim pColor As Int = FindSolidColorBetween(mainColor, darkColor, 1.0*k*k*k/(d*d*d))  
        CVX.DrawRect(R0, pColor, True, 0)  
        CVX.RemoveClip  
    Next  
  
    ' Draw the 'plain' area with the main color.  
    R0.Initialize( dW , dH, dW+SmallWW, dH+SmallHH)  
    PX.InitializeRoundedRect(R0, cornerRadius)  
    CVX.ClipPath(PX)  
    CVX.DrawRect(R0, mainColor, True, 0)  
    CVX.RemoveClip  
End Sub  
  
  
Sub GenerateViewShadow1( P As B4XView, cornerRadius As Int, insetPercentage As Float)  
  
    Dim BigWW As Int  = P.Width  
    Dim BigHH As Int = P.Height  
      
    ' inset percentage will be according to the smallest dim, but will be the same for both direction  
    Dim absInset As Float = insetPercentage*Min(BigWW, BigHH)  
    Dim SmallWW As Int = BigWW - absInset  
    Dim SmallHH As Int = BigHH - absInset  
  
    Dim CVX As B4XCanvas  
    CVX.Initialize(P)  
  
    Dim PX As B4XPath  
    Dim R0 As B4XRect  
    Dim dW As Int = (BigWW-SmallWW)/2  
    Dim dH As Int = (BigHH-SmallHH)/2  
    Dim d As Int = Max(dW, dH)  
      
    ' UPPER (light) shadow  
    For k = 0 To d  
        Dim kW As Float = k*dW/d  
        Dim kH As Float = k*dH/d  
        R0.Initialize( kW , kH, SmallWW+dW-kW, SmallHH+dH-kH)  
        PX.InitializeRoundedRect(R0, cornerRadius)  
        CVX.ClipPath(PX)  
        Dim pColor As Int = FindSolidColorBetween(mainColorb, lightColorb, 1.0*k*k*k/(d*d*d))  
        CVX.DrawRect(R0, pColor, True, 0)  
        CVX.RemoveClip  
    Next  
  
    ' LOWER (dark) shadow  
    For k = 0 To d  
        Dim kW As Float = k*dW/d  
        Dim kH As Float = k*dH/d  
        R0.Initialize( 2*dW-kW , 2*dH-kH, 2*dW+SmallWW-kW, 2*dH+SmallHH-kH)  
        PX.InitializeRoundedRect(R0, cornerRadius)  
        CVX.ClipPath(PX)  
        Dim pColor As Int = FindSolidColorBetween(mainColorb, darkColorb, 1.0*k*k*k/(d*d*d))  
        CVX.DrawRect(R0, pColor, True, 0)  
        CVX.RemoveClip  
    Next  
  
    ' Draw the 'plain' area with the main color.  
    R0.Initialize( dW , dH, dW+SmallWW, dH+SmallHH)  
    PX.InitializeRoundedRect(R0, cornerRadius)  
    CVX.ClipPath(PX)  
    CVX.DrawRect(R0, mainColorb, True, 0)  
    CVX.RemoveClip  
End Sub  
  
' progress=0 –> we get colorA  
' progress=1 -> we get colorB  
Sub FindSolidColorBetween(colorA As Int, colorB As Int, progress As Float) As Int  
    Dim weight As Int = 256*(1-Max(0, Min(progress, 1)))  
    Dim finalRed As Int   = Bit.ShiftRight(weight*Bit.And(Bit.ShiftRight(colorA,16),0xFF) + (256-weight)*Bit.And(Bit.ShiftRight(colorB,16),0xFF),8)  
    Dim finalGreen As Int = Bit.ShiftRight(weight*Bit.And(Bit.ShiftRight(colorA, 8),0xFF) + (256-weight)*Bit.And(Bit.ShiftRight(colorB, 8),0xFF),8)  
    Dim finalBlue As Int  = Bit.ShiftRight(weight*Bit.And(Bit.ShiftRight(colorA, 0),0xFF) + (256-weight)*Bit.And(Bit.ShiftRight(colorB, 0),0xFF),8)  
    Return Colors.RGB(finalRed, finalGreen, finalBlue)  
End Sub
```