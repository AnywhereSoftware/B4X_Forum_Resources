B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
#IgnoreWarnings:12
#DesignerProperty: Key: DataX1, DisplayName: X1, FieldType: String, DefaultValue: , Description: DataX1
#DesignerProperty: Key: DataY1, DisplayName: Y1, FieldType: String, DefaultValue: , Description: DataY1
#DesignerProperty: Key: DataX2, DisplayName: X2, FieldType: String, DefaultValue: , Description: DataX2
#DesignerProperty: Key: DataY2, DisplayName: Y2, FieldType: String, DefaultValue: , Description: DataY2
#DesignerProperty: Key: DataX3, DisplayName: X3, FieldType: String, DefaultValue: , Description: DataX3
#DesignerProperty: Key: DataY3, DisplayName: Y3, FieldType: String, DefaultValue: , Description: DataY3
#DesignerProperty: Key: DataStyle, DisplayName: Style, FieldType: String, DefaultValue: S, Description: DataStyle, List: F|FD|S
#DesignerProperty: Key: DataLineWidth, DisplayName: LineWidth, FieldType: String, DefaultValue: , Description: DataLineWidth
#DesignerProperty: Key: DataDrawColor, DisplayName: DrawColor, FieldType: String, DefaultValue: , Description: DataDrawColor
#DesignerProperty: Key: DataFillColor, DisplayName: FillColor, FieldType: String, DefaultValue: , Description: DataFillColor
#DesignerProperty: Key: ColorChooser, DisplayName: ColorChooser, FieldType: Color, DefaultValue: Null, Description: Use this to select RGB color

Sub Class_Globals 
    Private BANano As BANano 'ignore 
	Private mName As String 'ignore 
	Private mEventName As String 'ignore 
	Private mCallBack As Object 'ignore 
	Private mTarget As BANanoElement 'ignore 
	Private mElement As BANanoElement 'ignore 
	Public VElement As BAElement 
	Private sDataDrawColor As String
	Private sDataFillColor As String
	Private sDataLineWidth As String	
	Private sDataStyle As String
	Private sDataX1 As String
	Private sDataX2 As String
	Private sDataX3 As String
	Private sDataY1 As String
	Private sDataY2 As String
	Private sDataY3 As String
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
		sDataDrawColor = Props.GetDefault("DataDrawColor", "")
		sDataFillColor = Props.GetDefault("DataFillColor", "")
		sDataLineWidth = Props.GetDefault("DataLineWidth", "")
		sDataStyle = Props.GetDefault("DataStyle", "S")
		sDataX1 = Props.GetDefault("DataX1", "")
		sDataX2 = Props.GetDefault("DataX2", "")
		sDataX3 = Props.GetDefault("DataX3", "")
		sDataY1 = Props.GetDefault("DataY1", "")
		sDataY2 = Props.GetDefault("DataY2", "")
		sDataY3 = Props.GetDefault("DataY3", "")
	End If 
	' 
	'build and get the element 
	If BANano.Exists($"#${mName}"$) Then 
		mElement = BANano.GetElement($"#${mName}"$) 
	Else	 
		mElement = mTarget.Append($"<div data-type="triangle" id="${mName}"></div>"$).Get("#" & mName) 
	End If 
	' 
	VElement.Initialize(mCallBack, mName, mName) 
	VElement.AddAttr("data-drawcolor", sDataDrawColor)
	VElement.AddAttr("data-fillcolor", sDataFillColor)
	VElement.AddAttr("data-linewidth", sDataLineWidth)
	VElement.AddAttr("data-style", sDataStyle)
	VElement.AddAttr("data-x1", sDataX1)
	VElement.AddAttr("data-x2", sDataX2)
	VElement.AddAttr("data-x3", sDataX3)
	VElement.AddAttr("data-y1", sDataY1)
	VElement.AddAttr("data-y2", sDataY2)
	VElement.AddAttr("data-y3", sDataY3)
	VElement.AddStyle("display", "none")
End Sub

