B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
'SunCalc-B4X Is ported from suncalc.js under the BSD-2-Clause license.
'Copyright (c) 2014, Vladimir Agafonkin
'All rights reserved.
'Redistribution And use in source And binary forms, with Or without modification, are
'permitted provided that the following conditions are met:
'   1. Redistributions of source code must retain the above copyright notice, this list of
'      conditions And the following disclaimer.
'   2. Redistributions in binary form must reproduce the above copyright notice, this list
'      of conditions And the following disclaimer in the documentation And/Or other materials
'      provided with the distribution.
'THIS SOFTWARE Is PROVIDED BY THE COPYRIGHT HOLDERS And CONTRIBUTORS "AS IS" And ANY
'EXPRESS Or IMPLIED WARRANTIES, INCLUDING, BUT Not LIMITED To, THE IMPLIED WARRANTIES OF
'MERCHANTABILITY And FITNESS For A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
'COPYRIGHT HOLDER Or CONTRIBUTORS BE LIABLE For ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
'EXEMPLARY, Or CONSEQUENTIAL DAMAGES (INCLUDING, BUT Not LIMITED To, PROCUREMENT OF
'SUBSTITUTE GOODS Or SERVICES; LOSS OF USE, DATA, Or PROFITS; Or BUSINESS INTERRUPTION)
'HOWEVER CAUSED And ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, Or
'TORT (INCLUDING NEGLIGENCE Or OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
'SOFTWARE, EVEN If ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

private Sub Class_Globals
	
	Private PI As Double = 3.1415926535
	Private rad As Double = PI / 180
	
	Private dayMs As Double = 1000 * 60 * 60 * 24
	Private J1970 As Double = 2440588
	Private J2000 As Double = 2451545
	Private J0 As Double = 0.0009
	
	Private e As Double = rad * 23.4397    'obliquity of the Earth
	
	Type DR (dec As Double, ra As Double)
	Type AA (azimuth As Double, altitude As Double)
	Type tme (angle As Double, riseName As String, setName As String)
	Type Result (solarNoon As String, nadir As String)
	Type RDD (ra As Double, dec As Double, dist As Double)
	Type AADP (azimuth As Double, altitude As Double, distance As Double, parallacticAngle As Double)
	Type FPA (fraction As Double, phase As Double, angle As Double)
	
	Private times As List		'ToDo
		
End Sub

'Initializes the object.
Public Sub Initialize
	
	times.Initialize
	
	Dim t As tme :	t.Initialize
	t.angle = -0.833 	:	t.riseName = "sunrise"		:	t.setName = "sunset"		:	times.Add (t)
	Dim t As tme :	t.Initialize
	t.angle = -0.3	 	:	t.riseName = "sunriseEnd"	:	t.setName = "sunsetStart"	:	times.Add (t)
	Dim t As tme :	t.Initialize
	t.angle = -6	 	:	t.riseName = "dawn"			:	t.setName = "dusk"			:	times.Add (t)
	Dim t As tme :	t.Initialize
	t.angle = -12	 	:	t.riseName = "nauticalDawn"	:	t.setName = "nauticalDusk"	:	times.Add (t)
	Dim t As tme :	t.Initialize
	t.angle = -18 		:	t.riseName = "nightEnd"		:	t.setName = "night"			:	times.Add (t)
	Dim t As tme :	t.Initialize
	t.angle = 6		 	:	t.riseName = "goldenHour"	:	t.setName = "blueHour"		:	times.Add (t)
	
End Sub

'Allows additional Rise/Set angles to be added
Public Sub addTime (angle As Double, riseName As String, setName As String)
	Dim t As tme
	t.angle = angle
	t.riseName = riseName
	t.setName = setName
	times.Add (t)
End Sub

Private Sub to_julian(date As Double) As Double
    Return date / dayMs - 0.5 + J1970
End Sub

private Sub from_Julian(j As Double) As String
	Return DateTime.Date ((j + 0.5 - J1970) * dayMs) & " " & DateTime.Time ((j + 0.5 - J1970) * dayMs)
End Sub

Private Sub to_Days(date As Double) As Double
	Return to_julian(date) - J2000
End Sub

Private Sub right_ascension(l As Double, b As Double) As Double
    Return ATan2D(Sin(l) * Cos(e) - Tan(b) * Sin(e), Cos(l))
End Sub


Private Sub declination(l As Double, b As Double) As Double
    Return ASin(Sin(b) * Cos(e) + Cos(b) * Sin(e) * Sin(l))
End Sub


