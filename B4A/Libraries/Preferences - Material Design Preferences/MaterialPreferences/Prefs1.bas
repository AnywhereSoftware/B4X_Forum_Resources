B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=6.8
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

'Always extend Preference Activities from this Class!
#Extends: de.amberhome.preferences.AppCompatPreferenceActivity

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

	Private ToolBar As ACToolBarDark
	Private PView As PreferenceView
	Private AC As AppCompat
	
	Private PrefManager As PreferenceManager
	
	Private TimePreference As SimplePreference
	Private DatePreference As SimplePreference
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.LoadLayout("prefsscreen")

	ToolBar.Color = AC.GetThemeAttribute("colorPrimary")
	Dim AB As ACActionBar
	AB.Initialize
	AB.ShowUpIndicator = True
	AB.HomeVisible = True
	ToolBar.InitMenuListener
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub Activity_ActionBarHomeClick
	Activity.Finish
End Sub

Sub ToolBar_NavigationItemClick
	Activity.Finish	
End Sub

Sub PView_Ready (PrefsView As PreferenceView)
	Log("PView_Ready")
	Dim xml As XmlLayoutBuilder

	Dim Months() As String = Array As String("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")

	'You can add Preference Items directly to the PreferenceView:
	PrefsView.AddCheckBoxPreference("", "checkbox1", "Sample Checkbox item", "The option is currently enabled", "The option is currently disabled", False)

	'Elements can be created manually:
	Dim SwitchPref As SwitchPreference
	SwitchPref.Initialize(PrefsView, "", "switch1", False)
	SwitchPref.Title = "A Switch preference"
	SwitchPref.Summary = "Summary of the Switch"
	PrefsView.AddPreference(SwitchPref)

	'A simple EditTextPreference. You can configure the EditText (InputType etc.) in the EditTextCreated event. See below.
	Dim etp As EditTextPreference
	etp = PrefsView.AddEditTextPreference("Edit", "edittext1", "Sample EditText item", "Summary for the EditText", "123")
	etp.NegativeButtonText="No way"
	etp.DialogMessage="This is a message in the dialog"
	
	'Preference items can be grouped in categories:
	Dim cat1 As PreferenceCategory
	cat1 = PrefsView.AddCategory("", "", "Category 1")
	
	'A simple SeekBar Preference
	cat1.AddSeekBarPreference("SeekBar", "seek1", "SeekBar", "", 0, 0, 100)
	
	'SeekBars can have a Value field:
	Dim SeekBarPref As SeekBarPreference
	SeekBarPref = cat1.AddSeekBarPreference("SeekBar", "seek2", "Second SeekBar with Info", "The summary for a small description", 100, 0, 100)
	SeekBarPref.ShowValue = True

	'SeekBars can also be displayed in a dialog. Every item can show an icon.
	Dim SeekBarDialog As SeekBarDialogPreference
	SeekBarDialog = cat1.AddSeekBarDialogPreference("", "seek3", "Dialog SeekBar", "Seekbar displayed in a dialog", 0, 0, 100)
	SeekBarDialog.Icon = xml.GetDrawable("ic_ring_volume_black_24dp")
	SeekBarDialog.DialogIcon = xml.GetDrawable("ic_ring_volume_black_24dp")
	'Colorize the Icon with the Accent Color
	SeekBarDialog.IconTintEnabled=True
	SeekBarDialog.DialogMessage = "This is a text for further info"
	SeekBarDialog.DialogIconTintEnabled=True

	'There are several ListPreference types
	Dim lp As ListPreference
	'Default is the dialog type
	lp = PrefsView.AddListPreference("Edit", "list1", "List Preference", "with dialog", "January", Months, Months)
	lp.MenuMode = lp.MENU_MODE_DIALOG

	'Additionally there is a simple menu type
	lp = PrefsView.AddListPreference("Edit", "list2", "List Preference ", "with simple menu", "January", Months, Months)
	lp.MenuMode = lp.MENU_MODE_SIMPLE_MENU

	'or a simple dialog type
	lp = PrefsView.AddListPreference("Edit", "list3", "List Preference", "with simpledialog", "January", Months, Months)
	lp.MenuMode = lp.MENU_MODE_SIMPLE_DIALOG

	'at least you can let the lib decide what to use
	lp = PrefsView.AddListPreference("Edit", "list4", "List Preference", "with simple adaptive", "January", Months, Months)
	lp.MenuMode = lp.MENU_MODE_SIMPLE_ADAPTIVE
	'Make the simple menu use the whole width
	lp.SimpleMenuMaxWidth = lp.MAXWIDTH_FIT_SCREEN

	PrefsView.AddMultiSelectListPreference("Multi", "multilist", "MultiSelectList Preference", "Select multiple Entries", Array As String("May"), Months, Months)

	'The SimplePreference can be used to create custom pickers. The action is handled in the
	'PreferenceClicked event. There you can show a custom picker dialog or whatever.
	'They key is not used here because a custom preference value needs to be set by the PrefManager.
	DatePreference = PrefsView.AddSimplePreference("Date", "", "Custom DatePicker", DateTime.Date(PrefManager.GetLong2("date1", DateTime.Now)), DateTime.Now)
	TimePreference = PrefsView.AddSimplePreference("Time", "", "Custom TimePicker", DateTime.Time(PrefManager.GetLong2("time1", DateTime.Now)), DateTime.Now)

	Dim cat2 As PreferenceCategory
	cat2 = PrefsView.AddCategory("", "", "Special Preference Elements")

	'Calling an Intent
	Dim In As Intent
	In.Initialize("android.settings.WIFI_SETTINGS", "")
	cat2.AddSimplePreference("", "", "Call Intent", "This item will start the WIFI Settings", "").Intent = In
	
	'A simple color Picker
	Dim colorValues() As Int = Array As Int(Colors.Black, Colors.Blue, Colors.Cyan, Colors.DarkGray, Colors.Gray, Colors.Green, Colors.LightGray, _
		Colors.Magenta, Colors.Red, Colors.White, Colors.Yellow)
	Dim colorNames() As String = Array As String("Black", "Blue", "Cyan", "DarkGray", "Gray", "Green", "LightGray", _
		"Magenta", "Red", "White", "Yellow")
	Dim colp As ColorPreference
	colp = cat2.AddColorPreference("Color", "color1", "Color Preference", "Example of a color picker preference", Colors.Black, colorValues, colorNames)
	colp.DialogIcon = xml.GetDrawable("ic_ring_volume_black_24dp")

	'Call another Preference Activity in the PreferenceClicked event
	cat2.AddSimplePreference("Dependency", "", "Dependency Demo", "Demonstration of dependencies", "")

