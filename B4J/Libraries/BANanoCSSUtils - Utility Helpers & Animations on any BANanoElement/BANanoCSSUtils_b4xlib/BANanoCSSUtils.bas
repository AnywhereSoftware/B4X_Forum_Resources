B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
#IgnoreWarnings:12
Sub Process_Globals
	Private BANano As BANano		'ignore
	Private Module As Object
End Sub

'set the module that will be used for animations
'prefix the event with the element name
'<code>
'btnOk_Animation_Update (anim As BANanoObject)
'btnOk_Animation_Begin (anim As BANanoObject)
'btnOk_Animation_Complete (anim As BANanoObject)
'btnOk_Animation_LoopComplete (anim As BANanoObject)
'btnOk_Animation_LoopBegin (anim As BANanoObject)
'btnOk_Animation_Change
'btnOk_Animation_ChangeBegin (anim As BANanoObject)
'btnOk_Animation_ChangeComplete (anim As BananoObject)
'</code>
Sub SetModule(mCallBack As Object)
	Module = mCallBack
End Sub

Sub OnEvent(mElement As BANanoElement,event As String, mCallBack As Object, methodName As String, args As List)
	If SubExists(mCallBack, methodName) = False Then Return
	Dim cb As BANanoObject
	cb = BANano.CallBack(mCallBack, methodName, BANano.Spread(args))
	mElement.RemoveEventListener(event, cb, True)
	mElement.AddEventListener(event, cb, True)
End Sub

Public Sub SetBorder(mElement As BANanoElement, width As String, color As String, radius As String)
	Dim m As Map = CreateMap()
	m.put("border-color", color)
	M.put("border-width", width)
	M.put("border-radius", radius)
	m.Put("border-style", "solid")
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

Public Sub SetBoxShadowNone(mElement As BANanoElement)
	Dim m As Map = CreateMap()
	m.put("box-shadow", "0 0 #0000")
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

Public Sub SetBoxShadowInner(mElement As BANanoElement)
	Dim m As Map = CreateMap()
	m.put("box-shadow", "inset 0 2px 4px 0 rgb(0 0 0 / 0.05)")
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

Public Sub SetBoxShadowSM(mElement As BANanoElement)
	Dim m As Map = CreateMap()
	m.put("box-shadow", "0 1px 2px 0 rgb(0 0 0 / 0.05)")
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

Public Sub SetBoxShadowMD(mElement As BANanoElement)
	Dim m As Map = CreateMap()
	m.put("box-shadow", "0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)")
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

Public Sub SetBoxShadowLG(mElement As BANanoElement)
	Dim m As Map = CreateMap()
	m.put("box-shadow", "0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)")
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

Public Sub SetBoxShadowXL(mElement As BANanoElement)
	Dim m As Map = CreateMap()
	m.put("box-shadow", "0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1)")
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

Public Sub SetBoxShadow2XL(mElement As BANanoElement)
	Dim m As Map = CreateMap()
	m.put("box-shadow", "0 25px 50px -12px rgb(0 0 0 / 0.25)")
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

Public Sub SetBoxShadow(mElement As BANanoElement)
	Dim m As Map = CreateMap()
	m.put("box-shadow", "0 1px 3px 0 rgb(0 0 0 / 0.1), 0 1px 2px -1px rgb(0 0 0 / 0.1)")
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub


Sub FieldExists(el As BANanoElement, fldName As String) As Boolean
	If el.ToObject.GetField(fldName) = BANano.UNDEFINED Then Return False
	Return True
End Sub

Sub OnEventMethod(mElement As BANanoElement, event As String, mCallBack As Object, MethodName As String, args As List)
	Dim cb As BANanoObject = BANano.CallBack(mCallBack, MethodName, BANano.Spread(args))
	mElement.RunMethod("on", Array(event, cb))
End Sub

Public Sub SetRotate(mElement As BANanoElement, deg As String)
	Dim m As Map = CreateMap()
	m.put("rotate", $"${deg}deg"$)
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

