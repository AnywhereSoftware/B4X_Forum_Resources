### Flexible Table Sort Icons by advansis
### 11/08/2019
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/111191/)

Hi to everybody,  
when I use Flexible Table (<https://www.b4x.com/android/forum/threads/class-flexible-table.30649/>), most times I forget to include the sorting icons in fileassets.  
Furthermore, I wanted a dynamical way of creating such icons, so I modified the library code. If you find useful, please include in future versions.  
  
1) I **added the XUI library**  
  
2) In **Class\_Globals**, added the Bitmaps vars:  
  

```B4X
Public ascBmp,descBmp As B4XBitmap
```

  
  
3) Added the function (thanks to Erel and Filippo):  

```B4X
Public Sub FontToBitmap (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap  
    Dim xui As XUI  
    Dim p As Panel = xui.CreatePanel("")  
    p.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)  
    Dim cvs1 As B4XCanvas  
    cvs1.Initialize(p)  
    Dim t As Typeface  
    If IsMaterialIcons Then t = Typeface.MATERIALICONS Else t = Typeface.FONTAWESOME  
    Dim fnt As B4XFont = xui.CreateFont(t, FontSize)  
    Dim r As B4XRect = cvs1.MeasureText(text, fnt)  
    Dim BaseLine As Int = cvs1.TargetRect.CenterY - r.Height / 2 - r.Top  
    cvs1.DrawText(text, cvs1.TargetRect.CenterX, BaseLine, fnt, color, "CENTER")  
    Dim b As B4XBitmap = cvs1.CreateBitmap  
    cvs1.Release  
    Return b  
End Sub
```

  
  
I didn't try to obtain the same functionality without XUI…  
  
4) Changed the **Initialize** sub to have default images:  
  

```B4X
Public Sub Initialize (CallBack As Object, EventName As String)  
    cEventName = EventName  
    cCallBack = CallBack  
    ascBmp=FontToBitmap(Chr(0xF0DE),False,10,Colors.white)  
    descBmp=FontToBitmap(Chr(0xF0DD),False,10,Colors.white)  
End Sub
```

  
  
5) Changed the **showHeaderSorting** sub:  
  

```B4X
    If (dir = -1) Then  
        'sortingView.SetBackgroundImage(LoadBitmapSample(File.DirAssets, "sort_asc.png", ll, ll))  
        sortingView.SetBackgroundImage(ascBmp)  
    Else  
        'sortingView.SetBackgroundImage(LoadBitmapSample(File.DirAssets, "sort_desc.png", ll, ll))  
        sortingView.SetBackgroundImage(descBmp)  
    End If
```

  
  
Hope this will be helpful…