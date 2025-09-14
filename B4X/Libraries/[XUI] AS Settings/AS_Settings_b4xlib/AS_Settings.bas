B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
#If Documentation
Conditional Symbols
-SETTINGS_SegmentedTab
-SETTINGS_PlusMinus

Updates
V1.00
	-Release
V1.01
	-AS_Settings
		-BugFixes
		-Add AddProperty_SegmentedTab - You can now add the AS_SegmentedTab
		-Add AddProperty_PlusMinus - You can now add the AS_PlusMinus
		-Add get ValueTypeTextProperties - Change the appearance of the text edits
		-Breaking Change - Add Description Property to all AddProperty_ functions
			-You can now display a short descripton to your properties
		-Add Designer Property ShowMadeWithLove - Shows the Made with Love in B4X Badge at the end of the list
			-Default: False
		-Add Designer Property MadeWithLoveTextColor - Text Color of the Made with Love Badge
			-Default: White
		-Add Designer Property BottomText - a custom text on the end of the list
			-Default: ""
		-Add Designer Property BottomTextTextColor
			-Default: White
	-AS_Properties
		-Add RemoveProperty - Removes a property from the db
		-Add ClearProperties - Clears all properties from the db
V1.02
	-AS_Properties
		-Breaking change - For the intern database i'm now using the KeyValueStore lib.
			-This means that all settings are reset by the update
		-ClearProperties renamed to DeleteAllProperties
		-Add get KeyValueStore
	-AS_Settings
		-BugFixes in Property_SegmentedTab
			-AS_SegmentedTab V1.18+ needed
		-Add AddProperty_Chooser - looks like an AddProperty_Text, but is a label with click event
		-Add Event ChooserTextFieldClicked - Is triggered when you click on an AddProperty_Chooser
		-Add AddProperty_Custom - Is a CustomDrawProperty field, the CustomDrawProperty event is triggered, there you can add your own layout
		-Add Event CustomDrawProperty - You can now add your custom property layout
		-Add CustomDrawProperty_Add - You can add any view with this function and It is automatically added to the layout, you don't have to worry about where to put it
		-Add CustomDrawProperty_AddChooser - A chooser view is created
		-Add CustomDrawProperty_AddText - A simple text item
V1.03
	-AS_Settings
		-Add ResetGroups - Removes the groups, so that you can fill the view with new groups, without the groups that were previously visible
V1.04
	-AS_Settings
		-Description BugFixes
V1.05
	-AS_Settings
		-B4J Focused TextField at start bugfix
		-Add SetProperty_Boolean - Sets the value of a property as if the user had clicked the switch
			-The _ValueChanged event is triggered
		-Add GetProperty - Gets the property object
V2.00
	-AS_Settings
		-Add AddSpaceItem
		-Add AddDescriptionItem
		-Add multi page support
		-Events should be added again, as all type names have changed
V2.01
	-AS_SettingsPage
		-Add AddProperty_SelectionList - You can create single choice or multiple choice options
			-MultiSelect - If true more than one item can selected. If false only one item is selected if you click, it deselect the previous item
			-CanDeselectAll - If false, then the last item cannot be deselected, it need min one selected
	-AS_Settings
		-Add Designer Property SelectionItemSelectionColor - Color of the selection indicator
			-Default: White
		-Add Type AS_Settings_Property_SelectionList
		-Add Type AS_Settings_SelectionListItem
		-Add CreateSelectionListItem - Needed to build the items
V2.02
	-AS_SettingsPage
		-Added seperators to the SelectionList property
		-The ValueChanged event works now with the SelectionList Property
		-The .Refresh function is now smooth
		-BugFixes on the PropertyName height and Description height
V2.03
	-AS_Settings
		-BugFixes and Improvements
		-Add CreateList - Creates an list with just one line of code
		-Add Designer Property PropertyTextColor
		-Add set Theme
		-Add get Theme_Dark
		-Add get Theme_Light
		-Add Designer Property ThemeChangeTransition
			-Default: Fade
V2.04
	-AS_SettingsPage
		-if you now specify your own width for the property AddProperty_Text, you can now use more space
		-BugFixes
V2.05
	-AS_SettingsPage
		-SelectionList is now using more space
		-Add Property Custom
		-Add Event CustomDrawCustomProperty
	-AS_Settings
		-Add Event GroupHeaderClicked
V2.06
	-AS_SettingsPage
		-Add AddProperty_ComboBox2 - The value is displayed in the ComboBox and the key is used for selection and stored in the database
	-AS_Properties
		-Add SetDefaultValue - Defines the default value globally for this property
			-You can call GetProperty and this specified value is taken as the default value
			-No need to call GetPropertyDefault anymore
		-Add GetDefaultValue - Returns the default value that was set with SetDefaultValue
V2.07
	-AS_SettingsPage
		-BugFix on Refresh
V2.08
	-AS_SettingsPage
		-BugFix - The ComboBox display text can now be multiline
V2.09
	-AS_Settings
		-BugFixes for SaveMode_Manual 
		-BugFixes for AddProperty_Custom 
			-The specified height is now used
			-The CustomDrawCustomProperty Event is now triggered
V2.10
	-AS_Settings
		-Add AS_Settings_GroupProperties
			-Removed GroupNameTextColor
V2.11
	-AS_SettingsPage
		-BugFixes and Improvements
		-Add AddProperty_ColorChooser
		-Add Type AS_Settings_ColorItem
		-Add Event DisabledItemClicked
V2.12
	-AS_SettingsPage
		-BugFix - GetProperty now also works if the page has not yet been populated
		-Add get isPagePopulated - Indicates whether the page has already been filled with your properties
V2.13
	-AS_SettingsPage
		-The Boolean property now uses more space for the title and the description
V2.14
	-AS_SettingsPage
		-BugFix - if you have set “set Height” for a page and then made a ".Refresh", then it came to an ugly behavior 
V2.15
	-AS_SettingsPage
		-New 	- AddProperty_Link - Identical to AddProperty_Action only with a different icon
		-New    - PageScrollChanged Event
		-New    - CustomDrawGroup Event
		-Update - The round corners of a group are no longer created with 2 separate items in the list, but directly on the 1st and last item of a group
			-https://www.b4x.com/android/forum/threads/b4x-setpanelcornerradius-only-for-certain-corners.164567/
		-Update - AS_Settings_PropertyViews the LeftBackgroundPanel is renamed to BackgroundPanel
		-BugFix - In the Property SelectionList if SelectionMode Single was set and you used the SaveMode Manual, you could select multiple items
		-BugFix - In the Property Action more space is now released for the description if no value text is displayed
		-BugFix - In the Property ComboBox the complete item can be clicked to open the combobox
