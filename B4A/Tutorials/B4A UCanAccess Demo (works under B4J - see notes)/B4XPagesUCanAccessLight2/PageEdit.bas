B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.9
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Public Mode As String
	
	Private ToastMessage As BCToast
	Private Edit As PageEdit
	Private edtFirstName, edtLastName, edtCity As B4XView
	Private lblRowID As B4XView
	Private btnAdd, btnDelete, btnUpdate, btnPrevious, btnNext, btnFirst, btnLast As B4XView
	Private MP As B4XMainPage
End Sub

'You can add more parameters here.
Public Sub Initialize

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("Edit")
	
	MP = B4XPages.MainPage
	ToastMessage.Initialize(Root)
End Sub

Private Sub B4XPage_Appear
	ShowEntry(MP.CurrentIndex)
End Sub

Private Sub B4XPage_Disappear
	B4XPages.MainPage.ShowTable
End Sub

Private Sub btnMove_Click
	Private btn As Button
	Private Tag As String
	
	btn = Sender
	Tag = btn.Tag

	Select Tag
		Case "First"
			MP.CurrentIndex = 0
		Case "Prev"
			MP.CurrentIndex = Max(0, MP.CurrentIndex - 1)
		Case "Next"
			MP.CurrentIndex = Min(MP.CurrentIndex + 1, MP.RowIDList.Size - 1)
		Case "Last"
			MP.CurrentIndex = MP.RowIDList.Size - 1
	End Select
	ShowEntry(MP.CurrentIndex)
End Sub

Private Sub btnAdd_Click
	If AddEntry = True Then
		Edit.Mode = "Edit"
		ShowButtons
	End If
End Sub

Private Sub btnDelete_Click
	DeleteEntry
End Sub

Private Sub btnUpdate_Click
	UpdateEntry
End Sub

Public Sub ShowEntry(EntryIndex As Int)
	Private RowID As Int
	
	If MP.RowIDList.Size = 0 Then 			'check if the database is empty
		Return											'if yes leave the routine
	End If
	
	If Edit.Mode = "Add" Then
		lblRowID.Text = ""
		edtFirstName.Text = ""
		edtLastName.Text = ""
		edtCity.Text = ""
	Else
#If B4J
		Private ResultSet1 As ResultSet
#Else If B4A
		Private ResultSet1 As JdbcResultSet
#End If
		RowID = MP.RowIDList.Get(EntryIndex)		'get the ID for the given entry index
		'read the entry with the given ID
		ResultSet1 = MP.SQL1.ExecQuery("SELECT * FROM persons WHERE rowid = " & RowID)
		lblRowID.Text = "  " & RowID													'display the ID
		ResultSet1.NextRow																		'set the cursor
		edtFirstName.Text = ResultSet1.GetString("FirstName")	'read the value of the FirstName column
		edtLastName.Text = ResultSet1.GetString("LastName")		'read the value of the LasstName column
		edtCity.Text = ResultSet1.GetString("City")						'read the value of the City column
		ResultSet1.Close																			'close the cursor, we don't it anymore
	End If
	ShowButtons
End Sub

Sub AddEntry As Boolean
	Private Query As String
#If B4J
	Private ResultSet1 As ResultSet
#Else If B4A
	Private ResultSet1 As JdbcResultSet
#End If
	Private RowID As Int
	
	'check if all dields are filled
	If edtFirstName.Text = "" Or edtLastName.Text = "" Or edtCity.Text  = "" Then
		ToastMessage.Show("Missing data")	' confirmation for the user
		Return False
	End If
	
	'first we check if the entry already does exist
	Query = "SELECT * FROM persons WHERE FirstName = ? AND LastName = ? AND City = ?"
	ResultSet1 = MP.SQL1.ExecQuery2(Query, Array As String (edtFirstName.Text, edtLastName.Text, edtCity.Text))

	If ResultSet1.NextRow = True Then
		'if it exists show a message and do nothing else
		ToastMessage.Show("This entry already exists")
		ResultSet1.Close								'close the cursor, we don't it anymore
		Return False
	Else
		'if not, add the entry
		'we use ExecNonQuery2 because it's easier, we don't need to take care of the data types
		'****************************************
		'UCanAccess needs field list on insert if inserting data into a table with an auto-increment column
		'*****************************************
		Query = "INSERT INTO persons (FirstName, LastName, City) VALUES (?, ?, ?)"
