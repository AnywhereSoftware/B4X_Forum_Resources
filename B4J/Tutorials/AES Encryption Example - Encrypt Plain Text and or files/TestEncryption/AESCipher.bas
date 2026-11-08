B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
'V1.0

Sub Class_Globals
	Private fx As JFX
	
'	Key Lenths AES-128 = 16, AES-192 = 24, AES-256 = 32	
	Type AES_KeySize (AES_128 As Int, AES_192 As Int, AES_256 As Int)
	Public KeySize As AES_KeySize
	KeySize.AES_128 = 16
	KeySize.AES_192 = 24
	KeySize.AES_256 = 32
	
	'Encoding types: Hex or Base64
	Type AES_Encoding(Hex As String, Base64 As String)
	Public EncodeType As AES_Encoding
	EncodeType.Hex = "Hex"
	EncodeType.Base64 = "Base64"
		 
End Sub

 'Initialize the AESCipher encryption class
Public Sub Initialize()

End Sub

' Generates a cryptographically secure random salt of specified byte length
Public Sub GenerateSalt(bytesLength As Int) As Byte()
	Dim sr As JavaObject
	sr.InitializeNewInstance("java.security.SecureRandom", Null)

	Dim Salt(bytesLength) As Byte
	sr.RunMethod("nextBytes", Array(Salt))
	Return Salt
End Sub' Derives an AES key from a passphrase using PBKDF2WithHmacSHA256
Public Sub DeriveKey(passphrase As String, Salt() As Byte, keyLength As Int) As Byte()
	' Get the Class for char primitive
	Dim charType As JavaObject
	charType.InitializeStatic("java.lang.Character")
	Dim charClass As JavaObject = charType.GetField("TYPE")  ' This is 'char.class'

	' Create a Java char[] using reflection
	Dim reflectArray As JavaObject
	reflectArray.InitializeStatic("java.lang.reflect.Array")
	Dim charArray As JavaObject = reflectArray.RunMethod("newInstance", Array(charClass, passphrase.Length))

	' Fill the array with characters
	For i = 0 To passphrase.Length - 1
		reflectArray.RunMethod("setChar", Array(charArray, i, passphrase.CharAt(i)))
	Next

	' Create PBEKeySpec using the char array
	Dim spec As JavaObject
	spec.InitializeNewInstance("javax.crypto.spec.PBEKeySpec", Array(charArray, Salt, 100000, keyLength * 8))

	' Generate key from spec
	Dim keyFactory As JavaObject
	keyFactory.InitializeStatic("javax.crypto.SecretKeyFactory")
	Dim factory As JavaObject = keyFactory.RunMethod("getInstance", Array("PBKDF2WithHmacSHA256"))
	Dim secretKey As JavaObject = factory.RunMethod("generateSecret", Array(spec))
	Dim keyBytes() As Byte = secretKey.RunMethod("getEncoded", Null)

	Return keyBytes
End Sub

' AES Encryption (AES/CBC/PKCS5Padding)
Public Sub EncryptByte(key() As Byte, Data() As Byte) As Byte()
	Dim cipher As JavaObject
	cipher.InitializeStatic("javax.crypto.Cipher")
	cipher = cipher.RunMethod("getInstance", Array("AES/CBC/PKCS5Padding"))

	' Generate random IV (16 bytes)
	Dim iv(16) As Byte
	Dim sr As JavaObject
	sr.InitializeNewInstance("java.security.SecureRandom", Null)
	sr.RunMethod("nextBytes", Array(iv))
	Dim ivSpec As JavaObject
	ivSpec.InitializeNewInstance("javax.crypto.spec.IvParameterSpec", Array(iv))

	Dim secretKeySpec As JavaObject
	secretKeySpec.InitializeNewInstance("javax.crypto.spec.SecretKeySpec", Array(key, "AES"))

	cipher.RunMethod("init", Array(cipher.GetField("ENCRYPT_MODE"), secretKeySpec, ivSpec))

	Dim encrypted() As Byte = cipher.RunMethod("doFinal", Array(Data))

	' Prepend IV to ciphertext (needed for decryption)
	Dim output(encrypted.Length + iv.Length) As Byte
	For i = 0 To iv.Length - 1
		output(i) = iv(i)
	Next
	For i = 0 To encrypted.Length - 1
		output(i + iv.Length) = encrypted(i)
	Next

	Return output
