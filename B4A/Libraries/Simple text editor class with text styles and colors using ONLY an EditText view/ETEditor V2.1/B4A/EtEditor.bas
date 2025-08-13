B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.5
@EndOfDesignText@
' Class for turning an EditText view into an editor with formatting. Written by BG Apr 2025
' Version 1.0
' To use:
' 1) Declare Global variable: Dim ET As EtEditor
' 2) Initialize class with size, position and scale (normally set to 0) ET.Initialize(Panel1,0, 10%y,100%x,90%y, 0)
' 3) Create Style spinner (If using the inbuilt one) 					ET.CreateStyleSpinner(Panel1,100%x - 8%x,2%y,Colors.Black)
' 4) Create Colors spinner (If using the inbuilt one) 					ET.CreateColorSpinner(Panel1,100%x - 17%x,2%y,Colors.Black)
' 5) Create Zoom slider (If using the inbuilt one) 						ET.CreateZoomSlider(Panel1,100%x - 45%x,1%y,23%x,8%y)
' 6) Set a default text if required										ET.EditText.Text = "Welcome to ETEditor"
' 7) Or read from a file												Wait For (ET.ReadFromFile(rp.GetSafeDirDefaultExternal(""),"Test.et")) Complete (bResult As Boolean)
' If using the inbuilt Color spinner, Style spinner and Zoom slider, this class will take care of everything.
' You only need to call the 'SaveToFile', 'ReadFromFile' or 'SetEnabled' subs when required.
' If you wish to use the Custom Context Menus then copy the code (located at the end of this class)
'    between '#If Custom-Context-Menus-code' and '#End If Custom-Context-Menus-code' to the 'Main' module
'
' Version 2.0 Apr 2025
' 1) Added methods 'ReadFromHtml' and 'SaveToHtml'
' 2) Worked out how to get the span details from Java code, so rewrote a lot of code to use native methods instead.

' Version 2.1 Apr 2025
' 1) Added method 'InsertImage'
'    Can specify size of image in 4 variations, allowing to keep aspect ratio if desired. (Read comments of Sub)
'    The added image will automatically zoom with the text except if it has '[NZ]' in the file name (stands for NonZoom)
' 2) Can now Undo and Redo Zoom changes as well.
' 3) Changed the InputType to TYPE_TEXT_FLAG_NO_SUGGESTIONS (which means no auto correct suggestions are displayed)
' 4) Changed the 'SaveToHtml' and 'ReadFromHtml' methods to use B4A rather than needing to call Java code.

#IgnoreWarnings: 1, 7, 12

Sub Class_Globals
	Type ETSpanDetails (ETSpanType As String, SpanStart As Int, SpanEnd As Int, Parameter As Object)
	Type SpanTypes (BackgroundColor As String, ForegroundColor As String, Image As String, RelativeSize As String,  ScaleX As String, Subscript As String, Superscript As String, _
					StrikeThrough As String, Style As String, Underline As String)
	Public SpanType As SpanTypes
	SpanType.BackgroundColor = "android.text.style.BackgroundColorSpan" : SpanType.ForegroundColor = "android.text.style.ForegroundColorSpan" 
	SpanType.RelativeSize = "android.text.style.RelativeSizeSpan" : SpanType.ScaleX = "android.text.style.ScaleXSpan" 
	SpanType.Subscript = "android.text.style.SubscriptSpan" : SpanType.Superscript = "android.text.style.SuperscriptSpan"
	SpanType.StrikeThrough = "android.text.style.StrikethroughSpan" : SpanType.Style = "android.text.style.StyleSpan"
	SpanType.Underline = "android.text.style.UnderlineSpan" : SpanType.Image = "android.text.style.ImageSpan"
	Type AlignTypes (Left As Int, Centre As Int, Right As Int)
	Public AlignType As AlignTypes
	AlignType.Left = 0 : AlignType.Centre = 1 : AlignType.Right = 2
	
	Type UndoRedoDetails(Text As String, CursorPosition As Int, SpannableStringUndo As JavaObject, ZoomLevel As Int)
	Private LstUndoRedo As List, UndoRedoIdx As Int = -1, UndoRedoLimit As Int = 30, UndoAddToHistory As Boolean = True
	Private CopiedText As String, CopyStartIdx As Int, CopiedSpan As JavaObject
	
	Public ET As EditText, refET As Reflector
	Private ETTextChangeEventTriggered As Boolean = False
	Private SpannableStringET As JavaObject
	
	Private CtrlDown As Boolean = False
	Private AltDown As Boolean = False
	Private spnColors, spnStyles As Spinner
	Private Const SPAN_EXCLUSIVE_EXCLUSIVE As Int = 33
	Private pnlReadOnly As Panel
	Private IsReadOnly As Boolean  = False
	Private lstUseColors, lstColors As List
	Private BGViews As XUIViewsBG
	Private Scale As Float
' #################################################################
' Variables for Zoom Slider
	Private Slider_mEventName As String 'ignore
	Private Slider_mCallBack As Object 'ignore
	Private Slider_mBase As B4XView 'ignore
	Private Slider_xui As XUI 'ignore
	Private Slider_xpnl_leftside,Slider_xpnl_rightside,Slider_xpnl_slidebutton As B4XView
	Private Slider_tmp_xpnl_leftside,Slider_tmp_xpnl_rightside As B4XView
	Private Slider_downx As Int   ',Slider_downy As Int
	'Properties
	Private xLabelColor,xSliderButtonColor As Int
	Private Slider_MinValue,Slider_MaxValue,Slider_DefaultValue, Slider_DefaultTextSize As Int
	Private Slider_Value As Int
	Private Slider_SliderSize As Int
	Private Slider_SliderLabel As B4XView
	Private Slider_TxtSize As Int
	Private Slider_Position As Rect
	Private Slider_PreviousValue As Int
	Private Slider_IgnoreChange As Boolean
End Sub

'Initializes the object. Pass a 0 as scale for the class to calculate the correct scale for you.
Public Sub Initialize(Parent As Panel, Left As Int, Top As Int, Width As Int, Height As Int, DeviceScale As Float)
	If DeviceScale = 0 Then 
		Scale = CalculateScale
	Else
		Scale = DeviceScale	' so layout can be adjusted for different devices
	End If
	ET.Initialize("ET")
	ET.Color = Colors.White
	ET.Enabled = True
	ET.ForceDoneButton = False
	ET.Gravity= Gravity.NO_GRAVITY
	ET.InputType = 524288	' TYPE_TEXT_FLAG_NO_SUGGESTIONS
	ET.Padding = Array As Int (5dip,5dip,5dip,5dip)
	ET.SingleLine = False
	ET.TextColor = Colors.Black
	ET.TextSize = 35 * Scale
	ET.Typeface = Typeface.DEFAULT
	ET.Visible = True
	ET.Wrap  = False
	Parent.AddView(ET,Left,Top,Width,Height)
	LstUndoRedo.Initialize
	UndoRedoIdx = -1
	UndoAddToHistory = True
	pnlReadOnly.Initialize("")
	pnlReadOnly.Color = Colors.Transparent
	pnlReadOnly.Visible = False
	lstUseColors.Initialize2(Array As String("Black:000000","Maroon:800000","Green:008000","Navy:000080","Purple:800080","Teal:008080","Grey:808080", _
												"Red:FF0000","Lime:00FF00","Blue:0000FF","Fuchsia:FF00FF","Aqua:00FFFF"))
	' need to split out the colors here in case the user does not call the 'CreateColorSpinner' sub
	lstColors.Initialize
	For i = 0 To lstUseColors.Size -1
		Dim UseColor As String = lstUseColors.Get(i)
		' split out the color name and color value
		Dim s() As String = Regex.Split(":", UseColor)
		Dim Clr As Int = Bit.Or(0xff000000, Bit.ParseInt(s(1), 16))
		lstColors.Add(Clr)
	Next
	refET.Target = ET
	refET.SetOnKeyListener("ET_OnKeyPress")
	SpannableStringET = refET.RunMethod("getText") ' includes the text with all spans
	ET.RequestFocus
	BGViews.Initialize(B4XPages.GetNativeParent(B4XPages.MainPage),28 )
End Sub

' Returns the EditText view so the user can view or change it's properties.
' Do NOT change the Text property. Doing so will kill all the formatting.
Public Sub EditText As EditText
	Return ET
End Sub

' Returns the scale being used by the class
Public Sub GetScale As Float
	Return Scale
End Sub

' Sets whether the EditText is in read only mode or not. Optionally pass a new Background color (or 1 to leave unchanged).
' The 'ReadFromFile' method will still work in Read Only mode.
Public Sub SetReadOnly(ReadOnly As Boolean, BackColor As Int)
	spnColors.Enabled = Not(ReadOnly)
	spnStyles.Enabled = Not(ReadOnly)
	
	Dim jo = ET As JavaObject
	jo.RunMethod("setCursorVisible", Array As Object(Not(ReadOnly)))
	If ReadOnly Then
		' sets the Enabled to False and for safety puts a transparent panel over it. (Sometimes the 'enabled' property is unreliable)
		jo.RunMethod("setSelection", Array As Object(ET.SelectionStart, ET.SelectionStart))	' cancel the selection
		ET.Enabled = False
		pnlReadOnly.SetLayout(EditText.Left,EditText.Top,EditText.Width,EditText.Height)
		pnlReadOnly.Visible = True
	Else
		ET.Enabled = True
		pnlReadOnly.Visible = False
	End If
	If BackColor <= 0 Then EditText.Color = BackColor
	IsReadOnly = ReadOnly
	If Slider_mBase.IsInitialized Then 	Slider_mBase.Enabled = Not(IsReadOnly)
End Sub

' Returns the ReadOnly state of the EditText
Public Sub GetReadOnly As Boolean
	Return IsReadOnly
End Sub

' Clears the EditText of all text and spans
' Note: This is called automatically when required by the class but can be called by the user as well.
' Example: <code>Dim rs As ResumableSub = Clear(True)
'          Wait For (rs) Complete (bResult As Boolean)</code>
Public Sub Clear(ClearUndoHistoryAsWell As Boolean) As ResumableSub
	SpannableStringET = refET.RunMethod("getText") ' includes the text with all spans
	If ET.Text.Length > 0 Then
		Dim rs As ResumableSub = RunMethodAndWaitForTextChangedEventToFire("delete",0,ET.Text.length,"")
 	    	Wait For (rs) Complete (bResult As Boolean)
 	End If
	If ClearUndoHistoryAsWell Then
		LstUndoRedo.Clear
		UndoRedoIdx = -1
	End If
	SpannableStringET = refET.RunMethod("getText") ' includes the text with all spans
	Return True
End Sub

' Add a span (Color or Textstyle) on the currently selected text.
' Note: This is called automatically if using the inbuilt Style Spinner but can be called by the user as well.
' Example: <code>Dim rs As ResumableSub = AddSpanToET(SpanType.Style,Typeface.STYLE_BOLD)
'          Wait For (rs) Complete (bResult As Boolean)</code>
Public Sub AddSpanToET(ETSpanType As String,  Parameter As Float) As ResumableSub
	If ET.SelectionLength = 0 Then Return False
	SpannableStringET = refET.RunMethod("getText") ' includes the text with all spans
	' some span types need user input
	Dim SelectionStart As Int = ET.SelectionStart
	Dim SelectionLength As Int = ET.SelectionLength

	Select Case ETSpanType
		Case SpanType.RelativeSize
			If Parameter > 0 Then  Exit	'loading from file so already have parameter
			ET.SetSelection(SelectionStart,0)	' so context menu disappears
            Dim rs As ResumableSub = BGViews.ShowInputBox("Enter Relative Size eg." & CRLF & ".5 = Half the size" & CRLF & "1.5 = One and a half the size","1","ET Editor",0)
 	        Wait For (rs) Complete (sResult As String)
			Dim RelativeSize As Float = Val(sResult,1)
			' set selection again and apply span
			ET.SetSelection(SelectionStart,SelectionLength)
			If RelativeSize = 0 Then Return False
			Parameter = RelativeSize
		Case SpanType.ScaleX
			If Parameter > 0 Then Exit
			ET.SetSelection(SelectionStart,0)	' so context menu disappears
            Dim rs As ResumableSub = BGViews.ShowInputBox("Enter ScaleX ratio eg." & CRLF & ".5 = Half the size" & CRLF & "1.5 = One and a half the size","1","ET Editor",0)
 	        Wait For (rs) Complete (sResult As String)
			Dim ScaleXSize As Float = Val(sResult,1)
			' set selection again and apply span
			ET.SetSelection(SelectionStart,SelectionLength)
			If ScaleXSize = 0 Then Return False
			Parameter = ScaleXSize
		Case SpanType.BackgroundColor
			If Parameter <= 0 Then Exit
			ET.SetSelection(SelectionStart,0)	' so context menu disappears
			Dim rs As ResumableSub = BGViews.SelectColorFromList
 	    		Wait For (rs) Complete (iResult As Int)
			' set selection again and apply span
			ET.SetSelection(SelectionStart,SelectionLength)
			If iResult = DialogResponse.CANCEL Then Return False
			Parameter = iResult		
	End Select

	AddSpan(SpannableStringET,ETSpanType,SelectionStart, SelectionStart + SelectionLength,Parameter)
	AddToUndoRedoHistory
	EditText.RequestFocus
	Return True
