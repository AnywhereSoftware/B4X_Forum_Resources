B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
'xGantt Custom View class
'
'Version 0.1
'Author: Klaus CHRISTL (klaus)

#DesignerProperty: Key: Visible, DisplayName: Visible, FieldType: Boolean, DefaultValue: False

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private mVisible As Boolean
	
	Public MyGantt As xGantt
	Private pnlEdit, pnlEditGroup, pnlEditMilestone, pnlEditTask As B4XView
	Private edtItemID, edtItemName, edtTaskResponsible, edtTaskBeginDate, lblTaskEndDate, edtTaskDuration, edtTaskCompletion, edtTaskLagLead As B4XView
	Private pnlTaskPredecessorID, pnlMilestoneTaskID, pnlMilestoneDate As B4XView
	Private lblItemRow, lblItemToEdit, lblTaskPredecessorID, lblTaskLagLead, lblMilestoneTaskID As B4XView
	Private btnItemEditClear, btnItemEditUpdate, btnItemEditDelete, btnItemEditInsertAt As B4XView
	Private xcbxItemToEdit, xcbxItemType, xcbxTaskDependency, xcbxTaskPredecessorID As B4XComboBox
	Private xcbxGroupBeginTaskID, xcbxGroupEndTaskID As B4XComboBox
	Private xcbxMilestoneDependency, xcbxMilestoneTaskID, xcbxItemType, xcbxTaskDependency, xcbxTaskPredecessorID As B4XComboBox
	Private xcpkItemColor As xColorPicker
	Private lstItemTypes, lstMilestoneDependencies, lstMilestoneDependenciesShort, lstTaskDependencies, lstTaskDependenciesShort As List
	Private edtMilestoneDate As B4XView
	Private ItemToEdit As GanttItemData
	Private TaskToEdit As GanttTaskData
	Private GroupToEdit As GanttGroupData
	Private MilestoneToEdit As GanttMilestoneData
	Public CurrentItemIndex, CurrentGroupIndex, CurrentTaskIndex, CurrentMilestoneIndex  As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	
	Sleep(0)	
	mBase.LoadLayout("GanttEdit")
	
	mVisible = Props.GetDefault("Visible", False)
	mBase.Visible = mVisible
	
	EditInit
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

'Updates an Item with the given Index
Private Sub btnItemEditUpdate_Click'(Index As Int, TaskToUpdate As GanttTaskData)' As String, Name As String, Responsible As String, BeginDate As String, Duration As Int, Dependency As String, PredecessorID As String, LagLead As Int, Completion As Int, Color As Int)
	Private GID As GanttItemData
	
	GID = MyGantt.Items.Get(CurrentItemIndex)
	
	Select GID.Type
		Case "Group"
			UpdateGroup
		Case "Milestone"
			UpdateMilestone
		Case "Task"
			UpdateTask
	End Select
End Sub

'updates a Group when editing
Private Sub UpdateGroup
	GroupToEdit.ID = edtItemID.Text
	GroupToEdit.Name = edtItemName.Text
	GroupToEdit.BeginTaskID =  MyGantt.Tasks.Get(xcbxGroupBeginTaskID.SelectedIndex).As(GanttTaskData).ID
	GroupToEdit.EndTaskID = MyGantt.Tasks.Get(xcbxGroupEndTaskID.SelectedIndex).As(GanttTaskData).ID
	GroupToEdit.Color = xcpkItemColor.Color
	EditFillItems
	
	MyGantt.Groups.Set(CurrentGroupIndex, GroupToEdit)
End Sub

'updates a Milestone when editing
Private Sub UpdateMilestone
	MilestoneToEdit.ID = edtItemID.Text
	MilestoneToEdit.Name = edtItemName.Text
	MilestoneToEdit.Dependency = xcbxMilestoneDependency.SelectedItem.SubString2(0, 2)
	MilestoneToEdit.Color = xcpkItemColor.Color
	If MilestoneToEdit.Dependency.StartsWith("T") Then
		Private TD As GanttTaskData
		TD = MyGantt.Tasks.Get(xcbxMilestoneTaskID.SelectedIndex)
		MilestoneToEdit.TaskID = TD.ID
		If MilestoneToEdit.Dependency = "TB" Then
			MilestoneToEdit.Date = TD.BeginDate
			MilestoneToEdit.DateTicks = TD.BeginTicks
			MilestoneToEdit.DayIndex = TD.BeginDayIndex
		Else	'TE
			MilestoneToEdit.Date = TD.EndDate
			MilestoneToEdit.DateTicks = TD.EndTicks
			MilestoneToEdit.DayIndex = TD.EndDayIndex
		End If
	Else
		MilestoneToEdit.Dependency = "None"
		MilestoneToEdit.Date = edtMilestoneDate.Text
	End If
	EditFillItems
	
	MyGantt.Milestones.Set(CurrentMilestoneIndex, MilestoneToEdit)