V2.16
	-AS_SettingsPage
		-BugFix - Round corner fix for SelectionItems + ColorChooser
V2.17
	-AS_Settings
		-Update AS_Settings_GroupProperties added LeftGap
			-Default: 5dip
		-Update AS_Settings_Property_Properties added NameFont and DescriptionFont
			-NameFont Default: Bold 18
			-DescriptionFont Default: Normal 15
V2.18
	-AS_Settings
		-New AS_Settings_SelectionListItemProperties
			-xFont Default: BoldFont(18)
			-SeperatorVisible Default: True
		-New CustomDrawActionProperty Event - only for Action and Link Property
	-AS_SettingsPage
		-New get ExitIconImageView - B4J only
		-BugFix if the CustomProperty is in a group, the BackgroundPanel now has the correct width
V2.19
	-AS_SettingsPage
		-New get ExitIconBackgroundPanel - B4J only
		-New get PageBackgroundPanel
		-BugFixes
V2.20
	-AS_SettingsPage
		-BugFix on B4A with many TextFields
V2.21
	-AS_SettingsPage
		-BugFixes
#End If

'-BreakingChange - AddProperty_Text has a new parameter "Format"

#DesignerProperty: Key: ThemeChangeTransition, DisplayName: ThemeChangeTransition, FieldType: String, DefaultValue: Fade, List: None|Fade
#DesignerProperty: Key: SaveMode, DisplayName: SaveMode, FieldType: String, DefaultValue: Automatic, List: Automatic|Manual

#DesignerProperty: Key: BackgroundColor, DisplayName: BackgroundColor, FieldType: Color, DefaultValue: 0xFF131416, Description: You can use the built-in color picker to find the color values.

#DesignerProperty: Key: GroupHeight, DisplayName: GroupHeight, FieldType: Int, DefaultValue: 50, MinRange: 0
#DesignerProperty: Key: GroupNameBackgroundColor, DisplayName: GroupNameBackgroundColor, FieldType: Color, DefaultValue: 0xFF131416, Description: You can use the built-in color picker to find the color values.

#DesignerProperty: Key: PropertyColor, DisplayName: PropertyColor, FieldType: Color, DefaultValue: 0xFF202125, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: PropertyTextColor, DisplayName: PropertyTextColor, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: CornerRadius, DisplayName: CornerRadius, FieldType: Int, DefaultValue: 10, MinRange: 0, MaxRange: 50
#DesignerProperty: Key: PropertyHeight, DisplayName: PropertyHeight, FieldType: Int, DefaultValue: 60, MinRange: 0
#DesignerProperty: Key: PropertySeperator, DisplayName: PropertySeperator, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: PropertySeperatorColor, DisplayName: PropertySeperatorColor, FieldType: Color, DefaultValue: 0x28FFFFFF

#DesignerProperty: Key: SwitchThumbColor, DisplayName: SwitchThumbColor, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: SwitchTrueColor, DisplayName: SwitchTrueColor, FieldType: Color, DefaultValue: 0xFF2D8879, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: SwitchFalseColor, DisplayName: SwitchFalseColor, FieldType: Color, DefaultValue: 0xFF3C4043, Description: You can use the built-in color picker to find the color values.

#DesignerProperty: Key: SelectionItemSelectionColor, DisplayName: SelectionItemSelectionColor, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Color of the selection indicator

#IF SETTINGS_SegmentedTab
#DesignerProperty: Key: SegmentedTabBackgroundColor, DisplayName: SegmentedTabBackgroundColor, FieldType: Color, DefaultValue: 0xFF3D3C40, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: SegmentedTabSelectionColor, DisplayName: SegmentedTabSelectionColor, FieldType: Color, DefaultValue: 0xFF737278, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: SegmentedTabTextColor, DisplayName: SegmentedTabTextColor, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: SegmentedTabShowSeperators, DisplayName: SegmentedTabShowSeperators, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: SegmentedTabSeperatorsColor, DisplayName: SegmentedTabSeperatorsColor, FieldType: Color, DefaultValue: 0x50FFFFFF, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: SegmentedTabCornerRadius, DisplayName: SegmentedTabCornerRadius, FieldType: Int, DefaultValue: 5, MinRange: 0
#End If

#If SETTINGS_PlusMinus
#DesignerProperty: Key: PlusMinusBackgroundColor, DisplayName: PlusMinusBackgroundColor, FieldType: Color, DefaultValue: 0xFF3D3C40
#DesignerProperty: Key: PlusMinusTextColor, DisplayName: PlusMinusTextColor, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: PlusMinusHaloColor, DisplayName: PlusMinusHaloColor, FieldType: Color, DefaultValue: 0x50FFFFFF
#DesignerProperty: Key: PlusMinusShowDivider, DisplayName: PlusMinusShowDivider, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: PlusMinusDividerColor, DisplayName: PlusMinusDividerColor, FieldType: Color, DefaultValue: 0x50FFFFFF
#DesignerProperty: Key: PlusMinusCornerRadius, DisplayName: PlusMinusCornerRadius, FieldType: Int, DefaultValue: 10, MinRange: 0
#End If

#DesignerProperty: Key: HapticFeedback, DisplayName: HapticFeedback, FieldType: Boolean, DefaultValue: True

#DesignerProperty: Key: ShowMadeWithLove, DisplayName: ShowMadeWithLove, FieldType: Boolean, DefaultValue: False , Description: Shows the Made with love in B4X Badge on the end of the list
#DesignerProperty: Key: MadeWithLoveTextColor, DisplayName: MadeWithLoveTextColor, FieldType: Color, DefaultValue: 0xFFFFFFFF

#DesignerProperty: Key: BottomText, DisplayName: BottomText, FieldType: String, DefaultValue: , Description: Version 1.0.2
#DesignerProperty: Key: BottomTextTextColor, DisplayName: BottomTextTextColor, FieldType: Color, DefaultValue: 0xFFFFFFFF

