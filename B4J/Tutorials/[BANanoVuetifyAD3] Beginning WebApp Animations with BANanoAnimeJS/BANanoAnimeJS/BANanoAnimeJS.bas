B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
#IgnoreWarnings:12

Sub Class_Globals
	Private boAnime As BANanoObject
	'Private options As Map
	Private targets As List
	Private mCallBack As Object
	Private keyframesx As List
	
	Public const ROTATE_1turn As String = "1turn"
	
	Public const EASING_linear As String = "linear"
	Public const EASING_spring As String = "spring"
	Public const EASING_easeInQuad As String = "easeInQuad"
	Public const EASING_easeInCubic As String = "easeInCubic"  
	Public const EASING_easeInQuart As String = "easeInQuart"
	Public const EASING_easeInQuint As String = "easeInQuint"
	Public const EASING_easeInSine As String = "easeInSine"
	Public const EASING_easeInExpo As String = "easeInExpo"
	Public const EASING_easeInCirc As String = "easeInCirc"
	Public const EASING_easeInBack As String = "easeInBack"
	Public const EASING_easeOutQuad As String = "easeOutQuad"
	Public const EASING_easeOutCubic As String = "easeOutCubic"
	Public const EASING_easeOutQuart As String = "easeOutQuart"
	Public const EASING_easeOutQuint As String = "easeOutQuint"
	Public const EASING_easeOutSine As String = "easeOutSine"
	Public const EASING_easeOutExpo As String = "easeOutExpo"
	Public const EASING_easeOutCirc As String = "easeOutCirc"
	Public const EASING_easeOutBack As String = "easeOutBack"
	Public const EASING_easeInBounce As String = "easeInBounce"
	Public const EASING_easeInOutQuad As String = "easeInOutQuad"
	Public const EASING_easeInOutCubic As String = "easeInOutCubic"
	Public const EASING_easeInOutQuart As String = "easeInOutQuart"
	Public const EASING_easeInOutQuint As String = "easeInOutQuint"
	Public const EASING_easeInOutSine As String = "easeInOutSine"
	Public const EASING_easeInOutExpo As String = "easeInOutExpo"
	Public const EASING_easeInOutCirc As String = "easeInOutCirc"
	Public const EASING_easeInOutBack As String = "easeInOutBack"
	Public const EASING_easeInOutBounce As String = "easeInOutBounce"
	Public const EASING_easeOutBounce As String = "easeOutBounce"
	Public const EASING_easeOutInQuad As String = "easeOutInQuad"
	Public const EASING_easeOutInCubic As String = "easeOutInCubic"
	Public const EASING_easeOutInQuart As String = "easeOutInQuart"
	Public const EASING_easeOutInQuint As String = "easeOutInQuint"
	Public const EASING_easeOutInSine As String = "easeOutInSine"
	Public const EASING_easeOutInExpo As String = "easeOutInExpo"
	Public const EASING_easeOutInCirc As String = "easeOutInCirc"
	Public const EASING_easeOutInBack As String = "easeOutInBack"
	Public const EASING_easeOutInBounce As String = "easeOutInBounce"
	
	'
	Public const DIRECTION_alternate As String = "alternate"
	Public const DIRECTION_reverse As String = "reverse"
	Public const DIRECTION_normal As String = "normal"
	'
	Public anime As BANanoAnimeJSItem
	Private isCreated As Boolean
End Sub

'initialize the library
Public Sub Initialize(Module As Object, targetx As Object) As BANanoAnimeJS
	'options.Initialize 
	targets.Initialize 
	mCallBack = Module
	keyframesx.Initialize
	anime.Initialize  
	'
	target(targetx)
	isCreated = False
	Return Me
End Sub

' an individual animation
Sub animation As BANanoAnimeJSItem
	Dim ajsa As BANanoAnimeJSItem
	ajsa.Initialize
	Return ajsa
End Sub

'add a keyframe
Sub keyframes(kf As BANanoAnimeJSItem) As BANanoAnimeJS
	keyframesx.Add(kf.pop)
	Return Me
End Sub

'set the target to process
Sub target(jTarget As String) As BANanoAnimeJS
	targets.Add(jTarget)
	Return Me
End Sub

'animate build
Sub create
	isCreated = True
	Dim options As Map = anime.pop
	If keyframesx.Size > 0 Then
		options.put("keyframes", keyframesx)
	End If
	options.Put("targets", targets)
	boAnime.Initialize4("anime", options)
End Sub

'play the animation
Sub play
	If isCreated = False Then
		create
	End If
	boAnime.RunMethod("play", Null)
End Sub

'pause
Sub pause
	boAnime.RunMethod("pause", Null)
End Sub

'restart
Sub restart
	boAnime.RunMethod("restart", Null)
End Sub

'reverse
Sub reverse
	boAnime.RunMethod("reverse", Null)
End Sub
