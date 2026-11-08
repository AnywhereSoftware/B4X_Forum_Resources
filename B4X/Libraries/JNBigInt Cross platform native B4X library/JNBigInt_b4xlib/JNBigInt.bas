B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' Class module: JNBigInt
Sub Class_Globals
	Private Const BASE As Long = 1000000000
	Private Const BASE_DIGITS As Int = 9
	Private Const KARATSUBA_THRESHOLD As Int = 32

	Private mSign As Int
	Private mDigits() As Int
	Private mLen As Int
End Sub

Public Sub Initialize
	mSign = 0
	mLen = 0
	mDigits = Alloc(0)
End Sub

' ************ Setup subs
Public Sub SetFromInt(v As Int) As JNBigInt
	mLen = 0
	If v = 0 Then
		mSign = 0
		Return Me
	End If
	Dim absV As Long
	If v < 0 Then
		mSign = -1
		absV = 0 - CLng(v)
	Else
		mSign = 1
		absV = CLng(v)
	End If
	Do While absV > 0
		AppendDigit(absV Mod BASE)
		absV = absV / BASE
	Loop
	Return Me
End Sub

Public Sub SetFromString(text As String) As JNBigInt
	text = text.Trim
	mLen = 0

	If text.Length = 0 Then
		mSign = 0
		Return Me
	End If

	Dim Sign As Int = 1
	Dim p As Int = 0
	Dim ch As String = text.CharAt(0)
	If ch = "-" Then
		Sign = -1
		p = 1
	Else If ch = "+" Then
		p = 1
	End If

	' strip leading zeros
	Do While p < text.Length And text.CharAt(p) = "0"
		p = p + 1
	Loop

	If p >= text.Length Then
		mSign = 0
		Return Me
	End If

	Dim body As String = text.SubString(p)

	' parse in BASE_DIGITS chunks from right to left
	Dim i As Int = body.Length
	Do While i > 0
		Dim start As Int = Max(0, i - BASE_DIGITS)
		Dim chunk As String = body.SubString2(start, i)
		i = start
		If IsNumber(chunk) Then
			Dim v As Int = chunk
			AppendDigit(v)
		Else
			mLen = 0
			mSign = 0
			Return Me
		End If
	Loop

	mSign = Sign
	Normalize
	Return Me
End Sub

Public Sub IsZero As Boolean
	Return mSign = 0
End Sub

Public Sub getSign As Int
	Return mSign
End Sub

Public Sub ToString As String
	If mSign = 0 Then Return "0"

	Dim sb As StringBuilder
	sb.Initialize
	If mSign < 0 Then sb.Append("-")

	Dim i As Int = mLen - 1
	sb.Append(mDigits(i))

	For i = i - 1 To 0 Step -1
		Dim v As Int = mDigits(i)
		sb.Append(PadChunk(v))
	Next

	Return sb.ToString
End Sub

Private Sub PadChunk(v As Int) As String
	Dim s As String = NumberFormat2(v, 1, 0, 0, False)
	Do While s.Length < BASE_DIGITS
		s = "0" & s
	Loop
	Return s
End Sub

Public Sub CompareTo(other As JNBigInt) As Int
	If mSign < other.mSign Then Return -1
	If mSign > other.mSign Then Return 1
	If mSign = 0 Then Return 0

	Dim self As JNBigInt = Me
	Dim cmpAbs As Int = CompareAbs(self, other)
	If mSign > 0 Then
		Return cmpAbs
	Else
		Return -cmpAbs
	End If
End Sub

Private Sub CompareAbs(a As JNBigInt, b As JNBigInt) As Int
	Dim alen As Int = SafeLen(a)
	Dim blen As Int = SafeLen(b)

	If alen < blen Then Return -1
	If alen > blen Then Return 1
	For i = alen - 1 To 0 Step -1
		Dim av As Int = a.mDigits(i)
		Dim bv As Int = b.mDigits(i)
		If av < bv Then Return -1
		If av > bv Then Return 1
	Next
	Return 0
End Sub

Public Sub Add(other As JNBigInt) As JNBigInt
	If mSign = 0 Then Return other.Clone
	If other.mSign = 0 Then Return Clone

	If mSign = other.mSign Then
		Dim r As JNBigInt = AddAbs(Me, other)
		r.mSign = mSign
		Return r
	Else
		Dim cmp As Int = CompareAbs(Me, other)
		If cmp = 0 Then
			Dim r As JNBigInt
			r.Initialize
			Return r
		Else If cmp > 0 Then
			Dim r As JNBigInt = SubAbs(Me, other)
			r.mSign = mSign
			Return r
		Else
			Dim r As JNBigInt = SubAbs(other, Me)
			r.mSign = other.mSign
			Return r
		End If
	End If
End Sub

Public Sub Subtract(other As JNBigInt) As JNBigInt
	Dim neg As JNBigInt = other.Clone
	neg.mSign = -neg.mSign
	Return Add(neg)
End Sub

