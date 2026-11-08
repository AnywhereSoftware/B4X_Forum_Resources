B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#Region Definition
Sub Class_Globals
	Type info(platform As String, viewType As String, property As String, value As String, valueType As String, source As String)
	Type sortPair(keyword As String, val As Object)
	Private xui As XUI
	Private layoutReader As WiLLayoutReader	'ignore
	Private layoutWriter As WiLLayoutWriter	'ignore
	
	Private resourcesDir As String 'ignore
	Private BJL = 0, BAL = 1, BIL = 2 As Int	'ignore
	Private versions, genGroups, bilExtras, colors, clrNames, valueTypes, drawableTypes, hasDrawable, mainDrawables, dictionary As Map 		'ignore

	Private resources As Map 
	Private jparser As JSONParser	'ignore
	Private handled As Map
	
	Private headerList As List
	Private usesFontAwesome, usesMaterialIcons As Boolean	'ignore
	Private usesFiles, usesDesignerScript As List 
	Private hCenteredViews, vCenteredViews As Map

	Private allSources As List	'ignore
	Private currentPlatform As String
	Private currentTarget As String
	Private currentVariant As Int
	Private sourceVariants As List
	
	Private variantMaps, variantSpecs As List
	Private txtLayoutsDir As String
	Private writeJson As Boolean
End Sub

'Initializes the class and prepares the resources needed - no argument needed
Public Sub Initialize(writeJsonFile As Boolean)
	writeJson = writeJsonFile
	layoutReader.Initialize
	handled.Initialize
	usesFiles.initialize
	usesDesignerScript.Initialize
	hCenteredViews.Initialize
	vCenteredViews.Initialize
	headerList.Initialize
	valueTypes.initialize
	resourcesDir = File.DirAssets
		
'The following commented lines are to generate the resources for WiLXLayouts
'This is done once and then can be ignored since the resource file already exists
'	allSources.initialize	
'	analyze(inLayoutsDir, "defaults.bjl")
'	analyze(inLayoutsDir, "defaults.bal")
'	analyze(inLayoutsDir, "defaults.bil")
'
'	analyze(inLayoutsDir, "bjlviews.bjl")
'	analyze(inLayoutsDir, "balviews.bal")
'	analyze(inLayoutsDir, "bilviews.bil")
''
''	analyze(inLayoutsDir, "complex.bjl")
''	analyze(inLayoutsDir, "complex.bal")
''	analyze(inLayoutsDir, "complex.bil")
''	
'	File.WriteList(resourcesDir, "schema3.txt", allSources)
'	Log(allSources.size)
	
	prepareResources
End Sub
#end region

#Region Input processing

'Generates an map map of variants - the keys will be the variant ids and the values will be lists of generic views
Public Sub toTextMap(fromDir As String, fromFile As String) As Map
	currentPlatform = fromFile.SubString(fromFile.LastIndexOf(".") + 1)
	Dim filex As String = fromFile.SubString2(0, fromFile.LastIndexOf("."))
	Dim jsonMap As Map = layoutReader.ConvertBxlToMap(fromDir, fromFile)
	
	If writeJson Then 
		Try
			File.WriteString(fromDir, filex & "_" & currentPlatform & ".json", jsonMap.As(JSON).toString)
			Dim dirfile As String = GetCanonicalPath(fromDir, filex & "_" & currentPlatform & ".json")
			LogColor("WiLXLayouts generated: " & dirfile, xui.Color_RGB(220, 20, 60))
		Catch
			LogColor("ERROR could not write .json file (folder is missing or read only): " & dirfile, xui.Color_RGB(220, 20, 60))
		End Try
	End If
	
	getCenteredViews(jsonMap)
	
	getVariants(jsonMap)
	
	Dim dataMap As Map = jsonMap.Get("Data")
	Dim inputMap As Map = CreateMap()

	traverse(dataMap, inputMap)
	currentVariant = -1
	Dim outMap As Map = CreateMap()
	For Each variant As Map In sourceVariants
		currentVariant = currentVariant + 1
		Dim id As String
		If sourceVariants.Size > 1 Then 
			Dim scale As String = variant.Get("Scale")
			If scale.EndsWith(".0") Then scale = scale.As(Int)
			id = "_V" & currentVariant & "=" & scale & "_" & variant.Get("Width") & "X" & variant.Get("Height")
		End If
		Dim textList As List: textList.initialize
		For Each vwName As String In inputMap.Keys
			addViewToText(textList, inputMap.Get(vwName))
		Next
		outMap.Put(filex & id & "_" & currentPlatform, textList)
	Next
	Return outMap
End Sub

'Generates a .txt file description of the layout file found in fromDir/fromFile
'The output will be saved in the specified txtLayouts folder
'In the process it also creates an input .json file
'If you initialized WilConverter with "True" you'll find it in the same folder as the text file.
Public Sub toTextFile(fromDir As String, fromFile As String, txtLayoutsDir_ As String)
	txtLayoutsDir = txtLayoutsDir_
	
	currentPlatform = fromFile.SubString(fromFile.LastIndexOf(".") + 1)
	Dim filex As String = fromFile.SubString2(0, fromFile.LastIndexOf("."))
	Dim jsonMap As Map = layoutReader.ConvertBxlToMap(fromDir, fromFile)
	
	If writeJson Then 
		Try
			File.WriteString(txtLayoutsDir, filex & "_" & currentPlatform & ".json", jsonMap.As(JSON).toString)
			Dim dirfile As String = GetCanonicalPath(fromDir, filex & "_" & currentPlatform & ".json")
			LogColor("WiLXLayouts generated: " & dirfile, xui.Color_RGB(220, 20, 60))
		Catch
			LogColor("ERROR could not write .json file (folder is missing or read only): " & dirfile, xui.Color_RGB(220, 20, 60))
		End Try
	End If
	
	getCenteredViews(jsonMap)
	
	getVariants(jsonMap)
	
	Dim dataMap As Map = jsonMap.Get("Data")
	Dim inputMap As Map = CreateMap()

	traverse(dataMap, inputMap)
	currentVariant = -1
	For Each variant As Map In sourceVariants
		currentVariant = currentVariant + 1
		Dim id As String
		If sourceVariants.Size > 1 Then 
			Dim scale As String = variant.Get("Scale")
			If scale.EndsWith(".0") Then scale = scale.As(Int)
			id = "_V" & currentVariant & "=" & scale & "_" & variant.Get("Width") & "X" & variant.Get("Height")
		End If
		Dim textList As List: textList.initialize
		For Each vwName As String In inputMap.Keys
			addViewToText(textList, inputMap.Get(vwName))
		Next
		File.WriteList(txtLayoutsDir, filex & id & "_" & currentPlatform & ".txt", textList)
		Dim dirfile As String = GetCanonicalPath(txtLayoutsDir, filex & id & "_" & currentPlatform & ".txt")
		LogColor("WiLXLayouts generated: " & dirfile, xui.Color_RGB(220, 20, 60))
	Next
	Return
End Sub

Private Sub addViewToText(textList As List, inputPropMap As Map)
	For Each grp As String In genGroups.Keys
		If grp.StartsWith("spacer") Then
			If Not(textList.Get(textList.size - 1).As(String) = TAB) Then textList.Add(TAB)
		Else
			If grp = "name" Then
				handled.clear
				handled.Put("type", "")
				handled.Put("javaType", "")
				handled.Put("left", "")
				handled.Put("top", "")
				handled.Put("width", "")
				handled.Put("height", "")
				handled.Put("vanchor", "")
				handled.Put("hanchor", "")
				If textList.size > 0 And textList.Get(textList.size - 1).As(String).trim = "" Then textList.removeAt(textList.size - 1)
				textList.Add("'________________________________________")
			End If
			
			Dim vwType As String = inputPropMap.Get("csType")
			vwType = vwType.SubString(vwType.LastIndexOf(".") + 5)
			If vwType = "CustomView" Then vwType = inputPropMap.get("shortType")			
			Dim subName As String = grp & "Group"
						
			Dim result As String = CallSub3(Me, subName, vwType, inputPropMap)
			result = result.trim
			If result.Length > 0 Then textList.Add(result)
		End If
	Next
End Sub

Private Sub nameGroup(vwType As String, inputPropMap As Map) As String	'ignore
	Dim sb As StringBuilder: sb.Initialize
	Dim lst As List = genGroups.Get("name")
	For Each prp As String In lst
		Dim value As String = "?"
		Select prp
			Case "name"
				If vwType <> "Main" And vwType <> "Activity" Then value = inputPropMap.Get("name")
			Case "type"
				Select vwType
					Case "Activity": vwType = "Main"
					Case "EditText"
						Dim singleLine As String = inputPropMap.get("singleLine")
						If singleLine = "false" Then vwType = "TextArea"  Else vwType = "TextField"
					Case "TextView": vwType = "TextArea"
					Case "ProgressView": vwType = "ProgressBar"
					Case "SeekBar": vwType = "Slider"
					Case "Pane": vwType = "Panel"
					Case "ScrollPane": vwType = "ScrollView"
				End Select
				
				If currentPlatform = "bil" Then 
					If vwType = "Switch" Then
						Dim original As String = "CheckBox"
						If Not(inputPropMap.ContainsKey("contextMenu")) Then original = "ToggleButton"
						If inputPropMap.ContainsKey("selected") Then original = "ToggleButton"
						vwType = original
					End If
				End If
				value = vwType
			Case "rangeMin"
				If currentPlatform = "bil" Then 
					If inputPropMap.containsKey("maximumValue") Then 
						value = inputPropMap.GetDefault("minimumValue", 0)
						If IsNumber(value) Then value = value.As(Float)
					End If						
				Else
					If inputPropMap.containsKey("max") Then 
						value = inputPropMap.GetDefault("min", 0)
						If IsNumber(value) Then value = value.As(Float)
					End If						
				End If
			Case "rangeMax"
				If currentPlatform = "bil" Then 
					If inputPropMap.containsKey("maximumValue") Then 
						value = inputPropMap.GetDefault("maximumValue", 100)
						If IsNumber(value) Then value = value.As(Float)
					End If						
				Else
					If inputPropMap.containsKey("max") Then 
						value = inputPropMap.GetDefault("max", 100)
						If IsNumber(value) Then value = value.As(Float)
					End If
				End If
			Case "initial"
				If inputPropMap.containsKey("max") Or inputPropMap.containsKey("maximumValue") Then 
					value = inputPropMap.GetDefault("value", 0)
					If IsNumber(value) Then value = value.As(Float)
				Else if inputPropMap.containsKey("customProperties.Value") Then 
					value = inputPropMap.GetDefault("customProperties.Value", 0)
					If IsNumber(value) Then value = value.As(Float)
				End If
		End Select
		If value <> "?" Then sb.Append(prp).Append("=").Append(value).Append(TAB) 
	Next
	handled.Put("name", "")
	handled.Put("max", "")
	handled.Put("min", "")
	handled.Put("value", "")
	handled.Put("minimumValue", "")
	handled.Put("maximumValue", "")
	If sb.length > 0 Then sb.remove(sb.length -1, sb.length)
	Return sb.ToString
End Sub
	
Private Sub refsGroup(vwType As String, inputPropMap As Map) As String	'ignore
	Dim sb As StringBuilder: sb.Initialize
	Dim lst As List = genGroups.Get("refs")
	For Each prp As String In lst
		Dim value As String = "?"
		Select prp
			Case "parent"
				 value = inputPropMap.Get("parent")
				 If value = "Activity" Or value = "Main" Then value = "?"
				 If value = "" Then value = "?"
			Case "eventName"
				value = inputPropMap.Get("eventName")
				If value = "Activity" Then value = "Main"
			Case "tag"
				value = inputPropMap.GetDefault("tag", "?")
				If value = "" Then value = "?"
		End Select
		If value <> "?" Then sb.Append(prp).Append("=").Append(value).Append(TAB) 
	Next
	handled.Put("parent", "")
	handled.Put("eventName", "")
	handled.Put("tag", "")
	If sb.length > 0 Then sb.remove(sb.length -1, sb.length)
	Return sb.ToString
End Sub
	
