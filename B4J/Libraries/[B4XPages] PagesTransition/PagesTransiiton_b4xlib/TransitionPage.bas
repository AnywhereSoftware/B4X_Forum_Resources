B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	
	Private F_bmp, T_bmp As B4XBitmap
	Private Tpage As B4XView
	
	Private can As B4XCanvas
	Private Pn As B4XView
	
	' Timeline
	Private Pause As Int = 20
	
	' Luquid
	Private Point() As Map
	Private LR As Int = 0  ' Left Draw Onda (incremental)
	' Batman
	Private BatManStep As Int = 16
	Private MaxDot As Int = 160
	Private DivDot As Float = 5
			
	Public const AnimationStrip As Int = 1
	Public const AnimationColumn As Int = 2
	Public const AnimationCircleExplode As Int = 3
	Public const AnimationCircleImplode As Int = 4
	Public const AnimationZoom As Int = 5
	Public const AnimationRotaded As Int = 6
	Public const AnimationSpotted As Int = 7
	Public const SlideFromLeft As Int = 8
	Public const SlideFromTop As Int = 9
	Public const SlideFromRight As Int = 10
	Public const SlideFromBottom As Int = 11
	Public const AnimationLiquidUp As Int = 12
	Public const AnimationLiquidDown As Int = 13
	Public const AnimationBatMan As Int = 14
	Public const ShoveFromLeft As Int = 15
	Public const ShoveFromTop As Int = 16
	Public const ShoveFromRight As Int = 17
	Public const ShoveFromBottom As Int = 18
	Public const AnimationGuillotine As Int = 19
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(FromPageRoot As B4XView, ToPageRoot As B4XView)
	Tpage=ToPageRoot
	F_bmp=FromPageRoot.Snapshot
	
	Pn=xui.CreatePanel("Pn")
	Pn.SetLayoutAnimated(0,0,0,FromPageRoot.Width,FromPageRoot.Height)
	#if b4a
	Pn.As(Panel).Elevation=3dip
	#End If
	
	can.Initialize(Pn)
	can.DrawBitmap(F_bmp,can.TargetRect)
	can.Invalidate
End Sub

Private Sub Pn_Touch (Action As Int, X As Float, Y As Float)
	
End Sub

