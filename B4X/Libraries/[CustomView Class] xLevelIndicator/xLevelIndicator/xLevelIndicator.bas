B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
'Custom View Class: xLevelIndicator
'Display a simple level indicator with top text indicating the level + horizontal bar with height depending level + bottom text with text or fontawesome symbol.
'Hints:
'Set the anchors for the xLevelIndicator to both horz & vert to ensure resizing is handled.
'If the pane is getting rather small, only the label Level is shown.
'Tested with B4A v11.0 and B4J v9.30.
'20211109 rwbl

'Events
'Handle value changes
'Example:
'Private Sub LevelIndicator1_ValueChanged(value As Int)
'	Log($"LevelIndicator1_ValueChanged: ${value}"$)
'End Sub
#Event: ValueChanged(Value As Int)

'Properties
#DesignerProperty: Key: Level, DisplayName: Level, FieldType: Int, DefaultValue: 10, MinRange: 0, MaxRange: 100, Description: Indicator level. Note that MinRange and MaxRange are optional
#DesignerProperty: Key: LevelMin, DisplayName: Min Level, FieldType: Int, DefaultValue: 0, Description: Minimum level
#DesignerProperty: Key: LevelMax, DisplayName: Max Level, FieldType: Int, DefaultValue: 100, Description: Maximum level. Ensure to align with the max level
#DesignerProperty: Key: BorderWidth, DisplayName: Border Width, FieldType: Int, DefaultValue: 0, MinRange: 0, MaxRange: 14, Description: Indicator border width
#DesignerProperty: Key: BorderColor, DisplayName: Border Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Indicator border color
#DesignerProperty: Key: BarColor, DisplayName: Bar Color, FieldType: Color, DefaultValue: 0xFF0000FF, Description: Bar background color
#DesignerProperty: Key: LevelTextSize, DisplayName: Level Text Size, FieldType: Int, DefaultValue: 12, Description: Level text size
#DesignerProperty: Key: LevelTextColor, DisplayName: Level Text Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Level text color
#DesignerProperty: Key: LevelColor, DisplayName: Level Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Level text background color
#DesignerProperty: Key: LevelPrefix, DisplayName: Level Prefix, FieldType: String, DefaultValue:
#DesignerProperty: Key: LevelSuffix, DisplayName: Level Suffix, FieldType: String, DefaultValue: %
#DesignerProperty: Key: IndicatorText, DisplayName: Indicator Text, FieldType: String, DefaultValue: Level Indicator
#DesignerProperty: Key: IndicatorTextSize, DisplayName: Indicator Text Size, FieldType: Int, DefaultValue: 14, Description: Level indicator text size
#DesignerProperty: Key: IndicatorTextColor, DisplayName: Indicator Text Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Level indicator text color
#DesignerProperty: Key: IndicatorColor, DisplayName: Indicator Color, FieldType: Color, DefaultValue: 0xFF0000FF, Description: Level indicator text background color
#DesignerProperty: Key: IndicatorFontAwesome, DisplayName: Indicator FontAwesome, FieldType: Boolean, DefaultValue: False, Description: Set the font of the level indicator text to fontawesome
#DesignerProperty: Key: IndicatorVisible, DisplayName: Indicator Visible, FieldType: Boolean, DefaultValue: True

'Kept the examples as reference
'#Event: ExampleEvent (Value As Int)
'#DesignerProperty: Key: BooleanExample, DisplayName: Boolean Example, FieldType: Boolean, DefaultValue: True, Description: Example of a boolean property.
'#DesignerProperty: Key: IntExample, DisplayName: Int Example, FieldType: Int, DefaultValue: 10, MinRange: 0, MaxRange: 100, Description: Note that MinRange and MaxRange are optional.
'#DesignerProperty: Key: StringWithListExample, DisplayName: String With List, FieldType: String, DefaultValue: Sunday, List: Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday
'#DesignerProperty: Key: StringExample, DisplayName: String Example, FieldType: String, DefaultValue: Text
'#DesignerProperty: Key: ColorExample, DisplayName: Color Example, FieldType: Color, DefaultValue: 0xFFCFDCDC, Description: You can use the built-in color picker to find the color values.
'#DesignerProperty: Key: DefaultColorExample, DisplayName: Default Color Example, FieldType: Color, DefaultValue: Null, Description: Setting the default value to Null means that a nullable field will be displayed.

