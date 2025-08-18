Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=2.52
@EndOfDesignText@
#Region Module Attributes
	#FullScreen: False
	#IncludeTitle: True
' ignore '12:Sub not used', '33:DoEVents is deprecated' warnings
	#IgnoreWarnings: 12, 33
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

	Dim Blib As BasicLib
	Dim StackSize As Int = 15
	
	Dim Timer1 As Timer ' The one timer
	Dim TimerWasRunning As Boolean
	
	Dim StepState As Boolean
	Dim BreakLine As Int
	Dim FirstRunFlag As Boolean
	Dim SBuilder As StringBuilder
	
	Dim Program As String ' set by Main with the script code
	Dim Args(0) As String
	Dim Output As String ' set by Print statement in script code

	Type VarType (Name As String, Ranks As String, IsArray As Boolean) ' used in dipslaying variable values 
	
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	
	Dim ViewMap As Map ' holds all views

	Dim bmp As Bitmap ' one bitmap	
	Dim draw As Canvas ' one canvas	
	Dim font As Typeface ' one typeface
	Dim arraysX As ArraysExtra
	
	Dim aw As Int ' screen width
	Dim ah As Int ' screen height
	Dim activityorientation As String
	Dim input As String ' last dialog input
	
	Dim starting As Boolean ' used to detect and ignore the first Ended event after the initial block has completed
	Dim Obj1 As Reflector
	Dim IME As IME
End Sub

#Region Activity

Sub Activity_Create(FirstTime As Boolean)
	Activity.Title = "B4Script"
	
	' first time actions for this activity 
	If FirstTime Then 
		Timer1.Initialize("Timer", 1000)
		Blib.Initialize("Blib")
		AddNewSysCalls
	End If
		
	' first time actions for this program,
	' we may run another, or the same, program again and again so we have a script first time flag
	If FirstRunFlag Then
		Timer1.Interval = 1000 ' set timer defaults for first program run
		Timer1.Enabled = False ' belt and braces!
		TimerWasRunning = False
		Blib.Step = StepState
		Blib.BreakAtLine = BreakLine
		Blib.StackDepth = StackSize
		Dim ok As Boolean = Blib.LoadCodeAsString(Program)
		If ok Then
			Output = ""
		Else
			Blib_Ended(Blib.ErrorString)
		End If
	End If
	
	' activity (re)creation actions
	aw = Activity.Width
	ah = Activity.Height	
	If aw < ah Then
		activityorientation = "Portrait"
	Else
		activityorientation = "Landscape"
	End If
	IME.Initialize("IME")	
	font = Typeface.CreateNew(Typeface.DEFAULT, Typeface.STYLE_NORMAL)	
	ViewMap.Initialize
	Blib.Run(Args) ' the program must have loaded OK in order to get to here
	TimerWasRunning = Timer1.Enabled ' in case it was enabled in the initial code block
End Sub

Sub Activity_Resume
	Timer1.Enabled = TimerWasRunning
	If Blib.CanCall("Activity_Resume") Then ' check if the Sub exists
		Blib.Call("Activity_Resume", Null) 
	End If
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	FirstRunFlag = False
	If Blib.CanCall("Activity_Pause") Then ' check if the Sub exists
		Dim params(1) As String
		params(0) = UserClosed
		Blib.Call("Activity_Pause", params) 
	End If
	TimerWasRunning = Timer1.Enabled
	Timer1.Enabled = False
End Sub

Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event
	If Blib.CanCall("Activity_KeyPress") Then
		Dim rtn As String
		Dim params(1) As String
		params(0) = KeyCode
		rtn = Blib.Call("Activity_Keypress", params)
		If rtn.ToLowerCase = "true" Then
			Return True
		Else
			Return False
		End If
	End If
	Return False
End Sub

#End Region

#Region BasicLib Events

Sub Blib_Loaded(error As String) 'Error is an empty string if the script loaded without error	
	If error <> "" Then
		Dim msg As String = "Error at line " & Blib.LineNumber & CRLF
		msg = msg & "Code - " & Blib.ProgramLine(Blib.LineNumber) 
		msg = msg & "Error - " & Blib.ErrorString 
		Msgbox(msg,"Error loading script")
		Activity.Finish
	End If
End Sub

Sub Blib_Starting 'The script has initialised its variables and is about to start executing
	starting = True
End Sub

Sub Blib_Break(linenumber As Int) 'The script has stopped at linenumber
	Dim msg As String= "Break at line " & Blib.linenumber & " : "  & Blib.ProgramLine(Blib.linenumber) & CRLF	
	msg = msg & GetVariableVals & CRLF	
	msg = msg & "Step to step one line" & CRLF
	msg = msg & "Run to keep break" & CRLF
	msg = msg & "Cancel to clear break"	
	Dim ret As String = Msgbox2(msg,"Break", "Step", "Run", "Cancel" & CRLF & "Break", Null)
	If ret = DialogResponse.NEGATIVE Then ' Cancel Break and Run
		Blib.BreakAtLine = 0
	Else If ret = DialogResponse.POSITIVE Then ' Step
		Blib.Step = True
	Else If ret = DialogResponse.CANCEL Then ' Run
		Blib.Step = False			
	End If	
End Sub

Sub Blib_Stepped(linenumber As Int) 'The script has stepped to linenumber
	Dim msg As String = "Stepped to line " & Blib.linenumber & " : "  & Blib.ProgramLine(Blib.linenumber) & CRLF
	msg = msg & GetVariableVals & CRLF
	msg = msg & "Continue stepping?"
	Dim ret As String = Msgbox2(msg,"Stepped", "Yes", "No", "", Null)
	If ret <> DialogResponse.POSITIVE Then
		Blib.Step = False
	End If
End Sub

Sub GetVariableVals As String
	Dim GlobalVars, LocalVars, Printed As String
	Dim LocalsArr(0), GlobalsArr(0) As String
	Dim vtype As VarType
	GlobalVars = Blib.GetGlobalVars
	LocalVars = Blib.GetLocalVars
	GlobalsArr = Regex.Split(",", GlobalVars)
	LocalsArr = Regex.Split(",", LocalVars)
	GlobalVars = "GLOBAL VARIABLES" & CRLF
	LocalVars = "LOCAL VARIABLES" & CRLF
	Printed = ""
	If GlobalsArr(0) <> "" Then
		For Each var In GlobalsArr
			vtype = ParseVar(var)
			GlobalVars = GlobalVars & vtype.Name
			If vtype.IsArray Then
				GlobalVars = GlobalVars & vtype.Ranks
			End If
			GlobalVars = GlobalVars & " = '" & Blib.GetGlobal(vtype.Name).Replace(Chr(10), "\n") & "'"
			If vtype.IsArray Then
				GlobalVars = GlobalVars  & " ... "
			End If
			GlobalVars = GlobalVars  & CRLF
		Next
	End If
	If LocalsArr(0) <> "" Then
		For Each var In LocalsArr
			LocalVars = LocalVars & var & " = '" & Blib.GetLocal(var).Replace(Chr(10), "\n") & "'" & CRLF
		Next
	End If
	If Output <> "" Then
		Printed = CRLF & "PRINT OUTPUT" & CRLF & Output
	End If	
	Return  LocalVars & CRLF & GlobalVars & Printed
End Sub

Sub ParseVar(var As String) As VarType
	Dim vparts(2) As String '= Regex.Split("\(", var)
	Dim idx As Int = var.IndexOf("(")
	vparts(0) = var.SubString2(0, idx)
	vparts(1) = var.SubString(idx)	
	Dim vtype As VarType
	vtype.IsArray = True
	vtype.Name = vparts(0)
	vtype.Ranks = vparts(1).Replace(":", ",")
	If vtype.Ranks = "(1,0,0)" Then vtype.IsArray = False
	Return vtype	
End Sub

Sub Blib_Ended(error As String) 'Error is an empty string if the script terminated without error
	If starting And error = "" Then ' don't stop after initial code block exits except on error
		starting = False
		Return
	End If
	If Blib.ErrorString <> "" Then ' show error first before any print output
		Dim msg As String = "Error at line " & Blib.LineNumber & CRLF
		msg = msg & "Code - " & Blib.ProgramLine(Blib.LineNumber)
		msg = msg & "Error - " & Blib.ErrorString
		Msgbox(msg,"Ended with error")
	End If
	If Output <> "" Then
		Msgbox(Output, "Print Output")
	End If
	Activity.Finish
End Sub

Sub Blib_Message(message As String, subject As String)
	If subject = "Print" Then
		Output = Output & message & CRLF 
	Else
		Msgbox(message, subject)
	End If
End Sub

#End Region

#Region Script support Subs

Sub AddView(o As Object, name As String, left As String, top As String, width As String, height As String, parent As String)
	Dim v As View
	v = ViewMap.Get(parent)
	If v.IsInitialized  Then
		If v Is Panel Then
			Dim p As Panel
			p = v
			p.AddView(o, left, top, width, height)
		End If
	Else
		Activity.AddView(o, left, top, width, height)
	End If
	ViewMap.Put(name, o)
End Sub

#End Region

#Region HTML Contents

' Subs below are called by the running script
' Do Edit -> Outlining -> Collapse All then expand the regions below to conveniently see what functions are available

''<a name="top"></a>
''<b><u>BasicIDE B4Script Language Extensions</u></b><br>
''<a href="#events">Script Events</a><br>
''<a href="#functions">General Functions</a><br>
''<a href="#strings">String Functions</a><br>
''<a href="#device">Device Functions</a><br>
''<a href="#activity">Activity Functions</a><br>
''<a href="#array">Array Functions</a><br>
''<a href="#file">File Functions</a><br>
''<a href="#view">Add View Functions</a><br>
''<a href="#shared">Shared View Functions</a><br>
''<a href="#check">Check, Radio and Toggle Functions</a><br>
''<a href="#edittext">EditText Functions</a><br>
''<a href="#graphics">Graphics Functions</a><br>
''<a href="#listview">ListView Functions</a><br>
''<a href="#listandspin">ListView and Spinner Functions</a><br>
''<a href="#progressbar">ProgressBar Functions</a><br>
''<a href="#scrollview">ScrollView Functions</a><br>
''<a href="#seekbar">SeekBar Functions</a><br>
''<a href="#spinner">Spinner Functions</a><br>
''<a href="#tabhost">TabHost Functions</a><br>
''<a href="#textview">Textview Functions</a><br>
''<a href="#timer">Timer Functions</a><br>
''<a href="#user">User Interaction Functions</a><br>
''<a href="#colors">Color Constants</a><br>
''<a href="#key">KeyCode Functions and Constants</a><br>
''<a href="#gravity">Gravity Constants</a><br>
''<a href="#typeface">Typeface Constants</a><br>

#End Region

#Region Script Events

''<a name="events"></a>
''@H:SCRIPT EVENTS
''
''If a Sub of any of these names are defined in the program then it will be called at the appropriate time.
''The 'who' parameter will be set to the name of view that caused the event.
''Use Template.b4s as a starting point for a project and enter the event code as needed.

''@N:Activity_Create
''There is no supported Activity_Create sub.
''Instead the inital block of code block from the beginning of the script up to the first Sub statement is run.
''GetFirstTime returns True the first time the initial code block is run after a program is started.
'' This block of code will be run again whenever the Activity is re-created

''@N:Activity_Pause(userclosed)
''"Sub activity_pause(userclosed)" is called if implemented. userclosed will be True if the [Back] button was pressed.

''@N:Activity_Resume
''"Sub activity_resume" is called if implemented.

''@N:Activity_Keypress(keycode)
''"Sub activity_keypress(keycode)" is called if implemented.
'' Keycode will contain the system key code of the key pressed, and may be tested using the KEYCODE FUNCTIONS and KEYCODE CONSTANTS.
'' Return True from Activity_Keypress(keycode) to consume the keystroke (ie. not allow the system to continue processing it.)
''
''Example:
''Sub Activity_Keypress(keycode)
''&nbsp;&nbsp;# process numbers only, all others ignored
''&nbsp;&nbsp;If keycode = Key_isNumber(keycode)
''&nbsp;&nbsp;&nbsp;&nbsp;# process the keystroke here...
''&nbsp;&nbsp;&nbsp;&nbsp;# then consume the keystroke
''&nbsp;&nbsp;&nbsp;&nbsp;Return true
''&nbsp;&nbsp;End If
''End Sub

''@N:Button_Click(who)
''All Button Click events are vectored to a single BasicLib sub "Sub button_click(who)".

''@N:Check_CheckedChange(who, checked)
''All Checkbox CheckedChange events are vectored to a single BasicLib sub "Sub check_checkedchange(who, checked)".

''@N:Edit_EnterPressed(who)
''All EditText EnterPressed events are vectored to a single BasicLib sub "Sub edit_enterpressed(who)".

''@N:Edit_TextChanged(who, oldtext, newtext)
''All EditText TextChanged events are vectored to a single BasicLib sub "Sub edit_textchanged(who, oldtext, newtext)".

''@N:Edit_FocusChanged(who, hasfocus)
''All Edittext FocusChanged events are vectored to a single BasicLib sub "Sub edit_focuschanged(who, hasfocus)".

''@N:HSV_Changed(who, position)
''All HorizontalScrollView ScrollChanged events are vectored to a single BasicLib sub "Sub hsv_scrollchanged(who, position)".

''@N:Label_Click(who)
''All Label Click events are vectored to a single BasicLib sub "Sub label_click(who)".

''@N:Listview_ItemClick(who, position, value)
''All ListView ItemClick events are vectored to a single BasicLib sub "Sub listview_itemclick(who, position, value)".

''@N:Menu_Click(menutext)
''All menu item click events are vectored to a single BasicLib sub "Sub menu_click(menutext)".

''@N:Panel_Click(who)
''All Panel Click events are vectored to a single BasicLib sub "Sub panel_click(who)".

''@N:Radio_CheckedChange(who, checked)
''All RadioButton CheckedChange events are vectored to a single BasicLib sub "Sub radio_checkedchange(who, checked)".

''@N:Seekbar_ValueChanged(who, userchanged)
''All SeekBar ValueChanged events are vectored to a single BasicLib sub "Sub seekbar_valuechanged(who, value, userchanged)".

''@N:Spinner_ItemClick(who, position, value)
''All Spinner ItemClick events are vectored to a single BasicLib sub "Sub spinner_itemclick(who, position, value)".

''@N:Tabhost_TabChanged(who)
''All TabHost TabChanged events are vectored to a single BasicLib sub "Sub tabhost_tabchanged(who)".

''@N:Timer_Tick
''All Timer tick events are vectored to a single BasicLib sub "Sub timer_tick".

''@N:Toggle_Changed(who, checked)
''All ToggleButton CheckedChange events are vectored to a single BasicLib sub "Sub toggle_changed(who, checked)".

