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
	Private TimePicker As AS_TimePickerDialog
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS Settings Example")
	
	AS_Settings1.MainPage.AddGroup("Advanced","Advanced Settings")
	
	AS_Settings1.MainPage.AddProperty_Chooser("Advanced","PropertyName_1","TimePicker Example","",Null,"",110dip)
	AS_Settings1.MainPage.AddProperty_Custom("Advanced","PropertyName_2","2 TimePickers","",Null,"")
	
	AS_Settings1.MainPage.Create
	
End Sub

Private Sub B4XPage_KeyboardStateChanged (Height As Float)
	
	AS_Settings1.Base_Resize(Root.Width,Root.Height - Height)
	
End Sub

Private Sub AS_Settings1_ValueChanged(Property As AS_Settings_Property, Value As Object)
	Log("ValueChanged " & Property.PropertyName & ": " & Value)
End Sub


Private Sub AS_Settings1_ChooserTextFieldClicked(Property As AS_Settings_Property)

		ShowTimePicker(Property)
	
End Sub


Private Sub ShowTimePicker(Property As AS_Settings_Property)
	
	TimePicker.Initialize(Root)
	TimePicker.SetDarkMode
	
	Wait For (TimePicker.ShowDialog) Complete (PickerDialogResponse As AS_TimePickerDialog_DialogResponse)
	If PickerDialogResponse.Result = xui.DialogResponse_Positive Then

		If Property.PropertyName = "PropertyName_1" Then
			Property.Value = CreateMap("Hour":PickerDialogResponse.Hour,"Minute":TimePicker.Minute)
			Property.DisplayValueText = PickerDialogResponse.Hour & ":" & NumberFormat(PickerDialogResponse.Minute,2,0)
		End If
	
		AS_Properties.PutProperty(Property.PropertyName,Property.Value)
		AS_Properties.PutPropertyDisplayValueText(Property.PropertyName,Property.DisplayValueText)
	
		AS_Settings1.GetTopPage.Refresh

	End If
	
End Sub

Private Sub AS_Settings1_CustomDrawProperty(CustomDrawProperty As AS_Settings_CustomDrawProperty)
	
	If CustomDrawProperty.Property.PropertyName = "PropertyName_2" Then
		
		Dim m_PropertyValues As Map = IIf(CustomDrawProperty.Property.Value Is Map,CustomDrawProperty.Property.Value,CreateMap("":""))
		
		Dim BackgroundPanel As B4XView = CustomDrawProperty.PropertyViews.RightBackgroundPanel
		
		AS_Settings1.GetTopPage.CustomDrawProperty_Add(BackgroundPanel, AS_Settings1.GetTopPage.CustomDrawProperty_AddChooser(Me,"TimeStart"),60dip,AS_Settings1.PropertyProperties.FieldHeight).Text = m_PropertyValues.GetDefault("StartHour","14") & ":" & NumberFormat(m_PropertyValues.GetDefault("StartMinute","00"),2,0)
		AS_Settings1.GetTopPage.CustomDrawProperty_Add(BackgroundPanel, AS_Settings1.GetTopPage.CustomDrawProperty_AddText(Me,"","-"),20dip,AS_Settings1.PropertyProperties.FieldHeight)
		AS_Settings1.GetTopPage.CustomDrawProperty_Add(BackgroundPanel, AS_Settings1.GetTopPage.CustomDrawProperty_AddChooser(Me,"TimeEnd"),60dip,AS_Settings1.PropertyProperties.FieldHeight).Text = m_PropertyValues.GetDefault("EndHour","15") & ":" & NumberFormat(m_PropertyValues.GetDefault("EndMinute","00"),2,0)
		
	End If
	
End Sub

Private Sub TimeStart_Clicked(Property As AS_Settings_Property,View As Object)
	
	TimePicker.Initialize(Root)
	TimePicker.SetDarkMode
	
	Wait For (TimePicker.ShowDialog) Complete (PickerDialogResponse As AS_TimePickerDialog_DialogResponse)
	If PickerDialogResponse.Result = xui.DialogResponse_Positive Then
		
		Dim m_Properties As Map
		If Property.Value Is Map Then
			m_Properties = Property.Value
		Else
			m_Properties.Initialize
		End If
		
		m_Properties.Put("StartHour",PickerDialogResponse.Hour)
		m_Properties.Put("StartMinute",PickerDialogResponse.Minute)
		Property.Value = m_Properties
		
		View.As(B4XView).Text = PickerDialogResponse.Hour & ":" & NumberFormat(PickerDialogResponse.Minute,2,0)
	
		AS_Properties.PutProperty(Property.PropertyName,Property.Value)
	
	End If
	
End Sub

Private Sub TimeEnd_Clicked(Property As AS_Settings_Property,View As Object)
	
	TimePicker.Initialize(Root)
	TimePicker.SetDarkMode
	
	Wait For (TimePicker.ShowDialog) Complete (PickerDialogResponse As AS_TimePickerDialog_DialogResponse)
	If PickerDialogResponse.Result = xui.DialogResponse_Positive Then
		
		Dim m_Properties As Map
		If Property.Value Is Map Then
			m_Properties = Property.Value
		Else
			m_Properties.Initialize
		End If
		m_Properties.Put("EndHour",PickerDialogResponse.Hour)
		m_Properties.Put("EndMinute",PickerDialogResponse.Minute)
		Property.Value = m_Properties
		
		View.As(B4XView).Text = PickerDialogResponse.Hour & ":" & NumberFormat(PickerDialogResponse.Minute,2,0)
	
		AS_Properties.PutProperty(Property.PropertyName,Property.Value)
	
	End If
	
End Sub
