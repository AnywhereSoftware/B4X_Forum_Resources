B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
' B4XCryptFile b4xlib by Roger "ThRuST" Lindfors
' v1.0 	Coded 2022-07-06

' Based on code by Erel, Stevel05

' Shared with the B4X community.

' Requires:
' jB4XEncryption
' BouncyCastle
' StringUtils

' https://www.bouncycastle.org/download/bcprov-jdk18on-171.jar
' #AdditionalJar: bcprov-jdk18on-171.jar

Sub Process_Globals
	

End Sub

' -------------------------------------------------------------------------------------------------
' B4XCryptFile v1.0 by ThRuST is based on code by Erel, Stevel05
' Encrypts a file using AES
' b4xlib compatible with B4A, B4i and B4J
' Requires: jB4XEncryption, BouncyCastle, StringUtils
'
' <code>https://www.bouncycastle.org/download/bcprov-jdk18on-171.jar</code>
'
' <code>#AdditionalJar: bcprov-jdk18on-171.jar</code>
'
' Usage:
' -------------------------------------------------------------------------------------------------
' <code>
' ' Encrypt a file
'	B4XCryptFile.EncryptFileUsingAES("sourcepath", "sourcefilename", "destpath", "destfilename", "saltkey")
'</code>
Public Sub EncryptFileUsingAES (SourcePath As String, SourceFilename As String, DestPath As String, DestFilename As String, Salt As String)
	
	Try
		
		' Encrypt a file
		Dim FileBytes() As Byte = File.ReadBytes(SourcePath, SourceFilename)
		File.WriteBytes(DestPath, DestFilename, EncryptBytes(FileBytes, Salt))
		Log("File encryption successful")
	
	Catch
		Log("Error, could not encrypt file")
		Log(LastException.Message)
	End Try
	
End Sub

' -------------------------------------------------------------------------------------------------
' B4XCryptFile v1.0 by ThRuST is based on code by Erel, Stevel05
' Encrypts a file using AES
' b4xlib compatible with B4A, B4i and B4J
' Requires: jB4XEncryption, BouncyCastle, StringUtils
'
' <code>https://www.bouncycastle.org/download/bcprov-jdk18on-171.jar</code>
'
' <code>#AdditionalJar: bcprov-jdk18on-171.jar</code>
'
' Usage:
' -------------------------------------------------------------------------------------------------
' <code>
' ' Decrypt a file
'	B4XCryptFile.DecryptFileUsingAES("sourcepath", "sourcefilename", "destpath", "destfilename", "saltkey")
'</code>
Public Sub DecryptFileUsingAES (SourcePath As String, SourceFilename As String, DestPath As String, DestFilename As String, Salt As String)

	Try

		' Decrypt a file
		Dim EncryptedBytes() As Byte = File.ReadBytes(SourcePath, SourceFilename)
		File.WriteBytes(DestPath, DestFilename, DecryptBytes(EncryptedBytes, Salt))
		Log("File decryption successful")
	Catch
		Log("Error, could not decrypt file")
		Log(LastException.Message)
	End Try
	
End Sub

' Encrypt to String
Public Sub Encrypt (Text As String, Password As String) As String
	
	Dim c As B4XCipher
	Dim b() As Byte = c.Encrypt(Text.GetBytes("utf8"), Password)
	Dim su As StringUtils
	Return su.EncodeBase64(b)
	
End Sub

' Decrypt to String
Public Sub Decrypt(EncryptedText As String, Password As String) As String
	
	Dim c As B4XCipher
	Dim su As StringUtils
	Dim Enc() As Byte = su.DecodeBase64(EncryptedText)
	Dim dec() As Byte = c.Decrypt(Enc, Password)
	Return BytesToString(dec, 0, dec.Length, "utf8")
	
End Sub

' Encrypt to Bytes
Public Sub EncryptToBytes (Text As String, Password As String) As Byte()
	
	Dim c As B4XCipher
	Return c.Encrypt(Text.GetBytes("utf8"), Password)
	
End Sub

' Decrypt from Bytes
Public Sub DecryptFromBytes(EncryptedBytes() As Byte, Password As String) As String
	
	Dim c As B4XCipher
	Dim dec() As Byte = c.Decrypt(EncryptedBytes, Password)
	Return BytesToString(dec, 0, dec.Length, "utf8")
	
End Sub

' Encrypt Bytes
Public Sub EncryptBytes(Bytes() As Byte, Password As String) As Byte()
	Dim c As B4XCipher
	Return c.Encrypt(Bytes, Password)
	Log(c)
End Sub

' Decrypt Bytes
Public Sub DecryptBytes(EncryptedBytes() As Byte, Password As String) As Byte()
	Dim c As B4XCipher
	Return c.Decrypt(EncryptedBytes, Password)
End Sub
