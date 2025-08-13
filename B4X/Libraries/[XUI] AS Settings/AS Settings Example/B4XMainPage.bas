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
	Private SettingPage2 As AS_SettingsPage
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS Settings Example")
	
	AS_Settings1.MainPage.AddGroup("Basic","Basic Settings")
		
	AS_Settings1.MainPage.AddDescriptionItem("","Show sync help: when enabled, you'll see an explanation alert every time you tap 'Sync' on the Today tab.")
		
	'Boolean
	AS_Settings1.MainPage.AddProperty_Boolean("Basic","PropertyName_1","Overview in the morning","Your goals for today: Goal1, Goal2, Goal3",Null,True)
	AS_Settings1.MainPage.AddProperty_Boolean("Basic","PropertyName_2","Boolean Property False","Description Long Long Long Long Long Long Long Long Long Long Long Long Long Long Test Text",Null,False)

	AS_Settings1.MainPage.AddProperty_Boolean("Basic","PropertyName_3","Boolean Property True with a long text","",Null,True)
	'Action Button
	AS_Settings1.MainPage.AddProperty_Action("Basic","PropertyName_4","Action Property","",Null,"English")
	AS_Settings1.MainPage.AddProperty_Action("Basic","PropertyName_5","Icon","",AS_Settings1.FontToBitmap(Chr(0xF179),False,30,xui.Color_White),"English, German, Italian, Spanish, Swedish")
	AS_Settings1.MainPage.AddProperty_ActionClean("Basic","PropertyName_6","Delete Account","",AS_Settings1.FontToBitmap(Chr(0xE92B),True,34,xui.Color_White))
	AS_Settings1.MainPage.AddProperty_Action("Basic","PropertyName_7","Pro Feature","",Null,"Pro")
	
	AS_Settings1.MainPage.AddGroup("Advanced","Advanced Settings")
	
	'Numeric Example
	AS_Settings1.MainPage.AddProperty_Text("Advanced","PropertyName_8","Text Example","",Null,"Test",100dip,AS_Settings1.InputType_Text)
	AS_Settings1.MainPage.AddProperty_Text("Advanced","PropertyName_9","Numeric Example","",Null,24,60dip,AS_Settings1.InputType_Numeric)
	AS_Settings1.MainPage.AddProperty_Text("Advanced","PropertyName_10","Decimal Example","",Null,24.24,100dip,AS_Settings1.InputType_Decimal)
	'AS_Settings1.MainPage.AddProperty_Text("Advanced","PropertyName_12","Decimal Example",Null,24.24,100dip,AS_Settings1.InputType_IPv4,"")
	'ComboBox
	AS_Settings1.MainPage.AddProperty_ComboBox("Advanced","PropertyName_11","ComboBox Example","",Null,1,Array("Option 1","Option 2","Option 3","Option 4"))
	
	AS_Settings1.MainPage.BottomText = "Alexander Stolte" & CRLF & "V1.0.2"
	
	AS_Settings1.MainPage.Create
	
	
	'Second Page
	SettingPage2.Initialize(AS_Settings1,"Page #2")
	
	SettingPage2.AddGroup("Page2","Page 2 Settings")
	SettingPage2.AddProperty_Boolean("Page2","PropertyName_1","Overview in the morning","Your goals for today: Goal1, Goal2, Goal3",Null,True)
	SettingPage2.AddProperty_Boolean("Page2","PropertyName_2","Overview in the morning","Your goals for today: Goal1, Goal2, Goal3",Null,True)
	SettingPage2.AddProperty_Boolean("Page2","PropertyName_30","Overview in the morning","Your goals for today: Goal1, Goal2, Goal3",Null,True)
	SettingPage2.AddProperty_Boolean("Page2","PropertyName_31","Overview in the morning","Your goals for today: Goal1, Goal2, Goal3",Null,True)
	SettingPage2.AddProperty_Boolean("Page2","PropertyName_32","Overview in the morning","Your goals for today: Goal1, Goal2, Goal3",Null,True)
	SettingPage2.AddProperty_Boolean("Page2","PropertyName_33","Overview in the morning","Your goals for today: Goal1, Goal2, Goal3",Null,True)
	SettingPage2.AddProperty_Boolean("Page2","PropertyName_34","Overview in the morning","Your goals for today: Goal1, Goal2, Goal3",Null,True)
	
