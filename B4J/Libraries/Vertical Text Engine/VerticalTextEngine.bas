B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private previousText As String
	Private previousLines As List
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

End Sub

Public Sub Draw(text As String,f As Font,color As Paint,wordspace As Int,linespace As Int,wrap As Boolean,boxWidth As Int,boxHeight As Int) As B4XBitmap
	Dim emptyPane As Pane
	emptyPane.Initialize("")
	Dim cvs1 As B4XCanvas
	cvs1.Initialize(emptyPane)
	Dim fixedRect As B4XRect=cvs1.MeasureText("鹅",f)
	
	Dim lines As List
	If text=previousText And text<>"" Then
		lines=previousLines
	Else
		lines.Initialize
		For Each line As String In Regex.Split("\n",text)
			Dim textImages As List
			textImages.Initialize
			Dim nums As StringBuilder
			nums.Initialize
			For i=0 To line.Length-1
				Dim c As String=line.CharAt(i)
				If IsNumber(c) And i<line.Length-1 Then
					nums.Append(c)
				Else
					If nums.ToString<>"" Then
						If nums.ToString.Length>1 Then
							textImages.Add(MergedCharacters(nums.ToString,f,fixedRect.Width,fixedRect.Height,linespace,wordspace))
						Else
							textImages.Add(Text2Image(nums.ToString,f,color,wordspace,linespace,True,True,fixedRect))
						End If
					End If
					nums.Initialize
					textImages.Add(Text2Image(c,f,color,wordspace,linespace,True,True,fixedRect))
				End If
			Next
			lines.Add(textImages)
		Next
		previousLines=lines
		previousText=text
	End If
	
	If wrap Then
		lines=WrapText(lines,boxHeight)
	End If
	Dim width,height As Int
	Dim WHs As List
	Dim result As Map=GetWidthAndHeight(lines)
	width=result.Get("width")
	height=result.Get("height")
	WHs=result.Get("WHs")
	
	Dim bc As BitmapCreator
	bc.Initialize(width,height)
	Dim lineNum As Int=0
	Dim previousWidth As Int
	For Each textImages As List In lines
		Dim WH As Map=WHs.Get(lineNum)
		lineNum=lineNum+1
		previousWidth=previousWidth+WH.Get("width")
		Dim X As Double=width-previousWidth
		Dim Y As Double=0
		Dim index As Int=0
		For Each img As B4XBitmap In textImages
			Y=(fixedRect.Height+wordspace)*index
			Dim r As B4XRect
			r.Initialize(X,Y,X+img.Width,Y+img.Height)
			bc.DrawBitmap(img,r,True)
			index=index+1
		Next
		
	Next
	Return bc.Bitmap
End Sub

Sub GetWidthAndHeight(lines As List) As Map
	Dim result As Map
	result.Initialize
	Dim width,height As Int
	Dim WHs As List
	WHs.Initialize
	For Each textImages As List In lines
		Dim WH As Map
		WH.Initialize
		Dim lineHeight As Int
		Dim lineWidth As Int
		For Each textImage As B4XBitmap In textImages
			lineHeight=lineHeight+textImage.Height
			lineWidth=Max(lineWidth,textImage.Width)
		Next
		width=width+lineWidth
		height=Max(lineHeight,height)
		WH.Put("width",lineWidth)
		WH.Put("height",lineHeight)
		WHs.InsertAt(0,WH)
	Next
	result.Put("width",width)
	result.Put("height",height)
	result.Put("WHs",WHs)
	Return result
End Sub

Sub WrapText(lines As List,boxHeight As Int) As List
	Dim newLines As List
	newLines.Initialize
	For i=0 To lines.Size-1
		Dim textImages As List=lines.Get(i)
		Dim splitedLines As List
		splitedLines.Initialize
		Dim heightSum As Int
		Dim index As Int=0
		Dim nextStartIndex As Int=0
		For Each img As B4XBitmap In textImages
			heightSum=img.Height+heightSum
			If heightSum>boxHeight-img.Height*2/3 Then
				Dim imgs As List
				imgs.Initialize
				For j=nextStartIndex To index
					imgs.Add(textImages.Get(j))
				Next
				splitedLines.Add(imgs)
				nextStartIndex=index+1
				heightSum=0
			End If
			index=index+1
		Next
		
		If nextStartIndex<=textImages.Size-1 Then
			Dim imgs As List
			imgs.Initialize
			For j=nextStartIndex To textImages.Size-1
				imgs.Add(textImages.Get(j))
			Next
			splitedLines.Add(imgs)
		End If
		newLines.AddAll(splitedLines)
	Next
	Return newLines
