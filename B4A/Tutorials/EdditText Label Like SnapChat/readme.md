### EdditText Label Like SnapChat by Alexander Stolte
### 02/06/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/84453/)

![](https://www.b4x.com/android/forum/attachments/60105)  
Hello,  
  
**UPDATE  
  
This version includes Multiline Support and Guaranteed functionality. The last version had a lot of bugs, that new example is more mature.**  
  
At the moment, I'm experimenting a bit with editing images and one way is to place a text and push it up or down as desired. Since there is no solution for it, I just put something together.  
  
  
This is the Multiline  
![](https://www.b4x.com/android/forum/attachments/60111)  
  
  
this is the Original from Snapchat And this is my Example  
![](https://www.b4x.com/android/forum/attachments/60103) ![](https://www.b4x.com/android/forum/attachments/60104)  
  
You can swipe it  
  
![](https://www.b4x.com/android/forum/attachments/60105)  
  
  
  
We need this libraries:  
  
[-GestureDetector](https://www.b4x.com/android/forum/threads/lib-gesture-detector.21502/)  
-IME  
-StringUtils  
-JavaObject  
  
The View is made of a Panel, in this Panel is a EditText and a Label  
  

```B4X
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
   
    'Libs  
    Dim su As StringUtils  
    Dim ime As IME  
    Dim GD As GestureDetector  
   
    'Views  
    Private pnl_back As Panel  
    Private txb_input As EditText  
    Dim pnltop As Int  
    Private lbl_input As Label  
     
    'Variable  
    Dim listener As Int = 0  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("frm_main")  
    ime.Initialize("ime")  
    ime.AddHeightChangedEvent  
End Sub  
  
  
'Count the lines of the TextBox  
Sub getLineCount(TargetView As Object) As Int  
    Dim source = TargetView As JavaObject  
    Return source.RunMethod("getLineCount", Null)  
End Sub  
'is triggerd if the Keyboard open or close  
Sub ime_HeightChanged(NewHeight As Int, OldHeight As Int)  
   
    If listener = 1 Then ' if listener = 1 then check if the input text = 0 or not then change the height and top  
     
        If txb_input.Text.Length = 0 Then  
            pnl_back.Visible = False  
            listener = 0  
        Else  
            pnl_back.Height = su.MeasureMultilineTextHeight(txb_input,txb_input.Text ) +10dip  
            lbl_input.Height = pnl_back.Height  
   
            pnl_back.Top = pnltop - pnl_back.Height  
   
            txb_input.Height =  su.MeasureMultilineTextHeight(txb_input,txb_input.Text ) +14dip  
         
            lbl_input.Text = txb_input.Text  
            txb_input.Visible = False  
         
            lbl_input.Visible = True  
         
            GD.SetOnGestureListener(lbl_input, "Gesture") 'Set the Listener of the Gesture Detector on The Label  
            pnl_back.Top = 50%y  
            listener = 0 'because the keyboard is close now  
        End If  
    Else  
        pnl_back.Height = su.MeasureMultilineTextHeight(txb_input,txb_input.Text ) +10dip  
     
        pnl_back.Top = NewHeight - pnl_back.Height  
        pnltop = NewHeight  
        listener = 1  
    End If  
   
End Sub  
  
Sub txb_input_TextChanged (Old As String, New As String)  
            listener = 1  
  
    If getLineCount(txb_input) = 1 Then 'First line  
     
    pnl_back.Height = su.MeasureMultilineTextHeight(txb_input,txb_input.Text ) +10dip  
        lbl_input.Height = pnl_back.Height  
   
    pnl_back.Top = pnltop - pnl_back.Height  
   
        txb_input.Height =  su.MeasureMultilineTextHeight(txb_input,txb_input.Text ) +14dip  
   
    else If getLineCount(txb_input) = 2 Then 'second line…  
   
        txb_input.Height = su.MeasureMultilineTextHeight(txb_input,txb_input.Text )  
        txb_input.Height = txb_input.Height +10dip  
   
        pnl_back.Height = txb_input.Height +10dip  
        lbl_input.Height = pnl_back.Height  
        pnl_back.Top = pnltop  - txb_input.Height  
     
     
    else If getLineCount(txb_input) = 3 Then  
   
        txb_input.Height = su.MeasureMultilineTextHeight(txb_input,txb_input.Text )  
        txb_input.Height = txb_input.Height +10dip  
   
        pnl_back.Height = txb_input.Height +10dip  
        pnl_back.Top = pnltop  - txb_input.Height  
        lbl_input.Height = pnl_back.Height  
   
    else If getLineCount(txb_input) = 4 Then  
   
        txb_input.Height = su.MeasureMultilineTextHeight(txb_input,txb_input.Text )  
        txb_input.Height = txb_input.Height +10dip  
   
        pnl_back.Height = txb_input.Height +10dip  
        pnl_back.Top = pnltop  - txb_input.Height  
        lbl_input.Height = pnl_back.Height  
     
    else If getLineCount(txb_input) = 5 Then  
   
        txb_input.Height = su.MeasureMultilineTextHeight(txb_input,txb_input.Text )  
        txb_input.Height = txb_input.Height +10dip  
   
        pnl_back.Height = txb_input.Height +10dip  
        pnl_back.Top = pnltop  - txb_input.Height  
        lbl_input.Height = pnl_back.Height  
    End If  
End Sub  
'if we move the label up or down, the panel will move to it  
Sub Gesture_onDrag(deltaX As Float, deltaY As Float, MotionEvent As Object)  
    pnl_back.Top = Max(0, Min(pnl_back.Top + deltaY, 100%y - pnl_back.Height))  
End Sub  
'because the label_onclick event is not fired with the Gesture Detector  
Sub Gesture_onSingleTapConfirmed(X As Float, Y As Float, MotionEvent As Object)  
    txb_input.Visible = True  
    lbl_input.Visible = False  
    listener = 0  
    ime.ShowKeyboard(txb_input)    'open the Keyboard  
End Sub
```

  
  
Put this in the Manifest  

```B4X
SetActivityAttribute(main, android:windowSoftInputMode, adjustResize)
```