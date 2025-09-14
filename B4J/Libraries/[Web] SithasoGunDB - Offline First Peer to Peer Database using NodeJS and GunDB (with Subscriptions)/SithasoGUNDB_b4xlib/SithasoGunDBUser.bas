B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
#IgnoreWarnings:12
#Event: User_Create (ack As Map)
#Event: User_Auth (ack As Map)
#Event: User_ReadPubKeyByAlias (pub As String)
#Event: User_ReadByPubKey (ack As Map)
#Event: User_Error (Error As String)
#Event: User_Load (Data As Map)
#Event: User_Open (Data As Map)
'
Sub Class_Globals
	Private BANano As BANano 'ignore
	Public user As BANanoObject
	Public alias As String
	Public passPhrase As String
	Public g As BANanoObject
	Public mCallBack As Object
	Public mEvent As String
	Public pub As String
	Public epub As String
	Public priv As String
	Public epriv As String
	Public soul As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
'<code>
''store the user details in session store, so that when tabs are changed, user will still be logged in
'user.SaveToSession
'</code>
Public Sub Initialize(Module As Object, EventName As String, gun As SithasoGunDB) As SithasoGunDBUser
	mCallBack = Module
	mEvent = EventName
	g = gun.gun
	user = g.RunMethod("user", Null)
	pub = ""
	epub = ""
	priv = ""
	epriv = ""
	soul = ""
	Return Me
End Sub

'store user in session storage
Sub SaveToSession As SithasoGunDBUser
	'store the user details in session storage
	'the user will be auto-logged in
	Dim useropt As Map = CreateMap()
	useropt.Put("sessionStorage", True)
	user.RunMethod("recall", useropt)
	Return Me
End Sub

'return the user as a collection object
Sub AsCollection As SithasoGunDBCollection
	Dim gcollection As SithasoGunDBCollection
	gcollection.Initialize(mCallBack, g, "")
	gcollection.LinkExisting("user", user)
	Return gcollection
End Sub

Sub setFirstName(fn As String)
	Get("profile.firstname").Put(fn)
End Sub

Sub setLastName(fn As String)
	Get("profile.lastname").Put(fn)
End Sub

Sub setEmail(fn As String)
	Get("profile.email").Put(fn)
End Sub

'create user using alias and passphrase
'<code>
'Sub gun_user_create (ack As Map)
''read the pub key
'dim pub As String = user.pub
'End Sub
''an error has been raised
'sub gun_user_Error (Error As String)
'end sub
'</code>
Sub Create(a As String, p As String)
	alias = a
	passPhrase = p
	If alias = "" Or passPhrase = "" Then Return
	Dim ack As Map
	Dim cb As BANanoObject = BANano.CallBack(Me, "CreateX", Array(ack))
	user.RunMethod("create", Array(alias, passPhrase, cb))
End Sub

private Sub CreateX(ack As Map)
	Dim err As String = GetErrorMessage(ack)
	If err <> "" Then
		BANano.CallSub(mCallBack, $"${mEvent}_user_error"$, Array(err))
		Return
	End If
	epub = ack.Get("pub")
	'read the user details
	priv = modGunDB.GetRecursive(ack, "sea.priv")
	epriv = modGunDB.GetRecursive(ack, "sea.epriv")
	pub = modGunDB.GetRecursive(ack, "sea.pub")
	epub = modGunDB.GetRecursive(ack, "sea.epub")
	soul = modGunDB.GetRecursive(ack, "soul")
	Dim methodName As String = $"${mEvent}_user_create"$
	BANano.CallSub(mCallBack, methodName, Array(ack))
End Sub

Sub GetErrorMessage(response As Map) As String
	If response.ContainsKey("err") Then
		Dim res As String = response.Get("err")
		Return res
	Else
		Return ""
	End If
End Sub


'get the public key of the user using the alias
'<code>
'Sub gun_user_ReadPubKeyByAlias (pub As String)
'End Sub
'</code>
Sub ReadPubKeyByAlias(salias As String)
	Dim data As Object
	Dim cb As BANanoObject = BANano.CallBack(Me, "ReadPubX", Array(data))
	g.RunMethod("get", $"~@${salias}"$).RunMethod("once", cb)
End Sub

private Sub ReadPubX(data As Map)
	Dim sout As String = ""
	If BANano.IsUndefined(data) = False Then
		data.Remove("_")
		sout = data.GetKeyAt(0)	
	End If
	If sout = "" Then
		BANano.CallSub(mCallBack, $"${mEvent}_user_error"$, Array("The alias does not exist!"))
	Else	
		Dim methodName As String = $"${mEvent}_user_ReadPubKeyByAlias"$
		BANano.CallSub(mCallBack, methodName, Array(sout))
	End If
End Sub


'subscribe to my public key
'Sub Subscribe
'	SubscribeTo(Pub)
'End Sub

