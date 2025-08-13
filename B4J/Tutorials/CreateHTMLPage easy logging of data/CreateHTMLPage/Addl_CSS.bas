B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	
End Sub

'	Font Sans Serif
Public Sub FontSansSerif As String
	Return($"html * {font-family: Arial, Helvetica, sans-serif;}
"$)
End Sub

'Preferred CSS for multiple views
Public Sub MultiViews As String
	Return $"/* Preferred CSS for multiple views	*/
	.tablediv{display:inline-block;
/*			Display consecutive divs to the right	*/
			float:left;
/*			Tablediv Spacing */
			margin-right:15px;
/*	Ensures that the header is centered over the table	*/
			width:fit-content;}
"$
End Sub


'	Simplified css for 1 view or non float
'	although the multiple view CSS works just as well
'	Only really needed if you add a Title to the table.
Public Sub SingleView As String
	Return $"/*	Simplified css for 1 view or non float
	although the multiple view CSS works just as well	*/
	.tablediv{width:fit-content;}
"$
End Sub

'	Align table text center
Public Sub TableAlignTextCenter As String
	Return $"/*	Table align text center	*/
	table{text-align:center;}
"$
End Sub

'	Make table header bold
Public Sub TableHeadersBold As String
	Return $"/*	Table header bold	*/
	.table-header-title{font-weight:bold;}
"$
End Sub

'	Highlight data in column with colour (any valid CSS color string)
Public Sub HighlightDataInColumn(Column As Int, Colour As String) As String
	Return $"/* Highlight data in column ${Column} in Colour ${Colour}	*/
	.col-num${Column}{background-color:${Colour};
"$
End Sub

'	Highlight whole column with colour (any valid CSS color string)
Public Sub HighlightWholeColumn(Column As Int,Colour As String) As String
	Return $"/* Highlight whole column ${Column} in Colour ${Colour}	*/
	.col${Column}{background-color:${Colour};"$
End Sub

'	Position close button 
'	Pass Left or Right and Top or Bottom with preferred units (default is px). Empty string for others.
'	Width and Height (default unit is px) and FontSize (default unit is pt)
Public Sub PositionCloseButton(Left As String, Right As String, Top As String, Bottom As String, Width As String, Height As String,FontSize As String) As String
	Dim LeftRightPos As String = IIf(Left = "","right","left")
	Dim LeftRightSize As String = IIf(Left = "",Right,Left)
	Dim TopBottomPos As String = IIf(Top = "","bottom","top")
	Dim TopBottomSize As String = IIf(Top = "",Bottom,Top)
	If IsNumber(LeftRightSize) Then LeftRightSize = LeftRightSize & "px"
	If IsNumber(TopBottomSize) Then TopBottomSize = TopBottomSize & "px"
	If IsNumber(FontSize) Then FontSize = FontSize & "pt"
	If IsNumber(Width) Then Width = Width & "px"
	If IsNumber(Height) Then Height = Height & "px"
	Return $"/*	Position and size close Button	*/
#btnClose{position:fixed;${TopBottomPos}:${TopBottomSize};${LeftRightPos}:${LeftRightSize};width:${Width};height:${Height};font-size:${FontSize};}
"$
End Sub

'Make scrollable pass the relevant Class ie. .tablediv1
'This should be set as the DivClass on the table you want to scroll
'if you are only displaying one table, or you want them all to scroll you can use .divtable
'bearing in mind that if the table is not at the top of the screen (if you are showing multiple tables),
'this will not work as expected and you will need to set the css manually with the relevant 
'max-height for the specific table. 
Public Sub MakeScrollable(Class As String) As String
	If Class.StartsWith(".") = False Then Class = "." & Class
	Return $"${Class}{max-height:95vh;
	overflow-y:auto;}"$
End Sub