B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
'Class module
'Geodesic v2.0
'
'WGS84 UTM <-> Latitude/Longitude conversion.
'Based on the original Geodesic class by Erel (Anywhere Software):
'https://www.b4x.com/android/forum/threads/b4x-class-geodesic-convert-lat-lon-utm-coordinates.30702/
'
'v2.0 replaces the earlier Thomas/GeoTrans longitude-power series with Kruger's series
'in the third flattening n (Karney 2011, "Transverse Mercator with an accuracy of a few
'nanometers", eqs. 12 & 17), so accuracy stays sub-millimetre even several degrees from
'the zone's central meridian - where the old series could be off by tens of metres.
'
'New in v2.0: WGS84LatLonToUTM2(LL, Zone, Hemisphere) lets you force a specific UTM zone
'and/or hemisphere convention, instead of only the automatic values.
'
'Public API:
'  WGS84LatLonToUTM(LL)                       - automatic zone and hemisphere
'  WGS84LatLonToUTM2(LL, Zone, Hemisphere)    - forced zone and/or hemisphere  (new)
'  WGS84UTMTOLatLon(U)                        - UTM -> Latitude/Longitude
Sub Class_Globals
	Private ok = 0.9996, fe = 500000, deg2rad = cPI / 180, rad2deg = 1 / deg2rad As Double
	Type LatLon (Lat As Double, Lon As Double)
	Type UTM (UtmXZone As Int, X As Double, NorthHemisphere As Boolean, Y As Double)

	'--- Precomputed WGS84 constants (filled in Initialize) ---
	Private mEcc As Double				'first eccentricity
	Private mEcc2 As Double				'first eccentricity squared
	Private mKA As Double				'k0 * A  (combined central-meridian scale * rectifying radius)
	Private mAlp(4) As Double			'forward series coefficients alpha_j (Karney eq 12)
	Private mBet(4) As Double			'inverse series coefficients beta_j  (Karney eq 17)
End Sub

Public Sub Initialize
	'WGS84 ellipsoid
	Dim a As Double = 6378137.0
	Dim f As Double = 0.003352810665

	Dim n As Double = f / (2.0 - f)						'third flattening
	Dim n2 As Double = n * n
	Dim n3 As Double = n2 * n
	Dim n4 As Double = n3 * n

	mEcc  = Sqrt(f * (2.0 - f))
	mEcc2 = mEcc * mEcc

	'Rectifying radius factor A (Karney eq 14), pre-multiplied by the central scale k0.
	Dim bigA As Double = a / (1.0 + n) * (1.0 + n2 / 4.0 + n4 / 64.0)
	mKA = ok * bigA

	'Forward series coefficients alpha_j to order n^4 (Karney eq 12)
	mAlp(0) = 0.5 * n - (2.0 / 3.0) * n2 + (5.0 / 16.0) * n3 + (41.0 / 180.0) * n4
	mAlp(1) = (13.0 / 48.0) * n2 - (3.0 / 5.0) * n3 + (557.0 / 1440.0) * n4
	mAlp(2) = (61.0 / 240.0) * n3 - (103.0 / 140.0) * n4
	mAlp(3) = (49561.0 / 161280.0) * n4

	'Inverse series coefficients beta_j to order n^4 (Karney eq 17)
	mBet(0) = 0.5 * n - (2.0 / 3.0) * n2 + (37.0 / 96.0) * n3 - (1.0 / 360.0) * n4
	mBet(1) = (1.0 / 48.0) * n2 + (1.0 / 15.0) * n3 - (437.0 / 1440.0) * n4
	mBet(2) = (17.0 / 480.0) * n3 - (37.0 / 840.0) * n4
	mBet(3) = (4397.0 / 161280.0) * n4
End Sub

Private Sub Fix(d As Double) As Int
	Return d
End Sub

'--- Small hyperbolic / inverse-hyperbolic helpers (B4X has no built-ins for these) ---
'Each computes Power(cE, x) once and reuses it for its reciprocal, halving the exp cost.
Private Sub SinhD(x As Double) As Double
	Dim ex As Double = Power(cE, x)
	Return (ex - 1.0 / ex) / 2.0
End Sub

Private Sub AsinhD(x As Double) As Double
	Return Logarithm(x + Sqrt(x * x + 1), cE)
End Sub

Private Sub AtanhD(x As Double) As Double
	Return 0.5 * Logarithm((1 + x) / (1 - x), cE)
End Sub

'Convert LatLon to UTM using WGS84 datum, with automatic zone calculation.
'Returns: UTM coordinate
'LL - Latitude/Longitude to convert
Public Sub WGS84LatLonToUTM(LL As LatLon) As UTM
	Return LatLonToUTM(LL, 0, 0)
End Sub

'Convert LatLon to UTM using WGS84 datum, with a user-specified zone and hemisphere.
'Returns: UTM coordinate
'LL - Latitude/Longitude to convert
'Zone - UTM zone (1-60) to force; pass 0 for automatic calculation
'Hemisphere - True for northern convention, False for southern convention
Public Sub WGS84LatLonToUTM2(LL As LatLon, Zone As Int, Hemisphere As Boolean) As UTM
	Return LatLonToUTM(LL, Zone, IIf(Hemisphere, 1, -1))
End Sub

'Convert UTM to LatLon using WGS84 datum
Public Sub WGS84UTMTOLatLon(U As UTM) As LatLon
	Return UTMToLatLon(U)
End Sub

