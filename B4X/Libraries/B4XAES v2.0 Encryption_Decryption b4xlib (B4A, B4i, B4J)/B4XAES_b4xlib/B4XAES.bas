B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.5
@EndOfDesignText@
' B4XAES Encryption/Decryption b4xlib by Roger "ThRuST" Lindfors
' v1.0 	Coded 2022-07-02
' v2.0 	Coded 2022-07-04 based on a new solution by Erel
' Based on the great jB4XEncryption library by Erel

' Shared with the B4X community.

' Requires:
' jB4XEncryption
' BouncyCastle
' StringUtils

' https://www.bouncycastle.org/download/bcprov-jdk18on-171.jar
' #AdditionalJar: bcprov-jdk18on-171.jar

' -------------------------------------------------------------------------------------------------
Sub Process_Globals
	
	'Private fx As JFX
	Private B4XCrypt 	As B4XCipher
	Private su 			As StringUtils

End Sub

' -------------------------------------------------------------------------------------------------
' B4XAES v2.0 by ThRuST is based on a solution by Erel
' Encrypts a string using AES
' b4xlib compatible with B4A, B4i and B4J
' Requires: jB4XEncryption, BouncyCastle, StringUtils
'
' <code>https://www.bouncycastle.org/download/bcprov-jdk18on-171.jar</code>
'
' <code>#AdditionalJar: bcprov-jdk18on-171.jar</code>
'
' Usage: Encrypt (string, "saltkey")
' -------------------------------------------------------------------------------------------------
' <code>
'		' Encrypt string using B4XAES
'		Dim EncryptedString As String = ""
'		EncryptedString = B4XAES.Encrypt("Hello Wonderful World of B4X and B4XAES Cross-Platform Library (b4xlib)", "x")
'		Log(EncryptedString)
'</code>
Public Sub Encrypt (Text As String, SaltKey As String) As String
	
	Dim b() As Byte = B4XCrypt.Encrypt(Text.GetBytes("UTF8"), SaltKey)
	Return su.EncodeBase64(b)
	
End Sub

' -------------------------------------------------------------------------------------------------
' B4XAES v2.0 by ThRuST is based on a solution by Erel
' Decrypts a string using AES
' b4xlib compatible with B4A, B4i and B4J
' Requires: jB4XEncryption, BouncyCastle, StringUtils
'
' <code>https://www.bouncycastle.org/download/bcprov-jdk18on-171.jar</code>
'
' <code>#AdditionalJar: bcprov-jdk18on-171.jar</code>
'
' Usage: Decrypt (string, "saltkey")
' -------------------------------------------------------------------------------------------------
' <code>
'		' Encrypted Message
'		Dim EncryptedString As String = "8hvyDJ15o5H0zS4oQT6KWGeu19F5sOruhBgOzKGNze//S5D0rd9BvFyPp8RO2H+a0sHXCnnrC2IFXZLGK1VzpnxMsykvg9Ib4WbfCC39udC4j/NcjPWGZA5AiTMeDKh1z4f2j+qGTjs="
'		Dim DecryptedString As String = ""
'		
'		' Decrypt string using B4XAES
'		DecryptedString = B4XAES.Decrypt(EncryptedString, "x")
'		Log("Decrypted: " &  DecryptedString)
' </code>
' -------------------------------------------------------------------------------------------------
Public Sub Decrypt(Text As String, Saltkey As String) As String
	
	Dim enc() As Byte = su.DecodeBase64(Text)
	Dim dec() As Byte = B4XCrypt.Decrypt(enc, Saltkey)
	Return BytesToString(dec, 0, dec.Length, "UTF8")
	
End Sub



