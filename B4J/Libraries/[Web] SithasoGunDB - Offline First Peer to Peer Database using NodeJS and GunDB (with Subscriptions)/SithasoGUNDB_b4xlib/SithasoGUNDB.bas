B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
' Your BANano library
#IgnoreWarnings:12
#Event: Auth ()

Sub Class_Globals
	Private BANano As BANano 'ignore
	Private mCallBack As Object		'ignore
	Private EventName As String	'ignore
	Public gun As BANanoObject
	Public peers As List
	Private gunOpt As Map
End Sub


'<code>
''set the db name
'gun.DbName = "radata"
''use indexedDB
'gun.LocalStorage = False
''use file on disk for NodeJS, set to true if you will install peer
'gun.Radisk = True
''add a peer relay if you want
''clone this repo: https://github.com/Mashiane/SithasoGunDBPeer01
''install node.js, in terminal run 'npm install' then 'npn run start'
''gun.AddPeer("http://localhost:8765")
''connect to gun
'gun.connect
'</code>
Public Sub Initialize(Module As Object, mEventName As String)
	mCallBack = Module
	EventName = mEventName
	peers.Initialize 
	gunOpt.Initialize
End Sub

'set local storage
Sub setLocalStorage(b As Boolean)
	gunOpt.put("localStorage", b)
End Sub

'set radisk, persist to disk on node
Sub setRadisk(b As Boolean)
	gunOpt.Put("radisk", b)
End Sub

'set file
Sub setDbName(s As String)
	gunOpt.Put("file", s)
End Sub

'Sub setS3Key(key As String)
'	modGunDB.PutRecursive(gunOpt, "s3.key", key)
'End Sub
'
'Sub setS3Secret(secret As String)
'	modGunDB.PutRecursive(gunOpt, "s3.secret", secret)
'End Sub
'
'Sub setS3BucketName(bucket As String)
'	modGunDB.PutRecursive(gunOpt, "s3.bucket", bucket)
'End Sub

'add a peer to the db
Sub AddPeer(peer As String)
	peers.Add(peer)
End Sub

'connect to the backebd
Sub Connect
	If peers.Size >= 0 Then gunOpt.Put("peers", peers)
	gun = BANano.RunJavascriptMethod("Gun", Array(gunOpt))
	'trap changes in auth
	Dim cb As BANanoObject = BANano.CallBack(mCallBack, $"${EventName}_Auth"$, Null)
	gun.RunMethod("on", Array("auth", cb))
End Sub

'get an error response from map
Sub GetErrorMessage(response As Map) As String
	If response.ContainsKey("err") Then
		Dim res As String = response.Get("err")
		Return res
	Else
		Return ""	
	End If
End Sub

'get a collection from the gun instance
Sub Get(Module As Object, collName As String) As SithasoGunDBCollection
	Dim boList As List
	boList.Initialize
	boList.Add(gun)
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
	gcollection.Initialize(Module, gun, "")
	gcollection.LinkExisting(collName, coll)
	Return gcollection
End Sub

'get own unique key with 32 chars alphabets only
'this is a controlled id
Sub NextID As String
	Dim ni As String = "i" & guidAlphaAppGUN(14)
	Return ni
End Sub

private Sub guidAlphaAppGUN(glen As Int) As String
	Dim s As String = BANano.RunJavascriptMethod("guidAlphaAppGUN", Array(glen))
	s = s.ToLowerCase
	Return s
End Sub

#if javascript
function guidAlphaAppGUN(len) {
        var buf = [],
            chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789',
            charlen = chars.length,
            length = len || 32;
            
        for (var i = 0; i < length; i++) {
            buf[i] = chars.charAt(Math.floor(Math.random() * charlen));
        }
        
        return buf.join('');
    }
#end if