End Sub
' AES Decryption (AES/CBC/PKCS5Padding)
Public Sub DecryptByte(key() As Byte, cipherTextWithIV() As Byte) As Byte()
    Dim cipher As JavaObject
    cipher.InitializeStatic("javax.crypto.Cipher")
    cipher = cipher.RunMethod("getInstance", Array("AES/CBC/PKCS5Padding"))

    ' Extract IV (first 16 bytes)
    Dim iv(16) As Byte
    For i = 0 To 15
        iv(i) = cipherTextWithIV(i)
    Next
    Dim ivSpec As JavaObject
    ivSpec.InitializeNewInstance("javax.crypto.spec.IvParameterSpec", Array(iv))

    ' Extract ciphertext (from byte array after IV)
    Dim cipherText(cipherTextWithIV.Length - iv.Length) As Byte
    For i = iv.Length To cipherTextWithIV.Length - 1
        cipherText(i - iv.Length) = cipherTextWithIV(i)
    Next

    Dim secretKeySpec As JavaObject
    secretKeySpec.InitializeNewInstance("javax.crypto.spec.SecretKeySpec", Array(key, "AES"))

    cipher.RunMethod("init", Array(cipher.GetField("DECRYPT_MODE"), secretKeySpec, ivSpec))

    ' Decrypt the ciphertext to get the byte array
    Dim decryptedBytes() As Byte = cipher.RunMethod("doFinal", Array(cipherText))

    ' Return the decrypted data as a byte array
    Return decryptedBytes
End Sub

' Helper function to convert bytes to hexadecimal string
Public Sub BytesToHex(bytes() As Byte) As String
	Dim sb As StringBuilder
	sb.Initialize
	For Each b As Byte In bytes
		Dim hexByte As String = Bit.ToHexString(Bit.And(0xFF, b)).ToUpperCase
		If hexByte.Length = 1 Then hexByte = "0" & hexByte ' Pad single-digit hex
		sb.Append(hexByte)
	Next
	Return sb.ToString
End Sub
'Helper function to convert hexadecimal to bytes.
Public Sub HexToBytes(HexStr As String) As Byte()
	If HexStr.Length Mod 2 <> 0 Then
		HexStr = "0" & HexStr ' Pad with leading 0
	End If

	Dim len As Int = HexStr.Length / 2
	Dim result(len) As Byte
	For i = 0 To len - 1
		Dim hexByte As String = HexStr.SubString2(i * 2, i * 2 + 2)
		result(i) = Bit.ParseInt(hexByte, 16)
	Next
	Return result
End Sub

'Helper function to convert bytes to Base64
Public Sub BytesToBase64(bytes() As Byte) As String
	Dim encoder As JavaObject
	encoder = encoder.InitializeStatic("java.util.Base64").RunMethod("getEncoder", Null)
	Dim base64String As String = encoder.RunMethod("encodeToString", Array(bytes))
	Return base64String
End Sub
'Helper function to convert Base64 to Bytes
Public Sub Base64ToBytes(base64String As String) As Byte()
	Dim decoder As JavaObject
	decoder = decoder.InitializeStatic("java.util.Base64").RunMethod("getDecoder", Null)
	Dim bytes() As Byte = decoder.RunMethod("decode", Array(base64String))
	Return bytes
End Sub

'check two byte arrays if they are equal. example check byte before encryption and byte after encryption.
Public Sub ByteArraysEqual(a() As Byte, b() As Byte) As Boolean
	If a.Length <> b.Length Then Return False
	For i = 0 To a.Length - 1
		If a(i) <> b(i) Then Return False
	Next
	Return True
End Sub

