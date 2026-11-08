B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Public offsetX As Double = 0
	Public offsetY As Double = 0
	Public SQUARE As String = "Square"
	Public SAWTOOTH As String = "SawTooth"
	Public TRIANGLE As String = "Triangle"
	Public SEMICIRCLE As String = "SemiCircle"
	Dim wave As String = "Square"
	Dim n As Int = 0
	Public child As Cycle
	Dim cv1 As CanvasExt
	
	Dim ar As Arrow
	

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(wave1 As String, offsetX1 As Double, offsetY1 As Double, n1 As Int) As Cycle
	
	If offsetX1 <> 0.0 Then 
		offsetX = offsetX1
	Else
		offsetX = 0	
	End If
		
	If offsetY1 <> 0.0 Then 
		offsetY = offsetY1
	Else
		offsetY = 0	
	End If

	wave = wave1
	
	If wave  = "Square" Or wave = "Triangle" Then
		n = 2 * n1 -1
	End If
	If wave = "Sawtooth" Or wave = "SemiCircle" Then
		n = n1
	End If
	Return Me
	
End Sub

Public Sub Initialize_2(wave1 As String, n1 As Int) As Cycle
	wave = wave1

	If wave  = "Square" Or wave = "Triangle" Then
		n = 2 * n1 - 1
	End If
	If wave = "Sawtooth" Or wave = "SemiCircle" Then
		n = n1
	End If
	
	Return Me
	
End Sub


Public Sub addCycle(cycle1 As Cycle)
	child = cycle1

End Sub

Public Sub drawCycle(cv As Canvas, xVal As Double) As Canvas
	
	cv1.Initialize(cv)
	ar.Initialize(cv)
	
	If (wave = "Square")  Then
		Dim radius As Double = ((4 * 100) / (n * cPI))  '100 = height
		If Main.cbCircle.Checked = True Then 
			cv1.drawOval(offsetX.As(Int) - radius.As(Int), offsetY.As(Int) - radius.As(Int), (radius * 2).As(Int), (radius * 2).As(Int), fx.Colors.Red, False, 1dip)
		End If
		Dim angle As Double = n * xVal
		Dim x As Double = radius * Cos(angle)
		Dim y As Double= radius * Sin(angle)
		If Main.cbVector.Checked = True Then
			ar.drawArrow(offsetX.As(Int), offsetY.As(Int), (x + offsetX).As(Int), (y + offsetY).As(Int), 15, 15, fx.Colors.Green, 1dip)
		End If
		If (child.IsInitialized = False) Then
			cv.drawLine((x + offsetX).As(Int),(y + offsetY).As(Int), Main.beginGraphX, (y + offsetY).As(Int), fx.Colors.Blue, 1dip)
			Main.values.add(y + offsetY)
			If (Main.values.size > 1000) Then
				Main.values.RemoveAt(0)
			End If	
		Else 
			child.offsetX = x + offsetX
			child.offsetY = y + offsetY
			child.drawCycle(cv, xVal)
		End If
	End If
	
	If (wave = "Triangle")  Then
	
		Dim radius As Double = (2 * 100) / (Power(n,2) * cPI) ' 100 = height
		cv1.drawOval(offsetX.As(Int) - radius.As(Int), offsetY.As(Int) - radius.As(Int), (radius * 2).As(Int), (radius * 2).As(Int), fx.Colors.Red, False, 1dip)
		Dim angle As Double = n * xVal
		Dim x As Double = radius * Sin(angle)
		Dim y As Double = radius * Cos(angle)
		cv.DrawLine(offsetX.As(Int), offsetY.As(Int), (x + offsetX).As(Int), (y + offsetY).As(Int),fx.Colors.Green, 1dip)
	
		If (child.IsInitialized = False) Then
			cv.drawLine((x + offsetX).As(Int),(y + offsetY).As(Int), Main.beginGraphX, (y + offsetY).As(Int), fx.Colors.Blue, 1dip)
			Main.values.add(y + offsetY)
			If (Main.values.size > 1000) Then
			Main.values.RemoveAt(0)
			End If	
		Else
			child.offsetX = x + offsetX
			child.offsetY = y + offsetY
			child.drawCycle(cv, xVal)
		End If
	End If
	
	
	
	
	
	
	Return cv
	
