B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
#IgnoreWarnings:12
#Event: Change (e As BANanoEvent)
#Event: Click (e As BANanoEvent)
#DesignerProperty: Key: AutoID, DisplayName: Auto ID/Name, FieldType: Boolean, DefaultValue: True, Description: Overrides the ID/Name with a random string. If true, you CANNOT use it in your code!
#DesignerProperty: Key: Absolute, DisplayName: Absolute, FieldType: Boolean, DefaultValue: False, Description: Place component as it appears in the design
#DesignerProperty: Key: ParentID, DisplayName: ParentID, FieldType: String, DefaultValue: , Description: The ParentID of this component
#DesignerProperty: Key: CustomTag, DisplayName: Tag, FieldType: String, DefaultValue: div, Description: Custom HTML Tag
#DesignerProperty: Key: Color, DisplayName: Text Color, FieldType: String, DefaultValue: , Description: Text Color
#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: String, DefaultValue: , Description: Background Color
#DesignerProperty: Key: Border, DisplayName: Border, FieldType: String, DefaultValue: , Description: Border
#DesignerProperty: Key: Text, DisplayName: Text, FieldType: String, DefaultValue: , Description: Text
#DesignerProperty: Key: MarginAXYTBLR, DisplayName: Margins, FieldType: String, DefaultValue: a=?; x=?; y=?; t=?; b=?; l=?; r=? , Description: Margins A(all)-X(LR)-Y(TB)-T-B-L-R
#DesignerProperty: Key: PaddingAXYTBLR, DisplayName: Paddings, FieldType: String, DefaultValue: a=?; x=?; y=?; t=?; b=?; l=?; r=? , Description: Paddings A(all)-X(LR)-Y(TB)-T-B-L-R
#DesignerProperty: Key: RawClasses, DisplayName: Classes (;), FieldType: String, DefaultValue: , Description: Classes added to the HTML tag.
#DesignerProperty: Key: RawStyles, DisplayName: Styles (:;), FieldType: String, DefaultValue: , Description: Styles added to the HTML tag. Must be a json String use = and ;
#DesignerProperty: Key: RawAttributes, DisplayName: Attributes, FieldType: String, DefaultValue: , Description: Attributes added to the HTML tag. Must be a json String use = and ;
'global variables in this module
Sub Class_Globals
    Public CustProps As Map 'ignore
    Private mCallBack As Object 'ignore
    Private mEventName As String 'ignore
    Private mElement As BANanoElement 'ignore
    Private mTarget As BANanoElement 'ignore
    Private mName As String 'ignore
    Private BANano As BANano   'ignore
    Private mClasses As String
    Private mStyles As String
    Private mAttributes As String
    Private mMarginAXYTBLR As String
    Private mPaddingAXYTBLR As String
    Private mParentID As String
    Private sText As String = ""
    Public Tag As Object
    Private sBackgroundColor As String = ""
    Private sBorder As String = ""
    Private sCustomTag As String = ""
	Private sColor As String = ""
	Private bAbsolute As Boolean
End Sub
'initialize the custom view class
Public Sub Initialize (Callback As Object, Name As String, EventName As String)
	mEventName = CleanID(EventName)
    mName = CleanID(Name)
    mCallBack = Callback
    CustProps.Initialize
End Sub
' returns the BANanoElement
Public Sub getElement() As BANanoElement
    Return mElement
End Sub
' returns the element id
Public Sub getID() As String
    Return mName
End Sub
'add this element to an existing parent element
Public Sub AddToParent(targetID As String, props As Map)
    targetID = CleanID(targetID)
    mTarget = BANano.GetElement("#" & targetID)
    DesignerCreateView(mTarget, props)
End Sub
'remove this element from the dom
Public Sub Remove()
    mElement.Remove
    BANano.SetMeToNull
End Sub
'assign another element to this element
Sub setElement(e As BANanoElement)
    mElement = e
End Sub
'empty the element and remove all children
Sub Clear
    If mElement <> Null Then mElement.Empty
