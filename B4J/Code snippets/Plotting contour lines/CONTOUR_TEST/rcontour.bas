B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@
'Static code module
'Code module
'Subs in this code module will be accessible from all modules.
'Algorithm for contour(conrec) taken from  Paul Bourke https://paulbourke.net/papers/conrec/
'Depends on jReflection library
'Author: Prof.Dr.Rajesh B. Ghongade
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	
	Type CT(num(5000) As Int, u1(5000,5000),v1(5000,5000),u2(5000,5000),v2(5000,5000) As Double)
End Sub



Sub linspace(x As Double,y As Double,n As Int)As Double()
	Dim z(n) As Double
	Dim j As Int
	If x< y Then
		For i=0 To n-1
			z(j)=x+i*((y-x)/(n-1))
			j=j+1
		Next
	Else
		For i=0 To n-1
			z(j)=x-i*((x-y)/(n-1))
			j=j+1
		Next
	End If
	Return z
End Sub
Sub dimsize(MyArray As Object) As Int()
	Dim r As Reflector
	Dim dims() As Int
	r.Target = MyArray
	dims = r.TargetRank
	Return dims
End Sub


Sub mmax(a(,) As Double )As Double ' returns max in a matrix
	Dim s() As Int=dimsize(a)
	Dim r,c As Int
	r=s(0)
	c=s(1)
	Dim mval As Double=a(0,0)
	For i=0 To r-1
		For j=0 To c-1
			mval=Max(a(i,j),mval)
		Next
	Next
	Return mval

End Sub
Sub mmin(a(,) As Double )As Double ' returns max in a matrix
	Dim s() As Int=dimsize(a)
	Dim r,c As Int
	r=s(0)
	c=s(1)
	Dim mval As Double=a(0,0)
	For i=0 To r-1
		For j=0 To c-1
			mval=Min(a(i,j),mval)
		Next
	Next
	Return mval

End Sub

Sub amap(t() As Double,olb As Double,oub As Double) As Double()
	Dim s(2) As Int=dimsize(t)
	Dim ilb,iub As Double
	Dim r,c As Int'ignore
	r=s(0)
	
	
	Dim nt(r) As Double
	
	iub=arr_max(t)
	ilb=arr_min(t)
	Dim slope As Double=(oub-olb)/(iub-ilb)
	For i=0 To r-1
		nt(i)=olb+slope*(t(i)-ilb)
	Next
	Return nt
End Sub
Sub mmap(t(,) As Double,olb As Double,oub As Double) As Double(,)
	Dim s(2) As Int=dimsize(t)
	Dim ilb,iub As Double
	Dim r,c As Int
	r=s(0)
	c=s(1)
	
	Dim nt(r,c) As Double
	
	iub=mmax(t)
	ilb=mmin(t)
	Dim slope As Double=(oub-olb)/(iub-ilb)
	For i=0 To r-1
		For j=0 To c-1
			nt(i,j)=olb+slope*(t(i,j)-ilb)
		Next
	Next
	Return nt
End Sub
Sub arr_max(a() As Double )As Double ' returns max in an array
	Dim n As Int
	Dim y As Double
	n=a.Length
	y=a(0)
	For i=0 To n-1
		y=Max(a(i),y)
	
	Next
	Return y

End Sub
Sub arr_min(a() As Double )As Double ' returns max in a matrix
	Dim n As Int
	Dim y As Double
	n=a.Length
	y=a(0)
	For i=0 To n-1
		y=Min(a(i),y)
	
	Next
	Return y

End Sub