Sub SetColorAndBorder (mElement As BANanoElement, BackGroundColor As String, BorderWidth As String, BorderColor As String, BorderCornerRadius As String)
	Dim m As Map = CreateMap()
	m.put("border-color", BorderColor)
	M.put("border-width", MakePx(BorderWidth))
	M.put("border-radius", MakePx(BorderCornerRadius))
	m.Put("border-style", "solid")
	m.put("background-color", BackGroundColor)
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

Sub SetLayout(mElement As BANanoElement, left As String, top As String, width As String, height As String)
	left = MakePx(left)
	width = MakePx(width)
	height = MakePx(height)
	top = MakePx(top)
	Dim m As Map = CreateMap()
	m.put("left", left)
	m.put("width", width)
	m.put("height", height)
	m.put("top", top)
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

Sub SetLayoutRadius(mElement As BANanoElement, left As String, top As String, width As String, height As String, radius As String)
	left = MakePx(left)
	width = MakePx(width)
	height = MakePx(height)
	top = MakePx(top)
	Dim m As Map = CreateMap()
	m.put("left", left)
	m.put("width", width)
	m.put("height", height)
	m.put("top", top)
	m.put("border-radius", radius)
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

Sub SetRadius(mElement As BANanoElement, radius As String)
	Dim m As Map = CreateMap()
	m.put("border-radius", MakePx(radius))
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

Sub SetScale(mElement As BANanoElement, scale As Double)
	Dim m As Map = CreateMap()
	m.put("scale", scale)
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

'change the font size
Sub SetTextSize(mElement As BANanoElement, size As String)
	Dim m As Map = CreateMap()
	m.put("font-size", MakePx(size))
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

'change the opacity
Sub SetVisible(mElement As BANanoElement, b As Boolean)
	Dim m As Map = CreateMap()
	If b Then
		m.Put("opacity", "1")
	Else
		m.Put("opacity", "0")
	End If	
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

'use a hex color
Sub SetBackgroundColor(mElement As BANanoElement, color As String)
	Dim m As Map = CreateMap()
	m.put("background-color", color)
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

Sub SetAlpha(mElement As BANanoElement, v As Double)
	SetStyleProperty(mElement, "opacity", v)
End Sub

public Sub SetStyleProperty(mElement As BANanoElement, key As String, value As String)
	Dim m As Map = CreateMap()
	m.put(key, value)
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

Public Sub SetBackgroundImage(mElement As BANanoElement, fileName As String)
	Dim m As Map = CreateMap()
	m.put("background-image", $"url("${fileName}")"$)
	m.Put("background-size", "contain")  'fit the image to the div
	m.Put("background-repeat", "no-repeat")
	m.Put("background-position", "center center")
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

Public Sub GetStyleProperty(mElement As BANanoElement, key As String) As Object
	If mElement <> Null Then
		Dim sout As String = mElement.GetStyle(key)
		Return sout
	Else
		Return ""
	End If		
End Sub

Sub EnsureVisible(mElement As BANanoElement)
	Dim opt As Map = CreateMap("behavior": "smooth")
	If mElement <> Null Then mElement.RunMethod("scrollIntoView", opt)
End Sub

Sub GetStyleComputed(mElement As BANanoElement, var As String) As Object
	If mElement <> Null Then
		Dim computed As BANanoObject
		computed.Initialize4("getComputedStyle", mElement.ToObject) ' note that computed is read-only!
		Return computed.RunMethod("getPropertyValue", var)
	Else
		Return ""
	End If	
End Sub

Sub SetPadding(mElement As BANanoElement, LeftM As Int, TopM As Int, RightM As Int, BottomM As Int)
	Dim m As Map = CreateMap()
	m.put("padding-left", MakePx(LeftM))
	m.put("padding-top", MakePx(TopM))
	m.put("padding-right", MakePx(RightM))
	m.put("padding-bottom", MakePx(BottomM))
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

Sub SetMargin(mElement As BANanoElement, LeftM As Int, TopM As Int, RightM As Int, BottomM As Int)
	Dim m As Map = CreateMap()
	m.put("margin-left", MakePx(LeftM))
	m.put("margin-top", MakePx(TopM))
	m.put("margin-right", MakePx(RightM))
	m.put("margin-bottom", MakePx(BottomM))
	If mElement <> Null Then mElement.SetStyle(BANano.ToJson(m))
End Sub

