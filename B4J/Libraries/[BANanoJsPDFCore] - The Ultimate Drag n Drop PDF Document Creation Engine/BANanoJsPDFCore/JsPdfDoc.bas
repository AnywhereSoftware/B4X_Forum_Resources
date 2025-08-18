B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
#IgnoreWarnings:12
#IgnoreWarnings:9
#DesignerProperty: Key: Title, DisplayName: Title, FieldType: String, DefaultValue: BVAD3 PDF, Description: Title
#DesignerProperty: Key: Subject, DisplayName: Subject, FieldType: String, DefaultValue: , Description: Subject
#DesignerProperty: Key: Author, DisplayName: Author, FieldType: String, DefaultValue: , Description: Author
#DesignerProperty: Key: Creator, DisplayName: Creator, FieldType: String, DefaultValue: , Description: Creator
#DesignerProperty: Key: KeyWords, DisplayName: KeyWords, FieldType: String, DefaultValue: , Description: KeyWords

#DesignerProperty: Key: Compress, DisplayName: Compress, FieldType: Boolean, DefaultValue: False, Description: Compress
#DesignerProperty: Key: FileName, DisplayName: FileName, FieldType: String, DefaultValue: bvad3pdf1, Description: FileName
#DesignerProperty: Key: FontName, DisplayName: FontName, FieldType: String, DefaultValue: , Description: FontName
#DesignerProperty: Key: FontStyle, DisplayName: FontStyle, FieldType: String, DefaultValue: none, Description: FontStyle, List: none|bold|bolditalic|italic|normal
#DesignerProperty: Key: FontWeight, DisplayName: FontWeight, FieldType: String, DefaultValue: 400, Description: FontWeight, , List: 100|200|300|400|500|600|700|800|900
#DesignerProperty: Key: FontSize, DisplayName: FontSize, FieldType: String, DefaultValue: 16, Description: FontSize
#DesignerProperty: Key: DataTextColor, DisplayName: Text Color RGBA, FieldType: String, DefaultValue: 0;0;0 , Description: Text Color RGBA
#DesignerProperty: Key: ColorChooser, DisplayName: ColorChooser, FieldType: Color, DefaultValue: Null, Description: Use this to select RGB color

#DesignerProperty: Key: Zoom, DisplayName: Zoom, FieldType: String, DefaultValue: , Description: Zoom
#DesignerProperty: Key: Layout, DisplayName: Layout, FieldType: String, DefaultValue: , Description: Layout, List: single|twoleft|tworight
#DesignerProperty: Key: PMode, DisplayName: PMode, FieldType: String, DefaultValue: , Description: PMode, List: UseOutlines|UseThumbs|FullScreen
#DesignerProperty: Key: LineHeight, DisplayName: LineHeight, FieldType: String, DefaultValue: , Description: LineHeight
#DesignerProperty: Key: MarginBottom, DisplayName: MarginBottom, FieldType: String, DefaultValue: 0, Description: MarginBottom
#DesignerProperty: Key: MarginLeft, DisplayName: MarginLeft, FieldType: String, DefaultValue: 0, Description: MarginLeft
#DesignerProperty: Key: MarginRight, DisplayName: MarginRight, FieldType: String, DefaultValue: 0, Description: MarginRight
#DesignerProperty: Key: MarginTop, DisplayName: MarginTop, FieldType: String, DefaultValue: 0, Description: MarginTop
#DesignerProperty: Key: Orientation, DisplayName: Orientation, FieldType: String, DefaultValue: potrait, Description: Orientation, List: landscape|potrait
#DesignerProperty: Key: PageNumbers, DisplayName: PageNumbers, FieldType: Boolean, DefaultValue: False, Description: PageNumbers
#DesignerProperty: Key: PageSize, DisplayName: PageSize, FieldType: String, DefaultValue: a4, Description: PageSize, List: a0|a1|a10|a2|a3|a4|a5|a6|a7|a8|a9|a10|b0|b1|b10|b2|b3|b4|b5|b6|b7|b8|b9|b10|c0|c1|c10|c2|c3|c4|c5|c6|c7|c8|c9|c10|credit-card|dl|government-letter|junior-legal|ledger|legal|letter|tabloid

