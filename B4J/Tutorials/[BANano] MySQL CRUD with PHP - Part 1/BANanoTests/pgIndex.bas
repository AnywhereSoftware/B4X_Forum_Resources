B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private banano As BANano
	Public PhpPath As String = $"http://127.0.0.1/AJAX/assets/"$
	Public BANanano As BANano
End Sub

Sub Init()
	banano.GetElement("#body").Empty
	banano.GetElement("#body").Append($"<input id="txtusername" type="text" placeholder="User Name"></input><br><br>"$)
	banano.GetElement("#body").Append($"<input id="txtpassword" type="password" placeholder="Password"></input><br><br>"$)
	banano.GetElement("#body").Append($"<button id="btnlogin">LOGIN</button><br><br>"$)
	banano.GetElement("#body").Append($"<button id="btnloginw">LOGIN WAIT</button><br><br>"$)
	banano.GetElement("#body").Append($"<button id="btnregister">REGISTER</button><br><br>"$)
	
	banano.GetElement("#btnlogin").On("click", Me, "login")
	banano.GetElement("#btnloginw").On("click", Me, "loginw")
	banano.GetElement("#btnregister").On("click", Me, "register")
End Sub

Sub register(e As BANanoEvent)
	If banano.CheckInternetConnectionWait Then
		Dim strUser As String = banano.GetElement("#txtusername").GetValue
		'build php query
		Dim straction As String = "checkusername"
		Dim dbAction As Map
		dbAction.Initialize
		dbAction.Put("action=", straction)
		dbAction.Put("username=", strUser)
		'execute php
		ExecutePHP(dbAction,"users.php",straction)
	End If
End Sub

Sub login(e As BANanoEvent)
	If banano.CheckInternetConnectionWait Then
		Dim strUser As String = banano.GetElement("#txtusername").GetValue
		Dim strPwd As String = banano.GetElement("#txtpassword").GetValue
		'build php query
		Dim straction As String = "validateuser"
		Dim dbAction As Map
		dbAction.Initialize
		dbAction.Put("action=", straction)
		dbAction.Put("username=", strUser)
		dbAction.Put("userpassword=", strPwd)
		'execute php
		ExecutePHP(dbAction,"users.php",straction)
	End If
End Sub

Sub ExecutePHP(pQuery As Map, phpFile As String, phpTag As String)
	Dim json As String
	Dim sCommand As String = ""
	json = Map2QueryString(pQuery)
	If Len(json) = 0 Then
		sCommand = $"${PhpPath}${phpFile}"$
	Else
		sCommand = $"${PhpPath}${phpFile}?${json}"$
	End If
	'create the headers
	Dim headers As Map
	headers.Initialize
	headers.put("Content-Type", "application/json")
	headers.Put("Access-Control-Allow-Origin", "*")
	banano.CallAjax(sCommand, "GET", "json","",phpTag,False, headers)
End Sub


Sub BANano_CallAjaxResult(Success As Boolean, UniqueID As String, Result As String)
	If Success Then
		'convert ths json result to a list
		Dim res As List = Json2List(Result)
		Select Case UniqueID
		Case "validateuser"
			If res.Size = 0 Then
				'user not validated
				banano.Msgbox("The user credentials could not be validated!")
			Else
				banano.Msgbox("Go on, show another screen...")
			End If
		Case "checkusername"
			If res.Size = 0 Then
				' this username does not exist
				RegisterUser
			Else
				' this username exists
				banano.Msgbox("A user with the specified username already exists!")
				End If
		Case "registeruser"
			If res.Size = 0 Then
				banano.Msgbox("User could not be registered successfully, please try again!")
			Else
				banano.Msgbox("User was successfully registered!")
			End If
		End Select
	End If
End Sub


'convert a json string to a map
Sub Json2Map(strJSON As String) As Map
	Dim json As BANanoJSONParser
	Dim Map1 As Map
	Map1.Initialize
	Map1.clear
	Try
		If strJSON.length > 0 Then
			json.Initialize(strJSON)
			Map1 = json.NextObject
		End If
		Return Map1
	Catch
		Return Map1
	End Try
End Sub

' convert a json string to a list
Sub Json2List(strValue As String) As List
	Dim lst As List
	lst.Initialize
	lst.clear
	If strValue.Length = 0 Then
		Return lst
	End If
	Try
		Dim parser As BANanoJSONParser
		parser.Initialize(strValue)
		Return parser.NextArray
	Catch
		Return lst
	End Try
End Sub

Sub loginw(e As BANanoEvent)
	Dim strUser As String = banano.GetElement("#txtusername").GetValue
	Dim strPwd As String = banano.GetElement("#txtpassword").GetValue
	'build php query
	Dim straction As String = "validateuser"
	Dim dbAction As Map
	dbAction.Initialize
	dbAction.Put("action=", straction)
	dbAction.Put("username=", strUser)
	dbAction.Put("userpassword=", strPwd)
	'execute php
	Dim res As String = ExecutePHPWait(dbAction,"users.php",straction)
	Log(res)
	Log("Done")
End Sub


Sub ExecutePHPWait(pQuery As Map, phpFile As String, phpTag As String) As String
	Dim json As String
	Dim sCommand As String = ""
	json = Map2QueryString(pQuery)
	If Len(json) = 0 Then
		sCommand = $"${PhpPath}${phpFile}"$
	Else
		sCommand = $"${PhpPath}${phpFile}?${json}"$
	End If
	'create the headers
	Dim headers As Map
	headers.Initialize
	headers.put("Content-Type", "application/json")
	headers.Put("Access-Control-Allow-Origin", "*")
	Dim result As String = banano.CallAjaxWait(sCommand, "GET", "json","",False, headers)
	Return result
End Sub


'get the length of the string
Sub Len(Text As String) As Int
	Return Text.Length
End Sub

'convert a map to a querystring
Sub Map2QueryString(sm As Map) As String
	' convert a map to a querystring string
	Dim iCnt As Int
	Dim iTot As Int
	Dim sb As StringBuilder
	Dim mValue As String
	sb.Initialize
	
	' get size of map
	iTot = sm.Size - 1
	iCnt = 0
	For Each mKey As String In sm.Keys
		mValue = sm.Getdefault(mKey,"")
		mValue = mValue.trim
		mValue = banano.EncodeURI(mValue)
		mKey = mKey.Trim
		If mKey.EndsWith("=") = False Then mKey = mKey & "="
		sb.Append(mKey).Append(mValue)
		If iCnt < iTot Then sb.Append("&")
		iCnt = iCnt + 1
	Next
	Return sb.ToString
End Sub

'register the user
Sub RegisterUser
	Dim strUser As String = banano.GetElement("#txtusername").GetValue
	Dim strPwd As String = banano.GetElement("#txtpassword").GetValue
	strUser = strUser.Trim
	strPwd = strPwd.trim
	Dim straction As String = "registeruser"
	Dim dbAction As Map
	dbAction.Initialize
	dbAction.Put("action=", straction)
	dbAction.Put("username=", strUser)
	dbAction.Put("userpassword=", strPwd)
	ExecutePHP(dbAction, "users.php", "registeruser")
End Sub