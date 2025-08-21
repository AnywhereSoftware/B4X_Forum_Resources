Type=StaticCode
Version=2.31
ModulesStructureVersion=1
B4i=true
@EndOfDesignText@
'Code module
'version 1.00
Sub Process_Globals
	Private states As Map
	Private listPosition As Int
	Private Const StatesFileName = "state.dat", SettingsFileName = "settings.properties" As String
	Private settings As Map
End Sub

'Gets the setting value associated with the given key.
'Returns the DefaultValue parameter if the key was not found.
Public Sub GetSetting2(Key As String, DefaultValue As String) As String
	If settings.IsInitialized = False Then
		'load the stored settings
		If File.Exists(File.DirLibrary, SettingsFileName) Then 
			settings = File.ReadMap(File.DirLibrary, SettingsFileName)
		Else
			Return DefaultValue
		End If
	End If
	Dim v As String
	v = settings.GetDefault(Key.ToLowerCase, DefaultValue)
	Return v
End Sub
'Gets the setting value associated with the given key.
'Returns an empty string if the key was not found.
Public Sub GetSetting(Key As String) As String
	Return GetSetting2(Key, "")
End Sub
Public Sub SetSetting(Key As String, Value As String)
	If settings.IsInitialized = False Then
		'load the stored settings
		If File.Exists(File.DirLibrary, SettingsFileName) Then 
			settings = File.ReadMap(File.DirLibrary, SettingsFileName)
		Else
			settings.Initialize
		End If
	End If
	settings.Put(Key.ToLowerCase, Value)
End Sub

'Stores the settings in a file
Public Sub SaveSettings
	If settings.IsInitialized Then
		File.WriteMap(File.DirLibrary, SettingsFileName, settings)
	End If
End Sub

'Resets the stored state data for this page.
Public Sub ResetState(PageName As String)
	loadStateFile
	If states.IsInitialized Then 
		states.Remove(PageName.ToLowerCase)
		writeStateToFile
	End If
End Sub

Public Sub SaveState(Page As Page, PageName As String)
	If states.IsInitialized = False Then states.Initialize
	Dim list1 As List
	list1.Initialize
	list1.Add(DateTime.Now)
	For Each v As View In Page.RootPanel.GetAllViewsRecursive
		Dim data() As Object = SaveView(v)
		If data.Length > 0 Then list1.Add(data)
	Next
	states.Put(PageName.ToLowerCase, list1)
	writeStateToFile
End Sub

Private Sub writeStateToFile
	Dim raf As RandomAccessFile
	raf.Initialize(File.DirLibrary, StatesFileName, False)
	raf.WriteB4XObject(states, raf.CurrentPosition)
	raf.Close
End Sub

Private Sub SaveView(v As View) As Object()
	Dim data() As Object
	If v Is TextField Then
		Dim tf As TextField = v
		data = Array(tf.Text)
	Else If v Is TextView Then
		Dim tv As TextView = v
		data = Array(tv.Text)
	Else If v Is DatePicker Then
		Dim dp As DatePicker = v
		data = Array(dp.Ticks)
	Else If v Is Picker Then
		Dim p As Picker = v
		Dim no As NativeObject = p
		'find the number of columns
		Dim len As Int = no.GetField("dataSource").RunMethod("numberOfComponentsInPickerView:", Array(p)).AsNumber
		Dim data(len + 1) As Object 'there is an empty slot in index 0.
		data(0) = 0
		For i = 0 To len - 1
			data(i + 1) = p.GetSelectedRow(i)
		Next
	Else If v Is ScrollView Then
		Dim sv As ScrollView = v
		data = Array(sv.ScrollOffsetX, sv.ScrollOffsetY)
	Else If v Is SegmentedControl Then
		Dim sc As SegmentedControl = v
		data = Array(sc.SelectedIndex)
	Else If v Is Slider Then
		Dim slid As Slider = v
		data = Array(slid.Value)
	Else If v Is Stepper Then
		Dim st As Stepper = v
		data = Array(st.Value)
	Else If v Is Switch Then
		Dim sw As Switch = v
		data = Array(sw.Value)
	End If
	Return data
End Sub

Private Sub RestoreView(v As View, list1 As List)
	Dim data() As Object
	If v Is TextField Then
		Dim tf As TextField = v
		data = getNextItem(list1)
		tf.Text = data(0)
	Else If v Is TextView Then
		Dim tv As TextView = v
		data = getNextItem(list1)
		tv.Text = data(0)
	Else If v Is DatePicker Then
		Dim dp As DatePicker = v
		data = getNextItem(list1)
		dp.Ticks = data(0)
	Else If v Is Picker Then
		Dim p As Picker = v
		data = getNextItem(list1)
		For i = 1 To data.Length - 1
			p.SelectRow(i - 1, data(i), True)
		Next
	Else If v Is ScrollView Then
		Dim sv As ScrollView = v
		data = getNextItem(list1)
		sv.ScrollOffsetX = data(0)
		sv.ScrollOffsetY = data(1)
	Else If v Is SegmentedControl Then
		data = getNextItem(list1)
		Dim sc As SegmentedControl = v
		sc.SelectedIndex = data(0)
	Else If v Is Slider Then
		Dim slid As Slider = v
		data = getNextItem(list1)
		slid.Value = data(0)
	Else If v Is Stepper Then
		Dim st As Stepper = v
		data = getNextItem(list1)
		st.Value = data(0)
	Else If v Is Switch Then
		Dim sw As Switch = v
		data = getNextItem(list1)
		sw.Value = data(0)
	End If
End Sub

Private Sub getNextItem(list1 As List) As Object()
	listPosition = listPosition + 1
	Return list1.Get(listPosition)
End Sub

'Loads the stored state (if such is available)
'PageName - Should match the value use in SaveState
'ValidPeriodInMinutes - The validity period of this state measured in minutes. Pass 0 for an unlimited period.
'Returns true if the state was loaded
Public Sub RestoreState(Page As Page, PageName As String, ValidPeriodInMinutes As Int) As Boolean
	Try
		loadStateFile
		If states.IsInitialized = False Then
			Return False
		End If
		Dim list1 As List
		list1 = states.Get(PageName.ToLowerCase)
		If list1.IsInitialized = False Then Return False
		Dim time As Long
		time = list1.Get(0)
		If ValidPeriodInMinutes > 0 AND time + ValidPeriodInMinutes * DateTime.TicksPerMinute < DateTime.Now Then
			Return False
		End If
		listPosition = 0
		For Each v As View In Page.RootPanel.GetAllViewsRecursive
			RestoreView(v, list1)
		Next
		Return True
	Catch
		Log("Error loading state.")
		Log(LastException.Description)
		Return False
	End Try
End Sub

Private Sub loadStateFile
	'only load the state if it is not already available in memory.
	If states.IsInitialized Then Return
	If File.Exists(File.DirLibrary, StatesFileName) Then
		Dim raf As RandomAccessFile
		raf.Initialize(File.DirLibrary, StatesFileName, False)
		states = raf.ReadB4XObject(0)
		raf.Close
	End If
End Sub