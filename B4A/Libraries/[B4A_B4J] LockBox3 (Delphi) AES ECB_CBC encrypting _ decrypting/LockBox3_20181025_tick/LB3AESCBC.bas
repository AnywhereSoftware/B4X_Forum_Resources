B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.51
@EndOfDesignText@
Sub Class_Globals
	Private bc As ByteConverter
	Private su As StringUtils
	Private sr As SecureRandom
	Private cCTS As Cipher
	Private cCFB As Cipher
	Private k As KeyGenerator
End Sub

Public Sub Initialize(keyBytes() As Byte)
	cCTS.Initialize("AES/CTS/NoPadding")
	cCFB.Initialize("AES/CFB8/NoPadding")
	k.Initialize("AES")
	k.KeyFromBytes(keyBytes)
End Sub

Public Sub EncryptString(plainText As String) As String
	Dim cipherText As String = ""
	
	If plainText <> Null Then
		If plainText.Length > 0 Then
	
			Dim dataBytes() As Byte = plainText.GetBytes("UTF8")
	
			'Autogenerate nonce and insert into IV
			Dim nonce(8) As Byte
			sr.GetRandomBytes(nonce)
			Dim IV(16) As Byte
			bc.ArrayCopy(nonce, 0, IV, 0, 8)

			Dim encryptedBytes() As Byte
			If dataBytes.Length > 15 Then
				cCTS.InitialisationVector = IV
				encryptedBytes = cCTS.Encrypt(dataBytes, k.Key, True)
			Else
				cCFB.InitialisationVector = IV
				encryptedBytes = cCFB.Encrypt(dataBytes, k.Key, True)
			End If
	
			'Create result byte array, consisting of nonce and encrypted data
			Dim cipherTextBytes(encryptedBytes.Length + 8) As Byte
			bc.ArrayCopy(nonce, 0, cipherTextBytes, 0, 8)
			bc.ArrayCopy(encryptedBytes, 0, cipherTextBytes, 8, encryptedBytes.Length)
			cipherText = su.EncodeBase64(cipherTextBytes)
		End If
	End If
	
	Return cipherText
End Sub

Sub DecryptString(cipherText As String) As String
	Dim plainText As String = ""
	
	If cipherText <> Null Then
		If cipherText.Length > 0 Then
			'Retrieve nonce and data to decrypt from ciphertext byte array
			Dim cipherTextBytes() As Byte = su.DecodeBase64(cipherText)
			Dim nonce(8) As Byte
			bc.ArrayCopy(cipherTextBytes, 0, nonce, 0, 8)
			Dim dataBytes(cipherTextBytes.Length - 8) As Byte
			bc.ArrayCopy(cipherTextBytes, 8, dataBytes, 0, cipherTextBytes.Length - 8)
			'Create IV from nonce
			Dim IV(16) As Byte
			bc.ArrayCopy(nonce, 0, IV, 0, 8)
	
			Dim decryptedBytes() As Byte
			If dataBytes.Length > 15 Then
				cCTS.InitialisationVector = IV
				decryptedBytes = cCTS.Decrypt(dataBytes, k.Key, True)
			Else
				cCFB.InitialisationVector = IV
				decryptedBytes = cCFB.Decrypt(dataBytes, k.Key, True)
			End If
			plainText = BytesToString(decryptedBytes, 0, decryptedBytes.Length, "UTF8")
		End If
	End If
	
	Return plainText
End Sub