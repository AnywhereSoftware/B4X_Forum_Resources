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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=B4XMSLogin.zip


'**************************** REMEMBER TO EDIT MANIFEST TOO  ******************


Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	#if B4J
	Private ClientId As String = "8de38113-1431-2321-23f2-fpjad23pjsdo3d" 'FAKE
	Private ClientSecret As String = "rND8Q~umpweWUHvgjGXFy9scIsdfadadxcgs" ''Note that unlike Google, Microsoft does not use ClientSecret
	#else if B4A
	Private clientID As String = "8de38113-1431-2321-23f2-fpjad23pjsdo3d" 'FAKE
	Private ClientSecret As String = "" 'leave empty! ''Note that unlike Google, Microsoft does not use ClientSecret
	#else if B4i
	Private ClientId As String = "8de38113-1431-2321-23f2-bfad23b82e30" FAKE¡
	Private ClientSecret As String = "" 'leave empty! ''Note that unlike Google, Microsoft does not use ClientSecret
	#End If
	Public MSGraph As MicrosoftGraph
	Private lblPhone As B4XView
	Private lblEmail As B4XView
	Private lblName As B4XView
	Private const tenant As String = "104c96c8-22dd-46a6-b38c-fewee2p323jo" 'FAKE

	Private btnSendEmail As Button
	Private B4XImageView1 As B4XImageView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	xui.SetDataFolder("B4XMSLogin") 'only required for B4J
	'Note that unlike Google, Microsoft does not use ClientSecret
	MSGraph.Initialize(Me, "MSGraph", ClientId, tenant, "https://graph.microsoft.com/.default offline_access", ClientSecret, xui.DefaultFolder)
	'MSGraph.ResetToken 'uncomment if you changed the scope or want to reset the token
End Sub

Private Sub B4XPage_Foreground
	Log("B4XPage_Foreground")
	#if B4A
	MSGraph.CallFromResume(B4XPages.GetNativeParent(Me).GetStartingIntent)
	#End If
End Sub

Sub btnGetData_Click
	#IF B4A 
	Dim bc As ByteConverter
	Dim raw() As Byte = bc.HexToBytes(GetSignatureHash.Replace(":", "")) 'You can see it under Tools - Private Sign Key.
	Dim su As StringUtils
	Log("Use this sha1 base64 sign to register your app in ms: " & su.EncodeBase64(raw))
	#END IF
	MSGraph.GetAccessToken
	Wait For MSGraph_AccessTokenAvailable (Success As Boolean, Token As String)
	Log("Waiting: " & Success & " Token: " & Token)
	If Success = False Then
		Log("Error accessing account.")
		Return
	End If
	GetUserDetails(Token)
	GetUserImage(Token)
End Sub

Sub btnSendEmail_Click
	MSGraph.GetAccessToken
	Wait For MSGraph_AccessTokenAvailable (Success As Boolean, Token As String)
	If Success = False Then
		Log("Error accessing account.")
		Return
	End If
	SendEmail("youremail@gmail.com", Token)
End Sub


Sub ParsePersonData (data As String)
	Dim jp As JSONParser
	jp.Initialize(data)
	Dim map As Map = jp.NextObject
	lblName.Text = map.Get("displayName")
	lblEmail.Text = map.Get("mail")
	lblPhone.Text = map.Get("mobilePhone")
'	End If
End Sub

Sub GetUserDetails(token As String) ' añadido de MSLOGIN
	Dim j As HttpJob
	j.Initialize("", Me) 'name is empty as it is no longer needed
	j.Download("https://graph.microsoft.com/v1.0/me")
	j.GetRequest.SetHeader("Authorization","Bearer " & token)
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		ParsePersonData(j.GetString)
	Else
		MSGraph.ResetToken
		Log("Online data not available.")
	End If
	j.Release
End Sub

Sub GetUserImage(token As String)
	Dim j As HttpJob
	j.Initialize("", Me) 'name is empty as it is no longer needed
	j.Download("https://graph.microsoft.com/v1.0/me/photo/$value")
	j.GetRequest.SetHeader("Authorization","Bearer " & token)
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		B4XImageView1.Bitmap = j.GetBitmap
		B4XImageView1.RoundedImage = True
	Else
		MSGraph.ResetToken
		Log("Online data not available.")
	End If
	j.Release
End Sub

Sub SendEmail(toAddress As String, token As String) ' añadido de MSLOGIN
	Log("Sending email")
	Log(PrepareMessage(toAddress))
	Dim j As HttpJob
	j.Initialize("", Me) 'name is empty as it is no longer needed
	j.PostString("https://graph.microsoft.com/v1.0/me/sendMail", PrepareMessage(toAddress))
	j.GetRequest.SetContentType("application/json")
	j.GetRequest.SetHeader("Authorization","Bearer " & token)
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		ParsePersonData(j.GetString)
	Else
		MSGraph.ResetToken
		Log("Online data not available.")
	End If
	j.Release
End Sub


Sub PrepareMessage (email As String) As String
	' Crear el mapa principal
	Dim mensajeMap As Map
	mensajeMap.Initialize
    
	' Crear el contenido del mensaje
	Dim bodyMap As Map
	bodyMap.Initialize
	bodyMap.Put("contentType", "Text")
	bodyMap.Put("content", "The new cafeteria is open.")
    
	' Crear el mapa de destinatario
	Dim emailAddressMap As Map
	emailAddressMap.Initialize
	emailAddressMap.Put("address", email)
    
	Dim toRecipientMap As Map
	toRecipientMap.Initialize
	toRecipientMap.Put("emailAddress", emailAddressMap)
    
	' Crear la lista de destinatarios
	Dim toRecipientsList As List
	toRecipientsList.Initialize
	toRecipientsList.Add(toRecipientMap)
    
	' Crear el cuerpo principal del mensaje
	Dim messageContentMap As Map
	messageContentMap.Initialize
	messageContentMap.Put("subject", "Meet for lunch?")
	messageContentMap.Put("body", bodyMap)
	messageContentMap.Put("toRecipients", toRecipientsList)
    
	' Agregar el mensaje al mapa principal
	mensajeMap.Put("message", messageContentMap)
    
	' Convertir el mapa en JSON
	Dim json As JSONGenerator
	json.Initialize(mensajeMap)
	Return json.ToString
End Sub

#IF B4A
Sub GetSignatureHash As String
	Dim jo As JavaObject
	jo.InitializeContext
	Dim signatures() As Object = jo.RunMethodJO("getPackageManager", Null).RunMethodJO("getPackageInfo", _
     Array (Application.PackageName, 0x00000040)).GetField("signatures")
	Dim sig As JavaObject = signatures(0)
	Dim md As MessageDigest
	Dim hash() As Byte = md.GetMessageDigest(sig.RunMethod("toByteArray", Null), "SHA-1")
	Dim bc As ByteConverter
	Dim raw As String = bc.HexFromBytes(hash)
	Dim sb As StringBuilder
	sb.Initialize
	For i = 0 To raw.Length - 2 Step 2
		sb.Append(raw.CharAt(i)).Append(raw.CharAt(i + 1)).Append(":")
	Next
	sb.Remove(sb.Length - 1, sb.Length)
	Return sb.ToString
End Sub
#end if

