B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.45
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private AS_Settings1 As AS_Settings
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("frm_Settings")
	
	B4XPages.SetTitle(Me,"Settings")
	
	AS_Settings1.MainPage.AddProperty_Custom("","PremiumButton",90dip) 'Adds the Premium Button
	
	
	'Just Example Properties
	AS_Settings1.MainPage.AddGroup("Basic","Basic Settings")
	AS_Settings1.MainPage.AddDescriptionItem("","Show sync help: when enabled, you'll see an explanation alert every time you tap 'Sync' on the Today tab.")
	AS_Settings1.MainPage.AddProperty_Boolean("Basic","PropertyName_1","Overview in the morning","Your goals for today: Goal1, Goal2, Goal3",Null,True)
	AS_Settings1.MainPage.AddProperty_Boolean("Basic","PropertyName_2","Boolean Property False","Description Long Long Long Long Long Long Long Long Long Long Long Long Long Long Test Text",Null,False)

	'Creates the settings page
	AS_Settings1.MainPage.Create

End Sub


Private Sub AS_Settings1_CustomDrawCustomProperty(CustomProperty As AS_Settings_CustomDrawCustomProperty)
	
	Select CustomProperty.Property.PropertyName
		Case "PremiumButton"
			
			If Main.HasPremium Then
				
				CustomProperty.BackgroundPanel.LoadLayout("frm_SettingsProperty_PremiumButton")
				CustomProperty.BackgroundPanel.Color = IIf(Main.isDarkMode,xui.Color_ARGB(255,19, 20, 22),xui.Color_White)
				Dim xpnl_SettingsProperty_PremiumButton As B4XView = CustomProperty.BackgroundPanel.GetView(0)
				Dim xlbl_TopText As B4XView = xpnl_SettingsProperty_PremiumButton.GetView(0)
				Dim xlbl_BottomText As B4XView = xpnl_SettingsProperty_PremiumButton.GetView(1)
				Dim xlbl_ActionButton As B4XView = xpnl_SettingsProperty_PremiumButton.GetView(2)
				xlbl_ActionButton.Visible = False
				xlbl_TopText.Text = "Thank you for using"
				xlbl_BottomText.Text = "YourApp Pro"
				
			Else
					
				CustomProperty.BackgroundPanel.LoadLayout("frm_SettingsProperty_BuyPremiumButton")
				CustomProperty.BackgroundPanel.Color = IIf(Main.isDarkMode,xui.Color_ARGB(255,19, 20, 22),xui.Color_White)
				
				Dim xpnl_SettingsProperty_PremiumButton As B4XView = CustomProperty.BackgroundPanel.GetView(0)
				xpnl_SettingsProperty_PremiumButton.Color = IIf(Main.isDarkMode,xui.Color_ARGB(200,255,255,255),xui.Color_ARGB(255,19, 20, 22))
				
				Dim xiv_AppLogo As B4XImageView = xpnl_SettingsProperty_PremiumButton.GetView(0).Tag
				If Main.isDarkMode Then
					xiv_AppLogo.Bitmap = xui.LoadBitmap(File.DirAssets,"AppIcon_Dark.png")
				Else
					xiv_AppLogo.Bitmap = xui.LoadBitmap(File.DirAssets,"AppIcon_Light.png")
				End If
				
				Dim xlbl_BuyPremiumText As B4XView = xpnl_SettingsProperty_PremiumButton.GetView(1)
				xlbl_BuyPremiumText.TextColor = IIf(Main.isDarkMode,xui.Color_Black,xui.Color_White)
				
				Dim xlbl_ActionButton As B4XView = xpnl_SettingsProperty_PremiumButton.GetView(2)
				xlbl_ActionButton.TextColor = IIf(Main.isDarkMode,xui.Color_Black,xui.Color_White)
					
			End If
			
	End Select
	
End Sub

Private Sub xpnl_SettingsProperty_PremiumButton_Click
	
	If Main.HasPremium Then
		
	Else
		B4XPages.ShowPage("b4xp_Premium") 'Shows the Premium site
	End If
	
End Sub