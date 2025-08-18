B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
#IgnoreWarnings:12

Sub Class_Globals
	Public options As Map
	Public targets As List
	Private BANano As BANano
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize As BANanoAnimeJSItem
	options.Initialize 
	targets.Initialize 
	Return Me
End Sub

Sub alternate(b As Boolean) As BANanoAnimeJSItem
	If BANano.IsNull(b) Or BANano.IsUndefined(b) Then Return Me
	If b = False Then Return Me
	direction("alternate")
	Return Me
End Sub

'delay
Sub delay(d As Object) As BANanoAnimeJSItem
	If BANano.IsNull(d) Or BANano.IsUndefined(d) Then Return Me
	If d = "" Then Return Me
	options.Put("delay", d)
	Return Me
End Sub

'delay callback
'<code>
'item.delayCallBack(Me, "delayCallBack")
'Sub delayCallBack(el As Object, i As Int)
'End Sub
'</code>
Sub delayCallBack(Module As Object, methodName As String) As BANanoAnimeJSItem
	Dim el, i As Object
	Dim cb As BANanoObject = BANano.CallBack(Module, methodName, Array(el, i))
	options.Put("delay", cb.Result)
	Return Me
End Sub


'translateX callback
'<code>
'item.translateXCallBack(Me, "translateXCallBack")
'Sub translateXCallBack(el As Object, i As Int)
'End Sub
'</code>
Sub translateXCallBack(Module As Object, methodName As String) As BANanoAnimeJSItem
	Dim el, i As Object
	Dim cb As BANanoObject = BANano.CallBack(Module, methodName, Array(el, i))
	options.Put("translateX", cb.Result)
	Return Me
End Sub


'update callback
'<code>
'item.updateCallBack(Me, "updateCallBack")
'Sub translateYCallBack(el As Object, i As Int)
'End Sub
'</code>
Sub updateCallBack(Module As Object, methodName As String) As BANanoAnimeJSItem
	Dim cb As BANanoObject = BANano.CallBack(Module, methodName, Null)
	options.Put("update", cb.Result)
	Return Me
End Sub


'translateY callback
'<code>
'item.translateYCallBack(Me, "translateYCallBack")
'Sub translateYCallBack(el As Object, i As Int)
'End Sub
'</code>
Sub translateYCallBack(Module As Object, methodName As String) As BANanoAnimeJSItem
	Dim el, i As Object
	Dim cb As BANanoObject = BANano.CallBack(Module, methodName, Array(el, i))
	options.Put("translateY", cb.Result)
	Return Me
End Sub

'scale callback
'<code>
'item.scaleCallBack(Me, "scaleCallBack")
'Sub scaleCallBack(el As Object, i As Int, l As Object)
'End Sub
'</code>
Sub scaleCallBack(Module As Object, methodName As String) As BANanoAnimeJSItem
	Dim el, i, l As Object
	Dim cb As BANanoObject = BANano.CallBack(Module, methodName, Array(el, i, l))
	options.Put("scale", cb.Result)
	Return Me
End Sub

'rotate callback
'<code>
'item.rotateCallBack(Me, "rotateCallBack")
'Sub rotateCallBack()
'End Sub
'</code>
Sub rotateCallBack(Module As Object, methodName As String) As BANanoAnimeJSItem
	Dim cb As BANanoObject = BANano.CallBack(Module, methodName, Null)
	options.Put("rotate", cb.Result)
	Return Me
End Sub

'rotate callback
'<code>
'item.borderRadiusCallBack(Me, "borderRadiusCallBack")
'Sub borderRadiusCallBack()
'End Sub
'</code>
Sub borderRadiusCallBack(Module As Object, methodName As String) As BANanoAnimeJSItem
	Dim cb As BANanoObject = BANano.CallBack(Module, methodName, Null)
	options.Put("borderRadius", cb.Result)
	Return Me
End Sub


'duration callback
'<code>
'item.durationCallBack(Me, "durationCallBack")
'Sub durationCallBack()
'End Sub
'</code>
Sub durationCallBack(Module As Object, methodName As String) As BANanoAnimeJSItem
	Dim cb As BANanoObject = BANano.CallBack(Module, methodName, Null)
	options.Put("duration", cb.Result)
	Return Me
End Sub

'value
Sub value(v As Object) As BANanoAnimeJSItem
	If BANano.IsNull(v) Or BANano.IsUndefined(v) Then Return Me
	If v = "" Then Return Me
	options.Put("value", v)
	Return Me
End Sub

'opacity
Sub opacity(v As Object) As BANanoAnimeJSItem
	If BANano.IsNull(v) Or BANano.IsUndefined(v) Then Return Me
	If v = "" Then Return Me
	options.Put("opacity", v)
	Return Me
End Sub

'easing
Sub easing(e As Object) As BANanoAnimeJSItem
	If BANano.IsNull(e) Or BANano.IsUndefined(e) Then Return Me
	If e = "" Then Return Me
	options.Put("easing", e)
	Return Me
End Sub

