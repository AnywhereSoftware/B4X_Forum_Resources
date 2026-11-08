B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
Sub Class_Globals
	Private pnlParent As B4XView
	Private xui As XUI
	Private cv As B4XCanvas
	Private root As B4XView
	Private IsBALayout As Boolean
	Private DefaultBorderColor As Int = Colors.Gray
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
End Sub

Public Sub SetGlassProprety(Rootpanel As B4XView, view As B4XView, BorderCorner As Int)
	pnlParent = view
	root = Rootpanel
	IsBALayout = GetType(view) = "anywheresoftware.b4a.BALayout" Or GetType(view) = "B4IPanelView"
	
	cv.Initialize(pnlParent)
	cv.DrawBitmap(Blur(root.Snapshot.Crop(pnlParent.Left, pnlParent.Top, pnlParent.Width, pnlParent.Height)), cv.TargetRect)
	cv.Invalidate

	If IsBALayout Then
		DrawBorder(BorderCorner, 2dip)

		For i = 0 To pnlParent.NumberOfViews - 1
			Dim view As B4XView = pnlParent.GetView(i)
			pnlParent.GetView(i).SetColorAndBorder(0x41FFFFFF, 1dip, DefaultBorderColor, BorderCorner)
		Next
	Else
		DrawBorder(BorderCorner, 1dip)
	End If
End Sub

Private Sub DrawBorder(BorderCorner As Int, BorderWidth As Int)
	Dim path As B4XPath
	path.InitializeRoundedRect(cv.TargetRect, BorderCorner)
	cv.ClipPath(path)
	cv.DrawPath(path, DefaultBorderColor, False, BorderWidth)
	cv.Invalidate
End Sub

Public Sub setBorderColor(Value As Int)
	DefaultBorderColor = Value
End Sub

Public Sub getBorderColor As Int
	Return DefaultBorderColor
End Sub

private Sub Blur (bmp As B4XBitmap) As B4XBitmap
	'Dim n As Long = DateTime.Now
	Dim bc As BitmapCreator
	Dim ReduceScale As Int = 2
	bc.Initialize(bmp.Width / ReduceScale / bmp.Scale, bmp.Height / ReduceScale / bmp.Scale)
	bc.CopyPixelsFromBitmap(bmp)
	Dim count As Int = 3
	Dim clrs(3) As ARGBColor
	Dim temp As ARGBColor
	Dim m As Int
	For steps = 1 To count
		For y = 0 To bc.mHeight - 1
			For x = 0 To 2
				bc.GetARGB(x, y, clrs(x))
			Next
			SetAvg(bc, 1, y, clrs, temp)
			m = 0
			For x = 2 To bc.mWidth - 2
				bc.GetARGB(x + 1, y, clrs(m))
				m = (m + 1) Mod clrs.Length
				SetAvg(bc, x, y, clrs, temp)
			Next
		Next
		For x = 0 To bc.mWidth - 1
			For y = 0 To 2
				bc.GetARGB(x, y, clrs(y))
			Next
			SetAvg(bc, x, 1, clrs, temp)
			m = 0
			For y = 2 To bc.mHeight - 2
				bc.GetARGB(x, y + 1, clrs(m))
				m = (m + 1) Mod clrs.Length
				SetAvg(bc, x, y, clrs, temp)
			Next
		Next
	Next
	'Log(DateTime.Now - n)
	Return bc.Bitmap
End Sub

Private Sub SetAvg(bc As BitmapCreator, x As Int, y As Int, clrs() As ARGBColor, temp As ARGBColor)
	temp.Initialize
	For Each c As ARGBColor In clrs
		temp.r = temp.r + c.r
		temp.g = temp.g + c.g
		temp.b = temp.b + c.b
	Next
	temp.a = 255
	temp.r = temp.r / clrs.Length
	temp.g = temp.g / clrs.Length
	temp.b = temp.b / clrs.Length
	bc.SetARGB(x, y, temp)
End Sub