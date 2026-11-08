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
	Type TState(indent As String, increment As String, yamlSB As StringBuilder)
	Type KV(index As Int, key As String, value As Object)
	Private Root As B4XView
	Private xui As XUI
	#if B4J
		Private fx As JFX
	#End If
	Private source(6) As String
	Private structures(6) As Object
	Private Label1 As Label
	Private Label2 As Label
	Private TextArea1 As B4XFloatTextField
	Private TextArea2 As B4XFloatTextField
	Private MyDir As String
	#if B4a
		Private et1, et2 As EditText
	Private Timer1 As Timer
	#End If
	Private Label3 As Label
End Sub

Public Sub Initialize
	MyDir = File.DirApp.SubString2(0, File.DirApp.Length - "Objects".Length) & "Files"
	#if B4A
		Timer1.Initialize("Timer1", 400)
		MyDir = File.DirAssets
	#End If
	getStructures
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Sleep(20)
	#if B4J
		TextArea1.TextField.As(TextArea).Editable = False
		TextArea2.TextField.As(TextArea).Editable = False
		TextArea1.TextField.As(TextArea).WrapText = False
		TextArea2.TextField.As(TextArea).WrapText = False
		Dim t As Float = 30dip
		TextArea1.mBase.SetLayoutAnimated(0, 8dip, 40dip + t, Root.Width / 2 - 10dip, Root.Height - 45dip - t)
		TextArea2.mBase.SetLayoutAnimated(0, Root.Width / 2 + 2dip, 40dip + t, Root.Width / 2 - 10dip, Root.Height - 45dip - t)
	#Else if B4A
		Dim t As Float = 40dip
		TextArea1.mBase.SetLayoutAnimated(0, 8dip, 40dip + t, Root.Width / 2 - 10dip, Root.Height - 45dip - t)
		TextArea2.mBase.SetLayoutAnimated(0, Root.Width / 2 + 2dip, 40dip + t, Root.Width / 2 - 10dip, Root.Height - 45dip - t)
		TextArea1.mBase.SetColorAndBorder(xui.Color_White, 1dip, xui.Color_Black, 10dip)
		TextArea2.mBase.SetColorAndBorder(xui.Color_White, 1dip, xui.Color_Black, 10dip)

		et1 = TextArea1.TextField
		et2 = TextArea2.TextField
		
		DisableSoftKeyboard(et1)
		DisableSoftKeyboard(et2)

		et1.Wrap = False
		et2.Wrap = False
		et1.As(B4XView).SetColorAndBorder(xui.Color_Transparent, 0dip, xui.Color_Black, 10dip)
		et2.As(B4XView).SetColorAndBorder(xui.Color_Transparent, 0dip, xui.Color_Black, 10dip)
		et1.As(B4XView).SetTextAlignment("TOP", "LEFT")
		et2.As(B4XView).SetTextAlignment("TOP", "LEFT")
		et1.As(B4XView).SetLayoutAnimated(0, 0, 0, Root.Width / 2 - 10dip, Root.Height - 45dip - t)
		et2.As(B4XView).SetLayoutAnimated(0, 0, 0, Root.Width / 2 - 10dip, Root.Height - 45dip - t)
	#End If
	
	Label1.SetLayoutAnimated(0, Root.Width / 4 - Label1.Width / 2, 10dip + t, Label1.Width, Label1.Height)
	Label2.SetLayoutAnimated(0, 3 * Root.Width / 4 - Label2.Width / 2, 10dip + t, Label2.Width, Label2.Height)
	Label3.SetLayoutAnimated(0, 3 * Root.Width / 4 + Label2.Width / 2, 10dip + t, Label3.Width, Label3.Height)
	
	Dim btns(6) As Button
	Dim txts(6) As String = Array As String("Ex1: YAML -> structure -> YAML", "Ex2: .bjl -> structure -> YAML", "Ex3a: JSON -> structure -> YAML", _
								"Ex3b: JSON -> structure -> YAML", "Ex3c: JSON -> structure -> YAML", "Paste in Source JSON -> YAML")
	Dim w As Float = Root.Width / 6
	For i = 0 To 5
		btns(i).Initialize("btn")
		btns(i).Text = txts(i)
		btns(i).Tag = i
		#if B4J
			btns(i).As(B4XView).Font = xui.CreateDefaultBoldFont(13)
			Root.AddView(btns(i), 5dip + i * w, 0, w - 10dip, 20dip)
		#Else If B4A
			btns(i).As(B4XView).Font = xui.CreateDefaultBoldFont(11)
			Root.AddView(btns(i), 5dip + i * w, 0, w - 10dip, 50dip)
		#End If
	Next
	btns(0).As(B4XView).RequestFocus
