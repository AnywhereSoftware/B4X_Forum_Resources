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

	Private B4XComboBoxMealInformation As B4XComboBox
	Private B4XComboBoxMealType As B4XComboBox
	
	Private ListOfMealTypes As List
	Private ListOfMeals As List
	
	Private MealTypes(3) As MealType
	Private Meals(14) As MealChoice

	Private CurrentlySelectedMealTypeID As Int
	
	Private lblMealChoice As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:

	Activity.LoadLayout("2")

	ListOfMealTypes.Initialize()
	ListOfMeals.Initialize()

	'Make things look pretty
	B4XComboBoxMealType.cmbBox.DropdownBackgroundColor = Colors.RGB(0x41,0xE4,0x24)
	B4XComboBoxMealInformation.cmbBox.DropdownBackgroundColor = Colors.RGB(0xFF,0x93,0x00)

	LoadUpSomeFoodData
	FillTheMealTypeComboBox
	
	'The Selected Index for a ComboBox starts at 0 for the first item in the ComboBox List
	'However, the IDs for each Meal Type start at 1, so we have to add 1 to the index to create the correct Meal Type ID
	CurrentlySelectedMealTypeID = 1
	
	'With this CORRECTED Meal Type ID (starting from 1 rather than 0), we can call a Sub which fills the ComboBox showing the list of meals.
	FillTheListOfMealsComboBoxWithMealType(CurrentlySelectedMealTypeID)
	
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub FillTheMealTypeComboBox
	B4XComboBoxMealType.cmbBox.Clear
	
	'Now we've cleared the Meal Type Combobox, we can go ahead and iterate through the list of meal types
	'and add the item that we want (the string with the mealtype description) into the ComboBox
	For Each singleMealType As MealType In ListOfMealTypes
		B4XComboBoxMealType.cmbBox.Add(singleMealType.mealtype)
	Next

	'And finally we set the selected index to the first entry in the ComboBox, remembering that the first entry starts at 0
	B4XComboBoxMealType.SelectedIndex = 0
End Sub

Sub FillTheListOfMealsComboBoxWithMealType(MealTypeID As Int)
	B4XComboBoxMealInformation.cmbBox.Clear

	'Now we've cleared the List of Meals Combobox, we can go ahead and iterate through the list of meals
	'and add the item that we want (the string with the meal description for the specified MealTypeID) into the ComboBox
	
	'We only want to show Meals of the correct Meal type - ones that match the passed Meal Type ID.
		
	'We do this by comparing the singleMeal foreign key (id_mealtype) with the MealType ID that has been passed,
	'and if they match then we add that meal to the ComboBox
	
	'So we end up only showing meals which match the meal type ID passed into the funtion.
	'(If you selected Starter, you only see Starters. If you selected Main Course, you only see Main Course meals etc etc)
	
	For Each singleMeal As MealChoice In ListOfMeals
		If singleMeal.id_mealtype = MealTypeID Then
			B4XComboBoxMealInformation.cmbBox.Add(singleMeal.mealname)
		End If
	Next

	'And finally we set the selected index to the first entry in the ComboBox, remembering that the first entry starts at 0
	B4XComboBoxMealInformation.SelectedIndex = 0
End Sub

Sub B4XComboBoxMealInformation_SelectedIndexChanged (Index As Int)
	Dim mealChoice As String
	'Note here that we don't have to add anything to the passed Index, because this index is used to go into the ComboBox, NOT the data that filled the box!
	'eg Line 0 was selected, so we just want to go into Line 0, and get the item there (in this case a string giving us Meal Information)
	mealChoice = "You have chosen " & B4XComboBoxMealInformation.cmbBox.GetItem(Index)
	lblMealChoice.Text = mealChoice
End Sub

Sub B4XComboBoxMealType_SelectedIndexChanged (Index As Int)
	'We use index + 1 because the IDs in the data lists start from 1 rather than 0
	'The meal Type changed, so we want to fill the List of Meals correctly depending on the Meal Type
	FillTheListOfMealsComboBoxWithMealType(Index + 1)	
End Sub