End Sub

'updates a Task when editing
Private Sub UpdateTask
	If TaskToEdit.ID <> edtItemID.Text Then
		MyGantt.TaskChangeID(TaskToEdit, TaskToEdit.ID, edtItemID.Text)
		
	End If
	TaskToEdit.Name = edtItemName.Text
	TaskToEdit.Responsible = edtTaskResponsible.Text
	TaskToEdit.BeginDate = edtTaskBeginDate.Text
	TaskToEdit.Duration = edtTaskDuration.Text
	TaskToEdit.Duration = Abs(TaskToEdit.Duration)
	TaskToEdit.Completion = edtTaskCompletion.Text
	TaskToEdit.Completion = Max(TaskToEdit.Completion, 0)
	TaskToEdit.Completion = Min(TaskToEdit.Completion, 100)
	TaskToEdit.Color = xcpkItemColor.Color
	TaskToEdit.Dependency = lstTaskDependenciesShort.Get(xcbxTaskDependency.SelectedIndex)
	If TaskToEdit.Dependency = "None" Then
		TaskToEdit.PredecessorID = ""
	Else
		TaskToEdit.PredecessorID = MyGantt.TaskIDs.Get(xcbxTaskPredecessorID.SelectedIndex)
	End If
	TaskToEdit.LagLead = edtTaskLagLead.Text
	EditFillItems
	EditUpdate
	
	MyGantt.UpdateTask(CurrentTaskIndex, TaskToEdit)
End Sub

Private Sub btnItemEditClear_Click
	edtItemID.Text = ""
	edtItemName.Text = ""
	edtTaskResponsible.Text = ""
	edtTaskBeginDate.Text = ""
	edtTaskDuration.Text = ""
	edtTaskCompletion.Text = 0
	xcpkItemColor.Color = xui.Color_Red
	xcbxTaskPredecessorID.SelectedIndex = 0
	edtTaskLagLead.Text = 0
	pnlEditGroup.Visible = False
	pnlEditMilestone.Visible = False
	pnlEditTask.Visible = False
End Sub

Private Sub btnItemEditAdd_Click
	Select xcbxItemType.SelectedItem
		Case "Group"
			Private BeginTaskID, EndTaskID As String
			BeginTaskID = MyGantt.TaskIDs.Get(xcbxGroupBeginTaskID.SelectedIndex)
			EndTaskID = MyGantt.TaskIDs.Get(xcbxGroupEndTaskID.SelectedIndex)
			MyGantt.AddGroup(edtItemID.Text, edtItemName.Text, BeginTaskID, EndTaskID, xcpkItemColor.Color)
		Case "Milestone"
			Private Dependency, ObjectID As String
			Dependency = lstMilestoneDependenciesShort.Get(xcbxMilestoneDependency.SelectedIndex)
			ObjectID = MyGantt.TaskIDs.Get(xcbxMilestoneTaskID.SelectedIndex)
			If MyGantt.AddMilestone(edtItemID.Text, edtItemName.Text, edtMilestoneDate.Text, Dependency, ObjectID, xcpkItemColor.Color) = True Then
				CurrentItemIndex = MyGantt.Items.Size - 1
				EditFillItems
				EditUpdate
				TaskToEdit = MyGantt.Tasks.Get(CurrentTaskIndex)
			End If
		Case "Task"
			Private PredecessorID As String
			If xcbxTaskDependency.SelectedIndex > 0 Then
				PredecessorID = MyGantt.TaskIDs.Get(xcbxTaskPredecessorID.SelectedIndex)				
			End If
			If MyGantt.AddTask(edtItemID.Text, edtItemName.Text, edtTaskResponsible.Text, edtTaskBeginDate.Text, edtTaskDuration.Text, lstTaskDependenciesShort.Get(xcbxTaskDependency.SelectedIndex), PredecessorID, edtTaskLagLead.Text, xcpkItemColor.Color) = True Then
				CurrentItemIndex = MyGantt.Items.Size - 1
				EditFillItems
				EditUpdate
				TaskToEdit = MyGantt.Tasks.Get(CurrentTaskIndex)
			End If
	End Select
