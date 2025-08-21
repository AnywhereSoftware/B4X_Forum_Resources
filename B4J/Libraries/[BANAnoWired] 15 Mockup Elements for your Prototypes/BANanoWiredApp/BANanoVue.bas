B4J=true
Group=Default Group\Library
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Private BOVue As BANanoObject
	Private BANAno As BANano  'ignore
	Private methods As Map
	Public data As Map
	Private refs As Map
	Public body As BANanoElement
	Public Template As VueHTML
	Private computed As Map
	Private watches As Map
	Private created As Map
	Private mounted As Map
	Private destroyed As Map
	Private updated As Map
End Sub

'initialize view
Public Sub Initialize()
	BOVue.Initialize("Vue")
	'empty the body of the page
	body = BANAno.GetElement("#body")
	body.empty
	'add an empty div
	body.Append($"<div id="app"></div>"$)
	Template.Initialize("app","div") 
	methods.Initialize
	data.Initialize
	computed.Initialize  
	watches.Initialize
	created.Initialize
	mounted.Initialize
	destroyed.Initialize
	updated.Initialize
End Sub

Sub AuditTrail(oldM As Map, newM As Map) As Map
	Dim df As Map = CreateMap()
	For Each k As String In oldM.Keys
		Dim v As Object = oldM.Get(k)
		If newM.ContainsKey(k) Then
			Dim nv As Object = newM.Get(k)
			If v <> nv Then
				df.Put(k, nv)
			End If
		End If
	Next
	For Each k As String In newM.Keys
		Dim v As Object = newM.Get(k)
		If oldM.ContainsKey(k) Then
			Dim ov As Object = oldM.Get(k)
			If v <> ov Then
				df.Put(k, v)
			End If
		Else
			df.Put(k, v)	
		End If
	Next
	Return df
End Sub

Public Sub DateTimeNow() As String
	Dim lNow As Long
	Dim dt As String
	lNow = DateTime.Now
	DateTime.DateFormat = "yyyy-MM-dd"
	dt = DateTime.Date(lNow)
	Return dt
End Sub

Public Sub DateNow() As String
	Dim lNow As Long
	Dim dt As String
	lNow = DateTime.Now
	DateTime.DateFormat = "yyyy-MM-dd HH:mm"
	dt = DateTime.Date(lNow)
	Return dt
End Sub


Sub LongDateTimeToday() As String
	DateTime.DateFormat = "yyyy-MM-dd HH:mm"
	Dim dt As Long = DateTime.now
	DateTime.DateFormat = "dd/MM/yyyy, HH:mm"
	Return DateTime.Date(dt)
End Sub

Sub CopyMap(source As Map, keys As List) As Map
	Dim nm As Map = CreateMap()
	If keys.Get(0) = "*" Then
		For Each k As String In source.Keys
			Dim v As Object = source.Get(k)
			nm.Put(k, v)
		Next
	Else
		For Each k As String In keys
			Dim v As Object = source.Get(k)
			nm.Put(k, v)
		Next
	End If
	Return nm
End Sub


Sub Validate(rec As Map, required As Map) As Boolean
	Dim iv As Int = 0
	For Each k As String In rec.Keys
		If required.ContainsKey(k) Then
			Dim v As String = rec.GetDefault(k,"")
			v = CStr(v)
			v = v.trim
			If v = "" Then
				Log("Validate: " & k) 
				iv = iv + 1
			End If
		End If	
	Next
	If iv = 0 Then
		Return True
	Else
		Return False
	End If
End Sub


'convert object to string
Sub CStr(o As Object) As String
	Return "" & o
End Sub

Sub FixRecords(recs As List, trimThese As List, numThese As List, boolThese As List)
	Dim rTot As Int = recs.Size - 1
	Dim rCnt As Int
	For rCnt = 0 To rTot
		Dim rec As Map = recs.Get(rCnt)
		Dim bChanged As Boolean = False
		If trimThese <> Null Then 
			bChanged = True
			MakeTrim(rec,trimThese)
		End If
		If numThese <> Null Then
			bChanged = True
			 MakeNumeric(rec, numThese)
		End If
		If boolThese <> Null Then 
			bChanged = True
			MakeBoolean(rec, boolThese)
		End If
		If bChanged Then recs.Set(rCnt, rec)	
	Next
End Sub

