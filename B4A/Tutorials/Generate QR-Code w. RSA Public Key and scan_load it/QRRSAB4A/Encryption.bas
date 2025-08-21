B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	
	Public MyPublicRSAKeyAsBytes() As Byte, MyPrivateRSAKeyAsBytes() As Byte
	Public ServerPublicRSAKeyAsBytes() As Byte, ServerPrivateRSAKeyAsBytes() As Byte
	
'	
	Dim ServerKPG, OwnKPG As KeyPairGenerator
	Dim EC As Cipher
	
	Dim su As StringUtils, bc As ByteConverter
End Sub

Public Sub DecryptRSA (Data As String) As String
	Dim RSAEncryptedBytes() As Byte =  su.DecodeBase64(Data)
	
	Dim RSADecrypted() As Byte=EC.Decrypt(RSAEncryptedBytes,OwnKPG.PrivateKey,False)
	Dim RSADecryptedString As String=bc.StringFromBytes(RSADecrypted,"UTF8")
	Return RSADecryptedString
	
End Sub

Sub GenerateOWNRSAKeys
	EC.Initialize("RSA/ECB/PKCS1Padding")
	OwnKPG.Initialize("RSA", 2048)
	OwnKPG.GenerateKey
	MyPrivateRSAKeyAsBytes=OwnKPG.PrivateKeyToBytes
	MyPublicRSAKeyAsBytes=OwnKPG.PublicKeyToBytes
	
End Sub

Public Sub LoadServerRSAPubKey (PubKey As String)
	ServerKPG.Initialize("RSA",2048)
	Dim su As StringUtils
	Try
		ServerKPG.PublicKeyFromBytes(su.DecodeBase64(PubKey))
		Log("Public Key successfully loaded!")
		CallSubDelayed(Main,"PubKeyLoaded")
		If MyPublicRSAKeyAsBytes.Length=0 Then
			GenerateOWNRSAKeys
		End If
	Catch
		Log("Wrong Public Key...")
		Log(LastException)
	End Try
	
End Sub