Private Sub stateGroup(vwType As String, inputPropMap As Map) As String	'ignore
	If vwType = "Main" or vwType = "Activity" Then Return ""
	'state	enabled	visible	switch
	Dim sb As StringBuilder: sb.Initialize
	Dim lst As List = genGroups.Get("state")
	For Each prp As String In lst
		Dim value As String = "?"
		Select prp
			Case "enabled"
				value = inputPropMap.GetDefault("enabled", "")
				If value = "" Then 
					If Not(vwType = "ActivityIndicator" Or vwType = "Picker" Or vwType = "DatePicker") Then 
						value = "true"
					Else
						value = "?"
					End If
				End If
			Case "visible": value = inputPropMap.Get("visible")
			Case "switch"
				Dim zvalue As String = inputPropMap.getDefault("isChecked", "")
				If zvalue = "" Then zvalue = inputPropMap.getDefault("customProperties.Value", "")
				If zvalue = "" Then zvalue = inputPropMap.getDefault("selected", "")
				If zvalue = "" Then zvalue = inputPropMap.getDefault("checked", "")
				If zvalue = "" Then zvalue = inputPropMap.getDefault("pressed", "")
				If zvalue = "" And vwType = "SwiftButton" Then zvalue = "false"
				If currentPlatform = "bjl" And vwType = "Button" Then zvalue = "false"
				If currentPlatform = "bil" And vwType = "Button" Then zvalue = "false"
				If Not(IsNumber(zvalue)) Then 
					Select zvalue
						Case "": value = "?"
						Case "true": value = "on"
						Case "false": value = "off"
					End Select
				End If
		End Select
		If value <> "?" Then sb.Append(prp).Append("=").Append(value).Append(TAB) 
	Next
	handled.Put("enabled", "")
	handled.Put("visible", "")
	handled.Put("isChecked", "")
	handled.Put("selected", "")
	handled.Put("checked", "")
	handled.Put("pressed", "")
	handled.Put("customProperties.Value", "")
	If sb.length > 0 Then sb.remove(sb.length -1, sb.length)
	Return sb.ToString
End Sub
	
Private Sub otherGroup(vwType As String, inputPropMap As Map) As String	'ignore
	Dim sb As StringBuilder: sb.Initialize
	Dim lst As List = genGroups.Get("other")
	For Each prp As String In lst
		Dim value As String = "?"
		Select prp
			Case "contextMenu": value = inputPropMap.GetDefault("contextMenu", "?")
			Case "toolTip": value = inputPropMap.GetDefault("toolTip", "?")
			Case "extraCss": value = inputPropMap.GetDefault("extraCss", "?")
		End Select
		If value <> "?" And value <> "" Then sb.Append(prp).Append("=").Append(QUOTE).Append(value).Append(QUOTE).Append(CRLF) 
	Next
	handled.Put("contextMenu", "")
	handled.Put("toolTip", "")
	handled.Put("extraCss", "")
	If sb.length > 0 Then sb.remove(sb.length - 1, sb.length)
	Return sb.ToString
End Sub
	
Private Sub widthGroup(vwType As String, inputPropMap As Map) As String	'ignore
	Dim vwName As String = inputPropMap.Get("name")
	Dim sb As StringBuilder: sb.Initialize
	If vwType = "Main" or vwType = "Activity" Then
		Dim thisVariant As Map = sourceVariants.Get(currentVariant)
		sb.Append("width").Append("=").Append(thisVariant.Get("Width")).Append(TAB) 
	Else
		Dim lst As List = genGroups.Get("width")
		Dim hanchor As Int = inputPropMap.Get("variant" & currentVariant & ".hanchor")
		For Each prp As String In lst
			Dim value As String = "?"
			Select prp
				Case "width"
					Dim widthA As Int = inputPropMap.Get("variant" & currentVariant & ".width")
					If hanchor <> 2 Then value = widthA Else value = "*"
				Case "fromLeft"
					Dim leftA As Int = inputPropMap.Get("variant" & currentVariant & ".left")
					If hanchor = 0 Or hanchor = 2 Then value = leftA
				Case "fromRight"
					Dim rightA As Int = inputPropMap.Get("variant" & currentVariant & ".left")
					If hanchor = 1 Or hanchor = 2 Then value = rightA
				Case "hcentered"
					If hCenteredViews.get(0).As(Map).containsKey(vwName) Or hCenteredViews.get(currentVariant + 1).As(Map).containsKey(vwName) Then value = "ignoreFromLeft"
			End Select
			If value <> "?" Then sb.Append(prp).Append("=").Append(value).Append(TAB) 
		Next
	End If
	handled.Put("variant" & currentVariant & ".hanchor", "")
	handled.Put("variant" & currentVariant & ".width", "")
	handled.Put("variant" & currentVariant & ".left", "")
	If sb.length > 0 Then sb.remove(sb.length -1, sb.length)
	Return sb.ToString
End Sub
	
Private Sub heightGroup(vwType As String, inputPropMap As Map) As String	'ignore
	Dim vwName As String = inputPropMap.Get("name")
	Dim sb As StringBuilder: sb.Initialize
	If vwType = "Main" Or vwType = "Activity" Then
		Dim thisVariant As Map = sourceVariants.Get(currentVariant)
		sb.Append("height").Append("=").Append(thisVariant.Get("Height")).Append(TAB) 
	Else
		Dim lst As List = genGroups.Get("height")
		Dim vanchor As Int = inputPropMap.Get("variant" & currentVariant & ".vanchor")
		For Each prp As String In lst
			Dim value As String = "?"
			Select prp
				Case "height"
					Dim heightA As Int = inputPropMap.Get("variant" & currentVariant & ".height")
					If vanchor <> 2 Then value = heightA Else value = "*"
				Case "fromTop"
					Dim topA As Int = inputPropMap.Get("variant" & currentVariant & ".top")
					If vanchor = 0 Or vanchor = 2 Then value = topA
				Case "fromBottom"
					Dim bottomA As Int = inputPropMap.Get("variant" & currentVariant & ".top")
					If vanchor = 1 Or vanchor = 2 Then value = bottomA
				Case "vcentered"
					If vCenteredViews.get(0).As(Map).containsKey(vwName) Or vCenteredViews.get(currentVariant + 1).As(Map).containsKey(vwName) Then value = "ignoreFromTop"
			End Select
			If value <> "?" Then sb.Append(prp).Append("=").Append(value).Append(TAB)
	Next
	End If
	handled.Put("variant" & currentVariant & ".vanchor", "")
	handled.Put("variant" & currentVariant & ".height", "")
	handled.Put("variant" & currentVariant & ".top", "")
	If sb.length > 0 Then sb.remove(sb.length -1, sb.length)
	Return sb.ToString
End Sub

Private Sub backgroundGroup(vwType As String, inputPropMap As Map) As String	'ignore
	Dim sb As StringBuilder: sb.Initialize
	Dim lst As List = genGroups.Get("background")
	Select currentPlatform
		Case "bjl", "bil"
			For Each prp As String In lst
				Dim value As String = "?"
				Select prp
					Case "baseColor":
						Dim clr As String = inputPropMap.GetDefault("drawable.color", "")
						If clr = "" Then clr = inputPropMap.GetDefault("backgroundColor", "")
						If clr <> "" Then value = clrNames.GetDefault(clr, clr)
						'If value = "DEFAULT" Or value = "Transparent" Then value = "?"
					Case "gravity":
						Dim gravity As String = inputPropMap.GetDefault("drawable.gravity", "")
						If gravity <> "" Then value = gravity
					Case "file":
						Dim fileName As String = inputPropMap.GetDefault("drawable.file", "")
						If fileName <> "" Then value = QUOTE & fileName & QUOTE
					Case "gradient"
						Dim gradient As String = inputPropMap.GetDefault("drawable.orientation", "")
						If gradient <> "" Then value = gradient
					Case "firstColor"
						Dim firstColor As String = inputPropMap.GetDefault("drawable.firstColor", "")
						If firstColor <> "" Then value = clrNames.GetDefault(firstColor, firstColor)
					Case "secondColor"
						Dim secondColor As String = inputPropMap.GetDefault("drawable.secondColor", "")
						If secondColor <> "" Then value = clrNames.GetDefault(secondColor, secondColor)
					Case "alpha"
						Dim alpha As String = inputPropMap.GetDefault("alpha", "")
						If alpha <> "" Then 
							value = alpha
							If alpha = "1.0" Then value = "?"
						End If
				End Select
				If value <> "?" Then sb.Append(prp).Append("=").Append(value).Append(TAB) 
			Next
			
			handled.Put("drawable.color", "")
			handled.Put("backgroundColor", "")
			handled.Put("drawable.gravity", "")
			handled.Put("drawable.file", "")
			handled.Put("drawable.orientation", "")
			handled.Put("drawable.firstColor", "")
			handled.Put("drawable.secondColor", "")
			handled.Put("alpha", "")
		Case "bal"
			For Each prp As String In lst
				Dim value As String = "?"
				Select prp
					Case "baseColor":
						Dim clr As String = inputPropMap.GetDefault("drawable.color", "")
						If clr <> "" Then value = clrNames.GetDefault(clr, clr)
						'If value = "DEFAULT" Or value = "Transparent" Then value = "?"
					Case "gravity":
						Dim gravity As String = inputPropMap.GetDefault("drawable.gravity", "")
						If gravity <> "" Then 
							Select gravity
								Case "119": gravity = "Fill"
								Case "17": gravity = "Center"
								Case "51": gravity = "Left-Right"
							End Select
							value = gravity
						End If
					Case "file":
						Dim fileName As String = inputPropMap.GetDefault("drawable.file", "")
						If fileName <> "" Then value = QUOTE & fileName & QUOTE
					Case "gradient"
						Dim gradient As String = inputPropMap.GetDefault("drawable.orientation", "")
						If gradient <> "" Then value = gradient
					Case "firstColor"
						Dim firstColor As String = inputPropMap.GetDefault("drawable.firstColor", "")
						If firstColor <> "" Then value = clrNames.GetDefault(firstColor, firstColor)
					Case "secondColor"
						Dim secondColor As String = inputPropMap.GetDefault("drawable.secondColor", "")
						If secondColor <> "" Then value = clrNames.GetDefault(secondColor, secondColor)
					Case "alpha"
						Dim alpha As String = inputPropMap.GetDefault("drawable.alpha", "")
						If alpha <> "" Then 
							value = alpha
							If alpha = "1.0" Then value = "?"
						End If
				End Select
				If value <> "?" Then sb.Append(prp).Append("=").Append(value).Append(TAB) 
			Next
			handled.Put("drawable.color", "")
			handled.Put("drawable.gravity", "")
			handled.Put("drawable.file", "")
			handled.Put("drawable.orientation", "")
			handled.Put("drawable.firstColor", "")
			handled.Put("drawable.secondColor", "")
			handled.Put("drawable.alpha", "")
	End Select
	If sb.length > 0 Then sb.remove(sb.length -1, sb.length)
	Return sb.ToString
End Sub
	
Private Sub borderGroup(vwType As String, inputPropMap As Map) As String	'ignore
	Dim sb As StringBuilder: sb.Initialize
	Dim lst As List = genGroups.Get("border")
	Dim hasBorder As Boolean
	Select currentPlatform
		Case "bjl", "bil"
			For Each prp As String In lst
				Dim value As String = "?"
				Select prp
					Case "borderWidth":
						Dim wid As String = inputPropMap.GetDefault("borderWidth", "")
						If wid <> "" Then 
							value = wid.As(Int)
							If value <> "0" Then hasBorder = True
						End If
					Case "borderColor":
						Dim clr As String = inputPropMap.GetDefault("borderColor", "")
						If clr <> "" Then value = clrNames.GetDefault(clr, clr)
						If value = "DEFAULT" Or value = "Transparent" Then value = "?"
					Case "borderRadius":
						Dim rad As String = inputPropMap.GetDefault("cornerRadius", "")
						If rad <> "" Then value = rad.As(Int)
				End Select
				If value <> "?" Then sb.Append(prp).Append("=").Append(value).Append(TAB) 
			Next
			handled.Put("borderWidth", "")
			handled.Put("borderColor", "")
			handled.Put("cornerRadius", "")
			If Not(hasBorder) Then sb.initialize 
		Case "bal"
			For Each prp As String In lst
				Dim value As String = "?"
				Select prp
					Case "borderWidth":
						Dim wid As String = inputPropMap.GetDefault("drawable.borderWidth", "")
						If wid <> "" Then 
							value = wid.As(Int)
							If value <> "0" Then hasBorder = True
						End If
					Case "borderColor":
						Dim clr As String = inputPropMap.GetDefault("drawable.borderColor", "")
						If clr <> "" Then value = clrNames.GetDefault(clr, clr)
						If value = "DEFAULT" Or value = "Transparent" Then value = "?"
					Case "borderRadius":
						Dim rad As String = inputPropMap.GetDefault("drawable.cornerRadius", "")
						If rad <> "" Then value = rad.As(Int)
				End Select
				If value <> "?" Then sb.Append(prp).Append("=").Append(value).Append(TAB) 
			Next
			handled.Put("drawable.borderWidth", "")
			handled.Put("drawable.borderColor", "")
			handled.Put("drawable.cornerRadius", "")
			If Not(hasBorder) Then sb.initialize 
	End Select
	If sb.length > 0 Then sb.remove(sb.length -1, sb.length)
	Return sb.ToString
