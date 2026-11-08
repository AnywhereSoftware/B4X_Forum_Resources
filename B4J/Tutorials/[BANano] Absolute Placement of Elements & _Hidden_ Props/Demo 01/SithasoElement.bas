B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Private iClasses As List
	Private iStyles As Map
	Private iAttributes As Map
	Public mClasses As String
	Public mStyles As String
	Public mPaddingAXYTBLR As String
	Public mMarginAXYTBLR As String
	Public mAttributes As String
	Public allClass As String
	Public allStyle As String
	Public exAttrs As String
	Public exAttrs1 As String
	Private BANano As BANano			'ignore
End Sub

Public Sub Initialize
	iClasses.Initialize
	iStyles = CreateMap()
	iAttributes = CreateMap()
End Sub

Sub AddAttr(k As String, v As Object)
	iAttributes.put(k, v)
End Sub

Sub AddAttrMap(aMap As Map)
	For Each k As String In aMap.Keys
		Dim v As String = aMap.Get(k)
		AddAttr(k, v)
	Next
End Sub

Sub AddStyleMap(aMap As Map)
	For Each k As String In aMap.Keys
		Dim v As String = aMap.Get(k)
		AddStyle(k, v)
	Next
End Sub

Sub AddStyle(k As String, v As Object)
	iStyles.put(k, v)
End Sub

Sub AddClass(c As String)
	iClasses.Add(c)
End Sub

Sub BuildAttr
	Dim exClass As String = Join(" ", iClasses)
	Dim rawClass As List = GetRawClasses(mClasses)
	Dim exClass1 As String = Join(" ", rawClass)
	allClass = exClass & " " & exClass1
	allClass = allClass.trim
	If allClass <> "" Then iAttributes.put("class", allClass)
	Dim exStyle As String = BuildStyles(iStyles)
	Dim rawStyle As Map = GetRawStyles(mStyles)
	Dim rawStyle1 As Map = GetRawPadding(mPaddingAXYTBLR)
	Dim rawStyle2 As Map = GetRawMargins(mMarginAXYTBLR)
	Dim exStyle1 As String = BuildStyles(rawStyle)
	Dim exStyle2 As String = BuildStyles(rawStyle1)
	Dim exStyle3 As String = BuildStyles(rawStyle2)
	allStyle = exStyle & exStyle1 & exStyle2 & exStyle3
	allStyle = allStyle.trim
	allStyle = RemDelim(allStyle, ";")
	If allStyle <> "" Then iAttributes.put("style", allStyle)
	exAttrs = BuildAttributes(iAttributes)
	Dim rawAttrs As Map = GetRawAttributes(mAttributes)
	exAttrs1 = BuildAttributes(rawAttrs)
	exAttrs = exAttrs.trim
	exAttrs1 = exAttrs1.trim
End Sub

'join list to mv string
private Sub Join(delimiter As String, lst As List) As String
	If lst.Size = 0 Then Return ""
	Dim i As Int
	Dim sbx As StringBuilder
	Dim fld As String
	sbx.Initialize
	fld = lst.Get(0)
	sbx.Append(fld)
	For i = 1 To lst.size - 1
		Dim fld As String = lst.Get(i)
		sbx.Append(delimiter).Append(fld)
	Next
	Return sbx.ToString
End Sub

private Sub GetRawClasses(varStyles As String) As List
	varStyles = varStyles.Replace(" ", ";")
	varStyles = varStyles.Replace(CRLF, ";")
	Dim mxItems As List = StrParse(";", varStyles)
	mxItems = ListRemoveDuplicates(mxItems)
	Return mxItems
End Sub

private Sub BuildStyles(o As Map) As String
	Dim colStyle As StringBuilder
	colStyle.Initialize
	'
	For Each k As String In o.Keys
		Dim v As String = o.GetDefault(k, "")
		v = CStr(v)
		k = CStr(k)
		k = k.trim
		v = v.trim
		If k <> "" And v <> "" Then
			colStyle.Append($"${k}:${v};"$)
		End If
	Next
	Return colStyle.ToString
End Sub

private Sub CStr(o As Object) As String
	If BANano.isnull(o) Or BANano.IsUndefined(o) Then o = ""
	If o = "null" Then Return ""
	If o = "undefined" Then Return ""
	Return "" & o
End Sub

private Sub ListRemoveDuplicates(lst As List) As List
	Dim nd As Map = CreateMap()
	For Each k As String In lst
		nd.Put(k, k)
	Next
	Dim nl As List
	nl.Initialize
	For Each k As String In nd.Keys
		nl.Add(k)
	Next
	nl.Sort(True)
	Return nl
End Sub

'parse a string
private Sub StrParse(delim As String, inputString As String) As List
	Dim nl As List
	nl.Initialize
	Try
		inputString = CStr(inputString)
		If BANano.IsNull(inputString) Or BANano.IsUndefined(inputString) Then inputString = ""
		If inputString = "" Then Return nl
		If inputString.IndexOf(delim) = -1 Then
			nl.Add(inputString)
		Else
			nl = BANano.Split(delim,inputString)
		End If
		Return nl
	Catch
		'Log(LastException)
		Return nl
	End Try
End Sub