Public Sub Multiply(other As JNBigInt) As JNBigInt
	If mSign = 0 Or other.mSign = 0 Then
		Dim z As JNBigInt
		z.Initialize
		Return z
	End If

	Dim a As JNBigInt = Clone
	Dim b As JNBigInt = other.Clone
	a.mSign = 1
	b.mSign = 1

	Dim r As JNBigInt = MulKaratsuba(a, b)
	If mSign = other.mSign Then
		r.mSign = 1
	Else
		r.mSign = -1
	End If
	r.Normalize
	Return r
End Sub

Public Sub DivMod(other As JNBigInt) As Map
	Dim result As Map
	result.Initialize

	Dim zero As JNBigInt
	zero.Initialize

	If other.mSign = 0 Then
		Log("JNBigInt.DivMod: division by zero")
		result.Put("q", zero)
		result.Put("r", zero.Clone)
		Return result
	End If

	If mSign = 0 Then
		result.Put("q", zero)
		result.Put("r", zero.Clone)
		Return result
	End If

	Dim a As JNBigInt = Clone
	Dim b As JNBigInt = other.Clone
	a.mSign = 1
	b.mSign = 1

	Dim cmp As Int = CompareAbs(a, b)

	If cmp < 0 Then
		Dim q As JNBigInt
		q.Initialize
		Dim r As JNBigInt = Clone
		result.Put("q", q)
		result.Put("r", r)
		Return result
	End If

	If cmp = 0 Then
		Dim q As JNBigInt
		q.Initialize
		q.SetFromInt(1)
		If mSign = other.mSign Then
			q.mSign = 1
		Else
			q.mSign = -1
		End If
		Dim r As JNBigInt
		r.Initialize
		result.Put("q", q)
		result.Put("r", r)
		Return result
	End If

	Dim absRes As Map = DivModAbs(a, b)
	Dim qAbs As JNBigInt = absRes.Get("q")
	Dim rAbs As JNBigInt = absRes.Get("r")

	If mSign = other.mSign Then
		qAbs.mSign = 1
	Else
		qAbs.mSign = -1
	End If

	If rAbs.IsZero Then
		rAbs.mSign = 0
	Else
		If mSign > 0 Then
			rAbs.mSign = 1
		Else
			rAbs.mSign = -1
		End If
	End If

	result.Put("q", qAbs)
	result.Put("r", rAbs)
	Return result
End Sub

Public Sub Divide(other As JNBigInt) As JNBigInt
	Dim res As Map = DivMod(other)
	Dim q As JNBigInt = res.Get("q")
	Return q
End Sub

Public Sub Remainder(other As JNBigInt) As JNBigInt
	Dim res As Map = DivMod(other)
	Dim r As JNBigInt = res.Get("r")
	Return r
End Sub

Public Sub Gcd(other As JNBigInt) As JNBigInt
	Dim a As JNBigInt = Clone
	Dim b As JNBigInt = other.Clone

	If a.mSign < 0 Then a.mSign = 1
	If b.mSign < 0 Then b.mSign = 1

	If a.IsZero And b.IsZero Then
		Dim z As JNBigInt
		z.Initialize
		Return z
	End If

	If a.IsZero Then Return b
	If b.IsZero Then Return a

	Do While Not (b.IsZero)
		Dim dm As Map = a.DivMod(b)
		Dim r As JNBigInt = dm.Get("r")
		a = b
		b = r
	Loop

	a.mSign = 1
	Return a
End Sub

Public Sub ModInverse(m As JNBigInt) As JNBigInt
	Dim zero As JNBigInt
	zero.Initialize
	zero.SetFromInt(0)

	Dim one As JNBigInt
	one.Initialize
	one.SetFromInt(1)

	Dim modCopy As JNBigInt = m.Clone
	If modCopy.mSign <= 0 Then
		Dim z As JNBigInt
		z.Initialize
		Return z
	End If

	Dim a As JNBigInt = Remainder(modCopy)
	If a.mSign < 0 Then a = a.Add(modCopy)

	Dim g As JNBigInt = a.Gcd(modCopy)
	If g.CompareTo(one) <> 0 Then
		Dim z2 As JNBigInt
		z2.Initialize
		Return z2
	End If

	Dim r As JNBigInt = modCopy.Clone
	Dim newR As JNBigInt = a.Clone

	Dim t As JNBigInt
	t.Initialize
	t.SetFromInt(0)

	Dim newT As JNBigInt
	newT.Initialize
	newT.SetFromInt(1)

	Do While Not (newR.IsZero)
		Dim dm As Map = r.DivMod(newR)
		Dim q As JNBigInt = dm.Get("q")
		Dim rem As JNBigInt = dm.Get("r")

		Dim tempT As JNBigInt = t.Subtract(q.Multiply(newT))
		t = newT
		newT = tempT

		r = newR
		newR = rem
	Loop

	If r.CompareTo(one) <> 0 Then
		Dim z3 As JNBigInt
		z3.Initialize
		Return z3
	End If

	If t.mSign < 0 Then t = t.Add(modCopy)

	t = t.Remainder(modCopy)
	If t.mSign < 0 Then t = t.Add(modCopy)

	Return t
End Sub