'Convert LatLon to UTM (Kruger n-series, forward).
'Zone - UTM zone to force; pass 0 for automatic calculation
'ForceHemisphere - 1 = northern, -1 = southern, 0 = automatic
Private Sub LatLonToUTM(LL As LatLon, Zone As Int, ForceHemisphere As Int) As UTM
	Dim Lat As Double = LL.Lat
	Dim Lon As Double = LL.Lon

	'--- Zone selection (unchanged behaviour) ---
	Dim utmXZone As Int
	If Zone > 0 Then
		utmXZone = Zone
	Else If (Lon <= 0) Then
		utmXZone = 30 + Fix(Lon / 6)
	Else
		utmXZone = 31 + Fix(Lon / 6)
	End If

	Dim res As UTM
	res.Initialize

	'--- Hemisphere selection (unchanged behaviour) ---
	If ForceHemisphere = 0 Then
		res.NorthHemisphere = Lat >= 0
	Else
		res.NorthHemisphere = (ForceHemisphere = 1)
	End If

	Dim olam As Double = (utmXZone * 6 - 183) * deg2rad
	Dim phi As Double = Lat * deg2rad
	Dim lam As Double = Lon * deg2rad - olam
	Dim cosLam As Double = Cos(lam)

	'--- Geographic -> conformal (Karney eqs 8, 9, 7) ---
	Dim tau As Double = Tan(phi)
	Dim sig As Double = SinhD(mEcc * AtanhD(mEcc * tau / Sqrt(1.0 + tau * tau)))
	Dim taup As Double = tau * Sqrt(1.0 + sig * sig) - sig * Sqrt(1.0 + tau * tau)

	'--- Conformal -> spherical TM (Karney eq 10) ---
	Dim xip As Double = ATan2(taup, cosLam)
	Dim etap As Double = AsinhD(Sin(lam) / Sqrt(taup * taup + cosLam * cosLam))

	'--- Kruger rectifying series (Karney eq 11) ---
	'sinh and cosh of the same argument (2j*etap) share a single Power(cE,..) call.
	Dim xi As Double = xip
	Dim eta As Double = etap
	Dim j As Int
	Dim arg As Double
	Dim ex As Double
	Dim emx As Double
	Dim sh As Double
	Dim ch As Double
	For j = 1 To 4
		arg = 2 * j * etap
		ex  = Power(cE, arg)
		emx = 1.0 / ex
		ch  = (ex + emx) / 2.0		'cosh(arg)
		sh  = (ex - emx) / 2.0		'sinh(arg)
		xi  = xi  + mAlp(j - 1) * Sin(2 * j * xip) * ch
		eta = eta + mAlp(j - 1) * Cos(2 * j * xip) * sh
	Next

	'--- Scale to easting/northing (Karney eq 13) ---
	Dim easting As Double = mKA * eta + fe
	Dim northing As Double = mKA * xi
	If Not (res.NorthHemisphere) Then northing = northing + 10000000.0

	res.X = easting
	res.Y = northing
	res.utmXZone = utmXZone
	Return res
End Sub

'Convert UTM to LatLon (Kruger n-series, inverse).
Private Sub UTMToLatLon(U As UTM) As LatLon
	Dim nfn As Double
	If Not (U.NorthHemisphere) Then nfn = 10000000.0 Else nfn = 0.0

	'--- Unscale (Karney eq 15) ---
	Dim eta As Double = (U.X - fe) / mKA
	Dim xi As Double = (U.Y - nfn) / mKA

	'--- Inverse Kruger series (Karney eq 16) ---
	'sinh and cosh of the same argument (2j*eta) share a single Power(cE,..) call.
	Dim xip As Double = xi
	Dim etap As Double = eta
	Dim j As Int
	Dim arg As Double
	Dim ex As Double
	Dim emx As Double
	Dim sh As Double
	Dim ch As Double
	For j = 1 To 4
		arg = 2 * j * eta
		ex  = Power(cE, arg)
		emx = 1.0 / ex
		ch  = (ex + emx) / 2.0		'cosh(arg)
		sh  = (ex - emx) / 2.0		'sinh(arg)
		xip  = xip  - mBet(j - 1) * Sin(2 * j * xi) * ch
		etap = etap - mBet(j - 1) * Cos(2 * j * xi) * sh
	Next

	'--- Spherical TM -> conformal (Karney eq 18) ---
	Dim sinhEtap As Double = SinhD(etap)
	Dim cosXip As Double = Cos(xip)
	Dim taup As Double = Sin(xip) / Sqrt(sinhEtap * sinhEtap + cosXip * cosXip)
	Dim lam As Double = ATan2(sinhEtap, cosXip)

	'--- Conformal -> geographic latitude, Newton on eq 7 (Karney eqs 19-21) ---
	Dim tau As Double = taup
	Dim sig As Double
	Dim taupi As Double
	Dim dtau As Double
	Dim i As Int
	'Newton converges to round-off after 2 iterations (Karney); 3 gives a safety margin.
	For i = 1 To 3
		sig = SinhD(mEcc * AtanhD(mEcc * tau / Sqrt(1.0 + tau * tau)))
		taupi = tau * Sqrt(1.0 + sig * sig) - sig * Sqrt(1.0 + tau * tau)
		dtau = (taup - taupi) * (1.0 + (1.0 - mEcc2) * tau * tau) _
			/ ((1.0 - mEcc2) * Sqrt(1.0 + tau * tau) * Sqrt(1.0 + taupi * taupi))
		tau = tau + dtau
	Next

	Dim phi As Double = ATan(tau)
	Dim olam As Double = (U.UtmXZone * 6 - 183.0) * deg2rad

	Dim ll As LatLon
	ll.Initialize
	ll.Lat = phi * rad2deg
	ll.Lon = (lam + olam) * rad2deg
	Return ll
End Sub
