B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11
@EndOfDesignText@
Sub Class_Globals
	Private m_clientid, m_accesstoken, m_refreshtoken As String	
	Private m_secret As String
	'reference: https://stackoverflow.com/questions/21448005/how-do-i-upload-to-an-imgur-users-account
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	'your client id
	m_clientid = "XXXXXXXXXXXXXXX"
	'your secret
	m_secret = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	'your refresh token
	m_refreshtoken = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	'your access token
	m_accesstoken = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	'Get client_id and secret by Registration:
	'https://api.imgur.com/oauth2/addclient
	'Get refresh token and access token in responding web page's url input textbox:
	'https://api.imgur.com/oauth2/authorize?client_id=<clientid>&response_type=token
End Sub
' Refresh update-to-date access_token 
Public Sub sendOAuthRequest() As ResumableSub
	Dim url As String = "https://api.imgur.com/oauth2/token"
	Dim job As HttpJob
	job.Initialize("post", Me)
	Dim mapData As Map
	mapData.Initialize
	mapData.Put("refresh_token", m_refreshtoken)
	mapData.Put("client_id", m_clientid)
	mapData.Put("client_secret", m_secret)
	mapData.Put("grant_type", "refresh_token")
	'Dim jsonGen As JSONGenerator
	'jsonGen.Initialize(mapData)
	job.PostMultipart(url, mapData, Null)
	Wait For (job) JobDone(j As HttpJob)
	If j.Success Then
		Log(j.GetString)
		Return True
	End If
	Return False
End Sub
' Search keyword of image (i.e. anonymous get)
Public Sub sendGetRequest() As ResumableSub
	Dim url2 As String = "https://api.imgur.com/3/gallery/search"
	'Dim url As String = "https://api.imgur.com/3/gallery/search?q=monkey"
	Dim auth As String = "Client-ID " & m_clientid	
	Dim job As HttpJob
	job.Initialize("get", Me)
	job.Download2(url2, Array As String("q", "monkey"))
	'job.Download(url)
	job.GetRequest.SetHeader("authorization", auth)
	Wait For (job) JobDone(j As HttpJob)
	If j.Success Then
		Log(j.GetString)
		Return True
	End If
	Return False
End Sub
' Anonymous upload 
Public Sub sendPostRequest() As ResumableSub
	Dim url As String = "https://api.imgur.com/3/image"
	Dim auth As String = "Client-ID " & m_clientid
	Dim job As HttpJob
	job.Initialize("post", Me)
	Dim mapData As Map
	mapData.Initialize
	mapData.Put("image", getImageString)
	mapData.Put("type", "base64")
	'Dim jsonGen As JSONGenerator
	'jsonGen.Initialize(mapData)
	job.PostMultipart(url, mapData, Null)
	job.GetRequest.SetHeader("Authorization", auth)
	Wait For (job) JobDone(j As HttpJob)
	If j.Success Then
		Log(j.GetString)
		Return True
	End If
	Return False
End Sub
' Non-anonymous upload to user's account
Public Sub sendPostRequest2() As ResumableSub
	Dim url As String = "https://api.imgur.com/3/upload"
	Dim auth As String = "BEARER " & m_accesstoken
	Dim job As HttpJob
	job.Initialize("post", Me)
	Dim mapData As Map
	mapData.Initialize
	'mapData.Put("image", getImageString)
	mapData.Put("image", imageToString(File.DirRootExternal & "/b4ximgur/images", "smile.png"))
	mapData.Put("type", "base64")
	job.PostMultipart(url, mapData, Null)
	job.GetRequest.SetHeader("Authorization", auth)
	Wait For (job) JobDone(j As HttpJob)
	If j.Success Then
		Log(j.GetString)
		Return True
	End If
	Return False
End Sub
' Get sample image from image file
Private Sub imageToString(dir As String, fn As String) As String
	If File.Exists(dir, fn) = False Then
		Return ""
	End If
	'Read the image into an array of bytes.
	Dim b() As Byte = File.ReadBytes(dir, fn)
	Dim su As StringUtils
	Dim str As String = su.EncodeBase64(b)
	LogColor(str, Colors.Red)
	Return str
End Sub
' Get sample image in base64 string format
Private Sub getImageString() As String
	' Reference: https://www.base64-image.de/
	Return "iVBORw0KGgoAAAANSUhEUgAAAN0AAADQCAYAAACDWmTEAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAM/SURBVHhe7dyxbRRRGEZRL5KdOLJE5B52I1dAAZTggA5ciTswkmNqcAWOnBKRbMJKiICEDRZLPIkG5l1pzDnJfAXM1cv+zenV2Yrsdrux4K+Xl5ex1uHd+AIR0UFMdBATHcREBzHRQUx0EBMdxEQHMdFBTHQQEx3ERAcx0UFMdBATHcREBzHRQUx0EBMdxEQHsWnXwGZd7bp4ehiLNfn++ctYyzveP461rP1+P9ayvHQQEx3ERAcx0UFMdBATHcREBzHRQUx0EBMdxEQHMdFBTHQQEx3ERAcx0UFMdBATHcREBzHRQUx0EBMdxDbb7XbKCb5Zp/Ke39+MtQ43h+ex/m8zT/DNMuu0n5cOYqKDmOggJjqIiQ5iooOY6CAmOoiJDmKig5joICY6iIkOYqKDmOggJjqIiQ5iooOY6CAmOoiJDmKig5gTfINTef+s8VzeDE7wwRshOoiJDmKig5joICY6iIkOYqKDmOggJjqIiQ5iooOY6CAmOoiJDmKig5joICY6iIkOYqKDmOggJjqIiQ5iq7t7OcvvD5/G4nA4jLWc87vbsdbD3Ut4I0QHMdFBTHQQEx3ERAcx0UFMdBATHcREBzHRQUx0EBMdxEQHMdFBTHQQEx3ERAcx0UFMdBATHcREB7HVneCbdSrv57evYzHD8fJqrOXNOu/nBB+8EaKDmOggJjqIiQ5iooOY6CAmOoiJDmKig5joICY6iIkOYqKDmOggJjqIiQ5iooOY6CAmOoiJDmKig5joICY6iIkOYqKDmOggJjqIiQ5iooOY6CAmOoiJDmKig5joICY6iIkOYqKDmOggJjqIiQ5iooOY6CAmOoiJDmKb7XZ7GntRF08PYy1rv/s41rLOf/0YixmOl1djLe/87nasZR3vH8dalpcOYqKDmOggJjqIiQ5iooOY6CAmOoiJDmKig5joICY6iIkOYqKDmOggJjqIiQ5iooOY6CAmOoiJDmKig5joILY5vRp7UbvdbqxlHQ6HsZa13+/HYobr6+ux1mPWP+Glg5joICY6iIkOYqKDmOggJjqIiQ5iooOY6CAmOoiJDmKig5joICY6iIkOYqKDmOggJjqIiQ5iooOY6CB1dvYHXx5W/ygYgYUAAAAASUVORK5CYII="
End Sub