Private Sub QuickCompositeCheck(n As JNBigInt) As Boolean
	If n.mSign <= 0 Then Return False
	If n.mLen = 1 Then
		Dim val As Int = n.mDigits(0)
		If val <= 3 Then Return False
	End If

	Dim smallPrimes() As Int = Array As Int( _
        3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97, _
        101,103,107,109,113,127,131,137,139,149,151,157,163,167,173,179,181,191,193,197,199, _
        211,223,227,229,233,239,241,251,257,263,269,271,277,281,283,293,307,311,313,317, _
        331,337,347,349,353,359,367,373,379,383,389,397,401,409,419,421,431,433,439,443, _
        449,457,461,463,467,479,487,491,499,503,509,521,523,541)

	Dim val As Int
	If n.mLen = 1 And n.mSign > 0 Then
		val = n.mDigits(0)
	Else
		val = -1
	End If

	For Each sp As Int In smallPrimes
		If val = sp Then Return False
		Dim rem As Int = n.ModSmallInt(sp)
		If rem = 0 Then Return True
	Next

	Return False
End Sub

Public Sub IsProbablePrime(certainty As Int) As Boolean
	If mSign <= 0 Then Return False

	Dim one As JNBigInt
	one.Initialize
	one.SetFromInt(1)

	Dim two As JNBigInt
	two.Initialize
	two.SetFromInt(2)

	Dim three As JNBigInt
	three.Initialize
	three.SetFromInt(3)

	Dim self As JNBigInt = Me

	Dim cmp2 As Int = self.CompareTo(two)
	If cmp2 < 0 Then
		Return False
	Else If cmp2 = 0 Then
		Return True
	End If

	Dim cmp3 As Int = self.CompareTo(three)
	If cmp3 = 0 Then Return True

	Dim rem2 As JNBigInt = self.Remainder(two)
	If rem2.IsZero Then Return False

	Dim nMinus1 As JNBigInt = self.Subtract(one)
	Dim d As JNBigInt = nMinus1.Clone
	Dim s As Int = 0
	Dim r As JNBigInt

	Do While True
		r = d.Remainder(two)
		If r.IsZero = False Then Exit
		d = d.Divide(two)
		s = s + 1
	Loop

	If certainty <= 0 Then certainty = 3

	Dim bases() As Int = Array As Int(2, 3, 5, 7, 11, 13, 17, 19, 23, 29)
	Dim tests As Int = 0

	For Each aInt As Int In bases
		If tests >= certainty Then Exit

		Dim a As JNBigInt
		a.Initialize
		a.SetFromInt(aInt)

		If a.CompareTo(nMinus1) >= 0 Then Continue

		If Not (MillerRabinWitness(a, self, d, s)) Then
			Return False
		End If

		tests = tests + 1
	Next

	Return True
End Sub

Public Sub NextProbablePrime As JNBigInt
	Dim two As JNBigInt
	two.Initialize
	two.SetFromInt(2)

	Dim one As JNBigInt
	one.Initialize
	one.SetFromInt(1)

	Dim n As JNBigInt

	If mSign <= 0 Then
		n.Initialize
		n.SetFromInt(2)
	Else
		n = Clone
		Dim cmp2 As Int = n.CompareTo(two)
		If cmp2 <= 0 Then
			n = two
		Else
			Dim rem2 As JNBigInt = n.Remainder(two)
			If rem2.IsZero Then n = n.Add(one)
		End If
	End If

	Dim bitLen As Int = n.ToBinaryString.Length
	Dim rounds As Int
	If bitLen <= 256 Then
		rounds = 3
	Else If bitLen <= 512 Then
		rounds = 4
	Else If bitLen <= 1024 Then
		rounds = 5
	Else
		rounds = 6
	End If

	Do While True
		If Not (QuickCompositeCheck(n)) Then
			If n.IsProbablePrime(rounds) Then Return n
		End If
		n = n.Add(two)
	Loop

	Return n
End Sub

Public Sub RandomJNBigInt(bitCount As Int) As JNBigInt
	If bitCount <= 0 Then
		Dim z As JNBigInt
		z.Initialize
		Return z
	End If

	Dim bytes As Int = (bitCount + 7) / 8
	Dim buffer(bytes) As Byte

	For i = 0 To bytes - 1
		buffer(i) = Rnd(0, 256)
	Next

	Dim msbBit As Int = bitCount Mod 8
	If msbBit = 0 Then msbBit = 8
	Dim mask As Int = Bit.ShiftLeft(1, msbBit - 1)
	buffer(0) = Bit.Or(buffer(0), mask)

	Dim r As JNBigInt
	r.Initialize

	Dim base256 As JNBigInt
	base256.Initialize
	base256.SetFromInt(256)

	For Each b As Byte In buffer
		r = r.Multiply(base256)
		Dim bb As JNBigInt
		bb.Initialize
		bb.SetFromInt(Bit.And(b, 0xFF))
		r = r.Add(bb)
	Next

	r.mSign = 1
	r.Normalize
	Return r
End Sub

