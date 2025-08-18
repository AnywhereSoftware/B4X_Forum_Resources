B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.9
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Public flagFilterActive = False As Boolean
	Public SelectedItemIndex() As Int
	' Variables used to hold the selected indexes of the Spinners
	Public SelectedFirstName, SelectedLastName, SelectedCity As Int
	Public Query As String
	
	Private cbxFirstName, cbxLastName, cbxCity As B4XComboBox
	Private btnBooleanOperator As Button
	Private MP As B4XMainPage

	Private BooleanOperator = "AND " As String
End Sub

'You can add more parameters here.
Public Sub Initialize

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("SetFilter")
	
	MP = B4XPages.MainPage
End Sub

Private Sub B4XPage_Appear
	Show
End Sub

Public Sub Show
	UpdateFilters
	
	'set the last selected indexes of the Spinners
	cbxFirstName.SelectedIndex = SelectedFirstName
	cbxLastName.SelectedIndex = SelectedLastName
	cbxCity.SelectedIndex = SelectedCity
	
	'set the text of the btnBooleanOperator button
	btnBooleanOperator.Text = BooleanOperator
End Sub

Private Sub btnFilter_Click
	Query = GetFilterQuery

	'set the filter to active
	flagFilterActive = True
	
	'memorize the selected indexes of the Spinners
	SelectedFirstName = cbxFirstName.SelectedIndex
	SelectedLastName = cbxLastName.SelectedIndex
	SelectedCity = cbxCity.SelectedIndex
	
	'quit the calling object, returns to the Main object
	B4XPages.ClosePage(Me)
End Sub

Private Sub btnBooleanOperator_Click
	If BooleanOperator = "AND " Then
		BooleanOperator = "OR "
	Else
		BooleanOperator = "AND "
	End If
	btnBooleanOperator.Text = BooleanOperator
End Sub

'Initialize the ComboBoxes
Private Sub UpdateFilters
	Private Query1 As String
#If B4J
	Private ResultSet1 As ResultSet
#Else If B4A
	Private ResultSet1 As JdbcResultSet
#End If
	
	'We execute a query for each column and fill the ComboBox
	'We use SELECT DISTINCT to have each existing first name in the database only once
	Query1 = "SELECT DISTINCT FirstName FROM persons ORDER BY FirstName ASC"

	'fill the FirstName B4XComboBox
	ResultSet1 = MP.SQL1.ExecQuery(Query1)
	'we add 'no filter' as no selection
	Private lstFirstNames As List
	lstFirstNames.Initialize
	lstFirstNames.Add("no filter")
	'we fill the B4XCombobox with the data from the database
	Do While ResultSet1.NextRow
		lstFirstNames.Add(ResultSet1.GetString("FirstName"))
	Loop
	cbxFirstName.SetItems(lstFirstNames)
	
	'fill the LastName B4XComboBox
	Query1 = "SELECT DISTINCT LastName FROM persons ORDER BY LastName ASC"
	ResultSet1 = MP.SQL1.ExecQuery(Query1)
	Private lstLastNames As List
	lstLastNames.Initialize
	lstLastNames.Add("no filter")
	'we fill the B4XCombobox with the data from the database
	Do While ResultSet1.NextRow
		lstLastNames.Add(ResultSet1.GetString("LastName"))
	Loop
	cbxLastName.SetItems(lstLastNames)
	
	'fill the City ComboBox
	Query1 = "SELECT DISTINCT City FROM persons ORDER BY City ASC"
	ResultSet1 = MP.SQL1.ExecQuery(Query1)
	Private lstCity As List
	lstCity.Initialize
	lstCity.Add("no filter")
	'we fill the B4XCombobox with the data from the database
	Do While ResultSet1.NextRow
		lstCity.Add(ResultSet1.GetString("City"))
	Loop
	cbxCity.SetItems(lstCity)

	ResultSet1.Close
End Sub

Private Sub GetFilterQuery As String
	'a query will look like something
	' WHERE FirstName = 'John'
	' WHERE FirstName = 'John' AND LastName = 'KENNEDY'
	' WHERE FirstName = 'John' AND City = 'London'
	' WHERE FirstName = 'John' AND LastName = 'KENNEDY' AND City = 'London'
	'the single quotes are needed because the values are strings
	
	Private Query1 = " WHERE " As String	'beginning of the query1
	
	'if a FirstName is selected then spnFirstName.SelectedIndex > 0 and we add FirstName = 'selected first name'
	If cbxFirstName.SelectedIndex > 0 Then
'		Query1 = Query1 & "FirstName = '" & cbxFirstName.Items.Get(cbxFirstName.SelectedIndex) & "' "
		Query1 = Query1 & "FirstName = '" & cbxFirstName.GetItem(cbxFirstName.SelectedIndex) & "' "
	End If
	'if a LastName is selected then we add
	' LastName = 'selected last name' if no first name was selected
	' AND LastName = 'selected last name' or OR LastName = 'selected last name'
	'depending on the boolean operator
	If cbxLastName.SelectedIndex > 0 Then
		If Query1 = " WHERE " Then
'			Query1 = Query1 & "LastName = '" & cbxLastName.Items.Get(cbxLastName.SelectedIndex) & "' "
			Query1 = Query1 & "LastName = '" & cbxLastName.GetItem(cbxLastName.SelectedIndex) & "' "
		Else
'			Query1 = Query1 & BooleanOperator & "LastName = '" & cbxLastName.Items.Get(cbxLastName.SelectedIndex) & "' "
			Query1 = Query1 & BooleanOperator & "LastName = '" & cbxLastName.GetItem(cbxLastName.SelectedIndex) & "' "
		End If
	End If

	'if a City is selected then we add
	' City = 'selected city' if it's the first selection
	' AND City = 'selected city' or OR City = 'selected city'
	'depending on the boolean operator
	If cbxCity.SelectedIndex > 0 Then
		If Query1 = " WHERE " Then
			Query1 = Query1 & "City = '" & cbxCity.GetItem(cbxCity.SelectedIndex) & "' "
		Else
			Query1 = Query1 & BooleanOperator & "City = '" & cbxCity.GetItem(cbxCity.SelectedIndex) & "' "
		End If
	End If
	
	'if nothing was selected set Query = ""
	If Query1 = " WHERE " Then
		Query1 = ""
	End If
	
	Return Query1
End Sub
