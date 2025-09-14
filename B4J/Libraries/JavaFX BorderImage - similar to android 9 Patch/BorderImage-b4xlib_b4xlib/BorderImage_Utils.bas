B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.9
@EndOfDesignText@
'Static code module
Sub Process_Globals
	'The image Is tiled (repeated) To fill the area.
	Public Const REPEAT_REPEAT As String = "REPEAT"
	'The image Is tiled (repeated) And rescaled (If necessary) To fill the area with a whole number of tiles.
	Public Const REPEAT_ROUND As String = "ROUND"
	'The image Is tiled (repeated) To fill the area with a whole number of tiles, And any extra space Is distributed around the tiles.
	Public Const REPEAT_SPACE As String = "SPACE"
	'The image Is stretched To fill the area.
	Public Const REPEAT_STRETCH As String = "STRETCH"
End Sub

'Uses the default repeat values REPEAT_STRETCH and Filled = False
'Widths - The width of the drawn border
'Insets - Distance from the edge the border is drawn
'Slices - size of the image slices.
'There are more options if you define them yourself and call NewBorderImage4
Public Sub NewBorderImage(TImage As Image, Widths As Double, Insets As Double, Slices As Double) As BorderImage
	
	Dim TObj As BorderImage
	TObj.Initialize(TImage, _
	BorderWidths_Utils.NewBorderWidths3(Widths), _
	BorderImageInsets_Utils.NewInsets2(Insets), _
	BorderWidths_Utils.NewBorderWidths3(Slices), _
	False,REPEAT_STRETCH,REPEAT_STRETCH)
	Return TObj
End Sub

'Uses the default repeat values REPEAT_STRETCH
'Uses the default repeat values REPEAT_STRETCH and Filled = False
'Widths - The width of the drawn border
'Insets - Distance from the edge the border is drawn
'Slices - size of the image slices.
'Filled - Whether to display the center of the image or discard it.
'There are more options if you define them yourself and call NewBorderImage4
Public Sub NewBorderImage2(TImage As Image, Widths As Double, Insets As Double, Slices As Double, Filled As Boolean) As BorderImage
	
	Dim TObj As BorderImage
	TObj.Initialize(TImage, _
	BorderWidths_Utils.NewBorderWidths3(Widths), _
	BorderImageInsets_Utils.NewInsets2(Insets), _
	BorderWidths_Utils.NewBorderWidths3(Slices), _
	Filled,REPEAT_STRETCH,REPEAT_STRETCH)
	Return TObj
End Sub

'Uses the default repeat values REPEAT_STRETCH
'Uses the default repeat values REPEAT_STRETCH and Filled = False
'Widths - The width of the drawn border
'Insets - Distance from the edge the border is drawn
'Slices - size of the image slices.
'Filled - Whether to display the center of the image or discard it.
'There are more options if you define them yourself and call NewBorderImage4
'The repeat values are one of the BorderImage_Utils REPEAT Constants
Public Sub NewBorderImage3(TImage As Image, Widths As Double, Insets As Double, Slices As Double, Filled As Boolean,RepeatX As String, RepeatY As String) As BorderImage
	
	Dim TObj As BorderImage
	TObj.Initialize(TImage, _
	BorderWidths_Utils.NewBorderWidths3(Widths), _
	BorderImageInsets_Utils.NewInsets2(Insets), _
	BorderWidths_Utils.NewBorderWidths3(Slices), _
	Filled,RepeatX,RepeatY)
	Return TObj
End Sub

'Uses the default repeat values REPEAT_STRETCH
'Uses the default repeat values REPEAT_STRETCH and Filled = False
'Widths - The width of the drawn border
'Insets - Distance from the edge the border is drawn
'Slices - size of the image slices.
'Filled - Whether to display the center of the image or discard it.
'The repeat values are one of the BorderImage_Utils REPEAT Constants
Public Sub NewBorderImage4(TImage As Image, Widths As BorderWidths, Insets As BorderImageInsets, Slices As BorderWidths, Filled As Boolean, RepeatX As String, RepeatY As String) As BorderImage
	Dim TObj As BorderImage
	TObj.Initialize(TImage,Widths,Insets,Slices,Filled,RepeatX,RepeatY)
	Return TObj
End Sub

Public Sub RemoveCSS(N As Node, CSSElement As String) As String
	
	Dim Elements() As String = Regex.Split(";",N.Style)
	Dim Style As String
	Dim L As List
	L.Initialize
	For Each E As String In Elements
		If E.Contains(CSSElement) Then Continue
		L.Add(E)
	Next
	
	'Avoids the need to initialiseStatic with String Class.
	Dim StringClass As JavaObject = ""											'ignore
	Style = StringClass.RunMethod("join",Array(";",L))
	Return Style
End Sub

'Border images has to be a list as you can add more than one border.  
'You can pass an object array instead of alist
'<code>Setborder(N,Array(Bimg))</code>
'This sub will remove any border settings from the Nodes Style attribute.
Public Sub SetBorder(N As Node,BorderImages As List)
	'Need to remove references to border styles in the node Style string
	N.Style = RemoveCSS(N,"border")
	'Attach the Border to the Node
	Dim NJO As JavaObject = N
	Dim L As List = UnWrapList(BorderImages)
	Dim B As JavaObject
	B.InitializeNewInstance("javafx.scene.layout.Border",Array(Null,L))
	NJO.RunMethod("setBorder",Array(B))
End Sub

Private Sub UnWrapList(L As List) As List
	For i = 0 To L.Size - 1
		If L.Get(i) <> Null Then L.Set(i,CallSub(L.Get(i),"GetObject"))
	Next
	Return L
End Sub