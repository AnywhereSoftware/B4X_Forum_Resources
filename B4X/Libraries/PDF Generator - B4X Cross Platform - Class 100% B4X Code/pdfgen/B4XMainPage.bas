B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	#if B4J
		Private fx As JFX	
	#end if
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	xui.SetDataFolder("B4Xpdf")
	'copy images from assets folder to default folder
	File.Copy(File.DirAssets,"image.png",xui.DefaultFolder,"image.png")
	File.Copy(File.DirAssets,"image.jpg",xui.DefaultFolder,"image.jpg")
	File.Copy(File.DirAssets,"image.bmp",xui.DefaultFolder,"image.bmp")
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub fButtonHelloWord_Click
	Dim pdf As cPDF
	'initialize with mm unit
	pdf.Initialize("mm")
	
	'set properties
	pdf.sProperty(pdf.PropertyAuthor,"spsp"). _
	    sProperty(pdf.PropertyTitle,"Hello world"). _
		sProperty(pdf.PropertyKeywords,"B4X,PDF,Cross platform")
	
	'add a page
	pdf.pageAdd(pdf.pageSizeA4PortraitWidth,pdf.pageSizeA4PortraitHeight)

	'all combinations of font normal, bold,italic,underline and strikethrough
	For s=0 To 15
		'select a font
		pdf.sFont(pdf.fontHelvetica,s,30,pdf.colorBlack)
		'draw a text at position 20 (from left) and 277 (from bottom)
		pdf.outtext(20,277-s*15,"Hello world!")
	Next
	
	'save to file with compression if data compressed are smaller
	savePDF(pdf,"test.pdf",pdf.CompressAlways)
	
	'open with default viewer
	openPDF("test.pdf")
End Sub

Private Sub fButtonFonts_Click
	Dim pdf As cPDF
	Dim bc As ByteConverter
	Dim b(1) As Byte
	
	'initialize with mm unit
	pdf.Initialize("mm")

	'set properties
	pdf.sProperty(pdf.PropertyAuthor,"spsp"). _
	    sProperty(pdf.PropertyTitle,"Fonts available"). _
		sProperty(pdf.PropertyKeywords,"B4X,PDF,Cross platform")

	For i=0 To 4
		'add a page
		pdf.pageAdd(pdf.pageSizeA4PortraitWidth,pdf.pageSizeA4PortraitHeight)
		Dim f As String=Array As String(pdf.fontCourier,pdf.fontHelvetica,pdf.fontSymbol,pdf.fontTimes,pdf.fontZapfdingbats)(i)
		pdf.sFont(pdf.fontHelvetica,pdf.fontBold+pdf.fontUnderline,20,pdf.colorBlack)
		pdf.outtext(20,277,f)
		pdf.sFont(f,pdf.fontNormal,18,pdf.colorBlack)

		'iterate over chars 32..255 (0..31 are empty)
		For r=2 To 15
			For c=0 To 15

				If r=2 Then
					pdf.sFont(pdf.fontHelvetica,pdf.fontBold,18,pdf.colorBlack)
					b(0)=c
					pdf.outtext(20+c*10,257,bc.HexFromBytes(b))
					pdf.sFont(f,pdf.fontNormal,18,pdf.colorBlack)
				End If

				If c=0 Then
					pdf.sFont(pdf.fontHelvetica,pdf.fontBold,18,pdf.colorBlack)
					b(0)=r
					pdf.outtext(10,267-r*10,bc.HexFromBytes(b))
					pdf.sFont(f,pdf.fontNormal,18,pdf.colorBlack)
				End If

				'draw a text at position 20 (from left) and 277 (from bottom)
				pdf.outtext(20+c*10,267-r*10,Chr(r*16+c))
			Next
		Next
	Next

	'save to file with compression if data compressed are smaller
	savePDF(pdf,"test.pdf",pdf.CompressAlways)
	
	'open with default viewer
	openPDF("test.pdf")
End Sub

