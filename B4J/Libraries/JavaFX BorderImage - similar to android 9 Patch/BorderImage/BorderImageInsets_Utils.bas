B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.9
@EndOfDesignText@
Sub Process_Globals
	
End Sub

'Constructs a new Insets instance with four different offsets.
Public Sub NewInsets(Top As Double, Right As Double, Bottom As Double, Left As Double) As BorderImageInsets
	Dim TObj As BorderImageInsets
	TObj.Initialize
	TObj.Create(Top,Right,Bottom,Left)
	Return TObj
End Sub

'Constructs a new Insets instance with same value for all four offsets.
Public Sub NewInsets2(TopRightBottomLeft As Double) As BorderImageInsets
	Dim TObj As BorderImageInsets
	TObj.Initialize
	TObj.Create2(TopRightBottomLeft)
	Return TObj
End Sub