#if B4A
	Timer1.Enabled = True
#End If
End Sub

'recursive tree traversal to build TS.yamlSB stringbuilder
Private Sub structureToYaml(struct As Object, TS As TState)
	If struct Is Map Then
		Dim inList As Boolean
		If TS.indent.endsWith("*") Then			'first item should have a leading -
			inList = True
			TS.indent = TS.indent.SubString2(0, TS.indent.Length - 1)
		End If
		Dim saveIndent As String = TS.Indent
		If TS.yamlSB.Length > 0 Then TS.indent = TS.indent & TS.increment
		For Each kw As String In struct.As(Map).Keys
			Dim item As Object = struct.As(Map).Get(kw)
			If inList Then TS.indent = TS.indent.SubString(TS.increment.Length) & TS.increment.SubString(2) & "- "
			If item Is Map Or item Is List Then
				TS.yamlSB.Append(TS.indent & kw & ":").Append(CRLF)
				inList = False
				TS.indent = TS.indent.Replace("-", " ")
				structureToYaml(item, TS)
			Else
				If item Is String Then
					If IsNumber(item) Then item = $"'${item}'"$
					item = item.As(String).Replace(CRLF, "\n")
				End If
				TS.yamlSB.Append(TS.indent & kw & ": "  & item).Append(CRLF)
				inList = False
				TS.indent = TS.indent.Replace("-", " ")
			End If
		Next
		TS.indent = saveIndent
	Else If struct Is List Then
		Dim saveIndent As String = TS.Indent
		If TS.yamlSB.Length > 0 Then TS.indent = TS.indent & TS.increment
		For Each item As Object In struct.As(List)
			If item Is Map Or item Is List Then
				TS.indent = saveIndent & "*"
				structureToYaml(item, TS)
			Else
				If item Is String Then
					If IsNumber(item) Then item = $"'${item}'"$
					item = item.As(String).Replace(CRLF, "\n")
				End If
				TS.yamlSB.Append(TS.indent & "- " & item).Append(CRLF)
			End If
		Next
		TS.indent = saveIndent
	Else
		TS.yamlSB.Append(TS.indent & struct).Append(CRLF)
	End If
End Sub

'used by recursive parse to pass state
Public Sub CreateTState (indent As String, increment As String, yamlSB As StringBuilder) As TState
	Dim t1 As TState
	t1.Initialize
	t1.indent = indent
	t1.increment = increment
	t1.yamlSB = yamlSB
	Return t1
End Sub

'Samples from openAPI site: https://spec.openapis.org/oas/latest.html  scroll to section
Private Sub getJSONSamples
	Dim JSONSamples As List = File.ReadList(MyDir, "JSONSamples.txt")
	Dim samplesList As List
	samplesList.Initialize
	Dim thisSample As StringBuilder
	thisSample.Initialize
	For Each s As String In JSONSamples
		If s.StartsWith("***") Then
			If thisSample.Length > 0 Then
				samplesList.Add(thisSample.ToString)
				thisSample.Initialize
			End If
		Else
			thisSample.Append(s).Append(CRLF)
		End If
	Next
	samplesList.Add(thisSample.ToString)
	For i = 0 To samplesList.Size - 1
		Dim testJSON As String = samplesList.get(i)
		source(i + 2) = testJSON
		structures(i + 2) = prepareStructure(testJSON)
	Next
