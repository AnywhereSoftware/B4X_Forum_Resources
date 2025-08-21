B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
Sub Class_Globals
	Private fthisDoc As JavaObject
	Private funit As Float
End Sub

'Initializes the object. You can add parameters to this method if needed.
'aunit "pts" : points
'      "mm"  : mm
Public Sub Initialize(aunit As String)
	fthisDoc.InitializeNewInstance("org.apache.pdfbox.pdmodel.PDDocument",Null)
	Select Case aunit
		Case "pts"
			funit=1
		Case "mm"
			funit=2.8346456692
	End Select
End Sub
'new page
'asize : "A0".."A5"
'aorientation : "P" = portait
'               "L" = landscape
public Sub newPage(asize As String,aorientation As String) As JavaObject
	Dim thisPage As JavaObject
	Dim size As JavaObject
	Dim w As Float
	Dim h As Float
	size.InitializeStatic("org.apache.pdfbox.pdmodel.common.PDRectangle")
	Select Case aorientation
		Case "P"
			w=size.GetFieldJO(asize).RunMethod("getWidth",Array())
			h=size.GetFieldJO(asize).RunMethod("getHeight",Array())
		Case "L"
			h=size.GetFieldJO(asize).RunMethod("getWidth",Array())
			w=size.GetFieldJO(asize).RunMethod("getHeight",Array())
	End Select
	Dim s As JavaObject
	s.InitializeNewInstance("org.apache.pdfbox.pdmodel.common.PDRectangle",Array(w,h))
	thisPage.InitializeNewInstance("org.apache.pdfbox.pdmodel.PDPage",Array(s))
	Return thisPage
End Sub
'add a page to the document
public Sub addPage(page As JavaObject)
	fthisDoc.RunMethod("addPage",Array(page))
End Sub
'get the page height
public Sub pageHeight(apage As JavaObject) As Float
	Dim mb As JavaObject
	mb=apage.RunMethod("getMediaBox",Null)
	Return mb.RunMethod("getHeight",Array())/funit
End Sub
'get the page width
public Sub pageWidth(apage As JavaObject) As Float
	Dim mb As JavaObject
	mb=apage.RunMethod("getMediaBox",Null)
	Return mb.RunMethod("getWidth",Array())/funit
End Sub
'create a font
public Sub createFont(aname As String) As JavaObject
	Dim pdfonttype As JavaObject
	pdfonttype.InitializeStatic("org.apache.pdfbox.pdmodel.font.PDType1Font")
	Return pdfonttype.GetFieldJO(aname)
End Sub
'load a font from a file
public Sub loadfont(aDirName As String,afilename As String) As JavaObject
	Dim PDType0Font As JavaObject
	PDType0Font.InitializeStatic("org.apache.pdfbox.pdmodel.font.PDType0Font")
	Dim ist As InputStream=File.OpenInput(aDirName,afilename)
	Dim o As JavaObject=PDType0Font.RunMethodJO("load",Array(fthisDoc,ist))
	ist.Close
	Return o
End Sub
'calc text width
public Sub stringWidth(afont As JavaObject,asize As Float,atext As String) As Float
	Return afont.runmethod("getStringWidth",Array(atext))/1000*asize/funit
End Sub
'draw a text at a position
public Sub drawText(acontent As JavaObject,afont As JavaObject,asize As Float,aleft As Float,atop As Float,atext As String)
	acontent.RunMethod("beginText",Null)
	acontent.RunMethod("setFont",Array(afont,asize))
	Dim l As Float=aleft*funit
	Dim t As Float=atop*funit
	acontent.RunMethod("newLineAtOffset",Array(l,t))
	acontent.RunMethod("showText",Array(atext))
	acontent.RunMethod("endText",Null)
End Sub
'draw a text at a position with alignment
'aalign : 0=left
'         1=center
'         2=right
public Sub drawTextAlign(acontent As JavaObject,afont As JavaObject,asize As Float,aleft As Float,atop As Float,atext As String,awidth As Float,aalign As Int,apadding As Float)
	Dim w As Float=stringWidth(afont,asize,atext)
	Dim l As Float
	Select Case aalign
		Case 0
			l=(aleft+apadding)*funit
		Case 1
			l=(aleft*funit)+((awidth*funit)-w*funit)/2
		Case 2
			l=(aleft+awidth-apadding)*funit-w*funit
	End Select
	acontent.RunMethod("beginText",Null)
	acontent.RunMethod("setFont",Array(afont,asize))
	Dim t As Float=atop*funit
	acontent.RunMethod("newLineAtOffset",Array(l,t))
	acontent.RunMethod("showText",Array(atext))
	acontent.RunMethod("endText",Null)
End Sub
'create content object
public Sub createContent(apage As JavaObject,aappend As Boolean) As JavaObject
	Dim content As JavaObject
	content.InitializeNewInstance("org.apache.pdfbox.pdmodel.PDPageContentStream",Array(fthisDoc,apage,aappend,False))
	Return content
End Sub
'closecontent object
public Sub closeContent(acontent As JavaObject) 
	acontent.RunMethod("close",Null)
End Sub
public Sub setStrokingColor(acontent As JavaObject,ared As Int,agreen As Int,ablue As Int)
	acontent.RunMethod("setStrokingColor",Array(ared,agreen,ablue))
End Sub
public Sub setNonStrokingColor(acontent As JavaObject,ared As Int,agreen As Int,ablue As Int)
	acontent.RunMethod("setNonStrokingColor",Array(ared,agreen,ablue))
End Sub
public Sub drawRect(acontent As JavaObject,aleft As Float,atop As Float,awidth As Float,aheight As Float)
	Dim l As Float=aleft*funit
	Dim t As Float=atop*funit
	Dim w As Float=awidth*funit
	Dim h As Float=aheight*funit
	acontent.runmethod("addRect",Array(l,t,w,h))
End Sub
public Sub stroke(acontent As JavaObject)
	acontent.RunMethod("stroke",Null)
End Sub
public Sub fill(acontent As JavaObject)
	acontent.RunMethod("fill",Null)
End Sub
public Sub fillAndStroke(acontent As JavaObject)
	acontent.RunMethod("fillAndStroke",Null)
End Sub
public Sub drawImage(acontent As JavaObject,abytes() As Byte,aname As String,aleft As Float,atop As Float,awidth As Float,aheight As Float)
	Dim o As JavaObject
	o.InitializeStatic("org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject")
	Dim i As JavaObject=o.RunMethod("createFromByteArray",Array(fthisDoc,abytes,aname))
	Dim l As Float=aleft*funit
	Dim t As Float=atop*funit
	Dim w As Float=awidth*funit
	Dim h As Float=aheight*funit
	acontent.RunMethod("drawImage",Array(i,l,t,w,h))
End Sub


public Sub bidi(atext As String) As String
	Dim o As JavaObject=Me
	Return o.RunMethod("bidiReorder",Array(atext))
End Sub

#IF JAVA
 import com.ibm.icu.text.*;
 public static String bidiReorder(String text)
    {
        try {
        Bidi bidi = new Bidi((new ArabicShaping(ArabicShaping.LETTERS_SHAPE)).shape(text), 127);
            bidi.setReorderingMode(0);
            return bidi.writeReordered(2);
        }
        catch (ArabicShapingException ase3) {
        	return text;
		}
    }
#End If

public Sub saveToFile(afilename As String)
	fthisDoc.RunMethod("save",Array(afilename))
End Sub
public Sub saveToStream(astream As OutputStream)
	fthisDoc.RunMethod("save",Array(astream))
End Sub
public Sub close
	fthisDoc.RunMethod("close",Null)
End Sub