End Sub
	
Private Sub shadowGroup(vwType As String, inputPropMap As Map) As String	'ignore
	If Not(currentPlatform = "bjl") Then Return ""
	Dim sb As StringBuilder: sb.Initialize
	Dim lst As List = genGroups.Get("shadow")
	Dim isShadow As Boolean
	For Each prp As String In lst
		Dim value As String = "?"
		Select prp
			Case "shadowType"
				value = inputPropMap.getDefault("shadow.stype", "?")
				If value <> "0" Then isShadow = True
			Case "offsetX": value = inputPropMap.getDefault("shadow.offsetX", "?")
			Case "offsetY": value = inputPropMap.getDefault("shadow.offsetY", "?")
			Case "shadowColor": value = inputPropMap.getDefault("shadow.shadowColor", "?")
			Case "shadowRadius": value = inputPropMap.getDefault("shadow.radius", "?")
		End Select
		If IsNumber(value) Then value = value.As(Int)
		If value <> "?" Then sb.Append(prp).Append("=").Append(value).Append(TAB) 
	Next
	If Not(isShadow) Then sb.initialize 
	handled.Put("shadow.stype", "")
	handled.Put("shadow.offsetX", "")
	handled.Put("shadow.offsetY", "")
	handled.Put("shadow.shadowColor", "")
	handled.Put("shadow.radius", "")
	If sb.length > 0 Then sb.remove(sb.length -1, sb.length)
	Return sb.ToString
End Sub
	
Private Sub contentGroup(vwType As String, inputPropMap As Map) As String	'ignore
	Dim sb As StringBuilder: sb.Initialize
	Dim content As Object = inputPropMap.GetDefault("text", Null)
	If content <> Null Then 
		sb.Append("textContent").Append("=").Append(QUOTE).Append(content.as(String).replace(Chr(13) & Chr(10), "\n")).Append(QUOTE)
	End If
	handled.Put("text", "")
	Return sb.ToString
End Sub
	
Private Sub fontGroup(vwType As String, inputPropMap As Map) As String	'ignore
	Dim sb As StringBuilder: sb.Initialize
	Dim lst As List = genGroups.Get("font")
	Select currentPlatform
		Case "bjl"
			For Each prp As String In lst
				Dim value As String = "?"
				Select prp
					Case "fontName"
						value = inputPropMap.getDefault("font.fontName", "")
						If value = "" Then 
							value = inputPropMap.getDefault("fontAwesome", "")
							If value <> "" Then value = "fontAwesome"
						End If
						If value = "" Then 
							value = inputPropMap.getDefault("materialIcons", "")
							If value <> "" Then value = "materialIcons"
						End If
						If value = "" Or value = "DEFAULT" Then value = "?"
					Case "fontColor"
						Dim clr As String = inputPropMap.getDefault("textColor", "")
						If clr <> "" Then value = clrNames.GetDefault(clr, clr)
						If value = "DEFAULT" Or value = "Transparent" Then value = "?"
					Case "fontSize"
						value = inputPropMap.getDefault("font.fontSize", "?")
						If value <> "?" Then value = value.As(Int)
					Case "fontStyle"
						Dim bold As String = inputPropMap.getDefault("font.bold", "?")
						Dim italic As String = inputPropMap.getDefault("font.italic", "?")
						If bold = "true" And italic = "true" Then 
							value = "BOLD_ITALIC"
						else if bold = "true" Then 
							value = "BOLD"
						else If italic = "true" Then 
							value = "ITALIC"
						Else
							value = "NORMAL"
						End If
						If value = "NORMAL" Then value = "?"
				End Select
				If value <> "?" Then sb.Append(prp).Append("=").Append(value).Append(TAB) 
			Next
			handled.Put("font.fontName", "")
			handled.Put("fontAwesome", "")
			handled.Put("materialIcons", "")
			handled.Put("textColor", "")
			handled.Put("font.fontSize", "")
			handled.Put("font.bold", "")
			handled.Put("font.italic", "")
		Case "bal"
			For Each prp As String In lst
				Dim value As String = "?"
				Select prp
					Case "fontName"
						value = inputPropMap.getDefault("typeface", "")
						If value = "" Then 
							value = inputPropMap.getDefault("fontAwesome", "")
							If value <> "" Then value = "fontAwesome"
						End If
						If value = "" Then 
							value = inputPropMap.getDefault("materialIcons", "")
							If value <> "" Then value = "materialIcons"
						End If
						If value = "" Or value = "DEFAULT" Then value = "?"
					Case "fontColor"
						Dim clr As String = inputPropMap.getDefault("textColor", "")
						If clr <> "" Then value = clrNames.GetDefault(clr, clr)
						If value = "DEFAULT" Or value = "Transparent" Then value = "?"
					Case "fontSize"
						value = inputPropMap.getDefault("fontsize", "?")
						If value <> "?" Then value = value.As(Int)
					Case "fontStyle"
						value = inputPropMap.getDefault("style", "?")
						If value = "NORMAL" Then value = "?"
				End Select
				If value <> "?" Then sb.Append(prp).Append("=").Append(value).Append(TAB) 
			Next
			handled.Put("typeface", "")
			handled.Put("fontAwesome", "")
			handled.Put("materialIcons", "")
			handled.Put("textColor", "")
			handled.Put("fontsize", "")
			handled.Put("style", "")
		Case "bil"
			Dim fname As String = inputPropMap.getDefault("font.fontName", "")
			For Each prp As String In lst
				Dim value As String = "?"
				Select prp
					Case "fontName"
						If fname <>"" Then
							Dim w() As String = Regex.Split("-", fname)
							value = w(0)
						End If
						If value = "" Or value = "DEFAULT" Then value = "?"
					Case "fontColor"
						Dim clr As String = inputPropMap.getDefault("textColor", "")
						If clr <> "" Then value = clrNames.GetDefault(clr, clr)
						If value = "DEFAULT" Or value = "Transparent" Then value = "?"
					Case "fontSize"
						value = inputPropMap.getDefault("font.fontSize", "?")
						If value <> "?" Then value = value.As(Int)
					Case "fontStyle":
						If fname <>"" Then
							Dim w() As String = Regex.Split("-", fname)
							If w.Length > 1 Then value = w(1).toUpperCase
							If w.Length > 2 Then value = value & "_ITALIC"
						End If
				End Select
				If value <> "?" Then sb.Append(prp).Append("=").Append(value).Append(TAB) 
			Next
			handled.Put("font.fontName", "")
			handled.Put("fontAwesome", "")
			handled.Put("materialIcons", "")
			handled.Put("textColor", "")
			handled.Put("font.fontSize", "")
	End Select
	If sb.length > 0 Then sb.remove(sb.length -1, sb.length)
	Return sb.ToString
End Sub

Private Sub formatGroup(vwType As String, inputPropMap As Map) As String	'ignore
	Dim sb As StringBuilder: sb.Initialize
	Dim lst As List = genGroups.Get("format")
	Select currentPlatform
		Case "bjl"
			Dim align As String = inputPropMap.GetDefault("alignment", "")
			If align <> "" Then 
				If align.toUpperCase = "CENTER" Then align = "CENTER_CENTER"
				Dim w() As String = TwoParts("_", align)
				For Each prp As String In lst
					Dim value As String = "?"
					Select prp
						Case "vAlign": value = w(0).toUpperCase
						Case "hAlign": value = w(1).toUpperCase
						Case "wordWrap": value = inputPropMap.GetDefault("wrapText", "?")
						Case "ellipsis	": value = inputPropMap.GetDefault("ellipsize", "?")
					End Select
					If value <> "?" Then sb.Append(prp).Append("=").Append(value).Append(TAB) 
				Next
			End If
			handled.Put("alignment", "")
			handled.Put("wrapText", "")
			handled.Put("ellipsize", "")
		Case "bal"
			For Each prp As String In lst
				Dim value As String = "?"
				Select prp
					Case "vAlign"
						Dim valign As String = inputPropMap.GetDefault("vAlignment", "")
						If valign <> "" Then 
							If valign.StartsWith("CENTER") Then value = "CENTER" Else value = valign
						End If
						If value <> "" Then 
							If vwType = "EditText" And "false" = inputPropMap.GetDefault("singleLine", "") Then value = "?"
						End If
					Case "hAlign":
						Dim halign As String = inputPropMap.GetDefault("hAlignment", "")
						If halign <> "" Then 
							If halign.StartsWith("CENTER") Then value = "CENTER" Else value = halign
						End If
						If value <> "" Then 
							If vwType = "EditText" And "false" = inputPropMap.GetDefault("singleLine", "") Then value = "?"
						End If

					Case "wordWrap": value = inputPropMap.GetDefault("wrapText", "?")
					Case "ellipsis	": value = inputPropMap.GetDefault("ellipsize", "?")
				End Select
				If value <> "?" Then sb.Append(prp).Append("=").Append(value).Append(TAB) 
			Next
			handled.Put("vAlignment", "")
			handled.Put("hAlignment", "")
			handled.Put("wrapText", "")
			handled.Put("ellipsize", "")
		Case "bil"
			Dim align As String = inputPropMap.GetDefault("textAlignment", "")
			If align <> "" Then 
				For Each prp As String In lst
					Dim value As String = "?"
					Select prp
						Case "vAlign": value ="CENTER"
						Case "hAlign"
							Select align
								Case "0": value = "LEFT"
								Case "1": value = "CENTER"
								Case "2": value = "RIGHT"
							End Select
						Case "wordWrap": value = inputPropMap.GetDefault("wrapText", "?")
						Case "ellipsis	": value = inputPropMap.GetDefault("ellipsize", "?")
					End Select
					If value <> "?" Then sb.Append(prp).Append("=").Append(value).Append(TAB) 
				Next
			End If
			handled.Put("textAlignment", "")
			handled.Put("wrapText", "")
			handled.Put("ellipsize", "")
	End Select
	If vwType = "TextArea" Or vwType = "TextField" Or vwType = "TextView" Or vwType = "EditText" Then sb.initialize 
	If sb.length > 0 Then sb.remove(sb.length -1, sb.length)
	Return sb.ToString
End Sub
	
Private Sub editGroup(vwType As String, inputPropMap As Map) As String	'ignore
	Dim sb As StringBuilder: sb.Initialize
	Dim lst As List = genGroups.Get("edit")
	For Each prp As String In lst
		Dim value As String = "?"
		Select prp
			Case "editable": value = inputPropMap.GetDefault("editable", "?")
			Case "password"
				value = inputPropMap.GetDefault("password", "?")
				If value = "?" Then 
					value = inputPropMap.GetDefault("passwordMode", "?")
				End If
				If value <> "" Then 
					If vwType = "EditText" And "false" = inputPropMap.GetDefault("singleLine", "") Then value = "?"
				End If
		End Select
		If value <> "?" Then sb.Append(prp).Append("=").Append(value).Append(TAB) 
	Next
	handled.Put("singleLine", "")
	handled.Put("editable", "")
	handled.Put("password", "")
	handled.Put("passwordMode", "")
	If sb.length > 0 Then sb.remove(sb.length -1, sb.length)
	Return sb.ToString