private Sub GetRawStyles(varStyles As String) As Map
	varStyles = varStyles.Replace(CRLF, ";")
	varStyles = varStyles.Replace(",", ";")
	varStyles = varStyles.ToLowerCase
	varStyles = varStyles.Replace("=", ":")
	Dim mxItems As List = StrParse(";", varStyles)
	mxItems = ListRemoveDuplicates(mxItems)
	Dim ms As Map = CreateMap()
	For Each mtx As String In mxItems
		mtx = mtx.Trim
		If mtx = "" Then Continue
		Dim k As String = MvField(mtx,1,":")
		Dim v As String = MvField(mtx,2,":")
		v = CStr(v)
		k = CStr(k)
		k = k.trim
		v = v.trim
		If k <> "" And v <> "" Then
			ms.put(k, v)
		End If
	Next
	Return ms
End Sub

private Sub GetRawPadding(varStyles As String) As Map
	Dim ms As Map = CreateMap()
	varStyles = varStyles.Replace(CRLF, ";")
	varStyles = varStyles.Replace(",", ";")
	varStyles = varStyles.ToLowerCase
	varStyles = varStyles.Replace("=", ":")
	Dim mxItems As List = StrParse(";", varStyles)
	mxItems = ListRemoveDuplicates(mxItems)
	For Each mtx As String In mxItems
		mtx = mtx.Replace("?", "")
		mtx = mtx.Trim
		If mtx = "" Then Continue
		Dim k As String = MvField(mtx,1,":")
		Dim v As String = MvField(mtx,2,":")
		v = CStr(v)
		k = CStr(k)
		k = k.trim
		v = v.trim
		If k <> "" And v <> "" Then
			Select Case k
				Case "a"
					ms.put("padding-top", v)
					ms.put("padding-left", v)
					ms.put("padding-bottom", v)
					ms.put("padding-right", v)
				Case "x"
					ms.put("padding-left", v)
					ms.put("padding-right", v)
				Case "y"
					ms.put("padding-top", v)
					ms.put("padding-bottom", v)
				Case "t"
					ms.put("padding-top", v)
				Case "b"
					ms.put("padding-bottom", v)
				Case "l"
					ms.put("padding-left", v)
				Case "r"
					ms.put("padding-right", v)
			End Select
		End If
	Next
	Return ms
End Sub

private Sub GetRawMargins(varStyles As String) As Map
	Dim ms As Map = CreateMap()
	varStyles = varStyles.Replace(CRLF, ";")
	varStyles = varStyles.Replace(",", ";")
	varStyles = varStyles.Replace("=", ":")
	Dim mxItems As List = StrParse(";", varStyles)
	mxItems = ListRemoveDuplicates(mxItems)
	For Each mtx As String In mxItems
		mtx = mtx.Replace("?", "")
		mtx = mtx.Trim
		If mtx = "" Then Continue
		Dim k As String = MvField(mtx,1,":")
		Dim v As String = MvField(mtx,2,":")
		v = CStr(v)
		k = CStr(k)
		k = k.trim
		v = v.trim
		If k <> "" And v <> "" Then
			Select Case k
				Case "a"
					ms.put("margin-top", v)
					ms.put("margin-left", v)
					ms.put("margin-bottom", v)
					ms.put("margin-right", v)
				Case "x"
					ms.put("margin-left", v)
					ms.put("margin-right", v)
				Case "y"
					ms.put("margin-top", v)
					ms.put("margin-bottom", v)
				Case "t"
					ms.put("margin-top", v)
				Case "b"
					ms.put("margin-bottom", v)
				Case "l"
					ms.put("margin-left", v)
				Case "r"
					ms.put("margin-right", v)
			End Select
		End If
	Next
	Return ms
End Sub

private Sub RemDelim(sValue As String, Delim As String) As String
	Dim sw As Boolean = sValue.EndsWith(Delim)
	If sw Then
		Dim lDelim As Int = Delim.Length
		Dim nValue As String = sValue
		sw = nValue.EndsWith(Delim)
		If sw Then
			nValue = nValue.SubString2(0, nValue.Length-lDelim)
		End If
		Return nValue
	Else
		Return sValue
	End If
End Sub

private Sub BuildAttributes(o As Map) As String
	Dim colStyle As StringBuilder
	colStyle.Initialize
	'
	For Each k As String In o.Keys
		Dim v As String = o.GetDefault(k, "")
		v = CStr(v)
		k = CStr(k)
		k = k.trim
		v = v.trim
		If k <> "" And v <> "" Then
			colStyle.Append($"${k}="${v}" "$)
		End If
	Next
	Return colStyle.ToString
End Sub

private Sub GetRawAttributes(varStyles As String) As Map
	varStyles = varStyles.Replace(CRLF, ";")
	varStyles = varStyles.Replace(" ", ";")
	varStyles = varStyles.Replace("=", ":")
	Dim mxItems As List = StrParse(";", varStyles)
	mxItems = ListRemoveDuplicates(mxItems)
	Dim ms As Map = CreateMap()
	For Each mtx As String In mxItems
		mtx = mtx.Trim
		If mtx = "" Then Continue
		Dim k As String = MvField(mtx,1,":")
		Dim v As String = MvField(mtx,2,":")
		v = CStr(v)
		k = CStr(k)
		k = k.trim
		v = v.trim
		If k <> "" And v <> "" Then
			ms.put(k, v)
		End If
	Next
	Return ms
End Sub

'mvfield sub
private Sub MvField(sValue As String, iPosition As Int, Delimiter As String) As String
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