'steps
Sub steps(numberOfSteps As Int) As BANanoAnimeJSItem
	If BANano.IsNull(numberOfSteps) Or BANano.IsUndefined(numberOfSteps) Then Return Me
	If numberOfSteps = "" Then Return
	options.Put("easing", $"steps(${numberOfSteps})"$)
	Return Me
End Sub

'cubicBezier
Sub cubicBezier(x1 As Object, y1 As Object, x2 As Object, y2 As Object) As BANanoAnimeJSItem
	options.Put("easing", $"cubicBezier(${x1}, ${y1}, ${x2}, ${y2}})"$)
	Return Me
End Sub

'spring
Sub spring(mass As Object, stiffness As Object, damping As Object, velocity As Object) As BANanoAnimeJSItem
	options.Put("easing", $"spring(${mass}, ${stiffness}, ${damping}, ${velocity})"$)
	Return Me
End Sub

'easeInElastic
Sub easeInElastic(amplitude As Object, period As Object) As BANanoAnimeJSItem
	options.Put("easing", $"easeInElastic(${amplitude}, ${period})"$)
	Return Me
End Sub

'easeOutElastic
Sub easeOutElastic(amplitude As Object, period As Object) As BANanoAnimeJSItem
	options.Put("easing", $"easeOutElastic(${amplitude}, ${period})"$)
	Return Me
End Sub

'easeInOutElastic
Sub easeInOutElastic(amplitude As Object, period As Object) As BANanoAnimeJSItem
	options.Put("easing", $"easeInOutElastic(${amplitude}, ${period})"$)
	Return Me
End Sub

'easeOutInElastic
Sub easeOutInElastic(amplitude As Object, period As Object) As BANanoAnimeJSItem
	options.Put("easing", $"easeOutInElastic(${amplitude}, ${period})"$)
	Return Me
End Sub

'duration
Sub duration(d As Object) As BANanoAnimeJSItem
	If BANano.IsNull(d) Or BANano.IsUndefined(d) Then Return Me
	If d = "" Then Return Me
	options.Put("duration", d)
	Return Me
End Sub

'pop return the options
Sub pop As Map
	If targets.Size > 0 Then
		options.Put("targets", targets)
	End If
	Return options
End Sub

'set an option to change
private Sub change(prop As String, propvalue As Object) As BANanoAnimeJSItem
	options.Put(prop, propvalue)
	Return Me
End Sub

'set an option to change from to
private Sub change1(prop As String, fromValue As Object, toValue As Object) As BANanoAnimeJSItem
	Dim lopts As List
	lopts.Initialize 
	lopts.Add(fromValue)
	lopts.Add(toValue)
	options.Put(prop, lopts)
	Return Me
End Sub

'change the left css property
Sub left(l As Object) As BANanoAnimeJSItem
	If BANano.IsNull(l) Or BANano.IsUndefined(l) Then Return Me
	If l = "" Then Return Me
	change("left", l)
	Return Me
End Sub

'change the background color
Sub backgroundColor(bg As String) As BANanoAnimeJSItem
	If BANano.IsNull(bg) Or BANano.IsUndefined(bg) Then Return Me
	If bg = "" Then Return Me
	change("backgroundColor", bg)
	Return Me
End Sub

'change the border radius from to
Sub borderRadius(fromValue As Object, toValue As Object) As BANanoAnimeJSItem
	change1("borderRadius", fromValue, toValue)
	Return Me
End Sub

'translateX
Sub translateX(x As Object) As BANanoAnimeJSItem
	If BANano.IsNull(x) Or BANano.IsUndefined(x) Then Return Me
	If x = "" Then Return Me
	change("translateX", x)
	Return Me
End Sub

'translateX1
Sub translateX1(x0 As Object, x1 As Object) As BANanoAnimeJSItem
	Dim points As List
	points.Initialize 
	points.Add(x0)
	points.Add(x1)
	change("translateX", points)
	Return Me
End Sub

'translateY
Sub translateY(x As Object) As BANanoAnimeJSItem
	If BANano.IsNull(x) Or BANano.IsUndefined(x) Then Return Me
	If x = "" Then Return Me
	change("translateY", x)
	Return Me
End Sub

'translateZ
Sub translateZ(x As Object) As BANanoAnimeJSItem
	If BANano.IsNull(x) Or BANano.IsUndefined(x) Then Return Me
	If x = "" Then Return Me
	change("translateZ", x)
	Return Me
End Sub

'rotate
Sub rotate(r As Object) As BANanoAnimeJSItem
	If BANano.IsNull(r) Or BANano.IsUndefined(r) Then Return Me
	If r = "" Then Return Me
	change("rotate", r)
	Return Me
End Sub

'rotateX
Sub rotateX(r As Object) As BANanoAnimeJSItem
	If BANano.IsNull(r) Or BANano.IsUndefined(r) Then Return Me
	If r = "" Then Return Me
	change("rotateX", r)
	Return Me
End Sub

