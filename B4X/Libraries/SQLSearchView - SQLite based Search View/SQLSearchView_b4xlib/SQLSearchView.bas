B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Public mBase As B4XView
	Public CustomListView1 As CustomListView
	Private xDialog As B4XDialog
	Public SearchField As B4XFloatTextField
	Public TextHighlightColor As Int = 0xFFFD5C5C
	Public ItemHightlightColor As Int = 0x7E008EFF
	Private MAX_LIMIT = 4 As Int
	Public MaxNumberOfItemsToShow As Int = 100
	Private ItemsCache As List
	Public SelectedItem As String
	Private LastTerm As String
	#if B4A
	Private IME As IME
	#End If
	Public AllowUnlistedText As Boolean
	Public SQL As SQL
	Public AllItemsToDisplay As List
	Private TextChangedIndex As Int
End Sub

Public Sub Initialize
	mBase = xui.CreatePanel("mBase")
	Dim height As Int
	If xui.IsB4A Or xui.IsB4i Then height = 220dip Else height = 300dip
	mBase.SetLayoutAnimated(0, 0, 0, 300dip, height)
	mBase.LoadLayout("SearchTemplate")
	mBase.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)
	CustomListView1.sv.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)
	CustomListView1.DefaultTextBackgroundColor = 0xFF555555
	CustomListView1.DefaultTextColor = xui.Color_White
	#if B4J
	Dim sv As ScrollPane = CustomListView1.sv
	sv.StyleClasses.Add("b4xdialog")
	sv.InnerNode.StyleClasses.Add("b4xdialog")
	#if DEBUG
	Dim jo As JavaObject = Me
	jo.RunMethod("RemoveWarning", Null)
	#End If
	#end if
	ItemsCache.Initialize
	#if B4A
	IME.Initialize("")
	Dim jo As JavaObject = SearchField.TextField
	jo.RunMethod("setImeOptions", Array(Bit.Or(33554432, 6))) 'IME_FLAG_NO_FULLSCREEN | IME_ACTION_DONE
	#End If
End Sub

Public Sub Resize(Width As Int, Height As Int)
	mBase.SetLayoutAnimated(0, 0, 0, Width, Height)
	Dim c As B4XView = CustomListView1.AsView
	c.SetLayoutAnimated(0, 0, c.Top, Width, Height - c.Top)
	CustomListView1.Base_Resize(Width, c.Height)
End Sub

Public Sub GetPanel (Dialog As B4XDialog) As B4XView
	Return mBase
End Sub

Private Sub Show (Dialog As B4XDialog)
	xDialog = Dialog
	xDialog.PutAtTop = xui.IsB4A Or xui.IsB4i
	CustomListView1.AsView.Color = xui.Color_Transparent
	CustomListView1.sv.Color = xui.Color_Transparent
	mBase.Color = xui.Color_Transparent
	Sleep(20)
	Update("", True)
	CustomListView1.JumpToItem(0)
	SearchField.Text = ""
	SearchField.TextField.RequestFocus
	#if B4A
	IME.ShowKeyboard(SearchField.TextField)
	#end if
End Sub

Private Sub SearchField_TextChanged (Old As String, New As String)
	TextChangedIndex = TextChangedIndex + 1
	Dim MyIndex As Int = TextChangedIndex
	Sleep(100)
	If MyIndex <> TextChangedIndex Then Return
	Update(New, False)
End Sub

Private Sub Update(Term As String, Force As Boolean)
	If Term = LastTerm And Force = False Then Return
	LastTerm = Term
	If xui.IsB4J = False Then
		For i = 0 To CustomListView1.Size - 1
			Dim p As B4XView = CustomListView1.GetPanel(i)
			p.RemoveViewFromParent
			ItemsCache.Add(p)
		Next
	End If
	CustomListView1.Clear
	
	Dim str1, str2 As String
	str1 = Term.ToLowerCase
	If Term = "" Then
		
		AddItemsToList(AllItemsToDisplay, str1)
	Else
		If str1.Length > MAX_LIMIT Then
			str2 = str1.SubString2(0, MAX_LIMIT)
		Else
			str2 = str1
		End If
		AddItemsToList(GetList("prefix", str2), str1)
		AddItemsToList(GetList("substring", str2), str1)
	End If
End Sub

