B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=11.8
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	Private xui As XUI
End Sub

Sub Set_ListView_Props(lvMenu As ListView)
	'set the ListView divider to white and zero height
	SetDivider(lvMenu,xui.Color_White,0dip)
	
	'set ListView properties for 2 lines (menu items)
	lvMenu.TwoLinesAndBitmap.Label.Visible = False
	lvMenu.TwoLinesAndBitmap.ImageView.Top = 0dip
	lvMenu.TwoLinesAndBitmap.ItemHeight = 50dip
	lvMenu.TwoLinesAndBitmap.ImageView.Height = 50dip
	lvMenu.TwoLinesAndBitmap.SecondLabel.Height = 50dip
	lvMenu.TwoLinesAndBitmap.SecondLabel.TextSize = 16
	lvMenu.TwoLinesAndBitmap.SecondLabel.TextColor = Colors.DarkGray
	lvMenu.TwoLinesAndBitmap.SecondLabel.Gravity = Gravity.CENTER_VERTICAL
	lvMenu.TwoLinesAndBitmap.SecondLabel.Top = lvMenu.TwoLinesAndBitmap.Label.Top
	
	'set ListView properties for 1 line (group heading)
	lvMenu.SingleLineLayout.Label.Color = Colors.White
	lvMenu.SingleLineLayout.Label.TextColor = 0xFFEC7600
	lvMenu.SingleLineLayout.Label.TextSize = 13
	lvMenu.SingleLineLayout.ItemHeight = 30dip
	lvMenu.SingleLineLayout.Label.Gravity = Gravity.BOTTOM
End Sub

'Create MenuItem with: type, icon, title
Sub CreateMenuItem(ty As Int, ic As Int, ti As String) As MenuItem
	Dim mi As MenuItem
	mi.Initialize
	mi.mtype = ty
	mi.micon = ic
	mi.mtitle = ti
	Return mi
End Sub

Sub SetDivider(LV As ListView, Color As Int, Height As Int)
	Dim Ref As Reflector
	Ref.Target = LV
	Dim CD As ColorDrawable
	CD.Initialize(Color, 0)
	Ref.RunMethod4("setDivider", Array As Object(CD), Array As String("android.graphics.drawable.Drawable"))
	Ref.RunMethod2("setDividerHeight", Height, "java.lang.int")
End Sub

Sub FontAwesomeToBitmap(Text As String, FontSize As Float, FontColor As Int) As B4XBitmap 'Ignore
	Dim xui As XUI
	Dim P As Panel = xui.CreatePanel("")
	P.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)
	Dim CVS1 As B4XCanvas
	CVS1.Initialize(p)
	Dim Fnt As B4XFont = xui.CreateFont(Typeface.FONTAWESOME, FontSize)
	Dim R As B4XRect = CVS1.MeasureText(Text, Fnt)
	Dim BaseLine As Int = CVS1.TargetRect.CenterY - r.Height / 2 - r.Top
	CVS1.DrawText(Text, CVS1.TargetRect.CenterX, BaseLine, Fnt, FontColor, "CENTER")
	Dim B As B4XBitmap = CVS1.CreateBitmap
	CVS1.Release
	Return B
End Sub