End Sub	
	
'	If (Type == wave.SAWTOOTH) {
'		g2D.setColor(Color.WHITE);
'		double radius = (2 * 100) / (n * Math.PI); // 100 = height
'		g2D.setColor(new Color(255, 255, 255, 100));
'		g2D.drawOval((int) offsetX - (int) radius, (int) offsetY - (int) radius, (int) radius * 2,
'				(int) radius * 2);
'		double angle = n * xVal;
'		double x = radius * Math.cos(angle);
'		double y = radius * Math.sin(angle);
'		g2D.setColor(Color.WHITE);
'		g2D.drawLine((int) offsetX, (int) offsetY, (int) (x + offsetX), (int) (y + offsetY));
'
'		If (this.child == Null) {
'			g2D.setColor(new Color(255, 255, 0, 126));
'			g2D.drawLine((int) (x + offsetX), (int) (y + offsetY), Frame.beginGraphX, (int) (y + offsetY));
'			Frame.values.add(y + offsetY);
'			If (Frame.values.size() > 1000) {
'				Frame.values.remove(0);
'			}
'		} Else {
'			child.offsetX = x + offsetX;
'			child.offsetY = y + offsetY;
'			child.drawCycle(g2D, xVal);
'		}
'	}
'	If (Type == wave.TRIANGLE) {
'		g2D.setColor(Color.WHITE);
'		double radius = (2 * 100) / (Math.pow(n, 2) * Math.PI); // 100 = height
'		g2D.setColor(new Color(255, 255, 255, 100));
'		g2D.drawOval((int) offsetX - (int) radius, (int) offsetY - (int) radius, (int) radius * 2,
'				(int) radius * 2);
'		double angle = n * xVal;
'		double x = radius * Math.sin(angle);
'		double y = radius * Math.cos(angle);
'		g2D.setColor(Color.WHITE);
'		g2D.drawLine((int) offsetX, (int) offsetY, (int) (x + offsetX), (int) (y + offsetY));
'
'		If (this.child == Null) {
'			g2D.setColor(new Color(255, 255, 0, 126));
'			g2D.drawLine((int) (x + offsetX), (int) (y + offsetY), Frame.beginGraphX, (int) (y + offsetY));
'			Frame.values.add(y + offsetY);
'			If (Frame.values.size() > 1000) {
'				Frame.values.remove(0);
'			}
'		} Else {
'			child.offsetX = x + offsetX;
'			child.offsetY = y + offsetY;
'			child.drawCycle(g2D, xVal);
'		}
'	}
'	If (Type == wave.SEMICIRCLE) {
'		g2D.setColor(Color.WHITE);
'		double radius = (2 * 100) / (Math.pow(n, 2) * Math.PI); // 100 = height
'		g2D.setColor(new Color(255, 255, 255, 100));
'		g2D.drawOval((int) offsetX - (int) radius, (int) offsetY - (int) radius, (int) radius * 2,
'				(int) radius * 2);
'		double angle = n * xVal;
'		double x = radius * Math.sin(angle);
'		double y = radius * Math.cos(angle);
'		g2D.setColor(Color.WHITE);
'		g2D.drawLine((int) offsetX, (int) offsetY, (int) (x + offsetX), (int) (y + offsetY));
'
'		If (this.child == Null) {
'			g2D.setColor(new Color(255, 255, 0, 126));
'			g2D.drawLine((int) (x + offsetX), (int) (y + offsetY), Frame.beginGraphX, (int) (y + offsetY));
'			Frame.values.add(y + offsetY);
'			If (Frame.values.size() > 1000) {
'				Frame.values.remove(0);
'			}
'		} Else {
'			child.offsetX = x + offsetX;
'			child.offsetY = y + offsetY;
'			child.drawCycle(g2D, xVal);
'		}
'	}
'}
'


