Type=StaticCode
Version=5.9
ModulesStructureVersion=1
B4J=true
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub


'Gets the icon images to be used in the window decorations and when minimized.
'Also adds the icon to the form
'<code>Dim Img As Image = fx.LoadImage(File.DirAssets,"icon.png")
'FormUtils.GetIcons(MainForm).Add(Img)</code>
Public Sub GetIcons(F As Form) As List
	Dim TJo As JavaObject = GetStage(F)
	Return TJo.RunMethod("getIcons",Null)
End Sub
'Gets the value of the property minHeight.
Public Sub GetMinHeight(F As Form) As Double
	Dim TJo As JavaObject = GetStage(F)
	Return TJo.RunMethod("getMinHeight",Null)
End Sub
'Gets the value of the property minWidth.
Public Sub GetMinWidth(F As Form) As Double
	Dim TJo As JavaObject = GetStage(F)
	Return TJo.RunMethod("getMinWidth",Null)
End Sub
'Gets the value of the property alwaysOnTop.
Public Sub IsAlwaysOnTop(F As Form) As Boolean
	Dim TJo As JavaObject = GetStage(F)
	Return TJo.RunMethod("isAlwaysOnTop",Null)
End Sub
'Gets the value of the property fullScreen.
Public Sub IsFullScreen (F As Form) As Boolean
	Dim TJo As JavaObject = GetStage(F)
	Return TJo.RunMethod("isFullScreen",Null)
End Sub
'Gets the value of the property iconified.
Public Sub IsIconified (F As Form) As Boolean
	Dim TJo As JavaObject = GetStage(F)
	Return TJo.RunMethod("isIconified",Null)
End Sub
'Gets the value of the property maximized.
Public Sub IsMaximized (F As Form) As Boolean
	Dim TJo As JavaObject = GetStage(F)
	Return TJo.RunMethod("isMaximized",Null)
End Sub
'Gets the value of the property resizable.
Public Sub IsResizable (F As Form) As Boolean
	Dim TJo As JavaObject = GetStage(F)
	Return TJo.RunMethod("isResizable",Null)
End Sub
'Sets the value of the property fullScreen.
Public Sub SetFullScreen(F As Form, Value As Boolean)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("setFullScreen",Array As Object(Value))
End Sub
'Specifies the text to show when a user enters full screen mode, usually used to indicate the way a user should go about exiting out of full screen mode.
Public Sub SetFullScreenExitHint(F As Form, Value As String)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("setFullScreenExitHint",Array As Object(Value))
End Sub
'Specifies the KeyCombination that will allow the user to exit full screen mode.
Public Sub SetFullScreenExitKeyCombination(F As Form,TKeyCombination As Object)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("setFullScreenExitKeyCombination",Array As Object(TKeyCombination))
End Sub
'Sets the value of the property iconified.
Public Sub SetIconified(F As Form, Value As Boolean)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("setIconified",Array As Object(Value))
End Sub
'Sets the value of the property maxHeight.
Public Sub SetMaxHeight(F As Form, Value As Double)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("setMaxHeight",Array As Object(Value))
End Sub
'Sets the value of the property maximized.
Public Sub SetMaximized(F As Form, Value As Boolean)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("setMaximized",Array As Object(Value))
End Sub
'Sets the value of the property maxWidth.
Public Sub SetMaxWidth(F As Form, Value As Double)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("setMaxWidth",Array As Object(Value))
End Sub
'Sets the value of the property minHeight.
Public Sub SetMinHeight(F As Form, Value As Double)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("setMinHeight",Array As Object(Value))
End Sub
'Sets the value of the property minWidth.
Public Sub SetMinWidth(F As Form, Value As Double)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("setMinWidth",Array As Object(Value))
End Sub
'Send the Window to the background.
Public Sub ToBack(F As Form)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("toBack",Null)
End Sub
'Bring the Window to the foreground.
Public Sub ToFront(F As Form)
	Dim TJo As JavaObject = GetStage(F)
	TJo.RunMethod("toFront",Null)
End Sub

Private Sub GetStage(F As JavaObject) As JavaObject
	Return F.GetField("stage")
End Sub