#DesignerProperty: Key: OwnerPassword, DisplayName: OwnerPassword, FieldType: String, DefaultValue: , Description: OwnerPassword
#DesignerProperty: Key: UserPassword, DisplayName: UserPassword, FieldType: String, DefaultValue: , Description: UserPassword
#DesignerProperty: Key: PermissionAnnotForms, DisplayName: PermissionAnnotForms, FieldType: Boolean, DefaultValue: False, Description: PermissionAnnotForms
#DesignerProperty: Key: PermissionCopy, DisplayName: PermissionCopy, FieldType: Boolean, DefaultValue: False, Description: PermissionCopy
#DesignerProperty: Key: PermissionModify, DisplayName: PermissionModify, FieldType: Boolean, DefaultValue: False, Description: PermissionModify
#DesignerProperty: Key: PermissionPrint, DisplayName: PermissionPrint, FieldType: Boolean, DefaultValue: False, Description: PermissionPrint
#DesignerProperty: Key: Precision, DisplayName: Precision, FieldType: String, DefaultValue: 16, Description: Precision
#DesignerProperty: Key: floatPrecision, DisplayName: FloatPrecision, FieldType: String, DefaultValue: 16, Description: floatPrecision
#DesignerProperty: Key: PutOnlyUsedFonts, DisplayName: PutOnlyUsedFonts, FieldType: Boolean, DefaultValue: False, Description: PutOnlyUsedFonts
#DesignerProperty: Key: Unit, DisplayName: Unit, FieldType: String, DefaultValue: mm, Description: Unit, List: cm|in|m|mm|pt|px
#DesignerProperty: Key: UserUnit, DisplayName: UserUnit, FieldType: String, DefaultValue: 1.0, Description: UserUnit
#DesignerProperty: Key: OutputType, DisplayName: OutputType, FieldType: String, DefaultValue: dataurl, Description: OutputType, List: arraybuffer|blob|bloburi|bloburl|datauristring|dataurlstring|datauri|dataurl|dataurlnewwindow|pdfobjectnewwindow|pdfjsnewwindow

Sub Class_Globals 
    Private BANano As BANano 'ignore 
	Private mName As String 'ignore 
	Private mEventName As String 'ignore 
	Private mCallBack As Object 'ignore
	Private mElement As BANanoElement 'ignore 
	Private bCompress As Boolean
	Private sFileName As String
	Private sFontName As String
	Private sFontSize As String
	Private sFontStyle As String
	Private sLineHeight As String
	Private sMarginBottom As String
	Private sMarginLeft As String
	Private sMarginRight As String
	Private sMarginTop As String
	Private sOrientation As String
	Private sOwnerPassword As String
	Private bPageNumbers As Boolean
	Private sPageSize As String
	Private bPermissionAnnotForms As Boolean
	Private bPermissionCopy As Boolean
	Private bPermissionModify As Boolean
	Private bPermissionPrint As Boolean
	Private sPrecision As String
	Private bPutOnlyUsedFonts As Boolean
	Private sTitle As String
	Private sUnit As String
	Private sUserPassword As String
	Private sUserUnit As String
	Private mTarget As BANanoElement 'ignore 
	Public pdf As BANanoJSPDF
	Public VElement As BAElement 
	Private sfloatPrecision As String
	Private sFontWeight As String
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
	'
	Dim pdfr As BANanoObject = BANano.Window.GetField("jspdf").GetField("jsPDF")
	BANano.Window.SetField("jsPDF", pdfr)
End Sub