Sub GetPaddingLeft(mElement As BANanoElement) As String
	Return GetStyleProperty(mElement, "padding-left")
End Sub

Sub GetPaddingTop(mElement As BANanoElement) As String
	Return GetStyleProperty(mElement, "padding-top")
End Sub

Sub GetPaddingBottom(mElement As BANanoElement) As String
	Return GetStyleProperty(mElement, "padding-bottom")
End Sub

Sub GetPaddingRight(mElement As BANanoElement) As String
	Return GetStyleProperty(mElement, "padding-right")
End Sub

Sub GetMarginLeft(mElement As BANanoElement) As String
	Return GetStyleProperty(mElement, "margin-left")
End Sub

Sub GetMarginTop(mElement As BANanoElement) As String
	Return GetStyleProperty(mElement, "margin-top")
End Sub

Sub GetMarginBottom(mElement As BANanoElement) As String
	Return GetStyleProperty(mElement, "margin-bottom")
End Sub

Sub GetMarginRight(mElement As BANanoElement) As String
	Return GetStyleProperty(mElement, "margin-right")
End Sub

Sub GetTop(mElement As BANanoElement) As String
	Return GetStyleProperty(mElement, "top")
End Sub

Sub GetBottom(mElement As BANanoElement) As String
	Return GetStyleProperty(mElement, "bottom")
End Sub

Sub GetLeft(mElement As BANanoElement) As String
	Return GetStyleProperty(mElement, "left")
End Sub

Sub GetRight(mElement As BANanoElement) As String
	Return GetStyleProperty(mElement, "right")
End Sub

private Sub MakePx(sValue As String) As String
	sValue = CStr(sValue)
	sValue = sValue.trim
	If sValue = "?" Then Return sValue
	If sValue = "" Then Return sValue
	If sValue.EndsWith("%") Then
		Return sValue
	else If sValue.EndsWith("vm") Then
		Return sValue
	else If sValue.EndsWith("px") Then
		Return sValue
	else If sValue.EndsWith("cm") Then
		Return sValue
	else If sValue.EndsWith("mm") Then
		Return sValue
	else If sValue.EndsWith("in") Then
		Return sValue
	else If sValue.EndsWith("pt") Then
		Return sValue
	else If sValue.EndsWith("pc") Then
		Return sValue
	else If sValue.EndsWith("em") Then
		Return sValue
	else If sValue.EndsWith("ex") Then
		Return sValue
	else If sValue.EndsWith("ch") Then
		Return sValue
	else If sValue.EndsWith("rem") Then
		Return sValue
	else If sValue.EndsWith("vw") Then
		Return sValue
	else If sValue.EndsWith("vh") Then
		Return sValue
	else If sValue.EndsWith("vmin") Then
		Return sValue
	else If sValue.EndsWith("vmax") Then
		Return sValue
	else If sValue.EndsWith(";") Then
		Return sValue
	Else
		sValue = sValue.Replace("px","")
		sValue = $"${sValue}px"$
		If sValue = "px" Then sValue = ""
		Return sValue
	End If
End Sub

private Sub CStr(o As Object) As String
	If BANano.isnull(o) Or BANano.IsUndefined(o) Then o = ""
	If o = "null" Then Return ""
	If o = "undefined" Then Return ""
	Return "" & o
End Sub

Sub SetTop(mElement As BANanoElement, s As String)
	s = MakePx(s)
	SetStyleProperty(mElement,"top", s)
End Sub

Sub SetLeft(mElement As BANanoElement, s As String)
	s = MakePx(s)
	SetStyleProperty(mElement,"left", s)
End Sub

Sub SetWidth(mElement As BANanoElement, s As String)
	s = MakePx(s)
	SetStyleProperty(mElement,"width", s)
End Sub

Sub SetHeight(mElement As BANanoElement, s As String)
	s = MakePx(s)
	SetStyleProperty(mElement,"height", s)
End Sub

private Sub TargetID(s As String) As String
	s = CStr(s)
	s = s.tolowercase
	s = s.Replace("#", "")
	s = s.Replace(" ", "")
	s = s.Trim
	s = $"#${s}"$
	Return s
End Sub

