B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.51
@EndOfDesignText@
Sub Class_Globals
	Private su As StringUtils
	Private c As Cipher
	Private k As KeyGenerator
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(keyBytes() As Byte)
	c.Initialize("AES/ECB/ISO7816-4PADDING")
	k.Initialize("AES")
	k.KeyFromBytes(keyBytes)
End Sub

public Sub EncryptString(plainText As String) As String
	Dim cipherText As String = ""
	
	If plainText <> Null Then
		If plainText.Length > 0 Then
			Dim dataBytes() As Byte = plainText.GetBytes("UTF8")
			cipherText =  su.EncodeBase64(c.Encrypt(dataBytes, k.Key, False))
		End If
	End If

	Return cipherText
End Sub

Public Sub DecryptString(cipherText As String) As String
	Dim plainText As String = ""
	
	If cipherText <> Null Then
		If cipherText.Length > 0 Then
			Dim dataBytes() As Byte = su.DecodeBase64(cipherText)
			Dim decryptedBytes() As Byte = c.Decrypt(dataBytes, k.Key , False)
			plainText = BytesToString(decryptedBytes, 0, decryptedBytes.Length, "UTF8")
		End If
	End If

	Return plainText
End Sub