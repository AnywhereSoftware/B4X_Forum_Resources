B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=3
@EndOfDesignText@


Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.
	'Private pixel As AdafruitNeoPixel
	
End Sub
Sub snowsparkle(red As Byte,green As Byte,blue As Byte, sparkledelay As Int, speeddelay As Int)
	Dim dot As Int = Rnd(0,Main.num_leds)
	Dim dot1 As Int = Rnd(0,Main.num_leds)
	Dim dot2 As Int = Rnd(0,Main.num_leds)
	setall(red, green, blue)
	Main.pixel.Show
	Main.pixel.SetPixelColor(dot,255,255,255) ' three led's flashing at the same time
	Main.pixel.SetPixelColor(dot1,255,255,255)
	Main.pixel.SetPixelColor(dot2,255,255,255)
	Main.pixel.Show
	Delay(sparkledelay)
	Main.pixel.SetPixelColor(dot,red,green,blue) ' three led's flashing at the same time
	Main.pixel.SetPixelColor(dot1,red,green,blue)
	Main.pixel.SetPixelColor(dot2,red,green,blue)
	Main.pixel.Show
	Delay(speeddelay)
End Sub

Sub rgbloop()
	For i = 0 To 2
		For k = 0 To 255
			Select Case i
				Case 0 
					setall(k,0,0)
				Case 1
					setall(0,k,0)
				Case 2
					setall(0,0,k)
			End Select
			Main.pixel.Show
			Delay(3)
		Next
		For k = 255 To 0 Step -1
			Select Case i
				Case 0
					setall(k,0,0)
				Case 1
					setall(0,k,0)
				Case 2
					setall(0,0,k)
			End Select
			Main.pixel.Show
			Delay(3)
		Next
	Next
End Sub

Sub FadeInOut(red As Byte, green As Byte, blue As Byte)
	
  Dim r As Float
  Dim g As Float
  Dim b As Float
  For k = 0 To 255
  	r = (k/256)*red
	g = (k/256)*green
	b = (k/256)*blue
	setall(r,g,b)
	Main.pixel.Show
		Delay(3)
	Next

	For k = 255 To 0 Step -1
		r = (k/256)*red
		g = (k/256)*green
		b = (k/256)*blue
		setall(r,g,b)
		Main.pixel.Show
		Delay(3)
	Next

End Sub

Sub strobe (red As Byte, green As Byte, blue As Byte ,strobecount As Int, flashdelay As Int, endpause As Int)
	For j =0 To strobecount
		setall(red,green,blue)
		Main.pixel.Show
		Delay (flashdelay)
		setall(0,0,0)
		Main.pixel.Show
		Delay(flashdelay)
	Next
	Delay(endpause)
End Sub

Sub twinkle(red As Byte, green As Byte, blue As Byte,count As Int,speeddelay As Int,onlyone As Boolean)
	setall(0,0,0)
	For i = 0 To count
		Main.pixel.SetPixelColor(Rnd(0,Main.num_leds),red,green,blue)
		Main.pixel.Show
		Delay(speeddelay)
		If onlyone Then
			setall(0,0,0)
		End If
	Next
	Delay(speeddelay)
End Sub

Sub rainbowcycle(speeddelay As Int, repeat As Int)
	Dim firstpixelhue As ULong
	Dim pixelhue As Int
	For t = 0 To repeat
		For firstpixelhue = 0 To 65536 Step 256
			For i = 0 To Main.num_leds
				pixelhue =firstpixelhue +(i*65536 / Main.num_leds)
				Main.pixel.SetPixelColor3(i, Main.pixel.Gamma32(Main.pixel.ColorHSV(pixelhue)))
			Next
			Main.pixel.Show
			Delay (speeddelay)
		Next
	Next
End Sub

Sub colorwipe(color As ULong, wait As Int)
	For i= 0 To Main.num_leds
		Main.pixel.SetPixelColor3(i, color)
		Main.pixel.Show
		Delay(wait)
	Next

End Sub


Sub runninglights (red As Byte, green As Byte, blue As Byte, wavedelay As Int)
	Dim position As Int =0
	For t =0 To 2
		For j = 0 To Main.num_leds
			position=position+1
			For i = 0 To Main.num_leds
				Main.pixel.SetPixelColor(i,((Sin(i+position)*127+128)/255)*red,((Sin(i+position)*127+128)/255)*green,((Sin(i+position)*127+128)/255)*blue)
			Next
			Main.pixel.Show
			Delay(wavedelay)
		Next
	Next
	

End Sub


Sub theaterChaseRainbow (wait As Int)
	Dim firstpixelhue As Int =0
	Dim hue As Int
	Dim color As ULong
	For a = 0 To 30
		For b =0 To 3
			Main.pixel.Clear
			For c = b To Main.num_leds Step 3
				hue = firstpixelhue + c * 65536 / Main.num_leds
				color = Main.pixel.Gamma32(Main.pixel.ColorHSV(hue))
				Main.pixel.SetPixelColor3(c,color)
			Next
			Main.pixel.Show
			Delay(wait)
			firstpixelhue = 65536 + 65536 / 90
		Next
	Next
	
End Sub

Sub setall(red As Byte, green As Byte, blue As Byte)
	For t = 0 To Main.num_leds
		Main.pixel.SetPixelColor(t,red,green,blue)
	Next
End Sub
