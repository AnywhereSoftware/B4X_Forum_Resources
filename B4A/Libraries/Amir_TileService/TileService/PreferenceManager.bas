B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@
private Sub Process_Globals
	Public TILE_KEY As String = "Tile"
End Sub

Public Sub GetValue (Key As String,Def As Object) As Object
	Return DefaultSP.RunMethod("get"&GetType2(Def),Array(Key,Def))
End Sub

Public Sub SaveValue (Key As String,Value As Object)
	DefaultSP.RunMethodJO("edit",Null) _
		.RunMethodJO("put"&GetType2(Value),Array(Key,Value)) _
		.RunMethod("apply",Null)
End Sub

Private Sub DefaultSP As JavaObject
	Dim Context As JavaObject
	Context.InitializeStatic("anywheresoftware.b4a.BA")
	Dim Jo As JavaObject
	Jo.InitializeStatic("android.preference.PreferenceManager")
	Return Jo.RunMethodJO("getDefaultSharedPreferences",Array(Context.GetField("applicationContext")))
End Sub

'Supports String,Boolean,Int,Long,Float
Private Sub GetType2 (t As Object) As String
 	If t Is Int Then
		Return "Int"
	Else If t Is Long Then
		Return "Long"
	Else If t Is Boolean Then
		Return "Boolean"
	Else If t Is Float Then
		Return "Float"
	End If
	Return "String"
End Sub