End Sub

' Removes any spans for the selected text (i.e. turns the text back to Normal)
' Note: This is called automatically if using the inbuilt Style Spinner but can be called by the user as well.
' Example: <code>Dim rs As ResumableSub = RemoveSpans
'          Wait For (rs) Complete (bResult As Boolean)</code>
Public Sub RemoveSpans As ResumableSub
	If ET.SelectionLength = 0 Then Return False
	' deleting the text and reinserting it will delete any of it's spans
	Dim SelectedText As String = ET.Text.SubString2(ET.SelectionStart,ET.SelectionStart + ET.SelectionLength)	
	SpannableStringET = refET.RunMethod("getText") ' includes the text with all spans
	Dim rs As ResumableSub = RunMethodAndWaitForTextChangedEventToFire("delete",ET.SelectionStart,ET.SelectionStart + ET.SelectionLength,"")
 	    Wait For (rs) Complete (bResult As Boolean)
	Dim rs1 As ResumableSub = RunMethodAndWaitForTextChangedEventToFire("insert",ET.SelectionStart,0,SelectedText)
 	    Wait For (rs1) Complete (bResult As Boolean)
	Return True
End Sub

' Deletes the selected text.
' Note: Only required when need to delete text via code. The EditText will take care of text deleted by the user.
' Example: <code>Dim rs As ResumableSub = Delete()
'          Wait For (rs) Complete (bResult As Boolean)</code>
Public Sub Delete() As ResumableSub 
	UndoAddToHistory = True	
	Dim rs As ResumableSub = RunMethodAndWaitForTextChangedEventToFire("delete",ET.SelectionStart,ET.SelectionStart + ET.SelectionLength,"")
 	    Wait For (rs) Complete (bResult As Boolean)
	Return bResult
End Sub

' Inserts text (no formatting) at the cursor position
' Note: Only required when need to insert text via code. The EditText will take care of text inserted by the user.
' Example: <code>Dim rs As ResumableSub = Insert("Inserted Text")
'          Wait For (rs) Complete (bResult As Boolean)</code>
Public Sub InsertText(NewText As String) As ResumableSub
	UndoAddToHistory = True	
	Dim rs As ResumableSub = RunMethodAndWaitForTextChangedEventToFire("insert",ET.SelectionStart,0,NewText)
 	    Wait For (rs) Complete (bResult As Boolean)	
	Return bResult
End Sub

' Replaces the selected text with the replacement text
' Note: Only required when need to replace text via code. The EditText will take care of text replaced by the user.
' Example: <code>Dim rs As ResumableSub = Replace("Replaced text")
'          Wait For (rs) Complete (bResult As Boolean)</code>
Public Sub Replace(ReplacementText As String)  As ResumableSub 
	UndoAddToHistory = True	
	Dim rs As ResumableSub = RunMethodAndWaitForTextChangedEventToFire("replace",ET.SelectionStart, ET.SelectionStart + ET.SelectionLength,ReplacementText)
 	    Wait For (rs) Complete (bResult As Boolean)
	Return bResult
End Sub

' Aligns text in the selected line by adding or deleting spaces in front. ONLY works if EditText is NOT in wrap mode.
' Note: This is called automatically if using the inbuilt Style Spinner but can be called by the user as well.
' Example: <code>Dim rs As ResumableSub = Align(ET.AlignType.Centre)
'          Wait For (rs) Complete (bResult As Boolean)</code>
Public Sub Align(ETAlignType As Int) As ResumableSub
	' Alignment is only 'faked' by inserting or deleting spaces in front of the text in a line
	Dim ETText As String = ET.Text
	' cursor position is in front of the character
	' ie. If the text is abcde and the selectionstart = 3 then the cursor is between the c and the d (abc|de)
	
	' determine which line the cursor is in and get start and end positions
	Dim LineStartIdx As Int
	Dim LineEndIdx As Int	' LineEndIdx is 1 past the last character
	' use android java methods
	Dim LineIndex As Int
	Private joEditText, joEditTextLayout As JavaObject
    joEditText = ET
	joEditTextLayout = joEditText.RunMethod("getLayout", Null)
 	LineIndex = joEditTextLayout.RunMethod("getLineForOffset", Array As Object(ET.SelectionStart))
	LineStartIdx = joEditTextLayout.RunMethod("getLineStart", Array As Object(LineIndex))
	LineEndIdx = joEditTextLayout.RunMethod("getLineVisibleEnd", Array As Object(LineIndex))
	
	' count leading spaces 
	Dim LeadingSpacesLineEndIdx As Int
	For LeadingSpacesLineEndIdx = LineStartIdx To LineEndIdx
		If ETText.SubString2(LeadingSpacesLineEndIdx,LeadingSpacesLineEndIdx +1) <> " " Then Exit
	Next
	' count trailing spaces
	Dim TrailingSpacesBeginPos As Int
	For TrailingSpacesBeginPos = LineEndIdx -1 To LineStartIdx Step -1
		If ETText.SubString2(TrailingSpacesBeginPos,TrailingSpacesBeginPos +1) <> " " Then Exit
	Next	
	SpannableStringET = refET.RunMethod("getText") ' includes the text with all spans
	UndoAddToHistory = False	' running delete method will trigger text changed method which will in turn want to add to undo history
	' delete leading spaces
	Dim rs As ResumableSub =RunMethodAndWaitForTextChangedEventToFire("delete",LineStartIdx, LeadingSpacesLineEndIdx,"")
 	    Wait For (rs) Complete (bResult As Boolean)
	' delete trailing spaces
	Dim rs1 As ResumableSub =RunMethodAndWaitForTextChangedEventToFire("delete",TrailingSpacesBeginPos + 1, LineEndIdx,"")
 	    Wait For (rs1) Complete (bResult As Boolean)

	' work out new number of spaces required
	Dim LineTextNew As String = ETText.SubString2(LineStartIdx,LineEndIdx).trim

	Dim SpacesinFrontRequired As Int
	Select Case ETAlignType
		Case AlignType.Left
			SpacesinFrontRequired = 0
		Case AlignType.Centre
			For SpacesinFrontRequired = 1 To 1000
				LineTextNew = " " & LineTextNew & " "
				Dim Width As Int = MeasureTextWidth(ET.Parent,LineTextNew,ET.TextSize,ET.Typeface)
				If Width > ET.Width Then Exit
			Next
			LineTextNew = RTrim(LineTextNew)
		Case AlignType.Right
			For SpacesinFrontRequired = 1 To 1000
				LineTextNew = " " & LineTextNew
				Dim Width As Int = MeasureTextWidth(ET.Parent,LineTextNew,ET.TextSize,ET.Typeface)
				If Width > ET.Width Then Exit
			Next
	End Select
	Dim ReplacementText As String = LineTextNew.Replace(LineTextNew.Trim,"")	' no. of spaces to add
	UndoAddToHistory = True	' running replace method will trigger text changed method which will in turn add to undo history
	Dim rs2 As ResumableSub = RunMethodAndWaitForTextChangedEventToFire("replace",LineStartIdx,LineStartIdx,ReplacementText)
 	    Wait For (rs2) Complete (bResult As Boolean)
	ET.SelectionStart = LineStartIdx
	Return True
End Sub

' Inserts an image into the EditText. For a non-zoomable image have [NZ] somewhere in the file name.
' Width and Height can be in one of 4 formats;
' 0, 0   (No Width or Height specified: Will clear the EditText and fill it with the image)
' W, 0	 (Width specified but no Height: Will resize the image to Width and set the Height according to the Aspect Ratio)
' 0, H   (Height specified but no Width: Will resize the image to Height and set the Width according to the Aspect Ratio)
' W, H   (Width and Height specified: Will resize the image to the specified size regardless of Aspect Ratio)
Public Sub InsertImage(ImageDir As String, ImageFile As String, Width As Int, Height As Int) As ResumableSub
	' resumable subs don't like elseif or multiple statements on one line
	If File.Exists(ImageDir, ImageFile) = False Then
		Dim rsMsgBox As ResumableSub = BGViews.ShowMsgBox("File does not exist" & CRLF & ImageDir & CRLF & ImageDir,"ETEditor","OK","","",0)
 	    Wait For (rsMsgBox) Complete (iResult As Int)
		Return False
	End If
	Dim Source As String = File.Combine(ImageDir, ImageFile)
	Dim bm As Bitmap
	bm.Initialize(ImageDir,ImageFile)
	Dim AspectRatio As Float = bm.Width / bm.Height
	Dim W, H As Float
	If Width < 0 Then Width = 0 
	If Height < 0 Then Height = 0
	If Width = 0 And Height = 0 Then
		W = ET.Width : H = ET.Height
		Dim rsClear As ResumableSub = Clear(True)
         Wait For (rsClear) Complete (bResult As Boolean)
	End If
	If Width > 0 And Height = 0 Then 
		W = Width 
		H = Width / AspectRatio
	End If
	If Width = 0 And Height > 0 Then
		H = Height
		W = Height * AspectRatio
	End If		
	If Width > 0 And Height > 0 Then 
		W = Width 
		H = Height
	End If

	Dim SelStart As Int = ET.SelectionStart		 
	Dim SelEnd As Int = ET.SelectionStart + ET.SelectionLength
	If SelEnd = ET.SelectionStart Then
		' insert a space and then replace with the image
		Dim rsInsert As ResumableSub = InsertText(" ")
          Wait For (rsInsert) Complete (bResult As Boolean)
		SelEnd = SelStart + 1
	End If
	Dim lParameter As List
	lParameter.Initialize
	lParameter.Add(Source)
	lParameter.Add(W)
	lParameter.Add(H)
	AddSpan(SpannableStringET,SpanType.Image,SelStart,SelEnd,lParameter)
	AddToUndoRedoHistory
	Return True
End Sub

