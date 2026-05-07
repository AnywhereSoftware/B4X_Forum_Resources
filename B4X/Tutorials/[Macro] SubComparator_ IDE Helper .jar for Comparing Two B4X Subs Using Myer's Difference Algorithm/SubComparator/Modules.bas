B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private fx As JFX 'ignore
	
	Public modulesA As Map
	Public modulesB As Map
	
	Private projectA, projectB As String
	Private moduleA, moduleB As String
	Private Albl, Blbl As B4XView
	Private CustomListView1 As CustomListView
	
	Private pnlx(3) As B4XView
	Private clv(3) As CustomListView
	Private titleLbls(3)  As B4XView
	Private browseA, browseB As B4XView

	Private selected As List
	
	Private fontSize As Int = 20
	Private busy As Boolean	
	Private yoffset As Float = 40

End Sub

Public Sub Initialize As Object
	selected.initialize
	Return Me
End Sub
	
Private Sub B4XPage_Created (Root1 As B4XView)
	busy = True
	Root = Root1
	SetMoveListener(B4XPages.GetNativeParent(Me))
	fontSize = (Max(Root.Width - 600, 0) / 200 + 17)
	For i = 0 To 2
		pnlx(i) = xui.CreatePanel("")
	Next
	Dim dummy As TextField: dummy.initialize("")
	Root.AddView(dummy, -100, -100, 10, 10)
	
	
	Root.AddView(pnlx(0), 10, yoffset, Root.Width / 3 - 10, Root.Height - 2 * yoffset)
	Root.AddView(pnlx(1), Root.Width / 3, yoffset, Root.Width / 3 - 10, Root.Height - 2 * yoffset)
	Root.AddView(pnlx(2), 2 * Root.Width / 3, yoffset, Root.Width / 3 - 10, Root.Height - 2 * yoffset)
	For i = 0 To 2
		pnlx(i).LoadLayout("CLV")
		clv(i) = CustomListView1
		pnlx(i).SetColorAndBorder(xui.Color_White, 1dip, xui.Color_Black, 10)
	Next
	For i = 0 To 2
		clv(i).GetBase.SetColorAndBorder(xui.Color_White, 0, 0, 0)
		clv(i).GetBase.TextSize = fontSize
		Dim sp As ScrollPane = clv(i).sv
		sp.Style="-fx-background:transparent;-fx-background-color:transparent;"
		sp.SetVScrollVisibility("AS_NEEDED")
	Next
	titleLbls(0) = addTitle(0, "Modules in A but not in B")
	titleLbls(1) = addTitle(1, "Common Modules")
	titleLbls(2) = addTitle(2, "Modules in B but not in A")

	Albl = addTitle2(0, projectA)
	Blbl = addTitle2(1, projectB)
	
	Dim browsxB As Button: browsxB.initialize("browseB")
	browseB = browsxB
	browseB.SetTextAlignment("CENTER", "CENTER")
	browseB.Font = xui.CreateDefaultFont(14)
	browseB.TextColor = xui.Color_Blue
	browseB.text = "Browse"
	Root.AddView(browseB, Root.Width - 100, Root.Height - 35, 80, (fontSize / 22) * 30)
	
	Dim browsxA As Button: browsxA.initialize("browseA")
	browseA = browsxA
	browseA.SetTextAlignment("CENTER", "CENTER")
	browseA.Font = xui.CreateDefaultFont(14)
	browseA.TextColor = xui.Color_Blue
	browseA.text = "Browse"
	Root.AddView(browseA, 10, Root.Height - 35, 80, (fontSize / 22) * 30)
	dummy.RequestFocus
End Sub

Private Sub b4xpage_CloseRequest As ResumableSub
	If titleLbls(0).Text.Contains("Subs") Then 
		show(projectA, projectB)
	Else	
		Return True
	End If
	Return False	
End Sub

