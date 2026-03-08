###  JNBigInt Cross platform native B4X library by John Naylor
### 03/06/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170524/)

A while back I was playing about converting the Java BigInteger class to B4X. I like the idea of recreating such things as fully cross platform B4X code. I wanted to add some functions such as generating prime numbers and key pairs too. The main issue I had back then was speed. Using lists for storing number chunks worked out to be quite slow. Generating a 512 bit RSA key pair took quite a few seconds for example and creating anything useful like a 2048 bit key pair was well over 45 seconds on my PC. Still, it was an enjoyable challenge.  
  
I recently picked up on it again though and have reworked it to use arrays instead of lists plus I modified chunk sizes etc to try and speed things up. Here is the class I came up with.  
  
Please note it is untested on B4i. Class and demo code attached. Results of calculations & speed are shown in the logs.  
  
The B4J timings are from a 13th Gen i5 machine with 32Gb RAM. The B4A timings are from a Samsung Galaxy S23 Ultra.  
  
Most functions (Addition / Subtraction / Division etc) work in 1ms or less so I won't include them here but these are timings from the 'big hitter' subs. Times in ms.  
  
[TABLE]  
[TR]  
[TD]**Sub**[/TD]  
  
[TD]

**B4J**

[/TD]  
  
[TD]

**B4A**

[/TD]  
[/TR]  
[TR]  
[TD]NextProbablePrime[/TD]  
  
[TD]

50

[/TD]  
  
[TD]

63

[/TD]  
[/TR]  
[TR]  
[TD]1024-bit prime generation[/TD]  
  
[TD]

51

[/TD]  
  
[TD]

11

[/TD]  
[/TR]  
[TR]  
[TD]RSA 512-bit keypair[/TD]  
  
[TD]

22

[/TD]  
  
[TD]

97

[/TD]  
[/TR]  
[TR]  
[TD]RSA 2048-bit keypair[/TD]  
  
[TD]

9750

[/TD]  
  
[TD]

4382

[/TD]  
[/TR]  
[/TABLE]  
  
Keypair generation is still slow compared to pure Java but maybe fast enough to be of use. When I get time I will try and further optimize it.   
  
  
Publicly available subs :  
  
Initialize  
Resets the number to zero and prepares internal storage.  
  
SetFromInt(v As Int) As JNBigInt  
Sets the value from a 32-bit integer (handles negative values).  
  
SetFromString(text As String) As JNBigInt  
Parses a decimal string (with optional +/−) into a big integer.  
  
IsZero As Boolean  
Returns True if the value is zero.  
  
getSign As Int  
Returns the sign: −1 for negative, 0 for zero, 1 for positive.  
  
ToString As String  
Returns the decimal string representation.  
  
CompareTo(other As JNBigInt) As Int  
Compares this number with another; returns −1, 0, or 1.  
  
Add(other As JNBigInt) As JNBigInt  
Returns the sum of this and other.  
  
Subtract(other As JNBigInt) As JNBigInt  
Returns the result of this − other.  
  
Multiply(other As JNBigInt) As JNBigInt  
Returns the product (uses Karatsuba for large numbers).  
  
DivMod(other As JNBigInt) As Map  
Returns a Map with "q" (quotient) and "r" (remainder) of this ÷ other.  
  
Divide(other As JNBigInt) As JNBigInt  
Returns the quotient of this ÷ other.  
  
Remainder(other As JNBigInt) As JNBigInt  
Returns the remainder of this ÷ other.  
  
Gcd(other As JNBigInt) As JNBigInt  
Returns the greatest common divisor.  
  
ModInverse(m As JNBigInt) As JNBigInt  
Returns the modular inverse of this mod m (0 if none exists).  
  
IsProbablePrime(certainty As Int) As Boolean  
Miller–Rabin probable primality test; True if likely prime.  
  
NextProbablePrime As JNBigInt  
Returns the next probable prime ≥ this value (or 2 if non-positive).  
  
RandomJNBigInt(bitCount As Int) As JNBigInt  
Generates a random positive big integer with the specified bit length.  
  
GeneratePrime(bitCount As Int) As JNBigInt  
Generates a probable prime with approximately bitCount bits.  
  
GenerateRSAKeyPair(keyBits As Int) As Map  
Generates an RSA keypair. Returns a Map with:  
  
 "n" (modulus), "e" (public exponent), "d" (private exponent), "p", "q".  
  
AndBits(other As JNBigInt) As JNBigInt  
Bitwise AND (logical, unsigned interpretation).  
  
OrBits(other As JNBigInt) As JNBigInt  
Bitwise OR (logical, unsigned interpretation).  
  
XorBits(other As JNBigInt) As JNBigInt  
Bitwise XOR (logical, unsigned interpretation).  
  
NotBits As JNBigInt  
Bitwise NOT (logical, on the unsigned binary string).  
  
ShiftLeft(n As Int) As JNBigInt  
Logical left shift by n bits.  
  
ShiftRight(n As Int) As JNBigInt  
Logical right shift by n bits (zeros shifted in).  
  
ToHex As String  
Returns the hexadecimal string (uppercase) of the absolute value.  
  
FromHex(hex As String) As JNBigInt  
Parses a hexadecimal string into a positive big integer.  
  
ToBase64 As String  
Returns a Base64 representation of the absolute value (no padding).  
  
FromBase64(b64 As String) As JNBigInt  
Parses a Base64 string into a positive big integer.  
  
Clone As JNBigInt  
Returns a copy of this JNBigInt.