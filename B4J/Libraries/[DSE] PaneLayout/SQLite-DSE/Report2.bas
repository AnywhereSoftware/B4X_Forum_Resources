B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private XUI As XUI
	Private mSQL As SQL
	Private mContentPane As B4XView
	Private pnTitle As B4XView
	Private CustomListView1 As CustomListView
	Private lblInfo As B4XView
	Private lblWorking As B4XView
	Private TextField1 As TextField
	Dim DSE As DSE_PaneLayout
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(SQL As SQL,ContentPane As B4XView, InputPane As B4XView)
	mSQL = SQL
	mContentPane = ContentPane
	
	
	DSE.Initialize
	XUI.RegisterDesignerClass(DSE)
	
	
	DSE.Count = 3
	DSE.Widths = Array As Double(80,200,300)
	DSE.LeftMargin = 5
	DSE.Spacing = 5
	DSE.EventNames = Array As String("CB","CMB","TF")
	DSE.Types = Array As String(DSE.VIEW_CHECKBOX,DSE.VIEW_COMBOBOX,DSE.VIEW_TEXTFIELD)
	
	InputPane.LoadLayout("DSE_Layout")
	InputPane.GetView(0).GetView(0).Text = "Check"
	Dim CMB As ComboBox = InputPane.GetView(0).GetView(1)
	CMB.Items.AddAll(Array(1,2,3))
	
	TextField1 = InputPane.GetView(0).GetView(2)
	
End Sub

Public Sub Run

	mContentPane.RemoveAllViews
	
	'Important if you are reusing the class
	DSE.Reset
	
	DSE.Count = 4
	DSE.Widths = Array As Double(150,150,150,350)
	DSE.LeftMargin = 5
	
	
	mContentPane.LoadLayout("CustomListViewDSE")
	'Layout 

	pnTitle.GetView(0).Text = "First Name"
	pnTitle.GetView(1).Text = "Last_Name"
	pnTitle.GetView(2).Text = "Phone"
	pnTitle.GetView(3).SetTextAlignment("CENTER","CENTER")
	pnTitle.GetView(3).Text = "Web"
	
	pnTitle.Color = XUI.Color_Gray
	For Each V As B4XView In pnTitle.GetAllViewsRecursive
		V.Color = XUI.Color_Gray
	Next
	
	'Set the eventnams for the table content but not the title
	DSE.EventNames = Array As String("","","","Web")
	
	ShowReport
End Sub

Public Sub ShowReport
	
	CustomListView1.Clear
	lblWorking.Visible = True
	Sleep(50)
	
	Dim Args As List
	Args.Initialize
	
	Dim Query As String = $"SELECT ${Addresses.First_Name}, ${Addresses.Last_Name},${Addresses.Phone1},${Addresses.Web} From ${DBAccess.Addresses_TBL}
	WHERE ${Addresses.First_Name} || ' ' || ${Addresses.Last_Name} LIKE ?"$
	
	Args.Add($"%${TextField1.Text}%"$)
	
	Dim RS As ResultSet = mSQL.ExecQuery2(Query,Args)
	
	Dim Count As Int
	Do While RS.NextRow
		Count = Count + 1
		Dim pn As B4XView = XUI.CreatePanel("")
		pn.LoadLayout("DSE_Layout")
		Dim pnTarget As B4XView = pn.GetView(0)
		pnTarget.GetView(0).Text = RS.GetString2(0)
		pnTarget.GetView(1).Text = RS.GetString2(1)
		pnTarget.GetView(2).Text = RS.GetString2(2)
		pnTarget.GetView(3).Text = RS.GetString2(3)
		CustomListView1.Add(pnTarget,RS.GetString2(0) & " " & RS.GetString2(1))
	Loop
	lblWorking.Visible = False
	lblInfo.Text = (Count + 1) & " records displayed"
	
End Sub

Private Sub CustomListView1_ItemClick (Index As Int, Value As Object)
	Log($"Value ${Value} clicked"$)
End Sub

Private Sub Web_Clicked(Lbl As B4XView)
	'fx.ShowExternalDocument(Lbl.Text)
	Log($"Show external document ${Lbl.Text}"$)
End Sub

Private Sub TF_Action(TF As B4XView)
	ShowReport
End Sub

Private Sub CB_CheckedChange(CB As B4XView)
	Log(CB.Checked)
End Sub
Private Sub CMB_SelectedIndexChanged(CMB As ComboBox)
	Log(CMB.SelectedIndex & " " & CMB.Value)
End Sub