Private Sub GetList (TableName As String, Query As String) As List
	Dim rs As ResultSet = SQL.ExecQuery2($"SELECT terms FROM ${TableName} WHERE query = ?"$, Array As String(Query))
	If rs.NextRow = False Then
		rs.Close
		Return Array()
	Else
		Dim ser As B4XSerializator
		Dim result As List = ser.ConvertBytesToObject(rs.GetBlob2(0))
		For i = 0 To result.Size - 1
			'convert the term ids with the actual terms
			Dim index As Int = result.Get(i)
			Dim term As String = SQL.ExecQuerySingleResult2("SELECT term FROM terms WHERE id = ?", Array As String(index))
			result.Set(i, term)
		Next
		rs.Close
		Return result
	End If
End Sub


Private Sub SearchField_EnterPressed
	If AllowUnlistedText Then
		SelectedItem = LastTerm
		xDialog.Close(xui.DialogResponse_Positive)
	Else If CustomListView1.Size > 0 And LastTerm.Length > 0 Then
		CustomListView1_ItemClick(0, CustomListView1.GetValue(0))
	End If
End Sub


Private Sub CustomListView1_ItemClick (Index As Int, Value As Object)
	If Value = "" Then Return
	SelectedItem = Value
	xDialog.Close(xui.DialogResponse_Positive)
End Sub

Private Sub AddItemsToList(li As List, full As String)
	If li.IsInitialized = False Then Return
	#if B4J
	Dim tf As B4JTextFlow
	tf.Initialize
	#End If
	For i = 0 To li.Size - 1
		If CustomListView1.Size >= MaxNumberOfItemsToShow Then Return
		Dim item As String = li.Get(i)
		Dim x As Int = item.ToLowerCase.IndexOf(full)
		If x = -1 Then
			Continue
		End If
		Dim pnlColor As Int
		If CustomListView1.Size = 0 And full.Length > 0 And AllowUnlistedText = False Then 
			pnlColor = ItemHightlightColor 
		Else 
			pnlColor = CustomListView1.DefaultTextBackgroundColor
		End If
		#if B4A or B4i
		Dim cs As CSBuilder
		cs.Initialize.Append(item.SubString2(0, x)).Color(TextHighlightColor).Append(item.SubString2(x, x + full.Length)).Pop
		cs.Append(item.SubString(x + full.Length))
		If ItemsCache.Size > 0 Then
			Dim p As B4XView = ItemsCache.Get(ItemsCache.Size - 1)
			ItemsCache.RemoveAt(ItemsCache.Size - 1)
			#if B4A
			p.GetView(0).Text = cs
			#else if B4i
			Dim lbl As Label = p.GetView(0)
			lbl.AttributedText = cs
			#End If
			p.Color = pnlColor
			CustomListView1.Add(p, item)
		Else
			CustomListView1.AddTextItem(cs, item)
		End If
		#Else
		tf.Reset
		If x > 0 Then
			tf.Append(item.SubString2(0, x)).SetColor(CustomListView1.DefaultTextColor)
		End If
		If full.Length > 0 Then
			tf.Append(item.SubString2(x, x + full.Length)).SetColor(TextHighlightColor)
		End If
		If x + full.Length < item.Length Then
			tf.Append(item.SubString(x + full.Length)).SetColor(CustomListView1.DefaultTextColor)
		End If
		Dim p As B4XView = xui.CreatePanel("")
		p.SetLayoutAnimated(0, 0, 0, CustomListView1.AsView.Width, 60dip)
		Dim TextPane As B4XView = tf.CreateTextFlow
		p.AddView(TextPane, 0, p.Height / 2 - 12, p.Width, p.Height / 2)
		p.Color = pnlColor
		CustomListView1.Add(p, item)
		#End If
	Next
	For i = 0 To li.Size - 1
		Dim item As String = li.Get(i)
		Dim x As Int = item.ToLowerCase.IndexOf(full)
		If x = -1 Then
			Continue
		End If
	Next
End Sub