Private Sub azimuth(H As Double, phi As Double, dec As Double) As Double
    Return ATan2D(Sin(H), Cos(H) * Sin(phi) - Tan(dec) * Cos(phi))
End Sub

Private Sub altitude(H As Double, phi As Double, dec As Double) As Double
    Return ASin(Sin(phi) * Sin(dec) + Cos(phi) * Cos(dec) * Cos(H))
End Sub


Private Sub sidereal_time(d As Double, lw As Double) As Double
	Return rad * (280.16 + 360.9856235 * d) - lw
End Sub

Private Sub astro_refraction(h As Double) As Double
    'the following formula works for positive altitudes only.
    'if h = -0.08901179 a div/0 would occur.

    h = Max(h, 0)

    ' formula 16.4 of "Astronomical Algorithms" 2nd edition by Jean Meeus
    ' (Willmann-Bell, Richmond) 1998. 1.02 / tan(h + 10.26 / (h + 5.10)) h in
    ' degrees, result in arc minutes -> converted to rad:
	Return 0.0002967 / Tan(h + 0.00312536 / (h + 0.08901179))
End Sub

Private Sub solar_mean_anomaly(d As Double) As Double
    Return rad * (357.5291 + 0.98560028 * d)
End Sub


Private Sub ecliptic_longitude(M As Double) As Double
    ' equation of center
    Dim C As Double = rad * (1.9148 * Sin(M) + 0.02 * Sin(2 * M) + 0.0003 * Sin(3 * M))

    ' perihelion of the Earth
    Dim P As Double = rad * 102.9372

    Return M + C + P + PI
End Sub


Private Sub sun_coords(d As Double) As DR
    Dim M As Double = solar_mean_anomaly(d)
    Dim L As Double = ecliptic_longitude(M)

	Dim r As DR
	r.dec = declination(L, 0)
	r.ra = right_ascension(L, 0)
    
	Return r
End Sub

Private Sub julian_cycle(d As Double, lw As Double) As Double
    Return Round(d - J0 - lw / (2 * PI))
End Sub


Private Sub approx_transit(Ht As Double, lw As Double, n As Double) As Double
    Return J0 + (Ht + lw) / (2 * PI) + n
End Sub


Private Sub solar_transit_j(ds As Double, M As Double, L As Double) As Double
    Return J2000 + ds + 0.0053 * Sin(M) - 0.0069 * Sin(2 * L)
End Sub

Private Sub hour_angle(h As Double, phi As Double, d As Double) As Double
    Return ACos((Sin(h) - Sin(phi) * Sin(d)) / (Cos(phi) * Cos(d)))
End Sub


Private Sub observer_angle(height As Double) As Double
    Return -2.076 * Sqrt(height) / 60
End Sub


Private Sub get_set_j(h As Double, lw As Double, phi As Double, dec As Double, n As Double, M As Double, L As Double) As Double
    'Get set time for the given sun altitude
    
    Dim w As Double = hour_angle(h, phi, dec)
    Dim a As Double = approx_transit(w, lw, n)
	Return solar_transit_j(a, M, L)
	
End Sub

'Returns the Azimuth & altitude of the sun at the selected date, lat & lon
Public Sub SunPosition(date As Double, lng As Double, lat As Double) As Object
    Dim lw As Double = rad * -lng
    Dim phi As Double = rad * lat
    Dim d As Double = to_Days(date)

    Dim c As DR = sun_coords(d)
    Dim H As Double = sidereal_time(d, lw) - c.ra

	Dim r As AA
	r.azimuth = azimuth(H, phi, c.dec)
	r.altitude = altitude(H, phi, c.dec)
	
	Return r
End Sub

