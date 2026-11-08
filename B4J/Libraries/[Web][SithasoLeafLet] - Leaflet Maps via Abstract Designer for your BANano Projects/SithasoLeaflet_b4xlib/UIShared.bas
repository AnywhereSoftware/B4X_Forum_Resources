B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Private BANano As BANano 'ignore
	Private mSelf As Object
	Private iAttributes As Map
	Private iStyles As Map
	Private iClasses As List
	Public ExcludeTextColor As Boolean = False
	Public ExcludeBackgroundColor As Boolean = False
	Public ExcludeVisible As Boolean = False
	Public ExcludeEnabled As Boolean = False
	Public ExcludePosition As Boolean = False
End Sub

''add a unique item to a list
'Sub ListAddUnique(lst As List, item As String)
'	item = item.Trim
'	If item = "" Then Return
'	Dim itemPos As Int = lst.IndexOf(item)
'	If itemPos = -1 Then lst.Add(item)
'End Sub
'
'Sub PlayAudio(af As String)
'	Try
'		Dim Audio As BANanoObject
'		Audio.Initialize2("Audio", Array(af))
'		Audio.RunMethod("play", Null)
'	Catch
'		
'	End Try				'ignore
'End Sub
'
'Sub AddCode(cd As StringBuilder, cl As String)
'	cl = cl.Replace("~","$")
'	cd.Append(cl).Append(CRLF)
'End Sub
'
''search for a map object having a particular property
'Sub SearchList(lst As List, key As String, value As String) As Int
'	Dim colTot As Int = lst.Size - 1
'	Dim colCnt As Int = 0
'	For colCnt = 0 To colTot
'		Dim col As Map = lst.Get(colCnt)
'		Dim colIDx As String = col.Get(key)
'		If colIDx.EqualsIgnoreCase(value) Then Return colCnt
'	Next
'	Return -1
'End Sub

'join list to mv string
Sub JoinQuote(delimiter As String, lst As List) As String
	If lst.Size = 0 Then Return ""
	Dim i As Int
	Dim sbx As StringBuilder
	Dim fld As String
	sbx.Initialize
	fld = lst.Get(0)
	sbx.Append(QUOTE).Append(fld).Append(QUOTE)
	For i = 1 To lst.size - 1
		Dim fld As String = lst.Get(i)
		sbx.Append(delimiter).Append(QUOTE).Append(fld).Append(QUOTE)
	Next
	Dim sout As String = sbx.ToString
	sbx.Initialize
	Return sout
End Sub

Sub CopyMapByKeys(source As Map, keys As List) As Map
	Dim nm As Map = CreateMap()
	For Each k As String In keys
		Dim v As Object = source.Get(k)
		nm.Put(k, v)
	Next
	Return nm
End Sub

'extract first number of words from a string
Sub ExtractFirstWords(input As String, numwords As Int) As String			'ignoredeadcode
	' Split the string into an array of words
	Dim words As List = StrParse(" ", input)
	
	' Check if the input has fewer than number of words
	If words.size <= numwords Then
		Return input.Trim
	End If
    
	' Join the first 5 words and return the result
	Dim result As StringBuilder
	result.Initialize
	For i = 0 To (numwords - 1)
		result.Append(words.Get(i))
		result.Append(" ")
	Next
	' Return the trimmed result
	Return result.ToString.trim
End Sub

'double
Sub CDbl(o As String) As Double
	o = Val(o)
	Dim out As Double = NumberFormat2Fix(o,0,2,2,False)
	Dim nvalue As String = CStr(out)
	nvalue = nvalue.replace(",", ".")
	nvalue = Val(nvalue)
	Dim nout As Double = BANano.parseFloat(nvalue)
	Return nout
End Sub

'https://www.b4x.com/android/forum/threads/banano-numberformat2-gives-a-different-behavior-in-banano-than-in-b4j.134409/#post-850371
private Sub NumberFormat2Fix(number As Double, minimumIntegers As Int, maximumFractions As Int, minimumFractions As Int, groupingUsed As Boolean) As Double
	Return BANano.RunJavascriptMethod("NumberFormat2", Array(number, minimumIntegers, maximumFractions, minimumFractions, groupingUsed))
End Sub

'get the length of the string
Sub Len(Text As String) As Int
	Return Text.Length
End Sub

Sub PadRight(Value As String, MaxLen As Int, PadChar As String) As String
	Value = CStr(Value)
	Dim intOrdNoLen As Int = Len(Value)
	Dim i As Int
	For i = 1 To (MaxLen - intOrdNoLen) Step 1
		Value = PadChar & Value
	Next
	Return Value
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(self As Object)
	mSelf = self
	iAttributes.Initialize
	iStyles.Initialize
	iClasses.Initialize
	ExcludeTextColor = False
	ExcludeBackgroundColor = False
	ExcludeVisible = False
	ExcludeEnabled = False
	ExcludePosition = False
End Sub

Sub Focus(mElement As BANanoElement)
	Try
		If mElement = Null Then Return
		mElement.RunMethod("focus", Null)
	Catch
		
	End Try				'ignore
End Sub

