B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.5
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private clv As CustomListView
	Private lblName As B4XView
	Private lblPosition As B4XView
	Private lblGender As B4XView
	Private lblAge As B4XView
	
	Dim valToDelete As String
	Private txtSearch As B4XFloatTextField
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("lyDashboard")
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub B4XPage_Appear
	clv.AddTextItem("No members yet",0)
	Sleep(100)
	
	loadMembers
End Sub



Sub loadMembers
	
	clv.Clear
	
	Dim result As ResultSet
	result = Main.sql.ExecQuery("SELECT * FROM tblMembers WHERE status = 'Active'")
	
	Do While result.NextRow
		Dim fname As String = result.GetString("fname")
		Dim lname As String = result.GetString("lname")
		
'		Log($"${fname} - ${result.Getint("id")} - ${result.GetString("status")}"$)
		clv.AddTextItem(fname & " " & lname,result.GetInt("id"))
	Loop
End Sub

Private Sub clv_ItemClick (Index As Int, value As Object)
	
	valToDelete = value

	Dim singleMember As ResultSet = Main.sql.ExecQuery2("SELECT * FROM tblMembers WHERE id = ?",Array As String(value))
	
	Do While singleMember.NextRow
		Dim fullname As String = singleMember.GetString("fname") & " " & singleMember.GetString("lname")
		lblName.Text = fullname
		
		lblPosition.Text = singleMember.GetString("position")
		lblGender.Text = singleMember.GetString("gender")
		lblAge.Text = singleMember.GetInt("age")
	Loop
End Sub


Sub clearPreview
	lblName.Text = ""
	lblPosition.Text = ""
	lblGender.Text = ""
	lblAge.Text = ""
End Sub

Private Sub btnDelete_Click
	
	Dim sf As Object = xui.Msgbox2Async("Are you sure you want to Delete this User?", "Delete", "Yes", "", "No", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Main.sql.ExecNonQuery2("UPDATE tblMembers SET status = ? WHERE id = ?",Array As Object("InActive",valToDelete))
	
		'This will refresh the list
		loadMembers
	
		clearPreview
	End If
	
	
End Sub

Private Sub btnAdd_Click
	clearPreview
	
	
	'Get to Add page and access variable
	Dim pgA As actAdd = B4XPages.GetPage("idAdd")
	pgA.whatOperation = "Add"
	
	B4XPages.ShowPage("idAdd")
End Sub

Private Sub btnUPdate_Click
	clearPreview
	
	If valToDelete = "" Then
		xui.MsgboxAsync("Please choose a user to delete","No User selected")
		Return
	End If
	
	'Get to Add page and access variable
	Dim pgA As actAdd = B4XPages.GetPage("idAdd")
	pgA.whatOperation = "Update"
	pgA.idToUPdate = valToDelete
	
	B4XPages.ShowPage("idAdd")
End Sub

Private Sub btnSearch_Click
	Dim nameToSearch As String = txtSearch.Text
	
	clv.Clear
	
	If nameToSearch.Contains(" ") Then
		Log("Searching Full Name")
		
		Dim spaceIndex As Int = nameToSearch.IndexOf(" ")
		Dim fname As String = nameToSearch.SubString2(0,spaceIndex)
		Dim lname As String = nameToSearch.SubString(spaceIndex + 1)
		
'		Log("Firstname: " & fname)
'		Log("Last Name: " & lname)
		
'		LogColor("*********************Using Regex********************",xui.Color_Blue)
'		
'		Dim fullnameArray() As String = Regex.Split(" ",nameToSearch)
'		fname = fullnameArray(0)
'		lname = fullnameArray(1)
'		
'		Log("Firstname: " & fname)
'		Log("Last Name: " & lname)

		Dim result As ResultSet = Main.sql.ExecQuery($"select * FROM tblMembers WHERE fname LIKE '%${fname}%' AND lname LIKE '%${lname}%' AND status = 'Active'"$)
		
		Do While result.NextRow
			Dim fname As String = result.GetString("fname")
			Dim lname As String = result.GetString("lname")
			'Log($"${fname} - ${result.Getint("id")} - ${result.GetString("status")}"$)
			clv.AddTextItem(fname & " " & lname,result.GetInt("id"))
		Loop
	Else
		Log("Searching for Single Names")
		
			
		Dim result As ResultSet = Main.sql.ExecQuery($"select * FROM tblMembers WHERE fname LIKE '%${nameToSearch}%'  AND status = 'Active' OR lname LIKE '%${nameToSearch}%' AND status = 'Active'"$)
		
		Do While result.NextRow
			Dim fname As String = result.GetString("fname")
			Dim lname As String = result.GetString("lname")
			'Log($"${fname} - ${result.Getint("id")} - ${result.GetString("status")}"$)
			clv.AddTextItem(fname & " " & lname,result.GetInt("id"))
		Loop
	End If
	
	
	
End Sub



Private Sub txtSearch_TextChanged (Old As String, New As String)
	clearPreview
	clv.Clear
	
	'Reload the list if the search box is empty
	 If New = "" Then
	 	loadMembers
	End If
End Sub