#Event: ActionClicked(Property As AS_Settings_Property)
#Event: ChooserTextFieldClicked(Property As AS_Settings_Property)
#Event: CustomDrawActionProperty(ActionProperty AS AS_Settings_CustomDrawActionProperty)
#Event: CustomDrawCustomProperty(CustomProperty AS AS_Settings_CustomDrawCustomProperty)
#Event: CustomDrawProperty(CustomDrawProperty As AS_Settings_CustomDrawProperty)
#Event: CustomDrawGroup(CustomDrawGroup As AS_Settings_CustomDrawGroup)
#Event: DisabledItemClicked(Property As AS_Settings_Property, Value As Object)
#Event: GroupHeaderClicked(Group As AS_Settings_Group)
#Event: PageScrollChanged(Offset As Int, Page As AS_SettingsPage)
#Event: ValueChanged(Property As AS_Settings_Property, Value As Object)

Sub Class_Globals
	
	'Property Types
	Type AS_Settings_Property_Boolean(Property As AS_Settings_Property)
	Type AS_Settings_Property_Action(Property As AS_Settings_Property)
	Type AS_Settings_Property_Link(Property As AS_Settings_Property)
	Type AS_Settings_Property_ActionClean(Property As AS_Settings_Property)
	Type AS_Settings_Property_Text(Property As AS_Settings_Property,Width As Float,InputType As String)
	Type AS_Settings_Property_ComboBox(Property As AS_Settings_Property,ItemList As List,KeyValue As B4XOrderedMap)
	Type AS_Settings_Property_Chooser(Property As AS_Settings_Property,Width As Float)
	Type AS_Settings_Property_Custom(Property As AS_Settings_Property,Height As Float)
	Type AS_Settings_Property_SelectionList(Property As AS_Settings_Property,ListItems As List,MultiSelect As Boolean,CanDeselectAll As Boolean)
	Type AS_Settings_Property_ColorChooser(Property As AS_Settings_Property,ColorList As List,WidthHeight As Float)
	
	Type AS_Settings_SelectionListItem(DisplayName As String,Icon As B4XBitmap,Value As Object)
	Type AS_Settings_SelectionListItemProperties(xFont As B4XFont,SeperatorsVisible As Boolean)
	
	Type AS_Settings_SpaceItem(GroupKey As String,Height As Float)
	Type AS_Settings_DescriptionItem(GroupKey As String,Text As String,SidePadding As Float,TopPadding As Float,xFont As B4XFont,HorizontalAlignment As String)
	
	'Normal Types
	Type AS_Settings_Group(Key As String,Name As String,Properties As List)
	Type AS_Settings_Property(PropertyName As String,DisplayName As String,Description As String,Icon As B4XBitmap,PropertyType As Object,isLast As Boolean,isFirst As Boolean,Group As AS_Settings_Group,Value As Object,DefaultValue As Object,DisplayValueText As String,View As Object)
	Type AS_Settings_CustomDrawProperty(Group As AS_Settings_Group,Property As AS_Settings_Property,PropertyViews As AS_Settings_PropertyViews,PropertySettingViews As AS_Settings_PropertySettingViews)
	Type AS_Settings_CustomDrawGroup(Group As AS_Settings_Group,GroupViews As AS_Settings_GroupViews)
	Type AS_Settings_CustomDrawActionProperty(Group As AS_Settings_Group,Property As AS_Settings_Property,Height As Float,RootBackgroundPanel As B4XView,PropertyBackgroundPanel As B4XView,IconImageView As B4XView,PropertyNameLabel As B4XView,PropertyDescriptionLabel As B4XView,ActionClickPanel As B4XView,ActionIconLabel As B4XView,ActionValueLabel As B4XView)
	Type AS_Settings_CustomDrawCustomProperty(Group As AS_Settings_Group,Property As AS_Settings_Property,BackgroundPanel As B4XView,Height As Float)
	Type AS_Settings_GroupViews(BackgroundPanel As B4XView,NameLabel As B4XView)
	Type AS_Settings_PropertyViews(RootBackgroundPanel As B4XView,BackgroundPanel As B4XView,RightBackgroundPanel As B4XView,IconImageView As B4XView,NameLabel As B4XView,DescriptionLabel As B4XView)
	Type AS_Settings_PropertySettingViews(BackgroundPanel As B4XView,ActionButtonArrowLabel As B4XView,ActionValueLabel As B4XView)
	Type AS_Settings_SwitchProperties(FalseColor As Int,TrueColor As Int,ThumbColor As Int)
	Type AS_Settings_BottomTextProperty(xFont As B4XFont,TextColor As Int)
	Type AS_Settings_ColorItem(Color As Int,Enabled As Boolean)
	
	Type AS_Settings_Property_Properties(Width As Float,Height As Float,xFont As B4XFont,TextColor As Int,BackgroundColor As Int,DescriptionTextColor As Int,FieldBackgroundColor As Int,FieldHeight As Float,InputType As String,Format As String,CornerRadius As Float,NameFont As B4XFont,DescriptionFont As B4XFont)
	Type AS_Settings_GroupProperties(xFont As B4XFont,TextColor As Int,HorizontalTextAlignment As String,LeftGap As Float)
	#IF SETTINGS_SegmentedTab
	Type AS_Settings_Property_SegmentedTab(Property As AS_Settings_Property,Width As Float,CornerRadius As Float,ShowSeperators As Boolean,BackgroundColor As Int,SelectionColor As Int,SeperatorColor As Int,TextColor As Int,xFont As B4XFont,ItemMap As Map)
	#End If
	#If SETTINGS_PlusMinus
	Type AS_Settings_Property_PlusMinus(Property As AS_Settings_Property,CornerRadius As Float,ShowDivider As Boolean,BackgroundColor As Int,DividerColor As Int,HaloColor As Int,TextColor As Int,xFont As B4XFont,ShowHaloEffect As Boolean,MinValue As Int,MaxValue As Int,Increment As Int,Prefix As String,Suffix As String,PropertyProperties As AS_Settings_Property_Properties)
	#End If
		
	Private g_GroupProperties As AS_Settings_GroupProperties
	Private g_PropertyProperties As AS_Settings_Property_Properties
	Private g_BottomTextProperties As AS_Settings_BottomTextProperty
	Private g_SwitchProperties As AS_Settings_SwitchProperties
	Private g_SelectionListItemProperties As AS_Settings_SelectionListItemProperties
	#IF SETTINGS_SegmentedTab
	Private g_SegmentedTabProperties As AS_Settings_Property_SegmentedTab
	#End IF
	#If SETTINGS_PlusMinus
	Private g_PlusMinusProperties As AS_Settings_Property_PlusMinus
	#End If
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xpnl_Pages As B4XView
	Private xiv_RefreshImage As B4XView
	
	Private m_BackgroundColor As Int
	Private m_Padding As Float = 10dip
	Private m_PropertySeperator As Boolean
	Private m_PropertySeperatorColor As Int
	Private m_CornerRadius As Int
	Private m_GroupHeight As Float
	Private m_GroupNameBackgroundColor As Int
	Private m_ArrowColor As Int
	Private m_DragIndicatorColor As Int
	Private m_SecondPageShadowColor As Int
	Private m_SecondPageHeaderTextColor As Int
	Private m_ExitIconColor As Int
	Private m_HapticFeedback As Boolean
	Private m_SaveMode As String
	Private m_ShowMadeWithLove As Boolean
	Private m_MadeWithLoveTextColor As Int
	Private m_HeaderHeight As Float = 65dip
	Private m_SelectionItemSelectionColor As Int
	Private m_ThemeChangeTransition As String
	Private lst_Pages As List
	Private lst_CreatedPages As List
	
	Private m_MainPage As AS_SettingsPage

	Type AS_Settings_Theme(PlusMinus_TextColor As Int,PlusMinus_HaloColor As Int,PlusMius_DividerColor As Int,PlusMinus_BackgroundColor As Int,SegmentedTab_TextColor As Int,SegmentedTab_SeperatorColor As Int,SegmentedTab_SelectionColor As Int,SegmentedTab_BackgroundColor As Int,ExitIconColor As Int,SecondPageHeaderTextColor As Int,SecondPageShadowColor As Int,DragIndicatorColor As Int,ArrowColor As Int,BackgroundColor As Int,GroupNameBackgroundColor As Int,GroupNameTextColor As Int,PropertyColor As Int,PropertyTextColor As Int,DescriptionTextColor As Int,FieldBackgroundColor As Int,PropertySeperatorColor As Int,SwitchThumbColor As Int,SwitchTrueColor As Int,SwitchFalseColor As Int,SelectionItemSelectionColor As Int,SegmentedTabBackgroundColor As Int,SegmentedTabSelectionColor As Int,SegmentedTabTextColor As Int,SegmentedTabSeperatorsColor As Int,PlusMinusBackgroundColor As Int,PlusMinusTextColor As Int,PlusMinusHaloColor As Int,PlusMinusDividerColor As Int,MadeWithLoveTextColor As Int,BottomTextTextColor As Int)