Sub SetColorAnimated(mElement As BANanoElement,duration As Int, FromColor As String, ToColor As String) As BANanoAnimeJS
	Dim a1 As BANanoAnimeJS
	a1.Initialize(Module, "animation", TargetID(mElement.Name))
	a1.anime.duration(duration)
	a1.anime.backgroundColor1(FromColor, ToColor)
	a1.anime.easing("easeInOutQuad")
	a1.play
	Return a1
End Sub

Sub SetScaleAnimated(mElement As BANanoElement,duration As Int, FromScale As Double, ToScale As Double) As BANanoAnimeJS
	Dim a1 As BANanoAnimeJS
	a1.Initialize(Module, "animation", TargetID(mElement.Name))
	a1.anime.duration(duration)
	a1.anime.scale1(FromScale, ToScale)
	a1.anime.easing("easeInOutQuad")
	a1.play
	Return a1
End Sub

Sub SetVisibleAnimated(mElement As BANanoElement,duration As Int, b As Boolean) As BANanoAnimeJS
	Dim a1 As BANanoAnimeJS
	a1.Initialize(Module, "animation", TargetID(mElement.Name))
	a1.anime.duration(duration)
	a1.anime.visibility(b)
	a1.anime.easing("easeInOutQuad")
	a1.play
	Return a1
End Sub

Sub SetAlphaAnimated(mElement As BANanoElement,duration As Int, alpha As Double) As BANanoAnimeJS
	Dim a1 As BANanoAnimeJS
	a1.Initialize(Module, "animation", TargetID(mElement.Name))
	a1.anime.duration(duration)
	a1.anime.opacity(alpha)
	a1.anime.easing("easeInOutQuad")
	a1.play
	Return a1
End Sub

Sub SetLayoutAnimated(mElement As BANanoElement,duration As Int, left As String, top As String, width As String, height As String) As BANanoAnimeJS
	left = MakePx(left)
	width = MakePx(width)
	height = MakePx(height)
	top = MakePx(top)
	Dim a1 As BANanoAnimeJS
	a1.Initialize(Module, "animation", TargetID(mElement.Name))
	a1.anime.duration(duration)
	a1.anime.left(left)
	a1.anime.width(width)
	a1.anime.height(height)
	a1.anime.top(top)
	a1.anime.easing("easeInOutQuad")
	a1.play
	Return a1
End Sub

Sub SetLayoutAnimatedRadius(mElement As BANanoElement,duration As Int, left As String, top As String, width As String, height As String, radius As String) As BANanoAnimeJS
	left = MakePx(left)
	width = MakePx(width)
	height = MakePx(height)
	top = MakePx(top)
	Dim a1 As BANanoAnimeJS
	a1.Initialize(Module, "animation", TargetID(mElement.Name))
	a1.anime.duration(duration)
	a1.anime.left(left)
	a1.anime.width(width)
	a1.anime.height(height)
	a1.anime.top(top)
	a1.anime.borderRadius(radius)
	a1.anime.easing("easeInOutQuad")
	a1.play
	Return a1
End Sub

Sub SetWidthAnimated(mElement As BANanoElement,duration As Int, width As String) As BANanoAnimeJS
	width = MakePx(width)
	Dim a1 As BANanoAnimeJS
	a1.Initialize(Module, "animation", TargetID(mElement.Name))
	a1.anime.duration(duration)
	a1.anime.width(width)
	a1.anime.easing("easeInOutQuad")
	a1.play
	Return a1
End Sub

Sub SetHeightAnimated(mElement As BANanoElement,duration As Int, height As String) As BANanoAnimeJS
	height = MakePx(height)
	Dim a1 As BANanoAnimeJS
	a1.Initialize(Module, "animation", TargetID(mElement.Name))
	a1.anime.duration(duration)
	a1.anime.height(height)
	a1.anime.easing("easeInOutQuad")
	a1.play
	Return a1
End Sub

Sub SetRadiusAnimated(mElement As BANanoElement,duration As Int, radius As String) As BANanoAnimeJS
	radius = MakePx(radius)
	Dim a1 As BANanoAnimeJS
	a1.Initialize(Module, "animation", TargetID(mElement.Name))
	a1.anime.duration(duration)
	a1.anime.borderRadius(radius)
	a1.anime.easing("easeInOutQuad")
	a1.play
	Return a1