Sub InterpolateColorsInRange(color1 As Int, color2 As Int, minvalue1 As Float, maxvalue1 As Float, value As Float) As Int
	' Ensure value is within the range [minValue, maxValue]
	
	Dim value As Float = Max(minvalue1, Min(maxvalue1, value))
    
	' Calculate the parameter based on the value within the range
	Dim parameter As Float = (value - minvalue1) / (maxvalue1 - minvalue1)
    
	' Interpolate the color using the parameter
	Dim red1 As Int = Bit.UnsignedShiftRight(Bit.And(color1, 0xFF0000), 16)
	Dim green1 As Int = Bit.UnsignedShiftRight(Bit.And(color1, 0x00FF00), 8)
	Dim blue1 As Int = Bit.And(color1, 0x0000FF)
    
	Dim red2 As Int = Bit.UnsignedShiftRight(Bit.And(color2, 0xFF0000), 16)
	Dim green2 As Int = Bit.UnsignedShiftRight(Bit.And(color2, 0x00FF00), 8)
	Dim blue2 As Int = Bit.And(color2, 0x0000FF)
    
	Dim interpolatedRed As Int = red1 + (red2 - red1) * parameter
	Dim interpolatedGreen As Int = green1 + (green2 - green1) * parameter
	Dim interpolatedBlue As Int = blue1 + (blue2 - blue1) * parameter
    
	' Combine the interpolated RGB values into a single color
	Dim interpolatedColor As Int = Bit.Or(Bit.Or(Bit.ShiftLeft(interpolatedRed, 16), Bit.ShiftLeft(interpolatedGreen, 8)), interpolatedBlue)
    
	Return -interpolatedColor
End Sub