End Sub

Private Sub prepareStructure(txt As String) As Object
	If txt.StartsWith("[") Then txt = $"{root: ${CRLF}${txt}${CRLF}}"$
	Dim keyOrder As Map = getKeyOrder(txt)		'restore key order for ease of json-yaml comparison
	Dim m As Map = txt.As(JSON).ToMap 'ignore
	sortMaps(m, keyOrder, "")
	Return m
End Sub

'looks for all maps and reconstructs them based on the prescribed order of keys
Private Sub sortMaps(struct As Object, keyOrder As Map, currentBlock As String)		'does not work in B4i
	If struct Is Map Then
		Dim aList As List
		aList.Initialize
		For Each kw As String In struct.As(Map).Keys
			Dim index As Int = keyOrder.GetDefault(currentBlock & "." & kw, -1)
			If index = -1 Then Log("_____Error_____" & currentBlock & "." & kw)
			Dim kvx As KV = CreateKV(index, kw, struct.As(Map).Get(kw))
			aList.Add(kvx)
		Next
		aList.SortType("index", True)
		struct.As(Map).clear
		For Each kvx As KV In aList
			struct.As(Map).Put(kvx.key, kvx.value)
		Next
		For Each kw As String In struct.As(Map).Keys
			currentBlock = kw
			sortMaps(struct.As(Map).Get(kw), keyOrder, currentBlock)
		Next
	Else if struct Is List Then
		For Each item As Object In struct.As(List)
			If item Is Map Then sortMaps(item, keyOrder, currentBlock)
		Next
	End If
End Sub

'used by sortMaps
Public Sub CreateKV (index As Int, key As String, value As Object) As KV
	Dim t1 As KV
	t1.Initialize
	t1.index = index
	t1.key = key
	t1.value = value
	Return t1
End Sub

'a simple pass through the JSON text looking for ": extracting and storing keys in order of appearance
'it prepends the key with its parent key (ignores the case when there are duplicate parentKey.childKey names, but works most of the time)
Private Sub getKeyOrder(jsonStr As String) As Map
	Dim result As Map
	result.Initialize
	Dim v() As String = Regex.Split(QUOTE & "\:", jsonStr)
	Dim lev, lastlev As Int
	Dim kw, lastkw As String
	Dim stack As List: stack.initialize
	Dim currentBlock As String
	For i = 0 To v.Length - 2
		Dim s As String = v(i)
		For j = 0 To s.Length - 1
			Dim c As String = s.CharAt(j)
			If c = "{" Then lev = lev + 1
			If c = "}" Then lev = lev - 1
		Next
		If lev = lastlev + 1 Then 
			currentBlock = lastkw
			stack.Add(currentBlock)
		else if lev < lastlev Then 
			For m = 0 To lastlev - lev - 1
				stack.removeAt(stack.Size - 1)
			Next
			currentBlock = stack.get(stack.Size - 1)
		End If
		Dim k As Int = s.LastIndexOf(QUOTE)
		kw = s.SubString(k + 1)
		result.Put(currentBlock & "." & kw, i)
		lastlev = lev
		lastkw = kw
	Next
	Return result
End Sub

Private Sub getStructures
	'First example to show yaml ==> map/list structure ==> yaml keeps the integrity of the yaml string
	Dim parser As YAML
	parser.Initialize
	Dim s As String = $"---
name: Nathan Sweet
age: 28
date: 2001-12-14T21:59:43.10-05:00
address: 4011 16th Ave S
number: 123
ff: false
tt: true
phone numbers:
 - name: Home
   number: 206-555-5138
 - name: Work
   number: 425-555-2306
