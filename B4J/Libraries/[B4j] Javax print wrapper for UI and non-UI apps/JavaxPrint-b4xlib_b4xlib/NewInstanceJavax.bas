B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals

End Sub

Public Sub DocFlavor_STRING(MimeType As String) As DocFlavor_STRING
	Dim DF As DocFlavor_STRING
	DF.Initialize
	DF.Create(MimeType)
	Return DF
End Sub

Public Sub DocFlavor_SERVICE_FORMATTED(ClassName As String) As DocFlavor_SERVICE_FORMATTED
	Dim DF As DocFlavor_SERVICE_FORMATTED
	DF.Initialize
	DF.Create(ClassName)
	Return DF
End Sub

Public Sub SimpleDoc(PrintData As Object, Flavor As Object, Atts As Object) As SimpleDoc
	Dim TObj As SimpleDoc
	TObj.Initialize
	TObj.Create(PrintData,Flavor,Atts)
	Return TObj
End Sub

Public Sub DocAttributeSet As DocAttributeSet
	Dim DAB As DocAttributeSet
	DAB.Initialize
	Return DAB
End Sub

Public Sub Paper As Paper
	Dim P As Paper
	P.Initialize
	Return P	
End Sub

Public Sub PrintRequestAttributeSet As PrintRequestAttributeSet
	Dim PRA As PrintRequestAttributeSet
	PRA.Initialize
	Return PRA
End Sub

Public Sub PrintServiceAttributeSet As PrintServiceAttributeSet
	Dim PSA As PrintServiceAttributeSet
	PSA.Initialize
	Return PSA
End Sub

Public Sub PrintJobAttributeSet As PrintJobAttributeSet
	Dim PJA As PrintJobAttributeSet
	PJA.Initialize
	Return PJA
End Sub

Public Sub Printable(CallBack As Object,EventName As String) As Object
	Dim P As Printable
	Return P.Initialize(CallBack,EventName)
End Sub

'Creates an opaque sRGB AWTColor with the specified combined RGB value consisting of the red component in bits 16-23, the green component in bits 8-15, and the blue component in bits 0-7.
Public Sub AWTColor(Rgb As Int) As AWTColor
	Dim TObj As AWTColor
	TObj.Initialize
	TObj.Create(Rgb)
	Return TObj
End Sub

'Creates an sRGB color with the specified combined RGBA value consisting of the alpha component in bits 24-31, the red component in bits 16-23, the green component in bits 8-15, and the blue component in bits 0-7.
Public Sub AWTColor2(aRgb As Int, Hasalpha As Boolean) As AWTColor
	Dim TObj As AWTColor
	TObj.Initialize
	TObj.Create2(aRgb,Hasalpha)
	Return TObj
End Sub

'Creates an sRGB AWTColor with the specified red, green, blue, and alpha values in the range (0.0 - 1.0).
Public Sub AWTColor3(R As Float, G As Float, B As Float, A As Float) As AWTColor
	Dim TObj As AWTColor
	TObj.Initialize
	TObj.Create4(R,G,B,A)
	Return TObj
End Sub

'Creates an opaque sRGB AWTColor with the specified red, green, and blue values in the range (0 - 255).
Public Sub AWTColor4(R As Int, G As Int, B As Int) As AWTColor
	Dim TObj As AWTColor
	TObj.Initialize
	TObj.Create5(R,G,B)
	Return TObj
End Sub

'NewInstanceJavax.Font(AWTFont_Styles.SERIF,AWTFont_Styles.PLAIN,12)
Public Sub Font(Name As String, Style As Int, Size As Int) As AWTFont
	Dim tFont As AWTFont
	tFont.Initialize
	tFont.Create(Name,Style,Size)
	Return tFont
End Sub

Public Sub JTextArea As jTextArea
	Dim TJo As jTextArea
	TJo.Initialize
	Return TJo
End Sub

'Units should be on of the attributes.Size2DSyntax values
Public Sub MediaSize(X As Float, Y As Float, Units As Int) As Attribute
	Dim Jo As JavaObject
	Jo.InitializeNewInstance("javax.print.attribute.standard.MediaSize",Array(X,Y,Units))
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Wrapper.SetObject(Jo)
	Return Wrapper
End Sub