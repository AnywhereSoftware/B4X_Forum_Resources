B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
#IgnoreWarnings:12
#DesignerProperty: Key: DataX, DisplayName: X, FieldType: String, DefaultValue: , Description: DataX
#DesignerProperty: Key: DataY, DisplayName: Y, FieldType: String, DefaultValue: , Description: DataY
#DesignerProperty: Key: DataW, DisplayName: W, FieldType: String, DefaultValue: , Description: DataW
#DesignerProperty: Key: DataH, DisplayName: H, FieldType: String, DefaultValue: , Description: DataH
#DesignerProperty: Key: DataType, DisplayName: Type, FieldType: String, DefaultValue: text, Description: DataType, List: freetext|text|link
#DesignerProperty: Key: DataTitle, DisplayName: Title, FieldType: String, DefaultValue: , Description: DataTitle
#DesignerProperty: Key: DataContents, DisplayName: Contents, FieldType: String, DefaultValue: , Description: DataContents
#DesignerProperty: Key: DataOpen, DisplayName: Open, FieldType: Boolean, DefaultValue: False, Description: DataOpen
#DesignerProperty: Key: DataColorHex, DisplayName: Color Hex, FieldType: String, DefaultValue: , Description: DataColorHex
#DesignerProperty: Key: ColorChooser, DisplayName: ColorChooser, FieldType: Color, DefaultValue: Null, Description: Use this to select RGB color
#DesignerProperty: Key: DataTextColor, DisplayName: Text Color RGB, FieldType: String, DefaultValue: , Description: DataTextColor
#DesignerProperty: Key: DataFontName, DisplayName: FontName, FieldType: String, DefaultValue: , Description: DataFontName
#DesignerProperty: Key: DataFontSize, DisplayName: FontSize, FieldType: String, DefaultValue: , Description: DataFontSize
#DesignerProperty: Key: DataFontStyle, DisplayName: FontStyle, FieldType: String, DefaultValue: , Description: DataFontStyle, List: bold|bolditalic|italic|normal
#DesignerProperty: Key: DataFontWeight, DisplayName: FontWeight, FieldType: String, DefaultValue: , Description: DataFontWeight, List: 100|200|300|400|500|600|700|800|900

Sub Class_Globals 
    Private BANano As BANano 'ignore 
	Private mName As String 'ignore 
	Private mEventName As String 'ignore 
	Private mCallBack As Object 'ignore 
	Private mTarget As BANanoElement 'ignore 
	Private mElement As BANanoElement 'ignore 
	Public VElement As BAElement 
	Private sDataColorHex As String
	Private sDataContents As String
	Private sDataFontName As String
	Private sDataFontSize As String
	Private sDataFontStyle As String
	Private sDataFontWeight As String
	Private sDataH As String
	Private bDataOpen As Boolean
	Private sDataTextColor As String
	Private sDataTitle As String
	Private sDataType As String
	Private sDataW As String
	Private sDataX As String
	Private sDataY As String
End Sub

Sub Initialize (CallBack As Object, Name As String, EventName As String) 
	mName = Name.tolowercase 
	mEventName = EventName.ToLowerCase 
	mCallBack = CallBack	 
	mName = mName.Replace("#","") 
	mEventName = mEventName.Replace("#","") 
	If mName <> "" Then 
		Dim fKey As String = $"#${mName}"$ 
		If BANano.Exists(fKey) Then  
			mElement = BANano.GetElement(fKey) 
		End If 
	End If 
	End Sub

Sub DesignerCreateView (Target As BANanoElement, Props As Map) 
	mTarget = Target 
	If Props <> Null Then 
		sDataColorHex = Props.GetDefault("DataColorHex", "")
		sDataContents = Props.GetDefault("DataContents", "")
		sDataFontName = Props.GetDefault("DataFontName", "")
		sDataFontSize = Props.GetDefault("DataFontSize", "")
		sDataFontStyle = Props.GetDefault("DataFontStyle", "")
		sDataFontWeight = Props.GetDefault("DataFontWeight", "")
		sDataH = Props.GetDefault("DataH", "")
		bDataOpen = Props.GetDefault("DataOpen", False)
		sDataTextColor = Props.GetDefault("DataTextColor", "")
		sDataTitle = Props.GetDefault("DataTitle", "")
		sDataType = Props.GetDefault("DataType", "text")
		sDataW = Props.GetDefault("DataW", "")
		sDataX = Props.GetDefault("DataX", "")
		sDataY = Props.GetDefault("DataY", "")
	End If 
	' 
	'build and get the element 
	If BANano.Exists($"#${mName}"$) Then 
		mElement = BANano.GetElement($"#${mName}"$) 
	Else	 
		mElement = mTarget.Append($"<div data-type="annotation" id="${mName}"></div>"$).Get("#" & mName) 
	End If 
	' 
	VElement.Initialize(mCallBack, mName, mName) 
	VElement.AddStyle("display", "none")
	VElement.AddAttr("data-colorhex", sDataColorHex)
	VElement.AddAttr("data-contents", sDataContents)
	VElement.AddAttr("data-fontname", sDataFontName)
	VElement.AddAttr("data-fontsize", sDataFontSize)
	VElement.AddAttr("data-fontstyle", sDataFontStyle)
	VElement.AddAttr("data-fontweight", sDataFontWeight)
	VElement.AddAttr("data-h", sDataH)
	VElement.AddAttr("data-open", bDataOpen)
	VElement.AddAttr("data-textcolor", sDataTextColor)
	VElement.AddAttr("data-title", sDataTitle)
	VElement.AddAttr("data-w", sDataW)
	VElement.AddAttr("data-x", sDataX)
	VElement.AddAttr("data-y", sDataY)
	VElement.AddAttr("data-annottype", sDataType)
End Sub

