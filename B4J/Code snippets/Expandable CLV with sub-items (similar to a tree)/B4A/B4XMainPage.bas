B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals

	Private Root As B4XView
	Private xui As XUI

	Private clv1 As CustomListView
	Private lblTitle As B4XView
	Private pnlTitle As B4XView
	Private pnlExpanded As B4XView
	Private expandable As wmCLVExpandable2

	Private clr_foreground As Int = xui.Color_Black

	Private arrowClicked As Boolean = False

	Type itemInfo(ID As String, parentID As String, ascendantIDs As List)
	Private plusMinusClicked As Boolean = False
	Private FAplus As String = Chr(0xF196) ' FontAwesome '+' sign
	Private FAminus As String = Chr(0xF147) ' FontAwesome '-' sign

	Private lblPlusMinus As B4XView
	Private ImageViewArrow As B4XView

End Sub

Public Sub Initialize

'	B4XPages.GetManager.LogEvents = True

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created(Root1 As B4XView)

	Root = Root1
	Root.LoadLayout("main")

#If B4A
	' Avoid this error in B4A: java.lang.IllegalArgumentException: Cannot set 'scaleY' to Float.NaN
	clv1.AnimationDuration = 0
#End If

	expandable.Initialize(clv1, 2) ' The arrow imageview has index 2 (0-based) here !

	' NOTE: clv1.DividerSize (set in the Designer as 'Divider Height') must be 0 to make plus/minus work without leaving empty spaces between entries
	For i = 1 To 20
		Dim iInfo As itemInfo = CreateItemInfo(i, "", CreateEmptyList) ' Note: the first parm must be unique for the entire clv!
		Dim p As B4XView = CreateItem("Item #" & iInfo.id, Rnd(100dip, 300dip) + 60dip, 0, True)
		clv1.Add(p, expandable.CreateValue(p, iInfo))
		For j = 1 To 2
			Dim jInfo As itemInfo = CreateItemInfo(i & "/" & j, iInfo.id, Array(iInfo.id)) ' Note: the first parm must be unique for the entire clv!
			Dim p As B4XView = CreateItem("Item #" & jInfo.id, Rnd(100dip, 300dip) + 60dip, 1, True)
			clv1.Add(p, expandable.CreateValue(p, jInfo))
			For k = 1 To 3
				Dim kInfo As itemInfo = CreateItemInfo(i & "/" & j & "/" & k, jInfo.id, Array(iInfo.id, jInfo.id)) ' Note: the first parm must be unique for the entire clv!
				Dim p As B4XView = CreateItem("Item #" & kInfo.id, Rnd(100dip, 300dip) + 60dip, 2, True)
				clv1.Add(p, expandable.CreateValue(p, kInfo))
				For m = 1 To 2
					Dim mInfo As itemInfo = CreateItemInfo(i & "/" & j & "/" & k & "/" & m, kInfo.id, Array(iInfo.id, jInfo.id, kInfo.id)) ' Note: the first parm must be unique for the entire clv!
					Dim p As B4XView = CreateItem("Item #" & mInfo.id, Rnd(100dip, 300dip) + 60dip, 3, False)
					clv1.Add(p, expandable.CreateValue(p, mInfo))
				Next
			Next
		Next
	Next

End Sub

Private Sub B4XPage_Appear

End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub CreateItem(title As String, expandedHeight As Int, indent As Int, hasChildren As Boolean) As B4XView

	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, clv1.AsView.Width, expandedHeight)

	Dim layout As String
	' Select the layout file depending on 'indent'. Make the layouts identical,
	' except for their views' positions and sizes. The order of the views in the
	' title pane(L) remains important! (title, plus/minus, arrow)
	' You can add more layout files and their corresponding 'indent' values,
	' if desired.
	If indent <= 0 Then
		layout = "item"
	Else
		Select Case indent
			Case 1
				layout = "itemindent025"
			Case 2
				layout = "itemindent050"
			Case 3
				layout = "itemindent075"
			Case Else
				layout = "itemindent100"
		End Select
	End If
	p.LoadLayout(layout)
	p.SetLayoutAnimated(0, p.Left, 0, p.Width, p.GetView(0).Height) 'resize it to the collapsed height

	lblTitle.Text = title
	pnlTitle.SetColorAndBorder(xui.Color_Transparent, 1dip, clr_foreground, 5dip)
	pnlExpanded.SetColorAndBorder(xui.Color_Transparent, 1dip, clr_foreground, 5dip)

	If hasChildren Then
		lblPlusMinus.Visible = True
		lblPlusMinus.Text = FAminus
	Else
		lblPlusMinus.Text = ""
	End If

	' These are used to determine the clv item index of the clicked object
	lblPlusMinus.Tag = clv1.Size
	ImageViewArrow.Tag = clv1.Size

	Return p

