###  (Crow Up/Down every 25%) - Scrollbar in a TableView by T201016
### 05/31/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/171151/)

Hello,  
The following code snippet is intended to handle the scroll bar  
in TableView (i.e. tbvSearch), using two buttons,  
taking into account the case when the scroll bar is not visible.  
  
In this example for a vertical (UP/DN) scrollbar:  
  
![](https://www.b4x.com/android/forum/attachments/171723)  
  
  
1. Public variables:  

```B4X
Sub Process_Globals  
    Public tbvSearch As TableView  
  
    #Region ScrollPane Position  
    Public VerticalScrollBar As JavaObject  
    Public pnPosition As Pane  
    Public btnVTPosition As B4XView  
    Public btnVBPosition As B4XView  
    Type MyScrollPane (MinValue As Double, MaxValue As Double, SetValue As Double)  
    Public msp As MyScrollPane  
    #End Region  
    ….  
End Sub
```

  
  
2. Variable initialization and function call in AppStart:  

```B4X
Sub AppStart (Form1 As Form, Args() As String)  
    msp.Initialize  
    VerticalScrollBar = FindVerticalScrollBar(tbvSearch)  
    ….  
End Sub
```

  
  
3. Calling the function in MainForm\_Resize,  
 required when the number of lines does not exceed the page  
 and the scroll bar view is invisible:  

```B4X
Sub MainForm_Resize (Width As Double, Height As Double)  
    CallSubDelayed(Me, "VisiblePosition") '  
    ….  
End Sub
```

  
  
4. Put everything else in the Main - Code Module:  

```B4X
#Region Scroll-Bar Position H&V in TableView  
  
'Scroll UP (crow up every 25%)  
Private Sub btnVBPosition_Click  
    If tbvSearch.Items.Size = 0 Then Return  
  
    msp.MinValue = VerticalScrollBar.RunMethod("getMin", Null)  
    msp.MaxValue = VerticalScrollBar.RunMethod("getMax", Null)  
  
    If msp.SetValue > 0.75 And msp.SetValue <= 1.0 Then  
        msp.SetValue = 0.75  
    Else If msp.SetValue > 0.50 And msp.SetValue <= 0.75 Then  
        msp.SetValue = (msp.MinValue + msp.MaxValue) / 2 '0.50  
    Else If msp.SetValue > 0.25 And msp.SetValue <= 0.50 Then  
        msp.SetValue = (msp.MinValue + msp.MaxValue) / 4 '0.25  
    Else If msp.SetValue > 0.0 And msp.SetValue <= 0.25 Then  
        msp.SetValue = 0.00  
    End If  
    VerticalScrollBar.RunMethod("setValue", Array(msp.SetValue))  
    If SelectedRow >= 0 Then  
        tbvSearch.RequestFocus  
        tbvSearch.SelectedRow = SelectedRow  
        tbvSearch.SelectCell(SelectedRow,2)  
    End If  
End Sub  
  
'Scroll DN (crow down every 25%)  
Private Sub btnVTPosition_Click  
    If tbvSearch.Items.Size = 0 Then Return  
   
    msp.MinValue = VerticalScrollBar.RunMethod("getMin", Null)  
    msp.MaxValue = VerticalScrollBar.RunMethod("getMax", Null)  
  
    If msp.SetValue >= 0.0 And msp.SetValue < 0.25 Then  
        msp.SetValue = (msp.MinValue + msp.MaxValue) / 4 '0.25  
    Else If msp.SetValue >= 0.25 And msp.SetValue < 0.50 Then  
        msp.SetValue = (msp.MinValue + msp.MaxValue) / 2 '0.50  
    Else If msp.SetValue >= 0.50 And msp.SetValue < 0.75 Then  
        msp.SetValue = 0.75  
    Else If msp.SetValue >= 0.75 And msp.SetValue < 1.0 Then  
        msp.SetValue = 1.00  
    End If  
    VerticalScrollBar.RunMethod("setValue", Array(msp.SetValue))  
    If SelectedRow >= 0 Then  
        tbvSearch.RequestFocus  
        tbvSearch.SelectedRow = SelectedRow  
        tbvSearch.SelectCell(SelectedRow,2)  
    End If  
End Sub  
  
Private Sub FindVerticalScrollBar (tv As TableView) As JavaObject  
    Dim jo As JavaObject = tv  
    Dim bars() As Object = jo.RunMethodJO("lookupAll", Array(".scroll-bar")).RunMethod("toArray", Null)  
    For Each baro As JavaObject In bars  
        Dim orientation As String = baro.RunMethod("getOrientation", Null)  
        If orientation = "VERTICAL" Then  
            Return baro  
        End If  
    Next  
    Return Null  
End Sub  
  
Private Sub ScrollChangedEvent  
    Dim jo As JavaObject  
    jo = tbvSearch  
    Dim nodes() As Object  
    nodes = jo.RunMethodJO("lookupAll",Array(".scroll-bar")).RunMethod("toArray",Null)  
    Dim TableViewScrollBar As JavaObject  
   
    For Each sb As Object In nodes  
        Dim sbJO As JavaObject  
        sbJO = sb  
        Dim orientation As String = sbJO.RunMethod("getOrientation", Null)  
        If orientation = "VERTICAL" Then  
            TableViewScrollBar = sbJO  
        End If  
    Next  
   
    Dim r As Reflector  
    r.Target = TableViewScrollBar  
    r.AddChangeListener("tbvSearch_ScrollPosition","valueProperty")  
End Sub  
  
Private Sub tbvSearch_ScrollPosition_Changed (OldVal As Object, NewVal As Object)  
    btnVBPosition.Visible = IIf(NewVal.As(Double) = 0.0, False, True)  
    btnVTPosition.Visible = IIf(NewVal.As(Double) = 1.0, False, True)  
End Sub  
  
Private Sub VisiblePosition  
    Dim jo As JavaObject = tbvSearch  
    Dim bars() As Object = jo.RunMethodJO("lookupAll", Array(".scroll-bar")).RunMethod("toArray", Null)  
   
    For Each node As Node In bars  
        If GetType(node) = "com.sun.javafx.scene.control.skin.VirtualScrollBar" Or GetType(node) = "javafx.scene.control.ScrollBar" Then  
            Dim SB As JavaObject = node  
            Dim BarOrientation As String = SB.RunMethodJO("getOrientation",Null).RunMethod("toString",Null)  
            If BarOrientation = "VERTICAL" Then  
                ' Delete or Restore UP/DN buttons View (when the bar is visible or not)  
                pnPosition.Visible = node.Visible  
            End If  
        End If  
    Next  
    If pnPosition.Visible Then ScrollChangedEvent  
End Sub  
  
#End Region
```