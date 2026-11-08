B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Private CallBack As Object
	Private EventName As String
	Private Overlay As B4XView
	Private xui As XUI
	Private pnlBottom As B4XView
	Private OverlayVisible As Boolean
	Private posicion,filas,iconsize,textsize,ancho_boton,alto_boton,grid_columnas,limitestring As Int
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(vActivity As Activity, vCallback As Object, vEventName As String)
	CallBack = vCallback
	EventName = vEventName
	
	Overlay = xui.CreatePanel("overlay")
	Overlay.Visible = False
	Dim p As Panel = Overlay
	p.Elevation = 10dip
	vActivity.AddView(Overlay, 0, 0, 100%x, 100%y)
	Overlay.LoadLayout("Overlay")

	Dim C As Canvas
	C.Initialize(vActivity)
	Dim x As String
	x = Round((c.MeasureStringHeight("X,_", Typeface.SANS_SERIF, 10)/10+0.15)/0.25)*0.25
	Log("x:" & X)
	If x <= 2.25  Then
		iconsize = 50dip
		textsize = 14
		limitestring = 11
	Else If x <= 2.50  Then
		iconsize = 45dip
		textsize = 13
		limitestring = 11
	Else If x <= 3  Then
		iconsize = 45dip
		textsize = 11
		limitestring = 11
	Else If x <= 3.25  Then
		iconsize = 40dip
		textsize = 10
		limitestring = 11
	Else If x <= 3.75  Then
		iconsize = 35dip
		textsize = 10
		limitestring = 10
	Else If x <= 4.25  Then
		iconsize = 32dip
		textsize = 9
		limitestring = 10
	Else If x <= 5.25  Then
		iconsize = 28dip
		textsize = 8
		limitestring = 9
	Else
		iconsize = 40dip
		textsize = 10
		limitestring = 11
	End If
	
	'Log(100%x/3)
	'si dividiendo el 100%x entre 3 botones tiene un ancho superior a 300 pone 5 columnas
	If (100%x/3) < 240dip Then
		grid_columnas = 3
	Else if (100%x/4) < 240dip Then
		grid_columnas = 4
	Else if (100%x/5) < 240dip Then
		grid_columnas = 5
	Else
		grid_columnas = 3
	End If
	
	filas=0
	posicion=0
	ancho_boton = (100%x)/grid_columnas
	alto_boton = (100%x)/grid_columnas - (iconsize+(textsize)) '((iconsize-1dip)) '(iconsize-textsize)
End Sub
Public Sub addItem(id As Int, title As String, iconochar As Char)
	title=title.ToUpperCase
	title=recortastring(title, limitestring, True)
	
	Dim icon As B4XBitmap = FontAwesomeToBitmapColor(iconochar)
	
	posicion = posicion + 1
	Dim x As Int = (posicion - 1) Mod grid_columnas * ancho_boton
	Dim y As Int = Floor((posicion - 1) / grid_columnas) * alto_boton
    
	Dim btn As Button
	btn.Initialize("btn")
	RemoveShadow(btn)
	btn = ripplebutton(btn,Colors.White,Colors.LightGray)
	btn.Text = title.ToUpperCase
	btn.TextColor = Colors.ARGB(170,0,0,0)
	btn.TextSize=textsize
	'btn.Padding = Array As Int (20dip+iconsize+10dip, 0dip, 0dip, 0dip)
	btn.Gravity=Bit.Or(Gravity.CENTER_HORIZONTAL,Gravity.BOTTOM)
	btn.Tag=id
	pnlBottom.AddView(btn,x,y,ancho_boton,alto_boton)

	Dim iv As Panel
	iv.Initialize("")
	pnlBottom.AddView(iv,x+(ancho_boton/2)-(iconsize/2), y+(((btn.Height/2)-iconsize/2))-textsize*1dip,iconsize, iconsize)
	iv.SetBackgroundImage(icon.Resize(iconsize, iconsize, True))
	iv.Elevation=10dip
End Sub
public Sub show
	filas = (Floor((posicion - 1) / grid_columnas))+1
	pnlBottom.Height=(alto_boton*(filas))+20dip
	pnlBottom.SetColorAndBorder(xui.Color_White, 0, 0, 2dip)
	ToggleDrawerState
End Sub

