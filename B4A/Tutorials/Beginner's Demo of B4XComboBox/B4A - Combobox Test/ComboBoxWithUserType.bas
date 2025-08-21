B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9.5
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

	Private B4XComboBoxSimpleList As B4XComboBox
	Private ListOfUserTypes As List
	
	Type ItemData(ID As Int, Name As String, Code As String)
	
	Private lblID As Label
	Private lblName As Label
	Private lblCode As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("4")
	ListOfUserTypes.Initialize
	
	B4XComboBoxSimpleList.mBase.Color = Colors.Red
	B4XComboBoxSimpleList.mBase.SetColorAndBorder(Colors.Blue,2dip,Colors.Yellow,3dip)
	
	'This populates a List with a series of objects of type ItemData
	Dim i As Int
	For i = 0 To 15
		Dim singleItem As ItemData
		singleItem.Initialize
		singleItem.ID = i
		singleItem.Name = "Item " & i
		singleItem.Code = i *  10
		ListOfUserTypes.Add(singleItem)
	Next
	
	B4XComboBoxSimpleList.cmbBox.DropdownBackgroundColor = Colors.Blue
	
	'Now we iterate (go through) the list and pick out the bit we want displayed on the ComboBox
	For Each individualitem As ItemData In ListOfUserTypes
		B4XComboBoxSimpleList.cmbBox.Add(individualitem.Name)
	Next
	
	'Point to the first item on the list
	B4XComboBoxSimpleList.SelectedIndex = 0
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub


Sub B4XComboBoxSimpleList_SelectedIndexChanged (Index As Int)
	'We use the index of the selected item in the ComboBox to reference back into our list of UserType Objects
	'and pull out the object that was the source for the Combobox entry
	Dim selectedItem As ItemData
	selectedItem = ListOfUserTypes.Get(Index)
	
	'Now we've got it, we can display its values.
	lblID.Text = "Selected item has ID: " & selectedItem.ID
	lblName.Text = "Selected item has Name: " & selectedItem.Name
	lblCode.Text = "Selected item has Code: " & selectedItem.Code
	
End Sub