###  Toggleswitch & Button View by T201016
### 05/20/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/171067/)

New toggleswitch view using and adapting the source: [ToggleSwitch](https://www.b4x.com/android/forum/threads/b4j-toggleswitch.99089/)  
I have attached the ttoggleswitch.css file (*[SIZE=3]you will find my inserts in the highlighted lines[/SIZE]*)  
  
![](https://www.b4x.com/android/forum/attachments/171558)![](https://www.b4x.com/android/forum/attachments/171559)  
  

```B4X
'Custom View class  
#Event: SelectedChanged (Selected As Boolean)  
#DesignerProperty: Key: Selected, DisplayName: Selected, FieldType: Boolean, DefaultValue: False, Description: Switch initial selected state.  
Sub Class_Globals  
    Private fx As JFX  
    Private mEventName As String 'ignore  
    Private mCallBack As Object 'ignore  
    Private mBase As Pane  
    Private Circle As Pane  
    Private mSelected As Boolean = False  
    Private TSLbl As Label  
    Private mDuration As Long = 300  
    Private Animating As Boolean  
End Sub  
  
Public Sub Initialize (Callback As Object, EventName As String)  
    mEventName = EventName  
    mCallBack = Callback  
End Sub  
  
Public Sub DesignerCreateView (Base As Pane, Lbl As Label, Props As Map)  
    mBase = Base  
    TSLbl = Lbl  
  
    mSelected = Props.Get("Selected")  
    mBase.StyleClasses.Add("togglebutton-base")  
  
    Dim CircleWidth As Double = mBase.PrefHeight - 4  
    Circle.Initialize("Circle")  
    Circle.StyleClasses.Add("togglebutton-circle")  
    mBase.AddNode(Circle,2,2,CircleWidth,CircleWidth)  
  
    Lbl.StyleClasses.Add("togglebutton-label")  
    mBase.AddNode(Lbl,CircleWidth + 4,2,mBase.PrefWidth - CircleWidth - 4,CircleWidth)  
End Sub  
  
Private Sub Base_Resize (Width As Double, Height As Double)  
    Dim CircleWidth As Double = mBase.PrefHeight - 4  
    Circle.PrefHeight = CircleWidth  
    Circle.PrefWidth = CircleWidth  
    SetButtonState  
End Sub  
  
Private Sub SetButtonState As ResumableSub  
    TSLbl.Visible = False  
    Animating = True  
    If mSelected Then  
        Circle.SetLayoutAnimated(mDuration,mBase.PrefWidth - Circle.PrefWidth - 2,2,Circle.PrefWidth,Circle.PrefHeight)  
        Sleep(mDuration)  
        TSLbl.StyleClasses.Clear  
        TSLbl.StyleClasses.Add("togglebutton-label-selected")  
        TSLbl.Left = 2  
        TSLbl.Text = mBase.Tag  
    Else  
        Circle.SetLayoutAnimated(mDuration,2,2,Circle.PrefWidth,Circle.PrefHeight)  
        Sleep(mDuration)  
        TSLbl.StyleClasses.Clear  
        TSLbl.StyleClasses.Add("togglebutton-label")  
        TSLbl.Left = Circle.PrefWidth + 2  
        TSLbl.Text = IIf(TSLbl.Width >= 68 And TSLbl.Width <= 250, "Status: INACTIVE !", "OFF")  
    End If  
    Animating = False  
    TSLbl.Visible = True  
    Return Null  
End Sub  
  
Public Sub GetBase As Pane  
    Return mBase  
End Sub  
  
Private Sub Base_MouseClicked (EventData As MouseEvent)  
    If Animating Then Return  
    mSelected = Not(mSelected)  
    Wait For (SetButtonState) Complete (Result As Object)  
    If SubExists(mCallBack,mEventName & "_SelectedChanged") Then CallSubDelayed2(mCallBack,mEventName & "_SelectedChanged",mSelected)  
End Sub  
  
Public Sub setSelected(Selected As Boolean)  
    mSelected = Selected  
    SetButtonState  
End Sub  
  
Public Sub getSelected As Boolean  
    Return mSelected  
End Sub  
  
Public Sub setVisible(Visible As Boolean)  
    mBase.Visible = Visible  
End Sub  
  
Public Sub getVisible As Boolean  
    Return mBase.Visible  
End Sub  
  
Public Sub getEnable As Boolean  
    Return mBase.Enabled  
End Sub  
  
Public Sub RequestFocus  
    mBase.RequestFocus  
End Sub
```