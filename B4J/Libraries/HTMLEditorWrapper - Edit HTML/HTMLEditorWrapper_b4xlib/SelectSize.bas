B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
#DesignerProperty: Key: BooleanExample, DisplayName: Show Seconds, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color

#Event: Selected(Cols As int, Rows As int)
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private fx As JFX
	Private DragRect As B4XView
	Private rWidth,RHeight As Double
	Private pnSelectSize As B4XView
	Private MaxRows As Int = 12
	Private MaxCols As Int = 12
	Private B4xCanv As B4XCanvas
	Public Cols,Rows As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	mBase.LoadLayout("selectsizelayout")
	B4xCanv.Initialize(pnSelectSize)
	
	rWidth = mBase.Width / MaxCols
	RHeight = mBase.Height / MaxRows
	Dim R As JavaObject
	R.InitializeNewInstance("javafx.scene.shape.Rectangle",Array(rWidth,RHeight))
	R.RunMethod("setFill",Array(fx.Colors.ARGB(70,0,0,255)))
	DragRect = R
End Sub

Private Sub pnSelectSize_Resize (Width As Double, Height As Double)
	rWidth = Width / MaxCols
	RHeight = Height / MaxRows
	B4xCanv.ClearRect(B4xCanv.TargetRect)
	Dim X, Y As Double
	For i = 0 To 11
		For j = 0 To 11
			X = i * rWidth
			Y = j * RHeight
			B4xCanv.DrawLine(X,Y,X + rWidth,Y,xui.Color_Black,1)
			B4xCanv.DrawLine(X,Y,X,Y + RHeight,xui.Color_Black,1)
		Next
	Next
	pnSelectSize.AddView(DragRect,0,0,rWidth,RHeight)
	
	DragRect.Visible = False
	DragRect.Width = rWidth
	DragRect.Height = RHeight
End Sub

Private Sub pnSelectSize_MousePressed (EventData As MouseEvent)
	If EventData.X <= rWidth And EventData.Y < RHeight Then
		DragRect.As(B4XView).Visible = True
	End If
End Sub

Private Sub pnSelectSize_MouseDragged (EventData As MouseEvent)
	If DragRect.Visible = True Then
		Dim W As Double = Max(rWidth,Min(pnSelectSize.Width,EventData.X))
		Dim H As Double = Max(RHeight,Min(pnSelectSize.Height,EventData.Y))
		Cols = Round(W / rWidth)
		Rows = Round(H / RHeight)
		W = Cols * rWidth
		H = Rows * RHeight
		DragRect.As(JavaObject).RunMethod("setWidth",Array(W))
		DragRect.As(JavaObject).RunMethod("setHeight",Array(H))
	End If
End Sub
Private Sub pnSelectSize_MouseReleased (EventData As MouseEvent)
	DragRect.Visible = False
	If SubExists(mCallBack,mEventName & "_Selected") Then
		CallSub3(mCallBack,mEventName & "_Selected",Cols,Rows)
	End If
End Sub