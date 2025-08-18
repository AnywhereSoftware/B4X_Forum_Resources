### set and get with more parameters by Rosen Parlev
### 10/02/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/123008/)

Now I have started a very big project and I came to the problem how to set and get more parameters.  
Yesterday I spent the whole day looking for a solution on the forum how to set and get more than one parameter in Sub setSome / getSome.  
  
But today, I have a ready-made solution that works.   

```B4X
Private Sub Class_Globals  
    Private lblCaption As Label  
    Type optFont (aFont As Typeface, aSize As Int, aTypeFace As Typeface, aStyle As Int)  
    Private fCls As optFont  
End Sub  
  
Public Sub Initialize (Owner As Activity, Module As Object, Event As String)  
'    ……………  
End Sub  
  
Public Sub AddView (Module As Object, Left As Int, Top As Int, Width As Int, Height As Int)  
'    ……………  
End Sub  
  
Sub setFont (Font As optFont)  
    lblCaption.Typeface = Font.aFont  
    lblCaption.TextSize = Font.aSize  
    lblCaption.Typeface = Typeface.CreateNew (Font.aTypeFace,Font.aStyle)  
End Sub  
  
Sub getFont As optFont  
    Return fCls  
End Sub
```

  
  

```B4X
Sub Globals  
    Dim frmOpen As WinForm  
    Dim opt1 As WinOpt  
    Dim Sonda (30) As Typeface  
    Dim oFont As optFont  
    Dim oTypeFace () As Typeface = Array As Typeface   (Typeface.DEFAULT, _  
                                                        Typeface.DEFAULT_BOLD, _  
                                                        Typeface.MONOSPACE, _  
                                                        Typeface.SANS_SERIF, _  
                                                        Typeface.SERIF)  
      
    Dim oStyle () As Int = Array As Int    (Typeface.STYLE_BOLD, _  
                                            Typeface.STYLE_BOLD_ITALIC, _  
                                            Typeface.STYLE_ITALIC, _  
                                            Typeface.STYLE_NORMAL)  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Sonda(0) = Typeface.LoadFromAssets("courbd.ttf") 'Избор на шрифт  
    Sonda(1) = Typeface.LoadFromAssets("anka.ttf")  'Избор на шрифт на дисплея  
  
    Activity.Color = Colors.White  
  
    frmOpen.Initialize (Activity, Me, Null, "frmOpen")  
    frmOpen.frmCreate ("This is the ORIGINAL WINDOWS FORM")  
  
    opt1.Initialize (Activity, frmOpen, "opt1")  
    opt1.AddView (frmOpen, 2.08%x, 8.62%y, 13.02%x, 5.39%y)  
    opt1.Caption = "OptionButton!"  
  
    oFont.aFont = Sonda(0)  
    oFont.aSize = 16  
    oFont.aStyle = oStyle (0)  
    oFont.aTypeFace = oTypeFace (0)  
    opt1.FontR = oFont  
    Msgbox(oFont.aTypeFace,oFont.aStyle)  
End Sub
```

  
  
Before I wrote the above code and after I got desperate that I couldn't enter more than one parameter, I wrote:  
setFont / getFont  
setFontSize / getFoneSize  
setFontStyle / getFontStyle  
but my idea is to have many parameters for each component I write, and parameters, as is the case with a font, to combine several at once.