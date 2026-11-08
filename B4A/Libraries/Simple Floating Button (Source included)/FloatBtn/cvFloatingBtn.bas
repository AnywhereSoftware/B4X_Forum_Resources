B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
'Custom View class 
#Event: ExampleEvent (Value As Int)
'#DesignerProperty: Key: Width, DisplayName: Width, FieldType: int, DefaultValue: 55, Description: Width of button.
'#DesignerProperty: Key: Height, DisplayName: Height, FieldType: int, DefaultValue: 55, Description: Height of button.
#DesignerProperty: Key: ImageFile, DisplayName: Image File, FieldType: String, DefaultValue: , Description: Image for button.
'#DesignerProperty: Key: BooleanExample, DisplayName: Boolean Example, FieldType: Boolean, DefaultValue: True, Description: Example of a boolean property.
'#DesignerProperty: Key: IntExample, DisplayName: Int Example, FieldType: Int, DefaultValue: 10, MinRange: 0, MaxRange: 100, Description: Note that MinRange and MaxRange are optional.
'#DesignerProperty: Key: StringWithListExample, DisplayName: String With List, FieldType: String, DefaultValue: Sunday, List: Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday
'#DesignerProperty: Key: StringExample, DisplayName: String Example, FieldType: String, DefaultValue: Text
'#DesignerProperty: Key: ColorExample, DisplayName: Color Example, FieldType: Color, DefaultValue: 0xFFCFDCDC, Description: You can use the built-in color picker to find the color values.
'#DesignerProperty: Key: DefaultColorExample, DisplayName: Default Color Example, FieldType: Color, DefaultValue: Null, Description: Setting the default value to Null means that a nullable field will be displayed.
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As Panel
	Private Const DefaultColorConstant As Int = -984833 'ignore
	Private Const ACTION_DOWN=0,ACTION_UP=1 As Int
	Private downx, downy  As Float
	Private S1,S2,Diff As Long
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

Public Sub DesignerCreateView (Base As Panel, Lbl As Label, Props As Map)
	mBase = Base
	Private ImgFl As String
	ImgFl = Props.Get("ImageFile")
	
	If ImgFl <> "" Then mBase.SetBackgroundImage(LoadBitmap(File.DirAssets,ImgFl))
	
	SetOnTouchListener(mBase)
End Sub

Public Sub GetBase As Panel
	Return mBase
End Sub

Public Sub setLeft(Left As Int)
	mBase.Left  = Left
End Sub

Public Sub setTop(Top As Int)
	mBase.Top = Top
End Sub

Public Sub setVisible(Flag As Boolean)
	mBase.Visible = Flag
End Sub

Private Sub SetOnTouchListener(MyView As View)
	Dim ref As Reflector
	ref.Target = MyView
	ref.SetOnTouchListener("Panel_Touch")
End Sub

Private Sub Panel_Touch(ViewTag As Object, Action As Int, X As Float, Y As Float, MotionEvent As Object) As Boolean
	If Action = ACTION_DOWN Then
		downx = x
		downy = y
		S1 = DateTime.Now
	else If Action = ACTION_UP Then
		S2 = DateTime.Now
		Diff = S2 - S1
		
		If Diff <= 199 Then
			If SubExists(mCallBack,mEventName.Trim & "_Clicked") Then CallSub3(mCallBack,mEventName.Trim & "_Clicked",X,Y)			
		End If
	Else
		mBase.Left = mBase.Left + x - downx
		mBase.Top = mBase.Top + y - downy
		mBase.Left = mBase.Left
		mBase.Top = mBase.Top
	End If
	Return True
End Sub