'rotateY
Sub rotateY(r As Object) As BANanoAnimeJSItem
	If BANano.IsNull(r) Or BANano.IsUndefined(r) Then Return Me
	change("rotateY", r)
	Return Me
End Sub

'rotateZ
Sub rotateZ(r As Object) As BANanoAnimeJSItem
	If BANano.IsNull(r) Or BANano.IsUndefined(r) Then Return Me
	If r = "" Then Return Me
	change("rotateZ", r)
	Return Me
End Sub

'scale
Sub scale(s As Object) As BANanoAnimeJSItem
	If BANano.IsNull(s) Or BANano.IsUndefined(s) Then Return Me
	If s = "" Then Return Me
	change("scale", s)
	Return Me
End Sub

'scaleX
Sub scaleX(s As Object) As BANanoAnimeJSItem
	If BANano.IsNull(s) Or BANano.IsUndefined(s) Then Return Me
	If s = "" Then Return Me
	change("scaleX", s)
	Return Me
End Sub

'scaleY
Sub scaleY(s As Object) As BANanoAnimeJSItem
	If BANano.IsNull(s) Or BANano.IsUndefined(s) Then Return Me
	If s = "" Then Return Me
	change("scaleY", s)
	Return Me
End Sub

'scaleZ
Sub scaleZ(s As Object) As BANanoAnimeJSItem
	If BANano.IsNull(s) Or BANano.IsUndefined(s) Then Return Me
	If s = "" Then Return Me
	change("scaleZ", s)
	Return Me
End Sub

'skew
Sub skew(s As Object) As BANanoAnimeJSItem
	If BANano.IsNull(s) Or BANano.IsUndefined(s) Then Return Me
	If s = "" Then Return Me
	change("skew", s)
	Return Me
End Sub

'skewX
Sub skewX(s As Object) As BANanoAnimeJSItem
	If BANano.IsNull(s) Or BANano.IsUndefined(s) Then Return Me
	If s = "" Then Return Me
	change("skewX", s)
	Return Me
End Sub

'skewY
Sub skewY(s As Object) As BANanoAnimeJSItem
	If BANano.IsNull(s) Or BANano.IsUndefined(s) Then Return Me
	If s = "" Then Return Me
	change("skewY", s)
	Return Me
End Sub

'perspective
Sub perspective(s As Object) As BANanoAnimeJSItem
	If BANano.IsNull(s) Or BANano.IsUndefined(s) Then Return Me
	If s = "" Then Return Me
	change("perspective", s)
	Return Me
End Sub

'round
Sub roundIT(s As Object) As BANanoAnimeJSItem
	If BANano.IsNull(s) Or BANano.IsUndefined(s) Then Return Me
	If s = "" Then Return Me
	change("round", s)
	Return Me
End Sub

'loop
Sub loopIT(s As Boolean) As BANanoAnimeJSItem
	If BANano.IsNull(s) Or BANano.IsUndefined(s) Then Return Me
	If s = "" Then Return Me
	change("loop", s)
	Return Me
End Sub

'baseFrequency
Sub baseFrequency(s As Object) As BANanoAnimeJSItem
	If BANano.IsNull(s) Or BANano.IsUndefined(s) Then Return Me
	If s = "" Then Return Me
	change("baseFrequency", s)
	Return Me
End Sub

'direction
Sub direction(d As Object) As BANanoAnimeJSItem
	If BANano.IsNull(d) Or BANano.IsUndefined(d) Then Return Me
	If d = "" Then Return Me
	change("direction", d)
	Return Me
End Sub

'endDelay
Sub endDelay(s As Object) As BANanoAnimeJSItem
	If BANano.IsNull(s) Or BANano.IsUndefined(s) Then Return Me
	If s = "" Then Return Me
	change("endDelay", s)
	Return Me
End Sub

'innerHTML
Sub innerHTML(fromValue As Object, toValue As Object) As BANanoAnimeJSItem
	change1("innerHTML", fromValue, toValue)
	Return Me
End Sub

'autoplay
Sub autoplay(b As Boolean) As BANanoAnimeJSItem
	If BANano.IsNull(b) Or BANano.IsUndefined(b) Then Return Me
	If b = False Then Return Me
	If b = "" Then Return Me
	change("autoplay", b)
	Return Me
End Sub

'width
Sub width(w As Object) As BANanoAnimeJSItem
	If BANano.IsNull(w) Or BANano.IsUndefined(w) Then Return Me
	If w = "" Then Return Me
	change("width", w)
	Return Me
End Sub

'height
Sub height(h As Object) As BANanoAnimeJSItem
	If BANano.IsNull(h) Or BANano.IsUndefined(h) Then Return Me
	If h = "" Then Return Me
	change("height", h)
	Return Me
End Sub

'set the target to process
Sub target(jTarget As String) As BANanoAnimeJSItem
	If BANano.IsNull(jTarget) Or BANano.IsUndefined(jTarget) Then Return Me
	If jTarget = "" Then Return Me
	targets.Add(jTarget)
	Return Me
End Sub