Sub DesignerCreateView (Target As BANanoElement, Props As Map) 
	mTarget = Target 
	If Props <> Null Then 
		bCompress = Props.GetDefault("Compress", False)
		sFileName = Props.GetDefault("FileName", "bvad3pdf1")
		sFontName = Props.GetDefault("FontName", "")
		sFontSize = Props.GetDefault("FontSize", "")
		sFontStyle = Props.GetDefault("FontStyle", "none")
		sLineHeight = Props.GetDefault("LineHeight", "")
		sMarginBottom = Props.GetDefault("MarginBottom", "0")
		sMarginLeft = Props.GetDefault("MarginLeft", "0")
		sMarginRight = Props.GetDefault("MarginRight", "0")
		sMarginTop = Props.GetDefault("MarginTop", "0")
		sOrientation = Props.GetDefault("Orientation", "potrait")
		sOwnerPassword = Props.GetDefault("OwnerPassword", "")
		bPageNumbers = Props.GetDefault("PageNumbers", False)
		sPageSize = Props.GetDefault("PageSize", "a4")
		bPermissionAnnotForms = Props.GetDefault("PermissionAnnotForms", False)
		bPermissionCopy = Props.GetDefault("PermissionCopy", False)
		bPermissionModify = Props.GetDefault("PermissionModify", False)
		bPermissionPrint = Props.GetDefault("PermissionPrint", False)
		sPrecision = Props.GetDefault("Precision", "16")
		bPutOnlyUsedFonts = Props.GetDefault("PutOnlyUsedFonts", False)
		sTitle = Props.GetDefault("Title", "")
		sUnit = Props.GetDefault("Unit", "mm")
		sUserPassword = Props.GetDefault("UserPassword", "")
		sUserUnit = Props.GetDefault("UserUnit", "1.0")
		sfloatPrecision = Props.GetDefault("floatPrecision", "16")
		sFontWeight = Props.GetDefault("FontWeight", "normal")
		sZoom = Props.GetDefault("Zoom", "")
		sLayout = Props.GetDefault("Layout", "")
		sPMode = Props.GetDefault("PMode", "")
		sDataTextColor = Props.GetDefault("DataTextColor", "0; 0; 0")
	End If 
	'
	'create an invisible div
	If BANano.Exists($"#${mName}"$) Then 
		mElement = BANano.GetElement($"#${mName}"$) 
	Else	 
		mElement = mTarget.Append($"<div id="${mName}"></div>"$).Get("#" & mName) 
	End If 
	VElement.Initialize(mCallBack, mName, mName) 
	VElement.AddStyle("display", "none")
End Sub

Sub getID As String
	Return mName
End Sub

'the target for this document
Sub getHere As String
	Return $"#${mName}"$
End Sub

'prepare the document, we can add fonts
Sub Ready
	If sFontStyle = "none" Then sFontStyle = ""
	'initialize the class and do something
	pdf.Initialize(mCallBack, sFileName)
	pdf.Margin.top = BANano.parseInt(sMarginTop)
	pdf.Margin.left  = BANano.parseInt(sMarginTop)
	pdf.Margin.right = BANano.parseInt(sMarginRight)
	pdf.Margin.bottom = BANano.parseInt(sMarginBottom)
	'
	pdf.floatPrecision = BANano.parseint(sfloatPrecision)
	pdf.SetUserPassword(sUserPassword)
	pdf.compress = bCompress
	pdf.Orientation = sOrientation
	pdf.SetOwnerPassword(sOwnerPassword)
	pdf.PageSize = sPageSize
	If bPermissionPrint Then pdf.CanPrint		
	If bPermissionModify Then pdf.CanModify
	If bPermissionCopy Then pdf.CanCopy
	If bPermissionAnnotForms Then pdf.CanAnnotForms
	pdf.putOnlyUsedFonts = bPutOnlyUsedFonts
	pdf.Precision = BANano.parseInt(sPrecision)
	pdf.Unit = sUnit
	pdf.userUnit = BANano.parseFloat(sUserUnit)
	pdf.Title = sTitle
	pdf.Start
	pdf.setDisplayMode(sZoom, sLayout, sPMode)
End Sub

'addFont
Sub addFont(url As String, fontName As String, fontType As String)
	Try
		pdf.addFont(url, fontName, fontType)
	Catch
		Log(LastException)
	End Try		
End Sub

'build the document
Sub Go
	'pdf.SetFontType(sFontStyle)
	pdf.SetFontStyleWeight(sFontName, sFontStyle, sFontWeight)
	'pdf.SetFontStyle(sFontStyle)
	pdf.SetFontSize(sFontSize)
	pdf.SetTextColor(sDataTextColor)
	
	'get the pdf document
	Dim doc As BANanoElement
	doc.Initialize(getHere)
	'pre import images
	pdf.ClearImages
	'
	'Dim bDone As Boolean = BANano.Await(pdf.BEScanImages(doc))
	'Log(bDone)
	
	pdf.BEToPageChildren(doc)
	'add page numbers
	If bPageNumbers Then
		pdf.SetPageNumbers
	End If
End Sub

'after adding other elements
Sub Save
	pdf.Save
End Sub

'get base 64 that you can view
Sub ToViewer As String
	Dim res As String = pdf.ToBase64
	Return res
End Sub

'return the data url
Sub DataURL As String
	Return pdf.DataURL
End Sub