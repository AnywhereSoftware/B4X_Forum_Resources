B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private fx As JFX
	Private texts As List
	Private lastItem As JavaObject
	'Private awesome As Font
End Sub

Public Sub Initialize
	texts.Initialize
	'awesome = fx.LoadFont(File.DirAssets, "FontAwesome.otf", 12)
End Sub

'public Sub AddFontAwesome(text As String)
'	Dim lbl As Label
'	lbl.Initialize("")
'	lbl.Font = fx.LoadFont(File.DirAssets, "FontAwesome.otf", 12)
'	lbl.Text = ""
'	texts.Add(lbl)
'	Return Me
'End Sub
'
'public Sub AddOtherFont(text As String)
'	Dim lbl As Label
'	lbl.Initialize("")
'	lbl.Font = fx.LoadFont(File.DirAssets, "RemachineScript.ttf", 12)
'	lbl.Text = text
'	texts.Add(lbl)
'	Return Me
'End Sub

public Sub AddImage2(img As Image,text As String) As TextFlow
	Dim uri As ImageView
	uri.Initialize("")
	uri.SetImage(img)
	uri.SetLayoutAnimated(0,0,0,16,16)
	uri.Tag = text
	texts.Add(uri)
	Return Me
End Sub

public Sub AddImage1(img As Image, imgw As Double, imgh As Double) As TextFlow
	Dim uri As ImageView
	uri.Initialize("")
	uri.SetImage(img)
	uri.SetLayoutAnimated(0,0,0,imgw,imgh)
	texts.Add(uri)
	Return Me
End Sub

Public Sub AddImage(dir As String, img As String) As TextFlow
	Dim simg As Image = fx.LoadImage(dir,img)
	Dim uri As ImageView
	uri.Initialize("")
	uri.SetImage(simg)
	uri.SetLayoutAnimated(0,0,0,16,16)
	texts.Add(uri)
	Return Me
End Sub

Public Sub AddText(text As String) As TextFlow
	Dim lastItem As JavaObject
	lastItem.InitializeNewInstance("javafx.scene.text.Text", Array(text))
	texts.Add(lastItem)
	Return Me
End Sub

Public Sub SetFont(Font As Font) As TextFlow
	lastItem.RunMethod("setFont", Array(Font))
	Return Me
End Sub

Public Sub SetColor(Color As Paint) As TextFlow
	lastItem.RunMethod("setFill", Array(Color))
	Return Me	
End Sub

Public Sub SetUnderline(Underline As Boolean) As TextFlow
	lastItem.RunMethod("setUnderline", Array(Underline))
	Return Me
End Sub

Public Sub SetStrikethrough(Strikethrough As Boolean) As TextFlow
	lastItem.RunMethod("setStrikethrough", Array(Strikethrough))
	Return Me
End Sub

Public Sub CreateTextFlow As Pane
	Dim tf As JavaObject
	tf.InitializeNewInstance("javafx.scene.text.TextFlow", Null)
	tf.RunMethodJO("getChildren", Null).RunMethod("addAll", Array(texts))
	Return tf
End Sub