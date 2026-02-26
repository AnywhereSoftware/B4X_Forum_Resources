B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
#DesignerProperty: Key: BooleanExample, DisplayName: Show Seconds, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color
'https://github.com/AviranAbady/CookieBar2
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As Panel
	Private xui As XUI 'ignore
	Public Tag As Object

	Public TYPE_SUCCESS As Int = 0
	Public TYPE_WARNING As Int = 1
	Public TYPE_INFO As Int = 2
	Public TYPE_ERROR As Int = 3
	Private imvIcon As ImageView
	Private lblContent As Label		
	Private fontsize As Int = 12
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String, ParentView As Panel)
	mEventName = EventName
	mCallBack = Callback
	mBase.Initialize("mBase")
	imvIcon.Initialize("")
	lblContent.Initialize("")
	lblContent.TextSize = fontsize
	ParentView.AddView(mBase, 0, 70%y, 60%x, 30dip)
	mBase.AddView(imvIcon, 5dip, 5dip, 30dip, 30dip)
	mBase.AddView(lblContent, 45dip, 5dip, mBase.Width - imvIcon.Width, mBase.Height)
	
	lblContent.Gravity = Gravity.CENTER_VERTICAL 
	lblContent.TextColor = Colors.White
	
	mBase.Elevation = 3dip
	mBase.As(B4XView).SetColorAndBorder(Colors.ARGB(255,56,142,60), 0dip, Colors.White, 8dip)
	mBase.Visible = False
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
  	Dim clr As Int = xui.PaintOrColorToColor(Props.Get("TextColor")) 'Example of getting a color value from Props
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

Public Sub MakeText(Text As String, ToastType As Int)
	
	Dim s_label As Int = getNewSize(Text)
	Dim m_size As Int = 70%x
	If s_label > m_size Then
		mBase.Width = m_size
		mBase.Height = 42dip
		lblContent.Top = 5dip
		imvIcon.Top = 6dip
	Else 
		mBase.Width = s_label + 50dip
		mBase.Height = 30dip
		imvIcon.Height = 25dip
		imvIcon.Width = 25dip
		imvIcon.Top = 3dip
		lblContent.Top = 0dip
		lblContent.Left = 35dip
	End If
	
	mBase.Left = (100%x - mBase.Width) / 2
	
	lblContent.Text = Text
	
	If ToastType = TYPE_SUCCESS Then ' TYPE_SUCCESS
		mBase.Color = Colors.ARGB(255, 102, 188, 106)
		imvIcon.Bitmap = LoadBitmap(File.DirAssets, "success.png")
	else if ToastType = TYPE_WARNING Then 'TYPE_WARNING
		mBase.Color = Colors.ARGB(255, 255, 168, 33)
		imvIcon.Bitmap = LoadBitmap(File.DirAssets, "waring.png")
	else if ToastType = TYPE_INFO Then
		mBase.Color = Colors.ARGB(255, 36, 186, 246)
		imvIcon.Bitmap = LoadBitmap(File.DirAssets, "info.png")
	else if ToastType = TYPE_ERROR Then
		mBase.Color = Colors.ARGB(255, 239, 82, 79)
		imvIcon.Bitmap = LoadBitmap(File.DirAssets, "error.png")
	End If
	
	mBase.Visible = False	
End Sub

Public Sub Show(Duration As Int)
	mBase.Visible = True
	Dim anim As Animation		
	anim.InitializeAlpha("", 0, 1)
	
	mBase.Visible = True
	
	anim.Duration = Duration
	anim.Start(mBase)
	
	Sleep(2000)
	anim.InitializeAlpha("", 1, 0)			
	anim.Duration = Duration
	anim.Start(mBase)
	mBase.Visible = False
End Sub

private Sub getNewSize(value As String) As Int
	Dim cvs1 As B4XCanvas
	cvs1.Initialize(imvIcon)
	Dim fnt As B4XFont = xui.CreateFont(Typeface.DEFAULT, fontsize)
	Dim r As B4XRect = cvs1.MeasureText(value, fnt)
	
	Return r.Width
End Sub