B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.2
@EndOfDesignText@
'Requires Phone and Reflection on Android to support SetFallbackLineSpacing

#DesignerProperty: Key: TextColor, DisplayName: Name Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Text Colour
#DesignerProperty: Key: BackColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Background Color

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private tclr As Int
	Private bclr As Int
	Private mcorn As Int
	Private txt As Object
	Private tfnt As B4XFont

	Private lpad As Int
	Private rpad As Int
	Private tpad As Int
	Private bpad As Int

	Private mlbl As B4XView
	
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
	mBase.Color = Colors.Transparent
	
	tclr = xui.PaintOrColorToColor(Props.Get("TextColor"))
	bclr = xui.PaintOrColorToColor(Props.Get("BackColor"))
	#if b4a
	tfnt = xui.CreateFont(lbl.Typeface,lbl.textsize)
	#else	
	tfnt = lbl.Font
	#End If

	txt  = ""
	
	lpad = 10dip
	rpad = 10dip
	tpad = 10dip
	bpad = 10dip
	mcorn = 0
	
	Private llbl As Label
	
	llbl.Initialize("lbl")
	#if b4i
	llbl.Multiline = True
	#end if	
	mlbl = llbl
	
	mBase.AddView(mlbl,lpad,tpad,mBase.Width-(lpad+rpad),mBase.Height-(tpad+bpad))
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	mlbl.SetLayoutAnimated(0,lpad,tpad,mBase.Width-(lpad+rpad),mBase.Height-(tpad+bpad))
	draw
End Sub


'On certain phones StringUtils.MeasureMultilineTextHeight does not correctly calculate the height
'See https://www.b4x.com/android/forum/threads/non-english-characters-and-measuremultilinetextheight-in-api28.118643/#post-802771
Public Sub setFallbackLineSpacing(status As Boolean)
	#if B4a
	Dim P As Phone
	If P.SdkVersion >= 28 Then
		Dim Ref As Reflector
		Ref.Target = mlbl.As(Label)
		If (status) Then
			Ref.RunMethod2("setFallbackLineSpacing","True","java.lang.boolean")
		Else
			Ref.RunMethod2("setFallbackLineSpacing","False","java.lang.boolean")
		End If	
	End If
	#end if
End Sub



public Sub setText(t As Object)
	txt = t
	draw
End Sub

public Sub setTextColor(clr As Int)
	tclr = clr
	draw
End Sub

public Sub SetBackColor(clr As Int)
	bclr = clr
	draw
End Sub


public Sub SetTextFont(fnt As B4XFont)
	tfnt = fnt
	draw
End Sub

public Sub SetPadding(l As Int, t As Int, r As Int, b As Int)
	lpad = l
	tpad = t
	rpad = r
	bpad = b
	draw
End Sub

public Sub SetCorners(c As Int)
	mcorn = c
	draw
End Sub

public Sub GetHeight As Int
	Return GetPerfectHeight
End Sub


private Sub draw
	If (mBase.IsInitialized And mlbl.IsInitialized) Then
		mBase.SetColorAndBorder(bclr,0dip,Colors.Transparent,mcorn)
		
		mlbl.Font = tfnt
		
		mBase.SetLayoutAnimated(0,0,0,mBase.Width,GetPerfectHeight)
		mlbl.SetLayoutAnimated(0,lpad,tpad,mBase.Width-(lpad+rpad),mBase.Height-(tpad+bpad))
	
		mlbl.TextColor = tclr
		mlbl.Color = bclr
	
		XUIViewsUtils.SetTextOrCSBuilderToLabel(mlbl,txt)
		
	End If
End Sub


#Region multiline DrawText
public Sub GetPerfectHeight As Int
	
	If mlbl.IsInitialized Then
		mlbl.Font = tfnt
		
		Private h As Int = (MeasureMultiTextHeight(mlbl, mBase.Width-(lpad+rpad), txt) + tpad + bpad)
'		Log("perfect height = "&h)
		Return h
	End If
'	Log("imperfect height = "&mBase.Height)
	Return mBase.Height
End Sub

Public Sub MeasureMultiTextHeight(lbl As Label, width As Int, text As Object) As Int
	#if b4a
	Private su As StringUtils
	Return su.MeasureMultilineTextHeight(lbl, text)
	#else if b4i
	Dim plbl As Label
	plbl.Initialize("")
	plbl.Width = width
	plbl.Multiline = True
	XUIViewsUtils.SetTextOrCSBuilderToLabel(plbl,text)
	plbl.SizeToFit	
	Return plbl.Height
	#End If
	
End Sub

#End Region
