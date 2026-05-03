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
	
	Private TextPnl As B4XView
	Private Label1 As B4XView
	Private Label2 As B4XView
	Private Label3 As B4XView
	
	Private modulesA As Map
	Private modulesB As Map
	Private mods As Modules
	Private CustomListView1 As CustomListView
	Private A,B As List
	
	Private fontSize As Int = 20
	Public busy As Boolean	
End Sub

Public Sub Initialize As Object
	Return Me
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	busy = True
	Root = Root1
	SetMoveListener(B4XPages.GetNativeParent(Me))
	fontSize = (Max(Root.Width - 600, 0) / 200 + 17)

	Dim lbl1 As Label: lbl1.initialize("")
	Label1 = lbl1
	Label1.TextSize = fontSize
	Label1.SetTextAlignment("CENTER", "CENTER")
	Root.AddView(Label1, 10, 0, Root.width / 2, 30)
	
	Dim lbl2 As Label: lbl2.initialize("")
	Label2 = lbl2
	Label2.TextSize = fontSize
	Label2.SetTextAlignment("CENTER", "CENTER")
	Root.AddView(Label2, Root.width / 2, 0, Root.width / 2, 30)

	Dim lbl3 As Label: lbl3.initialize("")
	Label3 = lbl3
	Label3.TextSize = fontSize
	Label3.SetTextAlignment("CENTER", "CENTER")
	Root.AddView(Label3, 0, 20, Root.width, 30)
	
	TextPnl = xui.CreatePanel("")
	Root.AddView(TextPnl, 10, 50, Root.Width - 20, Root.Height - 60)
	TextPnl.LoadLayout("CLV")
	TextPnl.SetColorAndBorder(xui.Color_White, 1, xui.Color_Black, 10)
	CustomListView1.GetBase.SetColorAndBorder(xui.Color_White, 0, 0, 0)
	CustomListView1.GetBase.TextSize = fontSize
	Dim sp As ScrollPane = CustomListView1.sv
	sp.Style="-fx-background:transparent;-fx-background-color:transparent;"
	sp.SetVScrollVisibility("AS_NEEDED")
End Sub

Private Sub SetMoveListener(Form As JavaObject)
    Dim Stage As JavaObject = Form.GetField("stage")
    Dim XProp As JavaObject = Stage.RunMethod("xProperty",Null)
    Dim YProp As JavaObject = Stage.RunMethod("yProperty",Null)
   
    Dim O As Object = Form.CreateEventFromUI("javafx.beans.value.ChangeListener","FormMoved",Null)
    XProp.RunMethod("addListener",Array(O))
    YProp.RunMethod("addListener",Array(O))
End Sub

Public Sub show(projectA As String, moduleA As String, subNameA As String, projectB As String, moduleB As String, subNameB As String)
	mods = B4XPages.GetPage("mods")
	modulesA = mods.modulesA
	modulesB = mods.modulesB
	Label1.text = projectA & ": " & moduleA
	Label2.text = projectB & ": " & moduleB
	displayDif(moduleA, moduleB, subNameA, subNameB)
	Sleep(10)
	busy = False
End Sub

Private Sub Button2_Click
End Sub

Private Sub displayDif(moduleA As String, moduleB As String, subnameA As String, subnameB As String)
	Dim subsA As Map = modulesA.Get(moduleA)
	Dim subsB As Map = modulesB.Get(moduleB)
	A = subsA.Get(subnameA)
	B = subsB.Get(subnameB)
	Dim isSame As Boolean = compareAB
	If isSame Then Label3.Text = "They have the same code!" Else Label3.Text = ""

	Dim md As MyersDiff
	md.Initialize
    
	Dim list1 As List: list1.initialize
	For Each s As String In A
		Dim t As String = s.Trim.ToLowerCase.Replace(" ", "")
		list1.Add(t)
	Next

	Dim list2 As List: list2.initialize
	Dim mp2 As Map: mp2.initialize
	For Each s As String In B
		Dim t As String = s.Trim.ToLowerCase.Replace(" ", "")
		list2.Add(t)
	Next
		
    Dim diffs As List = md.Compare(list1, list2)
	list1.clear
	Dim indexA As Int
    For Each ds As DiffStep In diffs
        Select ds.Operation
            Case "EQUAL"
				list1.Add(A.get(indexA))
				indexA = indexA + 1
            Case "INSERT"
                list1.Add("")
            Case "DELETE"
				list1.Add(A.get(indexA))
				indexA = indexA + 1
        End Select
    Next
	list2.clear
	Dim indexB As Int
    For Each ds As DiffStep In diffs
        Select ds.Operation
            Case "EQUAL"
				list2.Add(B.get(indexB))
				indexB = indexB + 1
            Case "INSERT"
				list2.Add(B.get(indexB))
				indexB = indexB + 1
            Case "DELETE"
                list2.Add("")
        End Select
    Next
	A = list1
	B = list2
	CustomListView1.clear
	For i = 0 To A.Size - 1
		Dim mpnl As B4XView = addCLVItem("", "")
		If i Mod 2 = 1 Then mpnl.Color = xui.Color_RGB(245, 245, 245)
		If i < A.Size Then 
			Dim lblA As B4XView = mpnl.GetView(0)
			lblA.Text = A.Get(i)
			Dim lblB As B4XView = mpnl.GetView(2)
			lblB.Text = B.Get(i)
			lblB.TextColor = xui.Color_Black
			lblA.TextColor = xui.Color_Black
			If lblA.Text = "" Then lblB.TextColor = xui.color_RGB(220, 20, 60)
			If lblB.Text = "" Then lblA.TextColor = xui.color_Blue
		End If
	Next
