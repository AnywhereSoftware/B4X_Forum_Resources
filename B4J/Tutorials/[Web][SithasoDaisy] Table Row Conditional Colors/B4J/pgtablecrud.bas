B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@
#IgnoreWarnings:12, 9
Sub Process_Globals
	'this is the name of the page
	Public name As String = "tablecrud"
	Public title As String = "Table Colors"
	Public icon As String = "fa-solid fa-swatchbook"
	Public color As String = "#000000"
	'this variable holds the page controller
	Public page As SDUIPage
	'usually for constants and other things
	Public app As SDUIApp
	'the variable referencing banano lib
	Private banano As BANano		'ignore
	Private Mode As String		'ignore
	Private srowcount As String					'ignore
	Private SDUICol1 As SDUICol					'ignore
	Private SDUIRow1 As SDUIRow					'ignore
	Private tbltablecrud As SDUITable			'ignore
End Sub
'
'show the page
Sub Show(duiapp As SDUIApp)			'ignore
	'get the reference to the app
	app = duiapp
	'build the page, via code or loadlayouts
	banano.Await(BuildPage)
End Sub
'
''the name of the page
Sub getName As String		'ignore
	Return name
End Sub
'
''the icon of the page
Sub getIcon As String		'ignore
	Return icon
End Sub
'
''the title of the page
Sub getTitle As String		'ignore
	Return title
End Sub
'
''the color
Sub getColor As String		'ignore
	Return color
End Sub
'
''back button clicked on the table action bar
Private Sub tbltablecrud_Back (e As BANanoEvent)
	e.PreventDefault
End Sub
'
''start building the page
Private Sub BuildPage
	banano.LoadLayout(app.PageViewer, "tablecrudlayout")
	'set the title of the table listing
	tbltablecrud.Title = "Table Colors"
	'define the callback for condition background color
	tbltablecrud.SetComputeRowBackgroundColor("ComputeBackgroundColorNome")
	'define the callback for the condition text color
	tbltablecrud.SetComputeRowTextColor("ComputeTextColorNome")
	'
	tbltablecrud.AddColumnAction("vedo","View","fa fa-binoculars",app.COLOR_BLUE)
	tbltablecrud.AddColumn("nome", "Articolo")
	tbltablecrud.AddColumn("qta", "Giacenza")
	tbltablecrud.AddDesignerColums
	
	'Mount the Vehicle Models
	banano.Await(mounted)
End Sub

'Load Vehicle Models to table
Sub mounted
	app.PagePause
	'Show loading indicator
	tbltablecrud.RefreshLoading = True
	'dummy data
	Dim lstJSON As String = $"[{"id":"i0jdpitkpxahrq4","idart":"6osktqlkb3peb9g","nome":"001 A1","qta":-1},
	{"id":"iqc1yc6ts9rp5sa","idart":"kzia9lx1dld4akv","nome":"002 ssssssssss","qta":7},
	{"id":"i8m4cqjpbsxnnaj","idart":"xkgtsujplsrlkgo","nome":"003 pizza napoletana","qta":2},
	{"id":"iqbeokycoftmn4i","idart":"1zzn134kunvjzx3","nome":"004 llllllllllllll","qta":-2.2},
	{"id":"isylzw5bqlwtpfd","idart":"x8wepmizblnotfq","nome":"005 kkkkkkkkkkk","qta":-2},
	{"id":"iogq6ic7a4osswi","idart":"ip6zo3zefi2r9bs","nome":"006 jjjjjjjjjjjjjjjjjjj","qta":-2},
	{"id":"itjmod1orczl84g","idart":"zn88nytqwfcsytm","nome":"010 ggggggggggggg","qta":10},
	{"id":"is8y27vf7hsnxpe","idart":"kxyn3jlprl96ess","nome":"016 SEDICI","qta":7}]"$
	'convert to list
	Dim lstResult As List = banano.FromJson(lstJSON)
	
	'Set items to the table with pagination
	banano.Await(tbltablecrud.SetItemsPaginate(lstResult))
	'
	'sum the totals of each of these columns
	Dim summary As Map = tbltablecrud.SetFooterTotalSumCountColumns(Array("id"))
	'get the total number of processed rows
	srowcount = summary.Get("rowcount")
	'format the value to be a thousand
	srowcount = SDUIShared.Thousands(srowcount)
	'set the first column to show the total
	tbltablecrud.SetFooterColumn(tbltablecrud.FirstColumnName, $"Total (${srowcount})"$)
	'Hide loading indicator
	tbltablecrud.RefreshLoading = False
	app.PageResume
End Sub
'

'this receives the row data being added to the table
Sub ComputeBackgroundColorNome(item As Map) As String
	'read the qta and convert it to js float
	Dim qta As Double = SDUIShared.CDbl(item.Get("qta"))
	If qta < 0 Then
		'red
		Return "#FF0000"
	Else
		Return ""	
	End If
End Sub


'this receives the row data being added to the table
Sub ComputeTextColorNome(item As Map) As String
	'read the qta and convert it to js float
	Dim qta As Double = SDUIShared.CDbl(item.Get("qta"))
	If qta < 0 Then
		'white
		Return "#FFFFFF"
	Else
		Return ""
	End If
End Sub


'Table refresh button click
Private Sub tbltablecrud_Refresh (e As BANanoEvent)
	e.PreventDefault
	banano.Await(mounted)
End Sub

'the previous button has been clicked
Private Sub tbltablecrud_PrevPage (e As BANanoEvent)
	e.PreventDefault
	tbltablecrud.SetFooterColumn(tbltablecrud.FirstColumnName, $"Total (${srowcount})"$)
End Sub
'
'the next button has been clicked
Private Sub tbltablecrud_NextPage (e As BANanoEvent)
	e.PreventDefault
	tbltablecrud.SetFooterColumn(tbltablecrud.FirstColumnName, $"Total (${srowcount})"$)
End Sub
