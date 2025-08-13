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
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Dim input As String = "confidential"
	Log("Input: " & input)
	Dim EncryptedData() As Byte = EncryptText(input, "123456")
	Dim su As StringUtils
	Log("Base64 encrypted: " & su.EncodeBase64(EncryptedData))
	Dim Encrypted64FromB4J As String = "0O5aJMAt2pwx3asnFc7H+80J8+MV1e3e7S7p7L050YKxsNRoo5/w4Q=="
	Log("decrypted: " & DecryptText(su.DecodeBase64(Encrypted64FromB4J), "123456"))
End Sub

Sub EncryptText(text As String, password As String) As Byte()
	#if B4A or B4J
	Dim c As B4XCipher
	#else if B4i
	Dim c As Cipher
	#end if
	Return c.Encrypt(text.GetBytes("utf8"), password)
End Sub

Sub DecryptText(EncryptedData() As Byte, password As String) As String
	#if B4A or B4J
	Dim c As B4XCipher
	#else if B4i
	Dim c As Cipher
	#end if
	Dim b() As Byte = c.Decrypt(EncryptedData, password)
	Return BytesToString(b, 0, b.Length, "utf8")
End Sub