Public Sub GeneratePrime(bitCount As Int) As JNBigInt
	Dim one As JNBigInt
	one.Initialize
	one.SetFromInt(1)

	If bitCount < 2 Then bitCount = 2

	Dim rounds As Int
	If bitCount <= 256 Then
		rounds = 3
	Else If bitCount <= 512 Then
		rounds = 4
	Else If bitCount <= 1024 Then
		rounds = 5
	Else
		rounds = 6
	End If

	Do While True
		Dim p As JNBigInt = RandomJNBigInt(bitCount)

		If (p.mDigits(0) Mod 2) = 0 Then
			p = p.Add(one)
		End If

		If QuickCompositeCheck(p) Then Continue

		If p.IsProbablePrime(rounds) Then
			Return p
		End If
	Loop
	
	Return Me
End Sub

Public Sub GenerateRSAKeyPair(keyBits As Int) As Map
	If keyBits < 16 Then keyBits = 16
	Dim halfBits As Int = keyBits / 2
	If halfBits < 8 Then halfBits = 8

	Dim one As JNBigInt
	one.Initialize
	one.SetFromInt(1)

	Dim e As JNBigInt
	e.Initialize
	e.SetFromInt(65537)

	Dim p As JNBigInt
	Dim q As JNBigInt
	Dim n As JNBigInt
	Dim phi As JNBigInt
	Dim d As JNBigInt

	Do While True
		p = GeneratePrime(halfBits)

		Do While True
			q = GeneratePrime(halfBits)
			If p.CompareTo(q) <> 0 Then Exit
		Loop

		n = p.Multiply(q)

		Dim p1 As JNBigInt = p.Subtract(one)
		Dim q1 As JNBigInt = q.Subtract(one)
		phi = p1.Multiply(q1)

		Dim g As JNBigInt = e.Gcd(phi)
		If g.CompareTo(one) = 0 Then Exit
	Loop

	d = e.ModInverse(phi)

	Dim result As Map
	result.Initialize
	result.Put("n", n)
	result.Put("e", e)
	result.Put("d", d)
	result.Put("p", p)
	result.Put("q", q)
	Return result
End Sub

Public Sub AndBits(other As JNBigInt) As JNBigInt
	Return BitwiseCore(Me, other, "AND")
End Sub

Public Sub OrBits(other As JNBigInt) As JNBigInt
	Return BitwiseCore(Me, other, "OR")
End Sub

Public Sub XorBits(other As JNBigInt) As JNBigInt
	Return BitwiseCore(Me, other, "XOR")
End Sub

Public Sub NotBits As JNBigInt
	Dim s As String = ToBinaryString

	Dim sb As StringBuilder
	sb.Initialize
	For i = 0 To s.Length - 1
		sb.Append(IIf(s.CharAt(i) = "0", "1", "0"))
	Next

	Dim r As JNBigInt = FromBinaryString(sb.ToString)
	r.mSign = 1
	r.Normalize
	Return r
End Sub

Public Sub ShiftLeft(n As Int) As JNBigInt
	If n <= 0 Then Return Clone
	Dim s As String = ToBinaryString
	Return FromBinaryString(s & RepeatChar("0", n))
End Sub

Public Sub ShiftRight(n As Int) As JNBigInt
	If n <= 0 Then Return Clone
	Dim s As String = ToBinaryString
	If n >= s.Length Then
		Dim z As JNBigInt
		z.Initialize
		Return z
	End If
	Return FromBinaryString(s.SubString(n))
End Sub

Private Sub IsOdd(x As JNBigInt) As Boolean
	If x.mSign = 0 Then Return False
	Return (x.mDigits(0) Mod 2) <> 0
End Sub

Private Sub DivBy2(x As JNBigInt) As JNBigInt
	Dim r As JNBigInt
	r.Initialize

	If x.mSign = 0 Or x.mLen = 0 Then
		r.mSign = 0
		Return r
	End If

	Dim size As Int = x.mLen
	Dim tmp() As Int = Alloc(size)

	Dim carry As Int = 0
	For i = size - 1 To 0 Step -1
		Dim cur As Long = carry * BASE + x.mDigits(i)
		Dim qdigit As Int = cur / 2
		carry = cur Mod 2
		tmp(i) = qdigit
	Next

	r.mDigits = tmp
	r.mLen = size
	r.mSign = x.mSign
	r.Normalize
	Return r
End Sub

Private Sub AddAbs(a As JNBigInt, b As JNBigInt) As JNBigInt
	Dim r As JNBigInt
	r.Initialize
	r.mSign = 1
	Dim maxLen As Int = Max(a.mLen, b.mLen)
	r.EnsureCapacity(maxLen + 1)

	Dim carry As Long = 0
	For i = 0 To maxLen - 1
		Dim av As Long = 0, bv As Long = 0
		If i < a.mLen Then av = a.mDigits(i)
		If i < b.mLen Then bv = b.mDigits(i)
		Dim sum As Long = av + bv + carry
		If sum >= BASE Then
			sum = sum - BASE
			carry = 1
		Else
			carry = 0
		End If
		r.mDigits(i) = sum
	Next
	r.mLen = maxLen
	If carry <> 0 Then
		r.mDigits(r.mLen) = 1
		r.mLen = r.mLen + 1
	End If
	r.Normalize
	Return r