Sub MakeNumeric(m As Map, keys As List)
	For Each k As String In m.Keys
		Dim idxPos As Int = keys.IndexOf(k)
		If idxPos >= 0 Then
			Dim v As String = m.GetDefault(k,"")
			v = CStr(v)
			v = v.trim
			If v = "" Then v = "0"
			v = BANAno.parseInt(v)
			m.Put(k, v)
		End If
	Next
End Sub

Sub MakeBoolean(m As Map, keys As List)
	For Each k As String In m.Keys
		Dim idxPos As Int = keys.IndexOf(k)
		If idxPos >= 0 Then
			Dim v As String = m.GetDefault(k,"")
			v = CStr(v)
			v = v.trim
			Select Case v
			Case "","0", "false"
				m.Put(k, False)
			Case "1", "true"		
				m.Put(k, True)
			End Select
		End If
	Next
End Sub

Sub MakeTrim(m As Map, keys As List)
	For Each k As String In m.Keys
		Dim idxPos As Int = keys.IndexOf(k)
		If idxPos >= 0 Then
			Dim v As String = m.GetDefault(k,"")
			v = CStr(v)
			v = v.trim
			m.Put(k, v)
		End If
	Next
End Sub


'get id from event
Sub GetIDFromEvent(e As BANanoEvent) As String
	Dim curEve As BANanoElement = BANAno.ToElement(e.OtherField("currentTarget"))
	Dim id As String = curEve.GetField("id").Result
	Return id
End Sub

Sub CallComputed(methodName As String) As Object
	methodName = methodName.tolowercase
	Return BOVue.GetField(methodName)
End Sub

Sub CallMethod(methodName As String)
	methodName = methodName.tolowercase
	BOVue.RunMethod(methodName, Null)
End Sub

Sub RunMethod(methodName As String, params As Object) As BANanoObject
	Return BOVue.RunMethod(methodName, params)
End Sub

Sub SetStateTrue(k As String) As BANanoVue
	SetStateSingle(k,True)
	Return Me
End Sub

Sub SetStateFalse(k As String) As BANanoVue
	SetStateSingle(k,False)
	Return Me
End Sub

Sub SetStateIncrement(k As String) As BANanoVue
	Dim oldV As String = GetState(k, "0")
	oldV = BANAno.parseInt(oldV) + 1
	SetStateSingle(k, oldV)
	Return Me
End Sub

Sub SetStateDecrement(k As String) As BANanoVue
	Dim oldV As String = GetState(k, "0")
	oldV = BANAno.parseInt(oldV) - 1
	SetStateSingle(k, oldV)
	Return Me
End Sub


'a single state change
Sub SetStateSingle(k As String, v As Object) As BANanoVue
	Dim opt As Map = CreateMap()
	opt.Put(k, v)
	SetState(opt)
	Return Me 
End Sub

Sub ToggleState(stateName As String) As BANanoVue
	Dim bcurrent As Boolean = GetState(stateName,"")
	bcurrent = Not(bcurrent)
	Dim opt As Map = CreateMap()
	opt.Put(stateName, bcurrent)
	SetState(opt)
	Return Me	
End Sub

' parse a string to a list
Sub StrParse(Delim As String, InputString As String) As List
	Dim OutList As List
	Dim CommaLoc As Int
	OutList.Initialize
	OutList.clear
	CommaLoc=InputString.IndexOf(Delim)
	Do While CommaLoc >-1
		Dim LeftSide As String
		LeftSide= InputString.SubString2(0,CommaLoc)
		Dim RightSide As String
		RightSide= InputString.SubString(CommaLoc+1)
		OutList.Add(LeftSide)
		InputString=RightSide
		CommaLoc=InputString.IndexOf(Delim)
	Loop
	OutList.Add(InputString)
	Return OutList
End Sub

'mvfield sub
Sub MvField(sValue As String, iPosition As Int, Delimiter As String) As String
	If sValue.Length = 0 Then Return ""
	Dim xPos As Int = sValue.IndexOf(Delimiter)
	If xPos = -1 Then Return sValue
	Dim mValues As List = StrParse(Delimiter,sValue)
	Dim tValues As Int
	tValues = mValues.size -1
	Select Case iPosition
		Case -1
			Return mValues.get(tValues)
		Case -2
			Return mValues.get(tValues - 1)
		Case -3
			Dim sb As StringBuilder
			sb.Initialize
			Dim startcnt As Int
			sb.Append(mValues.Get(1))
			For startcnt = 2 To tValues
				sb.Append(Delimiter)
				sb.Append(mValues.get(startcnt))
			Next
			Return sb.tostring
		Case Else
			iPosition = iPosition - 1
			If iPosition <= -1 Then
				Return mValues.get(tValues)
			End If
			If iPosition > tValues Then
				Return ""
			End If
			Return mValues.get(iPosition)
	End Select
