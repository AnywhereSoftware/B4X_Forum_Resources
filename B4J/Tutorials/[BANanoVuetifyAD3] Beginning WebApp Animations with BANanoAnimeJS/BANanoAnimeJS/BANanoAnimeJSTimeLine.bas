B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
#IgnoreWarnings:12

Sub Class_Globals
	Private boAnime As BANanoObject
	Private targets As List
	Private mCallBack As Object
	Public timeline As BANanoAnimeJSItem
	Private BANano As BANano
	Private boTimeLine As BANanoObject
	Private isCreated As Boolean
End Sub

'initialize the library
Public Sub Initialize(Module As Object) As BANanoAnimeJSTimeLine
	targets.Initialize 
	mCallBack = Module
	timeline.Initialize  
	boAnime.Initialize("anime")
	isCreated = False
	Return Me
End Sub

'create the timeline
private Sub create As BANanoAnimeJSTimeLine
	isCreated = True
	Dim options As Map = timeline.pop
	boTimeLine = boAnime.RunMethod("timeline", options)
	Return Me
End Sub

' an individual animation
Sub animation As BANanoAnimeJSItem
	Dim ajsa As BANanoAnimeJSItem
	ajsa.Initialize
	Return ajsa
End Sub

'add a timeline animation
Sub add(anim As BANanoAnimeJSItem) As BANanoAnimeJSTimeLine
	If isCreated = False Then
		create
	End If
	Dim options As Map = anim.pop
	boTimeLine.RunMethod("add", options)
	Return Me
End Sub

'add a timeline animation with Offset
Sub addOffset(anim As BANanoAnimeJSItem, offSet As Object) As BANanoAnimeJSTimeLine
	If isCreated = False Then
		create
	End If
	Dim options As Map = anim.pop
	boTimeLine.RunMethod("add", Array(options, offSet))
	Return Me
End Sub

'play the timeline
Sub play
	boTimeLine.RunMethod("play", Null)
End Sub

'pause the timeline
Sub pause
	boTimeLine.RunMethod("pause", Null)
End Sub


'restart
Sub restart
	boTimeLine.RunMethod("restart", Null)
End Sub

'reverse
Sub reverse
	boTimeLine.RunMethod("reverse", Null)
End Sub
