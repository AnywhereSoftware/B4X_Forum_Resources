B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
'releases
'0.1 : first version
'0.2 : add support fo image PNG with colorspace Indexed (palette)
'0.3 : add raw command to enter PDF command directly
'0.4 : add strikeThrough style for font
'      add constants for font style 
'      add constants for colors
'      add methods gMultilineTextSize and outTextFlow
'      add setter/getter sX, sY, sY and gY to get/set the current position
'0.5 : add suport for all images type. image is convert to PNG before inserted. a temp file is created, insert into the pdf and deleted
'0.6 : add justify align
Sub Class_Globals
	Type TPDFContext(fX As Double,fY As Double, _
	                 fFontFamily As String,fFontSize As Double,fFontStyle As Int,fFontColor(3) As Double, _
					 fDrawWidth As Double,fDrawColor(3) As Double,fFillColor(3) As Double)
	Type TPDFPage(fWidth As Double,fHeight As Double,fBuffer As String)
	Type TPDFImageInfo(fError As Int,fWidth As Int,fHeight As Int,fBPP As Int,fColorSpace As Int,fCompression As Int,fFilter As Int,fInterlacing As Int,fData() As Byte,fPalette() As Byte)
	Type TPDFFontInfo(fCharsWidths(256) As Int,fYUnderline As Int,fHUnderline As Int,fYStrikeThrough As Int,fHStrikeThrough As Int,fYBottom As Int,fYTop As Int)
	Type TPDFTextSize(fWidth As Double,fTop As Double,fBottom As Double,fHeight As Double)
	Type TPDFMultilineTextSize(fWidth As Double,fHeight As Double,fParagraphs As List)

	'use to convert image to png
	Private fXUI As XUI

	'encoding file
	Private const fTextEncoding As String="cp1252"
	'versions
	Private fLibVersion As String
	Private fPDFVersion As String
	'factor between user unit and pt
	Private fUnitFactor As Double
	'current context
	Private fContext As TPDFContext
	'properties of PDF document
	Private fProperties As Map
	'list of objects in the PDF
	Private fObjs As List
	'current page
	Private fPage As Int
	'liste of pages (TPDFPage)
	Private fPages As List
	'list of used images in the document, each item in a map (path,imageinfo)
	Private fUsedImages As List
	'list of used fonts in the document
	Private fUsedFonts As List
	'font info for all the stadards fonts (TPDFFontInfo)
	Private fFontsInfos As Map

	'constants for page size
	Public const pageSizeA3PortraitWidth As Double=-841.89
	Public const pageSizeA3PortraitHeight As Double=-1190.55
	Public const pageSizeA4PortraitWidth As Double=-595.28
	Public const pageSizeA4PortraitHeight As Double=-841.89
	Public const pageSizeA5PortraitWidth As Double=-420.94
	Public const pageSizeA5PortraitHeight As Double=-595.28
	Public const pageSizeLetterPortraitWidth As Double=-612
	Public const pageSizeLetterPortraitHeight As Double=-792
	Public const pageSizeLegalPortraitWidth As Double=-612
	Public const pageSizeLegalPortraitHeight As Double=-1008
	Public const pageSizeA3LandscapeWidth As Double=-1190.55
	Public const pageSizeA3LandscapeHeight As Double=-841.89
	Public const pageSizeA4LandscapeWidth As Double=-841.89
	Public const pageSizeA4LandscapeHeight As Double=-595.28
	Public const pageSizeA5LandscapeWidth As Double=-595.28
	Public const pageSizeA5LandscapeHeight As Double=-420.94
	Public const pageSizeLetterLandscapeWidth As Double=-792
	Public const pageSizeLetterLandscapeHeight As Double=-612
	Public const pageSizeLegalLandscapeWidth As Double=-1008
	Public const pageSizeLegalLandscapeHeight As Double=-612

	'constants for standards fonts
	Public const fontCourier As String="Courier"
	Public const fontHelvetica As String="Helvetica"
	Public const fontTimes As String="Times"
	Public const fontSymbol As String="Symbol"
	Public const fontZapfdingbats As String="zapfdingbats"

	'constants for fonts styles
	Public const fontNormal As Int=0
	Public const fontBold As Int=1
	Public const fontItalic As Int=2
	Public const fontUnderline As Int=4
	Public const fontStrikeThrough As Int=8
	
	'constants for properties
	Public const PropertyAuthor As String="Author"
	Public const PropertyCreator As String="Creator"
	Public const PropertyProducer As String="Producer"
	Public const PropertyTitle As String="Title"
	Public const PropertySubject As String="Subject"
	Public const PropertyKeywords As String="Keywords"
	
	'constants for rectangle style
	Public const RectangleBorderOnly As String="S"
	Public const RectangleFillOnly As String="f"
	Public const RectangleBorderAndFill As String="B"

	'constants for text align
	Public const AlignLeft As String="L"
	Public const AlignCenter As String="C"
	Public const AlignRight As String="R"
	Public const AlignJusify As String="J"

	'constants for compression
	Public const CompressAlways As Int=0
	Public const CompressIfSmaller As Int=1
	Public const CompressNever As Int=2

	Public const colorBlack(3) As Double=Array As Double(0,0,0)
	Public const colorWhite(3) As Double=Array As Double(1,1,1)
	Public const colorGray(3) As Double=Array As Double(0.5,0.5,0.5)
	Public const colorRed(3) As Double=Array As Double(1,0,0)
	Public const colorGreen(3) As Double=Array As Double(0,1,0)
	Public const colorBlue(3) As Double=Array As Double(0,0,1)

End Sub

'initialize and set unit to use : mm, cm, pt, in
Public Sub Initialize(aunit As String) As cPDF
	fLibVersion="0.6"
	fPDFVersion="1.3"
	sUnit(aunit)
	fProperties=CreateMap("Producer":"B4XPDF","CreationDate":gCreationDate,"ModDate":gCreationDate)
	fContext.Initialize
	fObjs.Initialize
	fPages.Initialize
	fPage=0
	fUsedImages.Initialize
	fUsedFonts.Initialize
	initFontsInfos
	Return Me
End Sub

private Sub createFontInfo(acharsWidths() As Int,ayunderline As Int,ahunderline As Int,aystrikethrough As Int,ahstrikethrough As Int,aytop As Int,aybottom As Int) As TPDFFontInfo
	Dim fi As TPDFFontInfo
	fi.Initialize
	'width of each 256 chars
	fi.fCharsWidths=acharsWidths
	'bottom of underline rectangle
	fi.fYUnderline=ayunderline
	'height of underine rectangle
	fi.fHUnderline=ahunderline
	'bottom of strikethrough rectangle
	fi.fYStrikeThrough=aystrikethrough
	'height of strikethrough rectangle
	fi.fHStrikeThrough=ahstrikethrough
	'distance between baseline and top
	fi.fYTop=aytop
	'distance between baseline and bottom
	fi.fybottom=aybottom
	Return fi
End Sub