End Sub

Private Sub SubAbs(a As JNBigInt, b As JNBigInt) As JNBigInt
	Dim r As JNBigInt
	r.Initialize

	Dim alen As Int = SafeLen(a)
	Dim blen As Int = SafeLen(b)

	r.EnsureCapacity(alen)
	r.mLen = alen

	Dim borrow As Int = 0
	For i = 0 To alen - 1
		Dim av As Int = a.mDigits(i)
		Dim bv As Int = 0
		If i < blen Then bv = b.mDigits(i)

		Dim diff As Int = av - bv - borrow
		If diff < 0 Then
			diff = diff + BASE
			borrow = 1
		Else
			borrow = 0
		End If
		r.mDigits(i) = diff
	Next

	r.mSign = 1
	r.Normalize
	Return r
End Sub

Private Sub MulClassic(a As JNBigInt, b As JNBigInt) As JNBigInt
	Dim r As JNBigInt
	r.Initialize
	r.mSign = 1
	r.EnsureCapacity(a.mLen + b.mLen + 1)
	r.mLen = a.mLen + b.mLen + 1

	For i = 0 To a.mLen - 1
		Dim carry As Long = 0
		Dim av As Long = a.mDigits(i)
		For j = 0 To b.mLen - 1
			Dim idx As Int = i + j
			Dim cur As Long = r.mDigits(idx)
			Dim prod As Long = av * CLng(b.mDigits(j))
			Dim tmp As Long = cur + prod + carry
			r.mDigits(idx) = tmp Mod BASE
			carry = tmp / BASE
		Next
		Dim k As Int = i + b.mLen
		Do While carry <> 0
			Dim tmp2 As Long = CLng(r.mDigits(k)) + carry
			r.mDigits(k) = tmp2 Mod BASE
			carry = tmp2 / BASE
			k = k + 1
		Loop
	Next

	r.Normalize
	Return r
End Sub

Private Sub SliceDigits(a As JNBigInt, fromIdx As Int, length As Int) As JNBigInt
	Dim r As JNBigInt
	r.Initialize
	If length <= 0 Or fromIdx >= a.mLen Then Return r
	Dim endIdx As Int = Min(a.mLen, fromIdx + length)
	For i = fromIdx To endIdx - 1
		r.AppendDigit(a.mDigits(i))
	Next
	r.mSign = IIf(r.mLen = 0, 0, 1)
	r.Normalize
	Return r
End Sub

Private Sub ShiftDigits(a As JNBigInt, k As Int) As JNBigInt
	Dim r As JNBigInt
	r.Initialize
	If a.IsZero Then Return r
	For i = 1 To k
		r.AppendDigit(0)
	Next
	For i = 0 To a.mLen - 1
		r.AppendDigit(a.mDigits(i))
	Next
	r.mSign = a.mSign
	Return r
End Sub

Private Sub MulKaratsuba(a As JNBigInt, b As JNBigInt) As JNBigInt
	If a.IsZero Or b.IsZero Then
		Dim z As JNBigInt
		z.Initialize
		Return z
	End If

	Dim n As Int = Max(a.mLen, b.mLen)
	If n <= KARATSUBA_THRESHOLD Then Return MulClassic(a, b)

	Dim m As Int = n / 2

	Dim a0 As JNBigInt = SliceDigits(a, 0, m)
	Dim a1 As JNBigInt = SliceDigits(a, m, a.mLen - m)

	Dim b0 As JNBigInt = SliceDigits(b, 0, m)
	Dim b1 As JNBigInt = SliceDigits(b, m, b.mLen - m)

	Dim z0 As JNBigInt = MulKaratsuba(a0, b0)
	Dim z2 As JNBigInt = MulKaratsuba(a1, b1)

	Dim a0pa1 As JNBigInt = a0.Add(a1)
	Dim b0pb1 As JNBigInt = b0.Add(b1)
	Dim z1 As JNBigInt = MulKaratsuba(a0pa1, b0pb1)
	z1 = z1.Subtract(z0)
	z1 = z1.Subtract(z2)

	Dim r As JNBigInt
	r.Initialize
	Dim z1Shift As JNBigInt = ShiftDigits(z1, m)
	Dim z2Shift As JNBigInt = ShiftDigits(z2, 2 * m)
	r = z0.Add(z1Shift)
	r = r.Add(z2Shift)
	r.mSign = 1
	r.Normalize
	Return r
End Sub

Private Sub ModSmallInt(m As Int) As Int
	If m <= 0 Then Return 0
	If mSign = 0 Then Return 0

	Dim rem As Long = 0
	For i = mLen - 1 To 0 Step -1
		Dim d As Int = mDigits(i)
		rem = (rem * BASE + d) Mod m
	Next

	If mSign < 0 Then
		rem = rem Mod m
		If rem <> 0 Then
			rem = m - rem
			If rem = m Then rem = 0
		End If
	End If

	Return rem
End Sub