End Sub

Private Sub addCLVItem(txtA As String, txtB As String) As B4XView
	 Dim mainpnl As B4XView = xui.CreatePanel("")
	 mainpnl.SetLayoutAnimated(0, 0, 0, CustomListView1.GetBase.Width, 35)
	 addLabel(mainpnl, 0, txtA)
	 Dim partition As Label: partition.initialize("")
	 partition.As(B4XView).Color = xui.Color_RGB(240, 240, 240)
	 mainpnl.AddView(partition, mainpnl.Width / 2, 0, 2, mainpnl.Height)
	 addLabel(mainpnl, mainpnl.Width / 2, txtB)
	 CustomListView1.Add(mainpnl, txtA & "__~__" & txtB)
	 Return mainpnl
End Sub

Private Sub addLabel(pnl As B4XView, xoffset As Float, txt As String)
	Dim lbl As Label: lbl.initialize("codeLine")
	Dim lblx As B4XView = lbl
	lblx.textcolor = xui.color_Black
	lblx.text = txt
	pnl.AddView(lblx, xoffset + 10, 0, pnl.Width / 2  - 20, pnl.Height)
End Sub

Private Sub compareAB As Boolean
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

Private Sub	codeLine_MouseClicked (EventData As MouseEvent)
	Dim lblx As B4XView = Sender
	fx.Clipboard.SetString("'" & lblx.text)
	xui.MsgboxAsync("Code Line Copied to Clipboard", "Info")
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	If busy Then Return
    Dim F As Form = B4XPages.GetNativeParent(Me)
	Dim mods As Modules = B4XPages.GetPage("mods")
	mods.resizeForm(F.WindowWidth, F.WindowHeight)
	
	fontSize = (Max(F.WindowWidth - 600, 0) / 200 + 17)
	Label1.SetLayoutAnimated(0, 10, 0, Root.width / 2 - 10, 30)
	Label1.TextSize = fontSize
	Label2.SetLayoutAnimated(0, Root.width / 2, 0, Root.width / 2 - 10, 30)
	Label2.TextSize = fontSize
	Label3.SetLayoutAnimated(0, 0, 20, Root.width, 30)
	Label3.TextSize = fontSize
	TextPnl.SetLayoutAnimated(0, 10, 50, Root.Width - 20, Root.Height - 60)
	CustomListView1.GetBase.Width = TextPnl.Width - 30
	CustomListView1.GetBase.Font = xui.CreateDefaultFont(fontSize)
	For j = 0 To CustomListView1.size - 1
		Dim mainpnl As B4XView = CustomListView1.GetPanel(j)
		mainpnl.SetLayoutAnimated(0, 0, 0, CustomListView1.GetBase.Width, 35)
		CustomListView1.GetPanel(j).GetView(0).SetLayoutAnimated(0, 10, 0, mainpnl.Width / 2  - 20, mainpnl.Height)
		CustomListView1.GetPanel(j).GetView(1).SetLayoutAnimated(0, mainpnl.Width / 2, 0, 2, mainpnl.Height)
		CustomListView1.GetPanel(j).GetView(2).SetLayoutAnimated(0, mainpnl.Width / 2 + 10, 0, mainpnl.Width / 2  - 20, mainpnl.Height)
		CustomListView1.GetPanel(j).GetView(0).font = xui.CreateDefaultFont(fontSize)
		CustomListView1.GetPanel(j).GetView(2).font = xui.CreateDefaultFont(fontSize)
	Next
	CustomListView1.refresh
End Sub

Private Sub FormMoved_Event (MethodName As String, Args() As Object)
	If busy Then Return
    Dim F As Form = Sender
	Dim mods As Modules = B4XPages.GetPage("mods")
	mods.moveForm(F.WindowLeft, F.WindowTop)
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

Private Sub B4XPage_CloseRequest As ResumableSub
	Dim mods As Modules = B4XPages.GetPage("mods")
	mods.clearSelection
	Return True
End Sub