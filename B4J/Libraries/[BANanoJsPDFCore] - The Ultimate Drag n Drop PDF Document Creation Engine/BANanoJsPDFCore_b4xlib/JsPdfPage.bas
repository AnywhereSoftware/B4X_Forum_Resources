B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
#IgnoreWarnings:12
#DesignerProperty: Key: DataFormat, DisplayName: Format, FieldType: String, DefaultValue: a4, Description: DataFormat, List: a0|a1|a10|a10|a2|a3|a4|a5|a6|a7|a8|a9|b0|b1|b10|b10|b2|b3|b4|b5|b6|b7|b8|b9|c0|c1|c10|c10|c2|c3|c4|c5|c6|c7|c8|c9|credit-card|dl|government-letter|junior-legal|ledger|legal|letter|tabloid
#DesignerProperty: Key: DataOrientation, DisplayName: Orientation, FieldType: String, DefaultValue: potrait, Description: DataOrientation, List: landscape|potrait
#DesignerProperty: Key: DataFontName, DisplayName: FontName, FieldType: String, DefaultValue: , Description: DataFontName
#DesignerProperty: Key: DataFontStyle, DisplayName: FontStyle, FieldType: String, DefaultValue: none, Description: DataFontStyle, List: none|bold|bolditalic|italic|normal
#DesignerProperty: Key: DataFontWeight, DisplayName: FontWeight, FieldType: String, DefaultValue: 400, Description: FontWeight, List: 100|200|300|400|500|600|700|800|900
#DesignerProperty: Key: DataFontSize, DisplayName: FontSize, FieldType: String, DefaultValue: 16 , Description: DataFontSize
#DesignerProperty: Key: DataTextColor, DisplayName: Text Color RGBA, FieldType: String, DefaultValue: 0; 0; 0 , Description: Text Color RGBA
#DesignerProperty: Key: ColorChooser, DisplayName: ColorChooser, FieldType: Color, DefaultValue: Null, Description: Use this to select RGB color
#DesignerProperty: Key: Zoom, DisplayName: Zoom, FieldType: String, DefaultValue: , Description: Zoom
#DesignerProperty: Key: Layout, DisplayName: Layout, FieldType: String, DefaultValue: , Description: Layout, List: single|twoleft|tworight
#DesignerProperty: Key: PMode, DisplayName: PMode, FieldType: String, DefaultValue: , Description: PMode, List: UseOutlines|UseThumbs|FullScreen


Sub Class_Globals 
    Private BANano As BANano 'ignore 
	Private mName As String 'ignore 
	Private mEventName As String 'ignore 
	Private mCallBack As Object 'ignore 
	Private mTarget As BANanoElement 'ignore 
	Private mElement As BANanoElement 'ignore 
	Public VElement As BAElement 
	Private sDataFormat As String
	Private sDataOrientation As String
	Private sDataFontName As String
	Private sDataFontSize As String
	Private sDataFontStyle As String
	Private sDataFontWeight As String
	Private sZoom As String
	Private sLayout As String
	Private sPMode As String
	Private sDataTextColor As String
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
		sDataFormat = Props.GetDefault("DataFormat", "a4")
		sDataOrientation = Props.GetDefault("DataOrientation", "potrait")
		sDataFontName = Props.GetDefault("DataFontName", "")
		sDataFontSize = Props.GetDefault("DataFontSize", "16")
		sDataFontStyle = Props.GetDefault("DataFontStyle", "none")
		sDataFontWeight = Props.GetDefault("DataFontWeight", "normal")
		sZoom = Props.GetDefault("Zoom", "")
		sLayout = Props.GetDefault("Layout", "")
		sPMode = Props.GetDefault("PMode", "")
		sDataTextColor = Props.GetDefault("DataTextColor", "0; 0; 0")
	End If 
	' 
	'build and get the element 
	If BANano.Exists($"#${mName}"$) Then 
		mElement = BANano.GetElement($"#${mName}"$) 
	Else	 
		mElement = mTarget.Append($"<div data-type="page" id="${mName}"></div>"$).Get("#" & mName) 
	End If 
	' 
	VElement.Initialize(mCallBack, mName, mName) 
	VElement.AddAttr("data-format", sDataFormat)
	VElement.AddAttr("data-orientation", sDataOrientation)
	VElement.AddAttr("data-fontname", sDataFontName)
	VElement.AddAttr("data-fontsize", sDataFontSize)
	VElement.AddAttr("data-fontstyle", sDataFontStyle)
	VElement.AddAttr("data-fontweight", sDataFontWeight)
	VElement.AddAttr("data-zoom", sZoom)
	VElement.AddAttr("data-layout", sLayout)
	VElement.AddAttr("data-pmode", sPMode)
	VElement.AddAttr("data-textcolor", sDataTextColor)
	VElement.AddStyle("display", "none")
End Sub

'the target for this document
Sub getHere As String
	Return $"#${mName}"$
End Sub

Sub getID As String
	Return mName
End Sub