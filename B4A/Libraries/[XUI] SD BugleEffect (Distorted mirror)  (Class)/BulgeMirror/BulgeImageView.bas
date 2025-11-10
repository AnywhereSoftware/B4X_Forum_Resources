B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
#DesignerProperty: Key: Radius, DisplayName: Radius, FieldType: Int, DefaultValue: 60, Description: Radius Effect
#DesignerProperty: Key: Strength, DisplayName: Strength, FieldType: Int, DefaultValue: 10, Description: Strength Effect


'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=BulgeEffect.zip

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private ImageView As B4XView
	Private bmp As B4XBitmap
	Private Can As B4XCanvas
	Private aRadius As Float
	Private aStrength As Float
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
  	
	mBase.Color=xui.Color_Transparent
	aRadius=Props.Get("Radius") * 100dip/100
	aStrength=Props.Get("Strength") * 100dip/100
	
	ImageView=xui.CreatePanel("Pane")
	mBase.AddView(ImageView,0,0,mBase.Width,mBase.Height)
	Can.Initialize(ImageView)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  mBase.Width=Width
  mBase.Height=Height
End Sub

Public Sub setBitmap(B As B4XBitmap)
	bmp = B.Resize(mBase.Width,mBase.Height,True)
	Dim Rect As B4XRect
	Rect.Initialize(0,0,bmp.Width,bmp.Height)
	Can.DrawBitmap(bmp,Rect)
	Can.Invalidate
End Sub

Public Sub getBitmap As B4XBitmap
	Return  bmp
End Sub

Private Sub Pane_Touch (Action As Int, X As Float, Y As Float)
	Dim Rect As B4XRect
	Rect.Initialize(0,0,bmp.Width,bmp.Height)
	
	If Action=1 Then 
		Can.DrawBitmap(bmp,Rect)
	Else
		Dim dx As Float = 1 'bmp.Width / ImageView.Width
		Dim warped As B4XBitmap = ApplyBulgeEffect(bmp, x * dx, y * dx,  aRadius,  aStrength)
		Can.DrawBitmap(warped,Rect)
		'Can.DrawCircle(100,100,10,xui.Color_White,True,1dip)
	End If
	Can.Invalidate
End Sub

Sub ApplyBulgeEffect(Original As B4XBitmap, cx As Float, cy As Float, Radius As Float, Strength As Float) As B4XBitmap
	' strength positivo -> bulge (ingrandisce)
	' strength negativo -> pinch (restringe)
	Dim arg As ARGBColor
	arg.Initialize

	Dim bc As BitmapCreator
	bc.Initialize(Original.Width, Original.Height)
	bc.CopyPixelsFromBitmap(Original)
    
	Dim bcOut As BitmapCreator
	bcOut.Initialize(Original.Width, Original.Height)

	Dim w As Int = bc.mWidth
	Dim h As Int = bc.mHeight
	Dim maxr As Float = Radius

	For y = 0 To h - 1
		For x = 0 To w - 1
			Dim dx As Float = x - cx
			Dim dy As Float = y - cy
			Dim r As Float = Sqrt(dx * dx + dy * dy)
            
			If r < maxr Then
				' Normalizza la distanza (0 al centro, 1 al bordo)
				Dim nr As Float = r / maxr
				' Falloff: puoi cambiare la curva, qui usiamo (1 - nr^2)
				Dim factor As Float = 1 - (nr * nr)
				' Calcola il nuovo raggio deformato
				Dim newr As Float = r + Strength * factor
				' Evita valori negativi
				If newr < 0 Then newr = 0
				' Scala verso la sorgente
				Dim scale As Float = newr / r
				Dim sx As Int = cx + dx * scale
				Dim sy As Int = cy + dy * scale
				If sx >= 0 And sx < w And sy >= 0 And sy < h Then
					bcOut.SetARGB(x, y, bc.GetARGB(sx, sy,arg))
				Else
					arg.a=255
					arg.r=0
					arg.g=0
					arg.b=0
					bcOut.SetARGB(x, y, arg) ' nero fuori dai limiti
				End If
			Else
				bcOut.SetARGB(x, y, bc.GetARGB(x, y,arg))
			End If
		Next
	Next
	
	bcOut.DrawCircle(cx,cy,Radius,xui.Color_ARGB(50,255,255,255),False,2dip)
	
	Return bcOut.Bitmap
End Sub