Public Sub Transition(Animation As Int, Durate As Int)
	Sleep(Pause)
	T_bmp=Tpage.Snapshot
	Tpage.AddView(Pn,0,0,Pn.Width,Pn.Height)
	
	' start animation
	Select Animation
		Case AnimationStrip
			Dim N As Int = 10
			Dim Strip As Int = can.TargetRect.Height/n
			Dim statend As Long = DateTime.Now + Durate
			Dim MaxMove As Int = 20
			
			Dim Left As Int = -can.TargetRect.Width
			Dim Left2 As Int = can.TargetRect.Width
			Dim LeftStep As Int = can.TargetRect.Width/MaxMove
			
			Dim drt As Int =Durate/MaxMove
			Do While DateTime.Now<=statend
				Dim T As Long = DateTime.Now
				Dim B As Boolean = True
				For i=0 To N-1
					Dim rec As B4XRect
					If B Then rec.Initialize(Left,i*Strip,Left+can.TargetRect.Width,(i+1)*Strip) Else rec.Initialize(Left2,i*Strip,Left2+can.TargetRect.Width,(i+1)*Strip)
					Dim bmp As B4XBitmap = T_bmp.Crop(0,i*Strip,can.TargetRect.Width,Strip)
					can.DrawBitmap(bmp,rec)
					B=Not(B)
				Next
				can.Invalidate
				Left=Min(Left+LeftStep,0)
				Left2=Max(Left2-LeftStep,0)
				Sleep(drt-(DateTime.Now-T))
			Loop
		
		Case AnimationColumn
			Dim N As Int = 10
			Dim Col As Int = can.TargetRect.Width/n
			Dim statend As Long = DateTime.Now + Durate
			Dim MaxMove As Int = 20
			
			Dim Top As Int = -can.TargetRect.Height
			Dim Top2 As Int = can.TargetRect.Height
			Dim TopStep As Int = can.TargetRect.Height/MaxMove
			
			Dim drt As Int =Durate/MaxMove
			Do While DateTime.Now<=statend
				Dim T As Long = DateTime.Now
				Dim B As Boolean = True
				For i=0 To N-1
					Dim rec As B4XRect
					If B Then rec.Initialize(i*Col,Top,(i+1)*Col,Top+can.TargetRect.Height)	Else rec.Initialize(i*Col,Top2,(i+1)*Col,Top2+can.TargetRect.Height)
						
					Dim bmp As B4XBitmap = T_bmp.Crop(i*Col,0,Col,can.TargetRect.Height)
					can.DrawBitmap(bmp,rec)
					B=Not(B)
				Next
				can.Invalidate
				Top=Min(Top+TopStep,0)
				Top2=Max(Top2-TopStep,0)
				Sleep(drt-(DateTime.Now-T))
			Loop
		
		Case AnimationCircleExplode
			Dim statend As Long = DateTime.Now + Durate
			Dim MaxMove As Int = 20

			Dim MaxPath As Int = Max(can.TargetRect.Height,can.TargetRect.Width)/2
			Dim StepPath As Int = MaxPath/MaxMove
			Dim ProgrPath As Int = StepPath
			Do While DateTime.Now<=statend
				Dim rec As B4XRect
				rec.Initialize(can.TargetRect.CenterX-ProgrPath,can.TargetRect.Centery-ProgrPath,can.TargetRect.CenterX+ProgrPath,can.TargetRect.Centery+ProgrPath)
				Dim oval As B4XPath
				oval.InitializeOval(rec)
				can.ClipPath(oval)
				can.DrawBitmap(T_bmp,can.TargetRect)
				can.Invalidate
				can.RemoveClip

				ProgrPath=ProgrPath+StepPath		
				Sleep((Durate/MaxMove)-5)
			Loop
			
		Case AnimationCircleImplode
			Dim statend As Long = DateTime.Now + Durate
			Dim MaxMove As Int = 20
						
			Dim MaxPath As Int = Max(can.TargetRect.Height,can.TargetRect.Width)/2
			Dim StepPath As Int = MaxPath/MaxMove
			Dim ProgrPath As Int = MaxPath
			Do While DateTime.Now<=statend
				Dim rec As B4XRect
				rec.Initialize(can.TargetRect.CenterX-ProgrPath,can.TargetRect.Centery-ProgrPath,can.TargetRect.CenterX+ProgrPath,can.TargetRect.Centery+ProgrPath)
				Dim oval As B4XPath
				oval.InitializeOval(rec)
				can.DrawBitmap(T_bmp,can.TargetRect)
				can.ClipPath(oval)
				can.DrawBitmap(F_bmp,can.TargetRect)
				can.Invalidate
				can.RemoveClip

				ProgrPath=ProgrPath-StepPath
				Sleep((Durate/MaxMove)-5)
			Loop
		Case AnimationZoom
			Dim statend As Long = DateTime.Now + Durate
			Dim MaxMove As Int = 20

			Dim MaxPath As Int = Max(can.TargetRect.Height,can.TargetRect.Width)/2
			Dim StepPath As Int = MaxPath/MaxMove
			Dim ProgrPath As Int = StepPath			
			Do While DateTime.Now<=statend
				Dim rec As B4XRect
				rec.Initialize(can.TargetRect.CenterX-ProgrPath,can.TargetRect.Centery-ProgrPath,can.TargetRect.CenterX+ProgrPath,can.TargetRect.Centery+ProgrPath)
				
				can.DrawBitmap(F_bmp,can.TargetRect)
				can.DrawBitmap(T_bmp,rec)
				can.Invalidate

				ProgrPath=ProgrPath+StepPath
				Sleep((Durate/MaxMove)-5)
			Loop
		Case AnimationRotaded
			Dim statend As Long = DateTime.Now + Durate
			Dim MaxMove As Int = 20

			Dim MaxPath As Int = Max(can.TargetRect.Height,can.TargetRect.Width)/2
			Dim StepPath As Int = MaxPath/MaxMove
			Dim ProgrPath As Int = StepPath
			Dim Degree As Int = 360/MaxMove
			Do While DateTime.Now<=statend
				Dim rec As B4XRect
				rec.Initialize(can.TargetRect.CenterX-ProgrPath,can.TargetRect.Centery-ProgrPath,can.TargetRect.CenterX+ProgrPath,can.TargetRect.Centery+ProgrPath)
				
				can.DrawBitmap(F_bmp,can.TargetRect)
				can.DrawBitmapRotated(T_bmp,rec,Degree)
				can.Invalidate

				ProgrPath=ProgrPath+StepPath
				Degree=Degree+360/MaxMove
				Sleep((Durate/MaxMove)-5)
			Loop
		Case AnimationSpotted
			Dim statend As Long = DateTime.Now + Durate
			Dim MaxMove As Int = 20

			Dim MaxPath As Int = Max(can.TargetRect.Height,can.TargetRect.Width)/2
			Dim StepPath As Int = MaxPath/MaxMove
			Dim ProgrPath As Int = StepPath
			Do While DateTime.Now<=statend
				Dim rec As B4XRect
				rec.Initialize(can.TargetRect.CenterX-ProgrPath,can.TargetRect.Centery-ProgrPath,can.TargetRect.CenterX+ProgrPath,can.TargetRect.Centery+ProgrPath)
				Dim oval As B4XPath
				oval.InitializeOval(rec)
				can.ClipPath(oval)
				can.DrawBitmap(T_bmp,can.TargetRect)
				can.RemoveClip
				For Spotted=1 To 2
					Dim rec As B4XRect
					rec.Initialize((Spotted-0.5)*can.TargetRect.CenterX-ProgrPath,(Spotted-0.5)*can.TargetRect.Centery-ProgrPath,(Spotted-0.5)*can.TargetRect.CenterX+ProgrPath,(Spotted-0.5)*can.TargetRect.Centery+ProgrPath)
					Dim oval As B4XPath
					oval.InitializeOval(rec)
					can.ClipPath(oval)
					can.DrawBitmap(T_bmp,can.TargetRect)
					can.RemoveClip
					
					Dim rec As B4XRect
					rec.Initialize((Spotted-0.5)*can.TargetRect.CenterX-ProgrPath,(2.5-Spotted)*can.TargetRect.Centery-ProgrPath,(Spotted-0.5)*can.TargetRect.CenterX+ProgrPath,(2.5-Spotted)*can.TargetRect.Centery+ProgrPath)
					Dim oval As B4XPath
					oval.InitializeOval(rec)
					can.ClipPath(oval)
					can.DrawBitmap(T_bmp,can.TargetRect)
					can.RemoveClip
				Next
				
				can.Invalidate
				ProgrPath=ProgrPath+StepPath
				Sleep((Durate/MaxMove)-5)
			Loop
		
		Case SlideFromLeft
			Wait For (Slide(-1,0,Durate,False)) COMPLETE (Success As Boolean)
		Case SlideFromTop
			Wait For (Slide(0,1,Durate,False)) COMPLETE (Success As Boolean)
		Case SlideFromRight
			Wait For (Slide(1,0,Durate,False)) COMPLETE (Success As Boolean)
		Case SlideFromBottom
			Wait For (Slide(0,1,Durate,False)) COMPLETE (Success As Boolean)
		Case AnimationLiquidUp
			Dim statend As Long = DateTime.Now + Durate
			Dim MaxMove As Int = 20
			Dim stepL As Int = 0
			LR=can.TargetRect.CenterX
			Do While DateTime.Now<=statend
				Liquid(stepL,F_bmp,T_bmp)
				stepL = stepL + (100/MaxMove)
				Sleep((Durate/MaxMove)-10)
			Loop
		Case AnimationLiquidDown
			Dim statend As Long = DateTime.Now + Durate
			Dim MaxMove As Int = 20
			Dim stepL As Int = 100
			LR=can.TargetRect.CenterX
			Do While DateTime.Now<=statend
				Liquid(stepL,T_bmp,F_bmp)
				stepL = stepL - (100/MaxMove)
				Sleep((Durate/MaxMove)-10)
			Loop
		Case AnimationBatMan
			Dim drt As Int = Durate / BatManStep
			Dim L As List = CalculateBatMan
			For i=1 To BatManStep
				DrawBatMan(i*Max(Pn.Width,Pn.Height)/BatManStep,F_bmp,T_bmp,l)
				Sleep(drt-10)
			Next
		Case ShoveFromLeft
			Wait For (Slide(-1,0,Durate,True)) COMPLETE (Success As Boolean)
		Case ShoveFromTop
			Wait For (Slide(0,1,Durate,True)) COMPLETE (Success As Boolean)
		Case ShoveFromRight
			Wait For (Slide(1,0,Durate,True)) COMPLETE (Success As Boolean)
		Case ShoveFromBottom
			Wait For (Slide(0,1,Durate,True)) COMPLETE (Success As Boolean)
		Case AnimationGuillotine
			Wait For (Guillotine(F_bmp,T_bmp, Durate)) COMPLETE (Success As Boolean)
		Case Else
			Sleep(Durate)
	End Select
		
	' end animation
	can.Release
	Pn.RemoveAllViews
	Pn.RemoveViewFromParent
	Pn=Null