End Sub

Sub SetTextSizeAnimated(mElement As BANanoElement,duration As Int, textSize As String) As BANanoAnimeJS
	textSize = MakePx(textSize)
	Dim a1 As BANanoAnimeJS
	a1.Initialize(Module, "animation", TargetID(mElement.Name))
	a1.anime.duration(duration)
	a1.anime.fontSize(textSize)
	a1.anime.easing("easeInOutQuad")
	a1.play
	Return a1
End Sub

Sub SetLeftAnimated(mElement As BANanoElement,duration As Int, left As String) As BANanoAnimeJS
	left = MakePx(left)
	Dim a1 As BANanoAnimeJS
	a1.Initialize(Module, "animation", TargetID(mElement.Name))
	a1.anime.duration(duration)
	a1.anime.left(left)
	a1.anime.easing("easeInOutQuad")
	a1.play
	Return a1
End Sub

Sub SetTopAnimated(mElement As BANanoElement,duration As Int, top As String) As BANanoAnimeJS
	top = MakePx(top)
	Dim a1 As BANanoAnimeJS
	a1.Initialize(Module, "animation", TargetID(mElement.Name))
	a1.anime.duration(duration)
	a1.anime.top(top)
	a1.anime.easing("easeInOutQuad")
	a1.play
	Return a1
End Sub

Sub SetRotationAnimated(mElement As BANanoElement,duration As Int, degrees As Int) As BANanoAnimeJS
	degrees = CStr(degrees)
	Dim a1 As BANanoAnimeJS
	a1.Initialize(Module, "animation", TargetID(mElement.Name))
	a1.anime.rotate(degrees)
	a1.anime.duration(duration)
	a1.anime.easing("easeInOutQuad")
	a1.play
	Return a1
End Sub

Sub AddAttr(mElement As BANanoElement, attr As String, text As String)
	If mElement <> Null Then mElement.SetAttr(attr, text)
End Sub

Sub AddDataAttr(mElement As BANanoElement,attr As String, text As String)
	If mElement <> Null Then mElement.SetData(attr, text)
End Sub

Sub GetDataAttr(mElement As BANanoElement, attr As String) As String
	If mElement <> Null Then
		Dim text As String = mElement.GetData(attr)
		Return text
	Else
		Return ""
	End If
End Sub

Sub GetAttr(mElement As BANanoElement, attr As String) As String
	If mElement <> Null Then
		Dim text As String = mElement.GetAttr(attr)
		Return text
	Else
		Return ""
	End If
End Sub

Sub AddClass(mElement As BANanoElement, text As String)
	text = CStr(text)
	text = text.trim
	If text = "" Then Return
	If mElement <> Null Then
		Dim lst As List = StrParse(" ", text)
		For Each c As String In lst
			c = c.trim
			If c <> "" Then mElement.AddClass(c)
		Next
	End If
End Sub

Sub RemoveClass(mElement As BANanoElement, text As String)
	If mElement <> Null Then
		Dim lst As List = StrParse(" ", text)
		For Each c As String In lst
			mElement.RemoveClass(c)
		Next
	End If
End Sub

Sub AddAttrMap(mElement As BANanoElement, ms As Map)
	If ms.Size = 0 Then Return
	For Each k As String In ms.Keys
		Dim v As String = ms.Get(k)
		AddAttr(mElement,k, v)
	Next
End Sub

Sub RemoveAttr(mElement As BANanoElement, attr As String)
	If mElement <> Null Then
		mElement.RemoveAttr(attr)
	End If
End Sub

Sub AddStyleComputed(mElement As BANanoElement, attr As String, text As String)
	If mElement <> Null Then
		mElement.GetField("style").RunMethod("setProperty", Array(attr, text))
	End If
End Sub

Sub AddStyle(mElement As BANanoElement, attr As String, text As String)
	If mElement <> Null Then
		Dim m As Map = CreateMap()
		m.Put(attr, text)
		AddStyleMap(mElement, m)
	End If
End Sub

Sub AddStyleMap(mElement As BANanoElement, ms As Map)
	If ms.Size = 0 Then Return
	If mElement <> Null Then
		mElement.SetStyle(BANano.ToJson(ms))
	End If
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