private Sub initFontsInfos
	fFontsInfos.Initialize
	fFontsInfos.Put(calcFontKey("Courier",fontNormal),createFontInfo(Array As Int(600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600),-60,40,220,40,800,-230))
	fFontsInfos.Put(calcFontKey("Courier",fontBold),createFontInfo(Array As Int(600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600),-60,40,220,40,800,-230))
	fFontsInfos.Put(calcFontKey("Courier",fontItalic),createFontInfo(Array As Int(600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600),-60,40,220,40,800,-230))
	fFontsInfos.Put(calcFontKey("Courier",fontBold+fontItalic),createFontInfo(Array As Int(600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600,600),-60,40,220,40,800,-230))
	fFontsInfos.Put(calcFontKey("Helvetica",fontNormal),createFontInfo(Array As Int(278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,355,556,556,889,667,191,333,333,389,584,278,333,278,278,556,556,556,556,556,556,556,556,556,556,278,278,584,584,584,556,1015,667,667,722,722,667,611,778,722,278,500,667,556,833,722,778,667,778,722,667,611,722,667,944,667,667,611,278,278,278,469,556,333,556,556,500,556,556,278,556,556,222,222,500,222,833,556,556,556,556,333,500,278,556,500,722,500,500,500,334,260,334,584,350,556,350,222,556,333,1000,556,556,333,1000,667,333,1000,350,611,350,350,222,222,333,333,350,556,1000,333,1000,500,333,944,350,500,667,278,333,556,556,556,556,260,556,333,737,370,556,584,333,737,333,400,584,333,333,333,556,537,278,333,333,365,556,834,834,834,611,667,667,667,667,667,667,1000,722,667,667,667,667,278,278,278,278,722,722,778,778,778,778,778,584,778,722,722,722,722,667,667,611,556,556,556,556,556,556,889,500,556,556,556,556,278,278,278,278,556,556,556,556,556,556,556,584,611,556,556,556,556,500,556,500),-60,40,220,40,800,-230))
	fFontsInfos.Put(calcFontKey("Helvetica",fontBold),createFontInfo(Array As Int(278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,333,474,556,556,889,722,238,333,333,389,584,278,333,278,278,556,556,556,556,556,556,556,556,556,556,333,333,584,584,584,611,975,722,722,722,722,667,611,778,722,278,556,722,611,833,722,778,667,778,722,667,611,722,667,944,667,667,611,333,278,333,584,556,333,556,611,556,611,556,333,611,611,278,278,556,278,889,611,611,611,611,389,556,333,611,556,778,556,556,500,389,280,389,584,350,556,350,278,556,500,1000,556,556,333,1000,667,333,1000,350,611,350,350,278,278,500,500,350,556,1000,333,1000,556,333,944,350,500,667,278,333,556,556,556,556,280,556,333,737,370,556,584,333,737,333,400,584,333,333,333,611,556,278,333,333,365,556,834,834,834,611,722,722,722,722,722,722,1000,722,667,667,667,667,278,278,278,278,722,722,778,778,778,778,778,584,778,722,722,722,722,667,667,611,556,556,556,556,556,556,889,556,556,556,556,556,278,278,278,278,611,611,611,611,611,611,611,584,611,611,611,611,611,556,611,556),-60,40,220,40,800,-230))
	fFontsInfos.Put(calcFontKey("Helvetica",fontItalic),createFontInfo(Array As Int(278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,355,556,556,889,667,191,333,333,389,584,278,333,278,278,556,556,556,556,556,556,556,556,556,556,278,278,584,584,584,556,1015,667,667,722,722,667,611,778,722,278,500,667,556,833,722,778,667,778,722,667,611,722,667,944,667,667,611,278,278,278,469,556,333,556,556,500,556,556,278,556,556,222,222,500,222,833,556,556,556,556,333,500,278,556,500,722,500,500,500,334,260,334,584,350,556,350,222,556,333,1000,556,556,333,1000,667,333,1000,350,611,350,350,222,222,333,333,350,556,1000,333,1000,500,333,944,350,500,667,278,333,556,556,556,556,260,556,333,737,370,556,584,333,737,333,400,584,333,333,333,556,537,278,333,333,365,556,834,834,834,611,667,667,667,667,667,667,1000,722,667,667,667,667,278,278,278,278,722,722,778,778,778,778,778,584,778,722,722,722,722,667,667,611,556,556,556,556,556,556,889,500,556,556,556,556,278,278,278,278,556,556,556,556,556,556,556,584,611,556,556,556,556,500,556,500),-60,40,220,40,800,-230))
	fFontsInfos.Put(calcFontKey("Helvetica",fontBold+fontItalic),createFontInfo(Array As Int(278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,278,333,474,556,556,889,722,238,333,333,389,584,278,333,278,278,556,556,556,556,556,556,556,556,556,556,333,333,584,584,584,611,975,722,722,722,722,667,611,778,722,278,556,722,611,833,722,778,667,778,722,667,611,722,667,944,667,667,611,333,278,333,584,556,333,556,611,556,611,556,333,611,611,278,278,556,278,889,611,611,611,611,389,556,333,611,556,778,556,556,500,389,280,389,584,350,556,350,278,556,500,1000,556,556,333,1000,667,333,1000,350,611,350,350,278,278,500,500,350,556,1000,333,1000,556,333,944,350,500,667,278,333,556,556,556,556,280,556,333,737,370,556,584,333,737,333,400,584,333,333,333,611,556,278,333,333,365,556,834,834,834,611,722,722,722,722,722,722,1000,722,667,667,667,667,278,278,278,278,722,722,778,778,778,778,778,584,778,722,722,722,722,667,667,611,556,556,556,556,556,556,889,556,556,556,556,556,278,278,278,278,611,611,611,611,611,611,611,584,611,611,611,611,611,556,611,556),-60,40,220,40,800,-230))
	fFontsInfos.Put(calcFontKey("Times",fontNormal),createFontInfo(Array As Int(250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,333,408,500,500,833,778,180,333,333,500,564,250,333,250,278,500,500,500,500,500,500,500,500,500,500,278,278,564,564,564,444,921,722,667,667,722,611,556,722,722,333,389,722,611,889,722,722,556,722,667,556,611,722,722,944,722,722,611,333,278,333,469,500,333,444,500,444,500,444,333,500,500,278,278,500,278,778,500,500,500,500,333,389,278,500,500,722,500,500,444,480,200,480,541,350,500,350,333,500,444,1000,500,500,333,1000,556,333,889,350,611,350,350,333,333,444,444,350,500,1000,333,980,389,333,722,350,444,722,250,333,500,500,500,500,200,500,333,760,276,500,564,333,760,333,400,564,300,300,333,500,453,250,333,300,310,500,750,750,750,444,722,722,722,722,722,722,889,667,611,611,611,611,333,333,333,333,722,722,722,722,722,722,722,564,722,722,722,722,722,722,556,500,444,444,444,444,444,444,667,444,444,444,444,444,278,278,278,278,500,500,500,500,500,500,500,564,500,500,500,500,500,500,500,500),-60,40,2200,40,800,-230))
	fFontsInfos.Put(calcFontKey("Times",fontBold),createFontInfo(Array As Int(250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,333,555,500,500,1000,833,278,333,333,500,570,250,333,250,278,500,500,500,500,500,500,500,500,500,500,333,333,570,570,570,500,930,722,667,722,722,667,611,778,778,389,500,778,667,944,722,778,611,778,722,556,667,722,722,1000,722,722,667,333,278,333,581,500,333,500,556,444,556,444,333,500,556,278,333,556,278,833,556,500,556,556,444,389,333,556,500,722,500,500,444,394,220,394,520,350,500,350,333,500,500,1000,500,500,333,1000,556,333,1000,350,667,350,350,333,333,500,500,350,500,1000,333,1000,389,333,722,350,444,722,250,333,500,500,500,500,220,500,333,747,300,500,570,333,747,333,400,570,300,300,333,556,540,250,333,300,330,500,750,750,750,500,722,722,722,722,722,722,1000,722,667,667,667,667,389,389,389,389,722,722,778,778,778,778,778,570,778,722,722,722,722,722,611,556,500,500,500,500,500,500,722,444,444,444,444,444,278,278,278,278,500,556,500,500,500,500,500,570,500,556,556,556,556,500,556,500),-60,40,220,40,800,-230))
	fFontsInfos.Put(calcFontKey("Times",fontItalic),createFontInfo(Array As Int(250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,333,420,500,500,833,778,214,333,333,500,675,250,333,250,278,500,500,500,500,500,500,500,500,500,500,333,333,675,675,675,500,920,611,611,667,722,611,611,722,722,333,444,667,556,833,667,722,611,722,611,500,556,722,611,833,611,556,556,389,278,389,422,500,333,500,500,444,500,444,278,500,500,278,278,444,278,722,500,500,500,500,389,389,278,500,444,667,444,444,389,400,275,400,541,350,500,350,333,500,556,889,500,500,333,1000,500,333,944,350,556,350,350,333,333,556,556,350,500,889,333,980,389,333,667,350,389,556,250,389,500,500,500,500,275,500,333,760,276,500,675,333,760,333,400,675,300,300,333,500,523,250,333,300,310,500,750,750,750,500,611,611,611,611,611,611,889,667,611,611,611,611,333,333,333,333,722,667,722,722,722,722,722,675,722,722,722,722,722,556,611,500,500,500,500,500,500,500,667,444,444,444,444,444,278,278,278,278,500,500,500,500,500,500,500,675,500,500,500,500,500,444,500,444),-60,40,220,40,800,-230))
	fFontsInfos.Put(calcFontKey("Times",fontBold+fontItalic),createFontInfo(Array As Int(250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,389,555,500,500,833,778,278,333,333,500,570,250,333,250,278,500,500,500,500,500,500,500,500,500,500,333,333,570,570,570,500,832,667,667,667,722,667,667,722,778,389,500,667,611,889,722,722,611,722,667,556,611,722,667,889,667,611,611,333,278,333,570,500,333,500,500,444,500,444,333,500,556,278,278,500,278,778,556,500,500,500,389,389,278,556,444,667,500,444,389,348,220,348,570,350,500,350,333,500,500,1000,500,500,333,1000,556,333,944,350,611,350,350,333,333,500,500,350,500,1000,333,1000,389,333,722,350,389,611,250,389,500,500,500,500,220,500,333,747,266,500,606,333,747,333,400,570,300,300,333,576,500,250,333,300,300,500,750,750,750,500,667,667,667,667,667,667,944,667,667,667,667,667,389,389,389,389,722,722,722,722,722,722,722,570,722,722,722,722,722,611,611,500,500,500,500,500,500,500,722,444,444,444,444,444,278,278,278,278,500,556,500,500,500,500,500,570,500,556,556,556,556,444,500,444),-60,40,220,40,800,-230))
	fFontsInfos.Put(calcFontKey("Symbol",fontNormal),createFontInfo(Array As Int(250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,333,713,500,549,833,778,439,333,333,500,549,250,549,250,278,500,500,500,500,500,500,500,500,500,500,278,278,549,549,549,444,549,722,667,722,612,611,763,603,722,333,631,722,686,889,722,722,768,741,556,592,611,690,439,768,645,795,611,333,863,333,658,500,500,631,549,549,494,439,521,411,603,329,603,549,549,576,521,549,549,521,549,603,439,576,713,686,493,686,494,480,200,480,549,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,750,620,247,549,167,713,500,753,753,753,753,1042,987,603,987,603,400,549,411,549,549,713,494,460,549,549,549,549,1000,603,1000,658,823,686,795,987,768,768,823,768,768,713,713,713,713,713,713,713,768,713,790,790,890,823,549,250,713,603,603,1042,987,603,987,603,494,329,790,790,786,713,384,384,384,384,384,384,494,494,494,494,0,329,274,686,686,686,384,384,384,384,384,384,494,494,494,0),-60,10,220,40,800,-230))
	fFontsInfos.Put(calcFontKey("zapfdingbats",fontNormal),createFontInfo(Array As Int(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,278,974,961,974,980,719,789,790,791,690,960,939,549,855,911,933,911,945,974,755,846,762,761,571,677,763,760,759,754,494,552,537,577,692,786,788,788,790,793,794,816,823,789,841,823,833,816,831,923,744,723,749,790,792,695,776,768,792,759,707,708,682,701,826,815,789,789,707,687,696,689,786,787,713,791,785,791,873,761,762,762,759,759,892,892,788,784,438,138,277,415,392,392,668,668,0,390,390,317,317,276,276,509,509,410,410,234,234,334,334,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,732,544,544,910,667,760,760,776,595,694,626,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,788,894,838,1016,458,748,924,748,918,927,928,928,834,873,828,924,924,917,930,931,463,883,836,836,867,867,696,696,874,0,874,760,946,771,865,771,888,967,888,831,873,927,970,918,0),-60,40,220,40,800,-230))