End Sub



Public Sub getTheme_Light As AS_Settings_Theme
	
	Dim Theme As AS_Settings_Theme
	Theme.Initialize
	
	Theme.BackgroundColor = xui.Color_White
	Theme.PropertySeperatorColor = 0x28000000
	Theme.GroupNameBackgroundColor = xui.Color_White
	Theme.GroupNameTextColor = xui.Color_Black
	Theme.MadeWithLoveTextColor = xui.Color_Black
	Theme.SelectionItemSelectionColor = xui.Color_Black
	Theme.PropertyColor = xui.Color_ARGB(255,235, 235, 235)
	Theme.PropertyTextColor = xui.Color_Black
	Theme.DescriptionTextColor = xui.Color_ARGB(152,0,0,0)
	Theme.FieldBackgroundColor = xui.Color_ARGB(255,212, 212, 212)
	Theme.ArrowColor = xui.Color_ARGB(152,0,0,0)
	Theme.DragIndicatorColor = xui.Color_ARGB(152,0,0,0)
	Theme.SecondPageShadowColor = xui.Color_ARGB(152,0,0,0)
	Theme.SecondPageHeaderTextColor = xui.Color_ARGB(152,0,0,0)
	Theme.ExitIconColor = xui.Color_ARGB(80,0,0,0)
	
	#IF SETTINGS_SegmentedTab
	Theme.SegmentedTab_BackgroundColor = xui.Color_ARGB(255,61, 60, 64)
	Theme.SegmentedTab_SelectionColor = xui.Color_ARGB(255,115, 114, 120)
	Theme.SegmentedTab_SeperatorColor = xui.Color_ARGB(80,0,0,0)
	Theme.SegmentedTab_TextColor = xui.Color_Black
	#End If
	
	#If SETTINGS_PlusMinus
	Theme.PlusMinus_BackgroundColor = xui.Color_ARGB(255,60, 64, 67)
	Theme.PlusMius_DividerColor = xui.Color_ARGB(80,255,255,255)
	Theme.PlusMinus_HaloColor = xui.Color_ARGB(80,0,0,0)
	Theme.PlusMinus_TextColor = xui.Color_White
	#End If
	
	Theme.BottomTextTextColor = xui.Color_Black
	Theme.SwitchFalseColor = 0xFF3C4043
	Theme.SwitchTrueColor = 0xFF2D8879
	Theme.SwitchThumbColor = xui.Color_White
	
	Return Theme
	
End Sub