Public Sub LoadDatabase (Dir As String, FileName As String) As ResumableSub
	If Dir = File.DirAssets Then
		Dir = xui.DefaultFolder
		If File.Exists(xui.DefaultFolder, FileName) Then
			Log("reusing previously copied file: " & File.Combine(xui.DefaultFolder, FileName))
		Else
			Log("Copying file to: " & xui.DefaultFolder)
			Wait For (File.CopyAsync(File.DirAssets, FileName, xui.DefaultFolder, FileName)) Complete (Success As Boolean)
		End If
	End If
	#if B4A or B4i
		SQL.Initialize(Dir, FileName, False)
	#else
		SQL.InitializeSQLite(Dir, FileName, False)
	#End If
	AllItemsToDisplay.Initialize
	Dim rs As ResultSet = SQL.ExecQuery2("SELECT term FROM terms ORDER BY id ASC LIMIT ?", Array As String(MaxNumberOfItemsToShow))
	Do While rs.NextRow
		AllItemsToDisplay.Add(rs.GetString2(0))
	Loop
	rs.Close
	Log("Database ready")
	Return True
End Sub

#if B4J
Public Sub BuildDatabase (Dir As String, FileName As String, Items As List)
	Dim startTime As Long = DateTime.Now
	File.Delete(Dir, FileName)
	SQL.InitializeSQLite(Dir, FileName, True)
	SQL.ExecNonQuery("PRAGMA journal_mode = DELETE")
	SQL.ExecNonQuery("CREATE TABLE terms (id INTEGER PRIMARY KEY , term TEXT)")
	SQL.ExecNonQuery("CREATE TABLE prefix (query TEXT, terms BLOB)")
	SQL.ExecNonQuery("CREATE INDEX prefix_index ON prefix (query)")
	SQL.ExecNonQuery("CREATE TABLE substring (query TEXT, terms BLOB)")
	SQL.ExecNonQuery("CREATE INDEX substring_index ON substring (query)")
	Dim o() As Object = SetItems(Items)
	Dim prefixList = o(0), substringList = o(1) As Map
	SQL.BeginTransaction
	Dim ser As B4XSerializator
	For i = 0 To Items.Size - 1
		SQL.ExecNonQuery2("INSERT INTO terms VALUES (?, ?)", Array(i, Items.Get(i)))
	Next
	For Each m As Map In Array(prefixList, substringList)
		Dim TableName As String = IIf(m = prefixList, "prefix", "substring")
		For Each q As String In m.Keys
			Dim li As List = m.Get(q)
			Dim b() As Byte = ser.ConvertObjectToBytes(li)
			SQL.ExecNonQuery2($"INSERT INTO ${TableName} VALUES (?, ?)"$, Array(q, b))
		Next
	Next
	SQL.TransactionSuccessful
	Log("Index time: " & (DateTime.Now - startTime) & " ms (" & Items.Size & " Items)")
End Sub


Private Sub SetItems(Items As List) As Object
	
	Dim noDuplicates As B4XSet
	noDuplicates.Initialize
	Dim prefixList, substringList As Map
	prefixList.Initialize
	substringList.Initialize
	Dim m As Map
	Dim li As List
	For i = 0 To Items.Size - 1
		Dim item As String = Items.Get(i).As(String).ToLowerCase
		noDuplicates.Clear
		For start = 0 To item.Length
			Dim count As Int = 1
			Do While count <= MAX_LIMIT And start + count <= item.Length
				Dim str As String = item.SubString2(start, start + count)
				If noDuplicates.Contains(str) = False Then
					noDuplicates.Add(str)
					If start = 0 Then m = prefixList Else m = substringList
					li = m.Get(str)
					If li.IsInitialized = False Then
						li.Initialize
						m.Put(str, li)
					End If
					If li.Size < MaxNumberOfItemsToShow or count = MAX_LIMIT Then
						li.Add(i) 
					End If
				End If
				count = count + 1
			Loop
		Next
	Next

	Return Array(prefixList, substringList)
End Sub
#end if

Private Sub DialogClosed(Result As Int) 'ignore

End Sub

#if DEBUG
#if JAVA
public void RemoveWarning() throws Exception{
	anywheresoftware.b4a.shell.Shell s = anywheresoftware.b4a.shell.Shell.INSTANCE;
	java.lang.reflect.Field f = s.getClass().getDeclaredField("errorMessagesForSyncEvents");
	f.setAccessible(true);
	java.util.HashSet<String> h = (java.util.HashSet<String>)f.get(s);
	if (h == null) {
		h = new java.util.HashSet<String>();
		f.set(s, h);
	}
	h.add("tf_focuschanged");
}
#End If
#End If