Private Sub SetMoveListener(Form As JavaObject)
    Dim Stage As JavaObject = Form.GetField("stage")
    Dim XProp As JavaObject = Stage.RunMethod("xProperty",Null)
    Dim YProp As JavaObject = Stage.RunMethod("yProperty",Null)
   
    Dim O As Object = Form.CreateEventFromUI("javafx.beans.value.ChangeListener","FormMoved",Null)
    XProp.RunMethod("addListener",Array(O))
    YProp.RunMethod("addListener",Array(O))
End Sub

Private Sub addTitle(index As Int, txt As String) As B4XView
	Dim lbl As Label: lbl.Initialize("")
	Dim lblx As B4XView = lbl
	lblx.SetTextAlignment("CENTER", "CENTER")
	lblx.Font = xui.CreateDefaultFont(fontSize)
	lblx.TextColor = xui.Color_Blue
	lblx.text = txt
	Root.AddView(lblx, index * Root.Width / 3, 0, pnlx(index).Width, 40)
	Return lblx
End Sub

Private Sub addTitle2(index As Int, txt As String) As B4XView
	Dim lbl As Label: lbl.Initialize("")
	Dim lblx As B4XView = lbl
	lblx.SetTextAlignment("CENTER", "LEFT")
	lblx.Font = xui.CreateDefaultFont(fontSize)
	lblx.TextColor = xui.Color_Blue
	lblx.text = txt
	Dim w As Float = Root.Width / 2 - 120
	If index = 1 Then 
		lblx.SetTextAlignment("CENTER", "RIGHT")
		Root.AddView(lblx, Root.Width / 2, Root.Height - 40, w, 40)
	Else
		Root.AddView(lblx, 100, Root.Height - 40, w, 40)
	End If
	Return lblx
End Sub

Private Sub addCLVItem(clvIndex As Int, item As String)
	Dim clvx As CustomListView = clv(clvIndex)
	Dim pnl As B4XView = xui.CreatePanel("")
	pnl.Tag = clvIndex
	pnl.SetLayoutAnimated(0, 0, 0, clvx.getBase.width, (fontSize / 22) * 40)
	Dim lbl As Label: lbl.initialize("")
	Dim lblx As B4XView = lbl
	lblx.SetTextAlignment("CENTER", "LEFT")
	lblx.Font = xui.CreateDefaultFont(fontSize)
	lblx.TextColor = xui.Color_Black
	lblx.text = item
	pnl.AddView(lblx, 0, 0, pnl.Width, pnl.Height)
	clvx.Add(pnl, item)
End Sub