Sub conrec(Z(,) As Double,X0 () As Double,Y0() As Double,  nc As Int,  res As Int, width As Double,height As Double) As CT
	Dim mc As CT
	mc.Initialize
	Dim ilb,iub,jlb,jub As Int
	
	ilb=0
	iub=res-1
	jlb=0
	jub=res-1
	
	Dim maxvalue,minvalue As Double
	maxvalue=mmax(Z)
	minvalue=mmin(Z)
	Dim range(nc) As Double=linspace(minvalue,maxvalue,nc)
	Dim contour(nc) As Double
	For p=0 To nc-1
		contour(p)=range(p)
	Next
	
	Dim X(), Y() As Double
	Dim m1, m2, m3, case_value As Int
	Dim dmin, dmax As Double
	Dim x1, x2, y1, y2 As Double
	Dim i, j, k, m As Int
	Dim h(5) As Double
	Dim sh(5) As Int
	Dim xh(5), yh(5) As Double

	Dim Nullcode As Double
	Nullcode = Power(10,37)

	Dim im(4), jm(4) As Int
	im(0) = 0
	im(1) = 1
	im(2) = 1
	im(3) = 0
	jm(0) = 0
	jm(1) = 0
	jm(2) = 1
	jm(3) = 1

	Dim castab(3, 3, 3) As Int
	castab(0, 0, 0) = 0
	castab(0, 0, 1) = 0
	castab(0, 0, 2) = 8 '
	castab(0, 1, 0) = 0
	castab(0, 1, 1) = 2
	castab(0, 1, 2) = 5 '
	castab(0, 2, 0) = 7
	castab(0, 2, 1) = 6
	castab(0, 2, 2) = 9 '
	castab(1, 0, 0) = 0
	castab(1, 0, 1) = 3
	castab(1, 0, 2) = 4 '
	castab(1, 1, 0) = 1
	castab(1, 1, 1) = 3
	castab(1, 1, 2) = 1 '
	castab(1, 2, 0) = 4
	castab(1, 2, 1) = 3
	castab(1, 2, 2) = 0 '
	castab(2, 0, 0) = 9
	castab(2, 0, 1) = 6
	castab(2, 0, 2) = 7 '
	castab(2, 1, 0) = 5
	castab(2, 1, 1) = 2
	castab(2, 1, 2) = 0 '
	castab(2, 2, 0) = 8
	castab(2, 2, 1) = 0
	castab(2, 2, 2) = 0 '

	X=amap(X0,0,width)
	Y=amap(Y0,0,height)

	If nc <> 0 Then
		For j = jub - 1 To jlb Step -1
			For i = ilb To iub - 1
				Dim temp1, temp2 As Double
				temp1 = Min(Z(i, j), Z(i, j + 1))
				temp2 = Min(Z(i + 1, j), Z(i + 1, j + 1))
				dmin = Min(temp1, temp2)
				temp1 = Max(Z(i, j), Z(i, j + 1))
				temp2 = Max(Z(i + 1, j), Z(i + 1, j + 1))
				dmax = Max(temp1, temp2)
      

				If dmax >= contour(0) And dmin <= contour(nc - 1) And dmax < Nullcode Then
					For k = 0 To nc - 1
						If contour(k) >= dmin And contour(k) < dmax Then
							For m = 4 To 0 Step -1
								If (m > 0) Then
									h(m) = Z(i + im(m - 1), j + jm(m - 1)) - contour(k)
									xh(m) = X(i + im(m - 1))
									yh(m) = Y(j + jm(m - 1))
								Else
									h(0) = 0.25 * (h(1) + h(2) + h(3) + h(4))
									xh(0) = 0.5 * (X(i) + X(i + 1))
									yh(0) = 0.5 * (Y(j) + Y(j + 1))
								End If
								If (h(m) > 0) Then
									sh(m) = 1
								Else If h(m) < 0 Then
									sh(m) = -1
								Else:
									sh(m) = 0
								End If
							Next
           

							For m = 1 To 4
								m1 = m
								m2 = 0
								If (m <> 4) Then
									m3 = m + 1
								Else:
									m3 = 1
								End If
								case_value = castab(sh(m1) + 1, sh(m2) + 1, sh(m3) + 1)
								If case_value <> 0 Then
									Select Case case_value
                 

										Case 1
											x1 = xh(m1)
											y1 = yh(m1)
											x2 = xh(m2)
											y2 = yh(m2)
                 

										Case 2
											x1 = xh(m2)
											y1 = yh(m2)
											x2 = xh(m3)
											y2 = yh(m3)
                 

										Case 3
											x1 = xh(m3)
											y1 = yh(m3)
											x2 = xh(m1)
											y2 = yh(m1)
                 

										Case 4
											x1 = xh(m1)
											y1 = yh(m1)
											x2 = (h(m3) * xh(m2) - h(m2) * xh(m3)) / (h(m3) - h(m2))
											y2 = (h(m3) * yh(m2) - h(m2) * yh(m3)) / (h(m3) - h(m2))
                   
                 

										Case 5
											x1 = xh(m2)
											y1 = yh(m2)
											x2 = (h(m1) * xh(m3) - h(m3) * xh(m1)) / (h(m1) - h(m3))
											y2 = (h(m1) * yh(m3) - h(m3) * yh(m1)) / (h(m1) - h(m3))
                 

										Case 6
											x1 = xh(m3)
											y1 = yh(m3)
											x2 = (h(m2) * xh(m1) - h(m1) * xh(m2)) / (h(m2) - h(m1))
											y2 = (h(m2) * yh(m1) - h(m1) * yh(m2)) / (h(m2) - h(m1))
                 

										Case 7
											x1 = (h(m2) * xh(m1) - h(m1) * xh(m2)) / (h(m2) - h(m1))
											y1 = (h(m2) * yh(m1) - h(m1) * yh(m2)) / (h(m2) - h(m1))
											x2 = (h(m3) * xh(m2) - h(m2) * xh(m3)) / (h(m3) - h(m2))
											y2 = (h(m3) * yh(m2) - h(m2) * yh(m3)) / (h(m3) - h(m2))
                   
                 

										Case 8
											x1 = (h(m3) * xh(m2) - h(m2) * xh(m3)) / (h(m3) - h(m2))
											y1 = (h(m3) * yh(m2) - h(m2) * yh(m3)) / (h(m3) - h(m2))
											x2 = (h(m1) * xh(m3) - h(m3) * xh(m1)) / (h(m1) - h(m3))
											y2 = (h(m1) * yh(m3) - h(m3) * yh(m1)) / (h(m1) - h(m3))
                 

										Case 9
											x1 = (h(m1) * xh(m3) - h(m3) * xh(m1)) / (h(m1) - h(m3))
											y1 = (h(m1) * yh(m3) - h(m3) * yh(m1)) / (h(m1) - h(m3))
											x2 = (h(m2) * xh(m1) - h(m1) * xh(m2)) / (h(m2) - h(m1))
											y2 = (h(m2) * yh(m1) - h(m1) * yh(m2)) / (h(m2) - h(m1))
									End Select
									mc.num(k)=k
						
'					
									mc.u1(i,j)=x1
									mc.v1(i,j)=y1
									mc.u2(i,j)=x2
									mc.v2(i,j)=y2
									

								End If
							Next
						End If
					Next
				End If
			Next
 

		Next
		Return mc
	End If
End Sub
'