' Saves the displayed text with formatting in a custom format
' Example: <code>SaveToFile(rp.GetSafeDirDefaultExternal(""),"Test.et")</code>
Public Sub SaveToFile(Dir As String, Filename As String) As Boolean
	' custom file format has 3 sections
	' [Text] (contains the text of the EditText view)
	' [Properties] (lists various relevant properties of the EditText view
	' [Spans] (list the spans in the EditText view, one line for each span)
	'	SpanType,SelectionStart,SelectionEnd,Parameter
	'
	' eg.
	' [Text]
	' Amazing grace how sweet the sound
	' that saved a wretch like me!
	' I once was lost but now am found,
	' twas blind but now I see.
	' [Properties]
	' Zoom=75
	' Scale=1
	' Typeface=Default
	' [Spans]
	' Underline,35,42,0				(Underline, From 35 to 42)
	' ForegroundColor,53,58,-65536	(ForegroundColor, from 53 to 58, Red)
	' Style,53,58,1					(Bold, from 53 to 58)
	' RelativeSize,114,117,1.5		(RelativeSize, from 114 to 117, 1.5 times bigger)
	
	If File.Exists(Dir,Filename) = True Then 
		If File.Delete(Dir,Filename) = False Then Return False
	End If
	Dim lstFileLines As List :	lstFileLines.Initialize
	lstFileLines.Add("[Text]")
	lstFileLines.Add(ET.Text)
	lstFileLines.Add("[Properties]")
	lstFileLines.Add("Zoom=" & ET.TextSize)
	lstFileLines.Add("Scale=" & Scale)
	If ET.Typeface = Typeface.DEFAULT Then lstFileLines.Add("Typeface=Default")
	If ET.Typeface = Typeface.FONTAWESOME Then lstFileLines.Add("Typeface=FontAwesome")
	If ET.Typeface = Typeface.MONOSPACE Then lstFileLines.Add("Typeface=Monospace")
	If ET.Typeface = Typeface.SANS_SERIF Then lstFileLines.Add("Typeface=Sans_Serif")
	If ET.Typeface = Typeface.SERIF Then lstFileLines.Add("Typeface=Serif")
	lstFileLines.Add("[Spans]")
	SpannableStringET = refET.RunMethod("getText") 
	Dim LstSpanDetails As List = GetSpanDetails(SpannableStringET)
	For Each ETSD As ETSpanDetails In LstSpanDetails
		Dim sParameter As String = ""
		If ETSD.Parameter Is List Then
			Dim lParameter As List = ETSD.Parameter
			For Idx = 0 To lParameter.Size -2
				sParameter = sParameter & lParameter.Get(Idx).As (String) & ";"
			Next
			sParameter = sParameter & lParameter.Get(lParameter.Size -1).As (String)
		Else
			sParameter = ETSD.Parameter
		End If
		lstFileLines.Add(ETSD.ETSpanType & "," & ETSD.SpanStart & "," & ETSD.SpanEnd & "," & sParameter)
	Next
	File.WriteList(Dir,Filename,lstFileLines)
	ToastMessageShow("File saved", False)
	Return True
End Sub

' Saves the displayed text with formatting as html. Note: not all styles (eg Relative size and ScaleX) are supported by the html conversion.
' Example: <code>SaveToHtml(rp.GetSafeDirDefaultExternal(""),"Test.html")</code>
Public Sub SaveToHtml(Dir As String, Filename As String) As Boolean
	SpannableStringET = refET.RunMethod("getText") ' includes the text with all spans
	Dim joHtml As JavaObject
	joHtml.InitializeStatic("android.text.Html")
    Dim Html As String = joHtml.RunMethod("toHtml",Array(SpannableStringET))
	File.WriteString(Dir,Filename,Html)
	Return True
End Sub

' Reads a html file and displays it in the EditText. Note: not all styles (eg Relative size and ScaleX) are supported by the html conversion.
' Example: <code>Dim rs As ResumableSub = ReadFromHtml(rp.GetSafeDirDefaultExternal(""),"Test.html")
'          Wait For (rs) Complete (bResult As Boolean)</code>
Public Sub ReadFromHtml(Dir As String, Filename As String) As ResumableSub
	If File.Exists(Dir,Filename) = False Then Return False
	Dim rs As ResumableSub = Clear(True)
 	    Wait For (rs) Complete (bResult As Boolean)
	UndoAddToHistory = False
	Dim joHtml As JavaObject
	joHtml.InitializeStatic("android.text.Html")
	Dim html As String = File.ReadString(Dir, Filename)
    EditText.Text = joHtml.RunMethod("fromHtml",Array(html))
	UndoAddToHistory = True
	AddToUndoRedoHistory
	Return True
End Sub

' Reads text with formatting from file and displays in EditText
' Example: <code>Dim rs As ResumableSub = ReadFromFile(rp.GetSafeDirDefaultExternal(""),"Test.html")
'          Wait For (rs) Complete (bResult As Boolean)</code>
Public Sub ReadFromFile(Dir As String, Filename As String) As ResumableSub
	If File.Exists(Dir,Filename) = False Then Return False
	Dim rs As ResumableSub = Clear(True)
 	    Wait For (rs) Complete (bResult As Boolean)
	UndoAddToHistory = False
	Dim lstFileLines As List = File.ReadList(Dir,Filename)
	Dim ValidFileFormat As Boolean = False
	Dim FileLine As String
	Do Until 1 = 0
		If lstFileLines.Size < 6 Then Exit
		FileLine = lstFileLines.Get(0) 
		If FileLine <> "[Text]" Then Exit
		Dim Text As String = ""
		Dim i As Int
		For i = 1 To lstFileLines.Size -1
			If lstFileLines.Get(i).As (String) = "[Properties]" Then Exit
			If Text = "" Then
				Text = lstFileLines.Get(i)
			Else
				Text = Text & CRLF & lstFileLines.Get(i)
			End If
		Next
		If lstFileLines.Get(i).As (String) <> "[Properties]" Then Exit
		For i = i + 1 To lstFileLines.Size -1
			If lstFileLines.Get(i).As (String) = "[Spans]" Then 
				ValidFileFormat = True
				Exit
			End If
			If lstFileLines.Get(i).As (String).Contains("=") = False Then Exit
			Dim s() As String = Regex.Split("=", lstFileLines.Get(i))
			If s.Length <> 2 Then Exit
			Select Case s(0)
				Case "Zoom"
					ET.TextSize = Val(s(1),20)
				Case "Typeface"
					Select Case s(1)
						Case "Default"
							ET.Typeface=Typeface.DEFAULT
						Case "FontAwesome"
							ET.Typeface=Typeface.FONTAWESOME
						Case "Monospace"
							ET.Typeface=Typeface.MONOSPACE
						Case "Sans_Serif"
							ET.Typeface=Typeface.SANS_SERIF
						Case "Serif"
							ET.Typeface=Typeface.SERIF
					End Select
				Case "Scale"
					Dim FileScale As Float =  Val(s(1),1)
					If FileScale < Scale Then
						ET.TextSize = ET.TextSize * (Scale * FileScale)
					else if FileScale > Scale Then
						ET.TextSize = ET.TextSize * (Scale / FileScale)
					End If
			End Select
		Next	
		If ValidFileFormat = False Then Exit
		Dim rs1 As ResumableSub = RunMethodAndWaitForTextChangedEventToFire("setText",0,0,Text)
 	    	Wait For (rs1) Complete (bResult As Boolean)
		ValidFileFormat = False
		SpannableStringET = refET.RunMethod("getText") ' includes the text with all spans
		If lstFileLines.Get(i).As (String) <> "[Spans]" Then Exit
		For i = i + 1 To lstFileLines.Size -1
			Dim s() As String = Regex.Split(",", lstFileLines.Get(i).As (String))	
			If s.Length <> 4 Then Exit
			Dim ETSD As ETSpanDetails
			ETSD.Initialize
			ETSD.ETSpanType = s(0) :	ETSD.spanstart = s(1) : ETSD.spanend = s(2) :	ETSD.Parameter = s(3)
			If ETSD.ETSpanType = SpanType.Image.Replace("android.text.style.","") Then
				Dim sParameter() As String = Regex.Split(";", ETSD.Parameter)
				' source, width, height
				Dim Source As String = sParameter(0)
				Dim Width As Int = sParameter(1)
				Dim Height As Int = sParameter(2)
				Dim lParameter As List
				lParameter.Initialize
				lParameter.Add(Source)
				lParameter.Add(Width)
				lParameter.Add(Height)
				AddSpan(SpannableStringET,SpanType.Image,ETSD.SpanStart,ETSD.SpanEnd,lParameter)
			Else
				AddSpan(SpannableStringET,ETSD.ETSpanType,ETSD.SpanStart,ETSD.SpanEnd,ETSD.Parameter)
			End If
		Next
		Exit
	Loop
	If i = lstFileLines.Size  Then ValidFileFormat = True
	If ValidFileFormat = False Then
		Dim rs2 As ResumableSub = Clear(True)
 	    	Wait For (rs2) Complete (bResult As Boolean)
		UndoAddToHistory = True
		ET.Text = "Invalid file format"
	Else
		UndoAddToHistory = True
		AddToUndoRedoHistory				
	End If
	If Slider_mBase.IsInitialized Then
		Slider_SetValue(ET.TextSize,False)
		Slider_SetPanelText("Zoom=" & Slider_Value,0)
	End If
	EditText.Invalidate
	Return True
End Sub

' Displays a summary of all the shortcuts (when using an external keyboard)
' Note: Automatically called via shortcut key
' Example: <code>Dim rs As ResumableSub = ShowShortcuts()
'          Wait For (rs) Complete (bResult As Boolean)</code>
Public Sub ShowShortcuts As ResumableSub
	Dim LeftColumn, RightColumn As String
	LeftColumn = "Ctrl-A ScaleX" & CRLF & "Ctrl-B Bold" & CRLF & "Ctrl-C Copy+" & CRLF & "Ctrl-I Italic" & CRLF & "Ctrl-K Strikethrough" & CRLF & "Ctrl-L Align Left" & CRLF & _
		"Ctrl-M Align Middle" & CRLF & "Ctrl-N Normal" & CRLF & "Ctrl-O Background color" & CRLF & "Ctrl-P Superscript" & CRLF & "Ctrl-R Align Right" & CRLF & _
		"Ctrl-S Subscript" & CRLF & "Ctrl-T Relative Size" & CRLF & "Ctrl-U Underline" & CRLF & "Ctrl-V Paste+" & CRLF & "Ctrl-X Cut+" & CRLF & "Ctrl-Y Redo" & CRLF & "Ctrl-Z Undo"
	RightColumn = "Alt-A Aqua" & CRLF & "Alt-B Blue" & CRLF & "Alt-F Fuschia" & CRLF & "Alt-G Green" & CRLF & "Alt-K Black" & CRLF & "Alt-L Lime" & CRLF & "Alt-M Maroon" & CRLF & _
		"Alt-N Navy" & CRLF & "Alt-P Purple" & CRLF & "Alt-R Red" & CRLF & "Alt-T Teal" & CRLF & "Alt-Y Grey" & CRLF & CRLF & "Ctrl-1 Show Colors" & CRLF & "Ctrl-2 Show Styles" & CRLF & _
		"Ctrl-Left/Right Arrows = Zoom" & CRLF & CRLF & "Ctrl-? Show this screen"
	Dim rs As ResumableSub =BGViews.Show2ColumnDialog("Shortcut Keys",LeftColumn,RightColumn,28)
    Wait For (rs) Complete (iResult As Int)
	return true
End Sub

#Region CopyAndPaste
' Copies the selected text complete with formatting
' Note: Call this sub if using Custom Context Menus (Copy+)
' Example: <code>Copy</code>
Public Sub Copy As Boolean
	If ET.SelectionLength = 0 Then Return False
	CopyStartIdx  = ET.SelectionStart
	Dim SelectionEnd As Int = ET.Selectionstart + ET.SelectionLength
	CopiedText = ET.Text.SubString2(CopyStartIdx,SelectionEnd)
	SpannableStringET = refET.RunMethod("getText") ' includes the text with all spans
	CopiedSpan = SpannableStringET.RunMethod("subSequence",Array As Object (EditText.SelectionStart, EditText.SelectionStart + EditText.SelectionLength))
	ToastMessageShow("Selection copied",False)
	Return True
End Sub

' Cuts the selected text complete with formatting
' Note: Call this sub if using Custom Context Menus (Cut+)
' Example: <code>Cut</code>
Public Sub Cut As ResumableSub
	If Copy = False Then Return False
	SpannableStringET = refET.RunMethod("getText") ' includes the text with all spans
	UndoAddToHistory = False	' running delete method will trigger text changed method which will in turn want to add to undo history
	Dim rs As ResumableSub = RunMethodAndWaitForTextChangedEventToFire("delete",ET.SelectionStart,ET.SelectionStart + ET.SelectionLength,"")
 	    Wait For (rs) Complete (bResult As Boolean)
	UndoAddToHistory = True
	AddToUndoRedoHistory
	Return True
End Sub

