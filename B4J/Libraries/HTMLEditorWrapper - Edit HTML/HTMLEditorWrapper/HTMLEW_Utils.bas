B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.3
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
	Private XUI As XUI
End Sub

Public Sub SetTooltipTextSize(N As B4XView, Size As Double)
	Try
		Dim F As Font = XUI.CreateFont(N.Font,Size)
		Dim Tooltip As JavaObject = N.As(JavaObject).RunMethod("getTooltip",Null)
		Tooltip.RunMethod("setFont",Array(F))
	Catch
		Log(LastException)
	End Try
End Sub

Public Sub CssHexToInt(Hex As String) As Int
	Dim Len As Int = Hex.Length
	Select Len
		Case 8
			Hex = Hex.SubString(6) & Hex.SubString2(0,6)
			Dim Val As Int
			Dim S As String
			For i = 0 To Hex.Length - 2 Step 2
				Val = Bit.ShiftLeft(Val,8)
				S = Hex.SubString2(I,I+2)
				Val = Bit.Or(Val,Bit.ParseInt(S,16))
			Next
		Case 6
			Hex = "ff" & Hex
			Dim Val As Int
			Dim S As String
			For i = 0 To Hex.Length - 2 Step 2
				Val = Bit.ShiftLeft(Val,8)
				S = Hex.SubString2(I,I+2)
				Val = Bit.Or(Val,Bit.ParseInt(S,16))
			Next
		Case 4
			Hex = Hex.SubString(3) & Hex.SubString2(0,2)
			Dim Hex1 As StringBuilder
			Hex1.Initialize
			For i = 0 To Hex.Length - 1
				For j = 0 To 1
					Hex1.Append(Hex.CharAt(i))
				Next
			Next
			Return CssHexToInt(Hex1.ToString)
		Case 3
			Dim Hex1 As StringBuilder
			Hex1.Initialize
			For i = 0 To Hex.Length - 1
				For j = 0 To 1
					Hex1.Append(Hex.CharAt(i))
				Next
			Next
			Return CssHexToInt(Hex1.ToString)
	End Select
	Return Val
End Sub

Public Sub HexToInt(Hex As String) As Int
	If Hex.ToLowerCase.StartsWith("0x") Then Hex = Hex.SubString(2)
	Dim Val As Int
	Dim S As String
	For i = 0 To Hex.Length - 2 Step 2
		Val = Bit.ShiftLeft(Val,8)
		S = Hex.SubString2(I,I+2)
		Val = Bit.Or(Val,Bit.ParseInt(S,16))
	Next
	Return Val
End Sub

Public Sub RightToLeft(N As B4XView)
	N.As(JavaObject).RunMethod("setNodeOrientation",Array("RIGHT_TO_LEFT"))
	N.SetTextAlignment("CENTER","RIGHT")
End Sub

Public Sub GetScreenPosition(n As Node) As Double()
	
	Dim x = 0, y = 0 As Double
	Dim joNode = n, joScene, joStage As JavaObject
  
	'Get the scene position:
	joScene = joNode.RunMethod("getScene",Null)
	If joScene.IsInitialized = False Then Return Array As Double(0,0)
	x = x + joScene.RunMethod("getX", Null)
	y = y + joScene.RunMethod("getY", Null)

	'Get the stage position:
	joStage = joScene.RunMethod("getWindow", Null)
	If joStage.IsInitialized = False Then Return Array As Double(0,0)
	x = x + joStage.RunMethod("getX", Null)
	y = y + joStage.RunMethod("getY", Null)
  
	'Get the node position in the scene:
	Do While True
		y = y + joNode.RunMethod("getLayoutY", Null)
		x = x + joNode.RunMethod("getLayoutX", Null)
		joNode = joNode.RunMethod("getParent", Null)
		If joNode.IsInitialized = False Then Exit
	Loop

	Return Array As Double(x,y)
End Sub

Public Sub AddMnemonic(N As Node,Keys() As String)
	
	Dim KC As JavaObject
	KC.InitializeStatic("javafx.scene.input.KeyCombination")
	Dim KCS As String
	For i = 0 To Keys.Length - 1
		If i > 0 Then KCS = KCS & "+"
		KCS = KCS & Keys(i)
	Next
	
	Dim MN As JavaObject
	MN.InitializeNewInstance("javafx.scene.input.Mnemonic",Array(N,KC.RunMethod("keyCombination",Array(KCS))))
	
	Dim Scene As JavaObject = N.As(JavaObject).RunMethod("getScene",Null)
	Scene.RunMethod("addMnemonic",Array(MN))
	
End Sub

Public Sub PasteHTML(Text As String, HTML As String)
	Dim DataFormat As JavaObject
	DataFormat.InitializeStatic("javafx.scene.input.DataFormat")
	Dim Clipboard As JavaObject
	Clipboard.InitializeStatic("javafx.scene.input.Clipboard")
	Clipboard = Clipboard.RunMethod("getSystemClipboard",Null)
	Dim m As Map
	m.Initialize
	m.Put(DataFormat.GetField("HTML"),HTML)
	m.Put(DataFormat.GetField("PLAIN_TEXT"),Text)
		
	Clipboard.RunMethod("setContent",Array(M))
		
	Sleep(100)
	RobotPaste
End Sub

Public Sub GetHTMLfromClipboard As String
	Dim DataFormat As JavaObject
	DataFormat.InitializeStatic("javafx.scene.input.DataFormat")
	Dim Clipboard As JavaObject
	Clipboard.InitializeStatic("javafx.scene.input.Clipboard")
	Clipboard = Clipboard.RunMethod("getSystemClipboard",Null)
	
	If Clipboard.RunMethod("hasHtml",Null) Then
		Return Clipboard.RunMethod("getHtml",Null)
	End If
	Return ""
End Sub

Public Sub RobotPaste
	Dim Robot As JavaObject
	Robot.InitializeNewInstance("java.awt.Robot",Null)
	Robot.RunMethod("keyPress",Array(17))			'Ctrl Key
	Sleep(10)
	Robot.RunMethod("keyPress",Array(86))			'v key
	Sleep(10)
	Robot.RunMethod("keyRelease",Array(86))
	Sleep(10)
	Robot.RunMethod("keyRelease",Array(17))
End Sub

Public Sub RobotCopy
	Dim Robot As JavaObject
	Robot.InitializeNewInstance("java.awt.Robot",Null)
	Robot.RunMethod("keyPress",Array(17))			'Ctrl Key
	Sleep(10)
	Robot.RunMethod("keyPress",Array(67))			'c key
	Sleep(10)
	Robot.RunMethod("keyRelease",Array(67))
	Sleep(10)
	Robot.RunMethod("keyRelease",Array(17))
End Sub

Public Sub MenuSeparatorItem As JavaObject
	Dim TJO As JavaObject
	TJO.InitializeNewInstance("javafx.scene.control.SeparatorMenuItem",Null)
	Return TJO
End Sub