End Sub

Sub Text2Image(s As String,f As Font,color As Paint,wordspace As Int,linespace As Int,fixedHeight As Boolean,fixedWidth As Boolean,fixedRect As B4XRect) As B4XBitmap
	Dim emptyPane As Pane
	emptyPane.Initialize("")
	Dim cvs1 As B4XCanvas
	cvs1.Initialize(emptyPane)
	Dim r As B4XRect=cvs1.MeasureText(s,f)
	Dim width,height As Double
	If fixedWidth Then
		width=fixedRect.Width
	Else
		width=r.Width
	End If
	If fixedHeight Then
		height=fixedRect.Height
	Else
		height=r.Height
	End If
	
	Dim X,Y As Double
	X=0
	Y=height

	
	Dim Canvas1 As Canvas
	Canvas1.Initialize("")
	Canvas1.SetSize(width+linespace,height+wordspace)
	Dim alignment As String="LEFT"

	If CharIsCenterAlignedPunctuation(s) Then
		X=r.CenterX
	Else if CharIsRightAlignedPunctuation(s) Then
		X=width-r.Width
		Y=r.Height
		'alignment="RIGHT"
	End If
	If CharNeedRotation(s) Then
		If CharIsCenterAlignedPunctuation(s) Then
			X=r.Width/2-Abs(r.Top/2)
			Canvas1.DrawTextRotated(s,X,Y,f,color,"RIGHT",90)
		Else
			Canvas1.DrawTextRotated(s,X,Y,f,color,alignment,-90)
		End If
	Else
		If fixedHeight=True And fixedWidth=False Then 'character
			Y=fixedRect.Height+linespace
			X=0
		End If
		Canvas1.DrawText(s,X,y,f,color,"LEFT")
	End If
	Return Canvas1.Snapshot2(fx.Colors.Transparent)
End Sub

Sub CharNeedRotation(c As String) As Boolean
	Return Regex.IsMatch("[…—]",c)
End Sub

Sub CharIsCenterAlignedPunctuation(c As String) As Boolean
	Return Regex.IsMatch("[\!\?！？…—⋮0-9a-zA-Z]",c)
End Sub

Sub CharIsRightAlignedPunctuation(c As String) As Boolean
	Return Regex.IsMatch("[\.,。，、]",c)
End Sub

Public Sub MergedCharacters(s As String,f As Font,width As Int,height As Int,lineSpace As Int,wordSpace As Int) As B4XBitmap
	Dim bc As BitmapCreator
	bc.Initialize(width+lineSpace,height+wordSpace)
	Dim innerSpace As Int=0
	Dim leftOffset As Int=s.Length*innerSpace
	Dim cvs1 As B4XCanvas=CreateB4XCanvas
	For i=0 To s.Length-1
		Dim c As String=s.CharAt(i)
		Dim r As B4XRect=cvs1.MeasureText(c,f)
		Dim fixedRect As B4XRect
		fixedRect.Initialize(0,0,r.Width,height)
		Dim img As B4XBitmap=Text2Image(c,f,fx.Colors.Black,0,0,True,False,fixedRect)
		Dim rect As B4XRect
		Dim numWidth As Double=width/s.Length
		rect.Initialize(numWidth*i+leftOffset,innerSpace,numWidth*i+numWidth-innerSpace,img.Height)
		bc.DrawBitmap(img,rect,True)
	Next
	Return bc.Bitmap
End Sub

Sub CreateB4XCanvas As B4XCanvas
	Dim emptyPane As Pane
	emptyPane.Initialize("")
	Dim cvs1 As B4XCanvas
	cvs1.Initialize(emptyPane)
	Return cvs1
End Sub