' Pastes the copied text and it's formatting
' Note: Call this sub if using Custom Context Menus (Paste+)
' Example: <code>Dim rs As ResumableSub = Paste()
'          Wait For (rs) Complete (bResult As Boolean)</code>
Public Sub Paste As ResumableSub
	If CopiedText = "" Then Return False
	UndoAddToHistory = False
	Dim ETSelectionStart As Int = ET.SelectionStart		' save cursor position as the cursor will move during the delete and insert operations
	SpannableStringET = refET.RunMethod("getText") ' includes the text with all spans
	
	' if selection length > 0 then need to delete the selected text first
	If ET.SelectionLength > 0 Then
		UndoAddToHistory = False	' running delete method will trigger text changed method which will in turn want to add to undo history
		Dim rs As ResumableSub = RunMethodAndWaitForTextChangedEventToFire("delete",ET.SelectionStart,ET.SelectionStart + ET.SelectionLength,"")
 	    	Wait For (rs) Complete (bResult As Boolean)
	End If
	' insert copied text
	Dim rs1 As ResumableSub = RunMethodAndWaitForTextChangedEventToFire("insert",ET.SelectionStart,0,CopiedText)
 	   	Wait For (rs1) Complete (bResult As Boolean)
	' create new spans for the copied text
	Dim lstSpanDetails As List = GetSpanDetails(CopiedSpan)
	For Each ETSDCopied As ETSpanDetails In lstSpanDetails
		AddSpan(SpannableStringET,ETSDCopied.ETSpanType,ETSDCopied.SpanStart  + ETSelectionStart,ETSDCopied.SpanEnd  + ETSelectionStart,ETSDCopied.Parameter)
	Next
	UndoAddToHistory = True
	AddToUndoRedoHistory
	ET.SelectionStart = ETSelectionStart
	Return True
End Sub
#End Region

#Region UndoRedo
' Add the current state (text and formatting) of the EditText to the UndoRedoHistory
' Note: This class will automatically call this sub when required but can be called by the user as well.
' Example: <code>AddToUndoRedoHistory</code>
Public Sub AddToUndoRedoHistory()
	If UndoAddToHistory = False Then Return
	SpannableStringET = refET.RunMethod("getText") ' includes the text with all spans

	Dim URD As UndoRedoDetails
	URD.Initialize
	URD.Text = ET.Text
	URD.CursorPosition = ET.SelectionStart
	URD.SpannableStringUndo = SpannableStringET.RunMethod("subSequence",Array As Object (0, EditText.Text.Length))	' is a copy NOT a reference
	URD.ZoomLevel = ET.TextSize
	UndoRedoIdx = UndoRedoIdx + 1
	If UndoRedoIdx = UndoRedoLimit Then
		LstUndoRedo.RemoveAt(0)
		UndoRedoIdx = UndoRedoIdx - 1
	End If
	If UndoRedoIdx >= LstUndoRedo.Size Then
		LstUndoRedo.Add(URD)
	Else
		LstUndoRedo.Set(UndoRedoIdx,URD)	
	End If
End Sub

' Performs an Undo operation.
' Note: This is called automatically if using the inbuilt Style Spinner but can be called by the user as well.
' Example: <code>Undo</code>
Public Sub Undo
	If UndoRedoIdx <= 0 Then
		ToastMessageShow("Undo limit reached",False)
		Return
	End If
	UndoRedoIdx = UndoRedoIdx - 1
	UndoRedo
End Sub

' Performs an Redo operation.
' Note: This is called automatically if using the inbuilt Style Spinner but can be called by the user as well.
' Example: <code>Redo</code>
Public Sub Redo
	If UndoRedoIdx >= LstUndoRedo.Size -1 Then
		ToastMessageShow("Redo limit reached",False)
		Return
	End If
	UndoRedoIdx = UndoRedoIdx + 1
	UndoRedo
End Sub

' Only used internally by this class
Private Sub UndoRedo As ResumableSub
	' clear the whole EditText and recreate the text with the spans
	UndoAddToHistory = False
	Dim URD As UndoRedoDetails
	URD.Initialize
	URD = LstUndoRedo.Get(UndoRedoIdx)
	' need to use long form so the wait variables are different. Otherwise it sees them both as complete
	Dim rs As ResumableSub = Clear(False)
 	    Wait For (rs) Complete (bResult As Boolean)
	ET.Text = URD.SpannableStringUndo
	'Dim rs1 As ResumableSub = RunMethodAndWaitForTextChangedEventToFire("setText",0,0,URD.Text)
 	'    Wait For (rs1) Complete (bResult As Boolean)
	ET.SelectionStart = URD.CursorPosition
	ET.TextSize = URD.ZoomLevel
	Slider_SetValue(ET.TextSize,False)
	Slider_SetPanelText("Zoom=" & Slider_Value,0)
	UndoAddToHistory = True
	Return True
End Sub
#End Region

#Region Events
' This sub is called before the key makes it to the EditText. Returning 'True' will kill the keypress, 'False' will forward it on to the EditText.
' Use this sub to define the hot keys.
Private Sub ET_OnKeyPress(ViewTag As Object,keycode As Int, keyevent As Object) As Boolean
	If IsReadOnly Then Return True	' kill any keypresses that might come through in readonly mode
	Dim const ACTION_DOWN As Int = 0
	Dim const ACTION_UP As Int = 1

	Dim r As Reflector
	r.Target = keyevent	
	Dim ACTION As Int = r.RunMethod("getAction")
	'Log("EditText Keypress " & keycode & ", " & keyevent)
	'Dim DeviceId As Int = r.RunMethod("getDeviceId")
	'Dim Source As Int = r.RunMethod("getSource")
	
	' Keycodes
	'         1         2         3         4         5         6         7
	'01234567801234567890123456789012345678901234567890123456789012345678901234567890
	'       0123456789   LR      abcdefghijklmnopqrstuvwxyz    S                /
	'                    aa                                    h                ?
	'                    rr                                    i
	'                    rr                                    f
	'                    oo                                    t
	'                    ww
	
	Select ACTION
		Case ACTION_UP
			Select keycode
				Case 57
					AltDown = False
				Case 113
					CtrlDown = False
			End Select
		Case ACTION_DOWN
			Select keycode
				Case 57
					AltDown = True
				Case 113
					CtrlDown = True
			End Select
			If CtrlDown Then
				' Style menu hotkeys
				Select keycode
					Case 8	'1'
						If spnColors.IsInitialized Then PerformClick(spnColors)
						CtrlDown = False	' dialog will cause ACTION_UP not to register here
					Case 9 '2'
						If spnStyles.IsInitialized Then PerformClick(spnStyles)
						CtrlDown = False	' dialog will cause ACTION_UP not to register here
					Case 21	' left arrow
						If Slider_mBase.IsInitialized Then Slider_SetValue(ET.TextSize - 1,True)
					Case 22 ' right arrow
						If Slider_mBase.IsInitialized Then Slider_SetValue(ET.TextSize + 1,True)
					Case 29	'a'
						AddStyle("ScaleX")
						CtrlDown = False	' dialog will cause ACTION_UP not to register here
					Case 30	'b'
						AddStyle ("Bold")
					Case 31	'c'
						Copy
					Case 37	'i'
						AddStyle("Italic")
					Case 39	'k'
						AddStyle("StrikeThrough")
					Case 40	'l'
						AddStyle("Left")
					Case 41	'm'
						AddStyle("Middle")
					Case 42 'n'
						AddStyle("Normal")
					Case 43 'o'
						AddStyle("Background Color")
						CtrlDown = False	' dialog will cause ACTION_UP not to register here
					Case 44 'p'
						AddStyle("SuperScript")
					Case 46 'r'
						AddStyle("Right")
					Case 47 's'
						AddStyle("SubScript")
					Case 48	't'
						AddStyle("Relative Size")
						CtrlDown = False	' dialog will cause ACTION_UP not to register here
					Case 49	'u'
						AddStyle("Underline")
					Case 50	'v'
						Paste
					Case 52	'x'
						Cut
					Case 53	'y'
						Redo
					Case 54	'z'
						Undo
					Case 59, 76 '/?'
						ShowShortcuts
						CtrlDown = False
						EditText.RequestFocus
				End Select
				Return True
			End If
			If AltDown Then
				' Color hot keys
				Select keycode
					Case 21	' left arrow
						If Slider_mBase.IsInitialized Then Slider_SetValue(ET.TextSize - 1,True)
					Case 22 ' right arrow
						If Slider_mBase.IsInitialized Then Slider_SetValue(ET.TextSize + 1,True)
					Case 39	'k'
						Dim clr As Int = lstColors.Get(0)
						AddSpanToET(SpanType.ForegroundColor, clr)
					Case 41	'm'
						Dim clr As Int = lstColors.Get(1)
						AddSpanToET(SpanType.ForegroundColor, clr)
					Case 35	'g'
						Dim clr As Int = lstColors.Get(2)
						AddSpanToET(SpanType.ForegroundColor, clr)
					Case 42 'n'
						Dim clr As Int = lstColors.Get(3)
						AddSpanToET(SpanType.ForegroundColor, clr)
					Case 44 'p'
						Dim clr As Int = lstColors.Get(4)
						AddSpanToET(SpanType.ForegroundColor, clr)
					Case 48	't'
						Dim clr As Int = lstColors.Get(5)
						AddSpanToET(SpanType.ForegroundColor, clr)
					Case 53	'y'
						Dim clr As Int = lstColors.Get(6)
						AddSpanToET(SpanType.ForegroundColor, clr)
					Case 46 'r'
						Dim clr As Int = lstColors.Get(7)
						AddSpanToET(SpanType.ForegroundColor, clr)
					Case 40	'l'
						Dim clr As Int = lstColors.Get(8)
						AddSpanToET(SpanType.ForegroundColor, clr)
					Case 30	'b'
						Dim clr As Int = lstColors.Get(9)
						AddSpanToET(SpanType.ForegroundColor, clr)
					Case 34	'f'
						Dim clr As Int = lstColors.Get(10)
						AddSpanToET(SpanType.ForegroundColor, clr)
					Case 29	'a'
						Dim clr As Int = lstColors.Get(11)
						AddSpanToET(SpanType.ForegroundColor, clr)
					Case 59, 76 '/?'
						ShowShortcuts
						AltDown = False	' dialog will cause ACTION_UP not to register here
				End Select
				Return True
			End If
	End Select
	Return False
End Sub

' Automatically called whenever the user changes the text.
Private Sub ET_textchanged (Old As String, New As String)
	ETTextChangeEventTriggered = True
	AddToUndoRedoHistory
End Sub
#End Region

