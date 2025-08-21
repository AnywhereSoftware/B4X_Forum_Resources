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
	Public SQLDataAccess As SQL
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

	Private B4XComboBoxMealType As B4XComboBox
	Private B4XComboBoxMealInformation As B4XComboBox
	Private lblMealChoice As Label
	
	Private ListOfMealTypes As List
	Private ListOfMeals As List

	Private CurrentlySelectedMealTypeID As Int
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("3")
	
	ListOfMealTypes.Initialize()
	ListOfMeals.Initialize()
	
	'Make things look pretty
	B4XComboBoxMealType.cmbBox.DropdownBackgroundColor = Colors.RGB(0x41,0xE4,0x24)
	B4XComboBoxMealInformation.cmbBox.DropdownBackgroundColor = Colors.RGB(0xFF,0x93,0x00)
	
	SQLDataAccess.Initialize(File.DirInternal,"FoodData.db",False)
	
	FillTheMealTypeComboBox
	FillTheListOfMealsComboBoxWithMealType(1)
	
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub FillTheMealTypeComboBox
	B4XComboBoxMealType.cmbBox.Clear
	
	Dim MealTypeInformation() As String
	
	'ExecuteMemoryTable will return a list of ARRAYS.
	
	'Each one of those arrays is a String Array - so in order to ACCESS each of those arrays
	'in each entry in the list, we need an array of strings!

	'We need to get a List containing arrays, each one of which will be a string array where Entry(0) will be the mealtype
	'We pull out the id just to illustrate some points later on - it's not actually needed
	
	ListOfMealTypes = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT id, mealtype FROM MealType",Null,0)

	'ListofMealTypes is an array of strings - so at each index in the List will be a string array
		
	'In this particular case, each string array will have two elements in it - the "id" and the "mealtype" variables selected above
	'id			in element(0)
	'mealtype	in element(1)
		 
	'*** Remember, each entry in ListofMealTypes is a String array! ***

	'********************************************************************
	'*** COMMENT OUT ONE OR OTHER OF THESE TWO CODE BLOCKS.           ***
	'*** THEY BOTH DO THE SAME THING, BUT IN SLIGHTLY DIFFERENT WAYS. ***
	'********************************************************************
	
	'**********************************************
	'BREAKING DOWN THE LIST CAN BE DONE THIS WAY...
	'**********************************************
	
	Dim i As Int
	For i = 0 To ListOfMealTypes.Size - 1
		 
		'Pull out each string array in ListofMealTypes and assign it to a string array to allow us to access the array elements
		MealTypeInformation = ListOfMealTypes.Get(i)
		
		'Now we just add the element that we want to display to the Combobox
		B4XComboBoxMealType.cmbBox.Add(MealTypeInformation(1))
	Next
	
	'*****************************************
	'OR YOU COULD DO IT THIS WAY - YOU CHOOSE!
	'*****************************************
	
	'Clear the ComboBox because the previous code will have filled it up!
	B4XComboBoxMealType.cmbBox.Clear 
	For Each MealTypeInformation() As String In ListOfMealTypes	
		B4XComboBoxMealType.cmbBox.Add(MealTypeInformation(1))
	Next

	'******************
	'END OF CODE BLOCKS
	'******************
	
	'And finally we set the selected index to the first entry in the ComboBox, remembering that the first entry starts at 0
	B4XComboBoxMealType.SelectedIndex = 0

End Sub

Sub FillTheListOfMealsComboBoxWithMealType(MealTypeID As Int)
	B4XComboBoxMealInformation.cmbBox.Clear

	Dim MealInformation() As String
	
	'ExecuteMemoryTable will return a list of ARRAYS.
	
	'Each one of those arrays is a String Array - so in order to ACCESS each of those arrays
	'in each entry in the list, we need an array of strings!

	'We need to get a List containing arrays, each one of which will be a string array where Entry(0) will be the mealname
	'We pull out the id just to illustrate some points later on - it's not actually needed
	
	'Note that we only select meals which match the passed Meal Type ID
	ListOfMeals = DBUtils.ExecuteMemoryTable(SQLDataAccess,"SELECT id, mealname FROM Meals WHERE id_mealtype =" & MealTypeID,Null,0)

	For Each MealInformation() As String In ListOfMeals
		B4XComboBoxMealInformation.cmbBox.Add(MealInformation(1))
	Next

	'Set the selected index to the first entry in the ComboBox, remembering that the first entry starts at 0
	B4XComboBoxMealInformation.SelectedIndex = 0
End Sub

Sub B4XComboBoxMealType_SelectedIndexChanged (Index As Int)
	'We use index + 1 because the IDs in the data lists start from 1 rather than 0
	'The meal Type changed, so we want to fill the List of Meals correctly depending on the Meal Type
	FillTheListOfMealsComboBoxWithMealType(Index + 1)
End Sub

Sub B4XComboBoxMealInformation_SelectedIndexChanged (Index As Int)
	Dim mealChoice As String
	'Note here that we don't have to add anything to the passed Index, because this index is used to go into the ComboBox, NOT the data that filled the box!
	'eg Line 0 was selected, so we just want to go into Line 0, and get the item there (in this case a string giving us Meal Information)
	mealChoice = "You have chosen " & B4XComboBoxMealInformation.cmbBox.GetItem(Index)
	lblMealChoice.Text = mealChoice
End Sub