End Sub

Private Sub Slide(Left As Int , Top As Int, Durate As Int, Shove As Boolean) As ResumableSub
	Dim statend As Long = DateTime.Now + Durate
	Dim MaxMove As Int = Durate/50
	Dim LeftPrec As Int = 0
	Dim TopPrec As Int = 0
	Dim Width As Float = can.TargetRect.Width
	Dim Height As Float = can.TargetRect.Height
			
	Dim LeftStep As Int = -Left * Width/MaxMove
	Dim TopStep As Int = -Top * Height/MaxMove
	Left = Left * Width
	Top = Top * Height
	
	
	Dim drt As Int =Durate/MaxMove
	Do While DateTime.Now<=statend
		Dim T As Long = DateTime.Now
		Dim rec As B4XRect
			
		If Shove Then 
			rec.Initialize(LeftPrec,TopPrec,LeftPrec+Width,TopPrec+Height)		
			can.DrawBitmap(F_bmp,rec)
			LeftPrec=LeftPrec+LeftStep
			TopPrec=TopPrec+TopStep
		End If
		
		rec.Initialize(Left,Top,Left+Width,Top+Height) 
		can.DrawBitmap(T_bmp,rec)
		can.Invalidate
		Left=Left+LeftStep
		Top=Top+TopStep
		
		Sleep(drt-(DateTime.Now-T))
	Loop
	
	Return True
