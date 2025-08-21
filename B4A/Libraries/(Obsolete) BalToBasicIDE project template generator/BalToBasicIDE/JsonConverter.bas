B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private jp As JSONParser
	Private templateFile As String = "Template.b4s"
	Private scalevarname As String= "g_scale"
	Private scalewidthname As String= "g_width"
	Private DefaultColor As String =  "0xFFF0F8FF" ' the magic color indicating the default
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Public Sub ConvertJsonToB4S(Dir As String, FileName As String) As Boolean
	Dim bfile As String = FileName.SubString2(0, FileName.Length - 8)  & "b4s" 'remove .bsl.json
	If File.Exists(Dir, bfile) Then
		File.Copy(Dir, bfile, Dir, bfile & ".bak")
		File.Delete(Dir, bfile)
	End If
	Dim jp As JSONParser
	jp.Initialize(File.ReadString(Dir, FileName))
	Dim jp As JSONParser
	jp.Initialize(File.ReadString(Dir, FileName))
	ConvertJson(Dir, bfile)
	Return True
End Sub

Sub ConvertJson(Dir As String, FileName As String)
	Dim writer As TextWriter
	writer.Initialize(File.OpenOutput(Dir, FileName, False))
	Dim prefix, suffix As String
	If File.Exists(File.DirApp, templateFile) Then
		Dim template As String = File.ReadString(File.DirApp, templateFile)		
		Dim arr() As String = Regex.Split("###INSERT_CONTROLS_HERE###", template)
		prefix = arr(0)
		suffix = arr(1)	
		writer.Write(prefix)
	End If
	Dim Json As Map = jp.NextObject
	
	' Variants
	Dim Variants As List = Json.Get("Variants")
	Dim Varmap As Map = Variants.Get(0)
	Dim Width As String = Varmap.Get("Width")	
	writer.WriteLine("REM Scale Controls To the layout screen Width.")
	writer.WriteLine("REM Note that fonts are scaled according To Density by Android")
	writer.WriteLine("Dim g_layoutdata(0)")
	writer.WriteLine(scalevarname & " = getlayoutvalues")
	writer.WriteLine("strsplit(g_layoutdata(), g_scale,',')")
	writer.WriteLine(scalevarname & " = g_layoutdata(0) / " & Width) ' write the layout scaling factor
	writer.WriteLine(scalewidthname & " = " & scalevarname & " * " & Width) ' write the layout scaling factor
	writer.WriteLine("")
	writer.WriteLine("")
	
	
	' layoutheader has list of control names in index order
	Dim LayoutHeader As Map = Json.Get("LayoutHeader")
	Dim ControlsHeaders As List
	ControlsHeaders.Initialize2(LayoutHeader.Get("ControlsHeaders"))
	Dim ControlNameToTypeMap As Map
	ControlNameToTypeMap.Initialize
	For i = 0 To ControlsHeaders.Size-1
		Dim cmap As Map = ControlsHeaders.Get(i)
		ControlNameToTypeMap.Put(cmap.Get("Name"), cmap.Get("DesignerType"))				
	Next	
	
	' designer scripts are in DesignerScript
	Dim Scripts As List = LayoutHeader.Get("DesignerScript")
	Dim Script As String = Scripts.Get(0)
	
	' the control details are in Data
	Dim Data As Map = Json.Get("Data")
	Dim Children As Map
	Children = Data.Get(":kids")
	For Each key In Children.Keys
		Dim Control As Map = Children.Get(key)
		Dim controlname As String = Control.Get("name")
		WriteControl(writer, controlname, ControlNameToTypeMap, Control, "")		
	Next	
	writer.Write(TranslateScript(Script))
	writer.Write(suffix)
	writer.Close
End Sub


