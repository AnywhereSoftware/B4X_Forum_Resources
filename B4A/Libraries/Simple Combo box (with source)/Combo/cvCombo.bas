B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'#DesignerProperty: Key: TextSize, DisplayName: Text Box Color, FieldType: Color, DefaultValue: 0xFFFFEBCD,Description: Color of Text in Combo Box
Sub Class_Globals
	Private EventName As String 'ignore
	Private CallBack As Object 'ignore
	Private Act As Activity
	Private mBase As Panel
	Private pnlDummy As Panel
	Private left,top,width,height As Int
	Private pnlLv As Panel
	Private lbDB As Label
	Private imgArrow As ImageView
	Private ActiveTxtBoxBorderColor = 0xFFFFD700 As Int
	Private TxtBoxColor = 0x96202020 As Int
	Private InActiveTxtBoxBorderColor = 0xFF808080 As Int
	Private BorderWidth = 4 As Int
	Private KYB As IME
	Private lv As ListView
End Sub

Public Sub Initialize (Target As Object, Event As String)
	EventName = Event
	CallBack  = Target
	KYB.Initialize("")
	lbDB.Initialize("lbDb")
	
	lbDB.TextColor = Colors.RGB(250,235,215)'Colors.White
	lbDB.TextSize  = 16
	lbDB.Gravity = Gravity.LEFT + Gravity.CENTER_VERTICAL
	imgArrow.Initialize("")
	
	lv.Initialize("lv")
	lv.SingleLineLayout.Label.TextSize = lbDB.TextSize'22/access.GetUserFontScale
	lv.SingleLineLayout.Label.TextColor = Colors.RGB(250,235,215)
	
	Private bd As GradientDrawable
	Private col(2) As Int

	col(0) = Colors.RGB(105,105,105)
	col(1) = Colors.Black
	
	bd.Initialize("TOP_BOTTOM",col)
	lv.Color = TxtBoxColor
	
	pnlDummy.Initialize("pnlDummy")
	pnlDummy.Color  = Colors.Transparent
	pnlDummy.Visible = False
	pnlLv.Initialize("pnlLv")
	pnlLv.Color  = Colors.Transparent
End Sub

Public Sub DesignerCreateView (Base As Panel, Lbl As Label, Props As Map)
	Private CD As ColorDrawable
	CD.Initialize2(TxtBoxColor,7,BorderWidth, InActiveTxtBoxBorderColor)

	mBase 			= Base
	imgArrow.Bitmap = LoadBitmap(File.DirAssets,"arrow-white.png")	
    Base.Background = CD
	Base.AddView(imgArrow,Base.Width-40dip,0,25dip, Base.Height)	
	Base.AddView(lbDB,10dip,0,Base.Width,Base.Height)
	
	Act   = Props.Get("activity")
	Act.AddView(pnlDummy,0,0,100%x,100%y)
	width  = mBase.Width
	height = lv.SingleLineLayout.ItemHeight
	pnlLv.Background = CD
End Sub

Private Sub GetRelativeLeft(v As B4XView) As Int
	Dim res As Int
	Do While v <> Act 
		res = res + v.Left
		v = v.Parent
	Loop
	Return res
End Sub

Private Sub GetRelativeTop(v As B4XView) As Int
	Dim res As Int
	Do While v <> Act 
		res = res + v.Top
		v = v.Parent
	Loop
	Return res
End Sub

Private Sub lbDb_Click
	Private CD As ColorDrawable
	CD.Initialize2(TxtBoxColor,7,BorderWidth, ActiveTxtBoxBorderColor)
	mBase.Background    = CD
	
	left   = GetRelativeLeft(mBase)
	top    = GetRelativeTop(mBase)+mBase.Height
	
	Private LvHeight,LvTop As Int
	LvHeight = (lv.Size)*height
	
	pnlDummy.RemoveAllViews
	pnlLv.RemoveAllViews
	
	LvHeight = (lv.Size)*height
	
	If pnlDummy.Height > LvHeight+top Then
		LvTop = top
	Else
		LvTop = top
		LvHeight = (pnlDummy.Height - top)
	End If	

	pnlDummy.AddView(pnlLv,left,LvTop,width,LvHeight)
	pnlLv.AddView(lv,1dip,1dip,pnlLv.Width,pnlLv.Height)

	pnlDummy.Visible = True
	pnlDummy.RequestFocus
	KYB.HideKeyboard	
End Sub

Private Sub lv_ItemClick (Position As Int, Value As Object)	
	LostFocus
	pnlDummy.Visible = False
	lbDB.Text = Value
	If SubExists(CallBack,EventName.Trim & "_Clicked") Then CallSub(CallBack,EventName.Trim & "_Clicked")
End Sub

Private Sub pnlDummy_Touch (Action As Int, X As Float, Y As Float)
	LostFocus
	pnlDummy.Visible = False	
End Sub

Public Sub AddSingle(Val As String)
	lv.AddSingleLine(Val)
End Sub

Public Sub AddMulti(Val() As String)
	For i = 0 To Val.Length - 1
		lv.AddSingleLine(Val(i))
	Next
End Sub

Public Sub AddTwoLines(Val1 As String,Val2 As String,RetVal As String)
	lv.AddTwoLines2( Val1,Val2,RetVal)
End Sub

Public Sub GetLv As ListView
	Return lv
End Sub

Public Sub GetBase As Panel
	Return mBase
End Sub

Public Sub getText As String
	Return lbDB.Text
End Sub

Public Sub setText(Val As String)
	lbDB.Text = Val
End Sub

Public Sub getTextSize As Float
	Return lbDB.TextSize 
End Sub

Public Sub setTextSize(Val As Float)
	lbDB.TextSize = Val
End Sub

Public Sub getView As Label
	Return lbDB
End Sub

Public Sub SetFocus
	Private CD As ColorDrawable
	CD.Initialize2(TxtBoxColor,7,BorderWidth, Colors.ARGB(255,28,124,238))
	mBase.Background = CD
End Sub

Public Sub LostFocus
	Private CD As ColorDrawable
	CD.Initialize2(TxtBoxColor,7,BorderWidth, InActiveTxtBoxBorderColor)
	mBase.Background = CD
End Sub

Public Sub setVisible(Val As Boolean)
	mBase.Visible = Val
End Sub
