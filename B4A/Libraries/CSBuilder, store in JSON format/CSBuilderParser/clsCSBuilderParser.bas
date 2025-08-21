B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.5
@EndOfDesignText@
'CSBuilderParser
'dependencies :
' Core
' JSON
'parse a list of spans
'each span is a map with a span attribute, value (case unsentitive) can be :
' bold
' underline
' strikethrough
' size
' relativesize
' color
' backgroundcolor
' alignment
' verticalAlign
' scaleX
' typeface
' clickable
' text
' icon
' crlf
' image

'all the spans (except text,icon,crlf and image) can have a spans attribute which is a list of spans inside this span

'other attributes in span (case sensitive)
' bold : none
' underline : none 
' strikethrough : none 
' size 
'  size : (int) font size
' relativesize
'  proportion (float) multiplier of the current font size
' color
'  color (string) color (ARGB) in hexadecimal 
' backgroundcolor
'  backgroundColor (string) color (ARGB) in hexadecimal 
' alignment
'  alignment (string) NORMAL, OPPOSITE or CENTER
' verticalAlign
'  shift (int) pixel, automatically converted in dip (shift*1dip)
' scaleX
'  proportion (float) scale multiplier
' typeface
'  typeface (string) DEFAULT, DEFAULT_BOLD, MONOSPACE, SANS_SERIF or SERIF
'  style (string) BOLD, ITALIC, BOLD_ITALIC or NORMAL
' clickable
'  value (int, float, string) value send in the event
' text
'  text (string) text to display
' icon
'  code (string) hexadecimal code of the icon
'  font (string) MATERIALICONS or FONTAWESOME
' crlf : none
' image
'  filename (string) filename of the picture (in file.dirassets)
'  width (int) width of the displayed image in pixel, if not defined the width of the image is used
'  height (int) height of the displayed image in pixel, if not defined the height of the image is used
'  baseline (boolean) true or false to align the image with the baseline (true) or to the bottom (false)


Sub Class_Globals
	Private fCSBuilder As CSBuilder
	Private fModule As Object
	Private fEventName As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
'amodule : module  that will receives click event
'aeventname : prefix for the click event (_click will be add)
Public Sub Initialize(amodule As Object,aeventname As String)
	fModule=amodule
	fEventName=aeventname
End Sub

'return a CSBuilder from a JSON string which represents a list
public Sub parseJSON(astring As String) As CSBuilder
	Dim JP As JSONParser
	JP.Initialize(astring)
	Return parseList(JP.NextArray)
End Sub

'return a CSBuilder from a list
public Sub parseList(aspans As List) As CSBuilder
	parse(aspans,True)
	Return fCSBuilder.PopAll
End Sub

'enable click for a text element
public Sub clickEnalbleEvents(aobject As Object)
	fCSBuilder.EnableClickEvents(aobject)	
End Sub

private Sub parse(aspans As List,afirst As Boolean)
	If afirst Then
		fCSBuilder.Initialize
	End If
	For Each span As Map In aspans
		CallSub2(Me,"cs_" & span.Get("span"),span)
	Next
End Sub

private Sub cs_spans(aparams As Map)
	Dim l As List=aparams.GetDefault("spans",Null)
	If l.IsInitialized Then
		parse(l,False)
	End If
End Sub

private Sub cs_text(aparams As Map)
	Dim t As String=aparams.GetDefault("text","")
	If t<>"" Then
		fCSBuilder.Append(t)
	End If
End Sub

private Sub cs_bold(aparams As Map)
	fCSBuilder.Bold
	cs_spans(aparams)
	fCSBuilder.pop
End Sub

private Sub cs_underline(aparams As Map)
	fCSBuilder.underline
	cs_spans(aparams)
	fCSBuilder.pop
End Sub

private Sub cs_strikethrough(aparams As Map)
	fCSBuilder.Strikethrough
	cs_spans(aparams)
	fCSBuilder.pop
End Sub

private Sub cs_size(aparams As Map)
	fCSBuilder.Size(aparams.GetDefault("size",10))
	cs_spans(aparams)
	fCSBuilder.pop
End Sub