End Sub
	
Private Sub promptGroup(vwType As String, inputPropMap As Map) As String	'ignore
	Dim sb As StringBuilder: sb.Initialize
	Dim prompt As Object = inputPropMap.GetDefault("prompt", Null)
	If prompt = Null Then prompt = inputPropMap.GetDefault("hint", Null)
	If prompt = Null Then prompt = inputPropMap.GetDefault("hintText", Null)
	If prompt = Null Then prompt = inputPropMap.GetDefault("customProperties.Hint", Null)
	If prompt <> Null And prompt <> "" Then 
		sb.Append("prompt").Append("=").Append(QUOTE).Append(prompt.as(String).replace(Chr(13) & Chr(10), "\n")).Append(QUOTE)
	End If
	If vwType = "Main" Or vwType = "Activity" Then
		Dim title As Object = inputPropMap.GetDefault("title", Null)
		If title <> Null And title <> "" Then 
			sb.Append("title").Append("=").Append(QUOTE).Append(title.as(String).replace(Chr(13) & Chr(10), "\n")).Append(QUOTE)
		End If
		handled.Put("title", "")
	End If
	handled.Put("prompt", "")
	handled.Put("hint", "")
	handled.Put("hintText", "")
	handled.Put("customProperties.Hint", "")
	Return sb.ToString
End Sub

Private Sub additionalGroup(vwType As String, inputPropMap As Map) As String	'ignore
	Dim bxlSchemas As Map = dictionary.Get(currentPlatform)
	Dim bxlProps As Map = bxlSchemas.Get(vwType)

	Dim sb As StringBuilder: sb.Initialize
	For Each prp As String In inputPropMap.Keys
		If handled.containsKey(prp) Then Continue
		Dim value As String = inputPropMap.Get(prp)
		If prp = "menuItems" Then value = value.replace(Chr(13) & Chr(10), "\n").Replace(TAB, "\t")
		If bxlProps.ContainsKey(prp) Then 
			If prp.StartsWith("customProperties") Then
				prp = prp.SubString(prp.IndexOf(".") + 1)
				If prp <> "csType" And prp <> "type" And prp <> "shortType" And prp <> "customType" Then 
					Dim c As String = prp.CharAt(0)
					prp = c.ToLowerCase & prp.SubString(1)
					sb.Append(prp).append("=").append(value.trim).append(CRLF)
				End If
			Else
				Dim defaultValx As Map = bxlProps.Get(prp)
				Dim defaultVal As String = defaultValx.Get("value")
				If Not(value = defaultVal) Then sb.Append(prp).append("=").append(value.trim).append(CRLF)
			End If
		End If
	Next
	If sb.length > 0 Then sb.remove(sb.length -1, sb.length)
	Return sb.ToString
End Sub

Private Sub traverse(mp As Map, inputMap As Map)
	Dim vname As String = mp.Get("name")
	For Each kw As String In mp.Keys
		Dim val As Object = mp.Get(kw)
		If kw = ":kids" Then
			For Each indexkw As String In val.as(Map).keys   'there is only one
				traverse(val.As(Map).get(indexkw), inputMap)
			Next
		Else if val Is Map And Not(val.As(Map).containsKey("ValueType")) Then
			For Each prp As String In val.As(Map).Keys
				Dim sval As Object = val.As(Map).Get(prp)
				processItem(vname, kw & "." & prp, sval, inputMap)
			Next
		Else
			processItem(vname, kw, val, inputMap)
		End If
	Next
End Sub

Private Sub processItem(vname As String, prop As String, val As Object, inputMap As Map)
	If val Is Map Then val = val.As(Map).getDefault("Value", "")
	If Not(inputMap.ContainsKey(vname)) Then inputMap.Put(vname, CreateMap())
	inputMap.Get(vname).As(Map).Put(prop, val)
End Sub

Private Sub getVariants(jsonMap As Map)		'ignore
	sourceVariants = jsonMap.get("Variants")
'	Log(sourceVariants) 'a list of three maps
	'(ArrayList) [{Scale=1.0, Width=600, Height=600}, {Scale=1.0, Width=800, Height=400}, {Scale=1.0, Width=400, Height=800}]
End Sub

Private Sub getCenteredViews(jsonMap As Map)		'ignore
	hCenteredViews.clear
	vCenteredViews.clear
	hCenteredViews.Put(0, CreateMap())
	vCenteredViews.Put(0, CreateMap())

	
	Dim LayoutHeader As Map = jsonMap.Get("LayoutHeader")
	Dim DesignerScript As List = LayoutHeader.Get("DesignerScript")
	For j = 0 To DesignerScript.Size - 1
		Dim varLine As String = DesignerScript.Get(j)
		Dim variantParts() As String = Regex.Split(Chr(10), varLine)
		Dim variantIndex As Int = j
		hCenteredViews.Put(variantIndex, CreateMap())
		vCenteredViews.Put(variantIndex, CreateMap())
		For i = 0 To variantParts.Length - 1
			Dim s As String = variantParts(i).Replace(" ", "")
			If s.Contains("HorizontalCenter") Then 
				Dim vwName As String = s.SubString2(0, s.IndexOf("."))
				Dim percent As String = s.SubString(s.IndexOf("=") + 1)
				If percent.StartsWith("50%") Then
					hCenteredViews.Get(variantIndex).As(Map).Put(vwName, "")
				End If
			End If
			If s.Contains("VerticalCenter") Then 
				Dim vwName As String = s.SubString2(0, s.IndexOf("."))
				Dim percent As String = s.SubString(s.IndexOf("=") + 1)
				If percent.StartsWith("50%") Then 
					vCenteredViews.Get(variantIndex).As(Map).Put(vwName, "")
				End If
			End If
		Next
	Next
End Sub

Private Sub newInfo (platform As String, viewType As String, property As String, value As String, valueType As String, source As String) As info
	Dim t1 As info
	t1.Initialize
	t1.platform = platform
	t1.viewType = viewType
	t1.property = property
	t1.value = value
	t1.valueType = valueType
	t1.source = source
	Return t1
End Sub
#end region

#Region Output processing

'Generates a layout file based on a map of lists - the result will be in toDir/toFile 
Public Sub mapToLayout(textMap As Map, toDir As String, toFile As String)
	currentTarget = toFile.SubString(toFile.LastIndexOf(".") + 1)
	Dim filex As String = toFile.SubString2(0, toFile.LastIndexOf("."))		'ignore

	currentVariant = 0
	variantMaps.initialize
	variantSpecs.initialize
	hCenteredViews.clear
	vCenteredViews.clear
	
	Dim variantNames As List: variantNames.Initialize
	For Each kw As String In textMap.Keys
		variantNames.Add(kw)
	Next
	
	Dim variantOrder As List: variantOrder.initialize
	Select textMap.size
		Case 1		'variants_bjl.txt or variants_V0=1_600X600_bjl.txt
			hCenteredViews.Put(0, CreateMap())
			vCenteredViews.Put(0, CreateMap())
			hCenteredViews.Put(1, CreateMap())
			vCenteredViews.Put(1, CreateMap())
			variantMaps.add(processVariant("","", textMap.get(variantNames.get(0))))
			variantOrder.Add(0)
			variantSpecs.Add(versions.get(currentTarget).As(Map).get("variants"))
		Case Else		'variants_*_bjl.txt
			For Each fname As String In variantNames
				Dim w() As String = Regex.Split("_", fname)
				If fname.startsWith(w(0) & "_") Then
					hCenteredViews.Put(currentVariant + 1, CreateMap())
					vCenteredViews.Put(currentVariant + 1, CreateMap())
					w = Regex.Split("_", fname)
					Dim variantScale As String = w(1)
					Dim q() As String = TwoParts("=", variantScale)
					If q(0).toUpperCase.StartsWith("V") Then q(0) = q(0).SubString(1)
					variantOrder.Add(q(0))
					variantMaps.add(processVariant("","", textMap.get(variantNames.get(0))))
					Dim dimen() As String = Regex.Split("X", w(2))
					variantSpecs.Add(CreateMap("Scale": q(1).As(Int), "Width": dimen(0).As(Int), "Height": dimen(1).As(Int)))
					currentVariant = currentVariant + 1
				End If
			Next
	End Select
	
	Dim sorted As List: sorted.initialize
	For i = 0 To variantMaps.Size - 1
		sorted.Add(newSortPair(variantOrder.Get(i), Array(variantSpecs.Get(i), variantMaps.Get(i))))
	Next
	sorted.SortType("keyword", True)

	Dim temp As List: temp.initialize
	For Each sp As sortPair In sorted
		Dim ar() As Object = sp.val
		temp.add(ar(0))
	Next
	variantSpecs = temp
	
	Dim ar() As Object = sorted.Get(0).As(sortPair).val
	Dim assembledMap As Map = ar(1)
	
	For i = 1 To variantMaps.Size - 1
		ar = sorted.Get(i).As(sortPair).val
		Dim vmp As Map = ar(1)
		For Each vw As String In vmp.Keys
			Dim masterMap As Map = assembledMap.Get(vw)
			Dim mpx As Map = vmp.Get(vw)
			Dim thisVariant As Map = mpx.get("variant0")
			masterMap.Put("variant" & i, thisVariant)
		Next
	Next

	'add empty ":kids" prop to main node and then re-locate the elements to the tree
	Dim mainNode As Map
	If assembledMap.ContainsKey("Activity") Then mainNode = assembledMap.Get("Activity") Else mainNode = assembledMap.Get("Main")
	mainNode.Put(":kids", CreateMap())
	For Each vw As String In assembledMap.keys
		If vw = "Activity" Or vw = "Main" Then Continue
		Dim prpsMap As Map = assembledMap.Get(vw)
		Dim parent As String = prpsMap.GetDefault("parent", "")
		If parent <> "" Then
			Dim parentProps As Map = assembledMap.Get(parent)
			If Not(parentProps.ContainsKey(":kids")) Then parentProps.Put(":kids", CreateMap())
			Dim kids As Map = parentProps.Get(":kids")
			kids.Put(kids.Size.As(String), prpsMap)
		End If
	Next

	Dim layoutMap As Map = createFinalMap(assembledMap)
	Dim jsonString As String = layoutMap.As(JSON).ToString
	If writeJson Then 
		File.WriteString(toDir, filex & "_" & currentTarget & ".json", jsonString)
		Dim dirfile As String = GetCanonicalPath(toDir, filex & "_" & currentTarget & ".json")
		LogColor("WiLXLayouts generated: " & dirfile, xui.Color_RGB(220, 20, 60))
	End If

	layoutWriter.Initialize(currentTarget = "bil")
	File.Delete(toDir, toFile)
	layoutWriter.ConvertJsonToBxl(jsonString, toDir, toFile)
	Dim dirfile As String = GetCanonicalPath(toDir, toFile)
	LogColor("WiLXLayouts generated: " & dirfile, xui.Color_RGB(220, 20, 60))
End Sub