Public Sub show(projectA_ As String, projectB_ As String)
'	busy = True
	projectA = projectA_
	projectB = projectB_
	For i = 0 To 2
		clv(i).clear
		titleLbls(i).Text = titleLbls(i).Text.Replace("Subs", "Modules")
	Next
	selected.clear

	Albl.Text = "A = " & projectA
	Blbl.Text = "B = " & projectB
	
	Dim mainA As String = findMain(projectA)
	Dim mainB As String = findMain(projectB)
		
	Dim mpA As Map = FindProjectModules(projectA & "\" & mainA)
	Dim mpB As Map = FindProjectModules(projectB & "\" & mainB)
	
	modulesA = getMods(mpA, projectA & "\" & mainA)
	modulesB = getMods(mpB, projectB & "\" & mainB)
	
	Dim commonMods As List: commonMods.Initialize
	For Each modName As String In modulesA.Keys
		If Not(modulesB.ContainsKey(modName)) Then 
			addCLVItem(0, modName)
		Else
			commonMods.Add(modName)
		End If
	Next
	For Each modName As String In modulesB.Keys
		If Not(modulesA.ContainsKey(modName)) Then 
			addCLVItem(2, modName)
		End If
	Next
	For Each modName As String In commonMods
		addCLVItem(1, modName)
	Next
	Sleep(10)
	browseA.Visible = True
	browseB.Visible = True
	busy = False
End Sub

Private Sub findMain(project As String) As String
	Dim findMainX As String
	Dim files As List = File.ListFiles(project)
	Dim folders As List: folders.initialize
	For Each s As String In files
		Dim t As String = s.Trim.tolowercase
		If t.endsWith(".b4j") Or t.EndsWith(".b4a") Or t.EndsWith(".b4i") Then 
			findMainX = s
			Exit
		Else if File.IsDirectory(projectA, s) Then 
			folders.Add(s)
		End If
	Next
	Return findMainX
End Sub

Private Sub FindProjectModules(MainFile As String) As Map
    Dim result As Map = CreateMap()
    Dim ProjectDir As String = File.GetFileParent(MainFile)
    Dim lines As List = File.ReadList(MainFile, "")
    For Each line As String In lines
        If line = "@EndOfDesignText@" Then Exit
        Dim m As Matcher = Regex.Matcher("([^=]*)=(.*)", line)
        m.Find
        Dim key As String = m.Group(1)
        Dim value As String = m.Group(2)
        If key.StartsWith("Module") Then
            Dim path As String = DecodeModulePath(ProjectDir, value)
            Dim ModuleName As String = File.GetName(path)
            result.Put(ModuleName, path & ".bas")
        End If
    Next
    Return result
End Sub

Private Sub DecodeModulePath(ProjectDir As String, ModulePath As String) As String
    If ModulePath.StartsWith("|relative|") Then
        ModulePath = File.Combine(ProjectDir, ModulePath.SubString("|relative|".Length))
    Else If ModulePath.StartsWith("|absolute|") Then
        ModulePath = ModulePath.SubString("|absolute|".Length)
    Else
        ModulePath = File.Combine(ProjectDir, ModulePath)
    End If
    Return ModulePath
End Sub

Private Sub compareAB(A As List, B As List) As Boolean
	Dim tempA As List: tempA.Initialize
	For Each s As String In A
		s = s.Trim.toLowercase
		If s.Length > 0 Then 
			tempA.Add(s)
		End If
	Next
	Dim tempB As List: tempB.Initialize
	For Each s As String In B
		s = s.Trim.toLowercase
		If s.Length > 0 Then 
			tempB.Add(s)
		End If
	Next
	If tempA.Size <> tempB.Size Then Return False
	For i = 0 To tempA.Size - 1
		If Not(tempA.Get(i).As(String) = tempB.Get(i).As(String)) Then 
			Return False
		End If
	Next
	Return True
End Sub

Private Sub getMods(mp As Map, mainx As String) As Map
	Dim res As Map: res.initialize
	Dim files As List: files.initialize
	Dim modulesX As List: modulesX.initialize
	modulesX.Add("Main")
	files.Add(mainx)
	For Each module As String In mp.keys
		files.add(mp.Get(module))
		modulesX.Add(module)
	Next
	For i = 0 To modulesX.Size - 1
		Dim f As String = files.Get(i)
		Dim folder As String = File.GetFileParent(f)
		Dim fname As String = File.GetName(f)
		Dim lines As List = File.ReadList(folder, fname)
		Dim subs As Map = getSubs(lines)
		res.Put(modulesX.Get(i), subs)
	Next
	Return res
End Sub

Private Sub getSubs(lines As List) As Map
	Dim res As Map: res.initialize
	Dim prefix As Boolean = True
	Dim currentSub As String
	Dim lastSub As String
	For i = 0 To lines.Size - 1
		Dim s As String = lines.Get(i)
		If s = "@EndOfDesignText@" Then 
			prefix = False
			Continue
		End If
		If Not(prefix) Then 
			Dim t As String = s.toLowerCase.trim
			t = t.Replace("  ", " ")
			Dim k1 As Int = t.IndexOf("(")
			Dim k2 As Int = t.IndexOf(" as ")
			Dim k As Int
			If k1 > -1 And k2 > -1 Then 
				k = Min(k1, k2)
			Else if k1 = -1 And k2 = -1 Then 
				k = t.length
			Else if k1 = -1 And k2 > -1 Then 
				k = k2						
			Else if k1 > -1 And k2 = -1 Then 
				k = k1						
			End If
			If t.startswith("private sub ") Then 
				currentSub = t.SubString2(12, k).trim
			else if t.startswith("public sub ") Then 
				currentSub = t.SubString2(11, k).trim
			else if t.startswith("sub ") Then 
				currentSub = t.SubString2(4, k).trim
			End If
			If currentSub <> lastSub Then
				Dim subLines As List: subLines.initialize
				For j = i To lines.Size - 1
					Dim s As String = lines.Get(j)
					Dim t As String = s.toLowerCase.trim
					subLines.Add(s)
					If t.StartsWith("end sub") Then 
						i = j
						res.Put(currentSub, subLines)
						Exit
					End If
				Next
				lastSub = currentSub
			End If
		End If
	Next
	Return res
End Sub

Private Sub CustomListView1_ItemClick (Index As Int, Value As Object)
	Dim clvx As CustomListView = Sender
	Dim pnl As B4XView = clvx.GetPanel(Index)
	Dim lblx As B4XView = pnl.GetView(0)
	Dim clvIndex As Int = pnl.tag
	If lblx.TextColor = xui.Color_Blue Then 
		lblx.TextColor = xui.Color_Black
		selected.RemoveAt(selected.IndexOf(Value & TAB & clvIndex))
	Else
		lblx.TextColor = xui.Color_Blue
		selected.Add(Value & TAB & clvIndex)
	End If
	If selected.Size > 1 Then 
		If titleLbls(0).Text.Contains("Modules") Then reloadWithSubs Else compareSubs
	Else if selected.Size = 1 Then 
		Dim clvInx As String = selected.Get(0).As(String)
		clvInx = clvInx.Substring(clvInx.indexOf(TAB) + 1)
		If clvInx = "1" Then 
			If titleLbls(0).Text.Contains("Modules") Then reloadWithSubs Else compareSubs
		End If
	End If
End Sub

Private Sub compareSubs
	Dim subNameA, subNameB, subNameX As String
	If selected.Size = 1 Then
		Dim SubX As String =  selected.Get(0).As(String)
		subNameA = SubX.SubString2(0, SubX.IndexOf(TAB))
		If SubX.Contains(" ") Then subNameA = SubX.SubString2(0, SubX.IndexOf(" "))
		subNameB = subNameA
	Else
		Dim clvInx As String = selected.Get(0).As(String)
		clvInx = clvInx.Substring(clvInx.indexOf(TAB) + 1)
		Select clvInx
			Case "0"
				Dim SubX As String =  selected.Get(0).As(String)
				subNameA = SubX.SubString2(0, SubX.IndexOf(TAB))
				If SubX.Contains(" ") Then subNameA = SubX.SubString2(0, SubX.IndexOf(" "))
			Case "1"
				Dim SubX As String =  selected.Get(0).As(String)
				subNameX = SubX.SubString2(0, SubX.IndexOf(TAB))
				If SubX.Contains(" ") Then subNameX = SubX.SubString2(0, SubX.IndexOf(" "))
			Case "2"				
				Dim SubX As String =  selected.Get(0).As(String)
				subNameB = SubX.SubString2(0, SubX.IndexOf(TAB))
				If SubX.Contains(" ") Then subNameB = SubX.SubString2(0, SubX.IndexOf(" "))
		End Select
		Dim clvInx As String = selected.Get(1).As(String)
		clvInx = clvInx.Substring(clvInx.indexOf(TAB) + 1)
		Select clvInx
			Case "0"
				Dim SubX As String =  selected.Get(1).As(String)
				subNameA = SubX.SubString2(0, SubX.IndexOf(TAB))
				If SubX.Contains(" ") Then subNameA = SubX.SubString2(0, SubX.IndexOf(" "))
			Case "1"
				Dim SubX As String =  selected.Get(1).As(String)
				subNameX = SubX.SubString2(0, SubX.IndexOf(TAB))
				If SubX.Contains(" ") Then subNameX = SubX.SubString2(0, SubX.IndexOf(" "))
			Case "2"				
				Dim SubX As String =  selected.Get(1).As(String)
				subNameB = SubX.SubString2(0, SubX.IndexOf(TAB))
				If SubX.Contains(" ") Then subNameB = SubX.SubString2(0, SubX.IndexOf(" "))
		End Select
		If subNameA.Length = 0 Then subNameA = subNameX
		If subNameB.Length = 0 Then subNameB = subNameX
	End If
	
	Dim diff As ShowDif = B4XPages.GetPage("diff")
	diff.show(projectA, moduleA, subNameA, projectB, moduleB, subNameB)
	B4XPages.ShowPage("diff")
    Dim form As Form = B4XPages.GetNativeParent(Me)
	diff.moveForm(form.WindowLeft, form.WindowTop)
End Sub

Private Sub reloadWithSubs
	For i = 0 To 2
		clv(i).clear
		titleLbls(i).Text = titleLbls(i).Text.Replace("Modules", "Subs")
	Next
	Dim modNameA, modNameB, modNameX As String
	If selected.Size = 1 Then
		Dim SubX As String =  selected.Get(0).As(String)
		modNameA = SubX.SubString2(0, SubX.IndexOf(TAB))
		modNameB = modNameA
	Else if selected.Size >= 1 Then 
		Dim clvInx As String = selected.Get(0).As(String)
		clvInx = clvInx.Substring(clvInx.indexOf(TAB) + 1)
		Select clvInx
			Case "0"
				Dim SubX As String =  selected.Get(0).As(String)
				modNameA = SubX.SubString2(0, SubX.IndexOf(TAB))
			Case "1"
				Dim SubX As String =  selected.Get(0).As(String)
				modNameX = SubX.SubString2(0, SubX.IndexOf(TAB))
			Case "2"				
				Dim SubX As String =  selected.Get(0).As(String)
				modNameB = SubX.SubString2(0, SubX.IndexOf(TAB))
		End Select
		Dim clvInx As String = selected.Get(1).As(String)
		clvInx = clvInx.Substring(clvInx.indexOf(TAB) + 1)
		Select clvInx
			Case "0"
				Dim SubX As String =  selected.Get(1).As(String)
				modNameA = SubX.SubString2(0, SubX.IndexOf(TAB))
			Case "1"
				Dim SubX As String =  selected.Get(1).As(String)
				modNameX = SubX.SubString2(0, SubX.IndexOf(TAB))
			Case "2"				
				Dim SubX As String =  selected.Get(1).As(String)
				modNameB = SubX.SubString2(0, SubX.IndexOf(TAB))
		End Select
		If modNameA.Length = 0 Then modNameA = modNameX
		If modNameB.Length = 0 Then modNameB = modNameX
	End If
	selected.clear
	moduleA = modNameA
	moduleB = modNameB

	Albl.Text = "A = " & projectA & "\" & moduleA
	Blbl.Text = "B = " & projectB & "\" & moduleB
	
	Dim commonSubs As List: commonSubs.Initialize
	Dim subsA As Map = modulesA.Get(moduleA)
	Dim subsB As Map = modulesB.Get(moduleB)
	For Each subname As String In subsA.Keys
		If Not(subsB.ContainsKey(subname)) Then 
			addCLVItem(0, $"${subname}"$)
		Else
			commonSubs.Add(Array(moduleA, subname))
		End If
	Next
	Dim subsA As Map = modulesA.Get(moduleA)
	Dim subsB As Map = modulesB.Get(moduleB)
	For Each subname As String In subsB.Keys
		If Not(subsA.ContainsKey(subname)) Then 
			addCLVItem(2, $"${subname}"$)
		End If
	Next
	For Each ar() As Object In commonSubs
		Dim module As String = ar(0)
		Dim subname As String = ar(1)
		Dim subsA As Map = modulesA.Get(module)
		Dim subsB As Map = modulesB.Get(module)
		Dim A As List = subsA.Get(subname)
		Dim B As List = subsB.Get(subname)
		Dim isSame As Boolean = compareAB(A, B)
		If isSame Then 
			addCLVItem(1, $"${subname} A=B"$)
		Else 
			addCLVItem(1, $"${subname} A${Chr(0x2260)}B"$)
		End If
	Next
	browseA.Visible = False
	browseB.Visible = False
End Sub

Private Sub BrowseA_Click
	B4XPages.MainPage.resetModuleA
End Sub

Private Sub BrowseB_Click
	B4XPages.MainPage.resetModuleB
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	If busy Then Return
    Dim F As Form = B4XPages.GetNativeParent(Me)
	Dim diff As ShowDif = B4XPages.GetPage("diff")
	diff.resizeForm(F.WindowWidth, F.WindowHeight)
	
	fontSize = (Max(F.WindowWidth - 600, 0) / 200 + 17)
	Dim yoffset As Float = 40
	For i = 0 To 2
		If i = 0 Then 
			pnlx(i).SetLayoutAnimated(0, i * Root.Width / 3 + 10, yoffset, Root.Width / 3 - 20, Root.height - 2 * yoffset)
		Else
			pnlx(i).SetLayoutAnimated(0, i * Root.Width / 3, yoffset, Root.Width / 3 - 10, Root.height - 2 * yoffset)	
		End If
		clv(i).GetBase.font = xui.CreateDefaultFont(fontSize)
		For j = 0 To clv(i).size - 1
			clv(i).GetPanel(j).GetView(0).font = xui.CreateDefaultFont(fontSize)
		Next
		titleLbls(i).Font = xui.CreateDefaultFont(fontSize)
		titleLbls(i).SetLayoutAnimated(0, i * Root.Width / 3, 0, pnlx(i).Width, 40)	
		clv(i).Refresh
	Next
	Albl.SetLayoutAnimated(0, 60, Root.Height - 40, Root.Width / 2 - 50, 40)
	Blbl.SetLayoutAnimated(0, Root.Width / 2, Root.Height - 40, Root.Width / 2 - 120, 40)
	Albl.Font = xui.CreateDefaultFont(fontSize)
	Blbl.Font = xui.CreateDefaultFont(fontSize)
	browseA.SetLayoutAnimated(0, 10, Root.Height - 35, 80, 30)
	browseB.SetLayoutAnimated(0, Root.Width - 100, Root.Height - 35, 80, 30)
End Sub

Private Sub FormMoved_Event (MethodName As String, Args() As Object)
	If busy Then Return
    Dim F As Form = Sender
	Dim diff As ShowDif = B4XPages.GetPage("diff")
	diff.moveForm(F.WindowLeft, F.WindowTop)
End Sub

Public Sub resizeForm(Width As Float, Height As Float)
	busy = True
    Dim form As Form = B4XPages.GetNativeParent(Me)
    form.WindowWidth = Width
	form.WindowHeight = Height
	busy = False
End Sub

Public Sub moveForm(Left As Float, Top As Float)
	busy = True
    Dim form As Form = B4XPages.GetNativeParent(Me)
    form.WindowLeft = Left
	form.WindowTop = Top
	busy = False
End Sub

Public Sub clearSelection
	For i = 0 To 2
		For j = 0 To clv(i).Size -1
			clv(i).GetPanel(j).GetView(0).Textcolor = xui.color_Black
		Next
	Next
	selected.clear
End Sub