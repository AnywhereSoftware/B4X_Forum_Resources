### AutoCompleteEditText by Star-Dust
### 10/15/2019
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/110544/)

To bring an App B4A to B4I I had to create some B4i classes (with the help of XUI) that would reproduce some views that do not exist in B4i  
  
I chose to publish AutoCompleteEditText ….. I hope I can help someone …  
  

```B4X
#Event: ItemClick (Value As String)  
  
'Custom View class  
Sub Class_Globals  
    Private mEventName As String 'ignore  
    Private mCallBack As Object 'ignore  
    Private mBase As WeakRef  
   
    Public Tag As Object  
    Private EditText As TextField  
    Private Lista As List  
    Private PanelList As ScrollView  
End Sub  
  
Public Sub Initialize (Callback As Object, EventName As String)  
    mEventName = EventName  
    mCallBack = Callback  
   
    EditText.Initialize("EditText")  
    PanelList.Initialize("PanelList",500dip,1000dip)  
    PanelList.Color=Colors.ARGB(150,0,0,0)  
End Sub  
  
Public Sub DesignerCreateView (Base As Panel, Lbl As Label, Props As Map)  
    mBase.Value = Base  
   
    Base.AddView(EditText,0,0,Base.Width,Base.Height)  
End Sub  
  
Private Sub Base_Resize (Width As Double, Height As Double)  
    EditText.Width=Width  
    EditText.Height=Height  
End Sub  
  
Public Sub GetBase As Panel  
    Return mBase.Value  
End Sub  
  
  
Public Sub setText(Text As String)  
    EditText.Text=Text  
End Sub  
  
Public Sub getText As String  
    Return EditText.Text  
End Sub  
  
Public Sub SetItems(L As List)  
    Lista= L  
End Sub  
  
Public Sub Invalidate  
    For Each S As String In Lista  
        Log(S)  
    Next  
End Sub  
  
Private Sub EditText_BeginEdit  
    Dim mB As Panel = mBase.Value  
    Dim MainParent As Panel= mB.Parent  
  
    ' Main.KeyBoardHeigth is a Global Variable  
    MainParent.AddView(PanelList,mB.Left,mB.Top+mB.Height,mB.Width,MainParent.Height-mB.Height-Main.KeyBoardHeight-90dip)  
    EditText_TextChanged (EditText.Text,EditText.Text)  
End Sub  
  
Private Sub EditText_EndEdit  
    PanelList.RemoveViewFromParent  
    if SubExists(mCallBack,mEventName & "_ItemClick",1) then CallSub2(mCallBack,mEventName & "_ItemClick",EditText.Text)  
End Sub  
  
Private Sub EditText_TextChanged (OldText As String, NewText As String)  
    Dim I As Int = 0  
   
    PanelList.Panel.RemoveAllViews  
    PanelList.ContentWidth=PanelList.Width  
    For Each S As String In Lista  
        If S.ToLowerCase.Contains(NewText.ToLowerCase) And NewText.Trim<>"" Then  
            PanelList.Panel.AddView(CreaLabel(S),2dip,I*34dip,PanelList.Width-4dip,35dip)  
            I=I+1  
            PanelList.ContentHeight=I*35dip  
        End If  
    Next  
End Sub  
  
private Sub PanelList_Touch(Action As Int, X As Float, Y As Float)  
   
End Sub  
  
Private Sub CreaLabel(Text As String) As Label  
    Dim L As Label  
    L.Initialize("Label")  
    L.Text=Text  
    L.Color=Colors.LightGray  
    L.TextColor=Colors.Black  
   
    Return L  
End Sub  
  
Private Sub Label_Click  
    Dim S As Label = Sender  
    EditText.Text = S.Text  
    EditText_TextChanged (EditText.Text,EditText.Text)  
End Sub
```

  
  
  
**For KeyBoardHeight (in Main Code)**  

```B4X
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Public KeyBoardHeight As Application  
    ' … Other Variable  
End Sub  
  
Sub Page1_KeyboardStateChanged (Height As Float)  
    KeyBoardHeight=Height  
End Sub
```

  
  
PS. If you want you can improve the code and publish it to follow to share it with others