'Generates a .bjl .bal .bil file based on the txt file found in fromDir/fromFile
'The output will be saved in the specified toDir/toFile - platform is derived from the toFile extension
'In the process it also creates an output .json file
'If you initialized WilConverter with "True" you'll find it in the same folder as the text file.
Public Sub toLayoutFile(FromDir, fromFile, toDir As String, toFile As String)	'ignore
	currentTarget = toFile.SubString(toFile.LastIndexOf(".") + 1)
	Dim filex As String = toFile.SubString2(0, toFile.LastIndexOf("."))		'ignore
	Dim w() As String = Regex.Split("_", fromFile)

	currentVariant = 0
	variantMaps.initialize
	variantSpecs.initialize
	hCenteredViews.clear
	vCenteredViews.clear
	Dim emptyList As List: emptyList.initialize
	
	Dim variantOrder As List: variantOrder.initialize
	Select w.Length
		Case 2		'variants_bjl.txt
			hCenteredViews.Put(0, CreateMap())
			vCenteredViews.Put(0, CreateMap())
			hCenteredViews.Put(1, CreateMap())
			vCenteredViews.Put(1, CreateMap())
			variantMaps.add(processVariant(FromDir, fromFile, emptyList))
			variantOrder.Add(0)
			variantSpecs.Add(versions.get(currentTarget).As(Map).get("variants"))
		Case 3		'variants_*_bjl.txt
			Dim lst As List = File.ListFiles(FromDir)
			For Each fname As String In lst
				If fname.startsWith(w(0) & "_") Then
					hCenteredViews.Put(currentVariant + 1, CreateMap())
					vCenteredViews.Put(currentVariant + 1, CreateMap())
					w = Regex.Split("_", fname)
					Dim variantScale As String = w(1)
					Dim q() As String = TwoParts("=", variantScale)
					If q(0).toUpperCase.StartsWith("V") Then q(0) = q(0).SubString(1)
					variantOrder.Add(q(0))
					variantMaps.add(processVariant(FromDir, fname, emptyList))
					Dim dimen() As String = Regex.Split("X", w(2))
					variantSpecs.Add(CreateMap("Scale": q(1).As(Int), "Width": dimen(0).As(Int), "Height": dimen(1).As(Int)))
					currentVariant = currentVariant + 1
				End If
			Next
		Case 4		'variants_V0=1_600X600_bjl.txt
			hCenteredViews.Put(0, CreateMap())
			vCenteredViews.Put(0, CreateMap())
			hCenteredViews.Put(1, CreateMap())
			vCenteredViews.Put(1, CreateMap())
			Dim variantScale As String = w(1)
			Dim q() As String = TwoParts("=", variantScale)
			If q(0).toUpperCase.StartsWith("V") Then q(0) = q(0).SubString(1)
			variantOrder.Add(q(0))
			variantMaps.add(processVariant(FromDir, fromFile, emptyList))
			Dim dimen() As String = Regex.Split("X", w(2))
			variantSpecs.Add(CreateMap("Scale": q(1), "Width": dimen(0), "Height": dimen(1)))
	End Select
	
	Dim sorted As List: sorted.initialize
	For i = 0 To variantMaps.Size - 1
		sorted.Add(newSortPair(variantOrder.Get(i), Array(variantSpecs.Get(i), variantMaps.Get(i))))
	Next
	sorted.SortType("keyword", True)


	Dim temp As List: temp.initialize
	For Each sp As sortPair In sorted
		Dim ar() As Object = sp.val
		temp.add(ar(0))
	Next
	variantSpecs = temp
	
	Dim ar() As Object = sorted.Get(0).As(sortPair).val
	Dim assembledMap As Map = ar(1)
	
	For i = 1 To variantMaps.Size - 1
		ar = sorted.Get(i).As(sortPair).val
		Dim vmp As Map = ar(1)
		For Each vw As String In vmp.Keys
			Dim masterMap As Map = assembledMap.Get(vw)
			Dim mpx As Map = vmp.Get(vw)
			Dim thisVariant As Map = mpx.get("variant0")
			masterMap.Put("variant" & i, thisVariant)
		Next
	Next

	'add empty ":kids" prop to main node and then re-locate the elements to the tree
	Dim mainNode As Map
	If assembledMap.ContainsKey("Activity") Then mainNode = assembledMap.Get("Activity") Else mainNode = assembledMap.Get("Main")
	mainNode.Put(":kids", CreateMap())
	For Each vw As String In assembledMap.keys
		If vw = "Activity" Or vw = "Main" Then Continue
		Dim prpsMap As Map = assembledMap.Get(vw)
		Dim parent As String = prpsMap.GetDefault("parent", "")
		If parent <> "" Then
			Dim parentProps As Map = assembledMap.Get(parent)
			If Not(parentProps.ContainsKey(":kids")) Then parentProps.Put(":kids", CreateMap())
			Dim kids As Map = parentProps.Get(":kids")
			kids.Put(kids.Size.As(String), prpsMap)
		End If
	Next

	Dim layoutMap As Map = createFinalMap(assembledMap)
	Dim jsonString As String = layoutMap.As(JSON).ToString
	If writeJson Then 
		File.WriteString(toDir, filex & "_" & currentTarget & ".json", jsonString)
		Dim dirfile As String = GetCanonicalPath(toDir, filex & "_" & currentTarget & ".json")
		LogColor("WiLXLayouts generated: " & dirfile, xui.Color_RGB(220, 20, 60))
	End If

	layoutWriter.Initialize(currentTarget = "bil")
	File.Delete(toDir, toFile)
	layoutWriter.ConvertJsonToBxl(jsonString, toDir, toFile)
	Dim dirfile As String = GetCanonicalPath(toDir, toFile)
	LogColor("WiLXLayouts generated: " & dirfile, xui.Color_RGB(220, 20, 60))
End Sub

Private Sub processVariant(FromDir As String, fromFile As String, textList As List) As Map
	If textList.Size = 0 Then 
		If Not(File.Exists(FromDir, fromFile)) Then 
			Dim fpath As String = GetCanonicalPath(FromDir, fromFile)
			LogColor("ERROR: File not found '" & fpath & "'", xui.Color_Blue)
			ExitApplication
		End If
		Dim textLines As List = File.ReadList(FromDir, fromFile)
	Else
		textLines = textList
	End If
	
	Dim textViews As Map = parseVariant(textLines)

	Dim bxlSchemas As Map = dictionary.Get(currentTarget)
	Dim platformDrawableTypes As Map = drawableTypes.Get(currentTarget)
	Dim platformDrawables As Map = hasDrawable.Get(currentTarget)
	Dim thisMainDrawables As Map = mainDrawables.Get(currentTarget)
	
	handled.clear
	usesFiles.clear
	usesDesignerScript.clear

	'add Main or Activity from bxlSchemas and drawables
	Dim mainMap As Map = bxlSchemas.GetDefault("Main", CreateMap())
	If mainMap.size = 0 Then mainMap = bxlSchemas.GetDefault("Activity", CreateMap())
	

'This is needed for 3-level font props in bil
	Dim fontGroupStr As String = $"
{"font": {
	"csType": "Dbasic.Designer.FontGrid",
	"type": "B4IFontWrapper",
	"fontName": "DEFAULT",
	"fontSize": {
		"ValueType": 7,
		"Value": 17
	}
}}
"$

	Dim mainProps As Map = CreateMap()
	Dim mainTypes As Map = CreateMap()
	For Each prp As String In mainMap.Keys
		If currentTarget = "bil" Then 
			If prp = "backgroundColor" Then
				Dim thisViewProps As Map = textViews.GetDefault("", CreateMap())
				Dim clr As String = thisViewProps.GetDefault("basecolor", "")
				If clr <> "" Then 
					mainProps.Put(prp, colors.GetDefault(clr.toLowerCase, clr))
					mainTypes.Put(prp, 6)
				Else
					Dim mp As Map = mainMap.Get(prp)
					mainProps.Put(prp, mp.Get("value"))
					mainTypes.Put(prp, mp.Get("valueType"))
				End If
			Else if prp.EndsWith(".font") Then				
				mainProps.Put(prp, fontGroupStr)
				mainTypes.Put(prp, -1)
			Else
				Dim mp As Map = mainMap.Get(prp)
				mainProps.Put(prp, mp.Get("value"))
				mainTypes.Put(prp, mp.Get("valueType"))
			End If
		Else
			Dim mp As Map = mainMap.Get(prp)
			mainProps.Put(prp, mp.Get("value"))
			mainTypes.Put(prp, mp.Get("valueType"))
		End If
	Next

	For Each kw As String In thisMainDrawables.Keys  'there is only one ("Main" or "Activity")
		Dim lst As List = thisMainDrawables.Get(kw)
		For Each ar() As String In lst
			If ar(0) = "drawable.color" Then 
				Dim thisViewProps As Map = textViews.GetDefault("", CreateMap())
				Dim clr As String = thisViewProps.GetDefault("basecolor", "")
				If clr <> "" Then ar(1) = colors.GetDefault(clr.toLowerCase, clr)
			End If
			mainProps.Put(ar(0), ar(1))
			Dim valueT As Int = 0
			If ar(1).StartsWith("0x") Then valueT = 6
			If IsNumber(ar(1)) Then valueT = 7
			mainTypes.Put(ar(0), valueT)
		Next
	Next

	Dim thisViewProps As Map = textViews.GetDefault("", CreateMap())
	If thisViewProps.ContainsKey("title") Then
		mainProps.Put("title", thisViewProps.get("title").As(String).Replace(QUOTE, ""))
	End If
		
	Dim reStructuredProps As Map = CreateMap()
	restructure(reStructuredProps, mainProps, mainTypes)
	Dim assembledMap As Map = CreateMap()
	assembledMap.Put(mainProps.Get("name"), reStructuredProps)

	'add the rest of the views
	For Each vw As String In textViews.Keys
		Dim viewMap As Map = textViews.Get(vw)
		Dim txtType As String = viewMap.Get("type")
		Dim useEditTextA As Boolean
		If currentTarget = "bal" Then 
			If txtType = "TextArea" Then 
				useEditTextA = True
				txtType = "EditText"
			End If
			If txtType = "TextField" Then txtType = "EditText"
			If txtType = "Slider" Then txtType = "SeekBar"
		Else If currentTarget = "bjl" Then 
			If txtType = "Panel" Then txtType = "Pane"
			If txtType = "ScrollView" Then txtType = "ScrollPane"
		Else If currentTarget = "bil" Then 
			If txtType = "ToggleButton" Or txtType = "CheckBox" Then txtType = "Switch"
			If txtType = "TextArea" Then txtType = "TextView"
			If txtType = "ProgressBar" Then txtType = "ProgressView"
		End If
		viewMap.Put("type", txtType)
		Dim txtType As String = viewMap.Get("type")
		If currentPlatform = "bal" And txtType = "Main" Then txtType = "Activity"
		
		
		Dim defaultProps As Map = CreateMap()
		If useEditTextA Then 
			Dim bxlProps As Map = bxlSchemas.GetDefault("EditTextA", CreateMap())
		Else
			Dim bxlProps As Map = bxlSchemas.GetDefault(txtType, CreateMap())
		End If
		If bxlProps.Size = 0 Then 
			Log(txtType & " is not available in target platform")
			viewMap.Put("textcontent", viewMap.get("name") & CRLF & "View " & txtType & " is N/A")
			viewMap.Put("halign", "CENTER")
			viewMap.Put("valign", "CENTER")
			viewMap.Put("borderwidth", 2)
			viewMap.Put("bordercolor", "Gray")
			viewMap.Put("borderradius", 0)
			viewMap.Put("fontcolor", "Crimson")
			viewMap.Put("fontstyle", "BOLD")
			viewMap.Put("fontsize", 14)
			viewMap.Put("basecolor", "0xCCFFFFFF")
			txtType = "Label"
			Dim bxlProps As Map = bxlSchemas.GetDefault("Label", CreateMap())
		End If
		Dim valueTypeProps As Map = CreateMap()
		For Each prp As String In bxlProps.Keys
			Dim mp As Map = bxlProps.Get(prp)
			Dim value As String = mp.Get("value")
			If prp = "menuItems" Then value = value.Replace("\n", Chr(13) & Chr(10)).Replace("\t", TAB)
'			If prp = "left" Or prp = "top" Then 
'				If viewMap.ContainsKey("hcentered") Or viewMap.ContainsKey("vcentered") Then value = 10
'			End If

			defaultProps.Put(prp, value)
			valueTypeProps.Put(prp, mp.Get("valueType"))
		Next
		
		Dim isCustom As Boolean = defaultProps.ContainsKey("shortType")
		
		Dim hasDrawableType As Int = platformDrawables.GetDefault(txtType, -1)
		Dim thisDrawableType As String = "*"
		Select hasDrawableType
			Case 9
				If viewMap.ContainsKey("file") Then 
					thisDrawableType = "BitmapDrawable"
				Else If viewMap.ContainsKey("gradient") Then 
					thisDrawableType = "GradientDrawable"
				Else
					thisDrawableType = "ColorDrawable"
				End If
			Case 2
				thisDrawableType = "BitmapDrawable"
			Case 4
				thisDrawableType = "DefaultDrawable"	
			Case 0
				thisDrawableType = "Main"
		End Select
		If thisDrawableType <> "*" Then 
			Dim drawableLines As List = platformDrawableTypes.Get(thisDrawableType)
			For Each ar() As String In drawableLines
				Dim value As String = ar(1)