Private Sub fButtonLineRectangle_Click
	Dim pdf As cPDF
	'initialize with mm unit
	pdf.Initialize("mm")

	'set properties
	pdf.sProperty(pdf.PropertyAuthor,"spsp"). _
	    sProperty(pdf.PropertyTitle,"Lines and rectangles"). _
		sProperty(pdf.PropertyKeywords,"B4X,PDF,Cross platform")

	'add a page
	pdf.pageAdd(pdf.pageSizeA4PortraitWidth,pdf.pageSizeA4PortraitHeight)
	
	'set draw width and draw color (rgb from 0 to 1)
	pdf.sDrawWidth(5).sDrawColor(Array As Double(0.75,0.10,0.20))
	'draw 2 diagonales lines on the page
	pdf.outLine(0,297,210,0).outLine(210,297,0,0)
	
	pdf.sFont(pdf.fontHelvetica,pdf.fontNormal,30,Array As Double(0,0,0))
	pdf.outText(50,277,"Lines and rectangles")
	
	'set fill color, draw with and draw color
	pdf.sFillColor(pdf.colorBlue).sDrawWidth(1).sDrawColor(pdf.colorGreen)
	'draw 3 rectangles (border only, fill only, border and fill)
	pdf.outRectangle(10,130,50,30,pdf.RectangleBorderOnly)
	pdf.outRectangle(150,130,50,30,pdf.RectangleFillOnly)
	pdf.outRectangle(80,40,50,50,pdf.RectangleBorderAndFill)

	pdf.outText(50,20,"border, fill and both")

	'save to file with compression if data compressed are smaller
	savePDF(pdf,"test.pdf",pdf.CompressNEver)
	
	'open with default viewer
	openPDF("test.pdf")
End Sub


Private Sub fButtonImages_Click
	Dim pdf As cPDF
	'initialize with mm unit
	pdf.Initialize("mm")

	'set properties
	pdf.sProperty(pdf.PropertyAuthor,"spsp"). _
	    sProperty(pdf.PropertyTitle,"Images"). _
		sProperty(pdf.PropertyKeywords,"B4X,PDF,Cross platform")

	'add a page
	pdf.pageAdd(pdf.pageSizeA4PortraitWidth,pdf.pageSizeA4PortraitHeight)
	
	'select a font
	pdf.sFont(pdf.fontTimes,pdf.fontBold,16,pdf.colorBlack)
	
	'draw image with specific width and automatic height
	pdf.outImage(xui.DefaultFolder,"image.jpg",10,220,70,0)
	pdf.outText(10,210,"JPG - explicit width and height automatic (no distorsion)")
	
	'draw image with specific height and automatic width
	pdf.outImage(xui.DefaultFolder,"image.bmp",10,160,0,30)
	pdf.outText(10,150,"BMP - explicit height and width automatic (no distorsion)")

	'draw image with specific width and height
	pdf.outImage(xui.DefaultFolder,"image.png",10,100,30,30)
	pdf.outText(10,90,"PNG - explicit width and height (with distorsion)")

	'save to file with compression if data compressed are smaller
	savePDF(pdf,"test.pdf",pdf.CompressAlways)
	
	'open with default viewer
	openPDF("test.pdf")
End Sub