---
aaa"$
	source(0) = s
	structures(0) = parser.ParseAllDocuments(s)

	'Second example to show that the complex structure of layout files can be displayed and understood
	'modified BalConverter for .bjl .bal .bil: (@Erel)  https://www.b4x.com/android/forum/threads/b4x-balconverter-convert-the-layouts-files-to-json-and-vice-versa.41623/
	
	'Notes about the result:
	'1. Default color value: 0xFFF0F8FF
	'2. hanchor:none=0, left=1, right=2, both=3  	'affects the meaning of left, right, and width respectively, relative to parent
	'3. vanchor:none=0, top=1, bottom=2, both=3		'affects the meaning of top, bottom, and height respectively, relative to parent
	 
	Dim converter As WiLBalReader
	converter.Initialize
	#if B4J
	source(1) = $"Source File: ${MyDir}\test1.bjl"$
		structures(1) = converter.ConvertBalToMap(MyDir, "test1.bjl")
	#Else if B4A
		source(1) = $"The .b4j .b4a .b4i parser is not available in Android"$
		structures(1) = CreateMap("Error": "Not available for Android")
	#End If

	'Other examples to show how JSON strings can be converted to yaml strings preserving key order
	getJSONSamples
End Sub

Private Sub btn_Click
	#If B4A
		Timer1.Enabled = True
	#End If
	Dim btn As B4XView = Sender
	Dim index As Int = btn.Tag
	Dim sb As StringBuilder
	Select index
		Case 0
			TextArea1.Text = source(0)
			Dim combine As StringBuilder
			combine.initialize
			For Each doc As Object In structures(0).As(List)
				combine.Append("---").Append(CRLF)
				sb.Initialize
				structureToYaml(doc, CreateTState("", "    ", sb))
				combine.Append(sb.ToString)
			Next
			TextArea2.Text = combine.ToString
		Case 5
			TextArea1.Text = ""
			TextArea2.Text = ""
			Dim sf As Object = xui.Msgbox2Async("Ready?", "", "Yes", "", "", Null)
			Wait For (sf) Msgbox_Result (Result As Int)
			If Result = xui.DialogResponse_Positive Then
				#if B4J
					TextArea1.Text = fx.Clipboard.GetString
				#Else if B4A
					Dim cb As BClipboard
					TextArea1.Text = cb.getText
				#End If
				If TextArea1.Text.trim.Length > 0 Then
					Try
						sb.Initialize
						structureToYaml(prepareStructure(TextArea1.text), CreateTState("", "    ", sb))
						TextArea2.Text = sb.ToString
					Catch
						TextArea1.Text = ""
						Log(LastException)
					End Try
				End If
			End If
		Case Else
			TextArea1.Text = source(index)
			If TextArea1.Text.Trim.Length > 0 Then
				sb.Initialize
				structureToYaml(structures(index), CreateTState("", "    ", sb))
				TextArea2.Text = sb.ToString
			End If
	End Select
	#If B4A
	Sleep(500)
		Timer1.Enabled = True
	#End If
End Sub

#if B4A 
Private Sub DisableSoftKeyboard (oEditText As Object)
	Dim NativeMe As JavaObject = B4XPages.GetNativeParent(Me)
	NativeMe.InitializeContext
	NativeMe.RunMethod("disableSoftKeyboard", Array As Object(oEditText)) 'ignore
End Sub

Sub Timer1_Tick
	et1.As(B4XView).SetSelection(0, 0)
	et2.As(B4XView).SetSelection(0, 0)
	et1.RequestFocus
	et2.RequestFocus
End Sub

Private Sub Label3_Click
	#if B4J
		fx.Clipboard.SetString(TextArea2.Text)
	#Else if B4A
		Dim cb As BClipboard
		cb.SetText(TextArea2.Text)
	#End If
End Sub
#Else if B4J

Private Sub Label3_MouseClicked(Ev As MouseEvent)
	fx.Clipboard.SetString(TextArea2.Text)
	xui.MsgboxAsync("YAML string is on the Clipboard", "")
End Sub
#End If

Sub AssetsDir As String
#if B4J
	Return "../files/"
#else
    Return "AssetsDir"
#End If
End Sub