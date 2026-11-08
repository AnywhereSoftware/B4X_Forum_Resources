B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
Sub Class_Globals
	Private fParent As spJsonNode
	Private fExpanded As Boolean
	Private fName As String
	Private fIndent As Int
	Private fValue As Object
	Private fType As String
	Private fChildren As List
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize As spJsonNode
	fChildren.Initialize
	Return Me
End Sub

#region getter/setter
public Sub g_IsExpandable As Boolean
	Return (fType="object") Or (fType="array")
End Sub

public Sub g_hasValue As Boolean
	Return (fType<>"object") And (fType<>"array") And (fType<>"null")
End Sub

public Sub g_color As Int
	Select Case fType
		Case "string"
			Return 0xFFC9A33A
		Case "integer"
			Return 0xFF366970
		Case "decimal"
			Return 0xFF823DA6
		Case "boolean"
			Return 0xFFE47A1E
		Case "null"
			Return 0xFF000000
		Case "array"
			Return 0xFFD74444
		Case "object"
			Return 0xFF2B9138
	End Select
	Return 0
End Sub

public Sub s_Parent(avalue As spJsonNode) As spJsonNode
	fParent=avalue
	Return Me
End Sub

public Sub g_Parent As spJsonNode
	Return fParent
End Sub

public Sub g_children As List
	Return fChildren
End Sub

public Sub s_Expanded(avalue As Boolean) As spJsonNode
	fExpanded=avalue
	Return Me
End Sub

public Sub g_Expanded As Boolean
	Return fExpanded
End Sub

public Sub s_Name(avalue As String) As spJsonNode
	fName=avalue
	Return Me
End Sub

public Sub g_Name As String
	Return fName
End Sub

public Sub s_Indent(avalue As Int) As spJsonNode
	fIndent=avalue
	Return Me
End Sub

public Sub g_indent As Int
	Return fIndent
End Sub

public Sub s_Value(avalue As Object) As spJsonNode
	fValue=avalue
	fType=updateType
	Return Me
End Sub

public Sub g_Value As Object
	Return fValue
End Sub

public Sub g_Type As String
	Return fType
End Sub
#end region

#region computed property
public Sub g_path As String
	Dim n As spJsonNode=Me
	Dim s As String
	Do While Initialized(n)
		s=n.g_Name&"/"&s
		n=n.g_parent
	Loop
	Return s.SubString2(0,s.Length-1)
End Sub
#end region

private Sub updateType As String
	Select Case True
		Case Not(Initialized(fValue))
			Return "null"
		Case fValue Is String
			Return "string"
		Case fValue Is Int
			Return "integer"
		Case fValue Is Double
			Return "decimal"
		Case fValue Is Boolean
			Return "boolean"
		Case fValue Is Map
			Return "object"
		Case fValue Is List
			Return "array"
	End Select
	Return "error"
End Sub
