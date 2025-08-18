B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Private Robot As AWTRobot 'Make sure the jAWTRobot and jReflection libraries are added.
	Private edHTML As B4XView
	
	Private jcKeyEvt As JavaObject
	Private joKeyEvtKeyPressed As JavaObject
	Private joKeyEvtKeyReleased As JavaObject
	Private joKeyEvtKeyTyped As JavaObject

	Private CRComing As Boolean
	Private ArrowNeeded As Boolean
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	jcKeyEvt.InitializeStatic("javafx.scene.input.KeyEvent")
	joKeyEvtKeyPressed = jcKeyEvt.GetFieldJO("KEY_PRESSED")
	joKeyEvtKeyReleased = jcKeyEvt.GetFieldJO("KEY_RELEASED")
	joKeyEvtKeyTyped = jcKeyEvt.GetFieldJO("KEY_TYPED")
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
  	
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<html dir=").Append(Quoted("ltr")).Append("><head>")
	'Turn off page break at <p ...> ... </p> and <div ...> ... </div> boundaries:
	sb.Append("<style type=").Append(Quoted("text/css")).Append(">").Append("div {display: inline;} p {display: inline;}").Append("</style></head>")
	sb.Append("<body contenteditable=").Append(Quoted("true")).Append(">")
	edHTML.As(HTMLEditor).HTMLText = sb.Append("</body></html>").ToString
	
	Dim r As Reflector
	r.Target = edHTML
	r.AddEventFilter("HTMLKey", "javafx.scene.input.KeyEvent.ANY")  	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub HTMLKey_Filter(e As Event)
	Private joEvt As JavaObject = e
	Private joType As JavaObject = joEvt.RunMethod("getEventType", Null)
	If joType = joKeyEvtKeyPressed Then 'Consume the Enter key so we can inject something else and flag it.
		If ArrowNeeded Then 'Get ahead of the extra space we were forced to insert with CRLF(see below).
			ArrowNeeded = False
			Robot.RobotSpecialKeyPress("left_arrow")
			Robot.RobotSpecialKeyRelease("left_arrow")
		End If
		Private Code As String = joEvt.RunMethodJO("getCode", Null).RunMethod("toString", Null) 
		CRComing = Code.EqualsIgnoreCase("enter")
		If CRComing Then e.Consume
	Else If joType = joKeyEvtKeyTyped Then
		If CRComing Then e.Consume
	Else If joType = joKeyEvtKeyReleased Then
		If CRComing Then
			CRComing = False
			e.Consume
			Robot.RobotPaste2(CRLF & " ") 'The extra space is necessary for correct behaviour. We will paste in a Left arrow key next keypress.
			ArrowNeeded = True
		Else
			ArrowNeeded = False
		End If
	End If
End Sub

Private Sub Quoted(s As String) As String
	If s.Length = 0 Then Return QUOTE & QUOTE
	If Not(s.StartsWith(QUOTE)) Then s = QUOTE & s
	Return IIf(s.EndsWith(QUOTE), s, s & QUOTE)
End Sub