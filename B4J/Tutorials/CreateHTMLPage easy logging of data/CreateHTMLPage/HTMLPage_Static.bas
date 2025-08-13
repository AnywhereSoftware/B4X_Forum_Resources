B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Public Const HIGHLIGHT_LT As Int = 0
	Public Const HIGHLIGHT_LTEQ As Int = 1
	Public Const HIGHLIGHT_GT As Int = 2
	Public Const HIGHLIGHT_GTEQ As Int = 3
	Public Const HIGHLIGHT_EQ As Int = 4
	Public Const HIGHLIGHT_BETWEEN As Int = 5
	
	'Global flags
	Public TableCenterText As Boolean
	Public DivDefaultCSSUsed As Boolean
	Public TableDefaultCSSUsed As Boolean
End Sub

Public Sub TableDefaultCSS As String
	If TableDefaultCSSUsed Then Return ""
	TableDefaultCSSUsed = True
	Dim CSSStr As StringBuilder
	CSSStr.Initialize
	CSSStr.Append($"
/* Default Table CSS */
	table, table tbody, table tr, table td{
		border: 1px solid;
		border-collapse: collapse;
		font-size: 1em ;
		padding-top: 2px; 
		padding-bottom: 2px; 
		padding-left: 5px; 
		padding-right: 5px; 
		margin: 0;}
	table th{
		border: 1px solid;
		border-collapse: collapse;
		font-size: 1em ;
		padding-top: 2px;
		padding-bottom: 2px;
		padding-left: 5px;
		padding-right: 5px;
		margin: 0;
		font-weight: bold;
	}
	.row-num{font-weight:bold;}
	.tablediv{margin-bottom:15px;}
"$)
	Return CSSStr.ToString
End Sub

Public Sub DivDefaultCSS As String
	If DivDefaultCSSUsed Then Return ""
	DivDefaultCSSUsed = True
	Return ""
End Sub

Public Sub BRDefaultCSS As String
	Return ""
End Sub