Private Sub Class_Globals
	Private mVersion As String = "v1.00 (Build 20211109)"
	#If B4J
	Private fx As JFX
	#End If
	'CustomView objects Base, Event and Callback
	'Make BasePane a B4XView and public to access properties Dim objLI As LevelIndicator = p.GetView(0).Tag or objLI.mBase.Visible = False
	Public Base As B4XView
	Private mEventName As String
	Private mCallBack As Object
	'Properties
	Private mLevel As Int = 0
	Private mLevelMin As Int = 0
	Private mLevelMax As Int = 100
	Private mBorderWidth As Int
	Private mBorderColor As Int
	Private mBarColor As Int
	Private mLevelPrefix As String = ""
	Private mLevelSuffix As String = ""
	Private mLevelTextSize As Int
	Private mLevelTextColor As Int
	Private mLevelColor As Int
	Private mIndicatorText As String = ""
	Private mIndicatorTextSize As Int = 14
	Private mIndicatorTextColor As Int
	Private mIndicatorColor As Int
	Private mIndicatorFontAwesome As Boolean = False
	Private mIndicatorVisible As Boolean = True
	'XUI
	Private xui As XUI
	'Custom View Object Tag
	Public Tag As Object
	'Views
	Private pnLevelIndicator As B4XView		'Parent view holding the pnLevelBar
	Private lblLevel As B4XView				'Parent is pnLevelIndicator
	Private pnBar As B4XView				'Parent is pnLevelIndicator
	Private lblIndicator As B4XView			'Parent is pnLevelIndicator
End Sub

'Init the custom view.
'If view was added with the designer, do not use this method as handled by B4X.
Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Create the view with Base as an object (and not as pane).
Public Sub DesignerCreateView (BasePane As Object, Lbl As Label, Props As Map)
	Base = BasePane
	Base.Tag = Me
	'Get the properties and assign to local vars mVarName
	mLevel = 				Props.Get("Level")
	mLevelMin = 			Props.Get("LevelMin")
	mLevelMax = 			Props.Get("LevelMax")
	mLevelTextSize = 		Props.Get("LevelTextSize")
	mLevelTextColor = 		xui.PaintOrColorToColor(Props.Get("LevelTextColor"))
	mLevelColor = 			xui.PaintOrColorToColor(Props.Get("LevelColor"))
	mLevelPrefix = 			Props.Get("LevelPrefix")
	mLevelSuffix = 			Props.Get("LevelSuffix")
	mBorderWidth = 			Props.Get("BorderWidth")
	mBorderColor = 			xui.PaintOrColorToColor(Props.Get("BorderColor"))
	mBarColor = 			xui.PaintOrColorToColor(Props.Get("BarColor"))
	mIndicatorText =		Props.Get("IndicatorText")
	mIndicatorTextSize = 	Props.Get("IndicatorTextSize")
	mIndicatorTextColor = 	xui.PaintOrColorToColor(Props.Get("IndicatorTextColor"))
	mIndicatorColor = 		xui.PaintOrColorToColor(Props.Get("IndicatorColor"))
	mIndicatorFontAwesome =	Props.Get("IndicatorFontAwesome")
	mIndicatorVisible = 	Props.Get("IndicatorVisible")
	'Load the layout - must be via callsubdelayed (required for B4A)
	CallSubDelayed2(Me, "AfterLoadLayout", Props)
End Sub