End Sub


'Returns a random list value from a LIST 
Sub RandListValue(ListX As List) As Object
	ShuffleList(ListX)
	Return ListX.Get(Rnd(0, ListX.Size -1))
End Sub

'remove from list
Sub RamoveFromList(listX As List, item As String)
	Dim li As Int = listX.IndexOf(item)
	If li >= 0 Then listX.RemoveAt(li)
End Sub

Sub ShuffleList(pl As List) As List
	For i = pl.Size - 1 To 0 Step -1
		Dim j As Int
		Dim k As Object
		j = Rnd(0, i + 1)
		k = pl.Get(j)
		pl.Set(j,pl.Get(i))
		pl.Set(i,k)
	Next
	Return pl
End Sub


'check if we have state
Sub StateExists(stateName As String) As Boolean
	stateName = stateName.tolowercase
	Return data.ContainsKey(stateName)
End Sub

''set the font family
Sub SetFontFamily(ff As Object)
	body.SetStyle(BANAno.ToJson(CreateMap("font-family": ff)))
End Sub

'set the background image style
Sub SetCoverImage(imgURL As String)
	Dim opt As Map = CreateMap()
	If imgURL = "none" Then
		opt.Put("background-image", "none")
	Else
		'opt.Put("background-image", $"url('${imgURL}')"$)
		'opt.Put("background-position", "center center")
		'opt.Put("background-repeat", "no-repeat")
		'opt.Put("background-attachment", "fixed")
		'opt.Put("background-size", "cover")
		
		opt.Put("background", $"url('${imgURL}')"$)
		opt.Put("position", "absolute")
		opt.Put("height", "100%")
		opt.Put("width", "100%")
		opt.Put("top", "0")
		opt.Put("bottom", "0")
		opt.Put("right", "0")
		opt.Put("left", "0")
		opt.Put("z-index", "0")
	End If
	Dim sjson As String = BANAno.ToJson(opt)
	body.SetStyle(sjson)
End Sub

'inject the template
Sub SetTemplate(tmp As String)
	Template.SetText(tmp)
End Sub

'use a component module
Sub Use(bo As BANanoObject)
	BOVue.RunMethod("use", bo)
End Sub

Sub SetFocus(sid As String) As BANanoVue
	If sid <> "" Then
		sid = sid.tolowercase
		Dim input As BANanoObject = refs.Get(sid)
		Dim el As String = "$el"
		input.GetField(el).RunMethod("focus", Null)
	End If
	Return Me
End Sub


'render the ux
Sub UX()
	Dim tmp As String = Template.tostring
	Dim opt As Map = CreateMap()
	opt.Put("el", "#app")
	If data.Size > 0 Then
		opt.put("data", data)
	End If
	If methods.Size > 0 Then
		opt.Put("methods", methods)
	End If
	If computed.Size > 0 Then
		opt.Put("computed", computed)
	End If
	If watches.Size > 0 Then
		opt.Put("watch", watches)
	End If
	If updated.Size > 0 Then
		opt.Put("updated", updated)
	End If
	If destroyed.Size > 0 Then
		opt.Put("destroyed", destroyed)
	End If
	If mounted.Size > 0 Then
		opt.Put("mounted", mounted)
	End If
	If created.Size > 0 Then
		opt.Put("created", created)
	End If
	opt.Put("template", tmp)
	BOVue.Initialize2("Vue", opt)
	'get the state
	Dim dKey As String = "$data"
	data = BOVue.GetField(dKey).Result
	'get the refs
	Dim rKey As String = "$refs"
	refs = BOVue.GetField(rKey).result
End Sub

Sub ForceUpdate
	Dim fu As String = "$forceUpdate"
	BOVue.RunMethod(fu, Null)
	'get the state
	Dim dKey As String = "$data"
	data = BOVue.GetField(dKey).Result
	'get the refs
	Dim rKey As String = "$refs"
	refs = BOVue.GetField(rKey).result
End Sub

'add a method
Sub SetMethod(methodName As String, cb As BANanoObject) As BANanoVue
	methodName = methodName.tolowercase
	methods.Put(methodName, cb)
	Return Me
End Sub