#Region CustomViews
' Creates a Color Selector from a standard spinner. 
' If used, this class will handle all of the selections made automatically.
' Set BorderColor to Transparent if not required.
' Example:<code>CreateColorSpinner(Panel1,0,0,colors.Black)</code>
Public Sub CreateColorSpinner(Parent As Panel, Left As Int, Top As Int, BorderColor As Int) 
	If spnColors.IsInitialized Then Return	' can only call once
	spnColors.Initialize("spnColors")
	spnColors.Color = Colors.Transparent
	spnColors.Padding = Array As Int(0,0,0,0)
	spnColors.TextSize = Min(35,35 * Scale)	' 35 seems to be the magic textsize for a spinner where each item fills the space entirely
	spnColors.Clear

	Dim TextLength As Int= 12	' the length of each entry
	Dim FirstEntry As String = "|||          "
	' put Red, Green, Blue bars as the top entry
	spnColors.TextColor =Colors.Transparent
	Dim so As JavaObject
	so.InitializeNewInstance("android.text.SpannableStringBuilder",Array As Object(FirstEntry))
	AddSpan(so,"android.text.style.TypefaceSpan",0 , FirstEntry.length,"monospace")
	AddSpan(so,SpanType.BackgroundColor,0 , FirstEntry.length,Colors.Transparent)
	AddSpan(so,SpanType.ForegroundColor,0 , 1,Colors.red)
	AddSpan(so,SpanType.BackgroundColor,0 , 1,Colors.red)
	AddSpan(so,SpanType.ForegroundColor,1 , 2,Colors.Green)
	AddSpan(so,SpanType.BackgroundColor,1 , 2,Colors.green)
	AddSpan(so,SpanType.ForegroundColor,2 , 3,Colors.blue)
	AddSpan(so,SpanType.BackgroundColor,2 , 3,Colors.blue)
	spnColors.AddAll(Array As Object(so))
	' note that the width of the spinner only needs to accomodate the width of the FirstEntry and NOT necessarily the width of the other entries
	spnColors.Width = MeasureTextWidth(Parent,"|",spnColors.TextSize,Typeface.MONOSPACE)  * 4.5
	' for the entries, the lines need to be the same length so the backgrounds are the same length
	' there is also no Gravity in the spinner, so read each colour name and then manually space them so they're in the middle
	' Use Monospace so that the widths are consistent
	Dim LstColorNames As List : LstColorNames.Initialize
	lstColors.clear
	Dim lstUnderlineHighlights As List
	lstUnderlineHighlights.Initialize2(Array As Int(5,1,1,1,1,1,4,1,1,1,1,1))
	
	For i = 0 To lstUseColors.Size -1
		Dim UseColor As String = lstUseColors.Get(i)
		' split out the color name and color value
		Dim s() As String = Regex.Split(":", UseColor)
		Dim ColorName As String = s(0)
		Dim Clr As Int = Bit.Or(0xff000000, Bit.ParseInt(s(1), 16))
		lstColors.Add(Clr)
		Dim UnderlineHighlightPos As Int = lstUnderlineHighlights.Get(i)
		' each entry is 12 characters long, so space them out to put name in the centre
		Dim NewColorname As String  = ""
		For Idx= 1 To Round((TextLength-ColorName.Length) /2)
			NewColorname = NewColorname & " "
			If UnderlineHighlightPos > 0 Then UnderlineHighlightPos = UnderlineHighlightPos + 1
		Next
		NewColorname = NewColorname & ColorName
		For Idx = NewColorname.Length To TextLength 
			NewColorname = NewColorname & " "
		Next
		' build the spannablestring
		Dim so As JavaObject
		so.InitializeNewInstance("android.text.SpannableStringBuilder",Array As Object(NewColorname))
		AddSpan(so,SpanType.ForegroundColor,0 , TextLength,Colors.white)
		AddSpan(so,SpanType.BackgroundColor,0 , TextLength,Clr)
		AddSpan(so,SpanType.Style,0 , TextLength,Typeface.STYLE_BOLD)
		AddSpan(so,"android.text.style.TypefaceSpan",0 , TextLength,"monospace")
		If UnderlineHighlightPos > 0 Then
			AddSpan(so,SpanType.Underline,UnderlineHighlightPos-1 ,UnderlineHighlightPos,0)
		End If
		' add it to the spinner
		spnColors.AddAll(Array As Object(so))		
	Next
	spnColors.Tag = lstColors	' 	' the tag contains the color list
	spnColors.SelectedIndex =0
	Dim ControlBackground As ColorDrawable	' draw border around it
	ControlBackground.initialize2(Colors.Transparent,20,1,BorderColor)
	spnColors.Background = ControlBackground
	Parent.AddView(spnColors,Left,Top,spnColors.Width,MeasureTextHeight(Parent,spnColors.TextSize))
	Dim r As Reflector
	r.Target = spnColors
	r.SetOnTouchListener("SpnColors_OnTouch")
	spnColors.Visible = True
End Sub

' Creates a formatted Style Selector with Edit functions from a standard spinner
' If used, this class will handle all of the selections made automatically.
' Set BorderColor to Transparent if not required.
' Example:<code>CreateStyleSpinner(Panel1,0,0,Colors.Black)</code>
Public Sub CreateStyleSpinner(Parent As Panel, Left As Int, Top As Int, BorderColor As Int)
	If spnStyles.IsInitialized Then Return 	' can only call once (Use setlayout to change position)
	spnStyles.Initialize("spnStyles")
	spnStyles.Color = Colors.Transparent
	spnStyles.Padding = Array As Int(0,0,0,0)
	spnStyles.TextSize =  Min(35,35 * Scale)	' 35 seems to be the magic textsize for a spinner where each item fills the space entirely
	spnStyles.Clear
	Dim FirstEntry As String 
	spnStyles.TextColor = Colors.Transparent
	' put BUI as Bold, Italic and Underline as the firstentry
	FirstEntry =  "BIU"
	Dim so As JavaObject
	so.InitializeNewInstance("android.text.SpannableStringBuilder",Array As Object(FirstEntry))
	AddSpan(so,"android.text.style.TypefaceSpan",0 , FirstEntry.length,"monospace")
	AddSpan(so,SpanType.BackgroundColor,0 , FirstEntry.length,Colors.Transparent)
	AddSpan(so,SpanType.style,0 , 1,Typeface.STYLE_BOLD)
	AddSpan(so,SpanType.style,1 , 2,Typeface.STYLE_ITALIC)	
	AddSpan(so,SpanType.Underline,2 ,3,0)	
	spnStyles.AddAll(Array As Object(so))
	' note that the width of the spinner only needs to accomodate the width of the FirstEntry and NOT necessarily the width of the other entries
	spnStyles.Width = MeasureTextWidth(Parent,FirstEntry,spnStyles.TextSize,Typeface.MONOSPACE) * 1.5
	' for the entries, the lines need to be the same length so the backgrounds are the same length
	' there is also no Gravity in the spinner so read each colour name and then manually space them so they're in the middle
	' Use Monospace so that the widths are consistent
	Dim lstStyleMenu As List
	' make sure that each entry is the same length
	lstStyleMenu.Initialize2(Array As String("Bold","Italic","Normal", "Relative Size", "ScaleX","Subscript","     Superscript","StrikeThrough", "Underline","Background Color","Left            ","     Middle     ","           Right","Undo (^Z)       ","Redo (^Y)       "))
	Dim lstUnderlineHighlights As List
	lstUnderlineHighlights.Initialize2(Array As Int(1,1,1,5,3,1,8,5,1,13,1,6,12,8,8))
	For i = 0 To lstStyleMenu.Size -1
		Dim Style As String = lstStyleMenu.Get(i)
		Dim so As JavaObject
		so.InitializeNewInstance("android.text.SpannableStringBuilder",Array As Object(Style))
		AddSpan(so,"android.text.style.TypefaceSpan",0 , Style.length,"monospace")
		AddSpan(so,SpanType.ForegroundColor,0 ,  Style.length,Colors.Black)
		Select Case Style.trim
			Case "Background Color"
				AddSpan(so,SpanType.BackgroundColor,0 ,10,Colors.Gray)
				AddSpan(so,SpanType.BackgroundColor,11,16,Colors.RGB(0,255,0))
			Case "Bold"
				AddSpan(so,SpanType.BackgroundColor,0 ,Style.length,Colors.white)
				AddSpan(so,SpanType.Style,0 ,Style.length,Typeface.STYLE_BOLD)
			Case "Italic"
				AddSpan(so,SpanType.BackgroundColor,0 ,Style.length,Colors.white)
				AddSpan(so,SpanType.Style,0 ,Style.length,Typeface.STYLE_ITALIC)
			Case "Normal"
				AddSpan(so,SpanType.BackgroundColor,0 ,Style.length,Colors.white)
			Case "Relative Size"
				AddSpan(so,SpanType.BackgroundColor,0 ,Style.length,Colors.white)
				AddSpan(so,SpanType.RelativeSize,0 ,9,.75)
			Case "ScaleX"
				AddSpan(so,SpanType.BackgroundColor,0 ,Style.length,Colors.white)
				AddSpan(so,SpanType.ScaleX,0 ,Style.length,2)
			Case "SubScript"
				AddSpan(so,SpanType.BackgroundColor,0 ,Style.length,Colors.white)
				AddSpan(so,SpanType.RelativeSize,0 ,Style.length,.85)
				AddSpan(so,SpanType.Subscript,0 ,3,0)
			Case "SuperScript"
				AddSpan(so,SpanType.BackgroundColor,0 ,Style.length,Colors.white)
				AddSpan(so,SpanType.RelativeSize,0 ,Style.length,.85)
				AddSpan(so,SpanType.Superscript,5 ,10,0)
			Case "StrikeThrough"
				AddSpan(so,SpanType.BackgroundColor,0 ,Style.length,Colors.white)
				AddSpan(so,SpanType.StrikeThrough,0 ,Style.length,0)
			Case "Underline"
				AddSpan(so,SpanType.BackgroundColor,0 ,Style.length,Colors.white)
				AddSpan(so,SpanType.Underline ,0 ,Style.length,0)
			Case "Left", "Middle", "Right"
				AddSpan(so,SpanType.BackgroundColor,0 ,Style.length,Colors.RGB(173,216,230))
			Case "Undo", "Redo"
				AddSpan(so,SpanType.BackgroundColor,0 ,Style.length,Colors.LightGray)
		End Select
		Dim UnderlineHighlightPos As Int = lstUnderlineHighlights.Get(i)
		If UnderlineHighlightPos > 0 Then
			AddSpan(so,SpanType.Underline, UnderlineHighlightPos-1 ,UnderlineHighlightPos,0)
		End If
		spnStyles.AddAll(Array As Object(so))
	Next
	spnStyles.SelectedIndex =0
	Dim ControlBackground As ColorDrawable	' draw border around it
	ControlBackground.initialize2(Colors.Transparent,20,1,BorderColor)
	spnStyles.Background = ControlBackground
	Parent.AddView(spnStyles,Left,Top,spnStyles.Width,MeasureTextHeight(Parent,spnStyles.TextSize))
	Dim r As Reflector
	r.Target = spnStyles
	r.SetOnTouchListener("SpnStyles_OnTouch")
	spnStyles.Visible=True
End Sub

' Get the position and dimensions of the Colors spinner.
Public Sub GetSpnColorsLayout As Rect
	If spnColors.IsInitialized = False Then Return Null
	Dim R As Rect 
	r.Initialize(spnColors.Left,spnColors.Top,spnColors.Width - spnColors.left,spnColors.Height-spnColors.top)
	Return R
End Sub

' Allow user to change the position of the Colors spinner
'Public Sub SetSpnColorsLayout (Left As Int, Top As Int)
'	If spnColors.IsInitialized = False Then Return 
'	spnColors.SetLayout(Left,Top,spnColors.Width,spnColors.Height)
'End Sub

' Get the position and dimensions of the Styles spinner
Public Sub GetSpnStylesLayout As Rect
	If spnStyles.IsInitialized = False Then Return Null
	Dim R As Rect 
	r.Initialize(spnStyles.Left,spnStyles.Top,spnStyles.Width - spnStyles.left,spnStyles.Height-spnStyles.top)
	Return R
End Sub

' Allow user to change the position of the Styles spinner
'Public Sub SetSpnStylesLayout (Left As Int, Top As Int)
'	If spnStyles.IsInitialized = False Then Return 
'	spnStyles.SetLayout(Left,Top,spnStyles.Width,spnStyles.Height)
'End Sub

' Called when user touches the spinner. If return value is True then ItemClick sub is NOT called.
Private Sub SpnColors_OnTouch (o As Object, ACTION As Int, x As Float, y As Float, motion As Object) As Boolean
	If y <= spnColors.Height Then
		' first item touched, make not raise ItemClick event if spinner is already on this item, so need to handle it here.
		Dim Device As Phone
		Device.HideKeyboard(B4XPages.GetNativeParent(B4XPages.mainpage))
	End If
	Return False	' pass on the keystroke
End Sub

' Called when user touches the spinner. If return value is True then ItemClick sub is NOT called.
Private Sub SpnStyles_OnTouch (o As Object, ACTION As Int, x As Float, y As Float, motion As Object) As Boolean
	If y <= spnStyles.Height Then
		' first item touched, make not raise ItemClick event if spinner is already on this item, so need to handle it here.
		Dim Device As Phone
		Device.HideKeyboard(B4XPages.GetNativeParent(B4XPages.mainpage))
	End If
	Return False	' pass on the keystroke
End Sub

' Automatically called when used chooses a Style from the inbuilt spinner
Private Sub SpnStyles_ItemClick (Position As Int, Value As Object)
	If Position = 0 Then Return
	Dim Style As String = Value
	AddStyle(Style)
	spnStyles.SelectedIndex =0
End Sub

' Automatically called when used chooses a Color from the inbuilt spinner
Private Sub SpnColors_ItemClick (Position As Int, Value As Object)
	If Position = 0 Then Return
	Dim lstColors As List = spnColors.Tag
	Dim Clr As Int = lstColors.Get(Position -1)
	AddSpanToET(SpanType.ForegroundColor,Clr)
	spnColors.SelectedIndex = 0
End Sub