''@N:Event Templates
''Here are all the event Sub templates to copy and paste if desired.
''
''Sub activity_pause(userclosed) 
''End Sub
''
''Sub activity_resume
''End Sub 
''
'Sub activity_keypress(keycode)
''End Sub 
''
''Sub button_click(who)
''End Sub 
''
''Sub check_checkedchange(who, checked)
''End Sub 
''
''Sub edit_enterpressed(who)
''End Sub
''
''Sub edit_textchanged(who, old, new)
''End Sub
''
''Sub edit_focuschanged(who, hasfocus)
''End Sub
''
''Sub hsv_scrollchanged(who, position)
''End Sub
''
''Sub label_click(who)
''End Sub
''
''Sub listview_itemclick(who, pos, value)
''End Sub
''
''Sub menu_click(menutext)
''End Sub
''
''Sub panel_click(who)
''End Sub
''
''Sub radio_checkedchange(who, checked)
''End Sub 
''
''Sub seekbar_valuechanged(who, pos, value)
''End Sub
''
''Sub spinner_itemclick(who, pos, value)
''End Sub
''
''Sub tabhost_tabchanged(who)
''End Sub 
''
''Sub timer_tick
''End Sub 
''
''Sub toggle_changed(who, checked)
''End Sub 

#End Region

#Region General System Functions

''<a name="functions"></a>
''@H:GENERAL SYSTEM FUNCTIONS

''@N:CloseApplication
''On Android 4+ will close all the activities.
''When called in a script this will exit the application without resuming the IDE activity.
''AppClose in contrast will just close this activity and return to the Main activity.
Sub CloseApplication
Dim jo As JavaObject
jo.InitializeContext
	jo.RunMethod("finishAffinity", Null)
End Sub

''@N:IIf(condition, truepart, falsepart)
''IIf is a function that performs an If...Else...End If as a one line statement. 
''IIf has 3 parts: a condition, a True part and a False part.
'' The condition is evaluated, and if it evaluates true, the true part is returned, otherwise the false part is returned.
''It should not replace an If block that makes tests to ensure an error will not result. 
'' This is because as both True part and False part are evaluated when the function is called.
''Example:
''# instead of this...
''If a = 5 Then
''&nbsp;&nbsp;b = b + 1
''Else
''&nbsp;&nbsp;b = b - 1
''Endif
''# use this...
''b = b + IIf(a = 5, 1, -1)
Sub IIf(condition As String, truepart As String, falsepart As String) As String
	'condition = condition.ToLowerCase
	If condition = "true" Then
		Return truepart
	End If
	Return falsepart
End Sub

''@N:HideKeyboard
''Hides the soft keyboard.
Sub HideKeyboard
	IME.HideKeyboard
End Sub

#End Region

#Region String Functions

''<a name="strings"></a>
''@H:STRING FUNCTIONS

'	''@N:TextHeight(viewname, text)
'	''Calculates the height of the text in a label or edittext.
'
'	Sub TextHeight(name As String, text As String) As String
'		Dim su As StringUtils
'		Dim v As View
'		v = ViewMap.Get(name)
'		If Not(v.IsInitialized) Then Return -1
'		If Not(v Is Label) Then Return -1
'		Dim lbl As Label
'		lbl = v
'		Return su.MeasureMultilineTextHeight(lbl, text)
'	End Sub

''@N:SBAppend(text)
''Append 'text' to the end of the String Builder object.
Sub SBAppend(text As String)
	If SBuilder.IsInitialized Then
		SBuilder.Append(text)
	End If
End Sub

''@N:SBInitialize
''There is a single String Builder object which can be used as many times as needed.
''Initialize (or reinitialize) the String Builder object.
'' If the String Builder object is already initialized, it will be reinitialized and its text reset to blank.
Sub SBInitialize
	SBuilder.Initialize
End Sub


''@N:SBInsert(offset, text)
''Insert 'text' at the offset specified, in the String Builder object.
Sub SBInsert(offset As String, text As String)
	If SBuilder.IsInitialized Then
		SBuilder.Insert(offset, text)
	End If
End Sub

''@N:SBLength
''Returns the length of the text in the String Builder object.
Sub SBLength As String
	If SBuilder.IsInitialized Then
		Return SBuilder.Length
	Else
		Return -1
	End If
End Sub

''@N:SBRemove(start, end)
''Remove the text starting at 'start' offset up to, but not including, the 'end' offset, of the String Builder object.
Sub SBRemove(startoffset As String, endoffset As String)
	If SBuilder.IsInitialized Then
		SBuilder.Remove(startoffset, endoffset)
	End If
End Sub

''@N:SBToString
''Returns the text in the String Builder object.
Sub SBToString As String
	If SBuilder.IsInitialized Then
		Return SBuilder.ToString
	Else
		Return ""
	End If
End Sub

''@N:StrTrim(string)
''Returns a string that has had white space trimmed from the start and end of the passed string
''Ex. StrTrim("  123 ") returns "123"
Sub StrTrim(str As String) As String
	Return str.Trim
End Sub

#End Region

#Region Device functions

''<a name="device"></a>
''@H:DEVICE FUNCTIONS

''@N:ActivityHeight
''Get the available height of the activity.
''Depending upon the device orientation this is not necessarily the same as the physical display height.
Sub ActivityHeight As String
	Return ah
End Sub

''@N:ActivityWidth
''Get the available width of the activity.
''Depending upon the device orientation this is not necessarily the same as the physical display width.
Sub ActivityWidth As String
	Return aw
End Sub

''@N:GetLayoutValues
''Get the layout values for this device in a comma separated string "width,height,density".
Sub GetLayoutValues As String
	Dim l As LayoutValues
	l = GetDeviceLayoutValues
	Return l.Width & "," & l.Height & "," & l.Scale
End Sub

''@N:GetOrientation
''Returns the orientation of the device as either 'Portrait' or 'Landscape'.
Sub GetOrientation As String
	Return activityorientation
End Sub

''@N:ScreenScale
''Get the scaling value (density) for this device.
Sub ScreenScale As String
	Return GetDeviceLayoutValues.Scale
End Sub

#End Region

#Region Activity functions

''<a name="activity"></a>
''@H:ACTIVITY FUNCTIONS

''@N:ActivityFinish
''Closes the Activity and return directly to the editor. this may sometimes be required.
''Calling this bypasses the normal Blib_Ended code that will display any Print output and any error message
''Close a script without events by calling CloseAfterThis and close a script with events by AppClose.
Sub ActivityFinish
	Activity.Finish
End Sub

''@N:SetActivityTitle(title)
''Sets the activity title text in the activity's title label
''@N:CloseMenu
''Closes the Activity menu. This is added for symmetry with OpenMenu but seems of little practical use.
Sub CloseMenu
	Activity.CloseMenu
End Sub

''@N:GetFirstTime
''Returns true if this is the first time the initial code block program has been run.
''This is the equivalent of FirstTime in Activity_Create except this is for the program, not the activity.
Sub GetFirstTime As String
	Return FirstRunFlag
End Sub

''@N:CloseAfterThis
''Call somewhere before the end of the initial code block for a program that does not support events.
''Otherwise the program will be left waiting for an event that won't come and the back button will be needed to close it.
''A program that does use events can end by calling AppClose.
Sub CloseAfterThis
	starting = False
End Sub

''@N:LogCat(message)
''Logs the provided message to the Logcat output.
Sub LogCat(message As String)
	Log(message)
End Sub

''@N:OpenMenu
''Opens the Activity menu
Sub OpenMenu
	Activity.OpenMenu
End Sub

''@N:SetActivityBackground(orientation, radius, colorsarrayname)
''Set the Background property of the Activity to the GradientDrawable.
''Returns false if less than two colors are in the array otherwise returns true.
''Orientation can be one of the following:
''"TOP_BOTTOM", "TR_BL" (Top-Right To Bottom-Left), "RIGHT_LEFT", "BR_TL" (Bottom-Right To Top-Left)
''"BOTTOM_TOP", "BL_TR" (Bottom-Left To Top-Right), "LEFT_RIGHT", "TL_BR" (Top-Left To Bottom-Right)
Sub SetActivityBackground(Orientation As String, radius As String, colorsarrayname As String) As String
	Dim cols(0) As String
	Dim G As GradientDrawable
	cols = Blib.GetArray(colorsarrayname)
	If cols.Length >= 2 Then
		Dim colints(cols.Length) As Int
		For I = 0 To cols.Length - 1
			colints(I) = cols(I)
		Next
		G.Initialize(Orientation, colints)
		G.CornerRadius = radius
		Activity.Background = G
		Return True
	End If
	Return False
End Sub

Sub SetActivityTitle(title As String)
	Activity.title = title
End Sub

#End Region

#Region Array Functions

''<a name="array"></a>
''@H:ARRAY FUNCTIONS

''@N:FillArray(arrayname, start, length, value)
''Fully or partially fills the specified array with the specified value.
Sub FillArray(arrayname As String, start As String, len As String, value As String)
	Dim ia(0) As String
	ia = Blib.GetArray(arrayname)
	arraysX.Fill(ia, start, len, value)
	Blib.ShareArray(arrayname, ia)
End Sub

''@N:SortArray(arrayname, sorttype)
''Sort the specified array into ascending order in the specified manner. 
''One of cCaseSensitive (0), cCaseUnensitive (1) or  cNumbers (2).
''cCaseInsensitive is also accepted as a synonym for cCaseUnensitive'
''Note that for use with BinarySearch cCaseSensitive should be used otherwise the result may not be accurate
Sub SortArray(arrayname As String, sorttype As String)
	Dim ia(0) As String
	ia = Blib.GetArray(arrayname)
	arraysX.SortStringArray(ia, sorttype)
	Blib.ShareArray(arrayname, ia)
End Sub

''@N:SearchArray(arrayname, value)
''Searches the specified array for the specified value using the binary search algorithm.
''The array must be sorted into ascending order using cCaseSensitive otherwise the result may not be accurate..
Sub SearchArray(arrayname As String, value As String) As String
	Dim ia(0), res As String
	ia = Blib.GetArray(arrayname)
	res = arraysX.BinarySearch(ia, value)
	Return res
End Sub

'cCaseSensitive (0) and cCaseUnsensitive (1) are defined in B4Script, cNUmbers is not.
Sub cNumbers As String
	Return 2
End Sub

'cCaseUnsensitive was an original Erel typo that got stuck in Basic4ppc. 
Sub cCaseInsensitive As String
	Return 1
End Sub

#End Region

#Region File functions
''<a name="file"></a>
''@H:FILE FUNCTIONS

''@N:FileCopy(sourcedir, sourcefilename, destdir, destfilename)
''Copies the SourceFilename file in the SourceDir directory to the DestFilename directory and sets the name to DestFilename.
Sub FileCopy(sourcedir As String, sourcefname As String, destdir As String, destfname As String) As String
	Try
		File.Copy(sourcedir, sourcefname, destdir, destfname)
		Return True
	Catch
		Return False
	End Try
End Sub

''@N:FileDelete(dir, filename)
''Deletes the specified file. If the file name is a directory then it must be empty in order to be deleted.
''Returns true if the file was successfully deleted.
''Files in the assets folder cannot be deleted.
''Returns true if successful, false otherwise.
Sub FileDelete(dir As String, filename As String) As String
	Try
		Return File.Delete(dir, filename)
	Catch
		Return False
	End Try
End Sub

''@N:FileDirAssets
''Returns a reference to the files added with the Files Manager. These files are read-only.
''This is actually the string "AssetsDir" which B4A OpenInput(Dir, String) treats specially as a Dir parameter
''This is why FileGetPath does not support FileDirAssets as it then lacks the unique name that OpenInput looks for.
Sub FileDirAssets As String
	Return File.DirAssets
End Sub

''@N:FileDirDefaultExternal
''Returns the application default external folder which is based on the package name.
''The folder is created if needed.
Sub FileDirDefaultExternal As String
	Return File.DirDefaultExternal
End Sub

''@N:FileDirInternal
''Returns the internal private storage dir.
Sub FileDirInternal As String
	Return File.DirInternal
End Sub

''@N:FileDirRootExternal
''Returns the root folder of the external storage media.
Sub FileDirRootExternal As String
	Return File.DirRootExternal
End Sub

''@N:FileExists(dir, filename)
''Returns true if the specified FileName exists in the specified Dir.
''Note that the Android file system is case sensitive.
Sub FileExists(dir As String, filename As String) As String
	Return File.Exists(dir, filename)
End Sub

''@N:FileGetPath(dir, filename)
''Returns the fully qualified pathname of the filename. This does not support the Assets directory.
Sub FileGetPath(dir As String, filename As String) As String
	If dir <> FileDirAssets Then
		Return File.Combine(dir, filename)
	End If
	Return ""
End Sub

''@N:FileIsDirectory(dir, filename)
''Tests whether the specified file is a directory.
Sub FileIsDirectory(dir As String, filename As String) As String
	Return File.IsDirectory(dir, filename)
End Sub

''@N:FileIsSDCard
''Tests the external media, or SDCard (some devices call this Internal Storage), for readibility and writability.
Sub FileIsSDCard As String
	Return File.ExternalWritable
End Sub

''@N:FileListFiles(dir, filesarrayname)
''Fills an array with a list with all the files and directories which are stored in the specified path.
''Returns true if successful, false otherwise.
Sub FileListFiles(dir As String, filesarrayname As String) As String
	Try
		Dim l As List
		l = File.ListFiles(dir)
		Dim Arr(l.Size) As String
		For I = 0 To Arr.Length - 1
			Arr(I) = l.Get(I)
		Next
		Blib.SetArray(filesarrayname, Arr)
		Return True
	Catch
		Return False
	End Try
End Sub

''@N:FileMakeDir(parentdir, dir)
''Creates the given folder (dir can be a path like "dir1/dir2", creates all folders as needed).
''Returns true if successful, false otherwise.
Sub FileMakeDir(parentdir As String, dir As String) As String
	Try
		File.MakeDir(parentdir, dir)
		Return True
	Catch
		Return False
	End Try
End Sub

''@N:FileReadList(dir, filename, listarrayname)
''Reads the entire file and fills a named array with all lines as strings.
''Returns true if successful, false otherwise.
Sub FileReadList(dir As String, fileName As String, listarrayname As String) As String
	Try
		Dim l As List
		l = File.ReadList(dir, fileName)
		Dim A(l.Size) As String
		For I = 0 To A.Length - 1
			A(I) = l.Get(I)
		Next
		Blib.SetArray(listarrayname, A)
		Return True
	Catch
		Return False
	End Try
End Sub

''@N:FileReadString(dir, filename)
''Reads the entire file and returns it as a string.
''Returns an empty string on failure.
Sub FileReadString(dir As String, fileName As String) As String
	Try
		Return File.ReadString(dir, fileName)
	Catch
		Return ""
	End Try
End Sub