End Sub

'set factor to convert user unit to pt
private Sub sUnit(aunit As String) As cPDF
	Select aunit.ToLowerCase
		Case "pt"
			fUnitFactor=1.0
		Case "mm"
			fUnitFactor=72.0/25.4
		Case "cm"
			fUnitFactor=72.0/2.54
		Case "in"
			fUnitFactor=72.0
		Case Else
			fUnitFactor=1.0
	End Select
	Return Me
End Sub

'return current date and time in format D:YYYYMMDDHHMMSS±hh'mm'
private Sub gCreationDate As String
	DateTime.DateFormat="yyyyMMdd"
	DateTime.TimeFormat="hhmmss"
	Dim z As String=NumberFormat2(DateTime.TimeZoneOffset,2,2,2,False)
	z=IIf(z.SubString2(0,1)<>"-","+","") & z
	z=z.SubString2(0,3) & "'" & z.SubString(4) & "'"
	Return "D:" & DateTime.Date(DateTime.Now) & DateTime.Time(DateTime.Now) & z
End Sub

'all the ....write methods write a part of the pdf
private Sub headerWrite As Byte()
	Dim bb As B4XBytesBuilder
	bb.Initialize
	bb.Append($"%PDF-${NumberFormat2(fPDFVersion,1,1,1,False)}${Chr(10)}"$.getBytes(fTextEncoding))
	Return bb.toarray
