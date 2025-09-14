B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
Sub Class_Globals
	
	Private DEFAULT_QUALITY 								As Int = 10
	Private DEFAULT_IGNORE_WHITE 							As Boolean= True

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

' Use the median cut algorithm to determin the dominant colour in the image.

Public Sub getDominantColor(sourceImage As B4XBitmap) As ARGBColor
	
	Dim palette As Map
	palette.Initialize
	
	palette = getPalette(sourceImage, 5)
	
	If palette.Size = 0 Then
		Return Null
	End If
	
	Dim dominantColor As ARGBColor = palette.Get(0)
	Return dominantColor
End Sub

' Use the median cut algorithm to determin the dominant colour in the image.

Public Sub getDominantColor2(sourceImage As BitmapCreator, quality As Int, ignoreWhite As Boolean)  As ARGBColor
    
	Dim palette As Map
	palette.Initialize
	
	palette = getPalette2(sourceImage, 5, quality, ignoreWhite)
    
	If palette.Size=0 Then
		Return Null
	End If

	Dim dominantColor As ARGBColor = palette.Get(0)
	Return dominantColor

End Sub


' Use the median cut algorithm To cluster similar colors.

Public Sub getPalette(sourceImage As B4XBitmap, colorCount As Int) As Map
	
    Dim ccmap As CMap = getColorMap(sourceImage, colorCount)
    If ccmap .IsInitialized = False Then Return Null

    Return ccmap.palette
End Sub

' Use the median cut algorithm To cluster similar colors.
 
Public Sub getPalette2(sourceImage As BitmapCreator, colorCount As Int, quality As Int, ignoreWhite As Boolean) As Map

    Dim ccmap As CMap = getColorMap2(sourceImage, colorCount, quality, ignoreWhite)
    
    If ccmap.IsInitialized = False Then Return Null

    Return ccmap.palette
End Sub

' Use the median cut algorithm To cluster similar colors.

Public Sub getColorMap(sourceImage As B4XBitmap, colorCount As Int) As CMap
	
	Dim bc As BitmapCreator
	bc.Initialize (300,300)
	bc.CopyPixelsFromBitmap (sourceImage)
	
    Return getColorMap2(bc, colorCount, DEFAULT_QUALITY, DEFAULT_IGNORE_WHITE)
End Sub

' Use the median cut algorithm To cluster similar colors.
 
 Public Sub getColorMap2(sourceImage As BitmapCreator, colorCount As Int, quality As Int, ignoreWhite As Boolean) As CMap

	Dim pixels As List = getPixels(sourceImage, DEFAULT_QUALITY,True)
	
	' Send Array To quantize function which clusters values using median cut algorithm
	Dim ccmap As CMap 
	ccmap.Initialize
	
	ccmap = ccmap.quantize(pixels, colorCount)
	
	Return ccmap
	
End Sub

Private Sub getPixels (sourceImage As BitmapCreator, quality As Int , ignoreWhite As Boolean) As List
        
	Dim width As Int = sourceImage.mWidth
	Dim height As Int = sourceImage.mHeight
	Dim pixelCount As Int = width * height
	Dim numUsedPixels As Int 
	Dim i As Int
	Dim res As List			:		res.Initialize
	
	For i = 0 To pixelCount -1 Step quality

		Dim col As Int
				
		Dim row As Int = i / width
		If row = height Then row = height - 1
		col = (i - width * row)
		
		If col = width Then col = width -1

		Dim ar As ARGBColor
		ar.Initialize

		sourceImage.GetARGB (col, row, ar)

		If (ignoreWhite And ar.r > 250 And ar.g > 250 And ar.b > 250) = False Then
			res.Add (ar)
			numUsedPixels = numUsedPixels + 1
		End If

		If ignoreWhite = False Then
			res.Add (ar)
			numUsedPixels = numUsedPixels + 1
		End If
		
	Next
	
	Return res
	
End Sub