End Sub

Private Sub btnItemEditInsertAt_Click
	Select xcbxItemType.SelectedItem
		Case "Group"
			Private BeginTaskID, EndTaskID As String
			BeginTaskID = MyGantt.TaskIDs.Get(xcbxGroupBeginTaskID.SelectedIndex)
			EndTaskID = MyGantt.TaskIDs.Get(xcbxGroupEndTaskID.SelectedIndex)
			MyGantt.InsertAtGroup(CurrentItemIndex, edtItemID.Text, edtItemName.Text, BeginTaskID, EndTaskID, xcpkItemColor.Color)
		Case "Milestone"
			Private Dependency, ObjectID As String
			Dependency = lstMilestoneDependenciesShort.Get(xcbxMilestoneDependency.SelectedIndex)
			Select Dependency
				Case "TB", "TE"
					ObjectID = MyGantt.TaskIDs.Get(xcbxMilestoneTaskID.SelectedIndex)
				Case Else
					ObjectID = ""
			End Select
			If MyGantt.InsertAtMilestone(CurrentItemIndex, edtItemID.Text, edtItemName.Text, xcpkItemColor.Color, edtMilestoneDate.Text, Dependency, ObjectID) = True Then
				
			End If
		Case "Task"
			If MyGantt.InsertAtTask(CurrentItemIndex, edtItemID.Text, edtItemName.Text, xcpkItemColor.Color, edtTaskResponsible.Text, edtTaskBeginDate.Text, edtTaskDuration.Text, lstTaskDependenciesShort.Get(xcbxTaskDependency.SelectedIndex), MyGantt.TaskIDs.Get(xcbxTaskPredecessorID.SelectedIndex), edtTaskLagLead.Text) = False Then
				TaskToEdit = MyGantt.Tasks.Get(CurrentTaskIndex)
				EditFillItems
				EditUpdate
			End If
	End Select
End Sub

Private Sub btnItemEditDelete_Click
	xui.Msgbox2Async("Do you really want to delete this Item?", "Delete Item", "Yes", "", "No", Null)
	Wait For Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Select ItemToEdit.Type
			Case "Group"
				MyGantt.DeleteItem(CurrentItemIndex, ItemToEdit)
			Case "Milestone"
				MyGantt.DeleteItem(CurrentItemIndex, ItemToEdit)
			Case "Task"
		End Select
		EditFillItems
		EditUpdate
	End If
End Sub

Private Sub btnEditNew_Click
	xui.Msgbox2Async("Do you really want to create a new project ?", "New project", "Yes", "", "No", Null)
	Wait For Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		MyGantt.InitializeNewProject
		Private lst As List
		lst.Initialize
		xcbxItemToEdit.SetItems(lst)
		xcbxGroupBeginTaskID.SetItems(lst)
		xcbxGroupEndTaskID.SetItems(lst)
		xcbxMilestoneTaskID.SetItems(lst)
		xcbxTaskPredecessorID.SetItems(lst)
		
		xcbxItemType.SelectedIndex = 1
		xcbxItemType_SelectedIndexChanged(1)
		
		lblTaskPredecessorID.Visible = False
		pnlTaskPredecessorID.Visible = False
	End If
End Sub

Private Sub btnEditSave_Click
	Log("Save")
	
End Sub

Private Sub btnEditLoad_Click
	Log("Load")
	
End Sub

Private Sub btnEditRowUp_Click
	CurrentItemIndex = Max(CurrentItemIndex - 1, 0)
	xcbxItemToEdit.SelectedIndex = CurrentItemIndex
	xcbxItemToEdit_SelectedIndexChanged(CurrentItemIndex)
End Sub