'set mounted
Sub SetMounted(k As String, module As Object, methodName As String) As BANanoVue
	methodName = methodName.ToLowerCase
	k = k.tolowercase
	Dim cb As BANanoObject = BANAno.CallBack(module, methodName, Null)
	mounted.Put(k, cb)
	If SubExists(module, methodName) = False Then
		Log($"SetMounted: ${methodName} does not exist!"$)
	End If
	Return Me
End Sub

'set created
Sub SetCreated(k As String, module As Object, methodName As String) As BANanoVue
	methodName = methodName.ToLowerCase
	k = k.tolowercase
	Dim cb As BANanoObject = BANAno.CallBack(module, methodName, Null)
	computed.Put(k, cb)
	Return Me
End Sub

'set direct method
Sub SetMethod1(k As String, module As Object, methodName As String) As BANanoVue
	methodName = methodName.ToLowerCase
	k = k.tolowercase
	Dim e As BANanoEvent
	Dim cb As BANanoObject = BANAno.CallBack(module, methodName, Array(e))
	methods.Put(k, cb)
	If SubExists(module, methodName) = False Then
		Log($"SetMethod1: ${methodName} does not exist!"$)
	End If
	Return Me
End Sub

'set computed
Sub SetComputed(k As String, module As Object, methodName As String) As BANanoVue
	methodName = methodName.ToLowerCase
	k = k.tolowercase
	Dim e As BANanoEvent
	Dim cb As BANanoObject = BANAno.CallBack(module, methodName, Array(e))
	computed.Put(k, cb)
	If SubExists(module, methodName) = False Then
		Log($"SetComputed: ${methodName} does not exist!"$)
	End If
	Return Me
End Sub

Sub SetNextTick(module As Object, methodName As String) As BANanoVue
	methodName = methodName.ToLowerCase
	Dim cb As BANanoObject = BANAno.CallBack(module, methodName, Null)
	BOVue.RunMethod("nextTick", cb)
	Return Me
End Sub


'set watches 
Sub SetWatch(k As String, bImmediate As Boolean, bDeep As Boolean, module As Object, methodName As String) As BANanoVue
	methodName = methodName.tolowercase
	k = k.tolowercase
	If data.ContainsKey(k) Then
		Dim newVal As Object
		Dim cb As BANanoObject = BANAno.CallBack(module, methodName, Array(newVal))
		Dim deepit As Map = CreateMap()
		deepit.Put("handler", methodName)
		deepit.Put("deep", bDeep)
		deepit.Put("immediate", bImmediate)
		watches.Put(k, deepit)
		SetMethod(methodName, cb)
	Else
		Log("First set the v-model for " & k)
	End If	
	Return Me
End Sub

'set state object
Sub SetStateMap(mapKey As String, mapValues As Map) As BANanoVue
	Dim opt As Map = CreateMap()
	opt.Put(mapKey, mapValues)
	SetState(opt)
	Return Me
End Sub

'set state list
Sub SetStateList(mapKey As String, mapValues As List) As BANanoVue
	Dim opt As Map = CreateMap()
	opt.Put(mapKey, mapValues)
	SetState(opt)
	Return Me
End Sub

Sub SetStateListValues(mapValues As List) As BANanoVue
	For Each lstValue As String In mapValues
		Dim opt As Map = CreateMap()
		opt.Put(lstValue, "")
		SetState(opt)
	Next 
	Return Me
End Sub

'set the state
Sub SetState(m As Map) As BANanoVue
	For Each k As String In m.Keys
		Dim v As Object = m.Get(k)
		k = k.tolowercase
		data.Put(k, v)
	Next
	Return Me	
End Sub

'return if state exists
Sub HasState(k As String) As Boolean
	Return data.ContainsKey(k)
End Sub

Sub GetStates(lst As List) As Map
	Dim sm As Map = CreateMap()
	For Each lstrec As String In lst
		lstrec = lstrec.tolowercase
		Dim state As Object = GetState(lstrec, Null)
		sm.Put(lstrec, state)
	Next
	Return sm
End Sub
'
''get ref
'Sub GetRef(k As String) As BANanoObject
'	k = k.tolowercase
'	If refs.ContainsKey(k) Then
'		Dim out As BANanoObject = refs.Get(k)
'		Return out
'	Else
'		Log("GetRef: First set the ref for " & k)
'		Return Null
'	End If
'End Sub


'get the state
Sub GetState(k As String, v As Object) As Object
	k = k.tolowercase
	If data.ContainsKey(k) Then
		Dim out As Object = data.GetDefault(k,v)
		Return out
	Else
		Log("GetState: First set the v-model for " & k)
		Return ""
	End If
End Sub