End Sub

Private Sub Guillotine(FromB As B4XBitmap,ToB As B4XBitmap,Drt As Int) As ResumableSub
	Dim Tm As Int = 80
	Dim Q As Int = Drt/Tm
	Dim Degree As Int = 270
	Dim Passo As Int = 90 / Q
	Dim T As Long
	
	Dim P As B4XView=xui.CreatePanel("")
	P.SetLayoutAnimated(0,0,0,Pn.Width*2,Pn.Height*2)
	Dim rec As B4XRect
	rec.Initialize(Pn.Width,Pn.Height,Pn.Width*2,Pn.Height*2)
	Dim Cn As B4XCanvas
	Cn.Initialize(P)
	Cn.DrawBitmap(ToB,rec)
	Cn.Invalidate
	Dim ToBmp As B4XBitmap = Cn.CreateBitmap
	Cn.Release
	
	rec.Initialize(-Pn.Width,-Pn.Height,Pn.Width,Pn.Height)
	For i=0 To Q-1
		T=DateTime.Now		
		Log("Time " & T)
		can.DrawBitmap(FromB,can.TargetRect)
		'can.DrawBitmapRotated(ToBmp,can.TargetRect,Degree)
		can.DrawBitmapRotated(ToBmp,rec,Degree)
		Degree=Degree+Passo
		can.Invalidate
		Sleep(Tm+t-DateTime.Now)
	Next
	can.DrawBitmap(ToB,can.TargetRect)
	can.Invalidate
	
	Return True
End Sub

#region Liquid

Private Sub Liquid(vl As Int,UpB As B4XBitmap,DnB As B4XBitmap)
	Dim Dpt As Int = Max(can.TargetRect.Width,can.TargetRect.Height) ' Diametro Cerchio Massimo
	Dim level As Int ' Heigh Wawe
	'Dim Wave As Int = Min(Dpt/10,12dip)*SinD(vl*1.8)
	Dim Wave As Int = Min(Dpt/10,30dip)*SinD(vl*1.8)
	Dim More As Int = 20dip ' Left Incremental Wave

	level = can.TargetRect.Height*(100-vl)/100
	can.DrawBitmap(UpB,can.TargetRect)
	
	Point=DownWave(Dpt-LR,level,Wave) ' Diametro Cerchio Massimo - Left Partenza Onda
	DrawCSpline(DnB)

	LR=LR+More  ' Movimento Onda
	If (LR>Dpt) Or (LR<0) Then	More=-More

	can.Invalidate