Sub btn_Click
	ToggleDrawerState
	If SubExists(CallBack, EventName & "_BottomSheetItemClick") Then
		Dim btn As Button = Sender
		CallSub2(CallBack, EventName & "_BottomSheetItemClick", btn.tag)
	End If
End Sub
Sub Overlay_Click
	If OverlayVisible = False Then Return
	ToggleDrawerState
	If SubExists(CallBack, EventName & "_BottomSheetItemClick") Then
		CallSub2(CallBack, EventName & "_BottomSheetItemClick", 0)
	End If
End Sub

Sub RemoveShadow(Button1 As Button)
	Dim sdk As Phone
	If sdk.SdkVersion < 21 Then Return
	Dim jo As JavaObject
	jo = Button1
	jo.RunMethod("setStateListAnimator", Array(Null))
End Sub

public Sub ToggleDrawerState
	Dim Duration As Int = 150
	OverlayVisible = Not(OverlayVisible)
	Overlay.SetVisibleAnimated(Duration, OverlayVisible)
	Dim pnlBottomVisibleHeight As Int = pnlBottom.Height - 8dip 'hide bottom round corners
	If OverlayVisible Then
		pnlBottom.SetLayoutAnimated(0, 0, pnlBottom.Parent.Height, pnlBottom.Width, pnlBottom.Height)
		pnlBottom.SetLayoutAnimated(Duration, 0, pnlBottom.Parent.Height - pnlBottomVisibleHeight, pnlBottom.Width, pnlBottom.Height)
	Else
		pnlBottom.SetLayoutAnimated(0, 0, pnlBottom.Parent.Height - pnlBottomVisibleHeight, pnlBottom.Width, pnlBottom.Height)
		pnlBottom.SetLayoutAnimated(Duration, 0, pnlBottom.Parent.Height, pnlBottom.Width, pnlBottom.Height)
	End If
End Sub

public Sub checkoverlayvisible As Boolean
	Return OverlayVisible
End Sub

public Sub ripplebutton(btn As Button, backcolor As Int, presscolor As Int) As Button
	Dim sdk As Phone
	If sdk.SdkVersion < 21 Then
		'Android version < 5.0 Lollipop -> StateListDrawable
		Dim PressedCD As ColorDrawable
		PressedCD.Initialize(presscolor, 0)
		Dim DefaultCD As ColorDrawable
		DefaultCD.Initialize(Colors.Transparent, 0)
		Dim bStateList As StateListDrawable
		bStateList.Initialize
		bStateList.AddState(bStateList.State_Pressed, PressedCD)
		bStateList.AddCatchAllState(DefaultCD)
		btn.Background = bStateList
	Else
		'Android version >= 5.0 Lollipop -> RippleDrawable
		Dim bRipple As RippleDrawable
		bRipple.Initialize(backcolor, presscolor)
		btn.Background = bRipple.Drawable
	End If
	Return btn
End Sub

Sub FontAwesomeToBitmapColor(iconochar As Char) As B4XBitmap
	Dim coloricon As Int = Colors.rgb(0,155,184)
	
	Dim xui As XUI
	Dim p As Panel = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)
	Dim cvs1 As B4XCanvas
	cvs1.Initialize(p)
	
	Dim FontSize As Float
	Dim typeface1 As Typeface
	FontSize = 25
	typeface1 = Typeface.MATERIALICONS

	Dim fnt As B4XFont = xui.CreateFont(typeface1, FontSize)
	Dim r As B4XRect = cvs1.MeasureText(iconochar, fnt)
	Dim BaseLine As Int = cvs1.TargetRect.CenterY - r.Height / 2 - r.Top
	cvs1.DrawText(iconochar, cvs1.TargetRect.CenterX, BaseLine, fnt, coloricon, "CENTER")
	Dim b As B4XBitmap = cvs1.CreateBitmap
	cvs1.Release
	Return b
End Sub
public Sub recortastring(txt As String, longitud As Int, muestrapuntos As Boolean) As String
	If txt="" Or txt.Length=0 Then Return ""
	
	If txt.Length<=longitud Then
		Return txt
	Else
		If txt.Length<=longitud Or longitud<=3 Then
			Return txt.SubString2(0, longitud)
		Else
			If muestrapuntos Then
				Return txt.SubString2(0, longitud-3) & "..."
			Else
				Return txt.SubString2(0, longitud-3)
			End If
		End If
	End If
End Sub