Sub LoadUpSomeFoodData()
	MealTypes(0).Initialize
	MealTypes(0).id = 1
	MealTypes(0).mealtype = "Starter"
	ListOfMealTypes.Add(MealTypes(0))
	
	MealTypes(1).Initialize
	MealTypes(1).id = 2
	MealTypes(1).mealtype = "Main Course"
	ListOfMealTypes.Add(MealTypes(1))

	MealTypes(2).Initialize
	MealTypes(2).id = 3
	MealTypes(2).mealtype = "Dessert"
	ListOfMealTypes.Add(MealTypes(2))
	
	Meals(0).Initialize
	Meals(0).id = 1								'Unique ID for this item
	Meals(0).id_mealtype = 1					'This is the Foreign Key pointing to the FoodType Table - Starter
	Meals(0).mealname = "Soup of the day"		'And this is what it is!
	ListOfMeals.Add(Meals(0))
	
	Meals(1).Initialize
	Meals(1).id = 2								'Unique ID for this item
	Meals(1).id_mealtype = 1					'This is the Foreign Key pointing to the FoodType Table - Starter
	Meals(1).mealname = "Chicken Nuggets"		'And this is what it is!
	ListOfMeals.Add(Meals(1))
	
	Meals(2).Initialize
	Meals(2).id = 3								'Unique ID for this item
	Meals(2).id_mealtype = 1					'This is the Foreign Key pointing to the FoodType Table - Starter
	Meals(2).mealname = "Salmon and Toast"		'And this is what it is!
	ListOfMeals.Add(Meals(2))

	Meals(3).Initialize
	Meals(3).id = 4								'Unique ID for this item
	Meals(3).id_mealtype = 1					'This is the Foreign Key pointing to the FoodType Table - Starter
	Meals(3).mealname = "Brie and Cranberry Sauce"		'And this is what it is!
	ListOfMeals.Add(Meals(3))
	
	Meals(4).Initialize
	Meals(4).id = 5								'Unique ID for this item
	Meals(4).id_mealtype = 1					'This is the Foreign Key pointing to the FoodType Table - Starter
	Meals(4).mealname = "Melon and parma ham"	'And this is what it is!
	ListOfMeals.Add(Meals(4))
	
	Meals(5).Initialize
	Meals(5).id = 6								'Unique ID for this item
	Meals(5).id_mealtype = 2					'This is the Foreign Key pointing to the FoodType Table - Main Course
	Meals(5).mealname = "Steak and chips"		'And this is what it is!
	ListOfMeals.Add(Meals(5))

	Meals(6).Initialize
	Meals(6).id = 7								'Unique ID for this item
	Meals(6).id_mealtype = 2					'This is the Foreign Key pointing to the FoodType Table - Main Course
	Meals(6).mealname = "Sausage and Mash"		'And this is what it is!
	ListOfMeals.Add(Meals(6))

	Meals(7).Initialize
	Meals(7).id = 8								'Unique ID for this item
	Meals(7).id_mealtype = 2					'This is the Foreign Key pointing to the FoodType Table - Main Course
	Meals(7).mealname = "Hunter's Chicken"		'And this is what it is!
	ListOfMeals.Add(Meals(7))
	
	Meals(8).Initialize
	Meals(8).id = 9										'Unique ID for this item
	Meals(8).id_mealtype = 2							'This is the Foreign Key pointing to the FoodType Table - Main Course
	Meals(8).mealname = "Roast Beef and Vegetables"		'And this is what it is!
	ListOfMeals.Add(Meals(8))

	Meals(9).Initialize
	Meals(9).id = 10									'Unique ID for this item
	Meals(9).id_mealtype = 2							'This is the Foreign Key pointing to the FoodType Table - Main Course
	Meals(9).mealname = "Lasagne and Salad"				'And this is what it is!
	ListOfMeals.Add(Meals(9))

	Meals(10).Initialize
	Meals(10).id = 11									'Unique ID for this item
	Meals(10).id_mealtype = 3							'This is the Foreign Key pointing to the FoodType Table - Dessert
	Meals(10).mealname = "Sticky Toffee Pudding"		'And this is what it is!
	ListOfMeals.Add(Meals(10))
	
	Meals(11).Initialize
	Meals(11).id = 12									'Unique ID for this item
	Meals(11).id_mealtype = 3							'This is the Foreign Key pointing to the FoodType Table - Dessert
	Meals(11).mealname = "Chocolate Cake and Ice Cream"	'And this is what it is!
	ListOfMeals.Add(Meals(11))
	
	Meals(12).Initialize
	Meals(12).id = 13									'Unique ID for this item
	Meals(12).id_mealtype = 3							'This is the Foreign Key pointing to the FoodType Table - Dessert
	Meals(12).mealname = "3 scoops of ice cream"		'And this is what it is!
	ListOfMeals.Add(Meals(12))
	
	Meals(13).Initialize
	Meals(13).id = 14									'Unique ID for this item
	Meals(13).id_mealtype = 3							'This is the Foreign Key pointing to the FoodType Table - Dessert
	Meals(13).mealname = "Peach Melba Pie"				'And this is what it is!
	ListOfMeals.Add(Meals(13))
End Sub