End Sub

Private Sub DownWave(LR2 As Int,Level As Int, Wave As Int) As Map()
	Dim Pnt(9) As Map
	
	' Initialize Map
	For Each M As Map In Pnt
		M.Initialize
	Next
	
	Pnt(0).Put("x",LR2-can.TargetRect.Width*2)
	Pnt(0).put("y",can.TargetRect.Height)

	Pnt(1).Put("x",LR2-can.TargetRect.Width*1.50)
	Pnt(1).put("y",Level+Wave)

	Pnt(2).Put("x",LR2-can.TargetRect.Width*0.25)
	Pnt(2).put("y",Level+Wave/2)

	Pnt(3).Put("x",LR2)
	Pnt(3).put("y",Level)

	Pnt(4).Put("x",LR2+can.TargetRect.Width*0.25)
	Pnt(4).put("y",Level-Wave)

	Pnt(5).Put("x",LR2+can.TargetRect.Width*0.75)
	Pnt(5).put("y",Level+Wave)

	Pnt(6).Put("x",LR2+can.TargetRect.Width)
	Pnt(6).put("y",Level)

	Pnt(7).Put("x",LR2+can.TargetRect.Width*1.25)
	Pnt(7).put("y",Level+Wave)

	Pnt(8).Put("x",LR2+can.TargetRect.Width*2)
	Pnt(8).put("y",can.TargetRect.Height)
	
	For Each M As Map In Pnt
		M.Put("p",0)
		M.Put("u",0)
	Next
	
	Return Pnt
End Sub

Private Sub DrawCSpline(bmp As B4XBitmap)
	Dim piece As Int
	Dim xPos As Int
	Dim yPos As Int
	Dim Pt As B4XPath
  
	SetPandU
	For piece = 0 To Point.Length - 2
		For xPos = Point(piece).get("x") To Point(piece + 1).get("x")
			yPos = getCurvePoint(piece, xPos)
			
			If Pt.IsInitialized Then
				Pt.LineTo(xPos,yPos)
			Else
				Pt.Initialize(xPos,yPos)
			End If
		Next
	Next
	
	can.ClipPath(Pt)
	can.DrawBitmap(bmp,can.TargetRect)
	can.RemoveClip
End Sub


private Sub getCurvePoint(i As Int, v As Float) As Float
	Dim t As Float
	'derived curve equation (which uses p's and u's for coefficients)
	t = (v - Point(i).get("x")) / Point(i).get("u")
	Return t * Point(i + 1).get("y") + (1 - t) * Point(i).get("y") + Point(i).get("u") * Point(i).get("u") * (ff(t) * Point(i + 1).Get("p") + ff(1 - t) * Point(i).get("p")) / Point.Length
End Sub

private Sub ff(x As Float) As Float
	Return x * x * x - x
End Sub

Private Sub SetPandU
	Dim i As Int
	Dim d(Point.Length) As Float
	Dim w(Point.Length) As Float

	For i = 1 To Point.Length - 2
		d(i) = 2 * (Point(i + 1).get("x") - Point(i - 1).get("x"))
	Next
	For i = 0 To Point.Length - 2
		Point(i).Put("u",Point(i + 1).get("x") - Point(i).get("x"))
	Next
	For i = 1 To Point.Length - 2
		w(i) = 6 * ((Point(i + 1).get("y") - Point(i).get("y")) / Point(i).get("u") - (Point(i).get("y") - Point(i - 1).get("y")) / Point(i - 1).get("u"))
	Next
	For i = 1 To Point.Length - 3
		w(i + 1) = w(i + 1) - w(i) * Point(i).get("u") / d(i)
		d(i + 1) = d(i + 1) - Point(i).get("u") * Point(i).get("u") / d(i)
	Next
	Point(1).put("p", 0)
	For i = Point.Length - 2 To 1 Step -1
		Point(i).put("p", (w(i) - Point(i).get("u") * Point(i + 1).get("p")) / d(i))
	Next
	Point(Point.Length-1).put("p", 0)
End Sub

#End Region

#region Batman And Robin (Heroes)