Private Sub btnEditRowDown_Click
	CurrentItemIndex = Min(CurrentItemIndex + 1, MyGantt.Items.Size - 1)
	xcbxItemToEdit.SelectedIndex = CurrentItemIndex
	xcbxItemToEdit_SelectedIndexChanged(CurrentItemIndex)
End Sub

Private Sub EditInit
	lstItemTypes.Initialize
	lstItemTypes.AddAll(Array As String("Group", "Task", "Milestone"))
	lstMilestoneDependencies.Initialize
	lstMilestoneDependencies.AddAll(Array As String("None", "TB Task Begin", "TE Task End"))
	lstMilestoneDependenciesShort.Initialize
	lstMilestoneDependenciesShort.AddAll(Array As String("None",  "TB", "TE"))
	lstTaskDependencies.Initialize
	lstTaskDependencies.AddAll(Array As String("None", "FS  Finish to Start", "FF  Finish to Finish", "SS  Start to Start", "SF  Start to Finish"))
	lstTaskDependenciesShort.Initialize
	lstTaskDependenciesShort.AddAll(Array As String("None", "FS", "FF", "SS", "SF"))
	xcbxItemType.SetItems(lstItemTypes)
	xcbxMilestoneDependency.SetItems(lstMilestoneDependencies)
	xcbxTaskDependency.SetItems(lstTaskDependencies)

'	EditFillItems
'	EditUpdate
End Sub

'Updates the Edit screen content
Private Sub EditUpdate
	If MyGantt.Items.Size = 0 Then
		ItemToEdit.Initialize
		ItemToEdit.Type = "Task"
		TaskToEdit.Initialize
		EditUpdateTask
		xcbxItemType.SelectedIndex = 1
		pnlEditTask.Visible = True
	Else
		pnlEditGroup.Visible = False
		pnlEditMilestone.Visible = False
		pnlEditTask.Visible = False
		
		lblItemRow.Text = CurrentItemIndex
		ItemToEdit = MyGantt.Items.Get(CurrentItemIndex)
		xcbxItemType.SelectedIndex = lstItemTypes.IndexOf(ItemToEdit.Type)
		btnItemEditInsertAt.Text = "Insert at row: " & CurrentItemIndex
		Select ItemToEdit.Type
			Case "Group"
				CurrentGroupIndex = MyGantt.GroupIDs.IndexOf(ItemToEdit.ObjectID)
				GroupToEdit = MyGantt.Groups.Get(CurrentGroupIndex)
				EditUpdateGroup
				pnlEditGroup.Visible = True
			Case "Milestone"
				CurrentMilestoneIndex = MyGantt.MilestoneIDs.IndexOf(ItemToEdit.ObjectID)
				MilestoneToEdit = MyGantt.Milestones.Get(CurrentMilestoneIndex)
				EditUpdateMilestone
				pnlEditMilestone.Visible = True
			Case "Task"
				CurrentTaskIndex = MyGantt.TaskIDs.IndexOf(ItemToEdit.ObjectID)
				TaskToEdit = MyGantt.Tasks.Get(CurrentTaskIndex)
				EditUpdateTask
				pnlEditTask.Visible = True
		End Select
	End If
End Sub

Private Sub EditUpdateGroup
	If CurrentGroupIndex >= 0 Then
'		xcbxItemType_SelectedIndexChanged (CurrentGroupIndex)
		Private lst As List
		lst.Initialize
		For i = 0 To MyGantt.Tasks.Size - 1
			Private TD As GanttTaskData
			TD = MyGantt.Tasks.Get(i)
			lst.Add(TD.ID & " |  " & TD.Name)
		Next
		xcbxGroupBeginTaskID.SetItems(lst)
		xcbxGroupEndTaskID.SetItems(lst)
		edtItemID.Text = GroupToEdit.ID
		edtItemName.Text = GroupToEdit.Name
		xcpkItemColor.Color = GroupToEdit.Color
		xcbxGroupBeginTaskID.SelectedIndex = MyGantt.TaskIDs.IndexOf(GroupToEdit.BeginTaskID)
		xcbxGroupEndTaskID.SelectedIndex = MyGantt.TaskIDs.IndexOf(GroupToEdit.EndTaskID)
	End If
End Sub