End Sub

'Every Preference object can have a PreferenceClicked event which is called when the preference is clicked
Sub Dependency_PreferenceClicked (Preference As Preference)
	StartActivity(Prefs2)
End Sub

'A SeekBar has a ProgressChanged event which is called when the user changes the seekbar value.
'You can display an Info text at the Preference item.
'Be aware: this is not possible with the SeekBarDialogPreference object.
Sub SeekBar_ProgressChanged (Progress As Int, UserChanged As Boolean)
	Dim sbp As SeekBarPreference
	
	sbp = Sender
	sbp.Info = Progress & " %"
End Sub

'The Date Preference is clicked. We show the DatePicker.
Sub Date_PreferenceClicked (Preference As Preference)
	Dim DatePicker As DatePickerDialog
	Dim currentDate As Long

	currentDate = PrefManager.GetLong2("date1", DateTime.Now)
	DatePicker.Initialize("DatePicker", DateTime.GetYear(currentDate), DateTime.GetMonth(currentDate)-1, DateTime.GetDayOfMonth(currentDate))
	DatePicker.show("1")
End Sub

'A Date is selected in the DatePicker
Sub DatePicker_onDateSet(year As Int, monthOfYear As Int, dayOfMonth As Int)
	Dim selectedDate As Long
	
	selectedDate = DateUtils.SetDate(year, monthOfYear+1, dayOfMonth)
	PrefManager.SetString("date1", selectedDate)
	DatePreference.Summary = DateTime.Date(selectedDate)
	
	Log("Selected Date: " & DateTime.Date(selectedDate))
End Sub

'The Time Preference is clicked. We show the TimePicker.
Sub Time_PreferenceClicked (Preference As Preference)
	Dim TimePicker As TimePickerDialog
	Dim currentTime As Long
	
	currentTime = PrefManager.GetLong2("time1", DateTime.Now)
	TimePicker.Initialize("TimePicker", DateTime.GetHour(currentTime), DateTime.GetMinute(currentTime), True)
	TimePicker.show("1")
End Sub

'A Time is selected
Sub TimePicker_onTimeSet(hour As Int,minute As Int, second As Int)
	Dim selectedTime As Long
	
	selectedTime = DateUtils.SetDateAndTime(DateTime.GetYear(DateTime.Now), DateTime.GetMonth(DateTime.Now), DateTime.GetDayOfMonth(DateTime.Now), hour, minute, second)
	PrefManager.SetLong("time1", selectedTime)
	TimePreference.Summary = DateTime.Time(selectedTime)
	
	Log("Selected Time: " & DateTime.Time(selectedTime))
End Sub

'Every Preference can have a PreferenceChanged event. You can use this to
'display the current value in the summary for example.
Sub Edit_PreferenceChanged (Preference As Preference, NewValue As Object)
	Log("Preference Changed")
	Preference.Summary = NewValue
End Sub

'The EditTextPreference object has a EditTextCreated event. This is called when the EditText object is
'created so you can modify some settings. Here we set the InputType to only numbers. 
Sub Edit_EditTextCreated (Edit As EditText)
	Edit.InputType = Edit.INPUT_TYPE_DECIMAL_NUMBERS
End Sub

Sub Multi_PreferenceChanged (Preference As Preference, NewValue As List)
	Dim Values As String

	For Each v As String In NewValue
		Values = Values & v & " "
		Log("Value: " & v)
	Next
	
	Preference.Summary = Values
End Sub

Sub SeekBar_PreferenceChanged (Preference As Preference, NewValue As Object)
	Log("New Value: " & NewValue)
End Sub