Public Sub getTheme_Dark As AS_Settings_Theme
	
	Dim Theme As AS_Settings_Theme
	Theme.Initialize
	
	Theme.BackgroundColor = 0xFF131416
	Theme.PropertySeperatorColor = 0x28FFFFFF
	Theme.GroupNameBackgroundColor = 0xFF131416
	Theme.GroupNameTextColor = xui.Color_White
	Theme.MadeWithLoveTextColor = xui.Color_White
	Theme.SelectionItemSelectionColor = xui.Color_White
	Theme.PropertyColor = 0xFF202125
	Theme.PropertyTextColor = xui.Color_White
	Theme.DescriptionTextColor = xui.Color_ARGB(152,255,255,255)
	Theme.FieldBackgroundColor = xui.Color_ARGB(255,60, 64, 67)
	Theme.ArrowColor = xui.Color_ARGB(152,255,255,255)
	Theme.DragIndicatorColor = xui.Color_ARGB(152,255,255,255)
	Theme.SecondPageShadowColor = xui.Color_ARGB(200,0,0,0)
	Theme.SecondPageHeaderTextColor = xui.Color_ARGB(152,255,255,255)
	Theme.ExitIconColor = xui.Color_ARGB(80,255,255,255)
	
	#IF SETTINGS_SegmentedTab
	Theme.SegmentedTab_BackgroundColor = xui.Color_ARGB(255,61, 60, 64)
	Theme.SegmentedTab_SelectionColor = xui.Color_ARGB(255,115, 114, 120)
	Theme.SegmentedTab_SeperatorColor = xui.Color_ARGB(80,255,255,255)
	Theme.SegmentedTab_TextColor = xui.Color_White
	#End If
	
	#If SETTINGS_PlusMinus
	Theme.PlusMinus_BackgroundColor = xui.Color_ARGB(255,60, 64, 67)
	Theme.PlusMius_DividerColor = xui.Color_ARGB(80,255,255,255)
	Theme.PlusMinus_HaloColor =  xui.Color_ARGB(80,255,255,255)
	Theme.PlusMinus_TextColor = xui.Color_White
	#End If
	
	Theme.BottomTextTextColor = 0xFFFFFFFF
	Theme.SwitchFalseColor = 0xFF3C4043
	Theme.SwitchTrueColor = 0xFF2D8879
	Theme.SwitchThumbColor = 0xFFFFFFFF
	
	Return Theme
	
End Sub

Public Sub setTheme(Theme As AS_Settings_Theme)
	
	xiv_RefreshImage.SetBitmap(mBase.Snapshot)
	xiv_RefreshImage.SetVisibleAnimated(0,True)
	
	m_BackgroundColor = Theme.BackgroundColor
	m_PropertySeperatorColor = Theme.PropertySeperatorColor
	m_GroupNameBackgroundColor = Theme.GroupNameBackgroundColor
	g_GroupProperties.TextColor = Theme.GroupNameTextColor
	m_MadeWithLoveTextColor = Theme.MadeWithLoveTextColor
	m_SelectionItemSelectionColor = Theme.SelectionItemSelectionColor
	g_PropertyProperties.BackgroundColor = Theme.PropertyColor
	g_PropertyProperties.TextColor = Theme.PropertyTextColor
	g_PropertyProperties.FieldBackgroundColor = Theme.FieldBackgroundColor
	g_PropertyProperties.DescriptionTextColor = Theme.DescriptionTextColor
	m_ArrowColor = Theme.ArrowColor
	m_DragIndicatorColor = Theme.DragIndicatorColor
	m_SecondPageShadowColor = Theme.SecondPageShadowColor
	m_SecondPageHeaderTextColor = Theme.SecondPageHeaderTextColor
	m_ExitIconColor = Theme.ExitIconColor
	
	#IF SETTINGS_SegmentedTab
	g_SegmentedTabProperties.BackgroundColor = Theme.SegmentedTab_BackgroundColor
	g_SegmentedTabProperties.TextColor = Theme.SegmentedTab_TextColor
	g_SegmentedTabProperties.SelectionColor = Theme.SegmentedTab_SelectionColor
	g_SegmentedTabProperties.SeperatorColor = Theme.SegmentedTab_SeperatorColor
	#End If
	
	#If SETTINGS_PlusMinus
	g_PlusMinusProperties.BackgroundColor = Theme.PlusMinus_BackgroundColor
	g_PlusMinusProperties.TextColor = Theme.PlusMinus_TextColor
	g_PlusMinusProperties.DividerColor = Theme.PlusMius_DividerColor
	g_PlusMinusProperties.HaloColor = Theme.PlusMinus_HaloColor
	#End If
	
	g_BottomTextProperties.TextColor = Theme.BottomTextTextColor
	g_SwitchProperties.FalseColor = Theme.SwitchFalseColor
	g_SwitchProperties.TrueColor = Theme.SwitchTrueColor
	g_SwitchProperties.ThumbColor = Theme.SwitchThumbColor
	
	Sleep(0)
	
	For Each Page As AS_SettingsPage In lst_CreatedPages
		Page.Refresh
	Next
	
	Sleep(250)
	
	Select m_ThemeChangeTransition
		Case "None"
			xiv_RefreshImage.SetVisibleAnimated(0,False)
		Case "Fade"
			xiv_RefreshImage.SetVisibleAnimated(250,False)
	End Select
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	lst_Pages.Initialize
	lst_CreatedPages.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
	mBase.Tag = Me

	AS_Properties.Initialize
	xpnl_Pages = xui.CreatePanel("")
	mBase.AddView(xpnl_Pages,0,0,mBase.Width,mBase.Height)

	m_MainPage.Initialize(Me,"")
	lst_Pages.Add(m_MainPage)
	lst_CreatedPages.Add(m_MainPage)

	IniProps(Props)
	
	xiv_RefreshImage = CreateImageView("")
	xiv_RefreshImage.Visible = False
	mBase.AddView(xiv_RefreshImage,0,0,mBase.Width,mBase.Height)
	
	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If
	
End Sub

Public Sub getMainPage As AS_SettingsPage
	Return m_MainPage
End Sub

Public Sub getPages As B4XView
	Return xpnl_Pages
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	xiv_RefreshImage.SetLayoutAnimated(0,0,0,Width,Height)
	mBase.Color = m_BackgroundColor
  
  	xpnl_Pages.Width = Width
	xpnl_Pages.Height = Height
  
	For i = 0 To lst_Pages.Size -1		
		lst_Pages.Get(i).As(AS_SettingsPage).Base_Resize(Width,Height)		
	Next
  
	'xclv_main.AsView.SetLayoutAnimated(0,xclv_main.AsView.Left,xclv_main.AsView.Top,Width,Height)
	'xclv_main.Base_Resize(Width,Height)
  
End Sub