Private Sub fButtonRaw_Click
	Dim pdf As cPDF
	'initialize with mm unit
	pdf.Initialize("mm")

	'set properties
	pdf.sProperty(pdf.PropertyAuthor,"spsp"). _
	    sProperty(pdf.PropertyTitle,"Raw"). _
		sProperty(pdf.PropertyKeywords,"B4X,PDF,Cross platform")

	'add a page
	pdf.pageAdd(pdf.pageSizeA4PortraitWidth,pdf.pageSizeA4PortraitHeight)
	
	'select a font
	pdf.sFont(pdf.fontTimes,pdf.fontBold,20,pdf.colorBlack)
	pdf.outText(10,277,"outRaw allows to use PDF commands directly")
	pdf.sFont(pdf.fontTimes,pdf.fontNormal,12,pdf.colorBlack)
	pdf.outText(10,267,"https://opensource.adobe.com/dc-acrobat-sdk-docs/standards/pdfstandards/pdf/PDF32000_2008.pdf")
	
	'set the draw width to 1mm
	pdf.sDrawWidth(1)
	
	'set the draw color to blue
	pdf.outRaw($"0.0 0.0 1.0 RG"$)

	'set the fill color to red
	pdf.outRaw($"1.0 0.0 0.0 rg"$)

	'draw a triangle
	'start point (command m) : 20 260 m
	'line to (command l) : 60,240 l
	'line to (command l) : 20,220 l
	'close fill and stroke the path (command b)
	pdf.outRaw($"20 260 m 100 260 l 60 220 l b"$)
	
	'draw a bezier curve
	'start point (command m) : 15 150 m
	'control point 1, control point 2, end point (command c) and close path (command S) : 75 200 135 100 195,150 c S
	pdf.outRaw($"15 150 m 75 200 135 100 195 150 c S"$)
	
	'set the fill color to green
	pdf.outRaw($"0.0 1.0 0.0 rg"$)

	'draw 10 line with random points and fill the path
	Dim s As String
	For i=0 To 9
		s=s & Rnd(20,190) & " " & Rnd(80,120) & " " & IIf(i=0,"m ","l ")
	Next
	s=s & "b"
	pdf.outRaw(s)

	'save to file with compression if data compressed are smaller
	savePDF(pdf,"test.pdf",pdf.CompressNever)
	
	'open with default viewer
	openPDF("test.pdf")
End Sub

Private Sub fButtonMultilineText_Click
	Dim pdf As cPDF
	'initialize with mm unit
	pdf.Initialize("mm")
	
	'set properties
	pdf.sProperty(pdf.PropertyAuthor,"spsp"). _
	    sProperty(pdf.PropertyTitle,"Multi line text"). _
		sProperty(pdf.PropertyKeywords,"B4X,PDF,Cross platform")
	
	'add a page
	pdf.pageAdd(pdf.pageSizeA4PortraitWidth,pdf.pageSizeA4PortraitHeight)

	'set current position 10mm from the left, 287mm from the bottom
	pdf.sx(0).sY(287)

	Dim s As String

	s=$"Left align text with automatic and explicit CR.
Altera sententia est, quae definit amicitiam paribus officiis ac voluntatibus. Hoc quidem est nimis exigue et exiliter ad calculos vocare amicitiam, ut par sit ratio acceptorum et datorum. Divitior mihi et affluentior videtur esse vera amicitia nec observare restricte, ne plus reddat quam acceperit; neque enim verendum est, ne quid excidat, aut ne quid in terram defluat, aut ne plus aequo quid in amicitiam congeratur.

Quod cum ita sit, paucae domus studiorum seriis cultibus antea celebratae nunc ludibriis ignaviae torpentis exundant, vocali sonu, perflabili tinnitu fidium resultantes. denique pro philosopho cantor et in locum oratoris doctor artium ludicrarum accitur et bybliothecis sepulcrorum ritu in perpetuum clausis organa fabricantur hydraulica, et lyrae ad speciem carpentorum ingentes tibiaeque et histrionici gestus instrumenta non levia.

"$

	'select a font
	pdf.sFont(pdf.fontHelvetica,pdf.fontNormal,12,pdf.colorBlue)
	'draw flow text between 10 and 200 mm on the page, align left
	pdf.outtextflow(10,200,pdf.AlignLeft,s)



	s=$"Center text with automatic and explicit CR.
Altera sententia est, quae definit amicitiam paribus officiis ac voluntatibus. Hoc quidem est nimis exigue et exiliter ad calculos vocare amicitiam, ut par sit ratio acceptorum et datorum. Divitior mihi et affluentior videtur esse vera amicitia nec observare restricte, ne plus reddat quam acceperit; neque enim verendum est, ne quid excidat, aut ne quid in terram defluat, aut ne plus aequo quid in amicitiam congeratur.

Quod cum ita sit, paucae domus studiorum seriis cultibus antea celebratae nunc ludibriis ignaviae torpentis exundant, vocali sonu, perflabili tinnitu fidium resultantes. denique pro philosopho cantor et in locum oratoris doctor artium ludicrarum accitur et bybliothecis sepulcrorum ritu in perpetuum clausis organa fabricantur hydraulica, et lyrae ad speciem carpentorum ingentes tibiaeque et histrionici gestus instrumenta non levia.