'				If ar(0) = "drawable.gravity" And currentTarget = "bjl" Then Continue
				If ar(0) = "drawable.color" And currentTarget = "bal" Then 
					If value  = "0x00FFFFFF" And txtType = "CheckBox" Then value = "0xFFF0F8FF"
				End If
				If ar(0) = "drawable.borderColor" And currentTarget = "bal" Then 
					If value  = "0xFF000000" And txtType = "ScrollView" Then value = "0xFFF0F8FF"
				End If
				If ar(0) = "drawable.colorKey" Then 
					If txtType = "Pane" Or txtType = "Label" Or isCustom Then value  = "-fx-background-color" Else value = "-fx-base"
				End If
				defaultProps.Put(ar(0), value)
				Dim vtype As Int = 0
				If ar(1).StartsWith("0x") Then vtype = 6
				If IsNumber(ar(1)) Then vtype = 7
				valueTypeProps.Put(ar(0), vtype)
			Next
		End If

		'collect updated props from text file - by updating existing values we ensure that the appropriate defaults are in place
		Dim targetProps As Map = CreateMap()
		For Each prp As String In viewMap.Keys
			updatedProps(prp, viewMap, targetProps, defaultProps)
		Next
		
		'update the default map, but only if the default map contains the key - this ensures the target has only props it can recognize
		For Each prp As String In targetProps.Keys
			If defaultProps.ContainsKey(prp) Then defaultProps.Put(prp, targetProps.Get(prp))
		Next
		If currentTarget = "bjl" And defaultProps.ContainsKey("drawable.file") Then 
			If defaultProps.Get("drawable.file").As(String).Trim = "" Then defaultProps.remove("drawable.gravity")
		End If

		Dim reStructuredProps As Map = CreateMap()
		restructure(reStructuredProps, defaultProps, valueTypeProps)
		assembledMap.Put(vw, reStructuredProps)
	Next
	
	assembledMap.Remove("")
	Return assembledMap
End Sub


Private Sub createFinalMap(assembledMap As Map) As Map
	Dim layoutMap As Map: layoutMap.Initialize
	Dim layoutHeader As Map = CreateMap()

	Dim systemMap As Map = versions.get(currentTarget)
	Dim versionNumber As Int = systemMap.get("version")
	Dim gridSize As Int = systemMap.get("grid")
	
	Dim variants As List: variants.initialize
	For Each spec As Map In variantSpecs
		variants.Add(spec)
	Next
	
	layoutHeader.Put("Version", versionNumber)
	layoutHeader.Put("GridSize", gridSize)
	
	Dim controlsHeaders As List: controlsHeaders.Initialize
	headerList.clear
	usesDesignerScript.clear

	For Each kw As String In assembledMap.keys
		Dim kid As Map = assembledMap.Get(kw)
		Dim name As String = kid.Get("name")
		Dim javaType As String = kid.Get("javaType")
		Dim csType As String = kid.Get("csType")
		Dim shortType As String = csType.SubString(csType.LastIndexOf(".") + 5)
		If name = "Main" Then 
			If currentTarget = "bjl" Then 
				shortType = "Pane" 
			Else if currentTarget = "bal" Then
				shortType = "Activity"
			Else if currentTarget = "bil" Then
				shortType = "Panel"
			End If 
		End If
		If name <> "null" Then 
			If javaType.Contains("TextField") Then 
				headerList.add(newSortPair(name.toLowerCase, CreateMap("Name": name, "JavaType": javaType, "DesignerType": "TextField")))
			Else	
				headerList.add(newSortPair(name.toLowerCase, CreateMap("Name": name, "JavaType": javaType, "DesignerType": shortType)))
			End If
		End If
	Next
	
	headerList.SortType("keyword", True)
	For Each item As sortPair In headerList
		controlsHeaders.Add(item.val)
	Next
	layoutHeader.Put("ControlsHeaders", controlsHeaders)
	layoutHeader.Put("Files", usesFiles)
	
	
	'Determine if either horizontal or vertical centering is the same for all variants
	'Collect for each of allvar and spec var: a list of vw.script statements
	Dim collectedScripts(variantMaps.Size + 1) As List
	For i = 0 To collectedScripts.Length - 1
		collectedScripts(i).Initialize
	Next
	
	Dim firstHCentered As Map = CreateMap()
	Dim isHCAll As Boolean = True
	firstHCentered = hCenteredViews.Get(1)
	If firstHCentered.Size = 0 Then
		isHCAll = False
	Else
		For i = 2 To hCenteredViews.Size - 1
			Dim thisCentered As Map = hCenteredViews.Get(i)
			If thisCentered.as(String) <> firstHCentered.As(String) Then  'ignore
				isHCAll = False
				Exit
			End If
		Next
	End If

	Dim firstVCentered As Map = CreateMap()
	Dim isVCAll As Boolean = True
	firstVCentered = vCenteredViews.Get(1)
	If firstVCentered.Size = 0 Then
		isHCAll = False
	Else
		For i = 2 To vCenteredViews.Size - 1
			Dim thisCentered As Map = vCenteredViews.Get(i)
			If thisCentered.as(String) <> firstVCentered.As(String) Then  'ignore
				isVCAll = False
				Exit
			End If
		Next
	End If
	
	If isHCAll Then
		For Each vw As String In firstHCentered.Keys
			collectedScripts(0).Add(vw & ".z_HorizontalCenter = 50%x")
		Next
	Else
		For i = 1 To hCenteredViews.Size - 1
			Dim mp As Map = hCenteredViews.Get(i)
			For Each vw As String In mp.Keys
				collectedScripts(i).Add(vw & ".z_HorizontalCenter = 50%x")
			Next
		Next
	End If
	
	If isVCAll Then
		For Each vw As String In firstVCentered.Keys
			collectedScripts(0).Add(vw & ".VerticalCenter = 50%y")
		Next
	Else
		For i = 1 To vCenteredViews.Size - 1
			Dim mp As Map = vCenteredViews.Get(i)
			For Each vw As String In mp.Keys
				collectedScripts(i).Add(vw & ".VerticalCenter = 50%y")
			Next
		Next
	End If

	
	Dim lst As List = collectedScripts(0)
	lst.Sort(True)
	Dim sb As StringBuilder: sb.initialize
	If currentTarget = "bal" Or currentTarget = "bil" Then 
		sb.append($"'All variants script${Chr(10)}AutoScaleAll${Chr(10)}"$)
	Else
		sb.append($"'All variants script"$).append(Chr(10))
	End If
	For Each s As String In lst
		s = s.Replace(".z_", ".")
		sb.Append($"${s}${Chr(10)}"$)
	Next
	If lst.Size > 0 Then sb.Remove(sb.Length - 1, sb.length)
	usesDesignerScript.Add(sb.ToString)
	For i = 1 To collectedScripts.length - 1
		Dim lst As List = collectedScripts(i)
		lst.Sort(True)
		Dim sb As StringBuilder: sb.initialize
		Dim vmp As Map = variants.Get(i - 1)
		sb.append($"'Variant specific script: ${vmp.Get("Width")}x${vmp.Get("Height")},scale=${vmp.Get("Scale")}${Chr(10)}"$)
		For Each s As String In lst
			s = s.Replace(".z_", ".")
			Dim vmp As Map = variants.Get(i - 1)
			sb.Append($"${s}${Chr(10)}"$)
		Next
		usesDesignerScript.Add(sb.ToString)
	Next
	layoutHeader.Put("DesignerScript", usesDesignerScript)
	
	
	layoutMap.Put("LayoutHeader", layoutHeader)
	layoutMap.Put("Variants", variants)

	If currentTarget = "bjl" Then 
		layoutMap.Put("Data", assembledMap.Get("Main"))
	Else if currentTarget = "bal" Then 
		layoutMap.Put("Data", assembledMap.Get("Activity"))
	Else if currentTarget = "bil" Then 
		layoutMap.Put("Data", assembledMap.Get("Main"))
	End If

	layoutMap.Put("FontAwesome", usesFontAwesome)
	layoutMap.Put("MaterialIcons", usesMaterialIcons)
	
	Return layoutMap
End Sub

Private Sub restructure(reStructuredProps As Map, defaultProps As Map, valueTypeProps As Map)
		Dim sorted As List: sorted.initialize
		For Each kw As String In defaultProps.Keys
			Dim value As String = defaultProps.Get(kw)
			If kw = "csType" Or kw = "type"  Then kw = "A_" & kw
			If kw.Contains(".csType") Then kw = kw.Replace(".csType", ".A_csType") 
			If kw.Contains(".type") Then kw = kw.Replace(".type", ".A_type") 
			If kw.StartsWith("variant0") Then kw = "zz_" & kw
			sorted.Add(newSortPair(kw, value))
		Next
		sorted.SortTypeCaseInsensitive("keyword", True)

		Dim thisGroup, lastGroup As String
		Dim groupMap As Map = CreateMap()

		For Each sp As sortPair In sorted
			Dim prp As String = sp.keyword
			prp = prp.replace("A_", "").replace("zz_", "")
			Dim value As String = sp.val
			'Convert value to object type
			Dim obj As Object
'			Log(currentTarget & TAB & prp & TAB & value.Length  & TAB & valueTypeProps.Get(prp))
			Select valueTypeProps.Get(prp).As(Int)
				Case 6 'Colors
					obj = CreateMap("ValueType": 6, "Value": value)
				Case 7 'Integers
					If currentTarget = "bal" And (prp = "drawable.borderWidth" Or prp = "drawable.cornerRadius" Or prp = "drawable.gravity") Then 
						obj = value.As(Int)
					Else
						obj = CreateMap("ValueType": 7, "Value": value.As(Int))
					End If
				Case 8 'Floats
					obj = CreateMap("ValueType": 7, "Value": value.As(Float))
				Case 12
					If value = "" Then
						obj = CreateMap("ValueType": 12) 
					Else
						Dim lst As List: lst.initialize
						Dim v() As String = Regex.Split("\,", value)
						For i = 0 To v.length - 1
							lst.Add(v(i).Replace("[", "").Replace("]", "").trim.As(Int))
						Next
						obj = CreateMap("ValueType": 12, "Value": lst)
					End If
				Case -1
					jparser.Initialize(value)
					obj = jparser.NextObject.As(Map).Get("font")
				Case Else
					If value = "true" Or value = "false" Then 
						obj = value.As(Boolean) 
					Else If IsNumber(value) Then
						If value.Contains(".") Then obj = value.As(Float) Else obj = value.As(Int)
					Else
						obj = value
					End If
			End Select
			Dim v() As String = TwoParts(".", prp)
			thisGroup = v(0)
			Dim subprop As String = v(1)
			If thisGroup <> lastGroup Then 
				If groupMap.size > 0 Then 
					reStructuredProps.Put(lastGroup, groupMap)
					groupMap = CreateMap()
				End If
				If subprop = "" Then reStructuredProps.Put(prp, obj) Else groupMap.put(v(1), obj)
			Else
				groupMap.put(v(1), obj)
			End If
			lastGroup = thisGroup
		Next
		If groupMap.Size > 0 Then reStructuredProps.Put(lastGroup, groupMap)
		
		Dim variant As Map = reStructuredProps.Get("variant0")
		Dim unsortedVariant As Map = CreateMap()
		unsortedVariant.Put("left", variant.Get("left"))
		unsortedVariant.Put("top", variant.Get("top"))
		unsortedVariant.Put("width", variant.Get("width"))
		unsortedVariant.Put("height", variant.Get("height"))
		unsortedVariant.Put("hanchor", variant.Get("hanchor"))
		unsortedVariant.Put("vanchor", variant.Get("vanchor"))
		reStructuredProps.Put("variant0", unsortedVariant)
		Dim variant As Map = reStructuredProps.Get("variant0")
End Sub