Private Sub IniProps(Props As Map)
	
	m_BackgroundColor = xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
	m_PropertySeperator = Props.Get("PropertySeperator")
	m_PropertySeperatorColor = xui.PaintOrColorToColor(Props.Get("PropertySeperatorColor"))
	m_CornerRadius = Props.Get("CornerRadius")
	m_GroupNameBackgroundColor = xui.PaintOrColorToColor(Props.Get("GroupNameBackgroundColor"))
	m_GroupHeight = DipToCurrent(Props.Get("GroupHeight"))
	m_HapticFeedback = Props.Get("HapticFeedback")
	m_SaveMode = Props.GetDefault("SaveMode","Automatic")
	m_ShowMadeWithLove = Props.GetDefault("ShowMadeWithLove",False)
	m_MadeWithLoveTextColor = xui.PaintOrColorToColor(Props.GetDefault("MadeWithLoveTextColor",0xFFFFFFFF))
	m_MainPage.BottomText = Props.GetDefault("BottomText","")
	m_SelectionItemSelectionColor = xui.PaintOrColorToColor(Props.GetDefault("SelectionItemSelectionColor",0xFFFFFFFF))
	m_ArrowColor = xui.Color_ARGB(152,255,255,255)
	m_SecondPageShadowColor = xui.Color_ARGB(200,0,0,0)
	m_SecondPageHeaderTextColor = xui.Color_White
	m_ExitIconColor = xui.Color_ARGB(80,255,255,255)
	m_ThemeChangeTransition = Props.GetDefault("ThemeChangeTransition","Fade")
	
	g_PropertyProperties = CreateProperties(mBase.Width/4,DipToCurrent(Props.Get("PropertyHeight")),xui.CreateDefaultFont(18),xui.PaintOrColorToColor(Props.GetDefault("PropertyTextColor",0xFFFFFFFF)),xui.PaintOrColorToColor(Props.Get("PropertyColor")),xui.Color_ARGB(152,255,255,255),xui.Color_ARGB(255,60, 64, 67),DipToCurrent(Props.Get("PropertyHeight"))/2,getInputType_Text,"",5dip)
	g_PropertyProperties.NameFont = xui.CreateDefaultBoldFont(18)
	g_PropertyProperties.DescriptionFont = xui.CreateDefaultFont(15)
	
	g_GroupProperties = CreateAS_Settings_GroupProperties(xui.CreateDefaultBoldFont(20),xui.Color_White,"LEFT")
	g_GroupProperties.LeftGap = 5dip
	
	#IF SETTINGS_SegmentedTab
	g_SegmentedTabProperties = CreateAS_Settings_SegmentedTabProperties(0,DipToCurrent(Props.GetDefault("SegmentedTabCornerRadius",5dip)),Props.GetDefault("SegmentedTabShowSeperators",False),xui.PaintOrColorToColor(Props.GetDefault("SegmentedTabBackgroundColor",0xFF3D3C40)),xui.PaintOrColorToColor(Props.GetDefault("SegmentedTabSelectionColor",0xFF737278)),xui.PaintOrColorToColor(Props.GetDefault("SegmentedTabSeperatorsColor",0x50FFFFFF)),xui.PaintOrColorToColor(Props.GetDefault("SegmentedTabTextColor",0xFFFFFFFF)),xui.CreateDefaultBoldFont(15))
	#End If
	#If SETTINGS_PlusMinus
	g_PlusMinusProperties = CreateAS_Settings_Property_PlusMinus(Props.GetDefault("PlusMinusCornerRadius",5dip),Props.GetDefault("PlusMinusShowDivider",True),xui.PaintOrColorToColor(Props.GetDefault("PlusMinusBackgroundColor",0xFF3D3C40)),xui.PaintOrColorToColor(Props.GetDefault("PlusMinusDividerColor",0x50FFFFFF)),xui.PaintOrColorToColor(Props.GetDefault("PlusMinusHaloColor",0x50FFFFFF)),xui.PaintOrColorToColor(Props.GetDefault("PlusMinusTextColor",0xFFFFFFFF)),xui.CreateDefaultFont(20),True)
	#End If
	
	g_BottomTextProperties = CreateAS_Settings_BottomTextProperty(xui.CreateDefaultFont(15),xui.PaintOrColorToColor(Props.GetDefault("BottomTextTextColor",0xFFFFFFFF)))
	g_SwitchProperties = CreateAS_Settings_SwitchProperties(xui.PaintOrColorToColor(Props.Get("SwitchFalseColor")),xui.PaintOrColorToColor(Props.Get("SwitchTrueColor")),xui.PaintOrColorToColor(Props.Get("SwitchThumbColor")))

	g_SelectionListItemProperties.Initialize
	g_SelectionListItemProperties.xFont = xui.CreateDefaultBoldFont(18)
	g_SelectionListItemProperties.SeperatorsVisible = True

End Sub

#Region Properties

Public Sub getSelectionListItemProperties As AS_Settings_SelectionListItemProperties
	Return g_SelectionListItemProperties
End Sub

Public Sub setExitIconColor(Color As Int)
	m_ExitIconColor = Color
End Sub

Public Sub getExitIconColor As Int
	Return m_ExitIconColor
End Sub

Public Sub getSecondPageHeaderTextColor As Int
	Return m_SecondPageHeaderTextColor
End Sub

Public Sub setSecondPageHeaderTextColor(Color As Int)
	m_SecondPageHeaderTextColor = Color
End Sub

Public Sub getSecondPageShadowColor As Int
	Return m_SecondPageShadowColor
End Sub

Public Sub setSecondPageShadowColor(Color As Int)
	m_SecondPageShadowColor = Color
End Sub

Public Sub setDragIndicatorColor(Color As Int)
	m_DragIndicatorColor = Color
End Sub

Public Sub getDragIndicatorColor As Int
	Return m_DragIndicatorColor
End Sub

Public Sub setSelectionItemSelectionColor(Color As Int)
	m_SelectionItemSelectionColor = Color
End Sub

Public Sub getSelectionItemSelectionColor As Int
	Return m_SelectionItemSelectionColor
End Sub

Public Sub getHeaderHeight As Float
	Return m_HeaderHeight
End Sub

Public Sub GetTopPage As AS_SettingsPage
	Return lst_Pages.Get(lst_Pages.Size -1)
End Sub

Public Sub GetVisiblePages As List
	Return lst_Pages
End Sub

Public Sub GetCreatedPages As List
	Return lst_CreatedPages
End Sub

Public Sub setMadeWithLoveTextColor(Color As Int)
	m_MadeWithLoveTextColor = Color
End Sub

Public Sub getMadeWithLoveTextColor As Int
	Return m_MadeWithLoveTextColor
End Sub

