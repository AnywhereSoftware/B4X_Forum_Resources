B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=CLVItemToolboxTest3.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private CLVItemToolbox1 As CLVItemToolbox
	Private CustomListView1 As CustomListView
	Private lblItem As B4XView
	Private tfItem As B4XView
	
	Private mBCToast As BCToast
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("layMainPage")
	FillClv
	mBCToast.Initialize(Root)
	mBCToast.DurationMs = 1200
End Sub

Private Sub chkRemove_CheckedChange(Checked As Boolean)
	CLVItemToolbox1.ShowRemove = Checked
End Sub

Private Sub chkEdit_CheckedChange(Checked As Boolean)
	CLVItemToolbox1.ShowEdit = Checked
End Sub

Private Sub chkCheck_CheckedChange(Checked As Boolean)
	CLVItemToolbox1.ShowCheck = Checked
End Sub

Private Sub FillClv
	Dim lstNicks As List
	lstNicks.Initialize2(Array As String("Erel", "Mahares", "XFood", "Sagenut", "LordZenzo", "LucaMs", "Colin Evans", "AnandGupta", "Lello1964", "angel_"))
	For i = 0 To lstNicks.Size - 1
		CustomListView1.Add(CreateCvlItem(lstNicks.Get(i)), i)
	Next
End Sub

Private Sub CreateCvlItem(Nick As String) As B4XView
	Dim xPnl As B4XView = xui.CreatePanel("")
	xPnl.SetLayoutAnimated(0, 0, 0, 400dip, 40dip)
	xPnl.LoadLayout("layCLVItem")
	CLVItemToolbox1.CLV = CustomListView1
	CLVItemToolbox1.DlgItemText = Nick
	lblItem.Text = Nick
	tfItem.Text = NumberFormat2(Rnd(10, 2000), 1, 0, 0, True)
	Return xPnl
End Sub

'If Action is REMOVE, this event will fire only if UseInternalDlg is set to False,
'otherwise the ItemRemoved event will fire.
Private Sub CLVItemToolbox1_Click(Action As String, Base As B4XView)
	Dim ItemIndex As Int
	ItemIndex = CustomListView1.GetItemFromView(Base)
	
	Dim Msg As String = $"${Action} clv item #${ItemIndex}"$
	mBCToast.Show(Msg)
	
	Select Action
		Case CLVItemToolbox1.CHECKED
		Case CLVItemToolbox1.UNCHECKED
		Case CLVItemToolbox1.EDIT
		Case CLVItemToolbox1.REMOVE
	End Select
End Sub

Private Sub CLVItemToolbox1_ItemRemoved(Value As Object)
	Log("Removed:")
	Log(Value)
End Sub