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
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

'AES加密（需库：SS_AESEncryption）
'作者：lesliexin@outlook.com
'Web：www.lesliexin.com
'日期：2022-12-17
'str：待加密字符串
'iv：向量，必须是16位字符串
'key：密码，必须是16位或32位字符串
Private Sub EnCryptAES(str As String,iv As String,key As String) As String
	
	Private enc As AESEncryption	
	enc.InitializationVector = iv 
	enc.SecretKey = key 
	
	Private enStr As String=enc.AESEncrypt(str)
	Log("加密结果："& enStr)
	Return enStr
End Sub

'AES解密（需库：SS_AESEncryption）
'作者：lesliexin@outlook.com
'Web：www.lesliexin.com
'日期：2022-12-17
'str：待解密字符串
'iv：向量，必须是16位字符串
'key：密码，必须是16位或32位字符串
Private Sub DeCryptAES(str As String,iv As String,key As String) As String
	
	Private enc As AESEncryption	
	enc.InitializationVector = iv 
	enc.SecretKey = key 
	
	Private deStr As String =enc.AESDecrypt(str)
	Log("解密结果："& deStr)
	Return deStr
End Sub

Private Sub Button1_Click
	
	Private str="这是一串待加解密的字符串" As String
	Private iv="abcdefghijklmnop" As String
	Private key="ponmlkjihgfedcba" As String
	
	Private enstr=EnCryptAES(str,iv,key) As String
	
	Private destr=DeCryptAES(enstr,iv,key) As String
	
	Log("END")
	
End Sub