Private Sub CalculateBatMan As List
	Dim BPoint As List
	BPoint.Initialize
	
	Dim Mysub() As String = Array As String("f","s","r","q","g","p","g","q","r","s")
	Dim FromMax() As Float = Array As Float(-1,0, 1, 0.5, 1, 1, 0, 0, 0,-1)
	Dim ToMax() As Float   = Array As Float( 1,1, 0, 0, 0,-1,-1,-0.5,-1, 0)

	Dim y As Double
		
	MaxDot=Max(can.TargetRect.Width,can.TargetRect.Height)
	DivDot=MaxDot/BatManStep
	
	For I=0 To Mysub.Length-1
		For X=MaxDot*FromMax(I) To MaxDot*ToMax(I) Step IIf(FromMax(I)<ToMax(I),1,-1)
			y=CallSub2(Me,Mysub(I)&"_",X)
			If Y>=-MaxDot And Y<=MaxDot Then BPoint.Add(CreateMap("x":X,"y":y))				
		Next
	Next

	Return BPoint
End Sub

Private Sub DrawBatMan(MaxSize As Int, basebmp As B4XBitmap,bmp As B4XBitmap, Lp As List)
	Dim Cx As Int = can.TargetRect.CenterX
	Dim Cy As Int = can.TargetRect.Centery
	Dim rapp As Double = 5 * MaxSize/Max(can.TargetRect.Width,can.TargetRect.Height)
	
	can.DrawBitmap(basebmp,can.TargetRect)
	
'	For I=1 To Lp.Size-1
'		can.DrawLine(Cx+rapp*Lp.Get(i).As(Map).Get("x"),Cy+rapp*Lp.Get(i).As(Map).Get("y"),Cx+rapp*Lp.Get(i-1).As(Map).Get("x"),Cy+rapp*Lp.Get(i-1).As(Map).Get("y"),xui.Color_Black,1dip)
'	Next
		
	Dim Path As B4XPath
	Path.Initialize(Cx+rapp*Lp.Get(0).As(Map).Get("x"),Cy+rapp*Lp.Get(0).As(Map).Get("y"))
	For I=0 To Lp.Size-1
		Path.LineTo(Cx+rapp*Lp.Get(i).As(Map).Get("x"),Cy+rapp*Lp.Get(i).As(Map).Get("y"))
	Next
		
	can.ClipPath(Path)
	can.DrawBitmap(bmp,can.TargetRect)
	can.DrawPath(Path,xui.Color_Black,False,1dip)
	can.RemoveClip
	can.Invalidate
End Sub

Private Sub f_(x As Double) As Double
	x=x/DivDot
	Dim Y As Double = Abs(x/2)
	
	Y=Y-Power(x,2)*(3*Sqrt(33)-7)/122
	Y=Y-3+Sqrt(1-Power(Abs(Abs(x)-2)-1,2))
	
	Return -y*DivDot
End Sub

Private Sub s_(x As Double) As Double
	x=x/DivDot
	Dim Y As Double = -3 
	Y=y * Sqrt(1-Power(x/7,2))
	Y= y*Sqrt(Abs(Abs(x)-4)/(Abs(x)-4))
	
	'Log(x & " " & Y)
	Return -y*DivDot
End Sub

Private Sub r_(x As Double) As Double
	x=x/DivDot
	
	Dim Y As Double = -3 
	Y=y * Sqrt(1-Power(x/7,2))
	Y= y*Sqrt(Abs(Abs(x)-3)/(Abs(x)-3))
	
	Return y*DivDot
End Sub

Private Sub q_(x As Double) As Double
	x=x/DivDot
	
	Dim Y As Double = 6 * Sqrt(10)/7
	Y=Y+(1.5-Abs(x)/2)*Sqrt(Abs(Abs(x)-1)/(Abs(x)-1))
	Y=Y-6*((Sqrt(10)/14)*Sqrt(4-Power(Abs(x)-1,2)))
	
	Return -y*DivDot
End Sub

Private Sub g_(x As Double) As Double
	x=x/DivDot
	
	Dim Y As Double = -(Abs(x)-1)*(Abs(x)-0.75)
	Y=9*Sqrt(Abs(Y)/y) - 8 * Abs(x)
	
	Return -y*DivDot
End Sub

Private Sub p_(x As Double) As Double
	x=x/DivDot
	
	Dim Y As Double = 2.25
	Y=y*Sqrt(Abs(-(x-0.5)*(x+0.5))/(-(x-0.5)*(x+0.5)))
	
	'log(x & " " & Y)
	Return -y*DivDot
End Sub


#End Region