End Sub

#If B4J
' NOTE: clv1.DividerSize (set in the Designer as 'Divider Height') must be 0 to make plus/minus work without leaving empty spaces between entries
Private Sub lblPlusMinus_MouseClicked (EventData As MouseEvent)
	plusMinusClicked = True
End Sub
#Else
' NOTE: clv1.DividerSize (set in the Designer as 'Divider Height') must be 0 to make plus/minus work without leaving empty spaces between entries
Private Sub lblPlusMinus_Click
	plusMinusClicked = True
	' In B4J, clv1_ItemClick fires after this here event has fired. In B4A, it does not.
	Dim v As B4XView = Sender
	clv1_ItemClick(v.Tag, Null)
End Sub
#End If

#If B4J
Private Sub ImageViewArrow_MouseClicked (EventData As MouseEvent)
	arrowClicked = True
End Sub
#Else
Private Sub ImageViewArrow_Click
	arrowClicked = True
	' In B4J, clv1_ItemClick fires after this here event has fired. In B4A, it does not.
	Dim v As B4XView = Sender
	clv1_ItemClick(v.Tag, Null)
End Sub
#End If

' NOTE: clv1.DividerSize (set in the Designer as 'Divider Height') must be 0 to make plus/minus work without leaving empty spaces between entries
Private Sub clv1_ItemClick(Index As Int, Value As Object)

	Dim i As Int

	' Arrow clicked?
	If arrowClicked Then
		arrowClicked = False
		expandable.ToggleItem(Index)
		Return
	End If

	' +/- clicked? If not, return now
	If plusMinusClicked = False Then Return

	' Get the item's lblPlusMinus
	Dim clickedPlusMinus As B4XView = clv1.GetPanel(Index).GetView(0).GetView(1) ' item panel / title panel / plusminus label

	Dim clickedInf As itemInfo = expandable.GetValue(Index)
	Select Case clickedPlusMinus.Text
		Case FAplus
			clickedPlusMinus.Text = FAminus
			' Show direct descendants
			For i = 0 To (clv1.Size - 1)
				Dim inf As itemInfo = expandable.GetValue(i)
				If inf.parentID = clickedInf.ID Then
					Dim titlePnl As B4XView = clv1.GetPanel(Index).GetView(0) ' item panel / title panel
					clv1.ResizeItem(i, titlePnl.Height)
				End If
			Next
		Case FAminus
			clickedPlusMinus.Text = FAplus
			' Hide all descendants, direct and indirect.
			' Also change their lblPlusMinus text to '+'.
			For i = 0 To (clv1.Size - 1)
				Dim inf As itemInfo = expandable.GetValue(i)
				If inf.ascendantIDs.IndexOf(clickedInf.ID) >= 0 Then
					Dim plusMinus As B4XView = clv1.GetPanel(i).GetView(0).GetView(1) ' item panel / title panel / plusminus label
					plusMinus.Text = FAplus
					clv1.ResizeItem(i, 0)
				End If
			Next
		Case Else
			Return ' Actually, this shouldn't happen
	End Select

End Sub

Private Sub CreateItemInfo(ID As String, parentID As String, ascendantIDs As List) As itemInfo

	Dim t1 As itemInfo
	t1.Initialize
	t1.ID = ID
	t1.parentID = parentID
	t1.ascendantIDs = ascendantIDs
	Return t1

End Sub

Private Sub CreateEmptyList As List

	Dim emptyList As List
	emptyList.Initialize
	Return emptyList

End Sub