Private Sub DivModByIntAbs(a As JNBigInt, d As Int) As Map
	Dim res As Map: res.Initialize
	Dim q As JNBigInt: q.Initialize
	q.mSign = 1
	q.EnsureCapacity(a.mLen)
	q.mLen = a.mLen
	
	Dim rem As Long = 0
	For i = a.mLen - 1 To 0 Step -1
		Dim cur As Long = rem * BASE + a.mDigits(i)
		Dim qdigit As Long = cur / d
		rem = cur Mod d
		q.mDigits(i) = qdigit
	Next
	q.Normalize
	
	Dim r As JNBigInt: r.Initialize
	If rem <> 0 Then
		r.mSign = 1
		r.AppendDigit(rem)
	End If
	
	res.Put("q", q)
	res.Put("r", r)
	Return res
End Sub

Private Sub MulArrayByInt(src() As Int, srcLen As Int, m As Long, extraLeadingZero As Boolean) As Int()
	Dim outLen As Int = srcLen + IIf(extraLeadingZero, 1, 0)
	Dim out() As Int = Alloc(outLen)
	Dim carry As Long = 0
	For i = 0 To srcLen - 1
		Dim t As Long = CLng(src(i)) * m + carry
		out(i) = t Mod BASE
		carry = t / BASE
	Next
	If extraLeadingZero Then out(srcLen) = carry
	Return out
End Sub

Private Sub DivArrayByInt(src() As Int, srcLen As Int, d As Long) As Int()
	Dim out() As Int = Alloc(srcLen)
	Dim rem As Long = 0
	For i = srcLen - 1 To 0 Step -1
		Dim cur As Long = rem * BASE + src(i)
		out(i) = cur / d
		rem = cur Mod d
	Next
	Return out
End Sub

Private Sub DivModAbs(a As JNBigInt, b As JNBigInt) As Map
	Dim result As Map: result.Initialize
	
	If b.mLen = 1 Then Return DivModByIntAbs(a, b.mDigits(0))

	Dim n As Int = b.mLen
	Dim m As Int = a.mLen - n

	Dim vHigh As Long = b.mDigits(n - 1)
	Dim f As Long = BASE / (vHigh + 1)

	Dim u() As Int = MulArrayByInt(a.mDigits, a.mLen, f, True)
	Dim v() As Int = MulArrayByInt(b.mDigits, b.mLen, f, False)

	Dim qDigits() As Int = Alloc(m + 1)

	For j = m To 0 Step -1
		Dim ujn As Long = u(j + n)
		Dim ujn1 As Long = u(j + n - 1)
		Dim num As Long = ujn * BASE + ujn1
		Dim den As Long = v(n - 1)

		Dim qhat As Long = num / den
		Dim rhat As Long = num Mod den
		If qhat >= BASE Then qhat = BASE - 1

		If n >= 2 Then
			Do While qhat * CLng(v(n - 2)) > (rhat * BASE + u(j + n - 2))
				qhat = qhat - 1
				rhat = rhat + den
				If rhat >= BASE Then Exit
			Loop
		End If

		Dim borrow As Long = 0
		Dim carry As Long = 0

		For i = 0 To n - 1
			Dim p As Long = qhat * CLng(v(i)) + carry
			carry = p / BASE
			p = p Mod BASE

			Dim t As Long = CLng(u(j + i)) - p - borrow
			If t < 0 Then
				t = t + BASE
				borrow = 1
			Else
				borrow = 0
			End If
			u(j + i) = t
		Next

		Dim t2 As Long = CLng(u(j + n)) - carry - borrow
		If t2 < 0 Then
			qhat = qhat - 1
			Dim c As Long = 0
			For i = 0 To n - 1
				Dim s As Long = CLng(u(j + i)) + v(i) + c
				If s >= BASE Then
					s = s - BASE
					c = 1
				Else
					c = 0
				End If
				u(j + i) = s
			Next
			u(j + n) = u(j + n) + c
		Else
			u(j + n) = t2
		End If

		qDigits(j) = qhat
	Next

	Dim q As JNBigInt: q.Initialize
	q.mSign = 1
	q.mDigits = qDigits
	q.mLen = qDigits.Length
	q.Normalize
	
	Dim rNorm() As Int = Alloc(n)
	For i = 0 To n - 1
		rNorm(i) = u(i)
	Next
	Dim rDigits() As Int = DivArrayByInt(rNorm, n, f)

	Dim r As JNBigInt: r.Initialize
	r.mSign = 1
	r.mDigits = rDigits
	r.mLen = rDigits.Length
	r.Normalize
	
	result.Put("q", q)
	result.Put("r", r)
	Return result
End Sub

Private Sub ToBinaryString As String
	If mSign = 0 Then Return "0"

	Dim sb As StringBuilder
	sb.Initialize

	Dim x As JNBigInt = Clone
	x.mSign = 1

	Dim two As JNBigInt
	two.Initialize
	two.SetFromInt(2)

	Do While x.mSign <> 0
		Dim res As Map = x.DivMod(two)
		Dim q As JNBigInt = res.Get("q")
		Dim r As JNBigInt = res.Get("r")
		sb.Append(r.ToString)
		x = q
	Loop

	Return ReverseString(sb.ToString)
End Sub