' Creates a Zoom slider using the inbuilt 'Slider' pseudoclass	(Code at the end)
' If used, this class will handle all of the adjustments made to the slider automatically.	
Public Sub CreateZoomSlider(Parent As Panel, Left As Int, Top As Int, Width  As Int, Height As Int)
	If Slider_mBase.IsInitialized Then Return 	' can only call once
	Slider_CreateASSlider(Parent , Left , Top, Width , Height, Scale)
	Slider_SetValue(ET.TextSize,False)
	Slider_SetPanelText("Zoom=" & Slider_Value,0)
End Sub

' Allows user to get the Slider size and position
Public Sub GetZoomSliderLayout As Rect
	If Slider_mBase.IsInitialized Then Return Null
	Return Slider_Position
End Sub

' Sets the textsize for the Slider (correct size should have already been selected but just in case it needs to be changed)
Public Sub SetZoomSliderTextSize(NewSize As Int)
	If Slider_mBase.IsInitialized Then Return 	
	Slider_TxtSize = NewSize
End Sub

' Called when Slider value changed.
' Note: Automatically called by this class when required
Private Sub ZoomSliderValueChanged(NewValue As Int)
	ET.TextSize=NewValue
	Slider_SetPanelText("Zoom=" & Slider_Value,0)
End Sub

' Called when user raises finger from the slider
' Note: Automatically called by this class when required
Private Sub ZoomSliderValueChangedFinished(NewValue As Int, PreviousValue As Int)
	' resize any images as they don't automatically resize when zoomed
	' Do it here when user stops moving the slider, otherwise it will try to do this while the slider is moving and may not be quick enough
	Slider_IgnoreChange = True 
	Dim lstSpanDetails As List = GetSpanDetails(SpannableStringET)
 	UndoAddToHistory = False
	Dim Ratio As Float = NewValue / PreviousValue
	For Each ETSD As ETSpanDetails In lstSpanDetails
		If ETSD.ETSpanType <> SpanType.Image.Replace("android.text.style.","") Then Continue
		Dim lParameter As List = ETSD.Parameter
		Dim Source As String = lParameter.Get(0)
		If Source.Contains("[NZ]") Then Continue
		Dim NewWidth As Int= Round(lParameter.Get(1) * Ratio)
		lParameter.Set(1,NewWidth)
		Dim NewHeight As Int = Round(lParameter.Get(2) * Ratio)
		lParameter.Set(2,NewHeight)
		' delete old span (the image)
		Dim rs As ResumableSub = RunMethodAndWaitForTextChangedEventToFire("delete",ETSD.SpanStart, ETSD.SpanEnd,"")
			Wait For (rs) Complete (bResult As Boolean)
		' add a space where the image was
		Dim rs1 As ResumableSub = RunMethodAndWaitForTextChangedEventToFire("insert",ETSD.SpanStart, ETSD.SpanEnd," ")
			Wait For (rs1) Complete (bResult As Boolean)
		' insert new span with new size
		AddSpan(SpannableStringET,SpanType.Image,ETSD.SpanStart,ETSD.SpanEnd,lParameter)
	Next
	Slider_IgnoreChange = False
	UndoAddToHistory = True
	AddToUndoRedoHistory
End Sub
#End Region

' These subs not accesible to the user
#Region Private subs
' Actions from the Style spinner
Private Sub AddStyle(Style As String)
	Select Case Style.Trim
		Case "Bold"
			AddSpanToET(SpanType.Style,Typeface.STYLE_BOLD)
		Case "Italic"
			AddSpanToET(SpanType.Style,Typeface.STYLE_ITALIC)
		Case "Underline"
			AddSpanToET(SpanType.Underline,0)
		Case "Bold Italic"
			AddSpanToET(SpanType.Style,Typeface.STYLE_BOLD_ITALIC)
		Case "Normal"
			RemoveSpans
		Case "Left"
			Align(AlignType.Left)
		Case "Middle"
			Align(AlignType.Centre)
		Case "Right"
			Align(AlignType.right)
		Case "Undo (^Z)"
			Undo
		Case "Redo (^Y)"
			Redo
		Case "Relative Size"
			AddSpanToET(SpanType.RelativeSize,0)
		Case "ScaleX"
			AddSpanToET(SpanType.ScaleX,0)
		Case "StrikeThrough"
			AddSpanToET(SpanType.StrikeThrough,0)
		Case "Background Color"
			AddSpanToET(SpanType.BackgroundColor,1)
		Case "Subscript"
			AddSpanToET(SpanType.Subscript,0)
		Case "Superscript"
			AddSpanToET(SpanType.Superscript,0)
	End Select
End Sub

' Adds a span to the passed SpannableString
Private Sub AddSpan(SpannableString As JavaObject, ETSpanType As String, SpanStart As Int, SpanEnd As Int, Parameter As Object)
	If ETSpanType.Contains("android.text.style.") = False Then ETSpanType = "android.text.style." & ETSpanType
	Dim joSpan As JavaObject
	Select Case ETSpanType
		Case SpanType.ForegroundColor,  SpanType.BackgroundColor, SpanType.Style
			Dim iParameter As Int = Parameter
			joSpan.InitializeNewInstance(ETSpanType, Array As Object(iParameter))
			SpannableString.RunMethod("setSpan", Array As Object(joSpan, SpanStart , SpanEnd, SPAN_EXCLUSIVE_EXCLUSIVE))
		Case SpanType.RelativeSize, SpanType.ScaleX
			Dim fParameter As Float = Parameter
			joSpan.InitializeNewInstance(ETSpanType, Array As Object(fParameter))
			SpannableString.RunMethod("setSpan", Array As Object(joSpan, SpanStart , SpanEnd, SPAN_EXCLUSIVE_EXCLUSIVE))
		Case "android.text.style.TypefaceSpan"
			Dim sParameter As String = Parameter
			joSpan.InitializeNewInstance(ETSpanType, Array As Object(sParameter))
			SpannableString.RunMethod("setSpan", Array As Object(joSpan, SpanStart , SpanEnd, SPAN_EXCLUSIVE_EXCLUSIVE))
		Case "android.text.style.ImageSpan"
			' parameter is a list
			' First entry is location, 2nd entry is the width, 3rd entry is the height
			Dim lParameter As List = Parameter
			Dim Source As String = lParameter.Get(0)
			Dim Width As Int = lParameter.Get(1)
			Dim Height As Int = lParameter.Get(2)
			If File.Exists(Source,"") Then
				Dim bm, bmresized As Bitmap
				bm.Initialize(Source,"")
				bmresized = bm.Resize(Width,Height,False)
				Dim joBD  As JavaObject 
				joBD.InitializeNewInstance("android.graphics.drawable.BitmapDrawable", Array As Object(bmresized))
				joBD.RunMethod("setBounds",Array As Object(0,0,bmresized.Width,bmresized.Height))
				Dim joSpan As JavaObject
				joSpan.InitializeNewInstance(ETSpanType, Array As Object(joBD,Source,0))
				SpannableString.RunMethod("setSpan", Array As Object(joSpan, SpanStart , SpanEnd,SPAN_EXCLUSIVE_EXCLUSIVE))				
			End If
		Case Else
			' spans with no parameters (eg Underline)
			joSpan.InitializeNewInstance(ETSpanType, Null)
			SpannableString.RunMethod("setSpan", Array As Object(joSpan, SpanStart , SpanEnd, SPAN_EXCLUSIVE_EXCLUSIVE))
	End Select
End Sub

' Goes thru a spannable string and extracts the details of the individual spans.
' Note: Requires the Java code at the end of the Main module [Code can be copied from the end of this class]
Private Sub GetSpanDetails(SpannableString As JavaObject) As List
	' make a copy of the SpannableString
	Dim Length As Int = SpannableString.RunMethod("length",Null)
	Dim joCopy As JavaObject = SpannableString.RunMethod("subSequence",Array As Object (0, Length))	' makes a copy NOT a reference
	' run Java function to get all the spans
	Dim joGetAllSpans As JavaObject
	joGetAllSpans.InitializeContext
    Dim joSpans As JavaObject = joGetAllSpans.RunMethod("getAllSpans",Array(joCopy))
	' go thru each span and save the details
	Dim lstSpanDetails As List
	lstSpanDetails.Initialize
	Dim Size As Int = joSpans.RunMethod("size",Null)
	Dim SpanStart, SpanEnd As Int, Parameter As Object
	For Idx = 0 To Size - 1
		Dim joSpan As JavaObject = joSpans.RunMethod("get",Array As Object(Idx))
		Dim r As Reflector
   		r.Target = joSpan
   		r.Target = r.RunMethod("getClass")
		Dim ClassName As String = r.RunMethod("getName")
		SpanStart = 0 : SpanEnd = 0 : Parameter = 0
		Select Case ClassName
			Case "android.text.style.ForegroundColorSpan"
				SpanStart = SpannableString.RunMethod("getSpanStart", Array As Object(joSpan))
				SpanEnd = SpannableString.RunMethod("getSpanEnd", Array As Object(joSpan))
				Parameter = joSpan.RunMethod("getForegroundColor",Null)
			Case "android.text.style.BackgroundColorSpan"
				SpanStart = SpannableString.RunMethod("getSpanStart", Array As Object(joSpan))
				SpanEnd = SpannableString.RunMethod("getSpanEnd", Array As Object(joSpan))
				Parameter = joSpan.RunMethod("getBackgroundColor",Null)
			Case "android.text.style.UnderlineSpan"
				SpanStart = SpannableString.RunMethod("getSpanStart", Array As Object(joSpan))
				SpanEnd = SpannableString.RunMethod("getSpanEnd", Array As Object(joSpan))
			Case "android.text.style.StyleSpan"
				SpanStart = SpannableString.RunMethod("getSpanStart", Array As Object(joSpan))
				SpanEnd = SpannableString.RunMethod("getSpanEnd", Array As Object(joSpan))
				Parameter = joSpan.RunMethod("getStyle",Null)
			Case "android.text.style.RelativeSizeSpan"
				SpanStart = SpannableString.RunMethod("getSpanStart", Array As Object(joSpan))
				SpanEnd = SpannableString.RunMethod("getSpanEnd", Array As Object(joSpan))
				Parameter = joSpan.RunMethod("getSizeChange",Null)
			Case "android.text.style.ScaleXSpan"
				SpanStart = SpannableString.RunMethod("getSpanStart", Array As Object(joSpan))
				SpanEnd = SpannableString.RunMethod("getSpanEnd", Array As Object(joSpan))
				Parameter = joSpan.RunMethod("getScaleX",Null)
			Case "android.text.style.SubscriptSpan"
				SpanStart = SpannableString.RunMethod("getSpanStart", Array As Object(joSpan))
				SpanEnd = SpannableString.RunMethod("getSpanEnd", Array As Object(joSpan))
			Case "android.text.style.SuperscriptSpan"
				SpanStart = SpannableString.RunMethod("getSpanStart", Array As Object(joSpan))
				SpanEnd = SpannableString.RunMethod("getSpanEnd", Array As Object(joSpan))
			Case "android.text.style.StrikethroughSpan"
				SpanStart = SpannableString.RunMethod("getSpanStart", Array As Object(joSpan))
				SpanEnd = SpannableString.RunMethod("getSpanEnd", Array As Object(joSpan))
			Case "android.text.style.ImageSpan"
				SpanStart = SpannableString.RunMethod("getSpanStart", Array As Object(joSpan))
				SpanEnd = SpannableString.RunMethod("getSpanEnd", Array As Object(joSpan))
				Dim lParameter As List
				lParameter.Initialize
				' get the info back out of the span
				Dim Source As String = joSpan.RunMethod("getSource",Null)
				lParameter.Add(Source)
				Dim joGetBD As JavaObject = joSpan.RunMethod("getDrawable",Null)
				Dim joCopyBounds As JavaObject = joGetBD.RunMethod("copyBounds",Null)
				Dim Width As Int = joCopyBounds.RunMethod("width",Null)	
				lParameter.Add(Width)	
				Dim Height As Int = joCopyBounds.RunMethod("height",Null)
				lParameter.Add(Height)
				Parameter = lParameter
			Case Else
				Continue
		End Select
		Dim ETSD As ETSpanDetails
		ETSD.Initialize
		ETSD.ETSpanType = ClassName.Replace("android.text.style.","")
		ETSD.SpanStart = SpanStart
		ETSD.SpanEnd = SpanEnd
		ETSD.Parameter = Parameter
		lstSpanDetails.Add(ETSD)
	Next
	Return lstSpanDetails