Private Sub WriteControl(writer As TextWriter, controlname As String, ControlNameToTypeMap As Map, control As Map, parent As String)

	Dim text, left, top, width, height, visible, enable, isChecked, singleLine, textOff, textOn, wrap As String
	Dim Variant0 As Map = control.Get("variant0") ' top left width height
		
	Dim controltype As String = ControlNameToTypeMap.Get(controlname)
	If controltype = "ImageView" Then controltype = "Image" ' oversight in BasicIDE naming addImage instead of addImageView
	left = Variant0.Get("left") & "*" & scalevarname
	top = Variant0.Get("top") & "*" & scalevarname
	width = Variant0.Get("width") & "*" & scalevarname
	height = Variant0.Get("height") & "*" & scalevarname
	text = control.Get("text")
	visible = control.Get("visible")
	enable = control.Get("enable")
	isChecked = control.Get("isChecked")
	singleLine = control.Get("singleLine")
	textOff = control.Get("textOff")
	textOn = control.Get("textOn")
	wrap = control.Get("wrap")
	' background colour if present
	Dim drawable As Map = control.Get("drawable")
	Dim addcolor As Boolean = False
	If drawable.IsInitialized = True Then
		Dim color As Map = drawable.Get("color")
		If color.IsInitialized Then
			Dim colorstr As String = color.Get("Value")
			If colorstr <> DefaultColor Then
				Dim colornum As Int = ParseHexColor(colorstr)
				addcolor = True
			End If
		End If
	End If
	' text colour if present
	Dim textColor As Map = control.Get("textColor")
	Dim addtextcolor As Boolean = False
	If textColor.IsInitialized = True Then
		Dim textcolorstr As String = textColor.Get("Value")
		If textcolorstr <> DefaultColor Then
			Dim textcolornum As Int = ParseHexColor(textcolorstr)
			addtextcolor = True
		End If
	End If	
	
	writer.WriteLine("add" & controltype & "('" & controlname & "', " & left & ", " & top & ", " & width & ", " & height & ", '" & parent & "')")
	If text <> "null" And text <> "" Then writer.WriteLine("setText" & "('" & controlname & "', '" & text & "')")
	If visible <> "null" And visible <> "true" Then writer.WriteLine("setVisible" & "('" & controlname & "', " & visible & ")")
	If enable <> "null" And enable <> "true" Then writer.WriteLine("setEnable" & "('" & controlname & "', " & enable & ")")
	If isChecked <> "null" And isChecked = "true" Then writer.WriteLine("setChecked" & "('" & controlname & "', " & "true)")
	If singleLine <> "null" Then writer.WriteLine("setSingleLine" & "('" & controlname & "', " & singleLine & ")")
	If textOff <> "null" And textOff <> "" Then writer.WriteLine("setTextOff" & "('" & controlname & "', '" & textOff & "')")
	If textOn <> "null" And textOn <> "" Then writer.WriteLine("setTextOn" & "('" & controlname & "', '" & textOn & "')")
	If wrap <> "null" Then writer.WriteLine("setWrap" & "('" & controlname & "', " & wrap & ")")
	If addcolor Then writer.WriteLine("setColor" & "('" & controlname & "', 0, " & colornum & ")")
	If addtextcolor Then writer.WriteLine("setTextColor" & "('" & controlname & "', " & textcolornum & ")")
	
	writer.WriteLine("")
	
	Dim Children As Map
	Children = control.Get(":kids")
	If Children.IsInitialized = False Then Return
	For Each key In Children.Keys
		Dim control As Map = Children.Get(key)
		Dim controlkidname As String = control.Get("name")
		WriteControl(writer, controlkidname, ControlNameToTypeMap, control, controlname)		
	Next
			
End Sub

Sub ParseHexColor (s As String) As Int
	s = s.Replace("#", "").Replace("0x", "")
	Dim col As Int = 0
	If s.length = 6 Then
		col = Bit.Or(0xff000000, Bit.ParseInt(s, 16))
	Else If s.Length = 8 Then
		col = Bit.Or(Bit.ShiftLeft(Bit.ParseInt(s.SubString2(0, 2), 16), 24), Bit.ParseInt(s.SubString(2), 16))
	Else
		Log("JsonConverter: Invalid Color " & s)
	End If
	Return col
End Sub

Sub TranslateScript(script As String) As String
	Dim Dscript As DesignerScript
	Dscript.Initialize
	Dim sb As StringBuilder
	sb.Initialize
	Dim lines() As String  = Regex.Split(CRLF, script)
	lines(0) = "#" & lines(0)
	For Each line As String In lines		
		If Not(Dscript.DiscardLine(line)) Then
			line = Dscript.ReformatLine(line, scalevarname, scalewidthname)
			sb.Append(line).Append(CRLF)
		End If
	Next	
	Return sb.ToString
End Sub


