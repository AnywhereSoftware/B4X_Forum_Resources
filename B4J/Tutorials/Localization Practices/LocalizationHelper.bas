B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub

Sub Export
	Dim map1 As Map
	map1.Initialize
	ExportLayoutText(map1)
	ExportInCodeString(map1)
	ExportMaptoXLSX(map1)
End Sub

Sub ExportLayoutText(map1 As Map)
	Dim frm As Form
	frm.Initialize("frm",600,200)
	Dim assets As String
	assets=File.Combine(File.GetFileParent(File.DirApp),"Files")
	If File.Exists(assets,"")=False Then
		Return
	End If
	For Each filename As String In File.ListFiles(assets)
		If filename.ToLowerCase.EndsWith(".bjl") Then
			frm.RootPane.RemoveAllNodes
			frm.RootPane.LoadLayout(Utils.GetFilenameWithoutExtension(filename))
			
			If frm.Title<>"" Then
				Dim transUnit As Map
				transUnit.Initialize
				transUnit.Put("type","Form Title")
				transUnit.Put("note",filename)
				transUnit.Put("text",frm.Title)
				map1.Put(frm.Title.ToLowerCase,transUnit)
			End If
			
			For Each node As Object In frm.RootPane.GetAllViewsRecursive
				Dim transUnit As Map
				transUnit.Initialize
				transUnit.Put("type",GetType(node))
				transUnit.Put("note",filename)
				Dim n As Node=node
				If n Is TextArea Then
					Dim ta As TextArea = n
					transUnit.Put("text",ta.Text)
				Else If n Is TextField Then
					Dim tf As TextField = n
					transUnit.Put("text",tf.Text)
				Else if n Is Button Then
					Dim btn As Button = n
					transUnit.Put("text",btn.Text)
				Else if n Is CheckBox Then
					Dim cbx As CheckBox = n
					transUnit.Put("text",cbx.Text)
				Else If n Is RadioButton Then
					Dim rbtn As RadioButton = n
					transUnit.Put("text",rbtn.Text)
				Else If n Is ToggleButton Then
					Dim tbtn As ToggleButton = n
					transUnit.Put("text",tbtn.Text)
				Else If n Is Label Then
					Dim lbl As Label = n
					transUnit.Put("text",lbl.Text)
				else if n Is ListView Then
					Dim lv As ListView = n
					If lv.ContextMenu.IsInitialized Then
						ExportMenuItems(lv.ContextMenu.MenuItems,transUnit,map1)
					End If
					Continue
				else if n Is MenuBar Then
					Dim mb As MenuBar = n
					ExportMenuItems(mb.Menus,transUnit,map1)
					Continue
				else if n Is TableView Then
					Dim tv As TableView=n
					ExportTableViewColumns(tv,transUnit,map1)
					Continue
				End If
				If transUnit.ContainsKey("text") Then
					Dim text As String=transUnit.Get("text")
					map1.Put(text.ToLowerCase,transUnit)
				End If
			Next
		End If
	Next
End Sub

Sub ExportTableViewColumns(tv As TableView,transUnit As Map,map1 As Map)
    For i=0 To tv.ColumnsCount-1
		Dim text As String=tv.GetColumnHeader(i)
		Dim newTU As Map
		newTU.Initialize
		For Each key As String In transUnit.Keys
			newTU.Put(key,transUnit.Get(key))
		Next
		newTU.Put("text",text)
		map1.Put(text.ToLowerCase,newTU)
    Next
End Sub


Sub ExportMenuItems(MenuItems As List,transUnit As Map,map1 As Map)
	For Each item As Object In MenuItems
		If item Is Menu Then
			Dim m As Menu=item
			AppendMenuItem(m.Text,transUnit,map1)
			ExportMenuItems(m.MenuItems,transUnit,map1)
		else if item Is MenuItem Then
			Dim mi As MenuItem=item
			AppendMenuItem(mi.Text,transUnit,map1)
		End If
	Next
End Sub

Sub AppendMenuItem(text As String, transUnit As Map,map1 As Map)
	Try
		Dim newTU As Map
		newTU.Initialize
		For Each key As String In transUnit.Keys
			newTU.Put(key,transUnit.Get(key))
		Next
		newTU.Put("text",text)
		map1.Put(text.ToLowerCase,newTU)
	Catch
		Log(LastException)
	End Try
End Sub

Sub ExportInCodeString(map1 As Map)
	Dim projectDir As String = File.GetFileParent(File.DirApp)
	For Each filename As String In File.ListFiles(projectDir)
		If filename.EndsWith(".bas") Or filename.EndsWith(".b4j") Then
		    Dim strings As List
			strings.Initialize
			Dim content As String = File.ReadString(projectDir,filename)
			Dim matcher1 As Matcher=Regex.Matcher($"\.Localize\("(.*?)"\)"$,content)
			Do While matcher1.Find
				strings.Add(matcher1.Group(1))
			Loop
			stringsToMap(strings,map1)
		End If
	Next
End Sub

Sub stringsToMap(strings As List,map1 As Map)
	For Each s As String In strings
		Dim transUnit As Map
		transUnit.Initialize
		transUnit.Put("type","code")
		transUnit.Put("note","")
		transUnit.Put("text",s)
		map1.Put(s.ToLowerCase,transUnit)
	Next
End Sub

Sub ExportMaptoXLSX(map1 As Map)
	Dim wb As PoiWorkbook
	wb.InitializeNew(True)
	Dim sheet1 As PoiSheet = wb.AddSheet("Sheet1",0)
	Dim head As PoiRow=sheet1.CreateRow(0)
	head.CreateCellString(0,"key")
	head.CreateCellString(1,"type")
	head.CreateCellString(2,"note")
	For Each key As String In map1.Keys
		If key<>"" Then
			Dim row As PoiRow=sheet1.CreateRow(sheet1.LastRowNumber+1)
			Dim transUnit As Map=map1.Get(key)
			row.CreateCellString(0,transUnit.Get("text"))
			row.CreateCellString(1,transUnit.Get("type"))
			row.CreateCellString(2,transUnit.Get("note"))
		End If
	Next
	wb.Save(File.DirApp,"strings.xlsx")	
End Sub