''@N:FileRename(dir, oldfilename, newfilename)
''Renames the old filename to the new filename.
''Note that this method uses the B4A File.Copy and File.Delete methods internally.
Sub FileRename(dir As String, oldfname As String, newfname As String) As String
	Try
		File.Copy(dir, oldfname, dir, newfname)
		File.Delete(dir, oldfname)
		Return True
	Catch
		Return False
	End Try
End Sub

''@N:FileWriteList(dir, filename, listarrayname)
''Writes each item in the List As a single line.
''Note that a value containing CRLF will be saved as two lines which will return two items when read with ReadList.
''Returns true if successful, false otherwise.
Sub FileWriteList(dir As String, filename As String, listarrayname As String) As String
	Try
		Dim A(0) As String
		A = Blib.GetArray(listarrayname)
		File.WriteList(dir, filename, A)
		Return True
	Catch
		Return False
	End Try
End Sub

''@N:FileWriteString(dir, filename, text)
''Writes the given text to a new file.
''Returns true if successful, false otherwise.
Sub FileWriteString(dir As String, filename As String, Text As String) As String
	Try
		File.WriteString(dir, filename, Text)
		Return True
	Catch
		Return False
	End Try
End Sub

#End Region 

#Region Add View Functions and Events

''<a name="view"></a>
''@H:ADD VIEW FUNCTIONS
''The Add view functions use four parameters; name, left, top, width, height, and parent.
''Parent should be an empty string (ie. "") if adding to the activity.
''If you add a view you need to add all the event subs for that type of view.
''This because, for efficiency, the event Subs are assumed to be all there for an existing view.
''Using Template.b4s as a starting point does this for you. Fill the event code in as needed.

''@N:AddButton(buttonname, left, top, width, height, parent)
''Add a Button to the activity or a panel.
Sub AddButton(name As String, left As String, top As String, width As String, height As String, parent As String)
	Dim b As Button
	b.Initialize("Button")
	b.Tag = name
	AddView(b, name, left, top, width, height, parent)
End Sub

'Call the script "Sub button_click(sender)" when any Button Click event is raised. 
Sub Button_Click
	If Blib.CanCall("button_click") Then
		Dim v As View
		v = Sender
		Dim params(1) As String
		params(0) = v.Tag
		Blib.Call("button_click", params)
	End If
End Sub

''@N:AddCheckBox(checkboxname, left, top, width, height, parent)
''Add a CheckBox to the activity.
Sub AddCheckBox(name As String, left As String, top As String, width As String, height As String, parent As String)
	Dim b As CheckBox
	b.Initialize("CheckBox")
	b.Tag = name	
	AddView(b, name, left, top, width, height, parent)
End Sub

'Call the script "Sub check_checkedchange(sender, checked)" when any CheckBox CheckedChanged event is raised 
Sub CheckBox_CheckedChange(Checked As Boolean)
	If Blib.CanCall("check_checkedchange") Then
		Dim v As View
		v = Sender
		Dim params(2) As String
		params(0) = v.Tag
		params(1) = Checked
		Blib.Call("check_checkedchange", params)
	End If
End Sub

''@N:AddEditText(edittextname, left, top, width, height, parent)
''Add an EditText to the activity or a panel.
Sub AddEditText(name As String, left As String, top As String, width As String, height As String, parent As String)
	Dim e As EditText
	e.Initialize("EditText")
	e.Tag = name
	e.Gravity = Gravity.NO_GRAVITY
	AddView(e, name, left, top, width, height, parent)
End Sub

'Call the script "Sub edit_textchanged(sender, oldtext, newtext)" when any EditText TextChanged event is raised 
Sub EditText_TextChanged (Old As String, New As String)
	If Blib.CanCall("edit_textchanged") Then
		Dim v As View
		v = Sender
		Dim params(3) As String
		params(0) = v.Tag
		params(1) = Old
		params(2) = New
		Blib.Call("edit_textchanged", params)
	End If
End Sub

'Call the script "Sub edit_enterpressed(sender)" when any EditText EnterPressed event is raised 
Sub EditText_EnterPressed
	If Blib.CanCall("edit_enterpressed") Then
		Dim v As View
		v = Sender
		Dim params(1) As String
		params(0) = v.Tag
		Blib.Call("edit_enterpressed", params)
	End If
End Sub

'Call the script "Sub edit_focuschanged(who, hasfocus)
Sub EditText_FocusChanged(HasFocus As Boolean)
	If Blib.CanCall("edit_focuschanged") Then
		Dim v As View
		v = Sender
		Dim params(2) As String
		params(0) = v.Tag
		params(1) = HasFocus
		Blib.Call("edit_focuschanged", params)
	End If
End Sub

''@N:AddHorizontalScroll(horizontalscrollname, left, top, width, height, parent)
''Add a Horizontal Scroll view to the activity or panel
Sub AddHorizontalScroll(name As String, left As String, top As String, width As String, height As String, parent As String)
	Dim s As HorizontalScrollView
	s.Initialize(width, "HSV")
	s.Tag = name
	AddView(s, name, left, top, width, height, parent)
End Sub

'Call the script "Sub hsv_scrollchanged(sender, position)" when any HorizontalScrollView ScrollChanged event is raised. 
Sub HSV_ScrollChanged(position As Int)
	If Blib.CanCall("hsv_scrollchanged") Then
		Dim v As View
		v = Sender
		Dim params(2) As String
		params(0) = v.Tag
		params(1) = position
		Blib.Call("hsv_scrollchanged", params)
	End If
End Sub

''@N:AddImage(imagename, left, top, width, height, parent)
''Add an ImageView to the activity or a panel.
Sub AddImage(name As String, left As String, top As String, width As String, height As String, parent As String)
	Dim I As ImageView
	I.Initialize("Image")
	I.Tag = name	
	AddView(I, name, left, top, width, height, parent)
	ViewMap.Put(name, I)
End Sub

''@N:AddLabel(labelname, left, top, width, height, parent)
''Add a Label to the activity or a panel.
Sub AddLabel(name As String, left As String, top As String, width As String, height As String, parent As String)
	Dim l As Label
	l.Initialize("Label")
	l.Tag = name	
	AddView(l, name, left, top, width, height, parent)
End Sub

'Call the script "Sub label_click(sender)" when any Label Click event is raised. 
Sub Label_Click
	If Blib.CanCall("label_click") Then
		Dim v As View
		v = Sender
		Dim params(1) As String
		params(0) = v.Tag
		Blib.Call("label_click", params)
	End If
End Sub

''@N:AddListView(listviewname, left, top, width, height, parent)
''Add a ListView to the activity or a panel.
Sub AddListView(name As String, left As String, top As String, width As String, height As String, parent As String)
	Dim S As ListView
	S.Initialize("ListView")
	S.Tag = name	
	AddView(S, name, left, top, width, height, parent)
End Sub

'Call the script "Sub listview_itemclick(sender, position, value)" when any ListView ItemClick event is raised 
Sub ListView_ItemClick(position As Int, value As Object)
	If Blib.CanCall("listview_itemclick") Then
		Dim v As View
		v = Sender
		Dim params(3) As String
		params(0) = v.Tag
		params(1) = position
		params(2) = value
		Blib.Call("listview_itemclick", params)
	End If
End Sub

''@N:AddMenuItem(menutext)
''Add a MenuItem to the Activity.
Sub AddMenuItem(menutext As String)
	Activity.AddMenuItem(menutext, "Menu")
End Sub

'All menu_click events are sent here
Sub Menu_Click
	If Blib.CanCall("menu_click") Then
		Dim params(1) As String
		params(0) = Sender
		Blib.Call("menu_click", params)
	End If
End Sub

''@N:AddPanel(panelname, left, top, width, height, parent)
''Add a Panel to the activity or a panel.
Sub AddPanel(name As String, left As String, top As String, width As String, height As String, parent As String)
	Dim p As Panel
	p.Initialize("Panel")
	p.Tag = name	
	AddView(p, name, left, top, width, height, parent)
End Sub

'Call the script "Sub panel_click(sender)" when any Panel_Click event is raised. 
Sub Panel_Click
	If Blib.CanCall("panel_click") Then
		Dim v As View
		v = Sender
		Dim params(1) As String
		params(0) = v.Tag
		Blib.Call("panel_click", params)
	End If
End Sub

''@N:AddProgressBar(panelname, left, top, width, height, parent)
''Add a ProgressBar to the activity or a panel.
Sub AddProgressBar(name As String, left As String, top As String, width As String, height As String, parent As String)
	Dim p As ProgressBar
	p.Initialize("ProgressBar")
	p.Tag = name
	AddView(p, name, left, top, width, height, parent)
End Sub

''@N:AddRadioButton(radiobuttonname, left, top, width, height, parent)
''Add a RadioButton to the activity or a panel.
Sub AddRadioButton(name As String, left As String, top As String, width As String, height As String, parent As String)
	Dim b As RadioButton
	b.Initialize("RadioButton")
	b.Tag = name	
	AddView(b, name, left, top, width, height, parent)
End Sub

'Call the script "Sub radio_checkedchanged(sender, checked)" when any RadioButton CheckedChange event is raised 
Sub RadioButton_CheckedChange(Checked As Boolean)
	If Blib.CanCall("radio_checkedchange") Then
		Dim v As View
		v = Sender
		Dim params(2) As String
		params(0) = v.Tag
		params(1) = Checked
		Blib.Call("radio_checkedchange", params)
	End If
End Sub

''@N:AddScrollView(scrollviewname, left, top, width, height, parent)
''Add a ScrollView to the activity or a panel.
Sub AddScrollView(name As String, left As String, top As String, width As String, height As String, parent As String)
	Dim S As ScrollView
	S.Initialize(height)
	S.Tag = name	
	AddView(S, name, left, top, width, height, parent)
End Sub

''@N:AddSeekBar(seekbarname, left, top, width, height, parent)
''Add a SeekBar to the activity or a panel.
Sub AddSeekBar(name As String, left As String, top As String, width As String, height As String, parent As String)
	Dim S As SeekBar
	S.Initialize("SeekBar")
	S.Tag = name	
	AddView(S, name, left, top, width, height, parent)
End Sub

'Call the script "Sub seekbar_valuechanged(sender, value, userchanged)" when any SeekBar ValueChanged event is raised 
Sub SeekBar_ValueChanged(value As Int, userchanged As Boolean)
	If Blib.CanCall("seekbar_valuechanged") Then
		Dim v As View
		v = Sender
		Dim params(3) As String
		params(0) = v.Tag
		params(1) = value
		params(2) = userchanged
		Blib.Call("seekbar_valuechanged", params)
	End If
End Sub

''@N:AddSpinner(spinnername, left, top, width, height, parent)
''Add a Spinner to the activity or a panel.
Sub AddSpinner(name As String, left As String, top As String, width As String, height As String, parent As String)
	Dim S As Spinner
	S.Initialize("Spinner")
	S.Tag = name	
	AddView(S, name, left, top, width, height, parent)
End Sub

'Call the script "Sub spinner_itemclick(sender, position, value)" when any Spinner ItemClick event is raised 
Sub Spinner_ItemClick(position As Int, value As Object)
	If Blib.CanCall("spinner_itemclick") Then
		Dim v As View
		v = Sender
		Dim params(3) As String
		params(0) = v.Tag
		params(1) = position
		params(2) = value
		Blib.Call("spinner_itemclick", params)
	End If
End Sub

''@N:AddTabHost(tabhostname, left, top, width, height, parent)
''Add a TabHost to the activity or a panel.
Sub AddTabHost(name As String, left As String, top As String, width As String, height As String, parent As String)
	Dim T As TabHost
	T.Initialize("TabHost")
	T.Tag = name	
	AddView(T, name, left, top, width, height, parent)
End Sub

'Call the script "Sub tabhost_tabchanged(Sender)" when any TabHost TabChanged event is raised 
Sub TabHost_TabChanged
	If Blib.CanCall("tabhost_tabchanged") Then
		Dim v As TabHost
		v = Sender
		Dim params(1) As String
		params(0) = v.Tag
		Blib.Call("tabhost_tabchanged", params)
	End If
End Sub

''@N:AddToggleButton(togglebuttonname, left, top, width, height, parent)
''Add a ToggleButton to the activity or a panel.
Sub AddToggleButton(name As String, left As String, top As String, width As String, height As String, parent As String)
	Dim b As ToggleButton
	b.Initialize("ToggleButton")
	b.Tag = name
	AddView(b, name, left, top, width, height, parent)
End Sub

'Call the script "Sub toggle_change(sender, checked)" when any ToggleButton CheckedChanged event is raised 
Sub ToggleButton_CheckedChange(Checked As Boolean)
	If Blib.CanCall("toggle_checkedchange") Then
		Dim v As View
		v = Sender
		Dim params(2) As String
		params(0) = v.Tag
		params(1) = Checked
		Blib.Call("toggle_checkedchange", params)
	End If
End Sub

''@N:RemoveAllViews
''Removes all views from the Activity
Sub RemoveAllViews
	Dim v As View
	Dim S As Int
	Do While ViewMap.Size > 0
		S = ViewMap.Size - 1
		v = ViewMap.GetValueAt(S)
		v.RemoveView
		ViewMap.Remove(ViewMap.GetKeyAt(S))
	Loop
End Sub

