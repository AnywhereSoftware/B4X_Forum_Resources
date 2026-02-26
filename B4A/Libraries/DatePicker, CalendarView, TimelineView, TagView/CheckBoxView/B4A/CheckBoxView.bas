B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
#Event: CheckedChange(Checked As Boolean)
#DesignerProperty: Key: BooleanExample, DisplayName: Show Seconds, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color
#DesignerProperty: Key: BorderColor, DisplayName: BorderColor, FieldType: Color, DefaultValue: 0xFF6253F7, Description: Border color

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private imvCheckbox As Label
	Private icoCheck As B4XBitmap
	Private lblText As Label
	Private isSelected As Boolean = False
	Private clrBorder As Int = Colors.ARGB(255, 98,83,247)
	Private mTextColor As Int = Colors.Black
	Private mDisabled As Boolean = False
	Private mHistoryColor As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	Dim clrText As Int = xui.PaintOrColorToColor(Props.Get("TextColor"))
				
	mBase.Color = Colors.Transparent
	
	imvCheckbox.Initialize("imvCheckbox")
	mBase.AddView(imvCheckbox, 0, 0, 20dip, 20dip)
	icoCheck = LoadBitmapResize(File.DirAssets, "check.png", 30dip, 30dip, True)
	
	lblText.Initialize("")
	mBase.AddView(lblText, 25dip, 0, mBase.Width - 25dip, 20dip)
	lblText.Text = "Checkbox 1"
	lblText.TextColor = mTextColor
	
	DrawCheckbox(False)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

Private Sub DrawCheckbox(value As Boolean)
	Dim bm As BitmapCreator
	bm.Initialize(16dip, 16dip)
	
	If value = True Then
		bm.DrawRectRounded(bm.TargetRect, clrBorder, True, 2dip, 4dip)
		bm.DrawBitmap(icoCheck, bm.TargetRect, False)
	Else
		bm.DrawRectRounded(bm.TargetRect, clrBorder, False, 2dip, 4dip)
		
	End If
	lblText.TextColor = mTextColor
	imvCheckbox.SetBackgroundImage(bm.Bitmap)
End Sub

Sub imvCheckbox_Click
	If isSelected = True Then
		isSelected = False
	Else
		isSelected = True
	End If
	
	If mDisabled = False Then
		DrawCheckbox(isSelected)
		CallSub2(mCallBack, mEventName & "_CheckedChange", isSelected)
	End If
	
End Sub

Public Sub setChecked(value As Boolean)
	isSelected = True
	DrawCheckbox(isSelected)
End Sub

Public Sub getChecked() As Boolean
	Return isSelected
End Sub

Public Sub setDisabled(value As Boolean)
	mDisabled = value
	If mDisabled = True Then
		mHistoryColor = clrBorder
		clrBorder = Colors.ARGB(255, 204, 204, 204)
		mTextColor = Colors.ARGB(255, 204, 204, 204)
	Else
		clrBorder = mHistoryColor
		lblText.TextColor = mTextColor
	End If
	DrawCheckbox(isSelected)
End Sub

Public Sub getDisabled() As Boolean
	Return mDisabled
End Sub

Public Sub TextColor(value As Int) As Boolean
	lblText.TextColor = value
End Sub

Public Sub Color(value As Int)
	clrBorder = value
	DrawCheckbox(isSelected)
End Sub

Public Sub setText(value As String)
	lblText.Text = value
End Sub

Public Sub getText(value As String)
	Return lblText.Text
End Sub

Public Sub TextSize(value As Int)
	lblText.TextSize = value
End Sub