Private Sub ReverseString(s As String) As String
	Dim sb As StringBuilder
	sb.Initialize
	For i = s.Length - 1 To 0 Step -1
		sb.Append(s.CharAt(i))
	Next
	Return sb.ToString
End Sub

Private Sub FromBinaryString(bin As String) As JNBigInt
	Dim r As JNBigInt
	r.Initialize
	r.SetFromInt(0)

	If bin.Length = 0 Then Return r

	Dim two As JNBigInt
	two.Initialize
	two.SetFromInt(2)

	Dim one As JNBigInt
	one.Initialize
	one.SetFromInt(1)

	For i = 0 To bin.Length - 1
		r = r.Multiply(two)
		If bin.CharAt(i) = "1" Then
			r = r.Add(one)
		End If
	Next

	Return r
End Sub

Private Sub PadLeft(s As String, totalLength As Int, padChar As String) As String
	Do While s.Length < totalLength
		s = padChar & s
	Loop
	Return s
End Sub

Private Sub RepeatChar(ch As String, count As Int) As String
	Dim sb As StringBuilder
	sb.Initialize
	For i = 1 To count
		sb.Append(ch)
	Next
	Return sb.ToString
End Sub

Private Sub BitwiseCore(a As JNBigInt, b As JNBigInt, op As String) As JNBigInt
	Dim sa As String = a.ToBinaryString
	Dim sb As String = b.ToBinaryString

	Dim maxLen As Int = Max(sa.Length, sb.Length)
	sa = PadLeft(sa, maxLen, "0")
	sb = PadLeft(sb, maxLen, "0")

	Dim sbOut As StringBuilder
	sbOut.Initialize

	For i = 0 To maxLen - 1
		Dim ba As String = sa.CharAt(i)
		Dim bb As String = sb.CharAt(i)
		Dim out As String

		Select op
			Case "AND"
				out = IIf(ba = "1" And bb = "1", "1", "0")
			Case "OR"
				out = IIf(ba = "1" Or bb = "1", "1", "0")
			Case "XOR"
				out = IIf(ba <> bb, "1", "0")
		End Select

		sbOut.Append(out)
	Next

	Dim result As JNBigInt = FromBinaryString(sbOut.ToString)
	result.mSign = 1
	result.Normalize
	Return result
End Sub

Private Sub ModPow(b As JNBigInt, e As JNBigInt, modulus As JNBigInt) As JNBigInt
	Dim one As JNBigInt
	one.Initialize
	one.SetFromInt(1)

	If modulus.mSign = 0 Then
		Dim r0 As JNBigInt
		r0.Initialize
		Return r0
	End If

	Dim result As JNBigInt
	result.Initialize
	result.SetFromInt(1)

	Dim baseR As JNBigInt = b.Remainder(modulus)
	If baseR.mSign < 0 Then baseR = baseR.Add(modulus)

	Dim exp As JNBigInt = e.Clone
	exp.mSign = 1

	Do While Not (exp.IsZero)
		If IsOdd(exp) Then
			result = result.Multiply(baseR)
			result = result.Remainder(modulus)
		End If

		exp = DivBy2(exp)
		If exp.IsZero Then Exit

		baseR = baseR.Multiply(baseR)
		baseR = baseR.Remainder(modulus)
	Loop

	Return result
End Sub

Private Sub MillerRabinWitness(a As JNBigInt, n As JNBigInt, d As JNBigInt, s As Int) As Boolean
	Dim one As JNBigInt
	one.Initialize
	one.SetFromInt(1)

	Dim nMinus1 As JNBigInt = n.Subtract(one)

	Dim x As JNBigInt = ModPow(a, d, n)
	If x.CompareTo(one) = 0 Or x.CompareTo(nMinus1) = 0 Then Return True

	For r = 1 To s - 1
		x = x.Multiply(x)
		x = x.Remainder(n)
		If x.CompareTo(nMinus1) = 0 Then Return True
	Next

	Return False
End Sub

Public Sub ToHex As String
	If mSign = 0 Then Return "0"

	Dim bin As String = ToBinaryString
	Do While (bin.Length Mod 4) <> 0
		bin = "0" & bin
	Loop

	Dim sb As StringBuilder
	sb.Initialize
	For i = 0 To bin.Length - 1 Step 4
		Dim chunk As String = bin.SubString2(i, i + 4)
		Dim v As Int = 0
		If chunk.CharAt(0) = "1" Then v = v + 8
		If chunk.CharAt(1) = "1" Then v = v + 4
		If chunk.CharAt(2) = "1" Then v = v + 2
		If chunk.CharAt(3) = "1" Then v = v + 1
		If v < 10 Then
			sb.Append(Chr(Asc("0") + v))
		Else
			sb.Append(Chr(Asc("A") + (v - 10)))
		End If
	Next
	Return sb.ToString
End Sub

