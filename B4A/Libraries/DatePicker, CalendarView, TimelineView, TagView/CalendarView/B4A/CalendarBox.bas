B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
#Event: Click (NewDate As Long)
#DesignerProperty: Key: BooleanExample, DisplayName: Show Seconds, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As Panel
	Private xui As XUI 'ignore
	Public Tag As Object
	Private pnlWrapper As Panel
	Private pnlBottom As Panel
	Private vBitmap As ImageView
	Private lblText As Label
	Private lstEvent As List
	Type Events (color As Int, eventName As String, date As Long)
	Private hasEvent As Boolean = False
	Private lDate As Long
End Sub

Public Sub Initialize (Callback As Object, EventName As String, width As Int, height As Int)
	mEventName = EventName
	mCallBack = Callback
	mBase.Initialize("mBase")
	lblText.Initialize("")
	lstEvent.Initialize
	vBitmap.Initialize("")
	pnlWrapper.Initialize("nplWrapper")
		
	vBitmap.Gravity = Gravity.CENTER
	mBase.AddView(pnlWrapper, 0,0,width,height)
	
	Dim hBox As Int = pnlWrapper.Height - 10dip
	Dim lText As Int = (pnlWrapper.Width - hBox) / 2
		
	pnlWrapper.AddView(lblText,  lText, 0, hBox, hBox)
	lblText.Text = 15
	lblText.TextColor = Colors.Black
	lblText.Gravity = Gravity.CENTER_HORIZONTAL + Gravity.CENTER_VERTICAL
	
	pnlWrapper.AddView(vBitmap, 0, 0, pnlWrapper.Width, pnlWrapper.Height - 10dip)
	vBitmap.Visible = False
	
	pnlBottom.Initialize("")
	pnlWrapper.AddView(pnlBottom, 0,lblText.Height, pnlWrapper.Width, 10dip)
	'pnlBottom.Color = Colors.Magenta
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
  	Dim clr As Int = xui.PaintOrColorToColor(Props.Get("TextColor")) 'Example of getting a color value from Props
	
End Sub

Public Sub GetView() As View
	Return mBase
End Sub

Sub DrawEventSymbol
	pnlBottom.RemoveAllViews
	
	Dim positionX As Int = 0
	For i=0 To lstEvent.Size - 1
		Dim event As Events = lstEvent.Get(i)
		Dim lbl As Label
		lbl.Initialize("")
		lbl.As(B4XView).SetColorAndBorder(event.color, 0dip, Colors.White, 3dip)
		pnlBottom.AddView(lbl, positionX, 0, 6dip, 6dip)
		positionX = positionX + 8dip
	Next
		
	' Cacula to put center position
	pnlBottom.Width = (5dip * lstEvent.Size) + (3dip * lstEvent.Size)
	pnlBottom.Left= (pnlWrapper.Width - pnlBottom.Width) / 2
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

Public Sub setText(value As String)
	lblText.Text = value	
End Sub

Public Sub getText() As String
	Return lblText.Text
End Sub

Public Sub setDate(value As Long)
	lDate = value
End Sub

Public Sub getDate() As Long
	Return lDate
End Sub

Public Sub AddEvent(color As Int, eventName As String, date As Long)
	Dim event As Events
	event.Initialize
	event.color = color
	event.eventName = eventName
	event.date = date
	lstEvent.Add(event)	
	
	If (getText <> "") Then
		DrawEventSymbol
	End If
	
End Sub

Public Sub setBitMap(bitmap As B4XBitmap)
	vBitmap.Visible = True
	lblText.Visible = False
	vBitmap.Bitmap = bitmap		
End Sub

Public Sub isSelected(value As Boolean)
	If value = True Then
		lblText.As(B4XView).SetColorAndBorder(Colors.ARGB(255,151,94,236), 1dip, Colors.White, 3dip)
		lblText.TextColor = Colors.White
	End If	
End Sub

Sub mBase_Click
	
	lblText.As(B4XView).SetColorAndBorder(Colors.ARGB(255,151,94,236), 1dip, Colors.White, 3dip)
	lblText.TextColor = Colors.White
	Sleep(300)
	lblText.As(B4XView).SetColorAndBorder(Colors.White, 1dip, Colors.White, 3dip)
	lblText.TextColor = Colors.Black
	
	CallSub2(mCallBack, mEventName & "_Click", getDate)
End Sub

