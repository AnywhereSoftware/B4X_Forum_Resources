B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.5
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private lblBack As B4XView
	Private txtFname As B4XFloatTextField
	Private txtLname As B4XFloatTextField
	Private txtAge As B4XFloatTextField
	Private cmbPosition As B4XComboBox
	Private cmbGender As B4XComboBox
	
	Dim whatOperation As String
	Dim idToUpdate As String
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("lyADD")
	
	cmbGender.SetItems(Array As String("Male","Female"))
	cmbPosition.SetItems(Array As String("Boys Prefect","Girls Prefect", "Dinning Hall Prefect","Compound Overseer","Library Prefect"))
	
	DateTime.DateFormat = "yyyy-mm-dd"
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.


Sub B4XPage_Appear
	
	If whatOperation = "Update" Then
		Dim singleMember As ResultSet = Main.sql.ExecQuery2("SELECT * FROM tblMembers WHERE id = ?",Array As String(idToUpdate))
	
		Do While singleMember.NextRow
			
			txtFname.Text = singleMember.GetString("fname")
			txtLname.Text = singleMember.GetString("lname")
			txtAge.Text = singleMember.GetInt("age")
		Loop
	End If
	
End Sub

#IF B4J
	Private Sub lblBack_MouseClicked (EventData As MouseEvent)
#ELSE	
	Private Sub lblBack_Click
#End If	
	B4XPages.ShowPageAndRemovePreviousPages("idDash")
End Sub

Private Sub btnSave_Click
	Dim fname As String = txtFname.Text
	Dim lname As String = txtLname.Text
	Dim age As Int = txtAge.Text
	Dim position As String = cmbPosition.SelectedItem
	Dim gender As String = cmbGender.SelectedItem
	
	
	Dim dd As String = DateTime.Date(DateTime.Now)
	
	
	Select whatOperation
		Case "Add"
			Main.sql.ExecNonQuery2("INSERT INTO tblMembers VALUES (?,?,?,?,?,?,?,?)", _
			Array As Object(Null,fname,lname,position,age,gender,"Active",dd))
	
			xui.MsgboxAsync("New Member added succesfully","Succesful")
			
		Case "Update"
			Main.sql.ExecNonQuery2("UPDATE tblMembers SET fname = ?,lname = ?,age = ?,position = ?,gender = ? WHERE id = ?", _ 
			Array As Object(fname,lname,age,position,gender,idToUpdate))
			
			xui.MsgboxAsync("New Member Updated succesfully","Succesful")
	End Select
	

	txtAge.Text = ""
	txtLname.Text = ""
	txtFname.Text = ""
End Sub