Public Sub setShowMadeWithLove(Show As Boolean)
	m_ShowMadeWithLove = Show
End Sub

Public Sub getShowMadeWithLove As Boolean
	Return m_ShowMadeWithLove
End Sub

Public Sub getBottomTextProperties As AS_Settings_BottomTextProperty
	Return g_BottomTextProperties
End Sub

Public Sub getPropertyProperties As AS_Settings_Property_Properties
	Return g_PropertyProperties
End Sub

'HorizontalTextAlignment - LEFT, CENTER, RIGHT
Public Sub getGroupProperties As AS_Settings_GroupProperties
	Return g_GroupProperties
End Sub

#If SETTINGS_SegmentedTab
Public Sub getSegmentedTabProperties As AS_Settings_Property_SegmentedTab
	Return g_SegmentedTabProperties
End Sub
#End If

#If SETTINGS_PlusMinus
Public Sub getPlusMinusProperties As AS_Settings_Property_PlusMinus
	Return g_PlusMinusProperties
End Sub
#End If

'Haptic feedback of the switches and click actions
Public Sub setHapticFeedback(Enabled As Boolean)
	m_HapticFeedback = Enabled
End Sub

Public Sub getHapticFeedback As Boolean
	Return m_HapticFeedback
End Sub
'The Background Color of the group name
Public Sub setGroupNameBackgroundColor(Color As Int)
	m_GroupNameBackgroundColor = Color
End Sub

Public Sub getGroupNameBackgroundColor As Int
	Return m_GroupNameBackgroundColor
End Sub

Public Sub getArrowColor As Int
	Return m_ArrowColor
End Sub

Public Sub setArrowColor(Color As Int)
	m_ArrowColor = Color
End Sub

'Height of a group name
Public Sub setGroupHeight(Height As Float)
	m_GroupHeight= Height
End Sub

Public Sub getGroupHeight As Float
	Return m_GroupHeight
End Sub
'The corner radius of a group
Public Sub setCornerRadius(Radius As Int)
	m_CornerRadius = Radius
End Sub

Public Sub getCornerRadius As Int
	Return m_CornerRadius
End Sub
'Color of the seperator
Public Sub setPropertySeperatorColor(Color As Int)
	m_PropertySeperatorColor = Color
End Sub

Public Sub getPropertySeperatorColor As Int
	Return m_PropertySeperatorColor
End Sub
'If true a seperator is shown under a property
Public Sub setPropertySeperator(Show As Boolean)
	m_PropertySeperator = Show
End Sub

Public Sub getPropertySeperator As Boolean
	Return m_PropertySeperator
End Sub

Public Sub getSwitchProperties As AS_Settings_SwitchProperties
	Return g_SwitchProperties
End Sub
'The Padding Left and Right
'Default value: 10dip
Public Sub setPadding(Padding As Float)
	m_Padding = Padding
End Sub

Public Sub getPadding As Float
	Return m_Padding
End Sub

'Background Color of the view
Public Sub setBackgroundColor(Color As Int)
	m_BackgroundColor = Color
End Sub

Public Sub getBackgroundColor As Int
	Return m_BackgroundColor
End Sub

'<code>AS_Settings1.SaveMode = AS_Settings1.SaveMode_Automatic</code>
Public Sub getSaveMode As String
	Return m_SaveMode
End Sub

Public Sub setSaveMode(Mode As String)
	m_SaveMode = Mode
End Sub

#End Region

#Region Enums

'**************************************************************

Public Sub getInputType_Text As String
	Return "Text"
End Sub

Public Sub getInputType_Numeric As String
	Return "Numeric"
End Sub

Public Sub getInputType_Decimal As String
	Return "Decimal"
End Sub

'Public Sub getInputType_IPv4 As String
'	Return "IPv4"
'End Sub
'
'Public Sub getInputType_IPv6 As String
'	Return "IPv6"
'End Sub

'*************************************************************

Public Sub getSaveMode_Automatic As String
	Return "Automatic"
End Sub

Public Sub getSaveMode_Manual As String
	Return "Manual"
End Sub

#End Region

#Region Events

Private Sub GroupHeaderClicked(Group As AS_Settings_Group)
	If xui.SubExists(mCallBack, mEventName & "_GroupHeaderClicked",1) Then
		CallSub2(mCallBack, mEventName & "_GroupHeaderClicked",Group)
	End If
End Sub

Private Sub PageScrollChanged(Offset As Int,Page As AS_SettingsPage)
	If xui.SubExists(mCallBack, mEventName & "_PageScrollChanged",2) Then
		CallSub3(mCallBack, mEventName & "_PageScrollChanged",Offset,Page)
	End If
End Sub

Private Sub ValueChanged(Property As AS_Settings_Property, Value As Object)
	If xui.SubExists(mCallBack, mEventName & "_ValueChanged",2) Then
		CallSub3(mCallBack, mEventName & "_ValueChanged",Property,Value)
	End If
End Sub

Private Sub ActionClicked(Property As AS_Settings_Property)
	If xui.SubExists(mCallBack, mEventName & "_ActionClicked",1) Then
		CallSub2(mCallBack, mEventName & "_ActionClicked",Property)
	End If
End Sub

Private Sub ChooserTextFieldClicked(Property As AS_Settings_Property)
	If xui.SubExists(mCallBack, mEventName & "_ChooserTextFieldClicked",1) Then
		CallSub2(mCallBack, mEventName & "_ChooserTextFieldClicked",Property)
	End If
End Sub

Private Sub CustomDrawProperty(Property As AS_Settings_CustomDrawProperty)
	If xui.SubExists(mCallBack, mEventName & "_CustomDrawProperty",1) Then
		CallSub2(mCallBack, mEventName & "_CustomDrawProperty",Property)
	End If
End Sub

Private Sub CustomDrawGroup(Group As AS_Settings_CustomDrawGroup)
	If xui.SubExists(mCallBack, mEventName & "_CustomDrawGroup",1) Then
		CallSub2(mCallBack, mEventName & "_CustomDrawGroup",Group)
	End If
End Sub

Private Sub CustomDrawCustomProperty(Property As AS_Settings_CustomDrawCustomProperty)
	If xui.SubExists(mCallBack, mEventName & "_CustomDrawCustomProperty",1) Then
		CallSub2(mCallBack, mEventName & "_CustomDrawCustomProperty",Property)
	End If