"$

	'select a font
	pdf.sFont(pdf.fontCourier,pdf.fontItalic,12,pdf.colorRed)
	'draw flow text between 10 and 200 mm on the page, align center
	pdf.outtextflow(10,200,pdf.AlignCenter,s)


	s=$"Right text with automatic and explicit CR.
Altera sententia est, quae definit amicitiam paribus officiis ac voluntatibus. Hoc quidem est nimis exigue et exiliter ad calculos vocare amicitiam, ut par sit ratio acceptorum et datorum. Divitior mihi et affluentior videtur esse vera amicitia nec observare restricte, ne plus reddat quam acceperit; neque enim verendum est, ne quid excidat, aut ne quid in terram defluat, aut ne plus aequo quid in amicitiam congeratur.

Quod cum ita sit, paucae domus studiorum seriis cultibus antea celebratae nunc ludibriis ignaviae torpentis exundant, vocali sonu, perflabili tinnitu fidium resultantes. denique pro philosopho cantor et in locum oratoris doctor artium ludicrarum accitur et bybliothecis sepulcrorum ritu in perpetuum clausis organa fabricantur hydraulica, et lyrae ad speciem carpentorum ingentes tibiaeque et histrionici gestus instrumenta non levia.

"$

	'select a font
	pdf.sFont(pdf.fontTimes,pdf.fontbold,12,pdf.colorGreen)
	'draw flow text between 10 and 200 mm on the page, align right
	pdf.outtextflow(10,200,pdf.AlignRight,s)


	s=$"Justify text with automatic and explicit CR.
Altera sententia est, quae definit amicitiam paribus officiis ac voluntatibus. Hoc quidem est nimis exigue et exiliter ad calculos vocare amicitiam, ut par sit ratio acceptorum et datorum. Divitior mihi et affluentior videtur esse vera amicitia nec observare restricte, ne plus reddat quam acceperit; neque enim verendum est, ne quid excidat, aut ne quid in terram defluat, aut ne plus aequo quid in amicitiam congeratur.

Quod cum ita sit, paucae domus studiorum seriis cultibus antea celebratae nunc ludibriis ignaviae torpentis exundant, vocali sonu, perflabili tinnitu fidium resultantes. denique pro philosopho cantor et in locum oratoris doctor artium ludicrarum accitur et bybliothecis sepulcrorum ritu in perpetuum clausis organa fabricantur hydraulica, et lyrae ad speciem carpentorum ingentes tibiaeque et histrionici gestus instrumenta non levia.

"$

	'select a font
	pdf.sFont(pdf.fontTimes,pdf.fontbold,12,pdf.colorGray)
	'draw flow text between 10 and 200 mm on the page, align justify
	pdf.outtextflow(10,200,pdf.AlignJusify,s)
	
	'save to file with compression if data compressed are smaller
	savePDF(pdf,"test.pdf",pdf.CompressAlways)
	
	'open with default viewer
	openPDF("test.pdf")
End Sub

private Sub savePDF(apdf As cPDF,afile As String,acompress As Int)
	Dim folder As String
	#if B4J
		folder=xui.DefaultFolder
	#End If
	#if B4A
		folder=Starter.fFileProvider.SharedFolder	
	#End If
	#if B4I
		'......
	#End If
	apdf.saveToFile(folder,afile,acompress)
End Sub

private Sub openPDF(afile As String)
	#if B4J
		fx.ShowExternalDocument(File.GetUri(xui.DefaultFolder,afile))
	#end if
	#if B4A
		Dim in As Intent
		in.Initialize(in.ACTION_VIEW, "")
		Starter.ffileProvider.SetFileUriAsIntentData(in, afile)
		in.SetComponent("android/com.android.internal.app.ResolverActivity")
		in.SetType("application/pdf")
		StartActivity(in)
	#end if
	#if B4I
		'......
	#End If
End Sub
