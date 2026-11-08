B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
#DesignerProperty: Key: BooleanExample, DisplayName: Show Seconds, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As Panel
	Private xui As XUI 'ignore
	Public Tag As Object
	Private pnlWrapper As Panel
	Private imvLine As ImageView
	Private imvTop As ImageView
	Private pnlContent As Panel
	Private lineWidth As Int = 2dip
	Private lblTitle As Label
	Private lblContent As Label
	Private lblTime As Label
	Private pnlButtonGroup As Panel
End Sub

Public Sub Initialize (Callback As Object, EventName As String, width As Int, height As Int)
	mEventName = EventName
	mCallBack = Callback
	mBase.Initialize("mBase")
	pnlWrapper.Initialize("")
	
	imvLine.Initialize("")
	imvTop.Initialize("")
	
	mBase.AddView(imvTop, 0dip,0dip,20dip,20dip)
	mBase.AddView(imvLine, 10dip, 20dip,lineWidth,height)
	imvTop.Color = Colors.Magenta
	imvLine.Color = Colors.Red
	'pnlWrapper.Color = Colors.Gray
	Dim bRunning As B4XBitmap=LoadBitmapResize(File.DirAssets,"running.png", 15dip, 15dip, True)
	imvTop.Bitmap = bRunning

	pnlContent.Initialize("")
	mBase.AddView(pnlContent, 20dip, 20dip, width - 30dip,height - 30dip)
	pnlContent.Color = Colors.Gray
	
	'pnlContent.As(B4XView).SetColorAndBorder(Colors.ARGB(255,235, 244, 246), 0dip, Colors.White, 8dip)

	pnlContent.LoadLayout("timeline_item")
		
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
  	Dim clr As Int = xui.PaintOrColorToColor(Props.Get("TextColor")) 'Example of getting a color value from Props
End Sub

Public Sub setColor(value As Int)
	'pnlContent.Color = value
	pnlContent.As(B4XView).SetColorAndBorder(value, 0dip, Colors.White, 8dip)
End Sub

Public Sub setTitle(value As String)
	lblTitle.Text = value
End Sub

Public Sub setDescription(value As String)
	lblContent.Text = value
End Sub

Public Sub setTime(value As String)
	lblTime.Text = value
End Sub

Public Sub setLineColor(color As Int)
	imvLine.Color = color
End Sub

Public Sub setLineWidth(value As Int)
	lineWidth = value
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

Public Sub GetView() As Panel
	Return mBase
End Sub

Public Sub LoadLayout(LayoutFile As String)
	'pnlContent.LoadLayout(LayoutFile)	
End Sub

Public Sub setBitmap(value As Bitmap)
	imvTop.Bitmap = value
End Sub

Public Sub HideButton()
	pnlButtonGroup.Visible = False
End Sub