public Sub SetDisabled(mElement As BANanoElement, b As Boolean)
	If mElement <> Null Then
		If b = False Then
			mElement.RemoveAttr("disabled")
		Else
			mElement.SetAttr("disabled", True)
		End If
	End If
End Sub

public Sub SetRequired(mElement As BANanoElement, b As Boolean)
	If mElement <> Null Then
		If b = False Then
			mElement.RemoveAttr("required")
		Else
			mElement.SetAttr("required", True)
		End If
	End If
End Sub

public Sub SetReadOnly(mElement As BANanoElement, b As Boolean)
	If mElement <> Null Then
		If b = False Then
			mElement.RemoveAttr("readonly")
		Else
			mElement.SetAttr("readonly", True)
		End If
	End If
End Sub

public Sub GetDisabled(mElement As BANanoElement) As Boolean
	Dim bDisabled As Boolean = mElement.hasAttr("disabled")
	Return bDisabled
End Sub

Sub ColorToHSL(n As String) As String
	Dim res As String = BANano.RunJavascriptMethod("nameToHSL", Array(n))
	Return res
End Sub

Sub ColorToHex(n As String) As String
	Dim res As String = BANano.RunJavascriptMethod("nameToHex", Array(n))
	Return res
End Sub

Sub HexToHSL(h As String) As String
	Dim res As String = BANano.RunJavascriptMethod("hexToHSL", Array(h))
	Return res
End Sub

#if javascript
function nameToHSL(name) {
  let fakeDiv = document.createElement("div");
  fakeDiv.style.color = name;
  document.body.appendChild(fakeDiv);

  let cs = window.getComputedStyle(fakeDiv),
      pv = cs.getPropertyValue("color");

  document.body.removeChild(fakeDiv);

  // Code ripped from RGBToHSL() (except pv is substringed)
  let rgb = pv.substr(4).split(")")[0].split(","),
      r = rgb[0] / 255,
      g = rgb[1] / 255,
      b = rgb[2] / 255,
      cmin = Math.min(r,g,b),
      cmax = Math.max(r,g,b),
      delta = cmax - cmin,
      h = 0,
      s = 0,
      l = 0;

  if (delta == 0)
    h = 0;
  else if (cmax == r)
    h = ((g - b) / delta) % 6;
  else if (cmax == g)
    h = (b - r) / delta + 2;
  else
    h = (r - g) / delta + 4;

  h = Math.round(h * 60);

  if (h < 0)
    h += 360;

  l = (cmax + cmin) / 2;
  s = delta == 0 ? 0 : delta / (1 - Math.abs(2 * l - 1));
  s = +(s * 100).toFixed(1);
  l = +(l * 100).toFixed(1);

  return "hsl(" + h + "," + s + "%," + l + "%)";
}

function nameToHex(name) {
  // Get RGB from named color in temporary div
  let fakeDiv = document.createElement("div");
  fakeDiv.style.color = name;
  document.body.appendChild(fakeDiv);

  let cs = window.getComputedStyle(fakeDiv),
      pv = cs.getPropertyValue("color");

  document.body.removeChild(fakeDiv);

  // Code ripped from RGBToHex() (except pv is substringed)
  let rgb = pv.substr(4).split(")")[0].split(","),
      r = (+rgb[0]).toString(16),
      g = (+rgb[1]).toString(16),
      b = (+rgb[2]).toString(16);

  if (r.length == 1)
    r = "0" + r;
  if (g.length == 1)
    g = "0" + g;
  if (b.length == 1)
    b = "0" + b;

  return "#" + r + g + b;
}

