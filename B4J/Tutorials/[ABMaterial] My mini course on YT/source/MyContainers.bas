B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.3
@EndOfDesignText@

Sub Process_Globals
	Private ABM As ABMaterial
End Sub

Sub leftW(page As ABMPage) As ABMContainer

	
	Dim p As ABMContainer
'	p.PaddingRight = "5px"
	p.Initialize(page, "leftw", "left")
	#Region NOT SAVED: 2020-05-29T12:39:46
	'PHONE

	p.AddRowsM(3,True,0,0,"").AddCells12(1,"")
	p.BuildGrid ' IMPORTANT!
#End Region

	Dim l2 As ABMLabel
	l2.Initialize(page, "l2", "Left window", ABM.SIZE_H3, True, "")
	p.Cell(1,1).AddComponent(l2)
	
	Return p
End Sub


Sub rightW(page As ABMPage) As ABMContainer
	

	Dim p As ABMContainer
	p.Initialize(page, "rightw", "right")
	p.AddRowsM(3,True,0,0,"").AddCells12(1,"")
	p.BuildGrid ' IMPORTANT!
	Dim l3 As ABMLabel
	l3.Initialize(page, "l3", "Right window", ABM.SIZE_H3, True, "")
	

	Dim l3a As ABMInput
	l3a.Initialize(page, "input2", ABM.INPUT_TEXT, "Text", False, "inp")
	p.Cell(1,1).AddComponent(l3)
	p.Cell(2,1).AddComponent(l3a)
	
	Return p
End Sub

Sub lista(page As ABMPage) As ABMContainer
	Dim p As ABMContainer
	p.Initialize(page, "rightw", "right")
	p.AddRowsM(1,True,0,0,"").AddCells12(1,"")
	p.BuildGrid
	Dim list As ABMList
	list.InitializeWithMaxHeight(page, "list2", ABM.COLLAPSE_ACCORDION, 300, "")
	Dim li As List = DBM.SQLSelect(DBM.GetSQL, "select * from customers", Null)
	For Each m As Map In li
		Dim unique As String = m.Get("customerid")
		list.AddItem(unique, CreateLineList(page,unique, m.Get("lastname") &" " & m.Get("firstname")))
		list.AddSubItem(unique, "sub1_"&unique, CreateLineList(page,"sub1_"&unique, m.Get("country")&", "&m.Get("city")&", "&m.Get("address")))
		list.AddSubItem(unique, "sub2_"&unique, CreateLineList(page, "sub2_"&unique, m.Get("email")&", "&m.Get("phone")))
	Next
	p.Cell(1,1).AddComponent(list)
	
	Return p
End Sub

Sub CreateLineList(page As ABMPage,id As String, text As String) As ABMLabel
	Dim l As ABMLabel
	l.Initialize(page, id, text, ABM.SIZE_H5, True, "")
	Return l
End Sub