End Sub
'append the specified html to the element
Sub Append(tmp As Object)
    If mElement <> Null Then mElement.Append(tmp)
End Sub
'clear and replace the html of this element
Sub SetHTML(sHTML As String)
    If mElement <> Null Then mElement.SetHTML(sHTML)
End Sub
'execute getElementByID on the existing element
Sub LinkExisting
    mElement.Initialize($"#${mName}"$)
End Sub
'trigger an event on the element
Public Sub TriggerEvent(event As String, params() As String)
    If mElement <> Null Then
        mElement.Trigger(event, params)
    End If
End Sub
'return the #ID of the element
Public Sub getHere() As String
    Return $"#${mName}"$
End Sub
'set an attribute to the element
Sub AddAttr(attr As String, text As Object)
    If mElement <> Null Then mElement.SetAttr(attr, text)
End Sub
'set a data attribute to the element
Sub AddDataAttr(attr As String, text As String)
    If mElement <> Null Then mElement.SetData(attr, text)
End Sub
'get a data attribute of the element
Sub GetDataAttr(attr As String) As String
    If mElement <> Null Then
        Dim text As String = mElement.GetData(attr)
        Return text
    Else
        Return ""
    End If
End Sub
Sub GetAttr(attr As String) As String
    If mElement <> Null Then
        Dim text As String = mElement.GetAttr(attr)
        Return text
    Else
        Return ""
    End If
End Sub
'add a class to the element
Sub AddClass(text As String)
    If mElement <> Null Then
        Dim lst As List = StrParse(" ", text)
        For Each c As String In lst
            mElement.AddClass(c)
        Next
    End If
End Sub
'remove a class from the element
Sub RemoveClass(text As String)
    If mElement <> Null Then
        Dim lst As List = StrParse(" ", text)
        For Each c As String In lst
            mElement.RemoveClass(c)
        Next
    End If
End Sub
'add multiple attributes to the element
Sub AddAttrMap(ms As Map)
    If ms.Size = 0 Then Return
    For Each k As String In ms.Keys
        Dim v As String = ms.Get(k)
        AddAttr(k, v)
    Next
End Sub
'remove an attribute from the element
Sub RemoveAttr(attr As String)
    If mElement <> Null Then
        mElement.RemoveAttr(attr)
    End If
End Sub
'add a computed style to the element
Sub AddStyleComputed(attr As String, text As String)
    If mElement <> Null Then
        mElement.GetField("style").RunMethod("setProperty", Array(attr, text))
    End If
End Sub
'add a collection of styles to the element
Sub AddStyleMap(ms As Map)
    If ms.Size = 0 Then Return
    If mElement <> Null Then
        mElement.SetStyle(BANano.ToJson(ms))
    End If
End Sub
'add a styles to the element
Sub AddStyle(k As String, v As String)
	Dim m As Map = CreateMap()
	m.Put(k, v)
	AddStyleMap(m)
End Sub
'assign callback to "element.on()") 
Sub OnEventMethod(event As String, Module As Object, MethodName As String, args As List)
	Dim cb As BANanoObject = BANano.CallBack(Module, MethodName, BANano.Spread(args))
	If mElement <> Null Then mElement.RunMethod("on", Array(event, cb))
End Sub

Sub getthis As BANanoObject
    ' get the current class
    Dim this As BANanoObject
    this.Initialize("this")
    Return this
End Sub

'use to add an event to the element
Sub On(event As String, args As List)
    OnEvent(event, mCallBack, $"${mEventName}_${event}"$, args)
End Sub
'use to add an event to the element
Sub OnEvent(event As String, Module As Object, methodName As String, args As List)
    event = event.Replace(":","")
    event = event.Replace(".","")
    event = event.Replace("-","")
    '
    If SubExists(Module, methodName) = False Then Return
    Dim cb As BANanoObject
    cb = BANano.CallBack(Module, methodName, BANano.Spread(args))
    mElement.RemoveEventListener(event, cb, True)
    mElement.AddEventListener(event, cb, True)