Private Sub updatedProps(prp As String, viewMap As Map, targetProps As Map, defaultProps As Map)
	Dim targetProp As String = "?"
	Dim value As String = viewMap.Get(prp)
	value = value.Replace(QUOTE, "")
	Select prp
		Case "eventname"
			targetProps.Put("eventName", value)
		Case "type": Return
		Case "switch"
			If defaultProps.containsKey("customProperties.Value") Then 
				targetProps.Put("customProperties.Value", value.toLowerCase = "on")
			Else If defaultProps.containsKey("checked") Then
				targetProps.Put("checked", value.toLowerCase = "on")
			Else If defaultProps.containsKey("isChecked") Then
				targetProps.Put("isChecked", value.toLowerCase = "on")
			Else If defaultProps.containsKey("pressed") Then
				targetProps.Put("pressed", value.toLowerCase = "on")
			Else If defaultProps.containsKey("selected") Then
				targetProps.Put("selected", value.toLowerCase = "on")
			End If
		Case "width"
			Dim fromLeft As String = viewMap.GetDefault("fromleft", "")
			Dim fromRight As String = viewMap.GetDefault("fromright", "")
			Dim hcentered As String = viewMap.GetDefault("hcentered", "")
			If IsNumber(value) Then 
				targetProps.Put("variant0.width", value.As(Int))
				If hcentered = "" Then 
					If fromLeft <> "" Then 
						targetProps.Put("variant0.left", fromLeft.As(Int))
						targetProps.Put("variant0.hanchor", 0)
					Else If fromRight <> "" Then 
						targetProps.Put("variant0.left", fromRight.As(Int))
						targetProps.Put("variant0.hanchor", 1)
					End If
				Else					
					targetProps.Put("variant0.left", fromLeft.As(Int))
					targetProps.Put("variant0.hanchor", 0)
					hCenteredViews.get(currentVariant + 1).As(Map).Put(viewMap.Get("name"), True)
				End If
			Else
				targetProps.Put("variant0.left", fromLeft.As(Int))
				targetProps.Put("variant0.width", fromRight.As(Int))
				targetProps.Put("variant0.hanchor", 2)
			End If
		Case "height"
			Dim fromTop As String = viewMap.GetDefault("fromtop", "")
			Dim fromBottom As String = viewMap.GetDefault("frombottom", "")
			Dim vcentered As String = viewMap.GetDefault("vcentered", "")
			If IsNumber(value) Then
				targetProps.Put("variant0.height", value.As(Int))
				If vcentered = "" Then 
					If fromTop <> "" Then 
						targetProps.Put("variant0.top", fromTop.As(Int))
						targetProps.Put("variant0.vanchor", 0)
					Else If fromBottom <> "" Then 
						targetProps.Put("variant0.top", fromBottom.As(Int))
						targetProps.Put("variant0.vanchor", 1)
					End If
				Else
					targetProps.Put("variant0.top", fromTop.As(Int))
					targetProps.Put("variant0.vanchor", 0)
					vCenteredViews.get(currentVariant + 1).As(Map).Put(viewMap.Get("name"), True)
				End If
			Else
				targetProps.Put("variant0.top", fromTop.As(Int))
				targetProps.Put("variant0.height", fromBottom.As(Int))
				targetProps.Put("variant0.vanchor", 2)
			End If
		Case "fromleft", "fromtop", "fromright", "frombottom", "hcentered", "vcentered"
		Case "basecolor" 'handles alpha
			If defaultProps.containsKey("drawable.color") Then 
				targetProps.Put("drawable.color", colors.GetDefault(value.toLowerCase, value))
			Else If defaultProps.containsKey("backgroundColor") Then
				targetProps.Put("backgroundColor", colors.GetDefault(value.toLowerCase, value))
			End If
			Dim alpha As String = viewMap.GetDefault("alpha", "")
			If alpha <> "" Then targetProps.Put("alpha", alpha)
		Case "alpha"
		Case "file"  'handles gravity
			usesFiles.Add(value)
			targetProps.Put("drawable.file", value)
			Dim gravity As String = viewMap.GetDefault("gravity", "")
			If gravity = "" Then gravity = "fill"
			If currentTarget = "bal" Then
				Select gravity.toLowerCase
					Case "fill": gravity = "119"
					Case "center": gravity = "17"
					Case "left-right": gravity = "51"
				End Select
			Else
				Select gravity.toLowerCase
					Case "fill": gravity = "Fill"
					Case "center": gravity = "Center"
					Case "left-right": gravity = "Left-Right"
				End Select
			End If
			If gravity <> "" Then targetProps.Put("drawable.gravity", gravity)
		Case "gravity"
		Case "gradient" 'handles firstColor, secondColor
			targetProps.Put("drawable.orientation", value)
			If value <> "" Then 
				Dim firstColor As String = viewMap.GetDefault("firstcolor", "")
				Dim secondColor As String = viewMap.GetDefault("secondcolor", "")
				targetProps.Put("drawable.firstColor", colors.GetDefault(firstColor.toLowerCase, firstColor))
				targetProps.Put("drawable.secondColor", colors.GetDefault(secondColor.toLowerCase, secondColor))
			End If
		Case "firstcolor", "secondcolor"
		Case "fontname"
			Select value
				Case "fontawesome": targetProps.Put("fontAwesome", viewMap.GetDefault("textcontent", ""))
				Case "materialicons": targetProps.Put("materialIcons", viewMap.GetDefault("textcontent", ""))
				Case Else
					Select currentTarget
						Case "bjl": targetProps.Put("font.fontName", value)
						Case "bal": targetProps.Put("typeface", value)
						Case "bil"
							Dim fstyle As String = viewMap.GetDefault("fontstyle", "")
							If fstyle <> "" Then targetProps.Put("font.fontName", value & "-" & fstyle.Replace("_", "-"))
					End Select
			End Select
		Case "fontcolor"
			If defaultProps.ContainsKey("textColor") Then 
				value = colors.GetDefault(value.toLowerCase, value)
				targetProps.Put("textColor", value)
			End If
		Case "fontsize"
			If defaultProps.ContainsKey("font.fontSize") Then 
				targetProps.Put("font.fontSize", value)
			Else If defaultProps.ContainsKey("fontsize") Then
				targetProps.Put("fontsize", value)
			End If
		Case "fontstyle"
			Select currentTarget
				Case "bjl"
					targetProps.Put("font.bold", value.Contains("BOLD"))
					targetProps.Put("font.italic", value.Contains("ITALIC"))
				Case "bal"
					targetProps.Put("style", value)
				Case "bil"
					Dim fontname As String = targetProps.GetDefault("font.fontName", "")
					If fontname = "" Then fontname = "DEFAULT"
					If value.toUpperCase = "BOLD_ITALIC" Then 
						fontname = fontname & "-Bold-MTItalic"
					Else if value.toUpperCase = "BOLD" Then 
						fontname = fontname & "-Bold"
					Else if value.toUpperCase = "ITALIC" Then 
						fontname = fontname & "-MTItalic"
					End If
					value = fontname
					targetProps.Put("font.fontName", fontname)
			End Select
		Case "valign"
			value = value.ToUpperCase
			Select currentTarget
				Case "bjl"
					Dim align As String = value
					Dim hAlign As String = viewMap.GetDefault("halign", "")
					Dim align As String = align & "_" & hAlign
					If align.toUpperCase = "CENTER_CENTER" Then align = "CENTER"
					targetProps.Put("alignment", align) 
				Case "bal"
					If value.toUpperCase = "CENTER" Then 
						targetProps.Put("vAlignment", "CENTER_VERTICAL") 
					Else 
						targetProps.Put("vAlignment", value.toUpperCase)
					End If
				Case "bil"
					
			End Select
		Case "halign"
			value = value.ToUpperCase
			Select currentTarget
				Case "bjl"
				Case "bal"
					If value.toUpperCase = "CENTER" Then 
						targetProps.Put("hAlignment", "CENTER_HORIZONTAL") 
					Else 
						targetProps.Put("hAlignment", value.toUpperCase)
					End If
				Case "bil"
					If value.toUpperCase = "CENTER" Then 
						targetProps.Put("textAlignment", 1)
					Else if value.toUpperCase = "LEFT" Then 
						targetProps.Put("textAlignment", 0)
					Else if value.toUpperCase = "RIGHT" Then 
						targetProps.Put("textAlignment", 2)
					End If
			End Select
		Case "textcontent"
			targetProps.Put("text", value.Replace("\n", Chr(13) & Chr(10)))
		Case "password"
			value = value.toLowerCase
			If value <> "true" And value <> "false" Then value = "false"
			If defaultProps.containsKey("password") Then 
				targetProps.Put("password", value)
			Else If defaultProps.containsKey("passwordMode") Then 
				targetProps.Put("passwordMode", value)
			End If
		Case "wordwrap"
			If value <> "true" And value <> "false" Then value = "false"
			targetProps.Put("wrapText", value)
		Case "rangemax"   'handles rangeMin, and initial
			Dim rangeMax As String = value
			Dim rangeMin As String = viewMap.GetDefault("rangemin", "")
			Dim initial As String = viewMap.GetDefault("initial", "")
			Select currentTarget
				Case "bil"
					targetProps.Put("maximumValue", rangeMax)
					targetProps.Put("minimumValue", rangeMin)
					targetProps.Put("value", initial)
				Case Else
					targetProps.Put("max", rangeMax)
					targetProps.Put("min", rangeMin)
					If defaultProps.containsKey("value") Then 
						targetProps.Put("value", initial)
					Else if defaultProps.containsKey("customProperties.Value") Then 
						targetProps.Put("customProperties.Value", initial)
					End If
			End Select
		Case "rangemin", "initial"
		Case "borderwidth"  'handles borderColor, cornerRadius 
			Dim borderWidth As String = value
			Dim borderColor As String = viewMap.GetDefault("bordercolor", "")
			borderColor = colors.GetDefault(borderColor.toLowerCase, borderColor)
			Dim cornerRadius As String = viewMap.GetDefault("borderradius", 0)
			Select currentTarget
				Case "bal"
					targetProps.Put("drawable.borderWidth", borderWidth.As(Int))
					targetProps.Put("drawable.borderColor", borderColor)
					targetProps.Put("drawable.cornerRadius", cornerRadius.As(Int))
				Case Else
					targetProps.Put("borderWidth", borderWidth.As(Int))
					targetProps.Put("borderColor", borderColor)
					targetProps.Put("cornerRadius", cornerRadius.As(Int))
			End Select
		Case "bordercolor", "borderradius"
		Case "prompt"
			targetProp = IIf(defaultProps.containsKey("prompt"), "prompt", "")
			If targetProp = "" Then targetProp = IIf(defaultProps.containsKey("hint"), "hint", "")
			If targetProp = "" Then targetProp = IIf(defaultProps.containsKey("hintText"), "hintText", "")
			If targetProp = "" Then targetProp = IIf(defaultProps.containsKey("customProperties.Hint"), "customProperties.Hint", "")
			targetProps.Put(targetProp, value)
		Case Else
			targetProp = prp
			If prp.Length > 0 Then 
				Dim c As String = prp.CharAt(0)
				c = c.ToUppercase
				Dim z As String = "customProperties." & c & prp.SubString(1)
				If defaultProps.containsKey(z) Then targetProp = z
				targetProps.Put(targetProp, value) 
			End If
	End Select
End Sub

'Turns a list of lines from a generic variant layout into a Map of Views, where each View is a Map of properties
'Can access property "A" from view "X" as follows: resultMap.Get("X").As(Map).Get("A")
Public Sub parseVariant(lines As List) As Map
	Dim textViews As Map = CreateMap()
	Dim tmp As Map = CreateMap()
	Dim currentView As String
	For Each s As String In lines
		If s.StartsWith("'") Then Continue
		s = s.Trim
		If s.Length = 0 Then Continue
		Dim w() As String = parseLine(s)
		If w(0).StartsWith("name=") Then
			If tmp.Size > 1 Then textViews.Put(currentView, tmp)
			currentView = TwoParts("=", w(0))(1)
			Dim tmp As Map = CreateMap()
		End If
		For Each t As String In w
			Dim q() As String = TwoParts("=", t)
			tmp.Put(q(0).toLowerCase, q(1))
		Next
	Next
	If tmp.Size > 0 Then textViews.Put(currentView, tmp)
	Return textViews
End Sub