'subscribe to another public key
'Sub SubscribeTo(pubKey As String)
'	pubKey = pubKey.Replace("~","")
'	Dim data As Map
'	Dim id As Object
'	Dim cb As BANanoObject = BANano.CallBack(mCallBack, $"${mEvent}_user_subscribe"$, Array(data, id))
'	g.RunMethod("user", pubKey).RunMethod("on", cb)
'End Sub

'read a user by public key
'authorise a user
'<code>
'Sub gun_user_ReadByPubKey (ack As Map)
'End Sub
'</code>
Sub ReadByPubKey(pubKey As String)
	pubKey = pubKey.Replace("~","")
	Dim ack As Map
	Dim cb As BANanoObject = BANano.CallBack(mCallBack, $"${mEvent}_user_ReadByPubKey"$, Array(ack))
	g.RunMethod("user", pubKey).RunMethod("once", cb)
End Sub

'read a users alias by public key
Sub AliasByPubKey(pubKey As String) As String
	Try
		pubKey = pubKey.Replace("~","")
		Dim otherAlias As String = BANano.Await(g.RunMethod("user", pubKey).RunMethod("get", "alias").RunMethod("then", Null))
		Return otherAlias
	Catch
		Return ""
	End Try
End Sub

'return if user is signed in
Sub IsSignedIn As Boolean
	Dim b As Map = user.GetField("is").Result
	If BANano.IsUndefined(b) Then Return False
	Return True
End Sub

'authorise a user
'<code>
'Sub gun_user_auth (ack As Map)
'End Sub
''an error has been raised
'sub gun_user_Error (Error As String)
'end sub
'</code>
Sub Auth(a As String, p As String)
	alias = a
	passPhrase = p
	If alias = "" Or passPhrase = "" Then Return
	Dim ack As Map
	Dim cb As BANanoObject = BANano.CallBack(Me, "AuthX", Array(ack))
	user.RunMethod("auth", Array(alias, passPhrase, cb))
End Sub

private Sub AuthX(ack As Map)
	Dim err As String = GetErrorMessage(ack)
	If err <> "" Then
		BANano.CallSub(mCallBack, $"${mEvent}_user_error"$, Array(err))
		Return
	End If
	'read the user details
	priv = modGunDB.GetRecursive(ack, "sea.priv")
	epriv = modGunDB.GetRecursive(ack, "sea.epriv")
	pub = modGunDB.GetRecursive(ack, "sea.pub")
	epub = modGunDB.GetRecursive(ack, "sea.epub")
	soul = modGunDB.GetRecursive(ack, "soul")
	Dim methodName As String = $"${mEvent}_user_auth"$
	BANano.CallSub(mCallBack, methodName, Array(ack))
End Sub

Sub Delete As BANanoPromise
	If alias = "" Or passPhrase = "" Then Return Null
	Dim bp As BANanoPromise = user.RunMethod("delete", Array(alias, passPhrase)).RunMethod("then", Null)
	Return bp
End Sub

Sub SignOut
	user.RunMethod("leave", Null)
End Sub
'
'Sub Put(key As String, value As Object)
'	user.RunMethod("get", key).RunMethod("put", value)
'End Sub
'
'Sub Get(key As String) As BANanoPromise
'	Dim bp As BANanoPromise = user.RunMethod("get", key).RunMethod("once", Null).RunMethod("then", Null)
'	Return bp
'End Sub

'get a collection from the gun instance
Sub Get(collName As String) As SithasoGunDBCollection
	Dim boList As List
	boList.Initialize
	boList.Add(user)
	Dim paths As List = modGunDB.StrParse(".", collName)
	Dim tPaths As Int = paths.Size - 1
	Dim cPath As Int = 0
	For cPath = 0 To tPaths
		'get the last item
		Dim pObject As BANanoObject = boList.Get(cPath)
		Dim nPart As String = paths.Get(cPath)
		Dim ni As BANanoObject = pObject.RunMethod("get", nPart)
		boList.Add(ni)
		collName = nPart
	Next
	'
	tPaths = boList.Size - 1
	Dim coll As BANanoObject = boList.Get(tPaths)
	Dim gcollection As SithasoGunDBCollection
	gcollection.Initialize(mCallBack, g, "")
	gcollection.LinkExisting(collName, coll)
	Return gcollection
End Sub

'return the alias and pub of user
Sub getPublicProfile As Map
	Dim u As Map = CreateMap()
	u.Put("alias", alias)
	u.Put("pub", pub)
	Return u
End Sub

Sub Load As SithasoGunDBUser
	Dim data As Map
	Dim cb As BANanoObject = BANano.CallBack(mCallBack, $"${mEvent}_user_load"$, Array(data))
	user.RunMethod("load", cb)
	Return Me
End Sub

Sub Open As SithasoGunDBUser
	Dim data As Map
	Dim cb As BANanoObject = BANano.CallBack(mCallBack, $"${mEvent}_user_open"$, Array(data))
	user.RunMethod("open", cb)
	Return Me
End Sub