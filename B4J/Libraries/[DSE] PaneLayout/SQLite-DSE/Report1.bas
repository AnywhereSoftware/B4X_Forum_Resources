B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private XUI As XUI
	Private mSQL As SQL
	Private mContentPane As B4XView
	Private pnTitle As B4XView
	Private CustomListView1 As CustomListView
	Private lblInfo As B4XView
	Private lblWorking As B4XView
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(SQL As SQL,ContentPane As B4XView)
	mSQL = SQL
	mContentPane = ContentPane
End Sub

Public Sub Run

	mContentPane.RemoveAllViews
	
	Dim DSE As DSE_PaneLayout
	DSE.Initialize
	XUI.RegisterDesignerClass(DSE)
	DSE.Count = 4
	DSE.Widths = Array As Double(150,150,150,200)
	DSE.LeftMargin = 5
	
	mContentPane.LoadLayout("CustomListViewDSE")

	pnTitle.GetView(0).Text = "First Name"
	pnTitle.GetView(1).Text = "Last_Name"
	pnTitle.GetView(2).Text = "Phone"
	pnTitle.GetView(3).SetTextAlignment("CENTER","CENTER")
	pnTitle.GetView(3).Text = "Email"
	
	pnTitle.Color = XUI.Color_Gray
	For Each V As B4XView In pnTitle.GetAllViewsRecursive
		V.Color = XUI.Color_Gray
	Next
	
	ShowReport
End Sub

Public Sub ShowReport
	
	CustomListView1.Clear
	lblWorking.Visible = True
	Sleep(50)
	
	Dim Query As String = $"SELECT ${Addresses.First_Name}, ${Addresses.Last_Name},${Addresses.Phone1},${Addresses.Email} From ${DBAccess.Addresses_TBL}"$
	
	Dim RS As ResultSet = mSQL.ExecQuery(Query)
	
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