Private Sub EditUpdateMilestone
	If MyGantt.MileStones.Size > 0 Then
		edtItemID.Text = MilestoneToEdit.ID
		edtItemName.Text = MilestoneToEdit.Name
		xcpkItemColor.Color= MilestoneToEdit.Color

		pnlMilestoneTaskID.Visible = True
		pnlMilestoneDate.Visible = False
				
		Private lst As List
		lst.Initialize
		If MilestoneToEdit.Dependency.StartsWith("T") Then
			For i = 0 To MyGantt.Tasks.Size - 1
				Private TD As GanttTaskData
				TD = MyGantt.Tasks.Get(i)
				lst.Add(TD.ID & " |  " & TD.Name)
			Next
			xcbxItemToEdit.SetItems(lst)
			xcbxItemToEdit.SelectedIndex = MyGantt.TaskIDs.IndexOf(MilestoneToEdit.TaskID)
			lblItemToEdit.Text = "Milestone ID"
		Else
			pnlMilestoneTaskID.Visible = False
			pnlMilestoneDate.Visible = True
		End If
		
		xcbxMilestoneDependency.SelectedIndex = lstMilestoneDependenciesShort.IndexOf(MilestoneToEdit.Dependency)
	Else
		Private MilestoneToEdit As GanttMilestoneData
		MilestoneToEdit.Initialize
	End If
End Sub

Private Sub EditUpdateTask
	If MyGantt.Items.Size > 0 Then
		edtItemID.Text = TaskToEdit.ID
		edtItemName.Text = TaskToEdit.Name
		edtTaskResponsible.Text = TaskToEdit.Responsible
		edtTaskBeginDate.Text = TaskToEdit.BeginDate
		lblTaskEndDate.Text = TaskToEdit.EndDate
		edtTaskDuration.Text = TaskToEdit.Duration
		edtTaskCompletion.Text = TaskToEdit.Completion
		xcpkItemColor.Color= TaskToEdit.Color
		
		Private i As Int
		Private lst As List
		lst.Initialize
		For i = 0 To MyGantt.Tasks.Size - 1
			Private TD As GanttTaskData
			TD = MyGantt.Tasks.Get(i)
			lst.Add(TD.ID & " |  " & TD.Name)
		Next
'		xcbxTaskPredecessorID.SetItems(MyGantt.TaskIDs)
		xcbxTaskPredecessorID.SetItems(lst)
		
		i = lstTaskDependenciesShort.IndexOf(TaskToEdit.Dependency)
		xcbxTaskDependency.SelectedIndex = i
'		xcbxTaskDependency_SelectedIndexChanged(0)
		i = MyGantt.TaskIDs.IndexOf(TaskToEdit.PredecessorID)
		xcbxTaskPredecessorID.SelectedIndex = i
'		xcbxTaskPredecessorID_SelectedIndexChanged(i)
		edtTaskLagLead.Text = TaskToEdit.LagLead
		If xcbxTaskDependency.SelectedIndex = 0 Then
			lblTaskPredecessorID.Visible = False
			pnlTaskPredecessorID.Visible = False
			lblTaskLagLead.Visible = False
			edtTaskLagLead.Visible = False
			edtTaskBeginDate.Enabled = True
		Else
			lblTaskPredecessorID.Visible = True
			pnlTaskPredecessorID.Visible = True
			lblTaskLagLead.Visible = True
			edtTaskLagLead.Visible = True
			edtTaskBeginDate.Enabled = False
		End If
		btnItemEditInsertAt.Visible = True
		btnItemEditUpdate.Visible = True
		btnItemEditDelete.Visible = True
	Else
		edtItemID.Text = ""
		edtItemName.Text = ""
		edtTaskResponsible.Text = ""
		edtTaskBeginDate.Text = ""
		lblTaskEndDate.Text = ""
		edtTaskDuration.Text = 0
		edtTaskCompletion.Text = 0
		xcbxTaskDependency_SelectedIndexChanged(0)
		xcbxTaskDependency.SelectedIndex = 0
		xcbxTaskPredecessorID_SelectedIndexChanged(0)
		xcbxTaskPredecessorID.SelectedIndex = 0
		edtTaskLagLead.Text = 0
		lblTaskPredecessorID.Visible = True
		pnlTaskPredecessorID.Visible = False
		lblTaskLagLead.Visible = True
		edtTaskLagLead.Visible = True
		edtTaskBeginDate.Enabled = True
		btnItemEditInsertAt.Visible = False
		btnItemEditUpdate.Visible = False
		btnItemEditDelete.Visible = False
	End If
