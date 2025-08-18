Type=Class
Version=6.5
ModulesStructureVersion=1
B4A=true
@EndOfDesignText@
'Custom View class 
#Event: ChangeValue
#DesignerProperty: Key: Min, DisplayName: Min Value, FieldType: int, DefaultValue: 0, Description: Min value
#DesignerProperty: Key: Max, DisplayName: Max Value, FieldType: Int, DefaultValue: 10, Description: Max Value
#DesignerProperty: Key: Value, DisplayName: Actual Value, FieldType: int, DefaultValue: 0, Description: Get o Set valute
#DesignerProperty: Key: StepIncremental, DisplayName: Step incremental or decremental, FieldType: int, DefaultValue: 1,MinRange: 1, Description: Get o Set valute

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As Panel
	Private Const DefaultColorConstant As Int = -984833 'ignore
	Private Lab As Label
	
	Private Valore As Int
	Public MinValue,MaxValue,StepIncremental As Int
	Public Tag As Object
	
End Sub

'Initialize Custom View - Used by Designer and by code via AddToParent
'Initialize(Me,"Name")
'#Event: NameClass_ChangeValue
Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

Sub Corner(Colore As Int) As ColorDrawable
	Dim cdb As ColorDrawable
	cdb.Initialize(Colore, 20dip)
	Return cdb
End Sub

'Don't call on code 
Public Sub DesignerCreateView (Base As Panel, Lbl As Label, Props As Map)
	Dim X,disp As Int
	Dim Bm,Bm2 As Bitmap
	Dim Bp,Bn As Button
	Dim Can,Can2 As Canvas
	Dim Raggio As Double
	Dim Spessore As Double = 6dip
	Dim Space As Double = 16dip
	
	mBase = Base
	Base.Color=Colors.Transparent
	
	If Props.ContainsKey("Min") Then MinValue=Props.Get("Min") Else MinValue=1
	If Props.ContainsKey("Max") Then MaxValue=Props.Get("Max") Else MaxValue=10
	If Props.ContainsKey("Value") Then Value=Props.Get("Value") Else Value=1
	If Props.ContainsKey("StepIncremental") Then StepIncremental=Props.Get("StepIncremental") Else StepIncremental=1
	
	If Base.Width/(3.5)>Base.Height Then X=Base.Height Else X=Base.Width/(3.5)
	disp=(Base.Height-x)/2
	
	Raggio=X-(Spessore/2)
	Bm.InitializeMutable(x*2,x*2)
	Can.Initialize2(Bm)
	Can.DrawCircle(X,X,Raggio,Colors.RGB(188,185,185),True,Spessore)
	Can.DrawCircle(X,X,Raggio,Colors.RGB(60,60,60),False,Spessore)
	Can.DrawLine(Space,X,(X*2)-Space,X,Colors.Black,Spessore*2)
	Bn.Initialize("Bn")
	Bn.SetBackgroundImage(Can.Bitmap)
	
	Bm2.InitializeMutable(x*2,x*2)
	Can2.Initialize2(Bm2)
	Can2.DrawCircle(X,X,Raggio,Colors.RGB(188,185,185),True,Spessore)
	Can2.DrawCircle(X,X,Raggio,Colors.RGB(60,60,60),False,Spessore)
	Can2.DrawLine(Space,X,(X*2)-Space,X,Colors.Black,Spessore*2)
	Can2.DrawLine(X,Space,X,(X*2)-Space,Colors.Black,Spessore*2)
	Bp.Initialize("Bp")
	Bp.SetBackgroundImage(Can2.Bitmap)
		
	Lab.Initialize("")
	Lab.Text=Valore
	'Lab.Color=Colors.RGB(188,185,185)
	Lab.Background=Corner(Colors.RGB(188,185,185))
	Lab.TextColor=Colors.Black
	Lab.Gravity=Gravity.CENTER
	Lab.TextSize=X/2dip
	Base.AddView(Lab,X,disp,Base.Width-(X*2),x)
				
	Base.AddView(Bp,0dip,disp,X,X)
	Base.AddView(Bn,Base.Width-x,disp,X,X)
End Sub

Public Sub GetBase As Panel
	Return mBase
End Sub

Public Sub setValue(NewValue As Int)
	Valore=NewValue
	Lab.Text=Valore
End Sub

Sub getValue As Int
	Return Valore
End Sub

Private Sub Bp_Click
	If Valore+StepIncremental<=MaxValue Then
		Valore=Valore+StepIncremental
		Lab.Text=Valore
		If SubExists(mCallBack,mEventName & "_ChangeValue") Then CallSub(mCallBack,mEventName & "_ChangeValue")
	End If
End Sub

Private Sub Bn_Click
	If Valore-StepIncremental>=MinValue Then
		Valore=Valore-StepIncremental
		Lab.Text=Valore
		If SubExists(mCallBack,mEventName & "_ChangeValue") Then CallSub(mCallBack,mEventName & "_ChangeValue")
	End If
End Sub