End Sub

' Runs the selected method but wait for the Text Changed event on the EditText to fire before continuing
Private Sub RunMethodAndWaitForTextChangedEventToFire(Method As String, SelStart As Int, SelEnd As Int, Text As String) As ResumableSub
	SpannableStringET = refET.RunMethod("getText") ' includes the text with all spans
	ETTextChangeEventTriggered = False
	Select Case Method
		Case "setText"
			If ET.Text = Text Then Return False
			ET.Text = Text
		Case "delete"
			If SelStart = SelEnd Then Return False
			SpannableStringET.RunMethod("delete",Array As Object(SelStart,SelEnd))
		Case "insert"
			If SelStart < 0 Or SelStart > ET.Text.Length Then Return False
			If Text = "" Then Return False
			SpannableStringET.RunMethod("insert",Array As Object(SelStart,Text))
		Case "replace"
			If SelStart < 0 Or SelStart > ET.Text.Length Then Return False
			If SelEnd < 0 Or SelEnd > ET.Text.Length Then Return False
			If SelEnd - SelStart < 0 Then Return False
			If Text = "" Then Return False
			SpannableStringET.RunMethod("replace",Array As Object(SelStart,SelEnd,Text))
	End Select
	' wait for event to trigger (sometimes it doesn't fire, so give it a set time to do so
	Dim StartTime As Long = DateTime.Now
	Do Until ETTextChangeEventTriggered = True
		Sleep (100)
		If DateTime.Now - StartTime > 2000 Then 
			ETTextChangeEventTriggered = True
			Exit
		End If
	Loop
	SpannableStringET = refET.RunMethod("getText") ' includes the text with all spans
	Return True
End Sub
#End Region

#Region Routines
' Measures the width of text 
Private Sub MeasureTextWidth(ParentView As Panel, Txt As String, TxtSize As Int, Tp As Typeface) As Float
	Dim LblCheckSize As Label
	LblCheckSize.Initialize("")
	LblCheckSize.Visible=False
	LblCheckSize.Typeface =Tp
	LblCheckSize.TextSize= TxtSize
	LblCheckSize.padding = Array As Int (0dip, 0dip,0dip, 0dip)
	ParentView.AddView(LblCheckSize,0,0,100dip,100dip)
	Dim measure As Canvas
	measure.Initialize(LblCheckSize)
	Dim Width As Int = measure.MeasureStringWidth(Txt  ,LblCheckSize.Typeface,LblCheckSize.TextSize)	
	ParentView.RemoveViewAt(ParentView.NumberOfViews -1)
	Return Width
End Sub

' Measures the height of a given text size. Useful if need to know it before a view (eg label) is initialised
Private Sub MeasureTextHeight(ParentView As View, TxtSize As Int) As Float
	Dim su As StringUtils
	Dim LblCheckSize As Label
	LblCheckSize.Initialize("")
	LblCheckSize.TextSize= TxtSize
	LblCheckSize.padding = Array As Int (0dip, 0dip,0dip, 0dip)
	LblCheckSize.Text = "W" 
	LblCheckSize.Typeface=Typeface.DEFAULT
	If ParentView Is Panel Then
		Dim Parent As Panel = ParentView
		Parent.AddView(LblCheckSize,0,0,200dip,200dip)
	End If
	Dim Height As Int = su.MeasureMultilineTextHeight(LblCheckSize,LblCheckSize.Text)
	Parent.RemoveViewAt(Parent.NumberOfViews -1)
	Return Height
End Sub

' Removes the trailing spaces from a string
Private Sub RTrim(s As String) As String
	Dim Pos As Int
	For Pos = S.length -1 To 0 Step -1
		If s.SubString2(Pos,Pos+1) = " " Then Continue
		Return s.SubString2(0,Pos +1)
	Next
	Return s
End Sub

' simulates a click on a view. eg A spinner will open it's dropdown list (no event generated)
' depending on the view the click event may or may NOT be raised
Private Sub PerformClick(v As View)
	Dim jo As JavaObject = v
    jo.RunMethod("performClick", Null)
End Sub

' Safely converts a string to a number. If string = "" then returns 'DefaultValue'
' Example:<code>Math.Val("123")</code>
' Returns: 123
Private Sub Val(sNumber As String, DefaultValue As Int) As Float
	Dim i As Float
	' Some Functions calling this sub will require a '0' if sNumber cannot be converted to a number
	' However some Functions calling this sub may be using the result as a divisor, so need to return 1 if sNumber is not a number
	' But the caller can assign any number to be returned if sNumber is not a number
	i = DefaultValue
	If IsNumber(sNumber) Then i = sNumber
	Return i
End Sub

' attempts to work out the correct scale factor by using the dimensions and dpi of target device
Private Sub CalculateScale As Float
	' layouts designed on a tablet with 160dip resolution at 1280 x 752
	Dim ActivityWidth As Int = B4XPages.GetNativeParent(B4XPages.MainPage).Width
	Dim ActivityHeight As Int = B4XPages.GetNativeParent(B4XPages.MainPage).Height
	Dim m As Map = GetDeviceDpi 
	Dim Scale As Float
	Scale = Min((ActivityWidth/m.Get("xdpi")) / (1280/160) ,(ActivityHeight/m.Get("ydpi")) / (752/160) )
	Return Scale
End Sub

Private Sub GetDeviceDpi As Map
   Dim r As Reflector
   r.Target = r.GetContext
   r.Target = r.RunMethod("getResources")
   r.Target = r.RunMethod("getDisplayMetrics")
   Dim m As Map
   m.Initialize
   m.Put("xdpi",r.GetField("xdpi"))
   m.Put("ydpi",r.GetField("ydpi"))
   Return m
End Sub
#end Region

#Region Slider
	' #################################################################
	' Code for custom Horizontal slider (Sort of like having a nested class)
	' All Global variables and subs are prefixed by 'Slider_'
	Private Sub Slider_CreateASSlider(Parent As Panel, left As Int, Top As Int, Width As Int, Height As Int, NewScale As Float)
		xLabelColor= Colors.RGB(73,98,164)
		xSliderButtonColor= Colors.RGB(42,59,55)
		Slider_MinValue = 30 * NewScale
		Slider_MaxValue = 100 * NewScale
		Slider_DefaultValue = 50 * NewScale
		Slider_Value = Slider_DefaultValue
		Slider_PreviousValue = Slider_DefaultValue
		Slider_IgnoreChange = False
		Slider_DefaultTextSize = 25	* NewScale
		Slider_mBase = Slider_xui.CreatePanel("")
		Slider_mBase.Color = Slider_xui.Color_Transparent
		Slider_SetLayout(left, Top , Width, Height, NewScale)
		Parent.AddView(Slider_mBase,left,Top,Width,Height)
	End Sub

	Private Sub Slider_SetLayout( left As Int, Top As Int, Width As Int, Height As Int, NewScale As Float)
		If Slider_mBase.IsInitialized = False Then Return
		Slider_mBase.SetLayoutAnimated(0,left,Top,Width,Height)
		Slider_Position.Initialize(left,Top,Width-left,Height-Top)
		Slider_Base_Resize(Width, Height)
		If Not(Slider_SliderLabel.IsInitialized) Then Slider_SetPanelText("",Slider_DefaultTextSize) Else Slider_PositionSlideButton(False)
		' for some reason the labels are not anchored to the panel
		Dim LblLeft As B4XView = Slider_xpnl_leftside.GetView(0)
		LblLeft.SetLayoutAnimated(0,0,0,Slider_xpnl_leftside.Width, Slider_xpnl_leftside.Height)
		Dim LblRight As B4XView = Slider_xpnl_rightside.GetView(0)
		LblRight.SetLayoutAnimated(0,0,0,Slider_xpnl_rightside.Width, Slider_xpnl_rightside.Height)
		Slider_SliderLabel.SetLayoutAnimated(0,0,0,Slider_xpnl_slidebutton.Width, Slider_xpnl_slidebutton.Height)
		Slider_SliderLabel.TextSize = (Slider_SliderLabel.Width / 2) * NewScale
		Slider_mBase.Visible=True
	End Sub

	' Sets the text for the panel. "" = no  text.
	' If TextSize = 0 then uses current textsize
	Private Sub Slider_SetPanelText(Text As String, TextSize As Int)
		If TextSize > 0 Then 
			Slider_TxtSize = TextSize 
		Else 
			If Slider_TxtSize =0 Then Slider_TxtSize = 15
		End If
		Dim LeftTop As String = Text
		Dim RightBottom As String = Text
		If Slider_xpnl_slidebutton.Left < Slider_mBase.Width/2 Then LeftTop = "" Else RightBottom = ""
		If Slider_xpnl_leftside.NumberOfViews = 0 Then
			Slider_CreateLabel(Slider_xpnl_leftside,LeftTop,Slider_xui.CreateDefaultBoldFont(Slider_TxtSize))
		Else
			Dim Lbl As Label = Slider_xpnl_leftside.GetView(0)
			Lbl.Text = LeftTop
			Lbl.TextSize = Slider_TxtSize
		End If
		If Slider_xpnl_slidebutton.NumberOfViews = 0 Then
			Slider_CreateLabel(Slider_xpnl_slidebutton,"",Slider_xui.CreateFontAwesome(Slider_SliderSize /2))
			Slider_SliderLabel = Slider_xpnl_slidebutton.GetView(0)
			Slider_PositionSlideButton(False) ' which displays the correct arrows
		End If
		If Slider_xpnl_rightside.NumberOfViews = 0 Then
			Slider_CreateLabel(Slider_xpnl_rightside,RightBottom,Slider_xui.CreateDefaultBoldFont(TextSize))
		Else
			Dim Lbl As Label = Slider_xpnl_rightside.GetView(0)
			Lbl.Text = RightBottom
			Lbl.TextSize = Slider_TxtSize
		End If
	End Sub

	Private Sub Slider_GetPosition As Rect
		Return Slider_Position
	End Sub

	' used to set the value in code
	Private Sub Slider_SetValue(NewValue As Int, RaiseEvent As Boolean)
		Slider_Value = NewValue
		Slider_PositionSlideButton(RaiseEvent)
	End Sub

	Private Sub Slider_GetValue As Int
		Return Slider_Value
	End Sub

	Private Sub Slider_GetVisible As Boolean
		Return Slider_mBase.Visible
	End Sub

	Private Sub Slider_SetVisible(Visible As Boolean)
		Slider_mBase.Visible = Visible
	End Sub

	Private Sub SetEnabled(Enabled As Boolean)
		Slider_mBase.Enabled = Enabled
	End Sub

	Private Sub Slider_GetEnabled As Boolean
		Return Slider_mBase.Enabled
	End Sub

	#Region ASSlider Events
	Private Sub Slider_ValueChanged
		 ZoomSliderValueChanged (Slider_Value)
		'If xui.SubExists(mCallBack, mEventName & "_ValueChanged",0) Then
		'	CallSub2(mCallBack, mEventName & "_ValueChanged", Slider_Value) 
		'End If
	End Sub
	
	' called when user raises finger from slider
	Private Sub Slider_ValueChangedFinished
		ZoomSliderValueChangedFinished(Slider_Value, Slider_PreviousValue)
	End Sub
	#End Region

	#Region Slider More Private Subs
		Private Sub Slider_Base_Resize (Width As Double, Height As Double)
		  	If Slider_xpnl_leftside.IsInitialized = False Then	Slider_ini_views
			Slider_xpnl_leftside.SetLayoutAnimated(0,0,0,Width/2,Height)
			Slider_xpnl_rightside.SetLayoutAnimated(0,Width/2,0,Width/2,Height)
		  	Slider_xpnl_slidebutton.SetLayoutAnimated(0,Width/2 - Height/2,0,Height,Height)
			Slider_SliderSize = Slider_xpnl_slidebutton.Width
		  	'trick17
			Slider_tmp_xpnl_leftside.SetLayoutAnimated(0,Width/2 - (Width/3)/2,0,Width/3,Height)
			Slider_tmp_xpnl_rightside.SetLayoutAnimated(0,Width/2,0,Width/3,Height)
			
			Slider_xpnl_leftside.SetColorAndBorder(xLabelColor,0,Slider_xui.Color_Transparent,Slider_mBase.Height/2)
			Slider_xpnl_rightside.SetColorAndBorder(xLabelColor,0,Slider_xui.Color_Transparent,Slider_mBase.Height/2)
			Slider_xpnl_slidebutton.SetColorAndBorder(xSliderButtonColor,0,Slider_xui.Color_Transparent,Slider_mBase.Height/2)
		  	Slider_tmp_xpnl_leftside.Color = xLabelColor
			Slider_tmp_xpnl_rightside.Color = xLabelColor
		 End Sub
		 
		 Private Sub Slider_PositionSlideButton(RaiseEvent As Boolean)
			Dim SlideButtonLeft As Int
			Slider_Value = Max(Slider_MinValue,Slider_Value)
			Slider_Value = Min(Slider_Value,Slider_MaxValue)
			SlideButtonLeft = (Slider_Value - Slider_MinValue) * (Slider_mBase.Width/(Slider_MaxValue-Slider_MinValue)) - (Slider_SliderSize / 2)
			SlideButtonLeft = Max(0,SlideButtonLeft)
			SlideButtonLeft = Min(SlideButtonLeft,(Slider_mBase.Width - Slider_SliderSize ))
			Slider_xpnl_slidebutton.Left = SlideButtonLeft
			Select Case Slider_Value
				Case Slider_MinValue
					Slider_SliderLabel.text = Chr(0xF061) 
				Case Slider_MaxValue
					Slider_SliderLabel.text = Chr(0xF060)
				Case Else
					Slider_SliderLabel.text = Chr(0xF07E)
			End Select
			If RaiseEvent Then Slider_ValueChanged
		End Sub

		 Private Sub Slider_ini_views
			Slider_xpnl_leftside = Slider_xui.CreatePanel("xpnl_leftside")
			Slider_xpnl_rightside = Slider_xui.CreatePanel("xpnl_rightside")
			Slider_xpnl_slidebutton = Slider_xui.CreatePanel("xpnl_slidebutton")
			Slider_xpnl_leftside.Color = Colors.Transparent
			Slider_xpnl_rightside.Color = Colors.Transparent
			Slider_xpnl_slidebutton.Color = Colors.Transparent

			Slider_tmp_xpnl_leftside = Slider_xui.CreatePanel("")
			Slider_tmp_xpnl_rightside = Slider_xui.CreatePanel("")
			Private r As Reflector
			r.Target = Slider_xpnl_slidebutton
			r.SetOnTouchListener("Slider_xpnl_slidebutton_Touch2")
			r.Target = Slider_xpnl_leftside
			r.SetOnTouchListener("Slider_xpnl_leftside_Touch2")
			r.Target =Slider_xpnl_rightside
			r.SetOnTouchListener("Slider_xpnl_rightside_Touch2")
			
			Slider_mBase.AddView(Slider_tmp_xpnl_leftside,0,0,0,0)
			Slider_mBase.AddView(Slider_tmp_xpnl_rightside,0,0,0,0)
			Slider_mBase.AddView(Slider_xpnl_leftside,0,0,0,0)
			Slider_mBase.AddView(Slider_xpnl_rightside,0,0,0,0)
			Slider_mBase.AddView(Slider_xpnl_slidebutton,0,0,0,0)
		End Sub

		Private Sub Slider_CreateLabel(Parent As B4XView,Text As String,Font As B4XFont)
			Dim tmp_lbl As Label 
			tmp_lbl.Initialize("")
			Dim xtmp_lbl As B4XView = tmp_lbl
			Parent.AddView(xtmp_lbl,0,0,Parent.Width,Parent.Height)
			xtmp_lbl.Font = Font
			xtmp_lbl.Text = Text
			xtmp_lbl.SetTextAlignment("CENTER","CENTER")
			xtmp_lbl.TextColor = Slider_xui.Color_White
		End Sub

		Private Sub Slider_xpnl_leftside_Touch2 (o As Object, ACTION As Int, x As Float, y As Float, motion As Object) As Boolean
			If Slider_mBase.Enabled = False Then Return False
			If Slider_IgnoreChange = True Then Return False
			If ACTION = Slider_xpnl_leftside.TOUCH_ACTION_DOWN Then
				Slider_PreviousValue = Slider_Value
				Slider_Value = Round((Slider_MaxValue-Slider_MinValue)/(Slider_mBase.Width/x)) + Slider_MinValue
				Slider_PositionSlideButton(True)
			else If Slider_xpnl_leftside.TOUCH_ACTION_UP = ACTION Then
				Slider_ValueChangedFinished
			End If
			Return True
		End Sub

		Private Sub Slider_xpnl_rightside_Touch2 (o As Object, ACTION As Int, x As Float, y As Float, motion As Object) As Boolean
			If Slider_mBase.Enabled = False Then Return False
			If Slider_IgnoreChange = True Then Return False
			If ACTION = Slider_xpnl_rightside.TOUCH_ACTION_DOWN Then
				Slider_PreviousValue = Slider_Value
				Slider_Value = Round((Slider_MaxValue-Slider_MinValue)/(Slider_mBase.Width/x)) + Slider_MinValue + ((Slider_MaxValue-Slider_MinValue) /2)
				Slider_PositionSlideButton(True)
			else If Slider_xpnl_rightside.TOUCH_ACTION_UP = ACTION Then
				Slider_ValueChangedFinished
			End If
			Return True
		End Sub

		Private Sub Slider_xpnl_slidebutton_Touch2 (o As Object, ACTION As Int, x As Float, y As Float, motion As Object) As Boolean
			If Slider_mBase.Enabled = False Then Return False
			If Slider_IgnoreChange = True Then Return False
			If ACTION = Slider_xpnl_slidebutton.TOUCH_ACTION_DOWN Then
				Slider_downx = X 
				Slider_PreviousValue = Slider_Value
			Else if ACTION = Slider_xpnl_slidebutton.TOUCH_ACTION_MOVE Then
				' get Value (as determined by Min and Max properties)
				Dim Ratio As Float = (Slider_MaxValue-Slider_MinValue)/Slider_mBase.width
				Dim MbaseX As Int = Slider_xpnl_slidebutton.Left - Slider_downx + x
				Slider_Value = (MbaseX * Ratio) + Slider_MinValue
				Slider_Value = Max(Slider_MinValue,Slider_Value)
				Slider_Value = Min(Slider_Value,Slider_MaxValue)
				Slider_PositionSlideButton(True)
			else If Slider_xpnl_slidebutton.TOUCH_ACTION_UP = ACTION Then
				Slider_ValueChangedFinished
			End If
			Return True
		End Sub
	#End Region Slider More Private Subs