End Sub

private Sub catalogWrite As Byte()
	Dim bb As B4XBytesBuilder
	bb.Initialize
	bb.Append($"${fObjs.Size+1} 0 obj <</Type /Catalog /Pages 2 0 R>> endobj${Chr(10)}"$.getBytes(fTextEncoding))
	fObjs.Add(bb.Length)
	Return bb.toarray
End Sub

private Sub kidsWrite As Byte()
	Dim bb As B4XBytesBuilder
	bb.Initialize
	bb.Append($"${fObjs.Size+1} 0 obj <</Type /Pages /Kids ["$.getbytes(fTextEncoding))
	For i=1 To fPages.Size
		bb.append($"${fObjs.Size+1+i} 0 R "$.getbytes(fTextEncoding))
	Next
	bb.Append($"] /Count ${fPages.size}>> endobj${Chr(10)}"$.getbytes(fTextEncoding))
	fObjs.Add(bb.Length)
	Return bb.ToArray
End Sub

private Sub pagesWrite As Byte()
	Dim bb As B4XBytesBuilder
	bb.Initialize
	Dim r As Int=fObjs.Size+1+fPages.Size*2
	For i=0 To fPages.Size-1
		bb.append(pageWrite(i,r))
	Next
	Return bb.ToArray
End Sub

private Sub pageWrite(apage As Int,aresource As Int) As Byte()
	Dim bb As B4XBytesBuilder
	bb.Initialize
	Dim p As TPDFPage=fPages.Get(apage)
	bb.Append($"${fObjs.Size+1} 0 obj <</Type /Page /Parent 2 0 R /Resources ${aresource} 0 R /MediaBox [0 0 ${NumberFormat2(p.fwidth,1,2,2,False)} ${NumberFormat2(p.fheight,1,2,2,False)}] /Contents ${fObjs.Size+1+fPages.size} 0 R>> endobj${Chr(10)}"$.getbytes(fTextEncoding))
	fObjs.Add(bb.Length)
	Return bb.ToArray
End Sub

private Sub contentsWrite(acompress As Int) As Byte()
	Dim bb As B4XBytesBuilder
	bb.Initialize
	For i=0 To fPages.Size-1
		bb.append(contentWrite(acompress,i))
	Next
	Return bb.toarray
End Sub

private Sub contentWrite(acompress As Int,apage As Int) As Byte()
	Dim const compress As String="/Filter/FlateDecode"
	Dim bb As B4XBytesBuilder
	bb.Initialize

	Dim c() As Byte=fPages.Get(apage).As(TPDFPage).fBuffer.GetBytes(fTextEncoding)
	Dim filter As String=""

	If acompress<>CompressNever Then
		Dim cs As CompressedStreams
		Dim b() As Byte=cs.CompressBytes(c,"zlib")
		If acompress=CompressAlways Or b.Length+compress.length<c.Length Then
			c=b
			filter=compress
		End If
	End If
	
	bb.Append($"${fObjs.Size+1} 0 obj <<${filter}/Length ${c.length}>>${Chr(10)}stream${Chr(10)}"$.getbytes(fTextEncoding))
	bb.Append(c)
	bb.Append($"${Chr(10)}endstream${Chr(10)}endobj${Chr(10)}"$.getBytes(fTextEncoding))
	fObjs.Add(bb.Length)
	Return bb.ToArray
End Sub

private Sub resourcesWrite As Byte()
	Dim bb As B4XBytesBuilder
	bb.Initialize
	bb.Append($"${fObjs.size+1} 0 obj  << "$.getBytes(fTextEncoding))

	bb.Append($"/ProcSet [/PDF /Text /ImageB /ImageC /ImageI] ${Chr(10)}"$.getBytes(fTextEncoding))
	
	bb.append($"/Font << ${Chr(10)}"$.getBytes(fTextEncoding))
	For i=0 To fUsedFonts.Size-1
		bb.Append($"/F${i} ${fObjs.Size+1+i+1} 0 R "$.getBytes(fTextEncoding))
	Next
	bb.append($" >> ${Chr(10)}"$.getBytes(fTextEncoding))
	
	bb.append($"/XObject << ${Chr(10)}"$.getBytes(fTextEncoding))
	For i=0 To fUsedImages.Size-1
		bb.Append($"/I${i} ${fObjs.Size+1+i+1+fUsedFonts.size} 0 R "$.getBytes(fTextEncoding))
	Next
	bb.append($" >> ${Chr(10)}"$.getBytes(fTextEncoding))
	
	bb.Append($" >> endobj${Chr(10)}"$.getBytes(fTextEncoding))
	fObjs.Add(bb.Length)
	Return bb.ToArray
End Sub

private Sub fontsWrite As Byte()
	Dim bb As B4XBytesBuilder
	bb.Initialize
	For i=0 To fUsedFonts.Size-1
		bb.append(fontWrite(i))
	Next
	Return bb.ToArray
End Sub

private Sub fontWrite(afont As Int) As Byte()
	Dim bb As B4XBytesBuilder
	bb.Initialize
	Dim c As String=fUsedFonts.Get(afont)
	bb.Append($"${fObjs.Size+1} 0 obj << /Type /Font /Subtype /Type1 /BaseFont /${c} /Encoding /WinAnsiEncoding>> endobj${Chr(10)}"$.getbytes(fTextEncoding))
	fObjs.Add(bb.Length)
	Return bb.ToArray
End Sub

private Sub imagesWrite As Byte()
	Dim bb As B4XBytesBuilder
	bb.Initialize
	For i=0 To fUsedImages.Size-1
		bb.append(imageWrite(i))
	Next
	Return bb.toarray
End Sub

