B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
	Private TJO As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
End Sub

'Creates an empty TextFlow layout.
Public Sub Create
	TJO.InitializeNewInstance("javafx.scene.text.TextFlow",Null)
End Sub

'Creates a TextFlow layout with the given children.
'List needs to hold Type Object NOT Node.
Public Sub Create2(Children As List)
	For i = 0 To Children.Size - 1
		Dim Child As Object = Children.Get(i)
		If TextFlow_Utils.IsPackageObject(Child) Then Children.Set(i, CallSub(Child,"GetObject"))
	Next
	TJO.InitializeNewInstance("javafx.scene.text.TextFlow",Null)
	GetChildren.AddAll(Children)
End Sub

'Creates a TextFlow layout with the given child.
Public Sub Create3(Child As Object)
	If TextFlow_Utils.IsPackageObject(Child) Then Child = CallSub(Child,"GetObject")
	TJO.InitializeNewInstance("javafx.scene.text.TextFlow",Array As Object(Array As Node(Child)))
End Sub

'Calculates the baseline offset based on the first managed child.
Public Sub GetBaselineOffset As Double
	Return TJO.RunMethod("getBaselineOffset",Null)
End Sub

Public Sub AddNode(N As Object)
	If TextFlow_Utils.IsPackageObject(N) Then N = CallSub(N,"GetObject")
	GetChildren.Add(N)
End Sub
Public Sub AddAll(Children As List)
	For i = 0 To Children.Size - 1
		Dim Child As Object = Children.Get(i)
		If TextFlow_Utils.IsPackageObject(Child) Then Children.Set(i, CallSub(Child,"GetObject"))
	Next
	GetChildren.AddAll(Children)
End Sub

'Gets the list of children of this Parent.
Public Sub GetChildren As List
	Return TJO.RunMethod("getChildren",Null)
End Sub

Public Sub Clear
	GetChildren.Clear
End Sub

Public Sub RemoveNode(N As Object)
	If TextFlow_Utils.IsPackageObject(N) Then N = CallSub(N,"GetObject")
	Dim Pos As Int = GetChildren.IndexOf(N)
	If Pos > -1 Then GetChildren.RemoveAt(Pos)
End Sub

Public Sub InsertNode(Pos As Int, N As Object)
	If TextFlow_Utils.IsPackageObject(N) Then N = CallSub(N,"GetObject")
	GetChildren.InsertAt(Pos,N)
End Sub

Public Sub NodeCount As Int
	Return GetChildren.Size
End Sub

''Gets the list of children of this Parent.
''Text objects will be wrapped as TextClass
'Public Sub GetChildrenWrapped As List
'	Dim OutList As List
'	Dim L As List = TJO.RunMethod("getChildren",Null)
'	Dim OutList As List
'	OutList.Initialize
'	For Each T As JavaObject In L
'		If GetType(T) = "javafx.scene.text.Text" Then
'			Dim TC As TextClass
'			TC.Initialize
'			TC.SetObject(T)
'			OutList.Add(TC)
'		Else
'			OutList.Add(T)
'		End If
'	Next
'	Return OutList
'End Sub
'Gets the value of the property lineSpacing.
Public Sub GetLineSpacing As Double
	Return TJO.RunMethod("getLineSpacing",Null)
End Sub

Public Sub GetText As String
	Dim Text As String
	For Each O As Object In GetChildren
		 If O Is Label Then
			Dim L As Label = O
			Text = Text & L.Text
		Else
			Dim TC As TextClass
			TC.Initialize
			TC.SetObject(O)
				Text = Text & TC.GetText
		End If
	Next
	Return Text
End Sub
'Gets the value of the property textAlignment.
Public Sub GetTextAlignment As String
	Return TJO.RunMethod("getTextAlignment",Null)
End Sub

'Requests a layout pass to be performed before the next scene is rendered.
Public Sub RequestLayout
	TJO.RunMethod("requestLayout",Null)
End Sub
'Sets the value of the property lineSpacing.
Public Sub SetLineSpacing(Spacing As Double)
	TJO.RunMethod("setLineSpacing",Array As Object(Spacing))
End Sub
'Sets the value of the property textAlignment.
Public Sub SetTextAlignment(Value As String)
	TJO.RunMethod("setTextAlignment",Array As Object(Value))
End Sub

'Get the unwrapped object
Public Sub GetObject As Object
	Return TJO
End Sub

'Get the unwrapped object As a JavaObject
Public Sub GetObjectJO As JavaObject
	Return TJO
End Sub
'Comment if not needed

'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	TJO = Obj
End Sub

'Set the Tag for this object
Public Sub SetTag(Tag As Object)
	TJO.RunMethod("setUserData",Array(Tag))
End Sub

'Get the Tag for this object
Public Sub GetTag As Object
	Dim Tag As Object = TJO.RunMethod("getUserData",Null)
	If Tag = Null Then Tag = ""
	Return Tag
End Sub

