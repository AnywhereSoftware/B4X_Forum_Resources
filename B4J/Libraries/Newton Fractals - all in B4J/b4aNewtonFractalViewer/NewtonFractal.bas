B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	
	Dim DEFAULT_ZOOM As Double = 100.0
	Dim DEFAULT_TOP_LEFT_X As Double = -4.5
	Dim DEFAULT_TOP_LEFT_Y As Double = 4.0
	Private TOLERANCE As Double = Power(10, -6)
	Private MAXITER As Int = 100
	
	Private width, height As Int
	Private roots As Map
	Private rootColors As List

	Private poli As Polynomial
	
	Dim zoomFactor As Double 
	Dim topLeftX As Double 
	Dim topLeftY  As Double
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(wdth As Int, hght As Int, poli1 As Polynomial)
	
	zoomFactor = DEFAULT_ZOOM
	topLeftX = DEFAULT_TOP_LEFT_X
	topLeftY = DEFAULT_TOP_LEFT_Y
	width = wdth
	height = hght
	poli = poli1
	roots.Initialize
	rootColors.Initialize
	
End Sub


Private Sub getXPos(x As Double) As Double
    Return (x / zoomFactor) + topLeftX
End Sub

Private Sub getYPos(y As Double) As Double
    Return (y / zoomFactor) - topLeftY
End Sub


Private Sub clamp01(value As Float) As Float
    Return Max(0, Min(1, value))
End Sub


Private Sub getColorFromRoot(rootPoint1 As RootPoint) As JavaObject
	Dim col As JavaObject
	col.InitializeStatic("java.awt.Color")
	For i = 0 To rootColors.size - 1
		If(rootColors.Get(i).As(Complex).equals1(rootPoint1.point, TOLERANCE)) Then

			Dim hue, saturation, brightness As Float

			hue = clamp01(Abs((0.5f - rootPoint1.getPoint.arg / (cPI * 2.0f).As(Float))))

			saturation = clamp01(Abs(0.59f / rootPoint1.getPoint.abs.As(Float)))

			brightness = 0.95f * Max(1.0f - rootPoint1.getNumIter().As(Float) * 0.025f, 0.05f)
			If (rootPoint1.getPoint.abs < 0.1) Then
				saturation = 0.0f
			End If

			Return col.RunMethod("getHSBColor", Array(hue, saturation, brightness))
		End If
	Next
	Return col.GetField("black")
	
End Sub


Private Sub applyNewtonMethod(x As Int, y As Int)
    Dim point As Complex
	point.Initialize
	point.re = getXPos(x)
	point.im = getYPos(y)

	Dim rtApprox As RootApproximator
	
	rtApprox.Initialize(poli, point)
    Dim rootPoint1 As RootPoint = rtApprox.getRootPoint()
    If(Not(containsRoot(rootPoint1.getPoint))) Then
        rootColors.add(rootPoint1.getPoint)
	End If
	Dim pnt As JavaObject
	pnt.InitializeNewInstance("java.awt.Point", Array(x,y))
    roots.put(pnt, rootPoint1)
End Sub

Private Sub containsRoot(root As Complex) As Boolean

    For Each z As Complex In rootColors
        If(z.equals1(root, TOLERANCE)) Then
            Return True
        End If
    Next
    Return False
End Sub



public Sub doInBackground As List
	Dim fractalImage As List
	fractalImage.Initialize

	For y = 0 To height - 1
		For x = 0 To  width - 1
			applyNewtonMethod(x, y)
			Dim pnt As JavaObject
			pnt.InitializeNewInstance("java.awt.Point", Array(x,y))
			
			Dim c As JavaObject
			c.Initializestatic("java.awt.Color")
			c = getColorFromRoot(roots.Get(pnt))
			
			Dim aa(3) As Object
			aa(0) = x
			aa(1) = y
			aa(2) = c.RunMethod("getRGB", Null)
			fractalImage.Add(aa)
			
		Next
	Next
	
	Return fractalImage
End Sub