'		Query = "INSERT INTO persons VALUES (?, ?, ?)"
		MP.SQL1.ExecNonQuery2(Query, Array As String(edtFirstName.Text, edtLastName.Text, edtCity.Text))
	
		ToastMessage.Show("Entry added")	' confirmation for the user
	
		'to display the ID of the last entry we read the max value of the ID column
		RowID = MP.SQL1.ExecQuerySingleResult("SELECT max(rowid) FROM persons")
		MP.RowIDList.Add(RowID)			'add the last ID to the list
		MP.CurrentIndex = MP.RowIDList.Size - 1		'set the current index to the last one
		lblRowID.Text = RowID					'display the last index
	End If
	ResultSet1.Close								'close the cursor, we don't it anymore
	Return True
End Sub

Private Sub DeleteEntry
	Private Query As String
	
	'ask the user for confirmation
	Private sf As Object = xui.Msgbox2Async("Do you really want to delete " & edtFirstName.Text & " " & edtLastName.Text, "Delete entry", "Yes", "", "No", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Query = "DELETE FROM persons WHERE rowid = " & MP.RowIDList.Get(MP.CurrentIndex)
		MP.SQL1.ExecNonQuery(Query)									'delete the entry
		MP.RowIDList.RemoveAt(MP.CurrentIndex)					'remove the ID from the list
		If MP.CurrentIndex = MP.RowIDList.Size Then			'if the current index is the last one
			MP.CurrentIndex = MP.CurrentIndex - 1					'decrement it by 1
		End If
		ShowEntry(MP.CurrentIndex)										'show the next entry
		ToastMessage.Show("Entry deleted")	'confirmation for the user
		ShowButtons
	End If
End Sub

Private Sub UpdateEntry
	Private Query As String
	
	Query = "UPDATE persons Set FirstName = ?, LastName = ?, City = ? WHERE rowid = " & MP.RowIDList.Get(MP.CurrentIndex)
	MP.SQL1.ExecNonQuery2(Query, Array As String(edtFirstName.Text, edtLastName.Text, edtCity.Text))
	ToastMessage.Show("Entry updated")
	MP.ShowTable	'needed to update the Table in the B4XMainPage
End Sub

Private Sub ShowButtons
	If Edit.Mode = "Add" Then
		btnPrevious.Visible = False		'hide the navigation buttons
		btnNext.Visible = False
		btnFirst.Visible = False
		btnLast.Visible = False
		btnDelete.Visible = False
		btnUpdate.Visible = False
	Else
		btnDelete.Visible = True
		btnUpdate.Visible = True
		If MP.RowIDList.Size <= 1 Then 	'check if the database has less than 2 entries
			btnPrevious.Visible = False					'hide the navigation buttons
			btnNext.Visible = False
			btnFirst.Visible = False
			btnLast.Visible = False
		Else
			'show or hide the Previous and Next buttons depending on the value of the current index
			If MP.CurrentIndex = 0 Then
				btnPrevious.Visible = False
				btnFirst.Visible = False
			Else
				btnPrevious.Visible = True
				btnFirst.Visible = True
			End If
			
			If MP.CurrentIndex = MP.RowIDList.Size - 1 Then
				btnNext.Visible = False
				btnLast.Visible = False
			Else
				btnNext.Visible = True
				btnLast.Visible = True
			End If
		End If
	End If
End Sub