'Load the layout after the method designercreateview is called.
'Use callsubdelayed again for setting fontawesome and the level.
Sub AfterLoadLayout(Props As Map)	'ignore
	Base.LoadLayout("LevelIndicator")
	'Use callsubdelayed to set the various properties
	CallSubDelayed2(Me, "setLevel", mLevel)
	CallSubDelayed2(Me, "setLevelMin", mLevelMin)
	CallSubDelayed2(Me, "setLevelMax", mLevelMax)
	CallSubDelayed2(Me, "setLevelTextSize", mLevelTextSize)
	CallSubDelayed2(Me, "setLevelTextColor", mLevelTextColor)
	CallSubDelayed2(Me, "setLevelColor", mLevelColor)

	CallSubDelayed2(Me, "setBorderWidth", mBorderWidth)
	CallSubDelayed2(Me, "setBorderColor", mBorderColor)

	CallSubDelayed2(Me, "setBarColor", mBarColor)

	CallSubDelayed2(Me, "setIndicatorText", mIndicatorText)
	CallSubDelayed2(Me, "setIndicatorTextSize", mIndicatorTextSize)
	CallSubDelayed2(Me, "setIndicatorTextColor", mIndicatorTextColor)
	CallSubDelayed2(Me, "setIndicatorColor", mIndicatorColor)
	CallSubDelayed2(Me, "setIndicatorFontAwesome", mIndicatorFontAwesome)
	CallSubDelayed2(Me, "setIndicatorVisible", mIndicatorVisible)

	lblLevel.SetLayoutAnimated(0, mBorderWidth, mBorderWidth, pnLevelIndicator.Width - (mBorderWidth * 2), lblLevel.Height)
	lblIndicator.SetLayoutAnimated(0, mBorderWidth, pnLevelIndicator.Height - mBorderWidth - lblIndicator.Height, pnLevelIndicator.Width - (mBorderWidth * 2), lblIndicator.Height)
End Sub

'Set the layout of the mBase. This can be used to reposition the indicator.
'Example: <code>
'LevelIndicator1.setLayout(LevelIndicator1.mBase.Left,LevelIndicator1.mBase.Top,LevelIndicator1.Level, LevelIndicator1.mBase.Height)
'</code>
Public Sub setLayout(Left As Double,Top As Double,Width As Double,Height As Double)
	Base.Left = Left
	Base.Top = Top
	Base.Width = Width
	Base.Height = Height
End Sub

'Handle base resize - ensure the view has anchors across horizontal and vertical.
Private Sub Base_Resize (Width As Double, Height As Double)
	'Check if the panelindicator is initialized (required for B4A)
	If pnLevelIndicator.IsInitialized Then
		setLevel(mLevel)
	End If
End Sub

'Get the base as a pane.
'The base is a View Panel (B4A) or Pane (B4J).
#if B4A
Public Sub GetBase As Panel
#End If
#if B4J
Public Sub GetBase As Pane
#End If
	Return Base
End Sub

'Get or set the level of the indicator bar.
'Level - 0-100
'Example: <code>
'LevelIndicator1.Level = Rnd(0, 100)
'If LevelIndicator1.Level <= 5 Then DoSomeThing ...
'</code>
Public Sub setLevel(value As Int)
	Dim l,t,w,h As Int
	mLevel = value

	'Set the label level text
	lblLevel.Text = $"${mLevelPrefix}${mLevel}${mLevelSuffix}"$

	'Calculate the max height of the bar which is the height of the pane(l) minus the two label heights
	Dim maxHeightBar As Int = pnLevelIndicator.Height - lblIndicator.Height - lblLevel.Height - (mBorderWidth * 2)

	'Get the level fraction between 0 - 1 (1=100%). If above 1 then mLevelMax is too low = s adjusted to 1.
	Dim levelTopFraction As Double = mLevel / (mLevelMax - mLevelMin)
	If levelTopFraction < 0 Then levelTopFraction = 0
	If levelTopFraction > 1 Then levelTopFraction = 1

	'Set the bar layout positions left, top, width, height
	'The top value decreases if the bar height increases, i.e. bar 100% the top = lblLevel.Height + mBorderWidth
	l = mBorderWidth
	t = (maxHeightBar * (1 - levelTopFraction)) + lblLevel.Height + mBorderWidth
	w = pnLevelIndicator.Width - (mBorderWidth * 2)
	h = (maxHeightBar * levelTopFraction)
	'Log($"setLevel: Level=${mLevel}/${levelTopFraction}: l=${l}, t=${t}, h=${h} || t+h=${t + h}/${maxHeightBar }"$)
	'Set the pane(l) bar layout
	pnBar.SetLayoutAnimated(300, l, t, w, h)

	'Update the value changed event callback if exists		
	If SubExists(mCallBack, mEventName & "_ValueChanged") Then
		CallSubDelayed2(mCallBack, mEventName & "_ValueChanged", mLevel)
	End If
