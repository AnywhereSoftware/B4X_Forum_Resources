B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private AS_Settings1 As AS_Settings
	Private BottomDatePicker As AS_BottomDatePicker
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS Settings Example")
	
	AS_Settings1.MainPage.AddGroup("Advanced","Advanced Settings")
	
	AS_Settings1.PropertyProperties.xFont = xui.CreateDefaultFont(16)
	
	AS_Settings1.MainPage.AddProperty_Chooser("Advanced","PropertyName_1","DatePicker Example","",Null,"",100dip)
	AS_Settings1.MainPage.AddProperty_Chooser("Advanced","PropertyName_2","Date Range Example","",Null,"",180dip)
	
	AS_Settings1.MainPage.Create
	
End Sub

Private Sub B4XPage_KeyboardStateChanged (Height As Float)
	
	AS_Settings1.Base_Resize(Root.Width,Root.Height - Height)
	
End Sub

Private Sub AS_Settings1_ValueChanged(Property As AS_Settings_Property, Value As Object)
	Log("ValueChanged " & Property.PropertyName & ": " & Value)
End Sub


Private Sub AS_Settings1_ChooserTextFieldClicked(Property As AS_Settings_Property)
	Log("ChooserTextFieldClicked")
	If Property.PropertyName = "PropertyName_1" Then
		ShowDatePicker(Property,False)
	Else If Property.PropertyName = "PropertyName_2" Then
		ShowDatePicker(Property,True)
	End If
	
End Sub


Private Sub ShowDatePicker(Property As AS_Settings_Property,isRangeDate As Boolean)
	
	BottomDatePicker.Initialize(Me,"BottomDatePicker",Root)
	BottomDatePicker.Tag = Property
	BottomDatePicker.ConfirmationMode = BottomDatePicker.ConfirmationMode_Button
	
	If isRangeDate Then
		BottomDatePicker.SelectMode = BottomDatePicker.SelectMode_Range
	Else
		BottomDatePicker.SelectMode = BottomDatePicker.SelectMode_Day
	End If
	
	BottomDatePicker.ShowPicker
	BottomDatePicker.ConfirmationButton.Text = "Confirm Date"
	
End Sub

Private Sub BottomDatePicker_ConfirmButtonClicked
	Dim BottomDatePicker As AS_BottomDatePicker = Sender
	Dim Property As AS_Settings_Property = BottomDatePicker.Tag

	
	If Property.PropertyName = "PropertyName_1" Then
		Property.Value = BottomDatePicker.SelectedDate
		Property.DisplayValueText = DateTime.Date(BottomDatePicker.SelectedDate)
	Else If Property.PropertyName = "PropertyName_2" Then
		Property.Value = CreateMap("StartDate":BottomDatePicker.SelectedStartDate,"EndDate":BottomDatePicker.SelectedEndDate)
		Property.DisplayValueText = DateTime.Date(BottomDatePicker.SelectedDate) & "-" & DateTime.Date(BottomDatePicker.SelectedEndDate)
	End If
	
	AS_Properties.PutProperty(Property.PropertyName,Property.Value)
	AS_Properties.PutPropertyDisplayValueText(Property.PropertyName,Property.DisplayValueText)
	
	AS_Settings1.GetTopPage.Refresh

End Sub