Private Sub parseLine(line As String) As String()
	Dim quoteIndex As Int
	Dim quotes As List: quotes.initialize
	Dim bracketIndex As Int 
	Dim brackets As List: brackets.initialize
	Dim sb As StringBuilder: sb.initialize
	Dim lastc As String 
	Dim index As Int
	Do While index < line.Length
		Dim c As String = line.CharAt(index)
		If c = QUOTE Then 
			Dim sb2 As StringBuilder: sb2.initialize
			For i = index + 1 To line.length - 1
				c  = line.CharAt(i)
				If c = QUOTE Then
					quotes.Add(sb2.ToString)
					sb.Append("_$_" & quoteIndex & "_$_")
					quoteIndex = quoteIndex + 1
					sb2.Initialize
					index = i
					lastc = ""
					Exit
				Else	
					sb2.Append(c)
				End If
			Next
		Else if c = "[" Then 
			Dim sb2 As StringBuilder: sb2.initialize
			For i = index + 1 To line.length - 1
				c  = line.CharAt(i)
				If c = "]" Then
					brackets.Add(sb2.ToString)
					sb.Append("_#_" & bracketIndex & "_#_")
					bracketIndex = bracketIndex + 1
					sb2.Initialize
					index = i
					lastc = ""
					Exit
				Else	
					sb2.Append(c)
				End If
			Next
		Else
			If c = TAB Then c = " "
			If c = "," Then c = " "
			If c = " " And lastc = " " Then Continue
			If c = "=" And lastc = " " Then Continue
			sb.Append(c)
			lastc = c
		End If
		index = index + 1
	Loop
	Dim parts() As String = Regex.Split(" ", sb.ToString.trim)
	For i = 0 To parts.Length - 1
		If parts(i).trim.endsWith("_$_") Then 
			Dim w() As String = TwoParts("=", parts(i))
			parts(i) = w(0) & "=" & QUOTE & quotes.Get(w(1).Replace("_$_", "").as(Int)) & QUOTE
		End If
		If parts(i).trim.endsWith("_#_") Then 
			Dim w() As String = TwoParts("=", parts(i))
			parts(i) = w(0) & "=" & "[" & brackets.Get(w(1).Replace("_#_", "").as(Int)) & "]"
		End If
		If parts(i).Length = 0 Then Log("+++++" & parts(i) & TAB & parts(i).length)
	Next
	Return parts
End Sub

Private Sub TwoParts(c As String, s As String) As String()
	s = s.trim
	Dim result(2) As String
	result(0) = s
	Dim k As Int = s.IndexOf(c)
	If k > - 1 Then
		result(0) = s.SubString2(0, k).trim
		result(1) = s.SubString(k + c.length).trim
	End If
	Return result
End Sub

Private Sub newSortPair (keyword As String, val As Object) As sortPair
	Dim t1 As sortPair
	t1.Initialize
	t1.keyword = keyword
	t1.val = val
	Return t1
End Sub
#End Region

#region CreateResources
Private Sub analyze(dir As String, fname As String)			'ignore
	Dim target As String = fname.SubString(fname.LastIndexOf(".") + 1)
	Dim source As String = fname.SubString2(0, 3)

	Dim jsonMap As Map = layoutReader.ConvertBxlToMap(dir, fname)
	Dim dataMap As Map = jsonMap.Get("Data")
	traverseSchema(dataMap, target, source)
	
End Sub

Private Sub traverseSchema(mp As Map, target As String, source As String)
	Dim vtype As String = mp.Get("csType")
	vtype = vtype.SubString(vtype.LastIndexOf(".") + 5)
	If vtype = "CustomView" Then vtype = mp.get("shortType")
	For Each kw As String In mp.Keys
		Dim val As Object = mp.Get(kw)
		If kw = ":kids" Then
			For Each indexkw As String In val.as(Map).keys   'there is only one
				traverseSchema(val.As(Map).get(indexkw), target, source)
			Next
		Else if val Is Map And Not(val.As(Map).containsKey("ValueType")) Then
			For Each prp As String In val.As(Map).Keys
				Dim sval As Object = val.As(Map).Get(prp)
				processItemX(kw & "." & prp, sval, target, source, vtype)
			Next
		Else
			Dim vtype As String = mp.Get("csType")
			vtype = vtype.SubString(vtype.LastIndexOf(".") + 5)
			If vtype = "CustomView" Then vtype = mp.get("shortType")
			processItemX(kw, val, target, source, vtype)
		End If
	Next
End Sub

Private Sub processItemX(prop As String, val As Object, target As String, source As String, vType As String)	'ignore
	Dim xType As Int
	If val Is Map Then 
		xType = val.As(Map).getDefault("ValueType", 0)
		Dim value As String = val.As(Map).getDefault("Value", "")
		If xType = 7 Then 
			If value.endsWith(".0") Then 
				value = value.Replace(".0", "")
			Else
				xType = 8
			End If
		End If
	Else
		value = val
	End If
	value = value.Replace(Chr(13) & Chr(10), "\n")
	
	If Not(prop.StartsWith("drawable")) Then 
		allSources.add(target & TAB & source & TAB & vType & TAB & prop & TAB & value & TAB & xType)
	End If
	
End Sub

Private Sub prepareResources
	Dim schemaLines As List = File.ReadList(resourcesDir, "resourceTables.txt")
	resources.initialize
	Dim currentGroup As String
	For Each s As String In schemaLines
		If s.Trim.Length = 0 Then Continue
		If s.StartsWith("_") Then 
			currentGroup = s.SubString(1)
			Dim lst As List
			lst.Initialize
			resources.Put(currentGroup, lst)
		Else
			resources.Get(currentGroup).As(List).Add(s)
		End If
	Next
	prepareGEN_GROUPS
	prepareSYSTEM_DATA
	prepareCOLORS
	prepareDRAWABLE_TYPES
	prepareHAS_DRAWABLE
	prepareMAIN_DRAWABLES
	prepareDICTIONARY
End Sub

Private Sub prepareGEN_GROUPS
	genGroups.Initialize
	Dim data As List = resources.Get("GEN_GROUPS")
	Dim cnt As Int = 0
	For Each s As String In data
		If s.Trim = "*" Then 
			cnt = cnt + 1
			genGroups.Put("spacer" & cnt, CreateMap())
		Else	
			Dim v() As String = Regex.Split(TAB, s)
			Dim tmp As List: tmp.initialize
			For i = 1 To v.Length - 1
				tmp.Add(v(i))
			Next
			genGroups.Put(v(0), tmp)
		End If
	Next
End Sub

Private Sub prepareSYSTEM_DATA
	Dim data As List = resources.Get("SYSTEM_DATA")
	versions.initialize
	For Each s As String In data
		Dim v() As String = Regex.Split(TAB, s)
		For i = 1 To v.Length - 1
			v(i) = v(i).SubString(v(i).IndexOf("=") + 1).trim
		Next
		versions.Put(v(0), CreateMap("version": v(1), "grid": v(2), "variants": CreateMap("Scale": v(3).As(Int), "Width": v(4).As(Int), "Height": v(5).As(Int))))
	Next
End Sub

Private Sub prepareCOLORS
	Dim data As List = resources.Get("COLORS")
	colors.Initialize
	clrNames.Initialize
	For Each clrLine As String In data
		Dim v() As String = Regex.Split(TAB, clrLine)
		Dim val As String = v(1)
		If val.StartsWith("#") Then val = "0xFF" & val.SubString(1).trim
		colors.Put(v(0).ToLowerCase, val)
		clrNames.Put(val, v(0))
	Next
End Sub

Private Sub prepareDRAWABLE_TYPES
	drawableTypes = CreateMap("bjl": CreateMap(), "bal": CreateMap(), "bil": CreateMap())
	Dim data As List = resources.Get("DRAWABLE_TYPES")
	For Each s As String In data
		s = s.Trim
		If s.Length = 0 Then Continue
		Dim v() As String = Regex.Split(TAB, s)
		If v(3) = "?" Then v(3) = ""
		Dim dtype As String
		Select v(1)
			Case 0: dtype = "Main"
			Case 1: dtype = "ColorDrawable"
			Case 2: dtype = "BitmapDrawable"
			Case 3: dtype = "GradientDrawable"
			Case 4: dtype = "DefaultDrawable"		
		End Select
		Dim platform As String = v(0)
		Dim drawT As String = dtype
		Dim pair() As String = Array As String(v(2), v(3))
		
		Dim platformMp As Map = drawableTypes.Get(platform)
		If Not(platformMp.ContainsKey(drawT)) Then 
			Dim lst As List: lst.Initialize
			platformMp.Put(drawT, lst)	
		End If
		Dim lst As List = platformMp.Get(drawT)
		lst.Add(pair)
	Next
End Sub

Private Sub prepareHAS_DRAWABLE
	hasDrawable = CreateMap("bjl": CreateMap(), "bal": CreateMap(), "bil": CreateMap())
	Dim data As List = resources.Get("HAS_DRAWABLE")
	For Each s As String In data
		s = s.Trim
		If s.Length = 0 Then Continue
		Dim v() As String = Regex.Split(TAB, s)
		If v.Length = 3 Then
			hasDrawable.Get(v(0)).As(Map).Put(v(1), v(2).As(Int))
		Else	
			hasDrawable.Get(v(0)).As(Map).Put(v(1), 9)
		End If
	Next
End Sub

Private Sub prepareMAIN_DRAWABLES
	mainDrawables = CreateMap("bjl": CreateMap(), "bal": CreateMap(), "bil": CreateMap())
	Dim data As List = resources.Get("MAIN_DRAWABLES")
	For Each s As String In data
		s = s.Trim
		If s.Length = 0 Then Continue
		Dim v() As String = Regex.Split(TAB, s)
		If Not(mainDrawables.Get(v(0)).As(Map).ContainsKey(v(2))) Then 
			Dim lst As List: lst.initialize
			mainDrawables.Get(v(0)).As(Map).Put(v(2), lst)
		End If
		Dim lst As List = mainDrawables.Get(v(0)).As(Map).Get(v(2))
		lst.Add(Array As String(v(3), v(4)))
	Next
End Sub

Private Sub prepareDICTIONARY
	Dim data As List = resources.Get("DICTIONARY")
	dictionary.Initialize
	dictionary.Put("bjl", CreateMap())
	dictionary.Put("bal", CreateMap())
	dictionary.Put("bil", CreateMap())
	For Each s As String In data
		Dim v() As String = Regex.Split(TAB, s)
		Dim infoEntry As info = newInfo(v(0), v(2), v(3), v(4), v(5), v(1))
		Dim allviews As Map = dictionary.Get(infoEntry.platform)
		If Not(allviews.ContainsKey(infoEntry.viewType)) Then allviews.Put(infoEntry.viewType, CreateMap())
		Dim vwMap As Map = allviews.Get(infoEntry.viewType)
		vwMap.Put(infoEntry.property, CreateMap("value": infoEntry.value, "valueType": infoEntry.valueType, "source": infoEntry.source))
	Next
End Sub

Private Sub GetCanonicalPath(Dir As String, FileName As String) As String
	Dim jo As JavaObject
	Dim fullPath As String = File.Combine(Dir, FileName)
	jo.InitializeNewInstance("java.io.File", Array(fullPath))
	Try
		Dim canonicalPath As String = jo.RunMethod("getCanonicalPath", Null)
		Return canonicalPath
	Catch
		Log("failed: " & LastException.Message)
		Return ""
	End Try
End Sub

'Uses the viewMap (essentially a list of views) to create a view tree (parent property is used to create linkeages)
Public Sub mapToTree(viewMap As Map) As Map
	Dim viewTree As Map = CreateMap()
	For Each viewName As String In viewMap.Keys
		Dim propMap As Map = viewMap.Get(viewName)
		Dim parent As String = propMap.GetDefault("parent", "")
		If parent = "" Then 
			viewTree.Put(viewName, propMap)
		Else
			Dim parentView As Map = viewMap.Get(parent)
			If Not(parentView.ContainsKey("children")) Then parentView.Put("children", CreateMap())
			parentView.Get("children").As(Map).Put(viewName, propMap)
		End If
	Next
	Return viewTree
End Sub

#End Region
