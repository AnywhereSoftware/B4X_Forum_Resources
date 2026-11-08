B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
#IgnoreWarnings:12
#DesignerProperty: Key: DataAlias, DisplayName: Alias*, FieldType: String, DefaultValue: , Description: DataAlias
#DesignerProperty: Key: DataImageData, DisplayName: URL*, FieldType: String, DefaultValue: , Description: URL
#DesignerProperty: Key: DataFormat, DisplayName: Format*, FieldType: String, DefaultValue: JPEG, Description: DataFormat, List: JPEG|NONE|PNG|WEBP
#DesignerProperty: Key: DataX, DisplayName: X*, FieldType: String, DefaultValue: 60, Description: DataX
#DesignerProperty: Key: DataY, DisplayName: Y*, FieldType: String, DefaultValue: 60, Description: DataY
#DesignerProperty: Key: DataWidth, DisplayName: Width*, FieldType: String, DefaultValue: 100, Description: DataWidth
#DesignerProperty: Key: DataHeight, DisplayName: Height*, FieldType: String, DefaultValue: 100, Description: DataHeight
#DesignerProperty: Key: DataCompression, DisplayName: Compression, FieldType: String, DefaultValue: NONE, Description: DataCompression, List: FAST|MEDIUM|NONE|SLOW
#DesignerProperty: Key: DataRotation, DisplayName: Rotation, FieldType: String, DefaultValue: , Description: DataRotation

Sub Class_Globals 
    Private BANano As BANano 'ignore 
	Private mName As String 'ignore 
	Private mEventName As String 'ignore 
	Private mCallBack As Object 'ignore 
	Private mTarget As BANanoElement 'ignore 
	Private mElement As BANanoElement 'ignore 
	Public VElement As BAElement 
	Private sDataAlias As String
	Private sDataCompression As String
	Private sDataFormat As String
	Private sDataHeight As String
	Private sDataImageData As String
	Private sDataRotation As String
	Private sDataWidth As String
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
		sDataAlias = Props.GetDefault("DataAlias", "")
		sDataCompression = Props.GetDefault("DataCompression", "NONE")
		sDataFormat = Props.GetDefault("DataFormat", "JPEG")
		sDataHeight = Props.GetDefault("DataHeight", "100")
		sDataImageData = Props.GetDefault("DataImageData", "")
		sDataRotation = Props.GetDefault("DataRotation", "0")
		sDataWidth = Props.GetDefault("DataWidth", "100")
		sDataX = Props.GetDefault("DataX", "60")
		sDataY = Props.GetDefault("DataY", "60")
	End If 
	' 
	'build and get the element 
	If BANano.Exists($"#${mName}"$) Then 
		mElement = BANano.GetElement($"#${mName}"$) 
	Else	 
		mElement = mTarget.Append($"<div data-type="image" id="${mName}"></div>"$).Get("#" & mName) 
	End If 
	' 
	VElement.Initialize(mCallBack, mName, mName) 
	VElement.AddStyle("display", "none")
	VElement.AddAttr("data-alias", sDataAlias)
	VElement.AddAttr("data-compression", sDataCompression)
	VElement.AddAttr("data-format", sDataFormat)
	VElement.AddAttr("data-height", sDataHeight)
	VElement.AddAttr("data-imagedata", sDataImageData)
	VElement.AddAttr("data-rotation", sDataRotation)
	VElement.AddAttr("data-width", sDataWidth)
	VElement.AddAttr("data-x", sDataX)
	VElement.AddAttr("data-y", sDataY)
End Sub