private Sub imageWrite(aimage As Int) As Byte()
	Dim bb As B4XBytesBuilder
	bb.Initialize
	Dim ii As TPDFImageInfo=fUsedImages.Get(aimage).As(Map).Get("info")
	bb.Append($"${fObjs.Size+1} 0 obj${Chr(10)}<</Type /XObject${Chr(10)}/Subtype /Image${Chr(10)}/Width ${ii.fWidth}${Chr(10)}/Height ${ii.fHeight}${Chr(10)}"$.getbytes(fTextEncoding))
	Dim cs As String=Array As String("DeviceGray","Error","DeviceRGB","Indexed","DeviceGray","Error","DeviceRGB")(ii.fColorSpace)
	If cs="Indexed" Then
		bb.Append($"/ColorSpace [/Indexed /DeviceRGB ${NumberFormat2(ii.fPalette.Length/3-1,1,0,0,False)} ${fObjs.Size+2} 0 R]${Chr(10)}"$.getbytes(fTextEncoding))
	Else
		bb.Append($"/ColorSpace /DeviceRGB${Chr(10)}"$.getbytes(fTextEncoding))
	End If
	bb.Append($"/BitsPerComponent ${ii.fBPP}${Chr(10)}/Filter /FlateDecode${Chr(10)}/DecodeParms <</Predictor 15 /Colors ${IIf(cs="DeviceRGB",3,1)} /BitsPerComponent ${ii.fBPP} /Columns ${ii.fWidth}>>${Chr(10)}"$.getBytes(fTextEncoding))
	bb.Append($"/Length ${ii.fData.length}>>${Chr(10)}stream${Chr(10)}"$.getBytes(fTextEncoding))
	bb.Append(ii.fdata)
	bb.Append($"${Chr(10)}endstream${Chr(10)}endobj${Chr(10)}"$.getBytes(fTextEncoding))
	fObjs.Add(bb.Length)
	If cs="Indexed" Then
		bb.Append(paletteWrite(ii.fPalette))
	End If
	Return bb.ToArray
End Sub

private Sub paletteWrite(apalette() As Byte) As Byte()
	Dim bb As B4XBytesBuilder
	bb.Initialize
	bb.Append($"${fObjs.Size+1} 0 obj${Chr(10)}<</Length ${apalette.Length}>>${Chr(10)}stream${Chr(10)}"$.getbytes(fTextEncoding))
	bb.Append(apalette)
	bb.Append($"${Chr(10)}endstream${Chr(10)}endobj${Chr(10)}"$.getBytes(fTextEncoding))
	fObjs.Add(bb.Length)
	Return bb.ToArray
End Sub

private Sub propertiesWrite As Byte()
	Dim bb As B4XBytesBuilder
	bb.Initialize
	bb.Append($"${fObjs.Size+1} 0 obj <<${Chr(10)}"$.getBytes(fTextEncoding))
	For Each k As String In fProperties.keys
		bb.Append($"/${k}(${escapeText(fProperties.Get(k))})${Chr(10)}"$.getBytes(fTextEncoding))
	Next
	bb.Append($" >> endobj${Chr(10)}"$.getBytes(fTextEncoding))
	fObjs.Add(bb.Length)
	Return bb.ToArray
End Sub

private Sub refWrite(astart As Long,ageneration As Int,astatus As String) As Byte()
	Dim bb As B4XBytesBuilder
	bb.Initialize
	bb.Append($"${NumberFormat2(astart,10,0,0,False)} ${NumberFormat2(ageneration,5,0,0,False)} ${astatus}${Chr(10)}"$.getBytes(fTextEncoding))
	Return bb.ToArray
End Sub

private Sub xrefWrite As Byte()
	Dim bb As B4XBytesBuilder
	bb.Initialize
	Dim s As Long=headerWrite.length
	bb.Append($"xref${Chr(10)}"$.getBytes(fTextEncoding))
	bb.Append($"0 ${fObjs.Size+1}${Chr(10)}"$.getBytes(fTextEncoding))
	bb.Append(refWrite(0,65535,"f"))
	For i=0 To fObjs.Size-1
		Dim l As Int=fObjs.Get(i)
		bb.Append(refWrite(s,0,"n"))
		s=s+l
	Next
	Return bb.ToArray
End Sub

private Sub trailerWrite As Byte()
	Dim bb As B4XBytesBuilder
	bb.Initialize
	Dim s As Long=headerWrite.length
	For i=0 To fObjs.Size-1
		Dim l As Int=fObjs.Get(i)
		s=s+l
	Next
	bb.Append($"trailer <<${Chr(10)}"$.getBytes(fTextEncoding))
	bb.Append($"/Size ${fObjs.Size+1}${Chr(10)}"$.getBytes(fTextEncoding))
	bb.Append($"/Info ${fObjs.Size} 0 R${Chr(10)}"$.getBytes(fTextEncoding))
	bb.Append($"/Root 1 0 R${Chr(10)}"$.getBytes(fTextEncoding))
	bb.Append($">>${Chr(10)}"$.getBytes(fTextEncoding))
	bb.Append($"startxref${Chr(10)}"$.getBytes(fTextEncoding))
	bb.Append($"${s}${Chr(10)}"$.getBytes(fTextEncoding))
	Return bb.ToArray
End Sub

private Sub footerWrite As Byte()
	Return "%%EOF".GetBytes(fTextEncoding)
End Sub

'calc a unique key for a specific font (family ans style (bold, italic))
private Sub calcFontKey(afamily As String,astyle As Int)  As String
	If afamily="zapfdingbats" Or afamily="Symbol" Then
		astyle=Bit.And(astyle,Bit.Not(Bit.Or(fontBold,fontItalic)))
	End If
	If Bit.And(astyle,fontBold)<>0 And Bit.And(astyle,fontItalic)<>0 Then
		Return afamily & "-BoldOblique"
	End If
	If Bit.And(astyle,fontBold)<>0 Then
		Return afamily & "-Bold"
	End If
	If Bit.And(astyle,fontItalic)<>0 Then
		Return afamily & "-Oblique"
	End If
	If afamily="Times" Then
		Return "Times-Roman"
	End If
	Return afamily
End Sub

'add content to a page
private Sub contentAdd(apage As Int,acontent As String)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append(fPages.Get(apage).As(TPDFPage).fbuffer)
	sb.Append(acontent)
	fPages.Get(apage).As(TPDFPage).fbuffer=sb.ToString
End Sub