#end region Slider

#If Custom-Context-Menus-code
	' Copy this (Including the Java code) to the Main module (NOT B4XMainPage)
	Sub Process_Globals
		Public ActionMode, ContextMenu As JavaObject
		Public Device As Phone
	End Sub

	Sub Globals
		Dim FocusedView As View
	End Sub
	
	#Region Custom Context Menus
	' Custom context menus
	' see API reference
	' https://developer.android.com/reference/android/view/Menu
	' https://developer.android.com/reference/android/view/MenuItem
	' this sub is called if it exists in code when a submenu item is opened but before it is displayed (Setup by the Java code at the bottom)
	' It has to be here in the Main module and not on B4XMainPage (Make sure the Java code at the bottom is also there)
	Sub ContextMenu_Create(AM As JavaObject, Fw As View)	
		ActionMode=AM
		FocusedView=Fw	' view that called the submenu
		If Fw = B4XPages.MainPage.ET.EditText Then
			ContextMenu  = ActionMode.RunMethod("getMenu", Null)
			'menu.RunMethod("clear", Null)	' will clear all the menuitems
			Dim s As Int  = ContextMenu.RunMethod("size", Null)	' gets the count of the proposed context menu items.
			' my tablet sometimes comes up with other irrelevant context menu items such as 'API demos'.
			' this ensures that only the "Cut","Copy","Paste","Select all" items are kept.
			' Custom items can then be added.
			For i = 0 To s-1
				Dim MenuItem As JavaObject = ContextMenu.RunMethod("getItem",Array(i))	' gets the individual menu item
				Dim MenuTitle As String = MenuItem.RunMethod("getTitle",Null)	' get it's text
				Select Case MenuTitle
					Case "Copy","Paste"	',"Select all"	
						' keeping these but they only work with the text and not the spans. (Use Copy+, Cut+, Paste+)
					Case Else
						' so they need to replaced with "Copy+","Cut+", & "Paste+"
						MenuItem.RunMethod("setVisible",Array(False))
				End Select
			Next
			Dim event As Object = ContextMenu.CreateEvent("android.view.MenuItem.OnMenuItemClickListener", "ContextMenuClick", True)
			' add extra menu items
			Dim ExtraMenuItems As List
			ExtraMenuItems.Initialize2(Array As String("Copy+","Cut+","Paste+","Hide Keyboard"))
			For Each ExtraMenuItem As String In Routines.ListToStringArray(ExtraMenuItems)
				ContextMenu.RunMethodJO("add", Array(ExtraMenuItem)).RunMethod("setOnMenuItemClickListener", Array(event))
			Next		
		End If
	End Sub

	Sub ContextMenuClick_Event (MethodName As String, Args() As Object) As Boolean
		Dim MenuItem As JavaObject = Args(0)
		Dim Title As String = MenuItem.RunMethod("getTitle", Null)

		If FocusedView = B4XPages.MainPage.ET.EditText Then
			Select Title
				Case "Copy+"
					B4XPages.MainPage.ET.Copy
				Case "Cut+"
					B4XPages.MainPage.ET.Cut
				Case "Paste+"
					B4XPages.MainPage.ET.paste	
				Case "Hide Keyboard"
					' so a style can be added and the result not hidden by the keyboard
					Dim SelStart As Int = B4XPages.MainPage.ET.edittext.SelectionStart
					Dim SelLength As Int = B4XPages.MainPage.ET.edittext.SelectionLength
					Device.HideKeyboard(B4XPages.GetNativeParent(B4XPages.mainpage))
			End Select
	  	End If

		ActionMode.RunMethod("finish", Null)
		
		If FocusedView Is EditText Then
			Select Title
				Case "Hide Keyboard"
					' when the menu finishes it cancels the selection, so this reinstates it
					B4XPages.MainPage.ET.edittext.SetSelection(SelStart,SelLength)
			End Select
		End If
		
		Return True
	End Sub

	Sub ListToStringArray(list As List) As String()
	   Dim b(list.Size) As String
	   For i = 0 To list.Size - 1
	     b(i) = list.Get(i)
	   Next
	   Return b
	End Sub

	' this section for custom Contextmenus
	#if Java
	import android.view.*;
	import anywheresoftware.b4a.AbsObjectWrapper;
	import android.text.Selection;
	import android.widget.EditText;

	    @Override
	    public void onActionModeStarted(ActionMode mode) {
	        processBA.raiseEvent(this, "contextmenu_create", AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4j.object.JavaObject(), mode),
	            AbsObjectWrapper.ConvertToWrapper(new anywheresoftware.b4a.objects.ConcreteViewWrapper(), getCurrentFocus()));
	        super.onActionModeStarted(mode);
	    }
	     @Override
	    public void onActionModeFinished(ActionMode mode) {
	        super.onActionModeFinished(mode);
	    }
	    public static int getSelectionLength(EditText et) {
	        return Selection.getSelectionEnd(et.getText()) - Selection.getSelectionStart(et.getText());
	    }

	#End If

	#if Java
	public boolean _onCreateOptionsMenu(android.view.Menu menu) {
		 processBA.raiseEvent(null, "create_menu", menu);
		 return true;
	}
	#End If

	#End Region Custom Context Menus
#End If Custom-Context-Menus-code

#If GetAllSpans-Code
	' Copy this Java code to the Main module (NOT B4XMainPage)
	#If Java
	import android.text.SpannableStringBuilder;
	import java.util.ArrayList;

	 public static ArrayList getAllSpans(SpannableStringBuilder sourcetext) {
	 	
		Object[] spans = sourcetext.getSpans(0, sourcetext.length(), Object.class);
		ArrayList<Object> mylist = new ArrayList<Object>();
		for (Object span : spans) {
	     	mylist.add(span);
		    }
			return mylist;
			}
	#End If
#End If