private Sub cs_relativeSize(aparams As Map)
	fCSBuilder.RelativeSize(aparams.GetDefault("proportion",1.0))
	cs_spans(aparams)
	fCSBuilder.pop
End Sub

private Sub cs_color(aparams As Map)
	fCSBuilder.color(HexToARGB(aparams.GetDefault("color","FF000000")))
	cs_spans(aparams)
	fCSBuilder.pop
End Sub

private Sub cs_backgoundColor(aparams As Map)
	fCSBuilder.BackgroundColor(HexToARGB(aparams.GetDefault("backgroundColor","FFFFFFFF")))
	cs_spans(aparams)
	fCSBuilder.pop
End Sub

private Sub cs_alignment(aparams As Map)
	fCSBuilder.Alignment("ALIGN_" & aparams.GetDefault("alignment","NORMAL"))
	cs_spans(aparams)
	fCSBuilder.pop
End Sub

private Sub cs_verticalAlign(aparams As Map)
	fCSBuilder.VerticalAlign(aparams.GetDefault("shift",0)*1dip)
	cs_spans(aparams)
	fCSBuilder.pop
End Sub

private Sub cs_scaleX(aparams As Map)
	fCSBuilder.ScaleX(aparams.GetDefault("proportion",1))
	cs_spans(aparams)
	fCSBuilder.pop
End Sub

private Sub cs_image(aparams As Map)
	Dim bmp As Bitmap=LoadBitmap(File.DirAssets,aparams.GetDefault("filename",""))
	fCSBuilder.image(bmp _
	                ,aparams.GetDefault("width",bmp.Width) _
					,aparams.GetDefault("height",bmp.Height) _
					,aparams.GetDefault("baseline",False))
End Sub

private Sub cs_clickable(aparams As Map)
	fCSBuilder.Clickable("csbp",aparams.GetDefault("value",""))
	cs_spans(aparams)
	fCSBuilder.pop
End Sub

private Sub cs_icon(aparams As Map)
	Dim f As Map=CreateMap("MATERIALICONS":Typeface.MATERIALICONS _
	                      ,"FONTAWESOME":Typeface.FONTAWESOME)
	fCSBuilder.Typeface(f.GetDefault(aparams.GetDefault("font","MATERIALICONS"),Null))
	fCSBuilder.Append(Chr(Bit.ParseInt(aparams.GetDefault("code","0"),16)))
	fCSBuilder.pop
End Sub

private Sub cs_typeface(aparams As Map)
	Dim f As Map=CreateMap("DEFAULT":Typeface.DEFAULT _
	                      ,"DEFAULT_BOLD":Typeface.DEFAULT_BOLD _
						  ,"MONOSPACE":Typeface.MONOSPACE _
						  ,"SANS_SERIF":Typeface.SANS_SERIF _
						  ,"SERIF":Typeface.SERIF)
	Dim s As Map=CreateMap("BOLD":Typeface.STYLE_BOLD _
	                      ,"ITALIC":Typeface.STYLE_ITALIC _
						  ,"BOLD_ITALIC":Typeface.STYLE_BOLD_ITALIC _
						  ,"NORMAL":Typeface.STYLE_NORMAL)
	fCSBuilder.Typeface(Typeface.CreateNew(f.Get(aparams.GetDefault("typeface","SERIF")) _
	                                      ,s.Get(aparams.GetDefault("style","NORMAL"))))
	cs_spans(aparams)
	fCSBuilder.pop
End Sub

private Sub cs_crlf(aparams As Map)
	fCSBuilder.Append(CRLF)
End Sub

'convert hexadecimal string (AARRGGBB) to color
private Sub HexToARGB(ahex As String) As Long
	Dim a,r,g,b As Int
	a = Bit.ParseInt(ahex.SubString2(0,2), 16)
	r = Bit.ParseInt(ahex.SubString2(2,4), 16)
	g = Bit.ParseInt(ahex.SubString2(4,6), 16)
	b = Bit.ParseInt(ahex.SubString2(6,8), 16)
	Return Colors.ARGB(a,r,g,b)
End Sub

'receive click and raise event
private Sub csbp_click(avalue As Object)
	CallSub2(fModule,fEventName & "_click",avalue)
End Sub