'Returns a list of Rise/Set times.
'Sunrise / sunset (The moment the sun starts to appear / vanish)
'Sunrise End / Sunset Start (the moment the sun completely appears / vanishes)
'Dawn / Dusk (First light can be detected / last light is lost)
'Naughtical Dawn / Naughtical Dusk (as above, adjusted for being at sea)
'Night End / Night (Hours of night)
'Golden Hour / Blue Hour (Half way point between times of best light)
Public Sub TimesList (date As Long, lat As Double, lng As Double) As Object
	
	'Returns a list of useful times such as sunrise / sunset / dawn /dusk
	Dim lw As Double = rad * -lng
	Dim phi As Double = rad * lat

	Dim d As Double = to_Days(date)
	Dim n As Double = julian_cycle(d, lw)
	Dim ds As Double = approx_transit(0, lw, n)
	
	'dh = observer_angle(height)

	Dim M As Double = solar_mean_anomaly(ds)
	Dim L As Double = ecliptic_longitude(M)
	Dim dec As Double = declination(L, 0)

	Dim Jnoon As Double = solar_transit_j(ds, M, L)

	Dim i, Jset, Jrise As Double

	Dim rm As Map
	rm.Initialize
	
	Dim result As List
	result.Initialize
	
	rm.Put ("Solar Noon", from_Julian(Jnoon))
	rm.Put ("Nadir", from_Julian(Jnoon - 0.5))

	result.Add (rm)
	
	For i = 0 To times.Size -1
		
		Dim rm As Map
		rm.Initialize
		
		Dim tm As tme = times.Get (i)
		
		Jset = get_set_j(tm.angle * rad, lw, phi, dec, n, M, L)
		Jrise = Jnoon - (Jset - Jnoon)

		rm.Put (tm.riseName, from_Julian(Jrise))
		rm.Put (tm.setName, from_Julian(Jset))
		
		result.Add (rm)
	Next
	
	Return result
End Sub

'Geocentric ecliptic coordinates of the moon
'Returns Right ascension, declination & distance
Public Sub MoonCoords(date As Double) As Object
    ' ecliptic longitude
    Dim L As Double = rad * (218.316 + 13.176396 * date)
    ' mean anomaly
    Dim M As Double = rad * (134.963 + 13.064993 * date)
    ' mean distance
    Dim F As Double = rad * (93.272 + 13.229350 * date)

    ' longitude
    Dim ll As Double = L + rad * 6.289 * Sin(M)
    ' latitude
    Dim b As Double = rad * 5.128 * Sin(F)
    ' distance to the moon in km
    Dim dt As Double = 385001 - 20905 * Cos(M)

	Dim r As RDD
	r.ra = right_ascension(l, b)
	r.dec = declination(ll, b)
	r.dist = dt
	
	Return r
End Sub

'Position of the moon at a given date viewed from lat / lon
'Returns azimuth, altitude, distance & parallacticAngle
Public Sub MoonPosition(date As Double, lat As Double, lng As Double)  As Object

	Dim lw As Double = rad * -lng
	Dim phi As Double = rad * lat
	Dim d As Double = to_Days(date)

	Dim c As RDD = MoonCoords(d)
	Dim H As Double = sidereal_time(d, lw) - c.ra
	Dim lh As Double = altitude(H, phi, c.dec)

	' formula 14.1 of "Astronomical Algorithms" 2nd edition by Jean Meeus
	' (Willmann-Bell, Richmond) 1998.
	Dim pa As Double = ATan2(Sin(H), Tan(phi) * Cos(c.dec) - Sin(c.dec) * Cos(H))

	' altitude correction for refraction
	lh = lh + astro_refraction(lh)

	Dim r As AADP
	
	r.azimuth = azimuth(H, phi, c.dec)
	r.altitude = H
	r.distance = c.dist
	r.parallacticAngle = pa
	
	Return r
	
End Sub

' calculations for illumination parameters of the moon, based on
' http://idlastro.gsfc.nasa.gov/ftp/pro/astro/mphase.pro formulas and Chapter 48
' of "Astronomical Algorithms" 2nd edition by Jean Meeus (Willmann-Bell,
' Richmond) 1998.

'Illumination of the moon on given date
'Returns Fraction, phase & angle
Public Sub MoonIllumination(date As Double) As Object

	Dim d As Double = to_Days(date)
	Dim s As DR = sun_coords(d)
	Dim m As RDD = MoonCoords(d)

	' distance from Earth to Sun in km
	Dim sdist As Double = 149598000

	Dim phi As Double = ACos(Sin(s.dec) * Sin(m.dec) + Cos(s.dec) * Cos(m.dec) * Cos(s.ra - m.ra))
	Dim inc As Double = ATan2(sdist * Sin(phi), m.dist - sdist * Cos(phi))
	Dim angle As Double = ATan2(Cos(s.dec * Sin(s.ra - m.ra)), Sin(s.dec) * Cos(m.dec) - Cos(s.dec) * Sin(m.dec) * Cos(s.ra - m.ra))
	    
	Dim r As FPA
	r.fraction = (1 + Cos(inc)) / 2
	
	If angle < 0 Then
		r.phase = 0.5 + 0.5 * inc * -1 / PI
	Else
		r.phase = 0.5 + 0.5 * inc * 1 / PI
	End If
	r.angle = angle
	
	Return r
		
End Sub