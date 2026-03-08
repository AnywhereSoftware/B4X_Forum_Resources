B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
Private Sub Button1_Click
	
	Dim startTotal As Long = DateTime.Now
	Dim startOp As Long
	Dim elapsed As Long
	
	' ================== BASIC ARITHMETIC TESTS ==================
	
	' Initialize numbers
	startOp = DateTime.Now
	Dim a, b, c As JNBigInt
	a.Initialize
	a.SetFromString("123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890")
	b.Initialize
	b.SetFromString("98765432109876543210987654321098765432109876543210987654321098765432109876543210")
	elapsed = DateTime.Now - startOp
	Log("Initialization: " & elapsed & " ms")
	Log ("a = 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890")
	Log ("b = 98765432109876543210987654321098765432109876543210987654321098765432109876543210")
	Log("----------------------------------------")
	
	' Addition
	startOp = DateTime.Now
	c = a.Add(b)
	elapsed = DateTime.Now - startOp
	Log("a + b = " & c.ToString)
	Log("Addition time: " & elapsed & " ms")
	Log("----------------------------------------")
	
	' Subtraction
	startOp = DateTime.Now
	c = a.Subtract(b)
	elapsed = DateTime.Now - startOp
	Log("a - b = " & c.ToString)
	Log("Subtraction time: " & elapsed & " ms")
	Log("----------------------------------------")
	
	' Multiplication
	startOp = DateTime.Now
	c = a.Multiply(b)
	elapsed = DateTime.Now - startOp
	Log("a * b = " & c.ToString)
	Log("Multiplication time: " & elapsed & " ms")
	Log("----------------------------------------")
	
	' Comparison
	startOp = DateTime.Now
	Dim cmp As Int = a.CompareTo(b)
	elapsed = DateTime.Now - startOp
	Log("Compare: " & cmp)
	Log("Comparison time: " & elapsed & " ms")
	Log("----------------------------------------")
	
	' Division (quotient)
	startOp = DateTime.Now
	Dim q As JNBigInt = a.Divide(b)
	elapsed = DateTime.Now - startOp
	Log("a / b = " & q.ToString)
	Log("Division time: " & elapsed & " ms")
	Log("----------------------------------------")

	' Remainder
	startOp = DateTime.Now
	Dim r As JNBigInt = a.Remainder(b)
	elapsed = DateTime.Now - startOp
	Log("a % b = " & r.ToString)
	Log("Remainder time: " & elapsed & " ms")
	Log("----------------------------------------")

	' Correctness check: q*b + r == a
	startOp = DateTime.Now
	Dim check As JNBigInt = q.Multiply(b).Add(r)
	Dim ok As Boolean = (check.CompareTo(a) = 0)
	elapsed = DateTime.Now - startOp
	Log("Check q*b + r = a ? " & ok)
	Log("Verification time: " & elapsed & " ms")
	Log("----------------------------------------")
	
	
	' ================== BITWISE TESTS ==================
	
	Dim x, y As JNBigInt
	x.Initialize
	x.SetFromString("255")
	y.Initialize
	y.SetFromString("15")

	Log("x AND y = " & x.AndBits(y).ToString)   ' expect 15
	Log("x OR  y = " & x.OrBits(y).ToString)    ' expect 255
	Log("x XOR y = " & x.XorBits(y).ToString)   ' expect 240
	Log("x << 4  = " & x.ShiftLeft(4).ToString) ' expect 4080
	Log("x >> 4  = " & x.ShiftRight(4).ToString)' expect 15
	Log("----------------------------------------")
	
	
	' ================== GCD TEST ==================
	
	startOp = DateTime.Now
	Dim g As JNBigInt = a.Gcd(b)
	elapsed = DateTime.Now - startOp
	Log("gcd(a, b) = " & g.ToString)
	Log("GCD time: " & elapsed & " ms")
	Log("----------------------------------------")
	
	
	' ================== MODULAR INVERSE TEST ==================
	' Classic small example: 17^(-1) mod 3120 = 2753
	
	Dim m1, m2, inv, prod As JNBigInt
	m1.Initialize
	m1.SetFromInt(17)
	m2.Initialize
	m2.SetFromInt(3120)
	
	startOp = DateTime.Now
	inv = m1.ModInverse(m2)
	elapsed = DateTime.Now - startOp
	Log("ModInverse: 17^(-1) mod 3120 = " & inv.ToString)
	Log("ModInverse time: " & elapsed & " ms")
	
	' Check: (17 * inv) mod 3120 should be 1
	Dim one As JNBigInt
	one.Initialize
	one.SetFromInt(1)
	
	prod = m1.Multiply(inv).Remainder(m2)
	Log("Check (17 * inv) mod 3120 = 1 ? " & (prod.CompareTo(one) = 0))
	Log("----------------------------------------")
	
	
	' ================== NEXT PROBABLE PRIME TEST (from big starting point) ==================
	
	Dim p As JNBigInt
	p.Initialize
	p.SetFromString("98765432109876543210987654321098765432109876543210987654321098765432109876543210")
	
	startOp = DateTime.Now
	q = p.NextProbablePrime
	elapsed = DateTime.Now - startOp
	Log("Next probable prime after p = " & q.ToString)
	Log("IsProbablePrime(10) = " & q.IsProbablePrime(10))
	Log("NextProbablePrime time: " & elapsed & " ms")
	Log("----------------------------------------")
	
	
	' ================== 1024-BIT PRIME GENERATION TEST ==================
	
	Log ("Starting 1024-BIT PRIME GENERATION TEST")
	Dim gen As JNBigInt
	gen.Initialize    ' just an instance to call GeneratePrime on
	
	Dim prime1024 As JNBigInt
	startOp = DateTime.Now
	prime1024 = gen.GeneratePrime(256)
	elapsed = DateTime.Now - startOp
	
	Dim decLen As Int = prime1024.ToString.Length
	Log("1024-bit prime (decimal digits): " & decLen)
	' To avoid flooding the log, just show the first and last 40 digits
	Dim sPrime As String = prime1024.ToString
	Log("Prime : " & sPrime)
	Log("IsProbablePrime(10) = " & prime1024.IsProbablePrime(10))
	Log("1024-bit prime generation time: " & elapsed & " ms")
	Log("----------------------------------------")
	
	
	' ================== RSA KEYPAIR TEST (512 BITS FOR SPEED) ==================
	Log ("Starting RSA KEYPAIR TEST (512 BITS FOR SPEED))")
	Dim rsaBits As Int = 512
	startOp = DateTime.Now
	Dim rsa As Map = gen.GenerateRSAKeyPair(rsaBits)
	elapsed = DateTime.Now - startOp
	
	Dim n As JNBigInt = rsa.Get("n")
	Dim eBI As JNBigInt = rsa.Get("e")
	Dim dBI As JNBigInt = rsa.Get("d")
	Dim pBI As JNBigInt = rsa.Get("p")
	Dim qBI As JNBigInt = rsa.Get("q")
	
	Log("RSA " & rsaBits & "-bit keypair generated in " & elapsed & " ms")
	Log("n (decimal digits): " & n.ToString.Length)
	Log("e = " & eBI.ToString)
	Log("d (decimal digits): " & dBI.ToString.Length)
	Log("p (decimal digits): " & pBI.ToString.Length)
	Log("q (decimal digits): " & qBI.ToString.Length)
	
	' Verify that e*d ≡ 1 (mod phi), where phi = (p-1)*(q-1)
	Dim p1 As JNBigInt = pBI.Subtract(one)
	Dim q1 As JNBigInt = qBI.Subtract(one)
	Dim phi As JNBigInt = p1.Multiply(q1)
	
	Dim ed As JNBigInt = eBI.Multiply(dBI)
	Dim edModPhi As JNBigInt = ed.Remainder(phi)
	
	Log("Check e*d mod phi = 1 ? " & (edModPhi.CompareTo(one) = 0))
	Log("512bit keypair time: " & elapsed)
	Log("----------------------------------------")

	' ================== RSA KEYPAIR TEST (512 BITS FOR SPEED) ==================
	Log ("Starting RSA KEYPAIR TEST (2048 BITS))")
	Dim rsaBits As Int = 2048
	startOp = DateTime.Now
	Dim rsa As Map = gen.GenerateRSAKeyPair(rsaBits)
	elapsed = DateTime.Now - startOp
	
	Dim n As JNBigInt = rsa.Get("n")
	Dim eBI As JNBigInt = rsa.Get("e")
	Dim dBI As JNBigInt = rsa.Get("d")
	Dim pBI As JNBigInt = rsa.Get("p")
	Dim qBI As JNBigInt = rsa.Get("q")
	
	Log("RSA " & rsaBits & "-bit keypair generated in " & elapsed & " ms")
	Log("n (decimal digits): " & n.ToString.Length)
	Log("e = " & eBI.ToString)
	Log("d (decimal digits): " & dBI.ToString.Length)
	Log("p (decimal digits): " & pBI.ToString.Length)
	Log("q (decimal digits): " & qBI.ToString.Length)
	
	' Verify that e*d ≡ 1 (mod phi), where phi = (p-1)*(q-1)
	Dim p1 As JNBigInt = pBI.Subtract(one)
	Dim q1 As JNBigInt = qBI.Subtract(one)
	Dim phi As JNBigInt = p1.Multiply(q1)
	
	Dim ed As JNBigInt = eBI.Multiply(dBI)
	Dim edModPhi As JNBigInt = ed.Remainder(phi)
	
	Log("Check e*d mod phi = 1 ? " & (edModPhi.CompareTo(one) = 0))
	Log("2048bit keypair time: " & elapsed)
	Log("----------------------------------------")
	
	
	' ================== TOTAL TIME ==================
	
	Dim totalTime As Long = DateTime.Now - startTotal
	Log("TOTAL TIME: " & totalTime & " ms")
	
End Sub
