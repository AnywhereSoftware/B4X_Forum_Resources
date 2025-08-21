B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.9
@EndOfDesignText@
'Code module


'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Dim s As SQL
	'Dim c As Cursor


End Sub

Sub ConnectionDB

	Dim ConDB As String
	ConDB =DBUtils.CopyDBFromAssets("section_density.db") 'contacs_db = database name
	
	s.Initialize(ConDB, "section_density.db", True)

End Sub