End Sub
'set text
Sub setText(text As String)
    If mElement <> Null Then
        mElement.SetText(text)
    End If
End Sub
'get text
Sub getText As String
    If mElement <> Null Then
        Dim out As String = mElement.GetText
        Return out
    Else
        Return ""
    End If
End Sub
'code to design the view
Public Sub DesignerCreateView (Target As BANanoElement, Props As Map)
	'copy props to global variable
	For Each k As String In Props.Keys
		CustProps.Put(k, Props.Get(k))
	Next
	mTarget = Target
    If Props <> Null Then
        mParentID = Props.GetDefault("ParentID", "")
        mParentID = CStr(mParentID)
        mParentID = CleanID(mParentID)
        mClasses = Props.GetDefault("RawClasses", "")
        mClasses = CStr(mClasses)
        mStyles = Props.GetDefault("RawStyles", "")
        mStyles = CStr(mStyles)
        mAttributes = Props.GetDefault("RawAttributes", "")
        mAttributes = CStr(mAttributes)
        mMarginAXYTBLR = Props.GetDefault("MarginAXYTBLR","a=?; x=?; y=?; t=?; b=?; l=?; r=?")
        mMarginAXYTBLR = CStr(mMarginAXYTBLR)
        mPaddingAXYTBLR = Props.GetDefault("PaddingAXYTBLR","a=?; x=?; y=?; t=?; b=?; l=?; r=?")
        mPaddingAXYTBLR = CStr(mPaddingAXYTBLR)
        sBackgroundColor = Props.GetDefault("BackgroundColor", "")
        sBackgroundColor = CStr(sBackgroundColor)
        sBorder = Props.GetDefault("Border", "")
        sBorder = CStr(sBorder)
        sColor = Props.GetDefault("Color", "")
        sColor = CStr(sColor)
        sCustomTag = Props.GetDefault("CustomTag", "")
        sCustomTag = CStr(sCustomTag)
        sText = Props.GetDefault("Text", "")
        sText = CStr(sText)
		bAbsolute = Props.GetDefault("Absolute", False)
		bAbsolute = CBool(bAbsolute)
    End If
    '
    If mParentID <> "" Then
    	'does the parent exist
    	If BANano.Exists($"#${mParentID}"$) = False Then
    		BANano.Throw($"${mName}.DesignerCreateView: '${mParentID}' parent does not exist!"$)
    		Return
    	End If
    	mTarget.Initialize($"#${mParentID}"$)
    End If
	'End If
    Dim se As SithasoElement
    se.Initialize
    se.mClasses = mClasses
    se.mStyles = mStyles
    se.mPaddingAXYTBLR = mPaddingAXYTBLR
    se.mMarginAXYTBLR = mMarginAXYTBLR
    se.mAttributes = mAttributes
    If sBackgroundColor <> "" Then se.AddStyle("background-color", sBackgroundColor)
    If sBorder <> "" Then se.AddStyle("border", sBorder)
    If sColor <> "none" Then se.AddStyle("color", sColor)
	If bAbsolute Then
		Dim iB4XHAnchor As Int = Props.Get("B4XHAnchor")
		Dim iB4XVAnchor As Int = Props.Get("B4XVAnchor")
		se.AddStyle("position", "absolute")
		se.AddStyle("top", Props.Get("B4XTop") & "px")
		se.AddStyle("left", Props.Get("B4XLeft") & "px")
		'If iB4XHAnchor = 0 And iB4XVAnchor = 0 Then
			se.AddStyle("height", Props.Get("B4XHeight") & "px")
			se.AddStyle("width", Props.Get("B4XWidth") & "px")
		'End If
	End If
    se.BuildAttr
    mElement = mTarget.Append($"[BANCLEAN]<${sCustomTag} id="${mName}" ${se.exAttrs} ${se.exAttrs1}>${sText}</${sCustomTag}>"$).Get("#" & mName)
    '
	Dim e As BANanoEvent
    On("change", Array(e))
    On("click", Array(e))
End Sub