End Sub

Public Sub getLevel As Int
	Return mLevel
End Sub

'Get or set the min level to be displayed in the bar.
'value - Minimum level
Public Sub setLevelMin(value As Int)
	mLevelMin = value
End Sub

Public Sub getLevelMin As Int
	Return mLevelMin
End Sub

'Get or set the max level to be displayed in the bar.
'Ensure the max level is equal or higher then the max level reached else the bar is getting to high.
'value - Maximum level
Public Sub setLevelMax(value As Int)
	mLevelMax = value
End Sub

Public Sub getLevelMax As Int
	Return mLevelMax
End Sub

'Set the border width of the indicator
'value - Border width between 0 and 10
Public Sub SetBorderWidth(value As Int)
	mBorderWidth = value
	pnLevelIndicator.SetColorAndBorder(pnLevelIndicator.Color, mBorderWidth, mBorderColor, 0)
End Sub

'Set the border color of the indicator
'value - Border color as int, i.e. xui.Color_Blue
Public Sub SetBorderColor(value As Int)
	mBorderColor = value
	pnLevelIndicator.SetColorAndBorder(pnLevelIndicator.Color, mBorderWidth, mBorderColor, 0)
End Sub

'Get or set the bar background color.
'value - Color value as Int
'Example: <code>
'LevelIndicator1.BarColor = xui.Color_Yellow
'</code>
Public Sub setBarColor(value As Int)
	mBarColor = value
	pnBar.Color = mBarColor
End Sub

Public Sub getBarColor As Int
	Return mBarColor
End Sub

'Get or set the level prefix text.
'text - Text to display prior the level text. Note using a space after the text for the level value.
'Example: <code>
'LevelIndicator1.LevelTextPrefix = "Battery "
'</code>
Public Sub setLevelTextPrefix(text As String)
	mLevelPrefix = text
End Sub

Public Sub getLevelTextPrefix As String
	Return mLevelPrefix
End Sub

'Get or set the level suffix text.
'text - Text to display after the level text
'Example: <code>
'LevelIndicator1.LevelTextSuffix = "%"
'</code>
Public Sub setLevelTextSuffix(text As String)
	mLevelSuffix = text
End Sub

Public Sub getLevelTextSuffix As String
	Return mLevelSuffix
End Sub

'Get or set the level text size.
'value - Text size as Int
'Example: <code>
'LevelIndicator1.LevelTextSize = 14
'</code>
Public Sub setLevelTextSize(value As Int)
	mLevelTextSize = value
	lblLevel.TextSize = mLevelTextSize
End Sub

Public Sub getLevelTextSize As Int
	Return mLevelTextSize
End Sub

'Get or set the level text color.
'value - Color value as Int
'Example: <code>
'LevelIndicator1.LevelTextColor = xui.Color_Red
'</code>
Public Sub setLevelTextColor(value As Int)
	mLevelTextColor = value
	lblLevel.TextColor = mLevelTextColor
End Sub

Public Sub getLevelTextColor As Int
	Return mLevelTextColor
End Sub

'Get or set the level text background color.
'value - Color value as Int
'Example: <code>
'LevelIndicator1.LevelColor = xui.Color_Blue
'</code>
Public Sub setLevelColor(value As Int)
	mLevelColor = value
	lblLevel.Color = mLevelColor
End Sub

Public Sub getLevelColor As Int
	Return mLevelColor
End Sub

'Get or set the indicator text (bottom of the custom view).
'text - Text string or use fontawesome to display a symbol
'Example: <code>
'Set the text as fontawesome battery symbol depending indicator level
'Dim iconHex As Int
'If BatteryIndicator.Level <= 10 Then
'	iconHex = 0xF244
'	BatteryIndicator.IndicatorTextColor = xui.Color_Red
'Else If BatteryIndicator.Level > 10 And BatteryIndicator.Level <= 25 Then
'	iconHex = 0xF243
'	BatteryIndicator.IndicatorTextColor = xui.Color_Yellow
'Else If BatteryIndicator.Level > 25 And BatteryIndicator.Level <= 50 Then
'	iconHex = 0xF242
'	BatteryIndicator.IndicatorTextColor = defaultColor
'Else If BatteryIndicator.Level > 50 And BatteryIndicator.Level <= 75 Then
'	iconHex = 0xF241
'	BatteryIndicator.IndicatorTextColor = defaultColor
'Else
'	iconHex = 0xF240
'	BatteryIndicator.IndicatorTextColor = defaultColor
'End If
'BatteryIndicator.IndicatorText = Chr(iconHex)
'</code>
Public Sub setIndicatorText(text As String)
	mIndicatorText = text
	lblIndicator.Text = mIndicatorText