'Embeds salt withing the ecrypted string, Base64 encoding used only
Public Sub EncryptPlainTextWithSalt(passphrase As String, salt() As Byte, keyLength As Int, plaintexttoEncrypt As String, Encode As String) As String
	' Derive AES key from salt + passphrase
	Dim key() As Byte = DeriveKey(passphrase, salt, keyLength)

	' Generate IV (16 bytes)
	Dim iv() As Byte = GenerateSalt(16) ' Secure random IV

	' Set up cipher
	Dim cipher As JavaObject
	cipher.InitializeStatic("javax.crypto.Cipher")
	cipher = cipher.RunMethod("getInstance", Array("AES/CBC/PKCS5Padding"))

	Dim ivSpec As JavaObject
	ivSpec.InitializeNewInstance("javax.crypto.spec.IvParameterSpec", Array(iv))

	Dim keySpec As JavaObject
	keySpec.InitializeNewInstance("javax.crypto.spec.SecretKeySpec", Array(key, "AES"))

	cipher.RunMethod("init", Array(cipher.GetField("ENCRYPT_MODE"), keySpec, ivSpec))
	Dim encrypted() As Byte = cipher.RunMethod("doFinal", Array(plaintexttoEncrypt.GetBytes("UTF8")))

	' Combine salt, IV + ciphertext
	Dim output(salt.Length + iv.Length + encrypted.Length) As Byte
	Bit.ArrayCopy(salt, 0, output, 0, salt.Length)   ' Embed salt first
	Bit.ArrayCopy(iv, 0, output, salt.Length, iv.Length)
	Bit.ArrayCopy(encrypted, 0, output, salt.Length + iv.Length, encrypted.Length)

	' If Base64 encoding is requested
	If Encode = "Base64" Then
		Dim encoder As JavaObject
		encoder = encoder.InitializeStatic("java.util.Base64").RunMethod("getEncoder", Null)
		Return encoder.RunMethod("encodeToString", Array(output))
	Else
		' Convert to Hex if requested
		Return BytesToHex(output)
	End If
End Sub
'extracts embeded salt and uses that to decrypt, has to be base64 encoded
Public Sub DecryptPlainTextWithSalt(passphrase As String, keyLength As Int, encodedInput As String, Encode As String) As String
	' Decode the input based on the format (Base64 or Hex)
	Dim input() As Byte
	If Encode = "Base64" Then
		' Base64 decode input
		Dim decoder As JavaObject
		decoder = decoder.InitializeStatic("java.util.Base64").RunMethod("getDecoder", Null)
		input = decoder.RunMethod("decode", Array(encodedInput))
	Else
		' Hex decode input
		input = HexToBytes(encodedInput)
	End If

	' Extract salt (first 16 bytes), IV (next 16 bytes), and ciphertext
	Dim salt(16) As Byte
	Dim iv(16) As Byte
	Dim cipherText(input.Length - 32) As Byte

	Bit.ArrayCopy(input, 0, salt, 0, 16)             ' Extract salt
	Bit.ArrayCopy(input, 16, iv, 0, 16)               ' Extract IV
	Bit.ArrayCopy(input, 32, cipherText, 0, cipherText.Length)  ' Extract ciphertext

	' Derive key again
	Dim key() As Byte = DeriveKey(passphrase, salt, keyLength)

	' Set up cipher
	Dim cipher As JavaObject
	cipher.InitializeStatic("javax.crypto.Cipher")
	cipher = cipher.RunMethod("getInstance", Array("AES/CBC/PKCS5Padding"))

	Dim ivSpec As JavaObject
	ivSpec.InitializeNewInstance("javax.crypto.spec.IvParameterSpec", Array(iv))

	Dim keySpec As JavaObject
	keySpec.InitializeNewInstance("javax.crypto.spec.SecretKeySpec", Array(key, "AES"))

	cipher.RunMethod("init", Array(cipher.GetField("DECRYPT_MODE"), keySpec, ivSpec))
	Dim decrypted() As Byte = cipher.RunMethod("doFinal", Array(cipherText))

	Return BytesToString(decrypted, 0, decrypted.Length, "UTF8")
End Sub