End Sub

Private Sub CustomDrawActionProperty(Property As AS_Settings_CustomDrawActionProperty)
	If xui.SubExists(mCallBack, mEventName & "_CustomDrawActionProperty",1) Then
		CallSub2(mCallBack, mEventName & "_CustomDrawActionProperty",Property)
	End If
End Sub

Private Sub DisabledItemClicked(Property As AS_Settings_Property, Value As Object)
	If xui.SubExists(mCallBack, mEventName & "_DisabledItemClicked",2) Then
		CallSub3(mCallBack, mEventName & "_DisabledItemClicked",Property,Value)
	Else
		LogColor("AS_Settings: The clicked item is disabled, please use the DisabledItemClicked Event to handle it",xui.Color_Red)
	End If
End Sub


#End Region

#Region InternFunctions

'https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250
Public Sub FontToBitmap (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
	Dim xui As XUI
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)
	Dim cvs1 As B4XCanvas
	cvs1.Initialize(p)
	Dim fnt As B4XFont
	If IsMaterialIcons Then fnt = xui.CreateMaterialIcons(FontSize) Else fnt = xui.CreateFontAwesome(FontSize)
	Dim r As B4XRect = cvs1.MeasureText(text, fnt)
	Dim BaseLine As Int = cvs1.TargetRect.CenterY - r.Height / 2 - r.Top
	cvs1.DrawText(text, cvs1.TargetRect.CenterX, BaseLine, fnt, color, "CENTER")
	Dim b As B4XBitmap = cvs1.CreateBitmap
	cvs1.Release
	Return b
End Sub

'<code>AS_Settings1.CreateList(Array("",""))</code>
Public Sub CreateList(VarPar() As Object) As List
	Dim L As List
	L.Initialize
	For Each O As Object In VarPar
		L.Add(O)
	Next
	Return L
End Sub

Private Sub CreateImageView(EventName As String) As B4XView
	Dim iv As ImageView
	iv.Initialize(EventName)
	Return iv
End Sub

#End Region

#Region Types

#If SETTINGS_SegmentedTab
Public Sub CreateAS_Settings_SegmentedTabProperties (Width As Float, CornerRadius As Float, ShowSeperators As Boolean, BackgroundColor As Int, SelectionColor As Int, SeperatorColor As Int, TextColor As Int, xFont As B4XFont) As AS_Settings_Property_SegmentedTab
	Dim t1 As AS_Settings_Property_SegmentedTab
	t1.Initialize
	t1.Width = Width
	t1.CornerRadius = CornerRadius
	t1.ShowSeperators = ShowSeperators
	t1.BackgroundColor = BackgroundColor
	t1.SelectionColor = SelectionColor
	t1.SeperatorColor = SeperatorColor
	t1.TextColor = TextColor
	t1.xFont = xFont
	Return t1
End Sub
#End If

#If SETTINGS_PlusMinus
Private Sub CreateAS_Settings_Property_PlusMinus (CornerRadius As Float, ShowDivider As Boolean, BackgroundColor As Int, DividerColor As Int, HaloColor As Int, TextColor As Int, xFont As B4XFont, ShowHaloEffect As Boolean) As AS_Settings_Property_PlusMinus
	Dim t1 As AS_Settings_Property_PlusMinus
	t1.Initialize
	t1.CornerRadius = CornerRadius
	t1.ShowDivider = ShowDivider
	t1.BackgroundColor = BackgroundColor
	t1.DividerColor = DividerColor
	t1.HaloColor = HaloColor
	t1.TextColor = TextColor
	t1.xFont = xFont
	t1.ShowHaloEffect = ShowHaloEffect
	Return t1
End Sub
#End If

Private Sub CreateAS_Settings_BottomTextProperty (xFont As B4XFont, TextColor As Int) As AS_Settings_BottomTextProperty
	Dim t1 As AS_Settings_BottomTextProperty
	t1.Initialize
	t1.xFont = xFont
	t1.TextColor = TextColor
	Return t1
End Sub

Private Sub CreateAS_Settings_SwitchProperties (FalseColor As Int, TrueColor As Int, ThumbColor As Int) As AS_Settings_SwitchProperties
	Dim t1 As AS_Settings_SwitchProperties
	t1.Initialize
	t1.FalseColor = FalseColor
	t1.TrueColor = TrueColor
	t1.ThumbColor = ThumbColor
	Return t1
End Sub

#End Region


Public Sub CreateSelectionListItem (DisplayName As String, Icon As B4XBitmap,Value As Object) As AS_Settings_SelectionListItem
	Dim t1 As AS_Settings_SelectionListItem
	t1.Initialize
	t1.DisplayName = DisplayName
	t1.Icon = Icon
	t1.Value = Value
	Return t1
End Sub

Public Sub CreateProperties (Width As Float, Height As Float, xFont As B4XFont, TextColor As Int, BackgroundColor As Int, DescriptionTextColor As Int, FieldBackgroundColor As Int, FieldHeight As Float, InputType As String, Format As String, CornerRadius As Float) As AS_Settings_Property_Properties
	Dim t1 As AS_Settings_Property_Properties
	t1.Initialize
	t1.Width = Width
	t1.Height = Height
	t1.xFont = xFont
	t1.TextColor = TextColor
	t1.BackgroundColor = BackgroundColor
	t1.DescriptionTextColor = DescriptionTextColor
	t1.FieldBackgroundColor = FieldBackgroundColor
	t1.FieldHeight = FieldHeight
	t1.InputType = InputType
	t1.Format = Format
	t1.CornerRadius = CornerRadius
	Return t1
End Sub

Private Sub CreateAS_Settings_GroupProperties (xFont As B4XFont, TextColor As Int, HorizontalTextAlignment As String) As AS_Settings_GroupProperties
	Dim t1 As AS_Settings_GroupProperties
	t1.Initialize
	t1.xFont = xFont
	t1.TextColor = TextColor
	t1.HorizontalTextAlignment = HorizontalTextAlignment
	Return t1
End Sub


Public Sub CreateColorItem (Color As Int, Enabled As Boolean) As AS_Settings_ColorItem
	Dim t1 As AS_Settings_ColorItem
	t1.Initialize
	t1.Color = Color
	t1.Enabled = Enabled
	Return t1
End Sub