End Sub

Private Sub B4XPage_KeyboardStateChanged (Height As Float)
	
	AS_Settings1.Base_Resize(Root.Width,Root.Height - Height)
	
End Sub

Private Sub AS_Settings1_ValueChanged(Property As AS_Settings_Property, Value As Object)
	'Log("ValueChanged " & Property.PropertyName & ": " & Value)
	
	Select Property.PropertyName
		Case "PropertyName_1"
			AS_Settings1.MainPage.SetProperty_Boolean("PropertyName_2",Value)
			AS_Settings1.MainPage.SetProperty_Boolean("PropertyName_3",Value)
			AS_Settings1.MainPage.GetProperty("PropertyName_2").View.As(B4XSwitch).Enabled = Value
			AS_Settings1.MainPage.GetProperty("PropertyName_3").View.As(B4XSwitch).Enabled = Value
		Case Else
			Log("PropertyName: " & Property.PropertyName & " Value: " & Value)
	End Select
	
End Sub

Private Sub AS_Settings1_ActionClicked(Property As AS_Settings_Property)
	Log("ActionClicked: " & Property.PropertyName)
	
	If Property.PropertyName = "PropertyName_4" Or Property.PropertyName = "PropertyName_5" Or Property.PropertyName = "PropertyName_7" Then	
		'Shows an input box
		'ShowInputBox(Property.Value,Property.PropertyName)
		SettingPage2.ShowPage
	End If

End Sub

Private Sub AS_Settings1_CustomDrawProperty(CustomDrawProperty As AS_Settings_CustomDrawProperty)
	
	If CustomDrawProperty.Property.PropertyName = "PropertyName_6" Then
		CustomDrawProperty.PropertyViews.NameLabel.TextColor = xui.Color_ARGB(255,221, 95, 96)
		CustomDrawProperty.PropertyViews.IconImageView.SetBitmap(AS_Settings1.FontToBitmap(Chr(0xE92B),True,34,xui.Color_ARGB(255,221, 95, 96)))
	else If CustomDrawProperty.Property.PropertyName = "PropertyName_7" Then
		
		Dim ChipWidth As Float = 45dip
		Dim ChipHeight As Float = 20dip
		
		Dim xlbl_ProVersionChip As B4XView = CustomDrawProperty.PropertySettingViews.ActionValueLabel
		Dim xlbl_ActionButtonArrowLabel As B4XView = CustomDrawProperty.PropertySettingViews.ActionButtonArrowLabel
		xlbl_ProVersionChip.SetTextAlignment("CENTER","CENTER")
		xlbl_ProVersionChip.Font = xui.CreateDefaultBoldFont(15)
		xlbl_ProVersionChip.SetColorAndBorder(xui.Color_ARGB(255,81,190,97),0,0,ChipHeight/2)
		'Resize the Chip Label
		xlbl_ProVersionChip.SetLayoutAnimated(0,xlbl_ActionButtonArrowLabel.Left - ChipWidth - 5dip,CustomDrawProperty.PropertySettingViews.BackgroundPanel.Height/2 - ChipHeight/2,ChipWidth,ChipHeight)
	
	End If
	
End Sub


Private Sub ShowInputBox(DefaultText As String,PropertyName As String)
	Dim dialog As B4XDialog
	dialog.Initialize(Root)
	Dim input As B4XInputTemplate
	input.Initialize
	input.lblTitle.Text = "Title"
	input.Text = DefaultText
	Wait For (dialog.ShowTemplate(input, "OK", "", "CANCEL")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		AS_Properties.PutProperty(PropertyName,input.Text)
		AS_Settings1.MainPage.Refresh
	End If
End Sub