'escape characters ( ) \
private Sub escapeText(atext As String) As String
	Return atext.Replace("\","\\").Replace("(","\(").Replace(")","\)")
End Sub

'initialize, set properties and return a TPDFPage
private Sub createPage(awidth As Double,aheight As Double,abuffer As String) As TPDFPage
	Dim p As TPDFPage
	p.Initialize
	p.fWidth=awidth
	p.fHeight=aheight
	p.fBuffer=abuffer
	Return p
End Sub

private Sub rafReadString(araf As RandomAccessFile,astart As Long,acount As Long) As String
	Dim s As String
	For i=0 To acount-1
		s=s & Chr(araf.ReadUnsignedByte(astart+i))
	Next
	Return s
End Sub

'calc a unique key for a specific image (adir & afile)
private Sub imageKey(adir As String,afile As String) As String
	Return adir & afile
End Sub

'parse png file
private Sub imageInfo(adir As String,afile As String) As TPDFImageInfo
	Dim ii As TPDFImageInfo
	Dim raf  As RandomAccessFile
	Dim rafpos As Long
	Dim bbData As B4XBytesBuilder
	Dim bbPalette As B4XBytesBuilder
	
	bbData.Initialize
	bbPalette.Initialize
	ii.Initialize
	ii.fError=0
	raf.Initialize(adir,afile,True)
	rafpos=0
	
	
	'signture PNG
	If rafReadString(raf,rafpos,8)<>Chr(137) & "PNG" & Chr(13) & Chr(10) & Chr(26) & Chr(10) Then
		ii.fError=1
	End If
	rafpos=rafpos+8
	
	'chunks (length, type, data, CRC)
	Dim chunkLength As Int
	Dim chunkType As String
	Do While (ii.fError=0) And (chunkType<>"IEND")
		chunkLength=raf.ReadInt(rafpos)
		rafpos=rafpos+4
		chunkType=rafReadString(raf,rafpos,4)
		rafpos=rafpos+4
		Select chunkType
			'header
			Case "IHDR"
				ii.fWidth=raf.ReadInt(rafpos)
				rafpos=rafpos+4
				
				ii.fHeight=raf.ReadInt(rafpos)
				rafpos=rafpos+4
				
				ii.fBPP=raf.ReadUnsignedByte(rafpos)
				If ii.fBPP>8 Then
					ii.fError=2
				End If
				rafpos=rafpos+1
				
				ii.fColorSpace=raf.ReadUnsignedByte(rafpos)
				If ii.fColorSpace<>0 And ii.fColorSpace<>2 And ii.fColorSpace<>3 And ii.fColorSpace<>4 Then
					ii.FError=3
				End If
				rafpos=rafpos+1
				
				ii.FCompression=raf.ReadUnsignedByte(rafpos)
				If ii.FCompression<>0 Then
					ii.FError=4
				End If
				rafpos=rafpos+1
				
				ii.FFilter=raf.ReadUnsignedByte(rafpos)
				If ii.FFilter<>0 Then
					ii.FError=5
				End If
				rafpos=rafpos+1

				ii.FInterlacing=raf.ReadUnsignedByte(rafpos)
				If ii.FInterlacing<>0 Then
					ii.FError=6
				End If
				rafpos=rafpos+1
			'data
			Case "IDAT"
				Dim b(chunkLength) As Byte
				raf.ReadBytes(b,0,chunkLength,rafpos)
				bbData.Append(b)
				rafpos=rafpos+chunkLength
			'palette
			Case "PLTE"
				Dim b(chunkLength) As Byte
				raf.ReadBytes(b,0,chunkLength,rafpos)
				bbPalette.Append(b)
				rafpos=rafpos+chunkLength
			'ignore other chunktype
			Case Else
				'skip Data
				rafpos=rafpos+chunkLength
		End Select
		'skip CRC
		rafpos=rafpos+4
	Loop

	raf.close
	ii.fData=bbData.ToArray
	ii.fPalette=bbPalette.ToArray

	Return ii
End Sub



'save to stream
public Sub saveToStream(aoutputstream As OutputStream,acompress As Int) As cPDF
	Dim b() As Byte=headerWrite
	aoutputstream.WriteBytes(b,0,b.length)
	Dim b() As Byte=catalogWrite
	aoutputstream.WriteBytes(b,0,b.length)
	Dim b() As Byte=kidsWrite
	aoutputstream.WriteBytes(b,0,b.length)
	Dim b() As Byte=pagesWrite
	aoutputstream.WriteBytes(b,0,b.length)
	Dim b() As Byte=contentsWrite(acompress)
	aoutputstream.WriteBytes(b,0,b.length)
	Dim b() As Byte=resourcesWrite
	aoutputstream.WriteBytes(b,0,b.length)
	Dim b() As Byte=fontsWrite
	aoutputstream.WriteBytes(b,0,b.length)
	Dim b() As Byte=imagesWrite
	aoutputstream.WriteBytes(b,0,b.length)
	Dim b() As Byte=propertiesWrite
	aoutputstream.WriteBytes(b,0,b.length)
	Dim b() As Byte=xrefWrite
	aoutputstream.WriteBytes(b,0,b.length)
	Dim b() As Byte=trailerWrite
	aoutputstream.WriteBytes(b,0,b.length)
	Dim b() As Byte=footerWrite
	aoutputstream.WriteBytes(b,0,b.length)
	Return Me
End Sub

'save pdf to a file
public Sub saveToFile(adir As String,afile As String,acompress As Int) As cPDF
	File.Delete(adir,afile)
	Dim outputstream As OutputStream=File.OpenOutput(adir,afile,False)
	saveToStream(outputstream,acompress)
	outputstream.Close
	Return Me
End Sub

	
'return the index of the image with path=akey in fUSedImages
'return -1 if not found
private Sub findImageKey(akey As String) As Int
	For i=0 To fUsedImages.Size-1
		If fUsedImages.Get(i).As(Map).Get("path")=akey Then
			Return i
		End If
	Next
	Return -1
End Sub


'get the number of pages in the pdf
public Sub gPagesCount As Int
	Return fPages.size
End Sub

'get the width of the page
'apage : 1 to n
public Sub gPageWidth(apage As Int) As Double
	Return fPages.Get(apage-1).As(TPDFPage).fWidth/fUnitFactor
End Sub

'get the height of the page
'apage : 1 to n
public Sub gPageHeight(apage As Int) As Double
	Return fPages.Get(apage-1).As(TPDFPage).fHeight/fUnitFactor
End Sub

'add a new page with width and height
'use predefined constants pageSize... 
'or enter custom size (unit is unit defined in intialize method)
'the new page becomes the current page
public Sub pageAdd(awidth As Double,aheight As Double) As cPDF
	fPages.Add(createPage(IIf(awidth<0,-awidth,awidth*fUnitFactor),IIf(aheight<0,-aheight,aheight*fUnitFactor),""))
	fPage=fPages.Size-1
	sFont(fContext.fFontFamily,fContext.fFontStyle,fContext.fFontSize,fContext.fFontColor)
	sDrawColor(fContext.fDrawColor)
	sDrawWidth(fContext.fDrawWidth)
	sFillColor(fContext.fFillColor)
	Return Me
End Sub

'get current page
public Sub gPage As Int
	Return fPage+1
End Sub

'set current page
'apage : 1 to n
public Sub sPage(apage As Int) As cPDF
	fPage=apage-1
	Return Me
End Sub

'set draw color for line
'argb : Red Green Blue
'values from 0.000 to 1.000
public Sub sDrawColor(argb() As Double) As cPDF
	fContext.fDrawColor=argb
	contentAdd(fPage,$"${NumberFormat2(argb(0),1,3,3,False)} ${NumberFormat2(argb(1),1,3,3,False)} ${NumberFormat2(argb(2),1,3,3,False)} RG${Chr(10)}"$)
	Return Me
End Sub

'set draw width for line
public Sub sDrawWidth(awidth As Double) As cPDF
	fContext.fDrawWidth=awidth
	contentAdd(fPage,$"${NumberFormat2(awidth*fUnitFactor,1,3,3,False)} w${Chr(10)}"$)
	Return Me
End Sub

'set fill color
'argb : Red Green Blue
'values from 0.000 to 1.000
public Sub sFillColor(argb() As Double) As cPDF
	fContext.fFillColor=argb
	Return Me
End Sub

'set font
'family : Helvetica,Times,Courier,Symbol,zapfdingbats (use predefined constants font...)
'size in pts
'font uses cp-1252 windows encoding
public Sub sFont(afamily As String,astyle As Int,asize As Double,acolor() As Double) As cPDF
	Dim k As String=calcFontKey(afamily,astyle)
	Dim i As Int=fUsedFonts.IndexOf(k)
	If i=-1 Then
		fUsedFonts.Add(k)
		i=fUsedFonts.Size-1
	End If
	contentAdd(fPage,$"BT /F${i} ${NumberFormat2(asize,1,3,3,False)} Tf ET${Chr(10)}"$)
	fContext.fFontFamily=afamily
	fContext.fFontStyle=astyle
	fContext.fFontSize=asize
	fContext.fFontColor=acolor
	Return Me
End Sub

'draw text on current page at position ax,ay with current font and current text color
'(0,0) is bottom left of the page
'(w,h) if top right of the page
public Sub outText(ax As Double,ay As Double,atext As String) As cPDF
	contentAdd(fPage,$"${NumberFormat2(fContext.fFontColor(0),1,3,3,False)} ${NumberFormat2(fContext.fFontColor(1),1,3,3,False)} ${NumberFormat2(fContext.fFontColor(2),1,3,3,False)} rg${Chr(10)}"$)
	contentAdd(fPage,$"BT ${NumberFormat2(ax*fUnitFactor,1,3,3,False)} ${NumberFormat2(ay*fUnitFactor,1,3,3,False)} Td (${escapeText(atext)})Tj ET${Chr(10)}"$)
	If Bit.And(fContext.fFontstyle,fontUnderline+fontStrikeThrough)<>0 Then
		Dim fi As TPDFFontInfo=fFontsInfos.Get(calcFontKey(fContext.fFontFamily,fContext.fFontStyle)).As(TPDFFontInfo)
		Dim ts As TPDFTextSize=gTextSize(atext)
	End If
	If Bit.And(fContext.fFontstyle,fontUnderline)<>0 Then
		contentAdd(fPage,$"${NumberFormat2(ax*fUnitFactor,1,3,3,False)} ${NumberFormat2(ay*fUnitFactor+fi.fYUnderline*fContext.fFontSize/1000,1,3,3,False)} ${NumberFormat2(ts.fWidth*fUnitFactor,1,3,3,False)} ${NumberFormat2((fi.fHUnderline)*fContext.fFontSize/1000,1,3,3,False)} re f ${Chr(10)}"$)
	End If
	If Bit.And(fContext.fFontstyle,fontStrikeThrough)<>0 Then
		contentAdd(fPage,$"${NumberFormat2(ax*fUnitFactor,1,3,3,False)} ${NumberFormat2(ay*fUnitFactor+fi.fYStrikeThrough*fContext.fFontSize/1000,1,3,3,False)} ${NumberFormat2(ts.fWidth*fUnitFactor,1,3,3,False)} ${NumberFormat2((fi.fHStrikeThrough)*fContext.fFontSize/1000,1,3,3,False)} re f ${Chr(10)}"$)
	End If
	Return Me
End Sub

'draw text on current page at position ax,ay with current font and current text color
'explicit CRLF in atext
'automatic CRLF when awidth is reached
'(0,0) is bottom left of the page
'(w,h) if top right of the page
public Sub outTextFlow(aleftMargin As Double,arightMargin As Double,aalign As String,atext As String) As cPDF
	Dim mts As TPDFMultilineTextSize=gMultilineTextSize(arightMargin-aleftMargin,atext)
	Dim ts As TPDFTextSize
	For p=0 To mts.fParagraphs.Size-1
		Dim lines As List=mts.fParagraphs.Get(p).As(List)
		For i=0 To lines.Size-1
			Dim l As String=lines.Get(i)
			ts=gTextSize(l)
			Select Case aalign
				Case "L"
					outText(aleftMargin,fContext.fy,l)
				Case "C"
					outText(aleftMargin+(arightMargin-aleftMargin-ts.fWidth)/2,fContext.fy,l)
				Case "R"
					outText(arightMargin-ts.fWidth,fContext.fy,l)
				Case "J"
					If i=lines.Size-1 Then
						'last line if left aligned
						outText(aleftMargin,fContext.fy,l)
					Else
						'other lines are justified
						Dim w() As String=Regex.split(" ",l)
						Dim x As Double=aleftMargin
						'calc space between each word
						Dim s As Double=((arightMargin-aleftMargin)-ts.fWidth+(gTextSize(" ").fWidth*(w.Length-1)))/(w.Length-1)
						For j=0 To w.Length-1
							Dim ww As TPDFTextSize=gTextSize(w(j))
							outText(x,fContext.fy,w(j))
							x=x+s+ww.fWidth
						Next
					End If
			End Select
			fContext.fX=aleftMargin
			fContext.fy=fContext.fy+ts.fHeight
		Next
	Next
	Return Me
End Sub

'draw a line on current page from ax1,ay1 to ax2,ay2 with current width and color
'(0,0) is bottom left of the page
'(w,h) if top right of the page
public Sub outLine(ax1 As Double,ay1 As Double,ax2 As Double,ay2 As Double) As cPDF
	contentAdd(fPage,$"${NumberFormat2(ax1*fUnitFactor,1,3,3,False)} ${NumberFormat2(ay1*fUnitFactor,1,3,3,False)} m ${NumberFormat2(ax2*fUnitFactor,1,3,3,False)} ${NumberFormat2(ay2*fUnitFactor,1,3,3,False)} l h S${Chr(10)}"$)
	Return Me
End Sub

'draw a rectangle on current page starting at ax,ay with dimension aw,ah,current width, color and textAndFillColor are used
'(0,0) is bottom left of the page
'(w,h) if top right of the page
'astyle : use predefined constants RectangleBorderOnly,RectangleFillOnly,RectangleBorderAndFill
public Sub outRectangle(ax As Double,ay As Double,aw As Double,ah As Double,astyle As String) As cPDF
	If astyle=RectangleBorderAndFill Or astyle=RectangleFillOnly Then
		contentAdd(fPage,$"${NumberFormat2(fContext.fFillColor(0),1,3,3,False)} ${NumberFormat2(fContext.fFillColor(1),1,3,3,False)} ${NumberFormat2(fContext.fFillColor(2),1,3,3,False)} rg${Chr(10)}"$)
	End If
	contentAdd(fPage,$"${NumberFormat2(ax*fUnitFactor,1,3,3,False)} ${NumberFormat2(ay*fUnitFactor,1,3,3,False)} ${NumberFormat2(aw*fUnitFactor,1,3,3,False)} ${NumberFormat2(ah*fUnitFactor,1,3,3,False)} re ${astyle} ${Chr(10)}"$)
	Return Me
End Sub

private Sub convertImage(adir As String,afile As String) As String
	'convert to JPG
	Dim img As B4XBitmap
	img=fXUI.LoadBitmap(adir,afile)
	Dim out As OutputStream=File.OpenOutput(adir,afile & ".jpg",False)
	img.WriteToStream(out,100,"JPEG")
	out.close

	'then convert to PNG
	Dim img As B4XBitmap
	img=fXUI.LoadBitmap(adir,afile & ".jpg")
	Dim out As OutputStream=File.OpenOutput(adir,afile & ".png",False)
	img.WriteToStream(out,100,"PNG")
	out.close
	
	File.Delete(adir,afile & ".jpg")
	Return afile & ".png"
End Sub

'draw an image 
'only PNG
public Sub outImage(adir As String,afile As String,ax As Double,ay As Double,aw As Double,ah As Double) As cPDF
	Dim ii As TPDFImageInfo
	afile=convertImage(adir,afile)
	'check if this image is already used
	Dim k As String=imageKey(adir,afile)
	Dim i As Int=findImageKey(k)
	'if not add it to the list
	If i=-1 Then
		'get informations about the image
		ii=imageInfo(adir,afile)
		'store it in the list
		fUsedImages.add(CreateMap("path":k,"info":ii))
		i=fUsedImages.Size-1
	Else
		ii=fUsedImages.Get(i).As(Map).Get("info")
	End If

	File.Delete(adir,afile)
	
	If ii.fError=0 Then	
		'originals width and height
		If aw=0 And ah=0 Then
			aw=-96
			ah=-96
		End If
		
		'-aw is horizontal resolution in dpi
		If aw<0 Then
			aw=-ii.fWidth*72/aw/fUnitFactor
		End If
		'-ah is vertical resolution in dpi
		If ah<0 Then
			ah=-ii.fHeight*72/ah/fUnitFactor
		End If
		
		'calc aw proportionnaly to ah
		If aw=0 Then
			aw=ah*ii.fWidth/ii.fHeight
		End If
		'calc ah proportionnaly to aw
		If ah=0 Then
			ah=aw*ii.fHeight/ii.fWidth	
		End If
		
		contentAdd(fPage,$"q ${NumberFormat2(aw*fUnitFactor,1,3,3,False)} 0 0 ${NumberFormat2(ah*fUnitFactor,1,3,3,False)}  ${NumberFormat2(ax*fUnitFactor,1,3,3,False)} ${NumberFormat2(ay*fUnitFactor,1,3,3,False)} cm /I${i} Do Q${Chr(10)}"$)
	End If
	Return Me
End Sub

'add raw content to the current page
'all the positions and dimensions are in user unit
'LF is added at the end of text
public Sub outRaw(atext As String) As cPDF
	If fUnitFactor<>1 Then
		'convert user unit in atext to pt
		Dim shift As Int=0
		atext=atext & Chr(10)
		Dim m As Matcher = Regex.Matcher("([+-]?[0-9]{1,}[\.]{0,1}[0-9]{0,})",atext)
		Do While m.Find
			For g=1 To m.GroupCount
				Dim v As String=NumberFormat2(fUnitFactor*m.Group(g),1,3,3,False)
				atext=atext.SubString2(0,m.getstart(g)+shift) & v & atext.SubString(m.GetEnd(g)+shift)
				shift=shift+v.Length-m.Group(g).Length
			Next
		Loop
	End If
	contentAdd(fPage,atext)
	Return Me
End Sub

'set a document's property
'use predefined constants propertyAuthor....
public Sub sProperty(aproperty As String,avalue As String) As cPDF
	fProperties.Put(aproperty,avalue)
	Return Me
End Sub

'convert signed byte to unsigned
private Sub ToUnsigned(b As Byte) As Int
	Return Bit.And(0xFF, b)
End Sub

'get the text size with the current font and size
'fwidth : width of the text
'fTop : distance between baseline and top of the text
'fBottom : distance between baseline and bottom of the text
'fHeight : total height of the text
public Sub gTextSize(atext As String) As TPDFTextSize
	Dim bb As B4XBytesBuilder
	Dim ts As TPDFTextSize
	bb.Initialize
	bb.Append(atext.GetBytes(fTextEncoding))
	ts.Initialize
	Dim fi As TPDFFontInfo=fFontsInfos.Get(calcFontKey(fContext.fFontFamily,fContext.fFontStyle)).As(TPDFFontInfo)
	Dim w As Double
	For i=0 To bb.Length-1
		w=w+fi.fCharsWidths(ToUnsigned(bb.InternalBuffer(i)))
	Next
	ts.fWidth=w*fContext.fFontSize/1000/fUnitFactor
	ts.fTop=fi.fYTop*fContext.fFontSize/1000/fUnitFactor
	ts.fBottom=fi.fYBottom*fContext.fFontSize/1000/fUnitFactor
	ts.fHeight=ts.fBottom-ts.fTop
	Return ts
End Sub



'add line to TPDFMultilineTextSize and return rest of line 
private Sub MultilineTextSizeAddLine(amts As TPDFMultilineTextSize,ats As TPDFTextSize,atext As String,awidth As Double) As String
	Dim s As String
	If ats.fWidth>awidth Then
		Dim p As Int=atext.LastIndexOf(" ")
		If p=-1 Then
			p=atext.Length-1
		End If
		s=atext.SubString(p+1)
		atext=atext.SubString2(0,p)
	Else
		s=""
	End If
	amts.fparagraphs.Get(amts.fParagraphs.Size-1).As(List).Add(atext)
	amts.fHeight=amts.fHeight+ats.fHeight
	Return s
End Sub

'get the size of multiline text with the current font and size
public Sub gMultilineTextSize(awidth As Double,atext As String) As TPDFMultilineTextSize
	Dim mts As TPDFMultilineTextSize
	Dim ts As TPDFTextSize
	Dim c As Char
	Dim l As String=""
	mts.Initialize
	mts.fParagraphs.Initialize
	mts.fWidth=awidth
	'split text with CRLF
	Dim paragraphs() As String=Regex.Split(CRLF,atext)
	Dim p As String
	For j=0 To paragraphs.Length-1
		Dim lines As List
		lines.Initialize
		mts.fParagraphs.Add(lines)
		p=paragraphs(j)
		l=""
		For i=0 To p.Length-1
			c=p.CharAt(i)
			If Asc(c)>31 Then
				l=l & c
				ts=gTextSize(l)
				If ts.fWidth>awidth Then
					l=MultilineTextSizeAddLine(mts,ts,l,awidth)
				End If
			End If
		Next
		ts=gTextSize(l)
		l=MultilineTextSizeAddLine(mts,ts,l,awidth)
	Next

	Return mts
End Sub

public Sub sX(avalue As Double) As cPDF
	fContext.fX=avalue
	Return Me
End Sub

public Sub sY(avalue As Double) As cPDF
	fContext.fy=avalue
	Return Me
End Sub

public Sub gX As Double
	Return fContext.fX
End Sub

public Sub gy As Double
	Return fContext.fy
End Sub

'get the lib version
public Sub glibversion As String
	Return fLibVersion
End Sub