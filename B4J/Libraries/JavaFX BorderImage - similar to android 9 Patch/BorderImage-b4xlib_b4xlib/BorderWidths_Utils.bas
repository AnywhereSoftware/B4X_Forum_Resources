B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.9
@EndOfDesignText@
'Static code module
Sub Process_Globals
	
End Sub

'Creates a new BorderWidths with the specified widths for top, right, bottom, and left.
Public Sub NewBorderWidths(Top As Double, Right As Double, Bottom As Double, Left As Double) As BorderWidths
	Dim TObj As BorderWidths
	TObj.Initialize
	TObj.Create(Top,Right,Bottom,Left)
	Return TObj
End Sub

'*
Public Sub NewBorderWidths2(Top As Double, Right As Double, Bottom As Double, Left As Double, TopAsPercentage As Boolean, RightAsPercentage As Boolean, BottomAsPercentage As Boolean, LeftAsPercentage As Boolean) As BorderWidths
	Dim TObj As BorderWidths
	TObj.Initialize
	TObj.Create2(Top,Right,Bottom,Left,TopAsPercentage,RightAsPercentage,BottomAsPercentage,LeftAsPercentage)
	Return TObj
End Sub

'Creates a new BorderWidths using the given width for all four borders, and treating this width as a literal value, and not a percentage.
Public Sub NewBorderWidths3(Width As Double) As BorderWidths
	Dim TObj As BorderWidths
	TObj.Initialize
	TObj.Create3(Width)
	Return TObj
End Sub