function hexToHSL(H) {
  // Convert hex to RGB first
  let r = 0, g = 0, b = 0;
  if (H.length == 4) {
    r = "0x" + H[1] + H[1];
    g = "0x" + H[2] + H[2];
    b = "0x" + H[3] + H[3];
  } else if (H.length == 7) {
    r = "0x" + H[1] + H[2];
    g = "0x" + H[3] + H[4];
    b = "0x" + H[5] + H[6];
  }
  // Then to HSL
  r /= 255;
  g /= 255;
  b /= 255;
  let cmin = Math.min(r,g,b),
      cmax = Math.max(r,g,b),
      delta = cmax - cmin,
      h = 0,
      s = 0,
      l = 0;

  if (delta == 0)
    h = 0;
  else if (cmax == r)
    h = ((g - b) / delta) % 6;
  else if (cmax == g)
    h = (b - r) / delta + 2;
  else
    h = (r - g) / delta + 4;

  h = Math.round(h * 60);

  if (h < 0)
    h += 360;

  l = (cmax + cmin) / 2;
  s = delta == 0 ? 0 : delta / (1 - Math.abs(2 * l - 1));
  s = +(s * 100).toFixed(1);
  l = +(l * 100).toFixed(1);

  //return "hsl(" + h + "," + s + "%," + l + "%)";
  return "" + h + "_" + s + "%_" + l + "%";
}

#End If

Sub GetHTML(mElement As BANanoElement) As String
	If mElement <> Null Then
		Dim tmp As String = mElement.getfield("outerHTML").Result
		Return tmp
	Else
		Return ""
	End If
End Sub

Sub Clear(mElement As BANanoElement)
	If mElement <> Null Then
		mElement.Empty
	End If
End Sub

'get element by data
Sub GetElementByData(dataattr As String, value As String) As BANanoElement
	dataattr = dataattr.tolowercase
	Dim skey As String = $"[data-${dataattr}='${value}']"$
	Dim dataId As BANanoElement
	dataId.Initialize(skey)
	Return dataId
End Sub

'insert a css rule
Sub InsertCSSRule(selector As String, styles As Object)
	BANano.RunJavascriptMethod("insertRule", Array(selector, styles))
End Sub

'remove a css rule 
Sub RemoveCSSRule(selector As String)
	Dim i As BANanoObject
	i.Initialize("insertRule")
	i.RunMethod("remove", selector)
End Sub

'get the content of a template tag
Sub GetTemplate(mElement As BANanoElement) As String
	If mElement <> Null Then
		Dim clon As BANanoObject = mElement.RunMethod("cloneNode", True)
		Dim fc As String = clon.GetField("firstElementChild").GetField("outerHTML").result
		Return fc
	Else
		Return ""
	End If		
End Sub

Sub Append(mElement As BANanoElement, content As String)
	If mElement <> Null Then
		mElement.Append(content)
	End If
End Sub

Sub SetHTML(mElement As BANanoElement, content As String)
	If mElement <> Null Then
		mElement.SetHTML(content)
	End If
End Sub

'add a class on condition
public Sub AddClassOnCondition(mElement As BANanoElement, varClass As String, varCondition As Boolean, varShouldBe As Boolean)
	varClass = CStr(varClass)
	varCondition = CBool(varCondition)
	If varCondition = varShouldBe Then AddClass(mElement, varClass)
End Sub

''add an attr on condition
'public Sub AddAttrOnCondition(mElement As BANanoElement, varClass As String, varShouldBe As Object, varCondition As Boolean)
'	varClass = CStr(varClass)
'	varCondition = CBool(varCondition)
'	If varShouldBe <> varCondition Then Return
'	AddAttr(mElement, varClass, varShouldBe)
'End Sub

''add an attr on condition
'public Sub AddStyleOnCondition(mElement As BANanoElement, varClass As String, varCondition As Boolean, varShouldBe As Object)
'	varClass = CStr(varClass)
'	varCondition = CBool(varCondition)
'	If varShouldBe <> varCondition Then Return
'	AddStyle(mElement, varClass, varCondition)
'End Sub

'public Sub AddStyleOnConditionTrue(mElement As BANanoElement, varClass As String, varCondition As Boolean, varShouldBe As Boolean)
'	varClass = CStr(varClass)
'	varCondition = CBool(varCondition)
'	If varShouldBe Then 
'		If varCondition Then AddStyle(mElement, varClass, varCondition)
'	End If
'End Sub

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

Sub SetCoverImage(mElement As BANanoElement, url As String)
	url = CStr(url)
	url = url.trim
	If url = "" Then Return
	AddStyleMap(mElement, CreateMap("background-image":$"url('${url}')"$, "background-size":"cover", "width":"100%","height":"100%"))
End Sub