Sub getB4XEnabled As Boolean
	Return CustProps.Get("B4XEnabled")
End Sub

Sub getB4XVisible As Boolean
	Return CustProps.Get("B4XVisible")
End Sub

Sub getB4XVAnchor As String
	Return CustProps.Get("B4XVAnchor")
End Sub

Sub getB4XHAnchor As String
	Return CustProps.Get("B4XHAnchor")
End Sub

Sub getB4xHeight As String
	Return CustProps.Get("B4XHeight") & "px"
End Sub

Sub getB4XWidth As String
	Return CustProps.Get("B4XWidth") & "px"
End Sub

Sub getB4XTop As String
	Return CustProps.Get("B4XTop") & "px"
End Sub

Sub getB4XLeft As String
	Return CustProps.Get("B4XLeft") & "px"
End Sub

'set Background Color
Sub setBackgroundColor(s As String)
    sBackgroundColor = s
    CustProps.put("BackgroundColor", s)
    If s <> "" Then AddStyle("background-color", s)
End Sub

'set Border
Sub setBorder(s As String)
    sBorder = s
    CustProps.put("Border", s)
    If s <> "" Then AddStyle("border", s)
End Sub

'set Custom Tag
Sub setCustomTag(s As String)
    sCustomTag = s
    CustProps.put("CustomTag", s)
End Sub

'get Background Color
Sub getBackgroundColor As String
    Return sBackgroundColor
End Sub

'get Border
Sub getBorder As String
    Return sBorder
End Sub


'******
private Sub CleanID(s As String) As String
	s = CStr(s)
	s = s.tolowercase
	s = s.Replace("#", "")
	s = s.Replace(" ", "")
	s = s.Trim
	Return s
End Sub

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

private Sub CStr(o As Object) As String
	If BANano.isnull(o) Or BANano.IsUndefined(o) Then o = ""
	If o = "null" Then Return ""
	If o = "undefined" Then Return ""
	Return "" & o
End Sub

private Sub CBool(v As Object) As Boolean
	If BANano.IsNull(v) Or BANano.IsUndefined(v) Then
		v = False
	End If
	If GetType(v) = "string" Or GetType(v) = "object" Then
		Dim s As String = v & ""
		s = s.tolowercase
		If s = "" Then Return False
		If s = "false" Then Return False
		If S = "true" Then Return True
		If s = "1" Then Return True
		If s = "y" Then Return True
		If s = "0" Then Return False
		If s = "n" Then Return False
		If s = "no" Then Return False
		If s = "yes" Then Return True
	End If
	Return v
End Sub

'convert to int
private Sub CInt(o As Object) As Int
	o = Val(o)
	Return BANano.parseInt(o)
End Sub

private Sub Val(value As String) As String
	value = CStr(value)
	value = value.Trim
	If value = "" Then value = "0"
	If isNaN(value) Then value = "0"
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

'check if value isNaN
private Sub isNaN(obj As Object) As Boolean
	Dim res As Boolean = BANano.Window.RunMethod("isNaN", Array(obj)).Result
	Return res
End Sub

private Sub InStr(xText As String, sFind As String) As Int
	Return xText.tolowercase.IndexOf(sFind.tolowercase)
End Sub

private Sub CDbl(o As String) As Double
	o = Val(o)
	Dim out As Double = NumberFormat(o,0,2)
	Dim nvalue As String = CStr(out)
	nvalue = nvalue.replace(",", ".")
	nvalue = Val(nvalue)
	Dim nout As Double = BANano.parseFloat(nvalue)
	Return nout
End Sub

'convert props to JSON string
Sub ToJSON As String
	Dim eHTML As String = BANano.ToJson(CustProps)
	Return eHTML
End Sub

Public Sub AddToParentJSON(targetID As String, sJSON As String)
    targetID = CleanID(targetID)
    mTarget = BANano.GetElement("#" & targetID)
	Dim props As Map = BANano.FromJson(sJSON)
    DesignerCreateView(mTarget, props)
End Sub