End Sub

Private Sub EditFillItems
	If MyGantt.Items.Size = 0 Then
			Return
	End If
	
	Private i As Int
	Private lstItems As List
	
	lstItems.Initialize
	
	For i = 0 To MyGantt.Items.Size - 1
		Private GID As GanttItemData
		
		GID = MyGantt.Items.Get(i)
		Select GID.Type
			Case "Group"
				Private GD As GanttGroupData
				GD = MyGantt.Groups.Get(MyGantt.GroupIDs.IndexOf(GID.ObjectID))
				lstItems.Add(GID.Type & " : " & GID.ObjectID & "  " & GD.Name)
			Case "Milestone"
				Private MD As GanttMilestoneData
				MD = MyGantt.Milestones.Get(MyGantt.MilestoneIDs.IndexOf(GID.ObjectID))
				lstItems.Add(GID.Type & " : " & GID.ObjectID & "  " & MD.Name)
			Case "Task"
				Private TD As GanttTaskData
				TD = MyGantt.Tasks.Get(MyGantt.TaskIDs.IndexOf(GID.ObjectID))
				lstItems.Add(GID.Type & " : " & GID.ObjectID & "  " & TD.Name)
		End Select
	Next

	xcbxItemToEdit.SetItems(lstItems)
'	xcbxItemToEdit_SelectedIndexChanged(CurrentItemIndex)
	xcbxItemToEdit.SelectedIndex = CurrentItemIndex
'	xcbxItemToEdit_SelectedIndexChanged(CurrentItemIndex)
End Sub

Private Sub xcbxItemToEdit_SelectedIndexChanged (Index As Int)
	CurrentItemIndex = Index
	If MyGantt.Items.Size > 0 Then
		ItemToEdit = MyGantt.Items.Get(Index)
	End If
	EditUpdate
End Sub

Private Sub xcbxItemType_SelectedIndexChanged (Index As Int)
	pnlEditGroup.Visible = False
	pnlEditMilestone.Visible = False
	pnlEditTask.Visible = False
	Select xcbxItemType.SelectedItem
		Case "Group"
			pnlEditGroup.Visible = True
			EditUpdateGroup
		Case "Milestone"
			pnlEditMilestone.Visible = True
			EditUpdateMilestone
		Case "Task"
			pnlEditTask.Visible = True
			EditUpdateTask
	End Select
End Sub

Private Sub xcbxMilestoneDependency_SelectedIndexChanged (Index As Int)
	Private i As Int
	Private lst As List

	lst.Initialize
	
	pnlMilestoneTaskID.Visible = True
	pnlMilestoneDate.Visible = False
	Select lstMilestoneDependenciesShort.Get(Index)
		Case "None"
			pnlMilestoneTaskID.Visible = False
			pnlMilestoneDate.Visible = True
		Case "TB", "TE"
			For i = 0 To MyGantt.Tasks.Size - 1
				Private TD As GanttTaskData
				TD = MyGantt.Tasks.Get(i)
				lst.Add(TD.ID & " |  " & TD.Name)
			Next
			xcbxMilestoneTaskID.SetItems(lst)
	End Select
End Sub

Private Sub xcbxTaskDependency_SelectedIndexChanged (Index As Int)
	If Index = 0 Then
		lblTaskPredecessorID.Visible = False
		pnlTaskPredecessorID.Visible = False
		lblTaskLagLead.Visible = False
		edtTaskLagLead.Visible = False
		edtTaskBeginDate.Enabled = True
	Else
		lblTaskPredecessorID.Visible = True
		pnlTaskPredecessorID.Visible = True
		lblTaskLagLead.Visible = True
		edtTaskLagLead.Visible = True
		edtTaskBeginDate.Enabled = False
	End If
End Sub

Private Sub xcbxTaskPredecessorID_SelectedIndexChanged (Index As Int)

End Sub

Public Sub getVisible As Boolean
	Return mVisible
End Sub

Public Sub setVisible(Visible As Boolean)
	mVisible = Visible
	mBase.Visible = mVisible
	If mVisible = True Then
		EditFillItems
		EditUpdate
	End If
End Sub