''@N:RemoveFromParent(viewname)
''Removes the named view from its parent, but doesn't destroy it. 
''Used primarily for hiding a panel containing views to be used for popup help screens and custom input dialogs.
Sub RemoveFromParent(name As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		v.RemoveView
	End If
End Sub

''@N:RemoveView(name)
''Completely remove the named view from the program. It will no longer be available in the program.
Sub RemoveView(name As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		v.RemoveView
	End If
	ViewMap.Remove(name)
End Sub

''@N:SetNewParent(viewname, parent)
''Removes the named view from its existing parent, if any, and adds it to the specified parent which must be an Activity or Panel
Sub SetNewParent(name As String, parent As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		v.RemoveView
	End If	
	Dim p As View
	p = ViewMap.Get(parent)
	If p.IsInitialized  Then
		If p Is Panel Then
			Dim pnl As Panel
			pnl = p
			pnl.AddView(v, v.Left, v.Top, v.Width, v.Height)
		End If
	Else
		Activity.AddView(v, v.Left, v.Top, v.Width, v.Height)
	End If
End Sub

#End Region

#Region Shared View functions

''<a name="shared"></a>
''@H:SHARED VIEW FUNCTIONS
''These functions apply to all views.

''@N:BringToFront(viewname)
''Bring the named view to the front of the Z order.
Sub BringToFront(name As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		v.BringToFront
	End If
End Sub

''@N:GetEnabled(viewname)
''Get the Enabled property of the named view.
Sub GetEnabled(name As String) As String
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		Return v.Enabled
	End If
	Return -1
End Sub

''@N:GetHeight(viewname)
''Get the Height property of the named view.
Sub GetHeight(name As String) As String
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		Return v.Height
	End If
	Return -1
End Sub

''@N:GetLeft(viewname)
''Get the Left property of the named view.
Sub GetLeft(name As String) As String
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		Return v.Left
	End If
	Return -1
End Sub

''@N:GetRight(viewname)
''Gets the right side of the named view
Sub GetRight(name As String) As String
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		Return v.Left + v.Width - 1
	End If
	Return -1
End Sub

''@N:GetTop(viewname)
''Get the Top property of the named view.
Sub GetTop(name As String) As String
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		Return v.Top
	End If
	Return -1
End Sub

''@N:GetVisible(viewname)
''Get the Visible property of the named view.
Sub GetVisible(name As String) As String
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		Return v.Visible
	End If
	Return False
End Sub

''@N:GetWidth(viewname)
''Get the Width property of the named view.
Sub GetWidth(name As String) As String
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		Return v.Width
	End If
	Return -1
End Sub

''@N:Invalidate(viewname)
''Invalidate the named view.
''Invalidate graphics updates to a view through Canvas drawing routines so a CallDoEvents will repaint the View.
''See GRAPHICS FUNCTIONS for more info.
Sub Invalidate(name As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		v.Invalidate
	End If
End Sub

''@N:IsView(viewname)
''Returns true if the named view exists, otherwise false.
Sub IsView(name As String) As String
	Return ViewMap.ContainsKey(name)
End Sub

''@N:RequestFocus(viewname)
''Set the focus to the named view. Only views with editable text and a cursor may receive focus.
Sub RequestFocus(name As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		If v.RequestFocus Then
			IME.ShowKeyboard(v)
		End If
	End If
End Sub

''@N:SendToBack(viewname)
''Send the named view to the back of the Z order.
Sub SendToBack(name As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		v.SendToBack
	End If
End Sub

''@N:SetBackground(viewname, radius, color)
''Set the Background property of the named view to a ColorDrawable.
Sub SetBackground(name As String, radius As String, Color As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		Dim C As ColorDrawable
		C.Initialize(Color, radius)
		v.Background = C
	End If
End Sub

''@N:SetBackgroundGradient(viewname, orientation, radius, colorsarrayname)
''Set the Background property of the named view to a GradientDrawable.
''Returns false if less than two colors are in the array or name not found otherwise returns true.
''Orientation can be one of the following: 
''"TOP_BOTTOM", "TR_BL" (Top-Right To Bottom-Left), "RIGHT_LEFT", "BR_TL" (Bottom-Right To Top-Left)
''"BOTTOM_TOP", "BL_TR" (Bottom-Left To Top-Right), "LEFT_RIGHT", "TL_BR" (Top-Left To Bottom-Right)
Sub SetBackgroundGradient(name As String, Orientation As String, radius As String, colorsarrayname As String) As String
	Dim v As View
	Dim cols(0) As String
	Dim G As GradientDrawable
	v = ViewMap.Get(name)
	cols = Blib.GetArray(colorsarrayname)
	If v.IsInitialized And cols.Length >= 2 Then
		Dim colints(cols.Length) As Int
		For I = 0 To cols.Length - 1
			colints(I) = cols(I)
		Next
		G.Initialize(Orientation, colints)
		G.CornerRadius = radius
		v.Background = G
		Return True
	End If
	Return False
End Sub

''@N:SetBackgroundImage(viewname)
''Set the BackgroundImage of the view to the present bitmap. See GRAPHICS FUNCTIONS for more info.
''Return true if both view and bitmap are initialised otherwise return false.
Sub SetBackgroundImage(name As String) As String
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And bmp.IsInitialized Then
		v.SetBackgroundImage(bmp)
		Return True
	End If
	Return False
End Sub

''@N:SetColor(viewname, radius, color)
''Set the Background property of the named view to a ColorDrawable.
Sub SetColor(name As String, radius As String, Color As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		Dim C As ColorDrawable
		C.Initialize(Color, radius)
		v.Background = C
	End If
End Sub

''@N:SetEnabled(viewname, enabled)
''Set the true/false Enabled property of the named view.
Sub SetEnabled(name As String, state As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		v.Enabled = state
	End If
End Sub

''@N:SetHeight(viewname, height)
''Set the Height property of the named view.
Sub SetHeight(name As String, height As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		v.height = height
	End If
End Sub

''@N:SetLeft(viewname, left)
''Set the Left property of the named view.
Sub SetLeft(name As String, left As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		v.left = left
	End If
End Sub

''@N:SetTop(viewname, top)
''Set the Top property of the named view.
Sub SetTop(name As String, top As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		v.top = top
	End If
End Sub

''@N:SetVisible(viewname, visible)
''Set the true/false Visible property of the named view.
Sub SetVisible(name As String, visible As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		v.visible = visible
	End If
End Sub

''@N:SetWidth(viewname, width)
''Set the Width property of the named view.
Sub SetWidth(name As String, width As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		v.width = width
	End If
End Sub

#End Region

#Region CheckBox, RadioButton and ToggleButton functions

''<a name="check"></a>
''@H:CHECKBOX, RADIOBUTTON AND TOGGLEBUTTON FUNCTIONS
''CheckBox, RadioButton and ToggleButton support these functions in addition to the Shared View functions.

''@N:GetChecked(viewname)
''Get the Checked state of a CheckBox, RadioButton or ToggleButton.
Sub GetChecked(name As String) As String
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		If v Is CheckBox Then
			Dim C As CheckBox
			C = v
			Return C.Checked
		Else If v Is RadioButton Then
			Dim r As RadioButton
			r = v
			Return r.Checked
		Else If v Is ToggleButton Then
			Dim T As ToggleButton
			T = v
			Return T.Checked
		End If
	End If
	Return False
End Sub

''@N:SetChecked(viewname, checkedstate)
''Set the Checked state of a CheckBox, RadioButton or ToggleButton.
Sub SetChecked(name As String, checked As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		If v Is CheckBox Then
			Dim C As CheckBox
			C = v
			C.checked = checked
		Else If v Is RadioButton Then
			Dim r As RadioButton
			r = v
			r.checked = checked		
		Else If v Is ToggleButton Then
			Dim T As ToggleButton
			T = v
			T.checked = checked		
		End If
	End If
End Sub

''@N:SetTextOff(togglebuttonname, text)
''Sets the text that will appear in the OFF mode.
Sub SetTextOff(name As String, Text As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is ToggleButton Then
		Dim b As ToggleButton
		b = v
		b.TextOff = Text			
	End If
End Sub

''@N:SetTextOn(togglebuttonname, text)
''Sets the text that will appear in the ON mode.
Sub SetTextOn(name As String, Text As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is ToggleButton Then
		Dim b As ToggleButton
		b = v
		b.TextOn = Text			
	End If
End Sub

#End Region

#Region EditText functions

''<a name="edittext"></a>
''@H:EDITTEXT FUNCTIONS
''EditText supports these functions in addition to the View and TextView functions.

''@N:GetSelectionStart(edittextname)
''Gets the selection start position (or the cursor position) of the EditText.
''Returns -1 if there is no selection or cursor.
Sub GetSelectionStart(name As String) As String
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is EditText Then
		Dim e As EditText
		e = v
		Return e.SelectionStart		
	End If
	Return -1
End Sub

''@N:SelectAll(edittextname)
''Selects all text of the named edittext view.
Sub SelectAll(name As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is EditText Then
		Dim e As EditText
		e = v
		e.SelectAll
	End If
End Sub

''@N:SelectText(edittextname, selectionstart, selectionlength)
''Selects text within the named edittext, starting at offset selectionstart and extending selectionlength characters.
Sub SelectText(name As String, start As String, length As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is EditText Then
		Dim e As EditText
		'Dim st As Int = start, en As Int = start + length
		e = v
		Obj1.Target = e
		Obj1.RunMethod3("setSelection", start, "java.lang.int", start + length, "java.lang.int")
	End If
End Sub

''@N:SetForceDoneButton(edittextname, forcestate)
''Force the EditText virtual keyboard action key to display Done by setting this value to True.
Sub SetForceDoneButton(name As String, forcestate As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is EditText Then
		Dim e As EditText
		e = v
		e.ForceDoneButton = forcestate			
	End If	
End Sub

''@N:SetHint(edittextname, hinttext)
''Set the text that will appear when the EditText is empty.
Sub SetHint(name As String, hint As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is EditText Then
		Dim e As EditText
		e = v
		e.hint = hint			
	End If	
End Sub

''@N:SetHintColor(edittextname, hintcolor)
''Set the color of the text that will appear when the EditText is empty.
Sub SetHintColor(name As String, hintcolor As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is EditText Then
		Dim e As EditText
		e = v
		e.hintcolor = hintcolor			
	End If
End Sub

''@N:SetInputType(edittextname, inputtype)
''Set the value of the EditText InputType property.
''NONE = 0; TEXT = 1; NUMBERS = 2; _PHONE = 3; DECIMAL_NUMBERS = 12290;
Sub SetInputType(name As String, inputtype As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is EditText Then
		Dim e As EditText
		e = v
		e.inputtype = inputtype			
	End If
End Sub

''@N:SetPasswordMode(edittextname, state)
''Set the true or false value of the EditText PasswordMode property.
Sub SetPasswordMode(name As String, state As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is EditText Then
		Dim e As EditText
		e = v
		e.PasswordMode = state			
	End If
End Sub

''@N:SetSelectionStart(edittextname, startposition)
''Sets the selection start position (or the cursor position) of the EditText.
Sub SetSelectionStart(name As String, selectionstart As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is EditText Then
		Dim e As EditText
		e = v
		e.selectionstart = selectionstart			
	End If
End Sub

''@N:SetSingleLine(edittextname, singlelinestate)
''Set the true/false value of the EditText SingleLine property.
Sub SetSingleLine(name As String, state As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is EditText Then
		Dim e As EditText
		e = v
		e.SingleLine = state			
	End If
End Sub

''@N:SetWrap(edittextname, wrapstate)
''Set the true/false value of the EditText Wrap property.
Sub SetWrap(name As String, state As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is EditText Then
		Dim e As EditText
		e = v
		e.Wrap = state			
	End If
End Sub

#End Region

#Region Graphics functions

''<a name="graphics"></a>
''@H:GRAPHICS FUNCTIONS
''There is a single bitmap object, which can be initialised from an image file or as a new mutable bitmap.
''There is a single canvas object, which can be initialised on any view, or on a mutable bitmap.
''Both the bitmap and canvas objects may be reinitialised as many times as needed.
''Rectangles are assumed to be the names of a BasicLib array of rank 4 with coordinates of two points.
''The array items are ordered as left(0), top(1) of the upper left point and, right(2) and bottom(3) of the lower right point.
''Points are assumed to be consecutive items in an array ordered as xpos(2n+0) and ypos(2n+1).
''The drawings will only be updated after a call to ParentView.Invalidate.

''@N:BitmapHeight
''Get the height of the current bitmap.
Sub BitmapHeight As String
	Return bmp.Height
End Sub

''@N:BitmapInit(dir, filename)
''(Re)initialise the bitmap to a graphic file.
Sub BitmapInit(dir As String, fileName As String)
	bmp.Initialize(dir, fileName)
End Sub

''@N:BitmapInitMutable(width, height)
''(Re)initialise the bitmap to a mutable bitmap.
Sub BitmapInitMutable(width As String, height As String)
	bmp.InitializeMutable(width, height)
End Sub

''@N:BitmapWidth
''Get the width of the current bitmap.
Sub BitmapWidth As String
	Return bmp.Width
End Sub

''@N:CanvasInit(viewname)
''(Re)initialise the canvas object on any View.
Sub CanvasInit(viewname As String)
	Dim v As View
	v = ViewMap.Get(viewname)
	If v.IsInitialized Then
		draw.Initialize(v)
	End If
End Sub

''@N:CanvasInit2
''The one canvas can also be reinitialised on a mutable Bitmap if the sole Bitmap object is one.
Sub CanvasInit2
	If bmp.IsInitialized Then
		draw.Initialize2(bmp)
	End If
End Sub

''@N:DrawBitmap(srcrectarrayname, destrectarrayname)
''Draws the present bitmap
''SrcRect - The rectangular area of the Bitmap that will be drawn.
''DestRect - The rectangular area that the Bitmap will be drawn to.
''Returns false if more or less than two points are in the rectangle arrays otherwise returns true.
Sub DrawBitmap(srcrectarrayname As String, destrectarrayname As String) As String
	Dim rsrc As Rect
	Dim rdest As Rect
	Dim rs(0) As String
	Dim rd(0) As String
	rs = Blib.GetArray(srcrectarrayname)
	rd = Blib.GetArray(destrectarrayname)
	If rs.Length <> 4 Or rd.Length <> 4 Then
		Return False
	End If
	rsrc.Initialize(rs(0), rs(1), rs(2), rs(3))
	rdest.Initialize(rd(0), rd(1), rd(2), rd(3))
	draw.DrawBitmap(bmp, rsrc, rdest)
	Return True
End Sub

''@N:DrawBitmapFlipped(srcrectarrayname, destrectarrayname, vertically, horizontally, )
''Draws the present bitmap either horizontally, vertically or both..
''SrcRect - The rectangular area of the Bitmap that will be drawn.
''DestRect - The rectangular area that the Bitmap will be drawn to.
''Returns false if more or less than two points are in the rectangle arrays otherwise returns true.
Sub DrawBitmapFlipped(srcrectarrayname As String, destrectarrayname As String, vertically As String, horizontally As String) As String
	Dim rsrc As Rect
	Dim rdest As Rect
	Dim rs(0) As String
	Dim rd(0) As String
	rs = Blib.GetArray(srcrectarrayname)
	rd = Blib.GetArray(destrectarrayname)
	If rs.Length <> 4 Or rd.Length <> 4 Then
		Return False
	End If
	rsrc.Initialize(rs(0), rs(1), rs(2), rs(3))
	rdest.Initialize(rd(0), rd(1), rd(2), rd(3))
	draw.DrawBitmapFlipped(bmp, rsrc, rdest, vertically, horizontally)
	Return True
End Sub

''@N:DrawBitmapRotated(srcrectarrayname, destrectarrayname, degrees)
''Draws the present bitmap rotated.
''SrcRect - The rectangular area of the Bitmap that will be drawn.
''DestRect - The rectangular area that the Bitmap will be drawn to.
''Returns false if more or less than two points are in the rectangle arrays otherwise returns true.
Sub DrawBitmapRotated(srcrectarrayname As String, destrectarrayname As String, degrees As String) As String
	Dim rsrc As Rect
	Dim rdest As Rect
	Dim rs(0) As String
	Dim rd(0) As String
	rs = Blib.GetArray(srcrectarrayname)
	rd = Blib.GetArray(destrectarrayname)
	If rs.Length <> 4 Or rd.Length <> 4 Then
		Return False
	End If
	rsrc.Initialize(rs(0), rs(1), rs(2), rs(3))
	rdest.Initialize(rd(0), rd(1), rd(2), rd(3))
	draw.DrawBitmapRotated(bmp, rsrc, rdest, degrees)
	Return True
End Sub

''@N:DrawCircle(x, y, radius, color, filled, strokewidth)
''Draws a circle.
Sub DrawCircle(x As String, y As String, radius As String, Color As String, filled As String, strokewidth As String)
	draw.DrawCircle(x, y, radius, Color, filled, strokewidth)
	End Sub

''@N:DrawColor(color)
''Fills the entire canvas with the given color.
Sub DrawColor(Color As String)
	draw.DrawColor(Color)
End Sub

''@N:DrawLine(x1, y1, x2, y2, color, strokewidth)
''Draws a line.
Sub DrawLine(x1 As String, y1 As String, x2 As String, y2 As String, Color As String, strokewidth As String)
	draw.DrawLine(x1, y1, x2, y2, Color, strokewidth)
End Sub

''@N:DrawOval(rectarrayname, radius, color, filled, strokewidth)
''Draws an ellipse.
''Returns false if more or less than two points are in the array otherwise returns true.
Sub DrawOval(rectarrayname As String, Color As String, filled As String, strokewidth As String) As String
	Dim r As Rect
	Dim ra(0) As String
	ra = Blib.GetArray(rectarrayname)
	If ra.Length <> 4 Then
		Return False
	End If
	r.Initialize(ra(0), ra(1), ra(2), ra(3))
	draw.DrawOval(r, Color, filled, strokewidth)
	Return True
End Sub

''@N:DrawRotatedOval(rectarrayname, radius, color, filled, strokewidth, degrees)
''Draws a rotated  ellipse.
''Returns false if more or less than two points are in the array otherwise returns true.
Sub DrawOvalRotated(rectarrayname As String, Color As String, filled As String, strokewidth As String, degrees As String) As String
	Dim r As Rect
	Dim ra(0) As String
	ra = Blib.GetArray(rectarrayname)
	If ra.Length <> 4 Then
		Return False
	End If
	r.Initialize(ra(0), ra(1), ra(2), ra(3))
	draw.DrawOvalRotated(r, Color, filled, strokewidth, degrees)
	Return True
End Sub

''@N:DrawPath(pointsarrayname, color, filled, strokewidth)
''Draws a set of connected lines from the points provided in a named array.
''Returns false if less than two points are in the array otherwise returns true.
Sub DrawPath(pointsarrayname As String, Color As String, filled As String, strokewidth As String) As String
	Dim p As Path
	Dim pts(0) As String
	pts = Blib.GetArray(pointsarrayname)
	If pts.Length < 4 Then
		Return False
	End If
	p.Initialize(pts(0), pts(1))
	For I = 2 To pts.Length - 2 Step 2
		p.LineTo(pts(I), pts(I + 1))
	Next
	draw.DrawPath(p, Color, filled, strokewidth)
	Return True
End Sub

''@N:DrawPoint(x, y, color)
''Sets a single pixel to the specified color.
Sub DrawPoint(x As String, y As String, Color As String)
	draw.DrawPoint(x, y, Color)
End Sub

''@N:DrawRect(rectarrayname, color, filled, strokewidth)
''Draws a rectangle from the points provided in a named array.
''Returns false if more or less than two points are in the array otherwise returns true.
Sub DrawRect(rectarrayname As String, Color As String, filled As String, strokewidth As String) As String
	Dim r As Rect
	Dim ra(0) As String
	ra = Blib.GetArray(rectarrayname)
	If ra.Length <> 4 Then
		Return False
	End If
	r.Initialize(ra(0), ra(1), ra(2), ra(3))
	draw.DrawRect(r, Color, filled, strokewidth)
	Return True
End Sub

''@N:DrawRectRotated(rectarrayname, color, filled, strokewidth, degrees)
''Draws a rotated rectangle from the points provided in a named array and a specified angle.
''Returns false if more or less than two  points are in the array otherwise returns true.
Sub DrawRectRotated(rectarrayname As String, Color As String, filled As String, strokewidth As String, degrees As String) As String
	Dim r As Rect
	Dim ra(0) As String
	ra = Blib.GetArray(rectarrayname)
	If ra.Length <> 4 Then
		Return False
	End If
	r.Initialize(ra(0), ra(1), ra(2), ra(3))
	draw.DrawRectRotated(r, Color, filled, strokewidth, degrees)
	Return True
End Sub

''@N:DrawText(text, x, y, textsize, textcolor, align)
''Draw text. Align is one of the following values: "LEFT", "CENTER", "RIGHT".
Sub DrawText(Text As String, x As String, y As String, textsize As String, Color As String, align As String)
	draw.DrawText(Text, x, y, font, textsize, Color, align.ToUpperCase)
End Sub

''@N:DrawTextRotated(text, x, y, textsize, textcolor, align, degrees)
''Draw text. Align is one of the following values: "LEFT", "CENTER", "RIGHT".
Sub DrawTextRotated(Text As String, x As String, y As String, textsize As String, Color As String, align As String, degrees As String)
	draw.DrawTextRotated(Text, x, y, font, textsize, Color, align.ToUpperCase, degrees)
End Sub

#End Region

#Region ListView functions

''<a name="listview"></a>
''@H:LISTVIEW FUNCTIONS
''ListView supports these functions in addition to the Shared View functions.

''@N:GetLabel(listviewname, labelname)
''Makes the ListView.SingleLineLayout.Label accessible as a Label view.
''The layout functions of the ListView items may be changed using the label functions.
Sub GetLabel(listviewname As String, labelname As String)
	Dim v As View
	v = ViewMap.Get(listviewname)
	If v.IsInitialized And v Is ListView Then
		Dim l As ListView
		l = v
		ViewMap.Put(labelname, l.SingleLineLayout.Label)
	End If
End Sub

''@N:SetFastScrollEnabled(listviewname, scrollstate)
''Sets whether the fast scroll icon will appear when the user scrolls the list. The default Is False.
Sub SetFastScrollEnabled(name As String, state As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is ListView Then
		Dim l As ListView
		l = v
		l.FastScrollEnabled = state		
	End If
End Sub

''@N:SetItemHeight(listviewname, itemheight)
''Sets the ItemHeight of the SingleLineLayout in a ListView.
Sub SetItemHeight(name As String, height As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is ListView Then
		Dim l As ListView
		l = v
		l.SingleLineLayout.ItemHeight = height		
	End If
End Sub

''@N:SetLayoutBackgroundColor(listviewname, cornerradius, backgroundcolor)
''Set the ListView.SingleLineLayout.Background property of the ListView to a ColorDrawable.
Sub SetLayoutBackgroundColor(name As String, radius As String, Color As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is ListView Then
		Dim C As ColorDrawable
		C.Initialize(Color, radius)
		Dim l As ListView
		l.SingleLineLayout.Background = C
	End If
End Sub

''@N:SetLayoutBackgroundColorgradient(listviewname, orientation, cornerradius, colorsarrayname)
''Set the ListView.SingleLineLayout.Background property of the ListView to a GradientDrawable.
''Returns false if less than two colors are in the array or name not found otherwise returns true.
''Orientation can be one of the following - 
''"TOP_BOTTOM", "TR_BL" (Top-Right To Bottom-Left, "RIGHT_LEFT", "BR_TL" (Bottom-Right To Top-Left)
''"BOTTOM_TOP", "BL_TR" (Bottom-Left To Top-Right), "LEFT_RIGHT", "TL_BR" (Top-Left To Bottom-Right)
Sub SetLayoutBackgroundColorgradient(name As String, Orientation As String, radius As String, colorsarrayname As String) As String
	Dim cols(0) As String
	Dim v As View
	v = ViewMap.Get(name)
	cols = Blib.GetArray(colorsarrayname)
	If v.IsInitialized And v Is ListView And cols.Length >= 2 Then
		Dim l As ListView
		Dim G As GradientDrawable
		Dim colints(cols.Length) As Int
		For I = 0 To cols.Length - 1
			colints(I) = cols(I)
		Next
		G.Initialize(Orientation, colints)
		G.CornerRadius = radius
		l = v
		l.SingleLineLayout.Background = G
		Return True
	End If
	Return False
End Sub

''@N:SetScrollColor(listviewname, color)
''Sets the background color that will be used while scrolling the ListView.
Sub SetScrollColor(name As String, Color As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is ListView Then
		Dim l As ListView
		l = v
		l.ScrollingBackgroundColor = Color		
	End If
End Sub

#End Region

#Region ListView and Spinner functions

''<a name="listandspin"></a>
''@H:LISTVIEW AND SPINNER FUNCTIONS
''ListView and Spinner support these functions in addition to the Shared View functions.

''@N:Add(viewname, item)
''Add an item To a ListView or Spinner.
Sub Add(name As String, item As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		If v Is Spinner Then
			Dim S As Spinner
			S = v
			S.Add(item)
		Else If v Is ListView Then
			Dim l As ListView
			l = v
			l.AddSingleLine(item)		
		End If
	End If
End Sub

''@N:AddAll(viewname, itemarrayname)
''Add an array of items to a ListView or Spinner.
Sub AddAll(name As String, itemarrayname As String)
	Dim v As View
	Dim ia(0) As String
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		If v Is Spinner Then
			Dim S As Spinner
			S = v
			ia = Blib.GetArray(itemarrayname)
			S.AddAll(ia)
		Else If v Is ListView Then
			Dim l As ListView
			l = v
			ia = Blib.GetArray(itemarrayname)
			For I = 0 To ia.Length - 1
				l.AddSingleLine(ia(I))
			Next
		End If
	End If
End Sub

''@N:Clear(viewname)
''Clears the items from a ListView or Spinner.
Sub Clear(name As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		If v Is Spinner Then
			Dim S As Spinner
			S = v
			S.Clear
		Else If v Is ListView Then
			Dim l As ListView
			l = v
			l.Clear
		End If
	End If
End Sub

''@N:GetItem(viewname, index)
''Returns the item at the specified index from a ListView or Spinner.
Sub GetItem(name As String, index As String) As String
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		If v Is Spinner Then
			Dim S As Spinner
			S = v
			Return S.GetItem(index)
		Else If v Is ListView Then
			Dim l As ListView
			l = v
			Return l.GetItem(index)
		End If
	End If
	Return ""
End Sub

''@N:GetSize(viewname)
''Returns the number of items in a ListView or Spinner.
Sub GetSize(name As String) As String
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		If v Is Spinner Then
			Dim S As Spinner
			S = v
			Return S.Size
		Else If v Is ListView Then
			Dim l As ListView
			l = v
			Return l.Size
		End If
	End If
	Return -1
End Sub

''@N:RemoveAt(viewname, index)
''Removes the item at the specified index from a ListView or Spinner.
Sub RemoveAt(name As String, index As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized Then
		If v Is Spinner Then
			Dim S As Spinner
			S = v
			S.RemoveAt(index)
		Else If v Is ListView Then
			Dim l As ListView
			l = v
			l.RemoveAt(index)
		End If
	End If
End Sub

#End Region

#Region ProgressBar functions

''<a name="progressbar"></a>
''@H:PROGRESSBAR FUNCTIONS
''ProgressBar supports these functions in addition to the Shared View functions.

''@N:GetIndeterminate(progressbarname)
''Returns the current ProgressBar Indeterminate state, True or False.
Sub GetIndeterminate(progressbarname As String) As String
	Dim v As View
	v = ViewMap.Get(progressbarname)
	If v.IsInitialized And v Is ProgressBar Then
		Dim S As ProgressBar
		S = v
		Return S.Indeterminate
	End If
	Return False
End Sub

''@N:GetProgress(progressbarname)
''Returns the current ProgressBar Progress value between 0 and 100.
Sub GetProgress(progressbarname As String) As String
	Dim v As View
	v = ViewMap.Get(progressbarname)
	If v.IsInitialized And v Is ProgressBar Then
		Dim S As ProgressBar
		S = v
		Return S.Progress
	End If
	Return -1
End Sub

''@N:SetIndeterminate(progressbarname, indeterminate)
''Sets the current ProgressBar Indeterminate stae, either True or False.
Sub SetIndeterminate(progressbarname As String, indeterminate As String)
	Dim v As View
	v = ViewMap.Get(progressbarname)
	If v.IsInitialized And v Is ProgressBar Then
		Dim S As ProgressBar
		S = v
		S.Indeterminate = indeterminate
	End If
End Sub

''@N:SetProgress(progressbarname, progress)
''Sets the current ProgressBar Progress value. Should be between 0 and 100.
Sub SetProgress(progressbarname As String, progress As String)
	Dim v As View
	v = ViewMap.Get(progressbarname)
	If v.IsInitialized And v Is ProgressBar Then
		Dim S As ProgressBar
		S = v
		S.Progress = progress
	End If
End Sub

#End Region

#Region ScrollView functions

''<a name="scrollview"></a>
''@H:SCROLLVIEW FUNCTIONS
''Scrollviews support these functions in addition to the Shared View functions.
''Scrollview functions work on both Scrollviews and HorizontalScrollviews

''@N:FullScroll(scrollviewname, bottom)
''Scrolls the ScrollView to the top or bottom.
''True scrolls to the bottom, False scrolls to the top.
Sub FullScroll(scrollviewname As String, bottom As String)
	Dim v As View
	v = ViewMap.Get(scrollviewname)
	If v.IsInitialized And (v Is ScrollView Or v Is HorizontalScrollView) Then
		If v Is ScrollView Then
			Dim S As ScrollView
			S = v
			S.FullScroll(bottom)
		Else
			Dim h As HorizontalScrollView
			h = v
			h.FullScroll(bottom)
		End If
	End If
End Sub

''@N:GetPanel(scrollviewname, panelname)
''Makes the ScrollView Panel accessible as a named Panel View.
Sub GetPanel(scrollviewname As String, panelname As String)
	Dim v As View
	v = ViewMap.Get(scrollviewname)
	If v.IsInitialized And (v Is ScrollView Or v Is HorizontalScrollView) Then
		If v Is ScrollView Then
			Dim S As ScrollView
			S = v
			ViewMap.Put(panelname, S.Panel)
		Else
			Dim h As HorizontalScrollView
			h = v
			ViewMap.Put(panelname, h.Panel)
		End If
	End If
End Sub

''@N:GetScrollPosition(scrollviewname)
''Returns the current ScrollView ScrollPosition.
Sub GetScrollPosition(scrollviewname As String) As String
	Dim v As View
	v = ViewMap.Get(scrollviewname)
	If v.IsInitialized And (v Is ScrollView Or v Is HorizontalScrollView) Then
		If v Is ScrollView Then
			Dim S As ScrollView
			S = v
			Return S.ScrollPosition
		Else
			Dim h As HorizontalScrollView
			h = v
			Return h.ScrollPosition
		End If
	End If
	Return -1
End Sub

''@N:SetScrollPosition(scrollviewname, position)
''Sets the current ScrollView ScrollPosition.
Sub SetScrollPosition(scrollviewname As String, value As String)
	Dim v As View
	v = ViewMap.Get(scrollviewname)
	If v.IsInitialized And (v Is ScrollView Or v Is HorizontalScrollView) Then
		If v Is ScrollView Then
			Dim S As ScrollView
			S = v
			S.ScrollPosition = value
		Else
			Dim h As HorizontalScrollView
			h = v
			h.ScrollPosition = value
		End If
	End If
End Sub

#End Region

#Region SeekBar functions

''<a name="seekbar"></a>
''@H:SEEKBAR FUNCTIONS
''SeekBar supports these functions in addition to the Shared View functions.

''@N:GetMax(seekbarname)
''Returns the current SeekBar Max value. The default is 100.
Sub GetMax(seekbarname As String) As String
	Dim v As View
	v = ViewMap.Get(seekbarname)
	If v.IsInitialized And v Is SeekBar Then
		Dim S As SeekBar
		S = v
		Return S.Max
	End If
	Return -1
End Sub

''@N:GetValue(seekbarname)
''Returns the current SeekBar value. The minimum value is always zero.
Sub GetValue(seekbarname As String) As String
	Dim v As View
	v = ViewMap.Get(seekbarname)
	If v.IsInitialized And v Is SeekBar Then
		Dim S As SeekBar
		S = v
		Return S.Value
	End If
	Return -1
End Sub

''@N:SetMax(seekbarname, maxvalue)
''Sets the current SeekBar Max value. The default is 100.
Sub SetMax(seekbarname As String, maxvalue As String)
	Dim v As View
	v = ViewMap.Get(seekbarname)
	If v.IsInitialized And v Is SeekBar Then
		Dim S As SeekBar
		S = v
		S.Max = maxvalue
	End If
End Sub

''@N:SetValue(seekbarname, value)
''Sets the current SeekBar Value. Should be between 0 and Max.
Sub SetValue(seekbarname As String, value As String)
	Dim v As View
	v = ViewMap.Get(seekbarname)
	If v.IsInitialized And v Is SeekBar Then
		Dim S As SeekBar
		S = v
		S.value = value
	End If
End Sub

#End Region

#Region Spinner functions

''<a name="spinner"></a>
''@H:SPINNER FUNCTIONS
''Spinner supports these functions in addition to the Shared View functions.

''@N:SetSelectedIndex(spinnername)
''Returns the index of the selected item of a Spinner. Returns -1 if no item is selected.
Sub GetSelectedIndex(name As String) As String
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is Spinner Then
		Dim S As Spinner
		S = v
		Return S.SelectedIndex
	End If
	Return -1
End Sub

''@N:GetSelectedItem(spinnername)
''Returns the the selected item of a Spinner. Returns "" if no item is selected.
Sub GetSelectedItem(name As String) As String
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is Spinner Then
		Dim S As Spinner
		S = v
		Return S.SelectedItem
	End If
	Return ""
End Sub

''@N:SetPrompt(spinnername, prompt)
''Sets the title that will be displayed when the Spinner is opened.
Sub SetPrompt(name As String, index As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized  And v Is Spinner Then
		Dim S As Spinner
		S = v
		S.Prompt = index
	End If
End Sub

''@N:SetSelectedIndex(spinnername, index)
''Selects the item at the specified index of a Spinner. Pass -1 if no item is selected.
Sub SetSelectedIndex(name As String, index As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is Spinner Then
		Dim S As Spinner
		S = v
		S.SelectedIndex = index
	End If
End Sub

#End Region

#Region TabHost functions

''<a name="tabhost"></a>
''@H:TABHOST
''TabHost supports these functions in addition to the Shared View functions.

''@N:AddTab(title, panelname, parenttabhostname)
''Add a Tab and a new associated Panel to a TabHost.
''The panelname may be used to add views To the Tab.
Sub AddTab(title As String, panelname As String, parenttabhost As String)
	Dim v As View
	v = ViewMap.Get(parenttabhost)
	If v.IsInitialized And v Is TabHost Then
		Dim T As TabHost
		T = v
		Dim p As Panel
		p.Initialize("Panel")
		p.Tag = panelname	
		ViewMap.Put(panelname, p)			
		T.AddTab2(title, p)
	End If
End Sub

''@N:GetCurrentTab(tabhostname)
''Returns the index of the current tab page.
Sub GetCurrentTab(tabhostname As String) As String
	Dim v As View
	v = ViewMap.Get(tabhostname)
	If v.IsInitialized And v Is TabHost Then
		Dim T As TabHost
		T = v
		Return T.CurrentTab
	End If
	Return -1
End Sub

''@N:GetTabCount(tabhostname)
''Returns the number of tab pages.
Sub GetTabCount(tabhostname As String) As String
	Dim v As View
	v = ViewMap.Get(tabhostname)
	If v.IsInitialized And v Is TabHost Then
		Dim T As TabHost
		T = v
		Return T.TabCount
	End If
	Return -1
End Sub

''@N:SetCurrentTab(tabhostname, tabnumber)
''Selects the current tab page.
Sub SetCurrentTab(tabhostname As String, tabnumber As String)
	Dim v As View
	v = ViewMap.Get(tabhostname)
	If v.IsInitialized And v Is TabHost Then
		Dim T As TabHost
		T = v
		T.CurrentTab = tabnumber
	End If
End Sub

#End Region

#Region TextView functions

''<a name="textview"></a>
''@H:TEXTVIEW FUNCTIONS
''Views containing text support these functions in addition to the Shared View functions.

''@N:CreateTypeface(typeface, style)
''There is one Typeface but it can be reinitialised as required.
''Typeface - "Default", "Monospace", "Serif", "Sans_Serif"
''Style - 0 Normal : 1 Bold : 2 Italic : 3 Bold_Italic
Sub CreateTypeface(face As String, style As String)
	face = face.ToLowerCase
	If face = "monospace" Then
		font = Typeface.CreateNew(Typeface.MONOSPACE, style)
	Else If face = "serif" Then
		font = Typeface.CreateNew(Typeface.SERIF, style)
	Else If face = "sans_serif" Then
		font = Typeface.CreateNew(Typeface.SANS_SERIF, style)
	Else
		font = Typeface.CreateNew(Typeface.DEFAULT, style)
	End If
End Sub

''@N:GetText(viewname)
''Get the Text property, if any, of the named view.
Sub GetText(name As String) As String
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is Label Then
		Dim l As Label
		l = v
		Return l.Text
	End If
	Return ""
End Sub

''@N:SetGravity(viewname, gravity)
''Set the Gravity property, if any, of the named view.
''The Gravity properties below may be used, or use the following values.
''NO_GRAVITY = 0; TOP = 48 (0x30) ; BOTTOM = 80 (0x50; LEFT = 3; RIGHT = 5; CENTER = 17 (0x11);
''CENTER_HORIZONTAL = 1; CENTER_VERTICAL = 16 (0x10) ; FILL = 119 (0x77); 
Sub SetGravity(name As String, gravityvalue As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is Label Then
		Dim l As Label
		l = v
		l.Gravity = gravityvalue			
	End If
End Sub

''@N:SetText(viewname, text)
''Set the Text property, if any, of the named view.
Sub SetText(name As String, Text As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is Label Then
		Dim l As Label
		l = v
		l.Text = Text			
	End If
End Sub

''@N:SetTextColor(viewname, color)
''Set the TextColor property, if any, of the named view.
Sub SetTextColor(name As String, Color As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is Label Then
		Dim l As Label
		l = v
		l.TextColor = Color
	End If
End Sub

''@N:SetTextSize(viewname, size)
''Set the TextSize property, if any, of the named view.
Sub SetTextSize(name As String, size As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is Label Then
		Dim l As Label
		l = v
		l.TextSize = size	
	End If
End Sub

''@N:SetTypeface(viewname)
''Set the Typeface property, if any, of the named view to the current typeface.
Sub SetTypeface(name As String)
	Dim v As View
	v = ViewMap.Get(name)
	If v.IsInitialized And v Is Label Then
		Dim l As Label
		l = v
		l.Typeface = font	
	End If
End Sub

#End Region

#Region Timer functions

''<a name="timer"></a>
''@H:TIMER FUNCTIONS
''There is one timer and the Timer Tick events are vectored to "Sub timer_tick".

''@N:SetTimerEnabled(enabled)
''Enable or disable the Timer.
Sub SetTimerEnabled(enabled As String)
	Timer1.enabled = enabled
End Sub

''@N:SetTimerInterval(interval)
''Set the timer interval in milliseconds.
Sub SetTimerInterval(interval As String)
	Timer1.interval = interval
End Sub

'Call the script "Sub timer_tick" when the timer Tick event is raised 
Sub Timer_Tick
	If Blib.CanCall("timer_tick") Then
		Blib.Call("timer_tick", Null)
	End If
End Sub

#End Region

#Region User Interaction Functions
''These dialogs allow interaction with the user.

''<a name="user"></a>
''@H:USER INTERACTION FUNCTIONS

''@N:CallDoEvents
''Allow the message loop to run, lets views repaint themselves.
Sub CallDoEvents
	DoEvents
End Sub

''@N:Dialog reponse codes
''
''@DialogResponse_Positive
''@DialogResponse_Cancel
''@DialogResponse_Negative
Sub DialogResponse_Positive As String
	Return DialogResponse.POSITIVE
End Sub

Sub DialogResponse_Cancel As String
	Return DialogResponse.CANCEL
End Sub

Sub DialogResponse_Negative As String
	Return DialogResponse.NEGATIVE
End Sub

''@N:GetInput
''Get the user input from the latest InputBox, InputDate or InputTime modal dialog.
''Set the positive, cancel and negative parameters to the desired button text or leave blank to omit the button.
Sub GetInput As String
	Return input
End Sub

''@N:InputBox(prompt, title, positive, cancel, negative, inputtype)
''Show a modal dialog box and prompt the user for data.
''Inputtype sets the value of the InpuBox InputType property.
''Returns a DialogResponse value with the input text available by calling GetInput.
Sub InputBox(prompt As String, title As String, Positive As String, Cancel As String, Negative As String, Inputtype As String) As String
	Dim I As InputDialog
	Dim response As String
	I.InputType = Inputtype
	response = I.Show(prompt, title, Positive, Cancel, Negative, Null)
	input = I.input
	Return response
End Sub

''@N:InputBox InputType codes
''
''@Type_Decimal
''@Type_Numbers
''@Type_None
''@Type_Phone
''@Type_Text
'NONE = 0; TEXT = 1; NUMBERS = 2; _PHONE = 3; DECIMAL_NUMBERS = 12290.
Sub Type_Decimal As String
	Return 12290
End Sub

Sub Type_Numbers As String
	Return 2
End Sub

Sub Type_None As String
	Return 0
End Sub

Sub Type_Phone As String
	Return 3
End Sub

Sub Type_Text As String
	Return 1
End Sub

''@N:InputCustom(viewname, title, positive, cancel, negative)
''Allows a custom dialog to be presented to the user.
''viewname - the name of a single view to display in the dialog, most probably a panel
''title - the text in the dialog's title bar.
''Returns a dialog response.
''
''Example:
''# first add your panel. It needs a black background
''AddPanel("mypanel", 0, 0, pwidth, pheight, "")
''SetColor("mypanel", 0, Color_Black)
''# next, add all the desired views to the panel like this
''AddLabel("mylabel", 0, 0, 60 * ScreenScale, 30 * ScreenScale, "mypanel")
''SetText("mylabel", "label text")
''# now remove the panel from the activity
''RemoveFromParent("mypanel")
''# now call InputCustom
''sel = InputCustom("mypanel", "Yes", "Cancel", "No")
Sub InputCustom(name As String, title As String, positive As String, cancel As String, negative As String) As String
	Dim v As View
	Dim ret As Int
	v = ViewMap.Get(name)
	If Not(v.IsInitialized) Then
		 Return DialogResponse.cancel
	End If
	v.RemoveView		'just in case we forgot to in b4script code
	Dim vis As Boolean
	vis = v.Visible		'if panel hidden, unhide to show then hide again
	If Not(vis) Then
		 v.Visible = True
	End If
	Dim cd As CustomDialog2
	cd.AddView(v, v.Width, v.Height)
	ret = cd.Show(title, positive, cancel, negative, Null)
	If Not(vis) Then
		 v.Visible = False
	End If
	Return ret
End Sub

''@N:InputDate(prompt, title, startdateticks, positive, cancel, negative)
''Show a modal dialog box and prompt the user for a date.
''Returns a DialogResponse value with the input value avalable to GetInput as a ticks value.
Sub InputDate(prompt As String, title As String, startdateticks As String, Positive As String, Cancel As String, Negative As String) As String
	Dim d As DateDialog
	Dim response As String
	d.DateTicks = startdateticks 
	response = d.Show(prompt, title, Positive, Cancel, Negative, Null)
	input = d.DateTicks
	Return response	
End Sub

''@N:InputFile(filepath, filename, filefilter, title, positive, cancel, negative)
''Show a modal dialog box and prompt the user for a path or file name.
''Returns a DialogResponse value with the input values available to GetInput as a  comma separated string.
''The first part is the file path and the last part is file name. If the user selected a path the file name is an  empty string.
Sub InputFile(filepath As String, filename As String, filefilter As String, title As String, Positive As String, Cancel As String, Negative As String) As String
	Dim F As FileDialog	
	Dim response As String
	F.TextColor = Colors.Black ' may need to change for different themes
	F.filepath = filepath
	F.ChosenName = filename
	F.filefilter = filefilter
	response = F.Show(title, Positive, Cancel, Negative, Null)
	input = F.filepath & "," & F.ChosenName
	Return response	
End Sub

''@N:InputListBox(itemarrayname, title, selecteditem)
''Show a modal dialog box and prompt the user to select an item.
''selecteditem is the index of the item that will first be selected or -1 if no item should be preselected.
''Returns the index of the selected item or DialogResponse.Cancel if the user pressed on the back key.
Sub InputListBox(itemarrayname As String, title As String, selecteditem As String) As String
	Dim l As List
	l.Initialize
	Dim ia(0) As String
	ia = Blib.GetArray(itemarrayname)
	For I = 0 To ia.Length - 1
		l.Add(ia(I))
	Next
	Return InputList(l, title, selecteditem) 	
End Sub

''@N:InputMultiListBox(itemarrayname, title)
''Show a modal dialog box and prompt the user to select one or more items.
''Returns a comma separated list of indices selected that may be separated with StrSplit.
''Returns an empty string ("") if the Back button was pressed or no items were selected.
Sub InputMultiListBox(itemarrayname As String, title As String) As String
	Dim l As List
	Dim ret, comma As String
	l.Initialize
	Dim ia(0) As String
	ia = Blib.GetArray(itemarrayname)
	For I = 0 To ia.Length - 1
		l.Add(ia(I))
	Next
	l = InputMultiList(l, title)
	ret = ""
	comma = ""
	For I = 0 To l.Size - 1
		ret = ret & comma & l.Get(I)
		comma = ","
	Next
	Return ret
End Sub

''@N:InputNumber(showsign, digits, number, title, positive, cancel, negative)
''Show a modal dialog box and prompt the user for an integer number.
''If ShowSign is True the sign of the number corresponds to the sign entered by the user.
''Returns a DialogResponse value with the input number available to GetInput.
''If ShowSign is True the sign of the number corresponds to the sign entered by the user.
Sub InputNumber(showsign As String, digits As String, number As String, title As String, Positive As String, Cancel As String, Negative As String) As String
	Dim n As NumberDialog
	Dim response As String
	n.showsign = showsign
	n.digits = digits
	n.number = number
	response = n.Show(title, Positive, Cancel, Negative, Null)
	input = n.number
	Return response	
End Sub

''@N:InputTime(prompt, title, starttimeticks, as24hours, positive, cancel, negative)
''Show a modal dialog box and prompt the user for a time.
''Returns a DialogResponse value with the input value available to GetInput as a ticks value.
Sub InputTime(prompt As String, title As String, starttimeticks As String, as24hrs As String, Positive As String, Cancel As String, Negative As String) As String
	Dim T As TimeDialog
	Dim response As String
	T.TimeTicks = starttimeticks
	T.Is24Hours = as24hrs
	response = T.Show(prompt, title, Positive, Cancel, Negative, Null)
	input = T.TimeTicks
	Return response	
End Sub

''@N:MessageBox(message, title, positive, cancel, negative)
''Show a modal dialog box and prompt the user to make a selection.
''Returns a DialogResponse.
Sub MessageBox(message As String, title As String, Positive As String, Cancel As String, Negative As String) As String
	Dim response As String
	response = Msgbox2(message, title, Positive, Cancel, Negative, Null)
	Return response	
End Sub

''@N:ProgressHide
''Hide a non-modal progress dialog.
Sub ProgressHide
	ProgressDialogHide
End Sub

''@N:ProgressShow(text, usercancel)
''Show a non-modal progress dialog.
''Shows a dialog with a circular spinning bar and the specified text.
''Unlike Msgbox And InputList methods, the code will not block.
''You should call ProgressDialogHide To remove the dialog.
''If usercancel is True The dialog will also be removed If the user presses on the Back key.
Sub ProgressShow(text As String, usercancel As String)
	ProgressDialogShow2(text, usercancel)
End Sub

''@N:ShowToast(message, longduration)
''Shows a Toast. Setting longduration to true will cause the toast to stay on the screen longer.
Sub ShowToast(msg As String, longtime As String)
	ToastMessageShow(msg, longtime)
End Sub

#End Region

#Region Color constants

''<a name="colors"></a>
''@H:COLOR CONSTANTS
''These additional color constants return the color codes for the named color.
''
''@cDarkGray
''@cLightGray
''@cMagenta
''@cTransparent

Sub cDarkGray As String
	Return Colors.DarkGray
End Sub

Sub cLightGray As String
	Return Colors.LightGray
End Sub

Sub cMagenta As String
	Return Colors.Magenta
End Sub

Sub cTransparent As String
	Return Colors.Transparent
End Sub



#End Region

#Region Keycode functions

''<a name="key"></a>
''@H:KEYCODE FUNCTIONS AND CONSTANTS

''Pass the KeyCode value from the Activity_KeyPress event to any of these functions
''They will Return True or False depending upon whether the passed KeyCode is contained within that particular set.
''
''@Key_isNumber(KeyCode)
''Numeric keys are: 0123456789
''
''@Key_isAlpha(KeyCode)
'' Alpha keys are: ABCDEFGHIJKLMNOPQRSTUVWXYZ
''
''@Key_isSymbol(KeyCode)
'' Symbol keys are: '@/,=(-.+#^);\*
''
''@Key_isKeyboard(KeyCode)
''Keyboard keys are:  AltLeft AltRight Clear Del Enter Num ShiftLeft ShiftRight Space Symbol
''
''@Key_isDPad(KeyCode)
''DPad Keys are: Left Center Right Up Down
''
''@Key_isMedia(KeyCode)
''Media keys are:  FastForward Next Play/Pause Rewind Stop Mute
''
''@Key_isDevice(KeyCode)
''Device keys are : Back Call Camera EndCall Envelope Explorer Focus Grave HeadsetHook Home 
''&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Menu Notification Search SoftLeft SoftRight VolumeUp VolumeDown

Sub Key_isNumber(KeyCode As String) As String
	Dim isnum As Boolean
	isnum = True
	Select KeyCode
		Case KeyCodes.KEYCODE_0
		Case KeyCodes.KEYCODE_1
		Case KeyCodes.KEYCODE_2
		Case KeyCodes.KEYCODE_3
		Case KeyCodes.KEYCODE_4
		Case KeyCodes.KEYCODE_5
		Case KeyCodes.KEYCODE_6
		Case KeyCodes.KEYCODE_7
		Case KeyCodes.KEYCODE_8
		Case KeyCodes.KEYCODE_9
		Case Else
			isnum = False
	End Select
	Return isnum
End Sub

Sub Key_isAlpha(KeyCode As String) As String
	Dim isalpha As Boolean
	isalpha = True
	Select KeyCode
		Case KeyCodes.KEYCODE_A
		Case KeyCodes.KEYCODE_B
		Case KeyCodes.KEYCODE_C
		Case KeyCodes.KEYCODE_D
		Case KeyCodes.KEYCODE_E
		Case KeyCodes.KEYCODE_F
		Case KeyCodes.KEYCODE_G
		Case KeyCodes.KEYCODE_H
		Case KeyCodes.KEYCODE_I
		Case KeyCodes.KEYCODE_J
		Case KeyCodes.KEYCODE_K
		Case KeyCodes.KEYCODE_L
		Case KeyCodes.KEYCODE_M
		Case KeyCodes.KEYCODE_N
		Case KeyCodes.KEYCODE_O
		Case KeyCodes.KEYCODE_P
		Case KeyCodes.KEYCODE_Q
		Case KeyCodes.KEYCODE_R
		Case KeyCodes.KEYCODE_S
		Case KeyCodes.KEYCODE_T
		Case KeyCodes.KEYCODE_U
		Case KeyCodes.KEYCODE_V
		Case KeyCodes.KEYCODE_W
		Case KeyCodes.KEYCODE_X
		Case KeyCodes.KEYCODE_Y
		Case KeyCodes.KEYCODE_Z
		Case Else
			isalpha = False
	End Select
	Return isalpha
End Sub

Sub Key_isSymbol(KeyCode As String) As String
	Dim issym As Boolean
	issym = True
	Select KeyCode
		Case KeyCodes.KEYCODE_APOSTROPHE
		Case KeyCodes.KEYCODE_AT
		Case KeyCodes.KEYCODE_BACKSLASH
		Case KeyCodes.KEYCODE_COMMA
		Case KeyCodes.KEYCODE_EQUALS
		Case KeyCodes.KEYCODE_LEFT_BRACKET
		Case KeyCodes.KEYCODE_MINUS
		Case KeyCodes.KEYCODE_PERIOD
		Case KeyCodes.KEYCODE_PLUS
		Case KeyCodes.KEYCODE_POUND
		Case KeyCodes.KEYCODE_POWER
		Case KeyCodes.KEYCODE_RIGHT_BRACKET
		Case KeyCodes.KEYCODE_SEMICOLON
		Case KeyCodes.KEYCODE_SLASH
		Case KeyCodes.KEYCODE_STAR
		Case Else
			issym = False
	End Select
	Return issym
End Sub

Sub Key_isKeyboard(KeyCode As String) As String
	Dim iskey As Boolean
	iskey = True
	Select KeyCode
		Case KeyCodes.KEYCODE_ALT_LEFT
		Case KeyCodes.KEYCODE_ALT_RIGHT
		Case KeyCodes.KEYCODE_CLEAR
		Case KeyCodes.KEYCODE_DEL
		Case KeyCodes.KEYCODE_ENTER
		Case KeyCodes.KEYCODE_NUM
		Case KeyCodes.KEYCODE_SHIFT_LEFT
		Case KeyCodes.KEYCODE_SHIFT_RIGHT
		Case KeyCodes.KEYCODE_SPACE
		Case KeyCodes.KEYCODE_SYM
		Case Else
			iskey = False
	End Select
	Return iskey
End Sub

Sub Key_isDPad(KeyCode As String) As String
	Dim ispad As Boolean
	ispad = True
	Select KeyCode
		Case KeyCodes.KEYCODE_DPAD_CENTER
		Case KeyCodes.KEYCODE_DPAD_DOWN
		Case KeyCodes.KEYCODE_DPAD_LEFT
		Case KeyCodes.KEYCODE_DPAD_RIGHT
		Case KeyCodes.KEYCODE_DPAD_UP
		Case Else
			ispad = False
	End Select
	Return ispad
End Sub

Sub Key_isMedia(KeyCode As String) As String
	Dim ismed As Boolean
	ismed = True
	Select KeyCode
		Case KeyCodes.KEYCODE_MEDIA_FAST_FORWARD
		Case KeyCodes.KEYCODE_MEDIA_NEXT
		Case KeyCodes.KEYCODE_MEDIA_PLAY_PAUSE
		Case KeyCodes.KEYCODE_MEDIA_PREVIOUS
		Case KeyCodes.KEYCODE_MEDIA_REWIND
		Case KeyCodes.KEYCODE_MEDIA_STOP
		Case KeyCodes.KEYCODE_MUTE
		Case Else
			ismed = False
	End Select
	Return ismed
End Sub

Sub Key_isDevice(KeyCode As String) As String
	Dim isdev As Boolean
	isdev = True
	Select KeyCode
		Case KeyCodes.KEYCODE_BACK
		Case KeyCodes.KEYCODE_CALL
		Case KeyCodes.KEYCODE_CAMERA
		Case KeyCodes.KEYCODE_ENDCALL
		Case KeyCodes.KEYCODE_ENVELOPE
		Case KeyCodes.KEYCODE_EXPLORER	'not sure bout this one???
		Case KeyCodes.KEYCODE_FOCUS		'or this one???
		Case KeyCodes.KEYCODE_GRAVE		'have no idea bout this one???
		Case KeyCodes.KEYCODE_HEADSETHOOK
		Case KeyCodes.KEYCODE_HOME
		Case KeyCodes.KEYCODE_MENU
		Case KeyCodes.KEYCODE_NOTIFICATION
		Case KeyCodes.KEYCODE_SEARCH
		Case KeyCodes.KEYCODE_SOFT_LEFT
		Case KeyCodes.KEYCODE_SOFT_RIGHT
		Case KeyCodes.KEYCODE_VOLUME_DOWN
		Case KeyCodes.KEYCODE_VOLUME_UP
		Case Else
			isdev = False
	End Select
	Return isdev
End Sub

''
''
''Pass a KeyCode to these functions to get the ASCII value of a key as returned by Asc().
''Whether a KeyCode is a letter, number or symbol can be checked using the KeyCode functions above.
''KeyCodes for 0 to 9 are integer values 7 to 16.
''KeyCodes for letters A to Z are integer values 29 to 54.
''
''@ KeyToAsciiUpper(KeyCode)
''@ KeyToAsciiLower(KeyCode)
''@ KeyToNumberKey(KeyCode)

Sub KeyToAsciiUpper(KeyCode As String) As String
	Return KeyCode + 36
End Sub

Sub KeyToAsciiLower(KeyCode As String) As String
	Return KeyCode + 67
End Sub

Sub KeyToNumberKey(KeyCode As String) As String
	Return KeyCode + 19
End Sub

''
''
''KeyCode constants:
''Note that not all KeyCode constants are supported.
''Whether a KeyCode is a letter, number or symbol can be checked using the KeyCode functions above.
''KeyCodes for 0 to 9 are integer values 7 to 16.
''KeyCodes for letters A to Z are integer values 29 to 54.
''
''@Key_AltLeft
''@Key_AltRight
''@Key_Back
''@Key_Call
''@Key_Camera
''@Key_Clear
''@Key_Del
''@Key_DPadCenter
''@Key_DPadDown
''@Key_DPadLeft
''@Key_DPadRight
''@Key_DPadUp
''@Key_EndCall
''@Key_Enter
''@Key_Envelope
''@Key_Explorer
''@Key_Focus
''@Key_Grave
''@Key_HeadSetHook
''@Key_Home
''@Key_MediaFastForward
''@Key_MediaNext
''@Key_MediaPlayPause
''@Key_MediaPrevious
''@Key_MediaRewind
''@Key_MediaStop
''@Key_Menu
''@Key_Mute
''@Key_Notification
''@Key_Num
''@Key_Search
''@Key_ShiftLeft
''@Key_ShiftRight
''@Key_SoftLeft
''@Key_SoftRight
''@Key_Sym
''@Key_Tab
''@Key_Unknown
''@Key_VolumeDown
''@Key_VolumnUp

Sub Key_AltLeft As String
	Return KeyCodes.KEYCODE_ALT_LEFT
End Sub

Sub Key_AltRight As String
	Return KeyCodes.KEYCODE_ALT_RIGHT
End Sub

Sub Key_Back As String
	Return KeyCodes.KEYCODE_BACK
End Sub

Sub Key_Call As String
	Return KeyCodes.KEYCODE_CALL
End Sub

Sub Key_Camera As String
	Return KeyCodes.KEYCODE_CAMERA
End Sub

Sub Key_Clear As String
	Return KeyCodes.KEYCODE_CLEAR
End Sub

Sub Key_Del As String
	Return KeyCodes.KEYCODE_DEL
End Sub

Sub Key_DPadCenter As String
	Return KeyCodes.KEYCODE_DPAD_CENTER
End Sub

Sub Key_DPadDown As String
	Return KeyCodes.KEYCODE_DPAD_DOWN
End Sub

Sub Key_DPadLeft As String
	Return KeyCodes.KEYCODE_DPAD_LEFT
End Sub

Sub Key_DPadRight As String
	Return KeyCodes.KEYCODE_DPAD_RIGHT
End Sub

Sub Key_DPadUp As String
	Return KeyCodes.KEYCODE_DPAD_UP
End Sub

Sub Key_EndCall As String
	Return KeyCodes.KEYCODE_ENDCALL
End Sub

Sub Key_Enter As String
	Return KeyCodes.KEYCODE_ENTER
End Sub	

Sub Key_Envelope As String
	Return KeyCodes.KEYCODE_ENVELOPE
End Sub

Sub Key_Explorer As String
	Return KeyCodes.KEYCODE_EXPLORER
End Sub

Sub Key_Focus As String
	Return KeyCodes.KEYCODE_FOCUS
End Sub

Sub Key_Grave As String
	Return KeyCodes.KEYCODE_GRAVE
End Sub

Sub Key_HeadSetHook As String
	Return KeyCodes.KEYCODE_HEADSETHOOK
End Sub

Sub Key_Home As String
	Return KeyCodes.KEYCODE_HOME
End Sub

Sub Key_MediaFastForward As String
	Return KeyCodes.KEYCODE_MEDIA_FAST_FORWARD
End Sub

Sub Key_MediaNext As String
	Return KeyCodes.KEYCODE_MEDIA_NEXT
End Sub

Sub Key_MediaPlayPause As String
	Return KeyCodes.KEYCODE_MEDIA_PLAY_PAUSE
End Sub

Sub Key_MediaPrevious As String
	Return KeyCodes.KEYCODE_MEDIA_PREVIOUS
End Sub

Sub Key_MediaRewind As String
	Return KeyCodes.KEYCODE_MEDIA_REWIND
End Sub

Sub Key_MediaStop As String
	Return KeyCodes.KEYCODE_MEDIA_STOP
End Sub

Sub Key_Menu As String
	Return KeyCodes.KEYCODE_MENU
End Sub

Sub Key_Mute As String
	Return KeyCodes.KEYCODE_MUTE
End Sub

Sub Key_Notification As String
	Return KeyCodes.KEYCODE_NOTIFICATION
End Sub

Sub Key_Num As String
	Return KeyCodes.KEYCODE_NUM
End Sub

Sub Key_Search As String
	Return KeyCodes.KEYCODE_SEARCH
End Sub

Sub Key_ShiftLeft As String
	Return KeyCodes.KEYCODE_SHIFT_LEFT
End Sub

Sub Key_ShiftRight As String
	Return KeyCodes.KEYCODE_SHIFT_RIGHT
End Sub

Sub Key_SoftLeft As String
	Return KeyCodes.KEYCODE_SOFT_LEFT
End Sub

Sub Key_SoftRight As String
	Return KeyCodes.KEYCODE_SOFT_RIGHT
End Sub

Sub Key_Sym As String
	Return KeyCodes.KEYCODE_SYM
End Sub

Sub Key_Tab As String
	Return KeyCodes.KEYCODE_TAB
End Sub

Sub Key_Unknown As String
	Return KeyCodes.KEYCODE_UNKNOWN
End Sub

Sub Key_VolumeDown As String
	Return KeyCodes.KEYCODE_VOLUME_DOWN
End Sub

Sub Key_VolumnUp As String
	Return KeyCodes.KEYCODE_VOLUME_UP
End Sub

#End Region

#Region Gravity constants
''<a name="gravity"></a>
''@H:GRAVITY CONSTANTS
''These gravity constants return gravity values needed by functions for justifying text and images
''They may be used instead of hard coding numeric values.
''
''@Gravity_None
''@Gravity_Top
''@Gravity_Bottom
''@Gravity_Left
''@Gravity_Right
''@Gravity_Center
''@Gravity_CenterHorizontal
''@(also Gravity_HCenter)
''@Gravity_CenterVertical
''@(also Gravity_VCenter)
''@Gravity_Fill

Sub Gravity_None As String
	Return Gravity.NO_GRAVITY
End Sub

Sub Gravity_Top As String
	Return Gravity.TOP
End Sub

Sub Gravity_Bottom As String
	Return Gravity.BOTTOM
End Sub

Sub Gravity_Left As String
	Return Gravity.LEFT
End Sub

Sub Gravity_Right As String
	Return Gravity.RIGHT
End Sub

Sub Gravity_Center As String
	Return Gravity.CENTER
End Sub

Sub Gravity_CenterHorizontal As String
	Return Gravity.CENTER_HORIZONTAL
End Sub

Sub Gravity_HCenter As String
	Return Gravity.CENTER_HORIZONTAL
End Sub

Sub Gravity_CenterVertical As String
	Return Gravity.CENTER_VERTICAL
End Sub

Sub Gravity_VCenter As String
	Return Gravity.CENTER_VERTICAL
End Sub

Sub Gravity_Fill As String
	Return Gravity.FILL
End Sub

#End Region

#Region Typeface constants

''<a name="typeface"></a>
''@H:TYPEFACE CONSTANTS
''These typeface constants return the values needed for the typeface functions.
''They may be used instead of hard coding numeric values.
''
''@FontDefault
''@FontMonospace
''@FontSerif
''@FontSansSerif
''@StyleNormal
''@StyleBold
''@StyleItalic
''@StyleBoldItalic

Sub FontDefault As String
	Return "default"
End Sub

Sub FontMonospace As String
	Return "monospace"
End Sub

Sub FontSerif As String
	Return "serif"
End Sub

Sub FontSansSerif As String
	Return "sans_serif"
End Sub

Sub StyleNormal As String
	Return Typeface.STYLE_NORMAL
End Sub

Sub StyleBold As String
	Return Typeface.STYLE_BOLD
End Sub

Sub StyleItalic As String
	Return Typeface.STYLE_ITALIC
End Sub

Sub StyleBoldItalic As String
	Return Typeface.STYLE_BOLD_ITALIC
End Sub

#End Region

#Region AddNewSysCalls

' Call once after Blib.Initialize to add the new functions
Sub AddNewSysCalls
	'
	' System functions included with BasicLibIDE
	'
	' General functions
	Blib.AddSysCalls(Array As String("CloseApplication", _
										"IIf", _
										"cNumbers", _ 
										"HideKeyboard"))
	' String Functions
	Blib.AddSysCalls(Array As String("SBAppend", _
									"SBInitialize", _
									"SBInsert", _
									"SBLength", _
									"SBRemove", _
									"SBToString", _ 
									"StrTrim"))
	' Device functions
	Blib.AddSysCalls(Array As String( "ActivityHeight", _
									 "ActivityWidth", _									
									 "GetLayoutValues", _
									 "GetOrientation", _
									 "ScreenScale"))
	' Activity functions
	Blib.AddSysCalls(Array As String("ActivityFinish", _
									"CloseMenu", _
									"GetFirstTime", _
									"CloseAfterThis", _
									"LogCat", _
									"OpenMenu", _
									"SetActivityBackground", _
									"SetActivityTitle", _
									"SetActivityTitleColor"))		
	' Array functions
	Blib.AddSysCalls(Array As String("FillArray", _
									 "SearchArray", _
									 "SortArray"))									 
	'File functions
	Blib.AddSysCalls(Array As String( "FileCopy", _
									 "FileDelete", _
									 "FileDirAssets", _
									 "FileDirDefaultExternal", _
									 "FileDirInternal", _
									 "FileDirRootExternal", _
									 "FileExists", _
									 "FileGetPath", _
									 "FileIsDirectory", _
									 "FileIsSDCard", _
									 "FileListFiles", _
									 "FileMakeDir", _
									 "FileReadList", _
									 "FileReadString", _
									 "FileRename", _
									 "FileWriteList", _
									 "FileWriteString"))									 
	' Add View Tunctions and Events 
	Blib.AddSysCalls(Array As String("AddButton", _
									"AddCheckBox", _
									"AddEditText", _
									"AddHorizontalScroll", _
									"AddImage", _
									"AddLabel", _
									"AddListView", _
									"AddMenuItem", _
									"AddPanel", _
									"AddProgressBar", _
									"AddRadioButton", _
									"AddScrollView", _
									"AddSeekBar", _
									"AddSpinner", _
									"AddTabHost", _
									"AddToggleButton", _
									"RemoveAllViews", _
									"RemoveView", _
									"RemoveFromParent", _
									"SetNewParent"))
	' Shared View functions
	Blib.AddSysCalls(Array As String("BringToFront", _
									 "GetEnabled", _
									 "GetHeight", _
									 "GetLeft", _
									 "GetRight", _
									 "GetTop", _
									 "GetVisible", _
									 "GetWidth", _
									 "Invalidate", _
									 "IsView", _
									 "RequestFocus", _
									 "SendToBack", _
									 "SetBackground", _
									 "SetBackgroundGradient", _
									 "SetBackgroundImage", _
									 "SetColor", _
									 "SetEnabled", _
									 "SetHeight", _
									 "SetLeft", _
									 "SetTop", _
									 "SetVisible", _
									 "SetWidth"))
	' CheckBox, RadioButton and ToggleButton functions
	Blib.AddSysCalls(Array As String("GetChecked", _
									 "SetChecked", _
									 "SetTextOn", _
									 "SetTextOff"))
	' Edittext functions
	Blib.AddSysCalls(Array As String("GetSelectionStart", _
									 "SelectAll", _
									 "SelectText", _
									 "SetForceDoneButton", _
									 "SetHint", _
									 "SetHintColor", _
									 "SetInputType", _
									 "SetPasswordMode", _
									 "SetSelectionStart", _
									 "SetSingleLine", _
									 "SetWrap"))
	' Graphics functions
	Blib.AddSysCalls(Array As String("BitmapHeight", _
									 "BitmapInit", _
									 "BitmapInitMutable", _
									 "BitmapWidth", _
									 "CanvasInit", _
									 "CanvasInit2", _
									 "DrawBitmap", _
									 "DrawBitmapFlipped", _
									 "DrawBitmapRotated", _
									 "DrawCircle", _
									 "DrawColor", _
									 "DrawLine", _
									 "DrawOval", _
									 "DrawOvalRotated", _
									 "DrawPath", _
									 "DrawPoint", _
									 "DrawRect", _
									 "DrawRectRotated", _
									 "DrawText", _
									 "DrawTextRotated"))
	' Listview functions
	Blib.AddSysCalls(Array As String("GetLabel", _
									 "SetFastScrollEnabled", _
									 "SetItemHeight", _									 
									 "SetLayoutBackgroundColor", _
									 "SetLayoutBackgroundColorgradient", _
									 "SetScrollColor"))
	' Listview & spinner functions
	Blib.AddSysCalls(Array As String("Add", _
									 "AddAll", _
									 "Clear", _
									 "GetItem", _
									 "GetSize", _
									 "RemoveAt"))
	' ProgressBar functions
	Blib.AddSysCalls(Array As String("GetIndeterminate", _
									 "GetProgress", _
									 "SetIndeterminate", _
									 "SetProgress"))
	' ScrollView functions
	Blib.AddSysCalls(Array As String("FullScroll", _
									"GetPanel", _
									"GetScrollPosition", _
									"SetScrollPosition"))
	' SeekBar functions
	Blib.AddSysCalls(Array As String("GetMax", _
									 "GetValue", _
									 "SetMax", _
									 "SetValue"))
	' Spinner functions
	Blib.AddSysCalls(Array As String("GetSelectedIndex", _
									 "GetSelectedItem", _
									 "SetPrompt", _
									 "SetSelectedIndex"))
	' TabHost functions
	Blib.AddSysCalls(Array As String("AddTab", _
									 "GetCurrentTab", _
									 "GetTabCount", _
									 "SetCurrentTab"))
	' Textview functions
	Blib.AddSysCalls(Array As String("CreateTypeface", _
									 "GetText", _
									 "SetGravity", _
									 "SetText", _
									 "SetTextColor", _
									 "SetTextSize", _
									 "SetTypeface"))
	' Timer functions
	Blib.AddSysCalls(Array As String("SetTimerEnabled", _
									 "SetTimerInterval"))
	'User interaction functions
	Blib.AddSysCalls(Array As String("CallDoEvents", _
									 "DialogResponse_Positive", _
									 "DialogResponse_Cancel", _
									 "DialogResponse_Negative", _								 
									 "GetInput", _
									 "InputBox", _
									 "InputCustom", _
									 "InputDate", _
									 "InputFile", _
									 "InputListBox", _
									 "InputMultiListBox", _
									 "InputNumber", _
									 "InputTime", _
									 "MessageBox", _
									 "ProgressHide", _
									 "ProgressShow", _
									 "ShowToast", _
									"Type_Decimal", _
									"Type_Numbers", _
									"Type_None", _
									"Type_Phone", _
									"Type_Text"))
	' Color constants
	Blib.AddSysCalls(Array As String("cDarkGray", _
									 "cLightGray", _
									 "cMagenta", _
									 "cTransparent"))	
	' KeyCode functions and constants
	Blib.AddSysCalls(Array As String("Key_isNumber", _
									 "Key_isAlpha", _
									 "Key_isSymbol", _
									 "Key_isKeyboard", _
									 "Key_isDPad", _
									 "Key_isMedia", _
									 "Key_isDevice", _
									 "Key_AltLeft", _
									 "Key_AltRight", _
									 "Key_Back", _
									 "Key_Call", _
									 "Key_Camera", _
									 "Key_Clear", _
									 "Key_Del", _
									 "Key_DPadCenter", _
									 "Key_DPadDown", _
									 "Key_DPadLeft", _
									 "Key_DPadRight", _
									 "Key_DPadUp", _
									 "Key_EndCall", _
									 "Key_Enter", _
									 "Key_Envelope", _
									 "Key_Explorer", _
									 "Key_Focus", _
									 "Key_Grave", _
									 "Key_HeadSetHook", _
									 "Key_Home", _
									 "Key_MediaFastForward", _
									 "Key_MediaNext", _
									 "Key_MediaPlayPause", _
									 "Key_MediaPrevious", _
									 "Key_MediaRewind", _
									 "Key_MediaStop", _
									 "Key_Menu", _
									 "Key_Mute", _
									 "Key_Notification", _
									 "Key_Num", _
									 "Key_Search", _
									 "Key_ShiftLeft", _
									 "Key_ShiftRight", _
									 "Key_SoftLeft", _
									 "Key_SoftRight", _
									 "Key_Sym", _
									 "Key_Tab", _
									 "Key_Unknown", _
									 "Key_VolumeDown", _
									 "Key_VolumnUp"))									 
	' Gravity constants
	Blib.AddSysCalls(Array As String("Gravity_None", _
									 "Gravity_Top", _
									 "Gravity_Bottom", _
									 "Gravity_Left", _
									 "Gravity_Right", _
									 "Gravity_Center", _
									 "Gravity_CenterHorizontal", _
									 "Gravity_HCenter", _
									 "Gravity_CenterVertical", _
									 "Gravity_VCenter", _
									 "Gravity_Fill"))
	' Typeface Constants
	Blib.AddSysCalls(Array As String("FontDefault", _
									 "FontMonospace", _
									 "FontSerif", _
									 "FontSansSerif", _
									 "StyleNormal", _
									 "StyleBold", _
									 "StyleItalic", _
									 "StyleBoldItalic"))
End Sub

#End Region