Sub FocusByID(sID As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		mElement.RunMethod("focus", Null)
	Catch
		
	End Try				'ignore
End Sub

Sub SetReadOnly(mElement As BANanoElement, b As Boolean)
	Try
		If mElement = Null Then Return
		If b Then
			mElement.SetAttr("readonly", "readonly")
		Else
			mElement.RemoveAttr("readonly")
		End If
	Catch
		
	End Try				'ignore
End Sub

Sub SetNoArrows(mElement As BANanoElement)
	Try
		If mElement = Null Then Return
		AddClass(mElement, "[appearance:textfield] [&::-webkit-outer-spin-button]:appearance-none [&::-webkit-inner-spin-button]:appearance-none")
	Catch
		
	End Try				'ignore
End Sub

Sub GetElementByID(sID As String) As BANanoElement
	sID = CleanID(sID)
	Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
	If mElement = Null Then Return Null
	Return mElement
End Sub

Sub GetElementObjectByID(sID As String) As BANanoObject
	sID = CleanID(sID)
	Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
	If mElement = Null Then Return Null
	Return mElement.ToObject
End Sub

'scroll into view
Sub EnsureVisible(sID As String)
	Try
		sID = CleanID(sID)
		If BANano.Exists($"#${sID}"$) = False Then Return
		Dim opt As Map = CreateMap()
		opt.Put("behavior", "smooth")
		opt.Put("block", "nearest")
		opt.Put("inline", "nearest")
		BANano.GetElement($"#${sID}"$).RunMethod("scrollIntoView", opt)
	Catch
		
	End Try				'ignore
End Sub

' internal use
public Sub Trigger(mElement As BANanoElement, event As String, params() As String)
	Try
		If mElement = Null Then Return
		mElement.Trigger(event, params)
	Catch
		
	End Try				'ignore
End Sub

Sub RemoveElementByID(sID As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		mElement.Remove
		mElement = Null
	Catch
		
	End Try				'ignore
End Sub

' internal use
public Sub SetProps(props As Map)
	Dim sParentID As String = props.GetDefault("ParentID", "")
	sParentID = CleanID(sParentID)
	Dim sMarginAXYTBLR As String = props.GetDefault("MarginAXYTBLR", "a=?; x=?; y=?; t=?; b=?; l=?; r=?")
	sMarginAXYTBLR = CStr(sMarginAXYTBLR)
	Dim sPaddingAXYTBLR As String = props.GetDefault("PaddingAXYTBLR", "a=?; x=?; y=?; t=?; b=?; l=?; r=?")
	sPaddingAXYTBLR = CStr(sPaddingAXYTBLR)
	Dim sRawClasses As String = props.GetDefault("RawClasses", "")
	sRawClasses = CStr(sRawClasses)
	Dim sRawStyles As String = props.GetDefault("RawStyles", "")
	sRawStyles = CStr(sRawStyles)
	Dim sRawAttributes As String = props.GetDefault("RawAttributes", "")
	sRawAttributes = CStr(sRawAttributes)
	Dim bVisible As Boolean = props.GetDefault("Visible", True)
	bVisible = CBool(bVisible)
	Dim bEnabled As Boolean = props.GetDefault("Enabled", True)
	bEnabled = CBool(bEnabled)
	Dim sPositionStyle As String = props.GetDefault("PositionStyle", "")
	sPositionStyle = CStr(sPositionStyle)
	Dim sPosition As String = props.GetDefault("Position", "t=?; b=?; r=?; l=?")
	sPosition = CStr(sPosition)
	Dim sTextColor As String = props.GetDefault("TextColor", "")
	sTextColor = CStr(sTextColor)
	Dim sText As String = props.GetDefault("Text", "")
	sText = CStr(sText)
	Dim sBackgroundColor As String = props.GetDefault("BackgroundColor", "")
	sBackgroundColor = CStr(sBackgroundColor)
	Dim sRawBorderColor As String = props.GetDefault("RawBorderColor", "a=?; t=?; r=?; b=?; l=?; tl=?; tr=?; bl=?; br=?; x=?; y=?")
	sRawBorderColor = CStr(sRawBorderColor)
	Dim sRawBorderStyle As String = props.GetDefault("RawBorderStyle", "a=?; t=?; r=?; b=?; l=?; tl=?; tr=?; bl=?; br=?; x=?; y=?")
	sRawBorderStyle = CStr(sRawBorderStyle)
	Dim sRawBorderWidth As String = props.GetDefault("RawBorderWidth", "a=?; t=?; r=?; b=?; l=?; tl=?; tr=?; bl=?; br=?; x=?; y=?")
	sRawBorderWidth = CStr(sRawBorderWidth)
	Dim sRawBorderRadius As String = props.GetDefault("RawBorderRadius", "a=?; t=?; r=?; b=?; l=?; tl=?; tr=?; bl=?; br=?; x=?; y=?")
	sRawBorderRadius = CStr(sRawBorderRadius)
	'
	BANano.SetP(mSelf, "sParentID", sParentID)
	BANano.SetP(mSelf, "sMarginAXYTBLR", sMarginAXYTBLR)
	BANano.SetP(mSelf, "sPaddingAXYTBLR", sPaddingAXYTBLR)
	BANano.SetP(mSelf, "sRawClasses", sRawClasses)
	BANano.SetP(mSelf, "sRawStyles", sRawStyles)
	BANano.SetP(mSelf, "sRawAttributes", sRawAttributes)
	BANano.SetP(mSelf, "bVisible", bVisible)
	BANano.SetP(mSelf, "bEnabled", bEnabled)
	BANano.SetP(mSelf, "sPositionStyle", sPositionStyle)
	BANano.SetP(mSelf, "sPosition", sPosition)
	BANano.SetP(mSelf, "sTextColor", sTextColor)
	BANano.SetP(mSelf, "sText", sText)
	BANano.SetP(mSelf, "sBackgroundColor", sBackgroundColor)
	BANano.SetP(mSelf, "sRawBorderColor", sRawBorderColor)
	BANano.SetP(mSelf, "sRawBorderStyle", sRawBorderStyle)
	BANano.SetP(mSelf, "sRawBorderWidth", sRawBorderWidth)
	BANano.SetP(mSelf, "sRawBorderRadius", sRawBorderRadius)
End Sub

Private Sub GetVisibleDT() As Boolean
	Return BANano.GetP(mSelf, "bVisible")
End Sub

Private Sub GetEnabledDT() As Boolean
	Return BANano.GetP(mSelf, "bEnabled")
End Sub

public Sub BuildExAttributes() As String
	If ExcludeEnabled = False Then
		Dim bEnabled As Boolean = CBool(GetEnabledDT)
		If bEnabled = False Then AddAttrDT("disabled", "disabled")
	End If
	Dim sRawAttributes As String = GetAttributes
	Dim attrM As Map = GetKeyValues(sRawAttributes, False)
	attrM = BANano.DeepMerge(attrM, iAttributes)
	Dim xStyle As String = BuildAttributes(attrM)
	Return xStyle
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
		If k <> "" Then
			colStyle.Append($"${k}="${v}" "$)
		End If
	Next
	Dim sout As String = colStyle.tostring
	colStyle.Initialize
	Return sout
End Sub

' internal use
public Sub BuildExStyle() As String
	Dim styleList As Map
	styleList.Initialize
	If ExcludePosition = False Then
		Dim sPositions As String = GetPosition
		Dim sPositionsM As Map = GetPositionMap(sPositions)
		Dim sPositionStyle As String = GetPositionStyle
		If sPositionStyle = "none" Then sPositionStyle = ""
		If sPositionStyle <> "" Then
			styleList.Put("position", sPositionStyle)
		End If
		styleList = BANano.DeepMerge(styleList, sPositionsM)
	End If
	'
	Dim sRawStyles As String = GetStyles
	Dim styleM As Map = GetKeyValues(sRawStyles, True)
	'
	Dim sbc As String = GetBorderColor
	Dim sbcm As Map = GetBordersMap("color", sbc)
	'
	Dim sbs As String = GetBorderStyle
	Dim sbsm As Map = GetBordersMap("style", sbs)
	'
	Dim sbw As String = GetBorderWidth
	Dim sbwm As Map = GetBordersMap("width", sbw)
	
	Dim sbr As String = GetBorderRadius
	Dim sbrm As Map = GetBordersMap("radius", sbr)
	
	styleList = BANano.DeepMerge(styleList, styleM)
	styleList = BANano.DeepMerge(styleList, iStyles)
	styleList = BANano.DeepMerge(styleList, sbcm)
	styleList = BANano.DeepMerge(styleList, sbsm)
	styleList = BANano.DeepMerge(styleList, sbwm)
	styleList = BANano.DeepMerge(styleList, sbrm)
	
	Dim xStyle As String = BuildStyles(styleList)
	Return xStyle
End Sub

'prefix a color
Sub FixColor(prefix As String, v As String) As String
	prefix = CStr(prefix)
	v = CStr(v)
	v = v.ToLowerCase
	If prefix = "" And v = "" Then Return ""
	Dim nc As String = v
	v = nc
	Dim res As String = ""
	If v.StartsWith("#") Then
		res = $"${prefix}-[${v}]"$
		If prefix = "btn" Then
			res = res.Replace("btn-", "bg-")
		End If
		If prefix = "badge" Then
			res = res.Replace("badge-", "bg-")
		End If
	Else
		res = $"${prefix}-${v}"$
	End If
	If res.EndsWith("-") Then res = ""
	Return res
End Sub

public Sub BuildExClass() As String
	Dim classList As List
	classList.Initialize
	If ExcludeTextColor = False Then
		Dim xTextColor As String = GetTextColor
		Dim tc As String = FixColor("text", xTextColor)
		If tc <> "" Then AddClassDT(tc)
	End If
	'
	If ExcludeBackgroundColor = False Then
		Dim xBgColor As String = GetBackgroundColor
		Dim bc As String = FixColor("bg", xBgColor)
		If bc <> "" Then AddClassDT(bc)
	End If
	'
	If ExcludeVisible = False Then
		Dim bVisible As Boolean = CBool(GetVisibleDT)
		If bVisible = False Then AddClassDT("hidden")
	End If
	'
	Dim sClasses As String = GetClasses
	Dim cl As List = GetClassList(sClasses)
	classList = BANano.DeepMerge(classList, cl)
	
	Dim sMarginAXYTBLR As String = GetMarginAXYTBLR
	sMarginAXYTBLR = CStr(sMarginAXYTBLR)
	Dim marginsM As Map = GetMarginPaddingMap(sMarginAXYTBLR)
	Dim margins As List = MarginPaddingToList("m", marginsM)
	classList = BANano.DeepMerge(classList, margins)
	'
	Dim sPaddingAXYTBLR As String = GetPaddingAXYTBLR
	sPaddingAXYTBLR = CStr(sPaddingAXYTBLR)
	Dim paddingM As Map = GetMarginPaddingMap(sPaddingAXYTBLR)
	Dim padding As List = MarginPaddingToList("p", paddingM)
	classList = BANano.DeepMerge(classList, padding)
	classList = BANano.DeepMerge(classList, iClasses)
	
	Dim xStyle As String = Join(" ", classList)
	Return xStyle
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
	Dim sout As String = colStyle.ToString
	colStyle.Initialize
	Return sout
End Sub

public Sub SetParentID(s As String)
	s = CleanID(s)
	BANano.SetP(mSelf, "sParentID", s)
End Sub

public Sub GetParentID() As String
	Return BANano.GetP(mSelf, "sParentID")
End Sub

public Sub SetBorderRadius(mElement As BANanoElement, s As String)
	Try
		BANano.SetP(mSelf, "sRawBorderRadius", s)
		If mElement = Null Then Return
		Dim bb As Map = GetBordersMap("radius", s)
		AddStyleMap(mElement, bb)
	Catch
		
	End Try				'ignore
End Sub

public Sub GetBorderRadius() As String
	Return BANano.GetP(mSelf, "sRawBorderRadius")
End Sub

public Sub SetBorderWidth(mElement As BANanoElement, s As String)
	Try
		BANano.SetP(mSelf, "sRawBorderWidth", s)
		If mElement = Null Then Return
		Dim bb As Map = GetBordersMap("width", s)
		AddStyleMap(mElement, bb)
	Catch
		
	End Try				'ignore
End Sub

public Sub GetBorderWidth() As String
	Return BANano.GetP(mSelf, "sRawBorderWidth")
End Sub

public Sub SetBorderStyle(mElement As BANanoElement, s As String)
	Try
		BANano.SetP(mSelf, "sRawBorderStyle", s)
		If mElement = Null Then Return
		Dim bb As Map = GetBordersMap("style", s)
		AddStyleMap(mElement, bb)
	Catch
		
	End Try				'ignore
End Sub

public Sub GetBorderStyle() As String
	Return BANano.GetP(mSelf, "sRawBorderStyle")
End Sub

public Sub SetBorderColorStyle(mElement As BANanoElement, s As String)
	Try
		BANano.SetP(mSelf, "sRawBorderColor", s)
		If mElement = Null Then Return
		Dim bb As Map = GetBordersMap("color", s)
		AddStyleMap(mElement, bb)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetBorderColor(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		Dim ncolor As String = FixColor("border", s)
		UpdateClass(mElement, "bordercolor", ncolor)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetBorderColorByID(sID As String, s As String)
	Try
		sID = CStr(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		Dim ncolor As String = FixColor("border", s)
		UpdateClass(mElement, "bordercolor", ncolor)
	Catch
		
	End Try				'ignore
End Sub


public Sub GetBorderColor() As String
	Return BANano.GetP(mSelf, "sRawBorderColor")
End Sub

public Sub SetSize(mElement As BANanoElement, sizeName As String, prefix As String, s As String)
	Try
		If mElement = Null Then Return
		Dim s1 As String = FixSize(prefix, s)
		UpdateClass(mElement, sizeName, s1)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetSizeByID(sID As String, sizeName As String, prefix As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetSize(mElement, sizeName, prefix, s)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetColor(mElement As BANanoElement, colorName As String, prefix As String, s As String)
	Try
		If mElement = Null Then Return
		Dim s1 As String = FixColor(prefix, s)
		UpdateClass(mElement, colorName, s1)
	Catch
		
	End Try				'ignore
End Sub

public Sub GetColor() As String
	Return BANano.GetP(mSelf, "sColor")
End Sub

public Sub SetColorByID(sID As String, colorName As String, prefix As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetColor(mElement, colorName, prefix, s)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetColorStyle(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		Dim m As Map = CreateMap()
		m.Put("color", s)
		mElement.SetStyle(BANano.ToJson(m))
	Catch
		
	End Try				'ignore
End Sub


public Sub SetColorStyleByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetColorStyle(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetBackgroundColorStyle(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		Dim m As Map = CreateMap()
		m.Put("background-color", s)
		mElement.SetStyle(BANano.ToJson(m))
	Catch
		
	End Try				'ignore
End Sub

public Sub SetBackgroundColorStyleByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetBackgroundColorStyle(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetBackgroundColor(mElement As BANanoElement, s As String)		'ignoredeadcode
	Try
		BANano.SetP(mSelf, "sBackgroundColor", s)
		If mElement = Null Then Return
		Dim s1 As String = FixColor("bg", s)
		UpdateClass(mElement, "color", s1)
	Catch
		
	End Try				'ignore
End Sub

public Sub RemoveBackgroundColor(mElement As BANanoElement)
	Try
		If mElement = Null Then Return
		Dim lastColor As String = mElement.GetData("color")
		lastColor = CStr(lastColor)
		If lastColor <> "" Then mElement.RemoveClass(lastColor)
	Catch
		
	End Try				'ignore
End Sub

Sub RemoveBackgroundColorByID(sID As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		Dim lastColor As String = mElement.GetData("color")
		lastColor = CStr(lastColor)
		If lastColor <> "" Then
			mElement.RemoveClass(lastColor)
			mElement.RemoveAttr("data-color")
		End If
	Catch
		
	End Try				'ignore
End Sub

public Sub GetBackgroundColor() As String
	Return BANano.GetP(mSelf, "sBackgroundColor")
End Sub

public Sub SetTextColor(mElement As BANanoElement, s As String)
	Try
		BANano.SetP(mSelf, "sTextColor", s)
		If mElement = Null Then Return
		Dim s1 As String = FixColor("text", s)
		UpdateClass(mElement, "textcolor", s1)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetCheckedColor(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		Dim s1 As String = FixColor("checked:bg", s)
		Dim s2 As String = FixColor("checked:border", s)
		UpdateClass(mElement, "checkedbgcolor", s1)
		UpdateClass(mElement, "checkedborder", s2)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetCheckedColorByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		SetCheckedColor(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetCheckedTextColor(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		Dim s1 As String = FixColor("checked:text", s)
		UpdateClass(mElement, "checkedtextcolor", s1)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetCheckedTextColorByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		SetCheckedTextColor(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

public Sub UpdateClassByID(sID As String, k As String, v As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		UpdateClass(mElement, k, v)
	Catch
		
	End Try				'ignore
End Sub

public Sub RemoveClassByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		RemoveClass(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetBackgroundColorByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetBackgroundColor(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetTextColorByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetTextColor(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

private Sub SetIconSizeStyle(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		If s = "" Then s = "md"
		Select Case s
			Case "xs"
				S = "16px"   '"24px"
			Case "sm"
				S = "24px"  ' "32px"
			Case "md"
				S = "32px" ' "40px"
			Case "lg"
				S =  "40px" ' "48px"
			Case "xl"
				S = "48px" ' "56px"
		End Select
		SetStyle(mElement, "font-size", s)
		SetStyle(mElement, "font-size", s)
	Catch
		
	End Try				'ignore
End Sub

'set Image Size
Sub SetButtonImageSize(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		If s = "" Then s = "md"
		Select Case s
			Case "xs"
				S = "16px"   '"24px"
			Case "sm"
				S = "24px"  ' "32px"
			Case "md"
				S = "32px" ' "40px"
			Case "lg"
				S =  "40px" ' "48px"
			Case "xl"
				S = "48px" ' "56px"
		End Select
		SetSize(mElement, "width", "w", s)
		SetSize(mElement, "height", "h", s)
	Catch
		
	End Try				'ignore
End Sub

'get icon size insize button
Sub SetButtonImageSizeByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetButtonImageSize(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

private Sub SetIconSizeStyleByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetIconSizeStyle(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetTextSizeByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetTextSize(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetMaskByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetMask(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetRoundedByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetRounded(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetRoundedBoxByID(sID As String, b As Boolean)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetRoundedBox(mElement, b)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetRingColorByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetRingColor(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetTextByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetText(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetRingColor(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		Dim xcolor As String = FixColor("ring", s)
		UpdateClass(mElement, "ringcolor", xcolor)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetMask(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		Dim xmask As String = FixMask(s)
		UpdateClass(mElement, "mask", xmask)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetRounded(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		Dim xmask As String = FixRounded(s)
		UpdateClass(mElement, "rounded", xmask)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetRoundedBox(mElement As BANanoElement, b As Boolean)
	Try
		If mElement = Null Then Return
		If b = True Then
			AddClass(mElement, "rounded-box")
		Else
			RemoveClass(mElement, "rounded-box")
		End If
	Catch
		
	End Try				'ignore
End Sub

public Sub SetShadow(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		Dim xmask As String = FixShadow(s)
		UpdateClass(mElement, "shadow", xmask)
	Catch
		
	End Try				'ignore
End Sub

Sub SetShadowByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetShadow(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetTextSize(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		Dim s1 As String = FixColor("text", s)
		UpdateClass(mElement, "textsize", s1)
	Catch
		
	End Try				'ignore
End Sub

public Sub GetTextColor() As String
	Return BANano.GetP(mSelf, "sTextColor")
End Sub

Sub AddVisibleDT(b As Boolean)
	If b = False Then AddClassDT("hidden")
End Sub

Sub AddClassDT(clsName As String)
	iClasses.Add(clsName)
End Sub

Sub UpdateClassDT(className As String, clsName As String)
	iClasses.Add(clsName)
	iAttributes.Put($"data-${className}"$, clsName)
End Sub

'add a class to an element
Sub AddClass(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		s = CStr(s)
		s = s.Replace(" ", ";")
		s = s.Replace(CRLF, ";")
		s = s.Replace("<br/>", ";")
		s = s.trim
		If s = "" Then Return
		Dim lst As List = StrParseTrim(";", s)
		For Each c As String In lst
			If c = "" Then Continue
			mElement.AddClass(c)
		Next
	Catch
		
	End Try				'ignore
End Sub

Sub AddClassList(mElement As BANanoElement, lst As List)
	Try
		If mElement = Null Then Return
		Dim sList As String = Join(";", lst)
		AddClass(mElement, sList)
	Catch
		
	End Try				'ignore
End Sub

Sub AddStyleMap(mElement As BANanoElement, ms As Map)
	Try
		If mElement = Null Then Return
		If ms.Size = 0 Then Return
		Dim svalue As String = BANano.ToJson(ms)
		mElement.SetStyle(svalue)
	Catch
		
	End Try				'ignore
End Sub

Sub ClearByID(sID As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		mElement.empty
	Catch
		
	End Try				'ignore
End Sub

Sub Clear(mElement As BANanoElement)
	Try
		If mElement = Null Then Return
		mElement.empty
	Catch
		
	End Try				'ignore
End Sub

Sub Append(mElement As BANanoElement, sContent As String)
	Try
		If mElement = Null Then Return
		mElement.Append(sContent)
	Catch
		
	End Try				'ignore
End Sub

'append content to the specified element
Sub AppendByID(sID As String, sContent As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		mElement.Append(sContent)
	Catch
		
	End Try				'ignore
End Sub

Sub SetHTML(mElement As BANanoElement, sContent As String)
	Try
		BANano.SetP(mSelf, "sHTML", sContent)
		If mElement = Null Then Return
		mElement.SetHTML(BANano.SF(sContent))
	Catch
		
	End Try				'ignore
End Sub

Sub SetHTMLByID(sID As String, sContent As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		mElement.SetHTML(BANano.SF(sContent))
	Catch
		
	End Try				'ignore
End Sub

public Sub GetHTML() As String
	Return BANano.GetP(mSelf, "sHTML")
End Sub

'set attributes that are delimited by :;
public Sub SetAttributes(mElement As BANanoElement, s As String)
	Try
		BANano.SetP(mSelf, "sRawAttributes", s)
		If mElement = Null Then Return
		Dim mm As Map = GetKeyValues(s, False)
		For Each k As String In mm.Keys
			Dim v As String = mm.Get(k)
			Select Case k
				Case "class"
					AddClass(mElement, v)
				Case "style"
					SetStyles(mElement, v)
				Case Else
					SetAttr(mElement, k, v)
			End Select
		Next
	Catch
		
	End Try				'ignore
End Sub

public Sub SetAttributesByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		Dim mm As Map = GetKeyValues(s, False)
		For Each k As String In mm.Keys
			Dim v As String = mm.Get(k)
			SetAttr(mElement, k, v)
		Next
	Catch
		
	End Try				'ignore
End Sub

public Sub GetAttributes() As String
	Return BANano.GetP(mSelf, "sRawAttributes")
End Sub

'get positions delimited by :;
private Sub GetPositionMap(varStyles As String) As Map
	Dim ms As Map = CreateMap()
	Dim oldm As Map = GetKeyValues(varStyles, False)
	For Each k As String In oldm.Keys
		Dim v As String = oldm.Get(k)
		Select Case k
			Case "t"
				ms.Put("top", v)
			Case "b"
				ms.Put("bottom", v)
			Case "r"
				ms.Put("right", v)
			Case "l"
				ms.Put("left", v)
			Case Else
				ms.Put(k, v)
		End Select
	Next
	Return ms
End Sub

Sub SetPositionByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetPosition(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

public Sub SetPosition(mElement As BANanoElement, s As String)
	Try
		BANano.SetP(mSelf, "sPosition", s)
		If mElement = Null Then Return
		Dim stylesx As Map = GetPositionMap(s)
		AddStyleMap(mElement, stylesx)
	Catch
		
	End Try				'ignore
End Sub

public Sub GetPosition() As String
	Return BANano.GetP(mSelf, "sPosition")
End Sub


public Sub SetPaddingAXYTBLR(mElement As BANanoElement, s As String)
	Try
		BANano.SetP(mSelf, "sPaddingAXYTBLR", s)
		If mElement = Null Then Return
		Dim mm As Map = GetMarginPaddingMap(s)
		Dim classList As List = MarginPaddingToList("p", mm)
		AddClassList(mElement, classList)
	Catch
		
	End Try				'ignore
End Sub

Sub SetPaddingAXYTBLRByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetPaddingAXYTBLR(mElement, s)
	Catch
		
	End Try				'ignore
End Sub


' internal use
public Sub GetPaddingAXYTBLR() As String
	Return BANano.GetP(mSelf, "sPaddingAXYTBLR")
End Sub

public Sub SetMarginAXYTBLR(mElement As BANanoElement, s As String)
	Try
		BANano.SetP(mSelf, "sMarginAXYTBLR", s)
		If mElement = Null Then Return
		Dim mm As Map = GetMarginPaddingMap(s)
		Dim classList As List = MarginPaddingToList("m", mm)
		AddClassList(mElement, classList)
	Catch
		
	End Try				'ignore
End Sub

Sub SetMarginAXYTBLRByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetMarginAXYTBLR(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

public Sub GetMarginAXYTBLR() As String
	Return BANano.GetP(mSelf, "sMarginAXYTBLR")
End Sub

public Sub SetClasses(mElement As BANanoElement, s As String)
	Try
		BANano.SetP(mSelf, "sRawClasses", s)
		If mElement = Null Then Return
		AddClass(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetClassesByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		AddClass(mElement, s)
	Catch
		
	End Try				'ignore
End Sub


public Sub GetClasses() As String
	Return BANano.GetP(mSelf, "sRawClasses")
End Sub

public Sub SetPositionStyle(mElement As BANanoElement, s As String)
	Try
		BANano.SetP(mSelf, "sPositionStyle", s)
		If mElement = Null Then Return
		AddStyle(mElement, "position", s)
	Catch
		
	End Try				'ignore
End Sub

public Sub GetPositionStyle() As String
	Return BANano.GetP(mSelf, "sPositionStyle")
End Sub

public Sub SetStyles(mElement As BANanoElement, s As String)
	Try
		BANano.SetP(mSelf, "sRawStyles", s)
		If mElement = Null Then Return
		Dim ms As Map = GetKeyValues(s, True)
		If ms.Size = 0 Then Return
		mElement.SetStyle(BANano.ToJson(ms))
	Catch
		
	End Try				'ignore
End Sub

Sub SetStylesByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		Dim ms As Map = GetKeyValues(s, True)
		If ms.Size = 0 Then Return
		mElement.SetStyle(BANano.ToJson(ms))
	Catch
		
	End Try				'ignore
End Sub


public Sub GetStyles() As String
	Return BANano.GetP(mSelf, "sRawStyles")
End Sub

public Sub SetVisible(mElement As BANanoElement, bVisible As Boolean)
	Try
		BANano.SetP(mSelf, "bVisible", bVisible)
		If mElement = Null Then Return
		If bVisible Then
			RemoveClass(mElement, "hidden")
		Else
			AddClass(mElement, "hidden")
		End If
	Catch
		
	End Try				'ignore
End Sub

Sub SetCursorPointer(mElement As BANanoElement)
	Try
		If mElement = Null Then Return
		AddClass(mElement, "cursor-pointer")
	Catch
		
	End Try				'ignore
End Sub

Sub SetCursorPointerByID(sID As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetCursorPointer(mElement)
	Catch
		
	End Try				'ignore
End Sub

Sub Show(sID As String)
	SetVisibleByID(sID, True)
End Sub

Sub Hide(sID As String)
	SetVisibleByID(sID, False)
End Sub

Sub SetVisibleByID(sID As String, b As Boolean)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetVisible(mElement, b)
	Catch
		
	End Try				'ignore
End Sub

Sub OnEventMethod(mElement As BANanoElement, event As String, Module As Object, MethodName As String)		'ignore
	Try
		If mElement = Null Then Return
		Dim e As BANanoEvent
		Dim cb As BANanoObject = BANano.CallBack(Module, MethodName, Array(e))
		mElement.RunMethod("on", Array(event, cb))
	Catch
		
	End Try				'ignore
End Sub

Sub OnEventMethodByID(sID As String, event As String, CallBack As Object, MethodName As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		OnEventMethod(mElement, event, CallBack, MethodName)
	Catch
		
	End Try				'ignore
End Sub

Sub OnEventByID(sID As String, event As String, CallBack As Object, MethodName As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		OnEvent(mElement, event, CallBack, MethodName)
	Catch
		
	End Try				'ignore
End Sub

'add event
Sub OnEvent(mElement As BANanoElement, event As String, CallBack As Object, MethodName As String)
	Try
		If mElement = Null Then Return
		event = event.Replace(":","")
		event = event.Replace(".","")
		event = event.Replace("-","")
		If SubExists(CallBack, MethodName) Then
			mElement.Off(event)
			mElement.On(event, CallBack, MethodName)
		End If
	Catch
		
	End Try				'ignore
End Sub

' internal use
public Sub GetVisible(mElement As BANanoElement) As Boolean
	If mElement = Null Then Return False
	Dim mVisible As Boolean = Not(mElement.HasClass("hidden"))
	BANano.SetP(mSelf, "bVisible", mVisible)
	Return mVisible
End Sub

' internal use
public Sub SetEnabled(mElement As BANanoElement, bEnabled As Boolean)
	Try
		BANano.SetP(mSelf, "bEnabled", bEnabled)
		If mElement = Null Then Return
		If bEnabled Then
			RemoveAttr(mElement, "disabled")
		Else
			SetAttr(mElement, "disabled", True)
		End If
	Catch
		
	End Try				'ignore
End Sub

Sub SetEnabledByID(sID As String, bEnabled As Boolean)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If bEnabled Then
			RemoveAttr(mElement, "disabled")
		Else
			SetAttr(mElement, "disabled", True)
		End If
	Catch
		
	End Try				'ignore
End Sub

Sub SetButtonEnabledByID(sID As String, bEnabled As Boolean)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If bEnabled Then
			RemoveAttr(mElement, "disabled")
			RemoveClass(mElement, "btn-disabled")
		Else
			SetAttr(mElement, "disabled", True)
			AddClass(mElement, "btn-disabled")
		End If
	Catch
		
	End Try				'ignore
End Sub

' internal use
public Sub GetEnabled(mElement As BANanoElement) As Boolean
	If mElement = Null Then Return False
	Dim mEnabled As Boolean = Not(mElement.hasAttr("disabled"))
	BANano.SetP(mSelf, "bEnabled", mEnabled)
	Return mEnabled
End Sub

'set a data attribute
Sub SetData(mElement As BANanoElement, k As String, v As String)
	Try
		If mElement = Null Then Return
		If k = "" Then Return
		If v = "" Then
			RemoveAttr(mElement, $"data-${k}"$)
		Else
			SetAttr(mElement, $"data-${k}"$, v)
		End If
	Catch
		
	End Try				'ignore
End Sub

'get a data attribute
Sub GetData(mElement As BANanoElement, k As String) As String
	If mElement = Null Then Return ""
	Dim ma As String = mElement.GetData(k)
	ma = CStr(ma)
	ma = ma.trim
	Return ma
End Sub

'remove an attribute from the element
Sub RemoveAttr(mElement As BANanoElement, attr As String)
	Try
		If mElement = Null Then Return
		mElement.RemoveAttr(attr)
	Catch
		
	End Try				'ignore
End Sub

'add a styles to the element
Sub SetStyle(mElement As BANanoElement, k As String, v As String)
	Try
		If mElement = Null Then Return
		k = DeCamelCase(k)
		mElement.GetField("style").RunMethod("setProperty", Array(k, v))
	Catch
		
	End Try				'ignore
End Sub

Sub SetStyleByID(sID As String, k As String, v As String)
	Try
		sID = CleanID(sID)
		k = DeCamelCase(k)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		mElement.GetField("style").RunMethod("setProperty", Array(k, v))
	Catch
		
	End Try				'ignore
End Sub

Sub RemoveStyleByID(sID As String, k As String)
	Try
		sID = CleanID(sID)
		k = DeCamelCase(k)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		mElement.GetField("style").RunMethod("removeProperty", Array(k))
	Catch
		
	End Try				'ignore
End Sub

Sub GetStyleByID(sID As String, k As String) As String
	sID = CleanID(sID)
	k = DeCamelCase(k)
	Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
	If mElement = Null Then Return ""
	Dim computed As BANanoObject
	computed.Initialize4("getComputedStyle", mElement.ToObject) ' note that computed is read-only!
	Dim res As String = computed.RunMethod("getPropertyValue", k).Result
	res = CStr(res)
	Return res
End Sub

'add a styles to the element
Sub AddStyle(mElement As BANanoElement, k As String, v As String)			'ignoredeadcode
	Try
		If mElement = Null Then Return
		k = DeCamelCase(k)
		mElement.GetField("style").RunMethod("setProperty", Array(k, v))
	Catch
		
	End Try				'ignore
End Sub

Sub AddClassByID(sID As String, k As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		AddClass(mElement, k)
	Catch
		
	End Try				'ignore
End Sub

Sub AddStyleByID(sID As String, k As String, v As String)			'ignoredeadcode
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		AddStyle(mElement, k, v)
	Catch
		
	End Try				'ignore
End Sub

Sub AddStyleDT(k As String, v As String)
	iStyles.Put(k, v)
End Sub

Sub AddAttr(mElement As BANanoElement, attr As String, text As String)
	Try
		If mElement = Null Then Return
		mElement.SetAttr(attr, text)
	Catch
		
	End Try				'ignore
End Sub

Sub AddAttrByID(sID As String, k As String, v As String)			'ignoredeadcode
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetAttr(mElement, k, v)
	Catch
		
	End Try				'ignore
End Sub

Sub SetAttr(mElement As BANanoElement, Attr As String, text As String)
	Try
		If mElement = Null Then Return
		mElement.SetAttr(Attr, text)
	Catch
		
	End Try				'ignore
End Sub

Sub SetAttrByID(sID As String, k As String, v As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetAttr(mElement, k, v)
	Catch
		
	End Try				'ignore
End Sub

Sub RemoveAttrByID(sID As String, k As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		RemoveAttr(mElement, k)
	Catch
		
	End Try				'ignore
End Sub

Sub AddAttrDT(attr As String, text As Object)
	iAttributes.Put(attr, text)
End Sub

Sub AddDataAttrDT(attr As String, text As String)
	iAttributes.put($"data-${attr}"$, text)
End Sub

'set a data attribute to the element
Sub AddDataAttr(mElement As BANanoElement, attr As String, text As String)
	Try
		If mElement = Null Then Return
		mElement.SetData(attr, text)
	Catch
		
	End Try				'ignore
End Sub

Sub SetDataAttrByID(sID As String, k As String, v As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		mElement.SetData(k, v)
	Catch
		
	End Try				'ignore
End Sub

Sub GetDataAttr(mElement As BANanoElement, k As String) As String
	If mElement = Null Then Return ""
	If k = "" Then Return ""
	Dim xma As String = mElement.GetData(k)
	xma = CStr(xma)
	xma = xma.trim
	Return xma
End Sub

Sub GetAttr(mElement As BANanoElement, attr As String) As String
	If mElement = Null Then Return ""
	If attr = "" Then Return ""
	Dim stext As String = mElement.GetAttr(attr)
	stext = CStr(stext)
	stext = stext.trim
	Return stext
End Sub

Sub GetDataAttrByID(sID As String, attr As String) As String
	sID = CleanID(sID)
	Dim melement As BANanoElement = BANano.GetElement($"#${sID}"$)
	If melement = Null Then Return ""
	Dim stext As String = melement.GetData(attr)
	stext = CStr(stext)
	stext = stext.trim
	Return stext
End Sub

Sub GetAttrByID(sID As String, attr As String) As String
	sID = CleanID(sID)
	Dim melement As BANanoElement = BANano.GetElement($"#${sID}"$)
	If melement = Null Then Return ""
	Dim stext As String = melement.GetAttr(attr)
	stext = CStr(stext)
	stext = stext.trim
	Return stext
End Sub

Sub AddAttrMap(mElement As BANanoElement, ms As Map)
	Try
		If mElement = Null Then Return
		If ms.Size = 0 Then Return
		For Each k As String In ms.Keys
			Dim v As String = ms.Get(k)
			mElement.SetAttr(k,v)
		Next
	Catch
		
	End Try				'ignore
End Sub

'uses font awesome
'Sub SetIconNameByID1(elName As String, scontent As String)
'	elName = CleanID(elName)
'	Dim el As BANanoElement = BANano.GetElement($"#${elName}"$)
'	If el = Null Then Return
'	Dim mLastIcon As String = el.GetData("icon")
'	mLastIcon = CStr(mLastIcon)
'	If mLastIcon <> "" Then el.RemoveClass(mLastIcon)
'	el.AddClass(scontent)
'	el.SetData("icon", scontent)
'End Sub

'uses svg
Sub SetIconNameByID(elName As String, scontent As String)
	Try
		elName = CleanID(elName)
		Dim el As BANanoElement = BANano.GetElement($"#${elName}"$)
		SetSVGSrc(el, scontent)
	Catch
		
	End Try				'ignore
End Sub

Sub RemoveLastClassByID(sID As String, xClass As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		RemoveLastClass(mElement, xClass)
	Catch
		
	End Try				'ignore
End Sub

Sub RemoveLastClass(mElement As BANanoElement, xattr As String)
	Try
		If mElement = Null Then Return
		Dim mLast As String = mElement.GetData(xattr)
		mLast = CStr(mLast)
		mLast = mLast.trim
		mElement.RemoveAttr($"data-${xattr}"$)
		If mLast <> "" Then
			RemoveClass(mElement, mLast)
		End If
	Catch
		
	End Try				'ignore
End Sub

'this is for dynamic classes
Sub UpdateClass(mElement As BANanoElement, rpClass As String, nv As String)
	Try
		If mElement = Null Then Return
		RemoveLastClass(mElement, rpClass)
		If nv = "" Then Return
		If nv = "none" Then Return
		If nv.EndsWith("-") = True Then Return
		If nv.EndsWith("-none") = True Then Return
		mElement.SetData(rpClass, nv)
		AddClass(mElement, nv)
	Catch
		
	End Try				'ignore
End Sub

'Sub RemoveLastClass(mElement As BANanoElement, xattr As String)
'	If mElement = Null Then Return
'	Dim mLast As String = mElement.GetField($"data-${xattr}"$).Result
'	mLast = CStr(mLast)
'	mLast = mLast.trim
'	If mLast <> "" Then 
'		RemoveClass(mElement, mLast)
'	End If
'End Sub

''this is for dynamic classes
'Sub UpdateClass(mElement As BANanoElement, rpClass As String, nv As String)
'	If mElement = Null Then Return
'	RemoveLastClass(mElement, rpClass)
'	If nv = "" Then Return
'	If nv = "none" Then Return
'	If nv.EndsWith("-") = True Then Return
'	If nv.EndsWith("-none") = True Then Return
'	mElement.SetField($"data-${rpClass}"$, nv)
'	AddClass(mElement, nv)
'End Sub

Sub UpdateClassOnly(mElement As BANanoElement, rpClass As String, nv As String)
	Try
		If mElement = Null Then Return
		If nv = "" Then Return
		If nv = "none" Then Return
		If nv.EndsWith("-") = True Then Return
		If nv.EndsWith("-none") = True Then Return
		mElement.SetData(rpClass, nv)
		AddClass(mElement, nv)
	Catch
		
	End Try				'ignore
End Sub

private Sub GetClassList(s As String) As List
	Dim l As List
	l.Initialize
	s = CStr(s)
	s = s.Replace(" ", ";")
	s = s.Replace(CRLF, ";")
	s = s.Replace("<br/>", ";")
	s = s.Trim
	If s = "" Then Return l
	l = StrParse(";", s)
	Return l
End Sub

'remove a class from the element you can delimiter by ;
Sub RemoveClass(mElement As BANanoElement, xtext As String)
	Try
		If mElement = Null Then Return
		xtext = CStr(xtext)
		xtext = xtext.Replace(" ", ";")
		xtext = xtext.Replace(CRLF, ";")
		xtext = xtext.Replace("<br/>", ";")
		xtext = xtext.Trim
		If xtext = "" Then Return
		Dim lst As List = StrParse(";", xtext)
		For Each c As String In lst
			c = c.trim
			If c = "" Then Continue
			mElement.RemoveClass(c)
		Next
	Catch
		
	End Try				'ignore
End Sub

private Sub ListRemoveItem(lst As List, item As String)
	Dim cPos As Int = lst.IndexOf(item)
	If cPos <> -1 Then lst.RemoveAt(cPos)
End Sub

'convert a MV string to a map
Sub GetOptions(varStyles As String) As List
	varStyles = CStr(varStyles)
	varStyles = varStyles.Replace(CRLF, ";").Replace("<br/>", ";")
	varStyles = varStyles.Replace(":", "=").Replace("|", ";")
	varStyles = varStyles.Replace("'", "")
	varStyles = varStyles.Replace(",", ";")
	varStyles = varStyles.Replace(QUOTE, "")
	varStyles = varStyles.replace("?","")
	varStyles = varStyles.trim
	Dim mxItems As List = StrParse(";", varStyles)
	mxItems = ListRemoveDuplicates(mxItems, False)
	Return mxItems
End Sub

'convert a MV string to a map
Sub GetKeyValues(varStyles As String, deCamel As Boolean) As Map
	varStyles = CStr(varStyles)
	varStyles = varStyles.Replace(CRLF, ";").Replace("<br/>", ";")
	varStyles = varStyles.Replace(":", "=").Replace("|", ";")
	varStyles = varStyles.Replace("'", "")
	varStyles = varStyles.Replace(",", ";")
	varStyles = varStyles.Replace(QUOTE, "")
	varStyles = varStyles.replace("?","")
	varStyles = varStyles.trim
	Dim mxItems As List = StrParse(";", varStyles)
	mxItems = ListRemoveDuplicates(mxItems, False)
	Dim ms As Map = CreateMap()
	For Each mtx As String In mxItems
		mtx = mtx.Trim
		If mtx = "" Then Continue
		Dim k As String = MvField(mtx,1,"=")
		Dim v As String = MvField(mtx,2,"=")
		v = CStr(v)
		k = CStr(k)
		k = k.trim
		v = v.trim
		If k <> "" And v <> "" Then
			If deCamel Then k = DeCamelCase(k)
			ms.put(k, v)
		End If
	Next
	Return ms
End Sub


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
			Dim sout As String = sb.ToString
			sb.Initialize
			Return sout
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

'typeOf - width, style, color, radius
private Sub GetBordersMap(typeof As String, varOffsets As String) As Map
	Dim mm As Map = CreateMap("a":"", "t":"", "r":"", "b":"", "l":"", "tl":"", "tr":"", "bl":"", "br":"", "x":"", "y":"")
	Dim om As Map = GetKeyValues(varOffsets, False)
	For Each k As String In om.Keys
		Dim v As String = om.Get(k)
		Dim nk As String = ""
		Dim nk1 As String = ""
		Select Case k
			Case "a"
				nk = $"border-${typeof}"$
			Case "t"
				nk = $"border-top-${typeof}"$
			Case "r"
				nk = $"border-right-${typeof}"$
			Case "b"
				nk = $"border-bottom-${typeof}"$
			Case "l"
				nk = $"border-left-${typeof}"$
			Case "tl"
				nk = $"border-top-left-${typeof}"$
			Case "tr"
				nk = $"border-top-right-${typeof}"$
			Case "bl"
				nk = $"border-bottom-left-${typeof}"$
			Case "br"
				nk = $"border-bottom-right-${typeof}"$
			Case "x"
				nk = $"border-bottom-left-${typeof}"$
				nk1 = $"border-bottom-right-${typeof}"$
			Case "y"
				nk = $"border-bottom-top-${typeof}"$
				nk1 = $"border-bottom-bottom-${typeof}"$
		End Select
		If nk <> "" And v <> "" Then
			mm.Put(nk, v)
		End If
		If nk1 <> "" And v <> "" Then
			mm.Put(nk1, v)
		End If
	Next
	Return mm
End Sub

private Sub GetMarginPaddingMap(varOffsets As String) As Map
	Dim mm As Map = CreateMap("a":"", "x":"", "y":"", "t":"", "b":"", "l":"", "r":"")
	Dim om As Map = GetKeyValues(varOffsets, False)
	For Each k As String In om.Keys
		Dim v As String = om.Get(k)
		mm.Put(k, v)
	Next
	Return mm
End Sub


Sub StrMid(Text As String, Start As Int) As String
	Return Text.SubString(Start-1)
End Sub

'convert a map of marging/padding to a list
private Sub MarginPaddingToList(prefix As String, mm As Map) As List
	Dim l As List
	l.Initialize
	For Each k As String In mm.Keys
		Dim v As String = mm.Get(k)
		If v <> "" Then
			If v.StartsWith("n") Then
				Dim nn As String = StrMid(v,2)
				Dim n As String = RightSize(nn)
				Dim classKey As String = $"-${prefix}${k}-${n}"$
				If k = "a" Then
					classKey = $"-${prefix}-${n}"$
				End If
				l.Add(classKey)
			Else
				v = RightSize(v)
				Dim classKey As String = $"${prefix}${k}-${v}"$
				If k = "a" Then
					classKey = $"${prefix}-${v}"$
				End If
				l.Add(classKey)
			End If
		End If
	Next
	Return l
End Sub

Sub OnChildEvent(child As String, event As String, Module As Object, methodName As String)		'ignore
	Try
		child = CleanID(child)
		event = event.Replace(":","")
		event = event.Replace(".","")
		event = event.Replace("-","")
		'
		If SubExists(Module, methodName) = False Then Return
		Dim el As BANanoElement = BANano.GetElement($"#${child}"$)
		el.Off(event)
		el.On(event, Module, methodName)
	Catch
		
	End Try				'ignore
End Sub

Sub SetChecked(mElement As BANanoElement, v As Boolean)
	Try
		If mElement = Null Then Return
		mElement.SetChecked(v)
	Catch
		
	End Try				'ignore
End Sub

Sub GetChecked(mElement As BANanoElement) As Boolean
	If mElement = Null Then Return False
	Return mElement.GetChecked
End Sub

Sub SetImage(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		SetAttr(mElement, "src", s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetHeight(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		Dim sw As String = FixSize("h", s)
		UpdateClass(mElement, "height", sw)
	Catch
		
	End Try				'ignore
End Sub

Sub SetHeightResponsive(mElement As BANanoElement, breakpoint As String, s As String)
	Try
		If mElement = Null Then Return
		Dim sw As String = FixSize("h", s)
		Dim nw As String = $"${breakpoint}:${sw}"$
		UpdateClass(mElement, $"${breakpoint}height"$, nw)
	Catch
		
	End Try				'ignore
End Sub

Sub SetHeightByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetHeight(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetHeightResponsiveByID(sID As String, breakpoint As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetHeightResponsive(mElement, breakpoint, s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetWidth(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		Dim sw As String = FixSize("w", s)
		UpdateClass(mElement, "width", sw)
	Catch
		
	End Try				'ignore
End Sub

Sub FixIconSize(s As String) As String
	Dim actualSize As String = ""
	Select Case s
		Case "xs"
			actualSize = "14px"   '"24px"
		Case "sm"
			actualSize = "18px"  ' "32px"
		Case "md"
			actualSize = "24px" ' "40px"
		Case "lg"
			actualSize =  "32px" ' "48px"
		Case "xl"
			actualSize = "40px" ' "56px"
		Case Else
			actualSize = s
	End Select
	Return actualSize
End Sub

'set width and height of icon
Sub SetIconSize(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		Dim actualSize As String = ""
		Select Case s
			Case "xs"
				actualSize = "14px"   '"24px"
			Case "sm"
				actualSize = "18px"  ' "32px"
			Case "md"
				actualSize = "24px" ' "40px"
			Case "lg"
				actualSize =  "32px" ' "48px"
			Case "xl"
				actualSize = "40px" ' "56px"
			Case Else
				actualSize = s
		End Select
		mElement.SetAttr("width", actualSize)
		mElement.SetAttr("height", actualSize)
	Catch
		
	End Try				'ignore
End Sub

private Sub SetSVGSrc(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		mElement.SetAttr("data-src", s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetIconColor(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		If s = "" Then Return
		mElement.SetAttr("fill", "currentColor")
		SetStyle(mElement, "color", s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetIconColorByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		If s = "" Then Return
		mElement.SetAttr("fill", "currentColor")
		SetStyle(mElement, "color", s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetSVGFill(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		mElement.SetAttr("fill", s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetSVGFillByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		mElement.SetAttr("fill", s)
	Catch
		
	End Try				'ignore
End Sub

private Sub SetSVGSrcByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		mElement.SetAttr("data-src", s)
	Catch
		
	End Try				'ignore
End Sub

Sub ResizeIconByID(sID As String, sPercentage As String)
	Try
		sID = CleanID(sID)
		Dim sPerc As String = Val(sPercentage) & "%"
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		Dim m As Map = CreateMap("width": sPerc, "height":sPerc)
		mElement.SetStyle(BANano.ToJson(m))
		mElement.SetAttr("preserveAspectRatio", "xMidYMid meet")
		mElement.RemoveAttr("width")
		mElement.RemoveAttr("height")
	Catch
		
	End Try				'ignore
End Sub

Sub Increment(ival As Int) As Int
	ival = CInt(ival) + 1
	Return ival
End Sub

Sub Decrement(ival As Int) As Int
	ival = CInt(ival) - 1
	Return ival
End Sub

Sub PercentOf(cvalue As Int, tvalue As Int) As Double
	Dim dbl As Double = CDbl(cvalue) / CDbl(tvalue)
	dbl = CDbl(dbl) * 100
	dbl = Round(dbl)
	Return dbl
End Sub

'set width and height of icon
Sub SetIconSizeByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetIconSize(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetIconWidth(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		Dim actualSize As String = ""
		Select Case s
			Case "xs"
				actualSize = "14px"   '"24px"
			Case "sm"
				actualSize = "18px"  ' "32px"
			Case "md"
				actualSize = "24px" ' "40px"
			Case "lg"
				actualSize =  "32px" ' "48px"
			Case "xl"
				actualSize = "40px" ' "56px"
			Case Else
				actualSize = s
		End Select
		mElement.SetAttr("width", actualSize)
	Catch
		
	End Try				'ignore
End Sub

Sub SetIconHeight(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		Dim actualSize As String = ""
		Select Case s
			Case "xs"
				actualSize = "14px"   '"24px"
			Case "sm"
				actualSize = "18px"  ' "32px"
			Case "md"
				actualSize = "24px" ' "40px"
			Case "lg"
				actualSize =  "32px" ' "48px"
			Case "xl"
				actualSize = "40px" ' "56px"
			Case Else
				actualSize = s
		End Select
		mElement.SetAttr("height", actualSize)
	Catch
		
	End Try				'ignore
End Sub

Sub SetIconWidthByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetIconWidth(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetIconHeightByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetIconHeight(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetAttrWidthByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		mElement.SetAttr("width", s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetAttrHeightByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		mElement.SetAttr("width", s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetAttrWidth(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		mElement.SetAttr("width", s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetAttrHeight(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		mElement.SetAttr("height", s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetWidthResponsive(mElement As BANanoElement, breakpoint As String, s As String)
	Try
		If mElement = Null Then Return
		Dim sw As String = FixSize("w", s)
		Dim nw As String = $"${breakpoint}:${sw}"$
		UpdateClass(mElement, $"${breakpoint}width"$, nw)
	Catch
		
	End Try				'ignore
End Sub

Sub SetMaxWidthResponsive(mElement As BANanoElement, breakpoint As String, s As String)
	Try
		If mElement = Null Then Return
		Dim sw As String = FixSize("max-w", s)
		Dim nw As String = $"${breakpoint}:${sw}"$
		UpdateClass(mElement, $"${breakpoint}maxwidth"$, nw)
	Catch
		
	End Try				'ignore
End Sub

Sub SetMaxWidthResponsiveByID(sID As String, breakpoint As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetMaxWidthResponsive(mElement, breakpoint, s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetMaxHeightResponsiveByID(sID As String, breakpoint As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetMaxHeightResponsive(mElement, breakpoint, s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetMaxHeightResponsive(mElement As BANanoElement, breakpoint As String, s As String)
	Try
		If mElement = Null Then Return
		Dim sw As String = FixSize("max-h", s)
		Dim nw As String = $"${breakpoint}:${sw}"$
		UpdateClass(mElement, $"${breakpoint}maxheight"$, nw)
	Catch
		
	End Try				'ignore
End Sub

Sub SetWidthResponsiveByID(sID As String, breakpoint As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetWidthResponsive(mElement, breakpoint, s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetMaxHeight(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		Dim sw As String = FixSize("max-h", s)
		UpdateClass(mElement, "maxheight", sw)
	Catch
		
	End Try				'ignore
End Sub

Sub SetMinHeight(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		Dim sw As String = FixSize("min-h", s)
		UpdateClass(mElement, "minheight", sw)
	Catch
		
	End Try				'ignore
End Sub

Sub SetMaxWidth(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		Dim sw As String = FixSize("max-w", s)
		UpdateClass(mElement, "maxwidth", sw)
	Catch
		
	End Try				'ignore
End Sub

Sub SetMinWidth(mElement As BANanoElement, s As String)
	Try
		If mElement = Null Then Return
		Dim sw As String = FixSize("min-w", s)
		UpdateClass(mElement, "minwidth", sw)
	Catch
		
	End Try				'ignore
End Sub

Sub SetMaxWidthByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetMaxWidth(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetMaxHeightByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetMaxHeight(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetMinHeightByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetMinHeight(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetMinWidthByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetMinWidth(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetWidthByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetWidth(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

Sub SetImageByID(sID As String, s As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		SetImage(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

Sub GetCheckedByID(sID As String) As Boolean
	sID = CleanID(sID)
	Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
	If mElement = Null Then Return False
	Dim b As Boolean = mElement.GetChecked
	b = CBool(b)
	Return b
End Sub

Sub SetCheckedByID(sID As String, b As Boolean)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		mElement.SetChecked(b)
	Catch
		
	End Try				'ignore
End Sub

Sub ToggleDropDownByID(sID As String)
	ToggleClassByID(sID, "dropdown-open")
End Sub

Sub CloseDropDownByID(sID As String)
	RemoveClassByID(sID, "dropdown-open")
End Sub

Sub OpenDropDownByID(sID As String)
	AddClassByID(sID, "dropdown-open")
End Sub

Sub ToggleClassByID(sID As String, sClass As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		mElement.ToggleClass(sClass)
	Catch
		
	End Try				'ignore
End Sub

Sub ToggleClass(mElement As BANanoElement, sClass As String)
	Try
		If mElement = Null Then Return
		mElement.ToggleClass(sClass)
	Catch
		
	End Try				'ignore
End Sub

Sub ToggleByID(sID As String)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		Dim b As Boolean = CBool(mElement.GetChecked)
		mElement.SetChecked(Not(b))
	Catch
		
	End Try				'ignore
End Sub

Sub Toggle(mElement As BANanoElement)
	Try
		If mElement = Null Then Return
		Dim b As Boolean = CBool(mElement.GetChecked)
		mElement.SetChecked(Not(b))
	Catch
		
	End Try				'ignore
End Sub

Sub SetText(mElement As BANanoElement, hx As String)
	Try
		If mElement = Null Then Return
		mElement.SetText(hx)
	Catch
		
	End Try				'ignore
End Sub

Sub GetText(mElement As BANanoElement) As String
	If mElement = Null Then Return ""
	Return mElement.gettext
End Sub

Sub GetTextByID(sID As String) As String
	sID = CleanID(sID)
	Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
	Return GetText(mElement)
End Sub

Sub GetValue(mElement As BANanoElement) As Object
	If mElement = Null Then Return Null
	Return mElement.GetValue
End Sub

Sub GetValueByID(sID As String) As String
	sID = CleanID(sID)
	Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
	If mElement = Null Then Return ""
	Dim svalue As String = mElement.GetValue
	Return svalue
End Sub

Sub SetValue(mElement As BANanoElement, v As Object)
	If mElement = Null Then Return
	mElement.SetValue(v)
End Sub

Sub SetValueByID(sID As String, v As Object)
	Try
		sID = CleanID(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		If mElement = Null Then Return
		mElement.SetValue(v)
	Catch
		
	End Try				'ignore
End Sub

Sub ResponsiveClass(mElement As BANanoElement, className As String, xs As Boolean, sm As Boolean, md As Boolean, lg As Boolean)
	If mElement = Null Then Return
	If xs Then AddClass(mElement, "xs:" & className)
	If sm Then AddClass(mElement, "sm:" & className)
	If md Then AddClass(mElement, "md:" & className)
	If lg Then AddClass(mElement, "lg:" & className)
End Sub

Sub AddTextColorDT(tc As String)   'ignoredeadcode
	Try
		Dim s As String = FixColor("text", tc)
		AddAttrDT("data-textcolor", s)
		AddClassDT(s)
	Catch
		
	End Try				'ignore
End Sub

Sub AddBackgroundColorDT(tc As String)			'ignoredeadcode
	Dim s As String = FixColor("bg", tc)
	AddAttrDT("data-color", s)
	AddClassDT(s)
End Sub

Sub AddSizeDT(prefix As String, tc As String)
	Dim s As String = FixSize(prefix, tc)
	Select Case prefix
		Case "w"
			AddAttrDT("data-width", s)
		Case "h"
			AddAttrDT("data-height", s)
		Case "max-h"
			AddAttrDT("data-maxheight", S)
		Case "min-h"
			AddAttrDT("data-minheight", s)
		Case "max-w"
			AddAttrDT("data-maxwidth", S)
		Case "min-w"
			AddAttrDT("data-minwidth", S)
		Case Else
			AddAttrDT("data-size", S)
	End Select
	AddClassDT(s)
End Sub

Sub AddCenterChildrenDT				'ignoredeadcode
	AddClassDT("flex justify-center items-center")
End Sub

Sub AddWidthDT(s As String)
	AddSizeDT("w", s)
End Sub

Sub AddMinWidthDT(s As String)
	AddSizeDT("min-w", s)
End Sub

Sub AddMaxWidthDT(s As String)
	AddSizeDT("max-w", s)
End Sub

Sub AddHeightDT(s As String)
	AddSizeDT("h", s)
End Sub

Sub AddMaxHeightDT(s As String)
	AddSizeDT("max-h", s)
End Sub

Sub AddMinHeightDT(s As String)
	AddSizeDT("min-h", s)
End Sub

Sub AddColorDT(prefix As String, tc As String)
	Dim s As String = FixColor(prefix, tc)
	AddAttrDT("data-color", s)
	AddClassDT(s)
End Sub

Sub AddBorderColorDT(tc As String)					'ignoredeadcode
	Dim s As String = FixColor("border", tc)
	AddAttrDT("data-bordercolor", s)
	AddClassDT(s)
End Sub

Sub AddMaskDT(tc As String)
	Dim s As String = FixMask(tc)
	AddAttrDT("data-mask", s)
	AddClassDT(s)
End Sub

Sub AddRoundedDT(tc As String)
	Dim s As String = FixRounded(tc)
	AddAttrDT("data-rounded", s)
	AddClassDT(s)
End Sub

Sub AddRoundedBoxDT
	AddClassDT("rounded-box")
End Sub

Sub AddShadowDT(s As String)
	Dim x As String = FixShadow(s)
	AddAttrDT("data-shadow", s)
	AddAttrDT("shadow", s)
	AddClassDT(x)
End Sub

Sub AddTextSizeDT(tc As String)  'ignoredeadcode
	Dim s As String = FixSize("text", tc)
	AddAttrDT("data-textsize", s)
	AddClassDT(s)
End Sub

Sub AddBackgroundImageDT(s As String)				'ignoredeadcode
'	AddClassDT("bg-cover bg-center bg-no-repeat")
'	AddClassDT($"bg-[url(${s})]"$)
	AddStyleDT("background-image", $"url('${s}')"$)
	AddStyleDT("background-size", "cover")
'	AddStyleDT("width", "100%")
'	AddStyleDT("height", "100%")
	AddStyleDT("background-position", "center")
	AddStyleDT("background-repeat", "no-repeat")
End Sub

Sub SetBackgroundImage(mElement As BANanoElement, s As String)			'ignoredeadcode
	If mElement = Null Then Return
	Dim m As Map = CreateMap()
	m.Put("background-image", $"url('${s}')"$)
	m.put("background-size", "cover")
'	m.Put("width", "100%")
'	m.Put("height", "100%")
	m.Put("background-position", "center")
	m.Put("background-repeat", "no-repeat")
	AddStyleMap(mElement, m)
End Sub

Sub SetBackgroundImageByID(sID As String, s As String)			'ignoredeadcode
	Try
		sID = CStr(sID)
		Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
		SetBackgroundImage(mElement, s)
	Catch
		
	End Try				'ignore
End Sub

Sub AddPlacementDT(sprefix As String, sPlacement As String)   'ignoredeadcode
	Dim hashPos As Int = sPlacement.IndexOf("-")
	If hashPos = -1 Then
		AddClassDT($"${sprefix}-${sPlacement}"$)
	Else
		Dim fpart As String = MvField(sPlacement,1,"-")
		Dim spart As String = MvField(sPlacement,2,"-")
		AddClassDT($"${sprefix}-${fpart}"$)
		AddClassDT($"${sprefix}-${spart}"$)
	End If
End Sub

Sub SetPlacement(mElement As BANanoElement, sprefix As String, sPlacement As String)
	If mElement = Null Then Return
	Dim hashPos As Int = sPlacement.IndexOf("-")
	If hashPos = -1 Then
		AddClass(mElement, $"${sprefix}-${sPlacement}"$)
	Else
		Dim fpart As String = MvField(sPlacement,1,"-")
		Dim spart As String = MvField(sPlacement,2,"-")
		AddClass(mElement, $"${sprefix}-${fpart} ${sprefix}-${spart}"$)
	End If
End Sub

Sub SetIconFillByID(sID As String, s As String)
	sID = CleanID(sID)
	Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
	If mElement = Null Then Return
	mElement.SetAttr("fill", s)
End Sub

Sub SetIconFill(mElement As BANanoElement, s As String)
	If mElement = Null Then Return
	mElement.SetAttr("fill", s)
End Sub

Sub SetPlacementByID(sID As String, sprefix As String, splacement As String)
	sID = CleanID(sID)
	Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
	SetPlacement(mElement, sprefix, splacement)
End Sub

Sub SetCenterChildren(mElement As BANanoElement, b As Boolean)
	If mElement = Null Then Return
	If b Then
		AddClass(mElement, "flex justify-center items-center")
	Else
		RemoveClass(mElement, "flex justify-center items-center")
	End If
End Sub

Sub SetCenterChildrenByID(sID As String, b As Boolean)
	sID = CleanID(sID)
	Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
	SetCenterChildren(mElement, b)
End Sub

Sub SetField(mElement As BANanoElement, k As String, v As String)
	If mElement = Null Then Return
	mElement.SetField(k, v)
End Sub

Sub GetField(mElement As BANanoElement, k As String) As String
	If mElement = Null Then Return ""
	Dim v As String = mElement.GetField(k).Result
	v = CStr(v)
	Return v
End Sub

Sub SetFieldByID(sID As String, k As String, v As String)
	sID = CleanID(sID)
	Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
	If mElement = Null Then Return
	mElement.SetField(k, v)
End Sub

Sub GetFieldByID(sID As String, k As String) As String
	sID = CleanID(sID)
	Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
	If mElement = Null Then Return ""
	Dim v As String = mElement.GetField(k).Result
	v = CStr(v)
	Return v
End Sub

'return proper sub name
Sub ProperSubName(vx As String, removePref As Boolean) As String
	vx = vx.Replace(":", "-")
	vx = vx.Replace(".", "-")
	Dim varList As List = StrParse("-", vx)
	If removePref Then
		varList.RemoveAt(0)
	End If
	Dim varTot As Int = varList.Size - 1
	Dim varCnt As Int
	For varCnt = 0 To varTot
		Dim varItem As String = varList.Get(varCnt)
		varItem = ProperCase(varItem)
		varList.Set(varCnt, varItem)
	Next
	Dim subName1 As String = Join("",varList)
	Return subName1
End Sub

Sub ProperCase(myStr As String) As String
	Try
		If myStr.trim.length = 0 Then Return ""
		Dim x As String
		Dim j, k As Int
		myStr = myStr.tolowercase
		x = myStr.ToUpperCase.CharAt(0)
		myStr = x & myStr.SubString2(1, myStr.Length)
		For j = 1 To myStr.Length
			k = myStr.IndexOf2(" ", j + 1)
			If k = -1 Then Exit
			x = myStr.ToUpperCase.CharAt(k + 1)
			myStr = myStr.SubString2(0, k + 1) & x & myStr.SubString2(k + 2, myStr.Length)
		Next
		Return myStr
	Catch
		Return myStr
	End Try
End Sub


'count mv string
Sub MvCount(strMV As String, Delimiter As String) As Int
	strMV = CStr(strMV)
	strMV = strMV.Trim
	If strMV = "" Then Return 0
	Dim spValues As List = StrParse(Delimiter,strMV)
	Return spValues.Size
End Sub

Sub MvLast(delim As String, value As String) As String
	Dim tot As Int = MvCount(value,delim)
	Return MvField(value,tot,delim)
End Sub


'get recursive data from a map
Sub GetRecursive(data As Map, path As String) As Object
	Try
		Dim prevObj As BANanoObject = data
		If path.IndexOf(".") = -1 Then
			Dim res As Object = prevObj.GetField(path)
			If BANano.IsUndefined(res) Then
				res = Null
			End If
			Return res
		Else
			Dim items As List = BANano.Split(".", path)
			Dim iTot As Int = items.Size
			Dim iCnt As Int
			'
			Dim strprev As String = ""
			Dim prtObj As BANanoObject
			Dim litem As String = items.Get(iTot - 1)
			'
			For iCnt = 1 To iTot - 1
				'get the previos path
				strprev = items.Get(iCnt - 1)
				'the parent object
				prtObj = prevObj.GetField(strprev)
				'this does not exist, return
				If BANano.IsUndefined(prtObj) Then
					Return Null
				Else
					prevObj = prtObj
				End If
			Next
			Dim res As Object = prevObj.GetField(litem)
			If BANano.IsUndefined(res) Then
				res = Null
			End If
			Return res
		End If
	Catch
		Return Null
	End Try
End Sub

'Sub DateAdd(mDate As String, HowManyDays As Int) As String
'	DateTime.DateFormat = "yyyy-MM-dd"
'	HowManyDays = CInt(HowManyDays)
'	Dim ConvertDate, NewDateDay As Long
'	ConvertDate = DateTime.DateParse(mDate)
'	NewDateDay = DateTime.Add(ConvertDate, 0, 0, HowManyDays)
'	Return DateTime.Date(NewDateDay)
'End Sub
'
'Sub GetDatesBetween(startDate As String, endDate As String) As List
'	DateTime.DateFormat = "yyyy-MM-dd"
'	' Initialize the list to hold working dates
'	Dim workingDates As List
'	workingDates.Initialize
'
'	' Parse the start and end dates
'	Dim sd As Long = DateTime.DateParse(startDate)
'	Dim ed As Long = DateTime.DateParse(endDate)
'
'	' Loop through all dates from start to end
'	For i = sd To ed Step DateTime.TicksPerDay
'		' Add the date to the list
'		workingDates.Add(DateTime.Date(i))
'	Next
'
'	Return workingDates
'End Sub


'prefix a color
Sub FixColorIntensity(prefix As String, v As String, i As String) As String
	prefix = CStr(prefix)
	v = CStr(v)
	i = CStr(i)
	If prefix = "" Or v = "" Then Return ""
	Dim p1 As String = FixColor(prefix, v)
	If i <> "" Then
		If p1.Contains("[") = False Then
			p1 = p1 & "-" & i
		End If
	End If
	If p1.EndsWith("-") Then p1 = ""
	Return p1
End Sub

'
'Sub LoremIpsum(count As Int) As String
'	Dim str As String = $"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."$
'	Dim sb As StringBuilder
'	sb.Initialize
'	For i = 1 To count
'		sb.Append(str).Append(CRLF)
'	Next
'	Dim sout As String = sb.ToString
'	sb.Initialize
'	Return sout
'End Sub

Sub CleanID(s As String) As String
	s = CStr(s)
	s = s.tolowercase
	s = s.Replace("#", "")
	s = s.Replace(" ", "")
	s = s.Replace("{", "")
	s = s.Replace("]", "")
	s = s.Replace("[", "")
	s = s.Replace("}", "")
	s = s.Replace("(", "")
	s = s.Replace(")", "")
	s = s.Trim
	Return s
End Sub


Sub CBool(v As Object) As Boolean
	If BANano.IsNull(v) Or BANano.IsUndefined(v) Then
		v = False
	End If
	If GetType(v) = "string" Or GetType(v) = "object" Then
		Dim s As String = v & ""
		s = s.tolowercase
		s = s.trim
		If s = "" Then Return False
		If s = "false" Then Return False
		If S = "true" Then Return True
		If s = "1" Then Return True
		If s = "y" Then Return True
		If s = "0" Then Return False
		If s = "n" Then Return False
		If s = "no" Then Return False
		If s = "yes" Then Return True
		If s = "on" Then Return True
		If s = "off" Then Return False
	End If
	Return v
End Sub


Sub CStr(o As Object) As String
	If BANano.isnull(o) Or BANano.IsUndefined(o) Then o = ""
	If o = "null" Then Return ""
	If o = "undefined" Then Return ""
	Return "" & o
End Sub


Sub Join(delimiter As String, lst As List) As String
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
	Dim sout As String = sbx.ToString
	sbx.Initialize
	Return sout
End Sub

''format date to meet your needs
''https://day.js.org/docs/en/parse/string-format
'Sub FormatDisplayDate(item As String, sFormat As String) As String
'	Try
'		item = CStr(item)
'		If item = "" Then Return ""
'		Dim bo As BANanoObject = BANano.RunJavascriptMethod("dayjs", Array(item))
'		Dim sDate As String = bo.RunMethod("format", Array(sFormat)).Result
'		If sDate = "Invalid Date" Then Return ""
'		Return sDate
'	Catch
'		Return ""
'	End Try
'End Sub


Sub Val(value As String) As String
	value = CStr(value)
	value = value.Trim
	If value = "" Then value = "0"
	Try
		Dim sout As String = ""
		Dim mout As String = ""
		Dim slen As Int = value.Length
		Dim i As Int = 0
		For i = 0 To slen - 1
			mout = value.CharAt(i)
			If InStr("0123456789.-", mout) <> -1 Then
				sout = sout & mout
			End If
		Next
		Return sout
	Catch
		Return value
	End Try
End Sub


Sub InStr(sText As String, sFind As String) As Int
	Return sText.tolowercase.IndexOf(sFind.tolowercase)
End Sub


''format numeric display
'Sub FormatDisplayNumber(item As String, sFormat As String) As String
'	Try
'		item = "" & item
'		If item = "" Then Return ""
'		If BANano.isnull(item) Or BANano.IsUndefined(item) Then Return ""
'		item = Val(item)
'		item = BANano.parseFloat(item)
'		Dim bo As BANanoObject = BANano.RunJavascriptMethod("numeral", Array(item))
'		Dim sDate As String = bo.RunMethod("format", Array(sFormat)).Result
'		Return sDate
'	Catch
'		Return ""
'	End Try
'End Sub
'
'Sub FormatFileSize(Bytes As Float) As String
'	If BANano.IsNull(Bytes) Or BANano.IsUndefined(Bytes) Then
'		Bytes = 0
'	End If
'	Bytes = BANano.parsefloat(Bytes)
'	Try
'		Private Unit() As String = Array As String(" Byte", " KB", " MB", " GB", " TB", " PB", " EB", " ZB", " YB")
'		If Bytes = 0 Then
'			Return "0 Bytes"
'		Else
'			Private Po, Si As Double
'			Private I As Int
'			Bytes = Abs(Bytes)
'			I = Floor(Logarithm(Bytes, 1024))
'			Po = Power(1024, I)
'			Si = Bytes / Po
'			Return NumberFormat(Si, 1, 3) & Unit(I)
'		End If
'	Catch
'		Return "0 Bytes"
'	End Try
'End Sub
'
''return a date with day, month year name
'Sub NiceDate(sdate As String) As String
'	Return FormatDisplayDate(sdate, "ddd, DD MMM YYYY")
'End Sub
'
'Sub NiceMonth(sdate As String) As String
'	Return FormatDisplayDate(sdate, "MMMM, YYYY")
'End Sub
'
'Sub NiceYear(sdate As String) As String
'	Return FormatDisplayDate(sdate, "YYYY")
'End Sub
'
''return a date time
'Sub NiceTime(stime As String) As String
'	Return FormatDisplayDate(stime, "ddd, DD MMM YYYY @ HH:mm:ss")
'End Sub
'
'Sub NiceDateTime(stime As String) As String
'	Return FormatDisplayDate(stime, "ddd, DD MMM YYYY @ HH:mm")
'End Sub
'
'
''return money
'Sub NiceMoney(smoney As String) As String
'	Return FormatDisplayNumber(smoney, "0,0.00")
'End Sub
''return thousands
'Sub Thousands(smoney As String) As String
'	Return FormatDisplayNumber(smoney, "0,0")
'End Sub
'
'Sub NiceFileSize(fsx As String) As String
'	Return FormatFileSize(fsx)
'End Sub

Sub FixSize(prefix As String, v As String) As String
	prefix = CStr(prefix)
	v = CStr(v)
	If prefix = "" Or v = "" Then Return ""
	Dim res As String = ""
	If v.EndsWith("px") Then
		res = $"${prefix}-[${v}]"$
	else if v.EndsWith("rem") Then
		res = $"${prefix}-[${v}]"$
	else if v.EndsWith("vh") Then
		res = $"${prefix}-[${v}]"$
	else if v.EndsWith("vw") Then
		res = $"${prefix}-[${v}]"$
	else if v.EndsWith("%") Then
		res = $"${prefix}-[${v}]"$
	Else
		res = $"${prefix}-${v}"$
	End If
	If res.EndsWith("-") Then res = ""
	Return res
End Sub

Sub FixMask(mask As String) As String
	mask = mask.Replace("mask-", "")
	Select Case mask
		Case "rounded-xs", "rounded-md", "rounded-xl","rounded-sm", "rounded-2xl", "rounded-3xl", "rounded", "rounded-full", "rounded-lg"
			Return mask
		Case "circle"
			Return "rounded-full"
		Case "rounded"
			Return "rounded"
		Case "none", ""
			Return ""
		Case Else
			Return "mask mask-" & mask
	End Select
End Sub

Sub FixRounded(s As String) As String
	Select Case s
		Case "rounded"
			Return s
		Case "0"
			Return "rounded-none"
		Case Else
			Dim x As String = "rounded-" & s
			Return x
	End Select
End Sub


Sub ListToSelectOptionsSort(lst As List) As Map
	lst.Sort(True)
	Dim m As Map = CreateMap()
	For Each item As String In lst
		m.Put(item, item)
	Next
	Return m
End Sub

Sub MapToOptionsString(m As Map) As String
	Dim sb As StringBuilder
	sb.Initialize
	For Each k As String In m.Keys
		Dim v As String = m.Get(k)
		sb.Append($"${k}:${v};"$)
	Next
	Dim sout As String = sb.ToString
	sout = RemDelim(sout, ";")
	Return sout
End Sub

'put recursive object to a map
Sub PutRecursive(data As Map, path As String, value As Object)
	Try
		If BANano.IsNull(path) Or BANano.IsUndefined(path) Then
			path = ""
		End If
		If path = "" Then Return
		Dim prevObj As BANanoObject = data
		If path.IndexOf(".") = -1 Then
			'we dont have a dot
			prevObj.SetField(path, value)
		Else
			'we have a dot
			Dim items As List = BANano.Split(".", path)
			Dim iTot As Int = items.Size
			Dim iCnt As Int
			'
			Dim strprev As String = ""
			Dim prtObj As BANanoObject
			Dim litem As String = items.Get(iTot - 1)
			'
			For iCnt = 1 To iTot - 1
				'get the previos path
				strprev = items.Get(iCnt - 1)
				'the parent object
				prtObj = prevObj.GetField(strprev)
				'this does not exist, create it
				If BANano.IsUndefined(prtObj) Then
					Dim no As Object
					prevObj.SetField(strprev, no)
					prevObj = prevObj.GetField(strprev)
				Else
					prevObj = prtObj
				End If
			Next
			prevObj.SetField(litem, value)
		End If
	Catch	'ignore
	End Try	'ignore
End Sub

'remove items, case sensitive
Sub MvRemoveItems(delim As String, value As String, sitems As String) As String
	Dim nitems As List
	nitems.Initialize
	'
	Dim items As List = StrParse(delim, value)
	Dim spitems As List = StrParse(delim, sitems)
	'
	For Each k As String In items
		If spitems.IndexOf(k) = -1 Then nitems.Add(k)
	Next
	'
	Dim res As String = Join(delim, nitems)
	Return res
End Sub

'make lowercase
Sub MapMakeLowerCaseKeys(m As Map) As Map
	Dim nm As Map = CreateMap()
	For Each k As String In m.Keys
		Dim nk As String = k.tolowercase
		If nk = k Then Continue
		Dim v As Object = m.Get(k)
		nm.Put(nk, v)
		nm.Remove(k)
	Next
	Return nm
End Sub


'make the keys of the maps to lowercase
Sub ListOfMapsKeysToLowerCase(lst As List)
	Dim recTot As Int = lst.Size - 1
	Dim recCnt As Int
	For recCnt = 0 To recTot
		Dim m As Map = lst.Get(recCnt)
		m = MapMakeLowerCaseKeys(m)
		lst.Set(recCnt, m)
	Next
End Sub


'convert the items in a list to a map
Sub ListToSelectOptions(lst As List) As Map
	Dim m As Map = CreateMap()
	For Each item As String In lst
		m.Put(item, item)
	Next
	Return m
End Sub

Sub FixShadow(s As String) As String
	Select Case s
		Case "shadow"
			Return s
		Case Else
			Dim x As String = "shadow-" & s
			Return x
	End Select
End Sub


'convert to int
Sub CInt(o As Object) As Int
	o = Val(o)
	Return BANano.parseInt(o)
End Sub


Sub FixOffset(s As String) As String
	Select Case s
		Case "1"
			Return "ml-1/12"
		Case "2"
			Return "ml-2/12"
		Case "3"
			Return "ml-3/12"
		Case "4"
			Return "ml-4/12"
		Case "5"
			Return "ml-5/12"
		Case "6"
			Return "ml-1/2"
		Case "7"
			Return "ml-7/12"
		Case "8"
			Return "ml-8/12"
		Case "9"
			Return "ml-9/12"
		Case "10"
			Return "ml-10/12"
		Case "11"
			Return 	"ml-11/12"
		Case Else
			Return ""
	End Select
End Sub

Sub ListTrimItems(cols As List) As List
	Dim colTot As Int = cols.Size - 1
	Dim colCnt As Int
	For colCnt = 0 To colTot
		Dim strcol As String = cols.Get(colCnt)
		strcol = strcol.Trim
		cols.Set(colCnt, strcol)
	Next
	Return cols
End Sub

Sub StrParseTrim(delim As String, inputString As String) As List
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
		Dim nl1 As List = ListTrimItems(nl)
		Return nl1
	Catch
		'Log(LastException)
		Return nl
	End Try
End Sub

Sub DeCamelCase(st As String) As String			'ignoredeadcode
	If st.Length = 0 Then Return ""
	Dim k As Int
	Dim s As String
	Dim newst As String = st.CharAt(0)
	For i = 1 To st.Length - 1
		s = st.CharAt(i)
		k = Asc(s)
		If k>64 And k < 91 And st.CharAt(i-1) <> " " Then
			newst = newst & "-" & s
		Else
			newst = newst & s
		End If
	Next
	newst = newst.tolowercase
	Return newst
End Sub

Sub StrParse(delim As String, inputString As String) As List
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


Sub ListRemoveDuplicates(lst As List, bSort As Boolean) As List
	Dim nl As List
	nl.Initialize
	For Each item As String In lst
		If nl.IndexOf(item) = -1 Then
			nl.Add(item)
		End If
	Next
	If bSort Then nl.Sort(True)
	Return nl
End Sub

Sub RightSize(v As String) As String
	v = CStr(v)
	If v.EndsWith("px") Or v.EndsWith("rem") Or v.EndsWith("vh") Or v.EndsWith("vw") Or v.EndsWith("%") Then
		Return $"[${v}]"$
	Else
		Return v
	End If
End Sub

'return the left part of a string
Sub Left(Text As String, xLength As Long) As String
	If xLength>Text.Length Then xLength=Text.Length
	Return Text.SubString2(0, xLength)
End Sub

'get full name initials
Sub Initials(FullName As String) As String
	Dim parts As List = StrParse(" ", FullName)
	If parts.Size = 1 Then
		Dim fn As String = parts.Get(0)
		Dim xfn As String = Left(fn, 1)
		xfn = xfn.ToUpperCase.trim
		Return xfn
	Else
		Dim fn1 As String = parts.Get(0)
		Dim fn2 As String = MvField(FullName, -1, " ")
		Dim xfn1 As String = Left(fn1, 1)
		Dim xfn2 As String = Left(fn2, 1)
		Dim afn As String = $"${xfn1}${xfn2}"$
		afn = afn.ToUpperCase.trim
		Return afn
	End If
End Sub

''insert a css rule
'Sub InsertCSSRule(selector As String, styles As Object)
'	BANano.RunJavascriptMethod("insertRule", Array(selector, styles))
'End Sub
'
''remove a css rule 
'Sub RemoveCSSRule(selector As String)
'	Dim i As BANanoObject
'	i.Initialize("insertRule")
'	i.RunMethod("remove", selector)
'End Sub


'get alphabets only
Sub Alpha(value As String) As String
	value = CStr(value)
	Try
		value = value.Trim
		If value = "" Then value = ""
		Dim sout As String = ""
		Dim mout As String = ""
		Dim slen As Int = value.Length
		Dim i As Int = 0
		For i = 0 To slen - 1
			mout = value.CharAt(i)
			If InStr("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", mout) <> -1 Then
				sout = sout & mout
			End If
		Next
		Return sout
	Catch
		Return value
	End Try
End Sub

'remove the delimiter from stringbuilder
Sub RemDelim(sValue As String, Delim As String) As String
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

''<code>
'''parse a list of records from data-table to make csv
''Dim csvData As String = ListOfMapsToCSV(records, ",", true)
''</code>
'Sub ListOfMapsToCSV(content As List, quotes As Boolean, delimiter As String, hasHeader As Boolean) As String
'	Dim config As Map = CreateMap()
'	config.Put("quotes", quotes)
'	config.Put("delimiter", delimiter)
'	config.Put("header", hasHeader)
'	config.put("skipEmptyLines", True)
'	'
'	Dim Papa As BANanoObject
'	Papa.Initialize("Papa")
'	Dim res As String = Papa.RunMethod("unparse", Array(content, config)).Result
'	Return res
'End Sub

'return the position of a string found in a string
Sub InStr1(Text As String, sFind As String) As Int
	Return Text.tolowercase.IndexOf(sFind.tolowercase) + 1
End Sub

'
'Sub ShowLoader
'	Dim lEL As BANanoElement
'	lEL.Initialize("#loader-1")
'	Dim mStyle As Map = CreateMap()
'	mStyle.Put("display", "block")
'	lEL.SetStyle(BANano.ToJson(mStyle))
'End Sub
'
'Sub HideLoader
'	Dim lEL As BANanoElement
'	lEL.Initialize("#loader-1")
'	Dim mStyle As Map = CreateMap()
'	mStyle.Put("display", "none")
'	lEL.SetStyle(BANano.ToJson(mStyle))
'End Sub

Sub ListIndexOf(lst As List, prop As String, value As String) As Int
	value = CStr(value)
	Dim lstCnt As Int = 0
	Dim lstTot As Int = lst.Size - 1
	Dim rec As Map = CreateMap()
	Dim pos As Int = -1
	For lstCnt = 0 To lstTot
		rec = lst.Get(lstCnt)
		If rec.ContainsKey(prop) Then
			Dim v As String = rec.get(prop)
			v = CStr(v)
			If v.EqualsIgnoreCase(value) Then
				pos = lstCnt
				Exit
			End If
		End If
	Next
	Return pos
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


'
'Sub TableExists(tblName As String) As Boolean
'	Return tables.ContainsKey(tblName)
'End Sub
'
'Sub FormExists(tblName As String) As Boolean
'	Return forms.ContainsKey(tblName)
'End Sub
'
'Sub HintExists(tblName As String) As Boolean
'	Return hints.ContainsKey(tblName)
'End Sub

Sub CamelCase(idName As String) As String						'ignoredeadcode
	idName = idName.trim
	If idName = "" Then Return ""
	Dim ls As StringBuilder
	ls.Initialize
	Dim slen As Int = idName.Length
	Dim i As Int = 0
	For i = 0 To slen - 1
		Dim mout As String = idName.CharAt(i)
		If "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".IndexOf(mout) = -1 Then
			ls.Append("-")
		Else
			ls.Append(mout)
		End If
	Next
	Dim sname As String = ls.tostring
	ls.Initialize
	sname = ProperSubName(sname, False)
	Return sname
End Sub

Sub CamelCaseOthers(vx As String) As String
	vx = vx.Replace(":", "-")
	vx = vx.Replace(".", "-")
	Dim varList As List = StrParse("-", vx)
	Dim varTot As Int = varList.Size - 1
	Dim varCnt As Int
	'
	Dim varItem As String = varList.Get(varCnt)
	varItem = varItem.tolowercase
	varList.Set(varCnt, varItem)
	For varCnt = 1 To varTot
		Dim varItem As String = varList.Get(varCnt)
		varItem = ProperCase(varItem)
		varList.Set(varCnt, varItem)
	Next
	Dim subName1 As String = Join("",varList)
	Return subName1
End Sub

'use space
Sub DeCamelCaseSpace(st As String) As String
	If st.Length = 0 Then Return ""
	st = CamelCase(st)
	Dim k As Int
	Dim s As String
	Dim newst As String = st.CharAt(0)
	For i = 1 To st.Length - 1
		s = st.CharAt(i)
		k = Asc(s)
		If k>64 And k < 91 And st.CharAt(i-1) <> " " Then
			newst = newst & " " & s
		Else
			newst = newst & s
		End If
	Next
	Return newst
End Sub

'
''beautify source code
'Public Sub BeautifyB4X(sc As String) As Boolean
'	Dim lines As List = StrParse(CRLF, sc)
'	Dim nIndent As Int
'	Dim nLine As Int
'	Dim strNewLine As String
'	For nLine = 0 To lines.Size - 1
'		strNewLine = lines.get(nLine)
'		If IsBlockEnd(strNewLine) Then nIndent = nIndent - 1
'		If nIndent < 0 Then nIndent = 0
'		' Put back new line.
'		Dim xLine As String = Space(nIndent * 4) & strNewLine
'		lines.Set(nLine, xLine)
'		If IsBlockStart(strNewLine) Then nIndent = nIndent + 1
'	Next
'	Dim sout As String = Join(CRLF, lines)
'	Return sout
'End Sub
'
''download a text file
'Sub DownloadTextFile(content As String, fileName As String)
'	'load the file when it needs to be used
'	content = content.Replace("~","$")
'	Dim fc As List
'	fc.Initialize
'	fc.Add(content)
'	Dim blob As BANanoObject
'	blob.Initialize2("Blob",Array(fc, CreateMap("type": "text/plain;charset=utf-8")))
'	BANano.RunJavascriptMethod("saveAs",Array(blob,fileName))
'End Sub
'
'Sub PrettierCode(code As String) As String
'	Dim Prettier As BANanoObject = BANano.window.GetField("prettier")
'	'
'	Dim soutput As String = ""
'	soutput = Prettier.RunMethod("format", Array(code)).Result
'	Return soutput
'End Sub

Sub Space(HM As Int) As String
	Dim RS As String = ""
	Do While Len(RS) < HM
		RS = RS & " "
	Loop
	Return RS
End Sub
'
''is block start
'Sub IsBlockStart(strLine As String) As Boolean
'	Dim bOK As Boolean
'	Dim nPos As Int
'	Dim strTemp As String
'	nPos = InStr1(strLine, " ") - 1
'	If nPos < 0 Then nPos = Len(strLine)
'	strTemp = Left(strLine, nPos)
'	strTemp = strTemp.tolowercase
'	Select Case strTemp
'		Case "for", "do", "while", "select", "case", "else", "#else", "try", "#region", "sub", "catch"
'			bOK = True
'		Case "if", "#if", "else", "#else"
'			'find the posiiton of then
'			Dim p1 As Int = Len(strLine)
'			p1 = BANano.parseInt(p1)
'			Dim p2 As Int = InStr1(strLine.tolowercase, " then")
'			p2 = BANano.parseInt(p2)
'			Dim p3 As Int = p2 + 4
'			p3 = BANano.parseInt(p3)
'			bOK = (p1 = p3)
'		Case "private", "public"
'			If strLine.ToLowerCase.StartsWith("private sub ") Then bOK = True
'			If strLine.ToLowerCase.StartsWith("public sub ") Then bOK = True
'	End Select
'	Return bOK
'End Sub

''is block end
'Sub IsBlockEnd(strLine As String) As Boolean
'	Dim bOK As Boolean
'	Dim nPos As Int
'	Dim strTemp As String
'	nPos = InStr1(strLine, " ") - 1
'	If nPos < 0 Then nPos = Len(strLine)
'	nPos = BANano.parseInt(nPos)
'	'
'	strTemp = Left(strLine, nPos)
'	strTemp = strTemp.ToLowerCase
'	Select Case strTemp
'		Case "next", "loop", "case", "else", "#else", "#end", "catch"
'			bOK = True
'		Case "end"
'			Dim p1 As Int = Len(strLine)
'			p1 = BANano.parseInt(p1)
'			bOK = (p1 > 3)
'	End Select
'	Return bOK
'End Sub
'
''date in YYYY-MM-DD HH:mm
'Sub TimeAgo(dt As String) As String
'	dt = CStr(dt).trim
'	If dt = "" Then Return ""
'	Dim bo As BANanoObject = BANano.RunJavascriptMethod("dayjs", Array(dt, "YYYY-MM-DD HH:mm"))
'	Dim res As String = bo.RunMethod("fromNow", Null).result
'	Return res
'End Sub
'
'Sub MakeMoney(sValue As String) As String
'	Try
'		If BANano.IsNull(sValue) Or BANano.IsUndefined(sValue) Then Return "0.00"
'		If sValue.Length = 0 Then Return "0.00"
'		If sValue.IndexOf(",") Then sValue = sValue.Replace(",","")
'		sValue = Val(sValue)
'		If sValue = "0" Then sValue = "000"
'		sValue = Round2(sValue,2)
'		Return NumberFormat2Fix(sValue, 1, 2, 2, True)
'	Catch
'		Return sValue
'	End Try
'End Sub
'
'
'Sub YYYYMMDD(sdate As String) As String
'	Return FormatDisplayDate(sdate, "YYYY-MM-DD")
'End Sub
'Sub YYYYMM(sdate As String) As String
'	Return FormatDisplayDate(sdate, "YYYY-MM")
'End Sub

'time now
Sub TimeNow() As String
	Dim lNow As Long
	Dim dt As String
	lNow = DateTime.Now
	DateTime.DateFormat = "HH:mm"
	dt = DateTime.Date(lNow)
	Return dt
End Sub
'return the current yyyy-MM-dd
Sub DateNow() As String
	Dim lNow As Long
	Dim dt As String
	lNow = DateTime.Now
	DateTime.DateFormat = "yyyy-MM-dd"
	dt = DateTime.Date(lNow)
	Return dt
End Sub
''get the date based on days added
'Sub DateOnDaysFromToday(days2Add As Int) As String
'	Dim mDateNow As String = DateNow
'	Dim res As String = DateAdd(mDateNow, days2Add)
'	Return res
'End Sub
'return the current yyyy-MM-dd HH:mm
Sub DateTimeNow() As String
	Dim lNow As Long
	Dim dt As String
	lNow = DateTime.Now
	DateTime.DateFormat = "yyyy-MM-dd HH:mm"
	dt = DateTime.Date(lNow)
	Return dt
End Sub
'date time now
Sub DateTimeNowBackUp() As String
	Dim lNow As Long
	Dim dt As String
	lNow = DateTime.Now
	DateTime.DateFormat = "yyyy-MM-dd HH-mm"
	dt = DateTime.Date(lNow)
	Return dt
End Sub
'return the current yyyy-MM-dd HH:mm:ss
Sub Now() As String
	Dim lNow As Long
	Dim dt As String
	lNow = DateTime.Now
	DateTime.DateFormat = "yyyy-MM-dd HH:mm:ss"
	dt = DateTime.Date(lNow)
	Return dt
End Sub
'long date
Sub LongDateTimeToday() As String
	DateTime.DateFormat = "yyyy-MM-dd HH:mm"
	Dim dt As Long = DateTime.now
	DateTime.DateFormat = "dd/MM/yyyy, HH:mm"
	Return DateTime.Date(dt)
End Sub

Sub GetWorkingDates(startDate As String, endDate As String) As List
	DateTime.DateFormat = "yyyy-MM-dd"
	' Initialize the list to hold working dates
	Dim workingDates As List
	workingDates.Initialize

	' Parse the start and end dates
	Dim sd As Long = DateTime.DateParse(startDate)
	Dim ed As Long = DateTime.DateParse(endDate)

	' Loop through all dates from start to end
	For i = sd To ed Step DateTime.TicksPerDay
		' Get the day of the week (1=Sunday, 7=Saturday)
		Dim dayOfWeek As Int = DateTime.GetDayOfWeek(i)

		' Check if it's a working day (Monday to Friday)
		If dayOfWeek <> 1 And dayOfWeek <> 7 Then
			' Add the date to the list
			workingDates.Add(DateTime.Date(i))
		End If
	Next

	Return workingDates
End Sub

Sub GetWeekEnds(startDate As String, endDate As String) As List
	DateTime.DateFormat = "yyyy-MM-dd"
	' Initialize the list to hold working dates
	Dim workingDates As List
	workingDates.Initialize

	' Parse the start and end dates
	Dim sd As Long = DateTime.DateParse(startDate)
	Dim ed As Long = DateTime.DateParse(endDate)

	' Loop through all dates from start to end
	For i = sd To ed Step DateTime.TicksPerDay
		' Get the day of the week (1=Sunday, 7=Saturday)
		Dim dayOfWeek As Int = DateTime.GetDayOfWeek(i)

		' Check if it's a working day (Monday to Friday)
		If dayOfWeek = 1 Or dayOfWeek = 7 Then
			' Add the date to the list
			workingDates.Add(DateTime.Date(i))
		End If
	Next
	Return workingDates
End Sub

'open a url on a blank window
Sub OpenURLTab(url As String)			'ignoredeadcode
	Dim bo As BANanoObject = BANano.Window.RunMethod("open", Array(url, "_blank"))
	bo.RunMethod("focus", Null)
End Sub

Sub OpenURLTarget(url As String, target As String)
	Dim bo As BANanoObject = BANano.Window.RunMethod("open", Array(url, target))
	bo.RunMethod("focus", Null)
End Sub

'open whatsapp using the telephone number
'include country code with + on number
Sub OpenURLWhatsApp(tel As String)
	OpenURLTab($"https://api.whatsapp.com/send?phone=${tel}"$)
End Sub

Sub OpenURLWhatsAppText(tel As String, text As String)
	OpenURLTab($"https://api.whatsapp.com/send?phone=${tel}&text=${text}"$)
End Sub

'place a call using a number
'include country code with + on number
Sub OpenURLTel(tel As String)
	OpenURLTab($"tel:${tel}"$)
End Sub

Sub GeneratePassword(plength As Int, includeLowercase As Boolean,  includeUppercase As Boolean, includeNumbers As Boolean, includeSpecialChars As Boolean) As String				'ignoredeadcode
	Dim uppercaseArray() As String = Array As String ("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z")
	Dim lowercaseArray() As String = Array As String ("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
	Dim numbersArray()   As String = Array As String ("0","1","2","3","4","5","6","7","8","9")
	Dim symbolsArray() As String = Array As String ("@", "#", "$", "!", "^", "*", "(", ")", "_", "+", "[", "]", "{", "}", "|", ";", ":", ".")
	'
	Dim charList As List
	charList.Initialize
  
	If includeNumbers  Then charList.AddAll(numbersArray)
	If includeLowercase Then charList.AddAll(lowercaseArray)
	If includeUppercase Then charList.AddAll(uppercaseArray)
	If includeSpecialChars Then charList.AddAll(symbolsArray)

	Dim newPassword As StringBuilder
	newPassword.Initialize
  
	For i = 1 To plength
		newPassword.Append(charList.Get(Rnd(0, charList.Size)))
	Next
	Return newPassword.ToString
End Sub

Sub RunMethodByID(sID As String, sEvent As String)
	sID = CleanID(sID)
	Dim mElement As BANanoElement = BANano.GetElement($"#${sID}"$)
	If mElement = Null Then Return
	mElement.RunMethod(sEvent, Null)
End Sub

Sub SetToolTipByID(sID As String, tooltip As String, tooltipPosition As String)
	sID = CleanID(sID)
	Dim mElement As BANanoElement = BANano.GetElement($"#{sid}"$)
	If mElement = Null Then Return
	mElement.SetAttr("data-tip", tooltip)
	AddClass(mElement, $"tooltip tooltip-${tooltipPosition}"$)
End Sub

Sub SetToolTip(mElement As BANanoElement, tooltip As String, tooltipPosition As String)
	If mElement = Null Then Return
	mElement.SetAttr("data-tip", tooltip)
	AddClass(mElement, $"tooltip tooltip-${tooltipPosition}"$)
End Sub

'KB
Sub ToKiloBytes(kbSize As Int) As Int
	Dim maxs As Int = BANano.parseInt(kbSize) * 1024
	Return maxs
End Sub

'b
Sub ToBytes(kbSize As Int) As Long
	Dim maxs As Long = (BANano.parseInt(kbSize) * 1024) * 1024
	Return maxs
End Sub

Sub dataURLToBlob(dataURL As String) As Object
	Dim blob As Object = BANano.Await(BANano.RunJavascriptMethod("dataURLToBlob", Array(dataURL)))
	Return blob
End Sub

Sub dataURLtoFile(dataURL As String, fileName As String) As Object
	Dim fo As Object = BANano.Await(BANano.RunJavascriptMethod("dataURLtoFile", Array(dataURL, fileName)))
	Return fo
End Sub

Sub fileToDataURL(fileObj As Object) As String
	Dim fo As Object = BANano.Await(BANano.RunJavascriptMethod("fileToDataURL", Array(fileObj)))
	Return fo
End Sub

Sub CompressBase64(dataURL As String) As String
	Dim LZString As BANanoObject
	LZString.Initialize("LZString")
	Dim res As String = LZString.RunMethod("compressToBase64", dataURL).result
	Return res
End Sub

Sub DeCompressBase64(dataURL As String) As String
	Dim LZString As BANanoObject
	LZString.Initialize("LZString")
	Dim res As String = LZString.RunMethod("decompressFromBase64", dataURL).result
	Return res
End Sub
'
'Sub PakoCompressBase64(dataURL As String) As String
'	Dim res As String = BANano.RunJavascriptMethod("PakoCompressBase64", Array(dataURL))
'	Return res
'End Sub
'
'Sub PakoDeCompressBase64(dataURL As String) As String
'	Dim res As String = BANano.RunJavascriptMethod("PakoDecompressBase64", Array(dataURL))
'	Return res
'End Sub

'get start and end dates of a month based on date
Sub GetMonthStartEnd(dateString As String) As List
	dateString = dateString.trim
	' Parse the input date string to extract year, month, and day
	Dim syear As String = MvField(dateString,1,"-")
	Dim smonth As String = MvField(dateString,2,"-")
	
	' Set the calendar to the first day of the given month
	Dim startDate As Long
	DateTime.DateFormat = "yyyy-MM-dd"
	startDate = DateTime.DateParse(syear & "-" & smonth & "-01")
    
	' Calculate the end date by finding the first day of the next month, then subtracting one day
	Dim nextMonth As Int = BANano.parseInt(smonth) + 1
	Dim nextYear As Int = BANano.parseInt(syear)
    
	If nextMonth > 12 Then
		nextMonth = 1
		nextYear = BANano.parseInt(syear) + 1
	End If
    
	Dim endDate As Long
	endDate = DateTime.DateParse(nextYear & "-" & nextMonth & "-01") - DateTime.TicksPerDay
    
	' Format the start and end dates back to "yyyy-MM-dd" format
	Dim startDateString As String = DateTime.Date(startDate)
	Dim endDateString As String = DateTime.Date(endDate)
    
	' Create a list to return the start and end dates
	Dim result As List
	result.Initialize
	result.Add(startDateString)
	result.Add(endDateString)
    
	Return result
End Sub

Sub StrMid1(Text As String, Start As Int, iLength As Int) As String
	Return Text.SubString2(Start-1,Start+iLength-1)
End Sub

Sub GetGenderFromRSAID(IDNumber As String) As String
	IDNumber = PadRight(IDNumber, 13, "0")
	Dim seq As Int = IDNumber.SubString2(6, 10)
	seq = CInt(seq)
	If (seq >= 0) And (seq <= 4999) Then
		Return "Female"
	Else If (seq >= 5000) And (seq <= 9999) Then
		Return "Male"
	Else
		Return "Unknown"
	End If
End Sub

Sub IsValidRSAID_Luhn(IDNumber As String) As Boolean
	If IDNumber.Length <> 13 Then
		IDNumber = PadRight(IDNumber, 13, "0")
	End If
	Dim sum As Int = 0
	Dim doubleDigit As Boolean = False
	For i = IDNumber.Length - 1 To 0 Step -1
		Dim digit As Int = Asc(IDNumber.CharAt(i)) - 48
		If doubleDigit Then
			digit = digit * 2
			If digit > 9 Then digit = digit - 9
		End If
		sum = sum + digit
		doubleDigit = Not(doubleDigit)
	Next
	Return (sum Mod 10 = 0)
End Sub

'Sub ExtractDateOfBirthFromRSAID(idNumber As String) As String
'	If idNumber.Length <> 13 Then
'		idNumber = PadRight(idNumber, 13, "0")
'	End If
'	Dim iyear As String = Left(idNumber,2)
'	Dim imonth As String = StrMid1(idNumber,3,2)
'	Dim iday As String = StrMid1(idNumber,5,2)
'	'
'	Dim dateObj As BANanoObject
'	dateObj.Initialize2("Date", $"${iyear}-${imonth}-${iday}"$)
'	Dim yyyy As String = dateObj.RunMethod("getFullYear", Null).result
'	Dim mm As Int = dateObj.RunMethod("getMonth", Null).result
'	Dim dd As String = dateObj.RunMethod("getDate", Null).result
'	mm = BANano.parseInt(mm) + 1
'	mm = PadRight(mm, 2, "0")
'	dd = PadRight(dd, 2, "0")
'	'
'	Select Case yyyy
'	Case "1900"
'		yyyy = "2000"
'	Case "1901"
'		yyyy = "2001"
'	Case "1902"
'		yyyy = "2002"
'	Case "1903"
'		yyyy = "2003"
'	Case "1904"
'		yyyy = "2004"
'	Case "1905"
'		yyyy = "2005"
'	Case "1906"
'		yyyy = "2006"
'	Case "1907"
'		yyyy = "2007"
'	Case "1908"
'		yyyy = "2008"
'	Case "1909"
'		yyyy = "2009"
'	End Select
'	Dim nDate As String = $"${yyyy}-${mm}-${dd}"$
'	Return nDate
'End Sub
'
'Sub CalculateAge(birthDateString As String) As Int
'	If birthDateString = "" Then Return 0
'	Dim sToday As String = DateNow
'	Dim dyears As Int = YearDiff(sToday, birthDateString)
'	dyears = CInt(dyears)
'	dyears = Abs(dyears)
'	Return dyears
'End Sub

''date difference
'Sub DateDiff(currentDate As String, otherDate As String) As Int
'	If BANano.IsNull(currentDate) Or BANano.IsUndefined(currentDate) Then Return 0
'	If BANano.IsNull(otherDate) Or BANano.IsUndefined(otherDate) Then Return 0
'	Dim bo As BANanoObject = BANano.RunJavascriptMethod("dayjs", Array(currentDate))
'	Dim bo1 As BANanoObject = BANano.RunJavascriptMethod("dayjs", Array(otherDate))
'	'
'	Dim rslt As String = bo.RunMethod("diff", Array(bo1, "day")).Result
'	Return rslt
'End Sub
'
''year difference
'Sub YearDiff(currentDate As String, otherDate As String) As Int
'	If BANano.IsNull(currentDate) Or BANano.IsUndefined(currentDate) Then Return 0
'	If BANano.IsNull(otherDate) Or BANano.IsUndefined(otherDate) Then Return 0
'	Dim bo As BANanoObject = BANano.RunJavascriptMethod("dayjs", Array(currentDate))
'	Dim bo1 As BANanoObject = BANano.RunJavascriptMethod("dayjs", Array(otherDate))
'	'
'	Dim rslt As String = bo.RunMethod("diff", Array(bo1, "year")).Result
'	Return rslt
'End Sub
'
''month difference
'Sub MonthDiff(currentDate As String, otherDate As String) As Int
'	If BANano.IsNull(currentDate) Or BANano.IsUndefined(currentDate) Then Return 0
'	If BANano.IsNull(otherDate) Or BANano.IsUndefined(otherDate) Then Return 0
'	Dim bo As BANanoObject = BANano.RunJavascriptMethod("dayjs", Array(currentDate))
'	Dim bo1 As BANanoObject = BANano.RunJavascriptMethod("dayjs", Array(otherDate))
'	'
'	Dim rslt As String = bo.RunMethod("diff", Array(bo1, "month")).Result
'	Return rslt
'End Sub
'
''minute difference
'Sub MinuteDiff(currentDate As String, otherDate As String) As Int
'	If BANano.IsNull(currentDate) Or BANano.IsUndefined(currentDate) Then Return 0
'	If BANano.IsNull(otherDate) Or BANano.IsUndefined(otherDate) Then Return 0
'	Dim bo As BANanoObject = BANano.RunJavascriptMethod("dayjs", Array(currentDate))
'	Dim bo1 As BANanoObject = BANano.RunJavascriptMethod("dayjs", Array(otherDate))
'	'
'	Dim rslt As String = bo.RunMethod("diff", Array(bo1, "minute")).Result
'	Return rslt
'End Sub

'single quote each item on the list
Sub ListSingleQuoteItems(lst As List)
	Dim lTot As Int = lst.Size - 1
	Dim lCnt As Int
	For lCnt = 0 To lTot
		Dim lItem As String = lst.Get(lCnt)
		lItem = lItem.Replace("'", "")
		lItem = $"'${lItem}'"$
		lst.Set(lCnt, lItem)
	Next
End Sub

Sub ListDoubleQuoteItems(lst As List)
	Dim lTot As Int = lst.Size - 1
	Dim lCnt As Int
	For lCnt = 0 To lTot
		Dim lItem As String = lst.Get(lCnt)
		lItem = lItem.Replace(QUOTE, "")
		lItem = $"${QUOTE}${lItem}${QUOTE}"$
		lst.Set(lCnt, lItem)
	Next
End Sub

Sub ListToArrayVariable(lst As List) As String
	Dim lTot As Int = lst.Size - 1
	Dim lCnt As Int
	For lCnt = 0 To lTot
		Dim lItem As String = lst.Get(lCnt)
		lItem = lItem.Replace(QUOTE, "")
		lItem = $""${lItem}""$
		lst.Set(lCnt, lItem)
	Next
	Dim xs As String = Join(",", lst)
	Return xs
End Sub

'get the rest of the mv data from a particular position
Sub MvRest(delim As String, svalue As String, startPos As String) As String
	Dim spItems As List = StrParse(delim, svalue)
	Dim lst As List
	lst.initialize
	Dim rCnt As Int = startPos-1
	Dim rTot As Int = spItems.size - 1
	For rCnt = (startPos-1) To rTot
		lst.Add(spItems.Get(rCnt))
	Next
	Return Join(delim,lst)
End Sub

Sub ReadTextFileFromAssets(fn As String) As String
	Dim fileContents As String = BANano.Await(BANano.GetFileAsText($"${fn}?${DateTime.now}"$, Null, "utf8"))
	Return fileContents
End Sub

Sub ReadJSONFileFromAssets(fn As String) As Object
	Dim fileContents As String = BANano.Await(BANano.GetFileAsJSON($"${fn}?${DateTime.now}"$, Null))
	Return fileContents
End Sub

Sub ReadBase64FileFromAssets(fn As String) As Object
	Dim fileContents As String = BANano.Await(BANano.GetFileAsDataURL($"${fn}?${DateTime.now}"$, Null))
	Return fileContents
End Sub

''add app.UsesAES
'Sub AESEncrypt(v As String, s As String) As String
'	If BANano.AssetsIsDefined("Crypto") = False Then
'		BANano.Throw($"Uses Error: 'BANano.Await(app.UsesAES)' should be added!"$)
'		Return Me
'	End If
'	Dim CryptoJS As BANanoObject
'	CryptoJS.Initialize("CryptoJS")
'	
'	Dim o As BANanoObject = CryptoJS.GetField("AES").RunMethod("encrypt", Array(v, s))
'	Dim i As String = o.RunMethod("toString", Null).Result
'	Return i
'End Sub
'
''add app.UsesAES
'Sub AESDecrypt(v As String, s As String) As String
'	If BANano.AssetsIsDefined("Crypto") = False Then
'		BANano.Throw($"Uses Error: 'BANano.Await(app.UsesAES)' should be added!"$)
'		Return Me
'	End If
'	Dim CryptoJS As BANanoObject
'	CryptoJS.Initialize("CryptoJS")
'	Dim bytes As BANanoObject = CryptoJS.GetField("AES").RunMethod("decrypt", Array(v, s))
'	'
'	Dim k As BANanoObject = CryptoJS.GetField("enc").GetField("Utf8")
'	'
'	Dim i As String = bytes.RunMethod("toString", k).Result
'	Return i
'End Sub

Sub GetString(m As Map, fld As String) As String
	Dim x As String = m.Get(fld)
	x = CStr(x)
	Return x
End Sub

Sub GetBoolean(m As Map, fld As String) As Boolean
	Dim x As Boolean = m.Get(fld)
	x = CBool(x)
	Return x
End Sub

Sub GetInt(m As Map, fld As String) As Int
	Dim x As Int = m.Get(fld)
	x = CInt(x)
	Return x
End Sub

Sub GetDouble(m As Map, fld As String) As Double
	Dim x As Int = m.Get(fld)
	x = CDbl(x)
	Return x
End Sub

Sub GetLong(m As Map, fld As String) As Long
	Dim x As Int = m.Get(fld)
	x = CInt(x)
	Return x
End Sub

'create a list from map specific properties
Sub MapPropertiesToList(m As Map, props As List) As List
	Dim lst As List
	lst.Initialize
	For Each k As String In props
		If m.ContainsKey(k) Then
			Dim v As Object = m.Get(k)
			lst.Add(v)
		End If
	Next
	Return lst
End Sub

Sub MapKeysToList(m As Map) As List
	Dim lst As List
	lst.Initialize
	For Each k As String In m.Keys
		lst.Add(k)
	Next
	Return lst
End Sub

Sub MapValuesToList(m As Map) As List
	Dim lst As List
	lst.Initialize
	For Each k As String In m.Values
		lst.Add(k)
	Next
	Return lst
End Sub

Sub LoadAssetsOnDemand(Key As String, Items As List)
	'already loaded, return
	If BANano.AssetsIsDefined(Key) Then Return
	'
	Dim iTot As Int = Items.size - 1
	Dim iCnt As Int = 0
	For iCnt = 0 To iTot
		Dim fn As String = Items.Get(iCnt)
		If fn.EndsWith(".js") Then
			If fn.StartsWith("./scripts/") = False Then
				Items.Set(iCnt, $"./scripts/${fn}"$)
			End If
		End If
		If fn.EndsWith(".css") Then
			If fn.StartsWith("./styles/") = False Then
				Items.Set(iCnt, $"./styles/${fn}"$)
			End If
		End If
	Next
	Dim pathsNotFound() As String
	'load the assets
	pathsNotFound = BANano.AssetsLoadWait(Key, Items)
	If BANano.IsNull(pathsNotFound) = False Then
		BANano.Console.Warn($"${Key} not fully loaded..."$)
		For Each path As String In pathsNotFound
			Log(path)
		Next
	End If
End Sub


'year now
Sub YearNow() As String
	Dim lNow As Long
	Dim dt As String
	lNow = DateTime.Now
	DateTime.DateFormat = "yyyy"
	dt = DateTime.Date(lNow)
	Return dt
End Sub

'month now
Sub MonthNow() As String
	Dim lNow As Long
	Dim dt As String
	lNow = DateTime.Now
	DateTime.DateFormat = "MM"
	dt = DateTime.Date(lNow)
	Return dt
End Sub

Sub ConvertMinutesToHours(totalMinutes As Int) As String
	totalMinutes = BANano.parseInt(totalMinutes)
	Dim hours As Int = Floor(totalMinutes / 60)
	Dim minutes As Int = totalMinutes Mod 60
	Dim sout As String = $"${hours}:${minutes}"$
	Return sout
End Sub

Sub ConvertHoursToMinutes(hours As String) As Int
	If hours.IndexOf(":") > -1 Then
		' Input is in "HH:mm" format
		Dim parts() As String = BANano.Split(":", hours)
		If parts.Length = 2 Then
			Dim hoursPart As Int
			Dim minutesPart As Int
			hoursPart = CInt(parts(0))
			minutesPart = CInt(parts(1))
            
			Dim totalMinutes As Int
			totalMinutes = BANano.parseInt(hoursPart) * 60
			totalMinutes = BANano.parseInt(totalMinutes) + minutesPart
            
			Return totalMinutes
		Else
			Log("Invalid input format. Expected HH:mm")
			Return -1 ' or any suitable error handling
		End If
	Else
		' Input is a plain number representing hours
		Try
			Dim hoursAsInt As Int
			hoursAsInt = CInt(hours)
			Return hoursAsInt
		Catch
			Return -1 ' or any suitable error handling
		End Try
	End If
End Sub

''calculate the time added between 2 times
'Sub TimeAdd(currentTime As String, minutes2Add As String) As String
'	currentTime = CStr(currentTime)
'	minutes2Add = CStr(minutes2Add)
'	minutes2Add = ConvertHoursToMinutes(minutes2Add)
'	minutes2Add = CStr(minutes2Add)
'	'parse the current time
'	Dim ctObject As BANanoObject = BANano.RunJavascriptMethod("dayjs", Array($"2000-01-01 ${currentTime}"$))
'	'add the specified minutes
'	Dim rsObject As BANanoObject = ctObject.RunMethod("add", Array(minutes2Add, "minute"))
'	Dim sTime As String = rsObject.RunMethod("format", Array("HH:mm")).Result
'	Return sTime
'End Sub
'
''calculate the time added between 2 times
'Sub TimeAdd1(currentDate As String, currentTime As String, minutes2Add As String) As String
'	currentTime = CStr(currentTime)
'	minutes2Add = CStr(minutes2Add)
'	minutes2Add = ConvertHoursToMinutes(minutes2Add)
'	minutes2Add = CStr(minutes2Add)
'	'parse the current time
'	Dim ctObject As BANanoObject = BANano.RunJavascriptMethod("dayjs", Array($"${currentDate} ${currentTime}"$))
'	'add the specified minutes
'	Dim rsObject As BANanoObject = ctObject.RunMethod("add", Array(minutes2Add, "minute"))
'	Dim sTime As String = rsObject.RunMethod("format", Array("YYYY-MM-DD HH:mm")).Result
'	Return sTime
'End Sub


'add months to date
Sub MonthAdd(mDate As String, HowManyMonths As Int) As String
	DateTime.DateFormat = "yyyy-MM-dd"
	HowManyMonths = CInt(HowManyMonths)
	Dim ConvertDate, NewDateDay As Long
	ConvertDate = DateTime.DateParse(mDate)
	NewDateDay = DateTime.Add(ConvertDate, 0, HowManyMonths, 0)
	Return DateTime.Date(NewDateDay)
End Sub
'add years to date
Sub YearsAdd(mDate As String, HowManyYears As Int) As String
	DateTime.DateFormat = "yyyy-MM-dd"
	HowManyYears = CInt(HowManyYears)
	Dim ConvertDate, NewDateDay As Long
	ConvertDate = DateTime.DateParse(mDate)
	NewDateDay = DateTime.Add(ConvertDate, HowManyYears, 0, 0)
	Return DateTime.Date(NewDateDay)
End Sub
'Returns the number of days that have passed between two dates.
'Pass the dates as a String
Sub NumberOfDaysBetweenDates(CurrentDate As String, OtherDate As String) As Int
	DateTime.DateFormat = "yyyy-MM-dd"
	Dim CurrDate, OthDate As Long
	CurrDate = DateTime.DateParse(CurrentDate)
	OthDate = DateTime.DateParse(OtherDate)
	Dim tpd As Long = DateTime.TicksPerDay
	Dim iOut As Long = (CurrDate - OthDate)/tpd
	Return iOut
End Sub
Sub PeriodBetweenInDays(CurrentDate As String, OtherDate As String) As Int
	DateTime.DateFormat = "yyyy-MM-dd"
	Dim CurrDate, OthDate As Long
	CurrDate = DateTime.DateParse(CurrentDate)
	OthDate = DateTime.DateParse(OtherDate)
	Dim tpd As Long = DateTime.TicksPerDay
	Dim iOut As Long = (CurrDate - OthDate)/tpd
	Return iOut
End Sub

''calculate the time difference between 2 times
'Sub TimeDiff(startTime As String, endTime As String) As String
'	startTime = CStr(startTime)
'	endTime = CStr(endTime)
'	Dim ot As BANanoObject = BANano.RunJavascriptMethod("dayjs", Array($"2000-01-01 ${startTime}"$, "HH:mm"))
'	Dim nt As BANanoObject = BANano.RunJavascriptMethod("dayjs", Array($"2000-01-01 ${endTime}"$, "HH:mm"))
'	Dim sTime As String = nt.RunMethod("diff", Array(ot, "minute")).Result
'	Dim xtime As String = ConvertMinutesToHours(CInt(sTime))
'	Return xtime
'End Sub