B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
#IgnoreWarnings:12
#DesignerProperty: Key: DataText, DisplayName: Text*, FieldType: String, DefaultValue: , Description: DataText
#DesignerProperty: Key: DataX, DisplayName: X*, FieldType: String, DefaultValue: , Description: DataX
#DesignerProperty: Key: DataY, DisplayName: Y*, FieldType: String, DefaultValue: , Description: DataY
#DesignerProperty: Key: DataFontName, DisplayName: FontName, FieldType: String, DefaultValue: , Description: DataFontName
#DesignerProperty: Key: DataFontStyle, DisplayName: FontStyle, FieldType: String, DefaultValue: none, Description: DataFontStyle, List: none|bold|bolditalic|italic|normal
#DesignerProperty: Key: DataFontWeight, DisplayName: FontWeight, FieldType: String, DefaultValue: 400, Description: FontWeight , List: 100|200|300|400|500|600|700|800|900
#DesignerProperty: Key: DataFontSize, DisplayName: FontSize*, FieldType: String, DefaultValue: 16, Description: DataFontSize
#DesignerProperty: Key: DataTextColor, DisplayName: Text Color RGBA, FieldType: String, DefaultValue: , Description: Text Color RGBA
#DesignerProperty: Key: ColorChooser, DisplayName: ColorChooser, FieldType: Color, DefaultValue: Null, Description: Use this to select RGB color
#DesignerProperty: Key: DataAlign, DisplayName: Align, FieldType: String, DefaultValue: left, Description: DataAlign, List: center|justify|left|right
#DesignerProperty: Key: DataAngle, DisplayName: Angle, FieldType: String, DefaultValue: 0, Description: DataAngle
#DesignerProperty: Key: DataBaseline, DisplayName: Baseline, FieldType: String, DefaultValue: alphabetic, Description: DataBaseline, List: alphabetic|bottom|hanging|ideographic|middle|top
#DesignerProperty: Key: DataCharSpace, DisplayName: CharSpace, FieldType: String, DefaultValue: 0, Description: DataCharSpace
#DesignerProperty: Key: DataLineHeightFactor, DisplayName: DataLineHeightFactor, FieldType: String, DefaultValue: 1.5, Description: DataLineHeightFactor
#DesignerProperty: Key: DataMaxWidth, DisplayName: MaxWidth, FieldType: String, DefaultValue: 0, Description: DataMaxWidth
#DesignerProperty: Key: DataRenderingMode, DisplayName: RenderingMode, FieldType: String, DefaultValue: fill, Description: DataRenderingMode, List: addToPathForClipping|fill|fillAndAddForClipping|fillThenStroke|fillThenStrokeAndAddToPathForClipping|invisible|stroke|strokeAndAddPathForClipping
#DesignerProperty: Key: DataRotationDirection, DisplayName: RotationDirection, FieldType: String, DefaultValue: counterclockwise, Description: DataRotationDirection, List: clockwise|counterclockwise
#DesignerProperty: Key: DataTransform, DisplayName: Transform, FieldType: String, DefaultValue: , Description: DataTransform
#DesignerProperty: Key: DataWithLink, DisplayName: WithLink, FieldType: Boolean, DefaultValue: False, Description: DataWithLink
#DesignerProperty: Key: DataUrl, DisplayName: Url, FieldType: String, DefaultValue: , Description: DataUrl
#DesignerProperty: Key: DataPageNumber, DisplayName: PageNumber, FieldType: String, DefaultValue: , Description: DataPageNumber

Sub Class_Globals 
    Private BANano As BANano 'ignore 
	Private mName As String 'ignore 
	Private mEventName As String 'ignore 
	Private mCallBack As Object 'ignore 
	Private mTarget As BANanoElement 'ignore 
	Private mElement As BANanoElement 'ignore 
	Public VElement As BAElement 
	Private sDataAlign As String
Private sDataAngle As String
Private sDataBaseline As String
Private sDataCharSpace As String
Private sDataFontName As String
Private sDataFontSize As String
Private sDataFontStyle As String
Private sDataLineHeightFactor As String
Private sDataMaxWidth As String
Private sDataRenderingMode As String
Private sDataRotationDirection As String
Private sDataText As String
Private sDataTransform As String
Private sDataX As String
Private sDataY As String
Private sDataFontWeight As String
Private sDataTextColor As String
Private sDataPageNumber As String
Private sDataUrl As String
Private bDataWithLink As Boolean	
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
		sDataAlign = Props.GetDefault("DataAlign", "left")
		sDataAngle = Props.GetDefault("DataAngle", "0")
		sDataBaseline = Props.GetDefault("DataBaseline", "alphabetic")
		sDataCharSpace = Props.GetDefault("DataCharSpace", "0")
		sDataFontName = Props.GetDefault("DataFontName", "")
		sDataFontSize = Props.GetDefault("DataFontSize", "16")
		sDataFontStyle = Props.GetDefault("DataFontStyle", "none")
		sDataLineHeightFactor = Props.GetDefault("DataLineHeightFactor", "1.5")
		sDataMaxWidth = Props.GetDefault("DataMaxWidth", "0")
		sDataRenderingMode = Props.GetDefault("DataRenderingMode", "fill")
		sDataRotationDirection = Props.GetDefault("DataRotationDirection", "counterclockwise")
		sDataText = Props.GetDefault("DataText", "")
		sDataTextColor = Props.GetDefault("DataTextColor", "")
		sDataTransform = Props.GetDefault("DataTransform", "")
		sDataX = Props.GetDefault("DataX", "")
		sDataY = Props.GetDefault("DataY", "")
		sDataFontWeight = Props.GetDefault("DataFontWeight", "")
		sDataPageNumber = Props.GetDefault("DataPageNumber", "")
		sDataUrl = Props.GetDefault("DataUrl", "")
		bDataWithLink = Props.GetDefault("DataWithLink", False)
	End If 
	' 
	'build and get the element 
	If BANano.Exists($"#${mName}"$) Then 
		mElement = BANano.GetElement($"#${mName}"$) 
	Else	 
		mElement = mTarget.Append($"<div data-type="text" id="${mName}"></div>"$).Get("#" & mName) 
	End If 
	' 
	VElement.Initialize(mCallBack, mName, mName) 
	VElement.AddStyle("display", "none")
	VElement.AddAttr("data-align", sDataAlign)
	VElement.AddAttr("data-angle", sDataAngle)
	VElement.AddAttr("data-baseline", sDataBaseline)
	VElement.AddAttr("data-charspace", sDataCharSpace)
	VElement.AddAttr("data-fontname", sDataFontName)
	VElement.AddAttr("data-fontsize", sDataFontSize)
	VElement.AddAttr("data-fontstyle", sDataFontStyle)
	VElement.AddAttr("data-lineheightfactor", sDataLineHeightFactor)
	VElement.AddAttr("data-maxwidth", sDataMaxWidth)
	VElement.AddAttr("data-renderingmode", sDataRenderingMode)
	VElement.AddAttr("data-rotationdirection", sDataRotationDirection)
	VElement.AddAttr("data-text", sDataText)
	VElement.AddAttr("data-textcolor", sDataTextColor)
	VElement.AddAttr("data-transform", sDataTransform)
	VElement.AddAttr("data-x", sDataX)
	VElement.AddAttr("data-y", sDataY)
	VElement.AddAttr("data-fontweight", sDataFontWeight)
	VElement.AddAttr("data-pagenumber", sDataPageNumber)
	VElement.AddAttr("data-url", sDataUrl)
	VElement.AddAttr("data-withlink", bDataWithLink)
End Sub