Public Sub FromHex(hex As String) As JNBigInt
	Dim s As String = hex.Trim.ToUpperCase
	If s.Length = 0 Then
		Dim z As JNBigInt
		z.Initialize
		Return z
	End If

	Dim sb As StringBuilder
	sb.Initialize
	For i = 0 To s.Length - 1
		Dim ch As String = s.CharAt(i)
		Dim v As Int
		If ch >= "0" And ch <= "9" Then
			v = Asc(ch) - Asc("0")
		Else If ch >= "A" And ch <= "F" Then
			v = 10 + Asc(ch) - Asc("A")
		Else
			Continue
		End If
		Dim bits As String = ToBinaryStringFixed(v, 4)
		sb.Append(bits)
	Next

	Dim bin As String = sb.ToString
	Dim p As Int = 0
	Do While p < bin.Length - 1 And bin.CharAt(p) = "0"
		p = p + 1
	Loop
	bin = bin.SubString(p)

	Dim r As JNBigInt = FromBinaryString(bin)
	r.mSign = 1
	r.Normalize
	Return r
End Sub

Public Sub ToBase64 As String
	Dim bin As String = ToBinaryString
	Do While (bin.Length Mod 6) <> 0
		bin = "0" & bin
	Loop

	Dim alphabet As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	Dim sb As StringBuilder
	sb.Initialize

	For i = 0 To bin.Length - 1 Step 6
		Dim chunk As String = bin.SubString2(i, i + 6)
		Dim v As Int = 0
		If chunk.CharAt(0) = "1" Then v = v + 32
		If chunk.CharAt(1) = "1" Then v = v + 16
		If chunk.CharAt(2) = "1" Then v = v + 8
		If chunk.CharAt(3) = "1" Then v = v + 4
		If chunk.CharAt(4) = "1" Then v = v + 2
		If chunk.CharAt(5) = "1" Then v = v + 1
		sb.Append(alphabet.CharAt(v))
	Next

	Return sb.ToString
End Sub

Public Sub FromBase64(b64 As String) As JNBigInt
	Dim s As String = b64.Trim
	Dim alphabet As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

	If s.Length = 0 Then
		Dim z As JNBigInt
		z.Initialize
		Return z
	End If

	Dim sb As StringBuilder
	sb.Initialize
	For i = 0 To s.Length - 1
		Dim ch As String = s.CharAt(i)
		If ch = "=" Then Continue
		Dim idx As Int = alphabet.IndexOf(ch)
		If idx < 0 Then Continue
		Dim bits As String = ToBinaryStringFixed(idx, 6)
		sb.Append(bits)
	Next

	Dim bin As String = sb.ToString
	Dim p As Int = 0
	Do While p < bin.Length - 1 And bin.CharAt(p) = "0"
		p = p + 1
	Loop
	bin = bin.SubString(p)

	Dim r As JNBigInt = FromBinaryString(bin)
	r.mSign = 1
	r.Normalize
	Return r
End Sub

Private Sub Alloc(len As Int) As Int()
	If len < 0 Then len = 0
	Dim a(len) As Int
	Return a
End Sub

Private Sub CLng(v As Long) As Long
	Return v
End Sub

Private Sub EnsureCapacity(cap As Int)
	If mDigits.Length >= cap Then Return
	Dim newCap As Int = Max(cap, Max(4, mDigits.Length * 2))
	Dim tmp() As Int = Alloc(newCap)
	If mLen > 0 Then
		CopyArray(mDigits, 0, tmp, 0, mLen)
	End If
	mDigits = tmp
End Sub

Private Sub CopyArray(src() As Int, srcPos As Int, dst() As Int, dstPos As Int, count As Int)
	Dim maxCount As Int = Min(count, Min(src.Length - srcPos, dst.Length - dstPos))
	For i = 0 To maxCount - 1
		dst(dstPos + i) = src(srcPos + i)
	Next
End Sub

Private Sub AppendDigit(d As Int)
	EnsureCapacity(mLen + 1)
	mDigits(mLen) = d
	mLen = mLen + 1
End Sub

Private Sub Normalize
	If mLen > mDigits.Length Then mLen = mDigits.Length
	Do While mLen > 0 And mDigits(mLen - 1) = 0
		mLen = mLen - 1
	Loop
	If mLen = 0 Then mSign = 0
End Sub

Private Sub SafeLen(x As JNBigInt) As Int
	Dim l As Int = x.mLen
	If l > x.mDigits.Length Then l = x.mDigits.Length
	If l < 0 Then l = 0
	Return l
End Sub

Public Sub Clone As JNBigInt
	Dim c As JNBigInt
	c.Initialize
	c.mSign = mSign

	Dim copyLen As Int = Min(mLen, mDigits.Length)
	c.mLen = copyLen
	c.mDigits = Alloc(copyLen)
	If copyLen > 0 Then
		CopyArray(mDigits, 0, c.mDigits, 0, copyLen)
	End If
	Return c
End Sub

Private Sub ToBinaryStringFixed(value As Int, width As Int) As String
	Dim sb As StringBuilder
	sb.Initialize
	For i = width - 1 To 0 Step -1
		Dim mask As Int = Bit.ShiftLeft(1, i)
		If Bit.And(value, mask) <> 0 Then
			sb.Append("1")
		Else
			sb.Append("0")
		End If
	Next
	Return sb.ToString
End Sub