End Sub

Public Sub getIndicatorText As String
	Return mIndicatorText
End Sub

'Get or set the Indicator text size.
'value - Text size as Int
'Example: <code>
'LevelIndicator1.IndicatorTextSize = 18
'</code>
Public Sub setIndicatorTextSize(value As Int)
	mIndicatorTextSize = value
	lblIndicator.TextSize = mIndicatorTextSize
End Sub

Public Sub getIndicatorTextSize As Int
	Return mIndicatorTextSize
End Sub

'Get or set the Indicator text color.
'value - Color value as Int
'Example: <code>
'LevelIndicator1.IndicatorTextColor = xui.Color_Red
'</code>
Public Sub setIndicatorTextColor(value As Int)
	mIndicatorTextColor = value
	lblIndicator.TextColor = mIndicatorTextColor
End Sub

Public Sub getIndicatorTextColor As Int
	Return mIndicatorTextColor
End Sub

'Get or set the indicator text background color.
'value - Color value as Int
'Example: <code>
'LevelIndicator1.IndicatorColor = xui.Color_Blue
'</code>
Public Sub setIndicatorColor(value As Int)
	mIndicatorColor = value
	lblIndicator.Color = mIndicatorColor
End Sub

Public Sub getIndicatorColor As Int
	Return mIndicatorColor
End Sub

'Get or set the indicator font to FontAwesome or Default.
'Recommend to set via the Visual Designer. If setting via code, use CallSubDelayed (for B4A).
'value - True = FontAwesome, False = Default
'Hint CallSubDelayed:<code> 
'CallSubDelayed(Me, "SetLevelIndicatorFontAwesome")
'Sub SetLevelIndicatorFontAwesome
'	LevelIndicator1.IndicatorFontAwesome = True
'End Sub
'</code>
Public Sub setIndicatorFontAwesome(value As Boolean)
	If value Then
		lblIndicator.Font = xui.CreateFontAwesome(lblIndicator.TextSize)
		If mIndicatorText.ToUpperCase.StartsWith("0X") Then
			lblIndicator.Text = Chr(Bit.ParseInt(mIndicatorText.ToUpperCase.Replace("0X",""), 16))
		End If
	Else
		lblIndicator.Font = xui.CreateDefaultFont(lblIndicator.TextSize)
		lblIndicator.Text = mIndicatorText
	End If
	mIndicatorFontAwesome = value
End Sub

Public Sub getIndicatorFontAwesome As Boolean
	Return mIndicatorFontAwesome
End Sub

'Get or set the indicator visibility.
'value - Boolean True|False
Public Sub setIndicatorVisible(value As Boolean)
	mIndicatorVisible = value
	lblIndicator.Visible = mIndicatorVisible
End Sub

Public Sub getIndicatorVisible As Boolean
	Return mIndicatorVisible
End Sub

'Set the color and the border properties.
'Example: <copy>
'LevelIndicator1.SetColorAndBorder(xui.Color_Transparent, 5dip, xui.Color_Red, 5dip)
'</copy>
Public Sub SetColorAndBorder(BackgroundColor As Int, BorderWidth As Int, BorderColor As Int, BorderCornerRadius As Int)
	pnLevelIndicator.SetColorAndBorder(BackgroundColor, BorderWidth, BorderColor, BorderCornerRadius)
	lblLevel.SetColorAndBorder(lblLevel.Color, 0, 0, BorderCornerRadius)
	lblIndicator.SetColorAndBorder(lblIndicator.Color, 0, 0, BorderCornerRadius)
End Sub

'Get the version of the LevelIndicator.
'Returns - String with the version like v20211108.
Public Sub Version As String
	Return mVersion
End Sub
