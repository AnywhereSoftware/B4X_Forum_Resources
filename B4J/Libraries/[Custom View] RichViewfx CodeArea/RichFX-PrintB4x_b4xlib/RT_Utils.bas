B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4.19
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub
Public Sub GetPackageName (Module As Object) As String
	Dim ModJo As JavaObject = Module
	Dim MoStr As String = ModJo.RunMethod("toString",Null)
	Return MoStr.SubString2(MoStr.IndexOf(" ")+1,MoStr.LastIndexOf("."))
End Sub
'Joins an array or list of strings with Delimeters in between
Public Sub StringJoin(Delim As String, Source As Object) As String
	Dim Str As JavaObject
	Str.InitializeNewInstance("java.lang.String",Null)
	Return Str.RunMethod("join",Array(Delim,Source))
End Sub
Public Sub StringCount(StringToSearch As String,TargetStr As String,IgnoreCase As Boolean) As Int
    If IgnoreCase Then
        StringToSearch = StringToSearch.ToLowerCase
        TargetStr = TargetStr.ToLowerCase
    End If

    Return (StringToSearch.Length - StringToSearch.Replace(TargetStr,"").Length) / TargetStr.Length

End Sub
Public Sub GetTypes As String()
	Dim L() As String = Array As String( _
	"Activity", _
	"Bitmap", _
	"Button", _
	"Boolean", _
	"Boolean()", _
	"Byte", _
	"Byte()", _
	"Canvas", _
	"Checkbox", _
	"Char", _
	"Char()", _
	"ColorDrawable", _
	"ComboBox", _
	"Context", _
	"Double", _
	"Double()", _
	"Drawable", _
	"EditText", _
	"File", _
	"Float", _
	"Float()", _
	"Font", _
	"Form", _
	"InputStream", _
	"Int", _
	"Int()", _
	"Intent", _
	"JavaObject", _
	"JavaObject()", _
	"JFX", _
	"Label", _
	"List", _
	"ListView", _
	"Long", _
	"Long()", _
	"Map", _
	"Matcher", _
	"MediaPlayer", _
	"Node", _
	"Object", _
	"Object()", _
	"OutputStream", _
	"PackageManager", _
	"Pane", _
	"Path", _
	"Phone", _
	"ProgressBar", _
	"RadioButton", _
	"RandomAccessFile", _
	"Rect", _
	"RichString", _
	"RichStringBuilder", _
	"RichStringFormatter", _
	"SeekBar", _
	"Short", _
	"Short()", _
	"Spinner", _
	"StateListDrawable", _
	"String", _
	"String()", _
	"Timer", _
	"Togglebutton", _
	"Tooltip", _
	"Typeface", _
	"Uri", _
	"View", _
	"WebView" _
	)
	Return L
End Sub

Sub GetKeywords As String()
	'"As" is dealt with Explicitly
	Dim L() As String = Array As String( _
	"Abs", _
	"ACos", _
	"ACosD", _
	"Array", _
	"Asc", _
	"ASin", _
	"ASinD", _
	"ATan", _
	"ATan2", _
	"ATan2D", _
	"ATanD", _
	"BytesToString", _
	"CallSub", _
	"CallSub2", _
	"CallSub3", _
	"CallSubDelayed", _
	"CallSubDelayed2", _
	"CallSubDelayed3", _
	"CancelScheduledService", _
	"Catch", _
	"cE", _
	"Ceil", _
	"CharsToString", _
	"Chr", _
	"ConfigureHomeWidget", _
	"Continue", _
	"Cos", _
	"CosD", _
	"cPI", _
	"CreateMap", _
	"CRLF", _
	"Density", _
	"Dim", _
	"DipToCurrent", _
	"Do", _
	"DoEvents", _
	"End", _
	"Exit", _
	"ExitApplication", _
	"False", _
	"File", _
	"Floor", _
	"For", _
	"GetDeviceLayoutValues", _
	"GetType", _
	"If", _
	"InputList", _
	"InputMap", _
	"InputMultiList", _
	"Is", _
	"IsBackgroundTaskRunning", _
	"IsDevTool", _
	"IsNumber", _
	"IsPaused", _
	"LastException", _
	"LoadBitmap", _
	"LoadBitmapSample", _
	"Log", _
	"Logarithm", _
	"LogColor", _
	"Loop", _
	"Max", _
	"Me", _
	"Min", _
	"Msgbox", _
	"Msgbox2", _
	"Not", _
	"Null", _
	"NumberFormat", _
	"NumberFormat2", _
	"PerXToCurrent", _
	"PerYToCurrent", _
	"Power", _
	"Private", _
	"ProgressDialogHide", _
	"ProgressDialogShow", _
	"ProgressDialogShow2", _
	"Public", _
	"QUOTE", _
	"Regex", _
	"Return", _
	"Rnd", _
	"RndSeed", _
	"Round", _
	"Round2", _
	"Select", _
	"Sender", _
	"Sin", _
	"SinD", _
	"SmartStringFormatter", _
	"Sqrt", _
	"StartActivity", _
	"StartService", _
	"StartServiceAt", _
	"StartServiceAtExact", _
	"StopService", _
	"Sub", _
	"SubExists", _
	"TAB", _
	"Tan", _
	"TanD", _
	"ToastMessageShow", _
	"True", _
	"Try", _
	"Type", _
	"Until", _
	"While" _
	)
	Return L
End Sub
Sub GetDirectives As String()
	Dim L() As String = Array As String( _
	"#AdditionalJar:", _
	"#CommandLineArgs:", _
	"#CustomBuildAction:", _
	"#DebuggerDisableOptimizations:", _
	"#DesignerProperty:", _
	"#Event:", _
	"#ExcludeFromLibrary:", _
	"#IgnoreWarnings:", _
	"#LibraryAuthor:", _
	"#LibraryName:", _
	"#LibraryVersion:", _
	"#MainFormHeight:", _
	"#MainFormWidth:", _
	"#MergeLibraries:", _
	"#RaisesSynchronousEvents", _
	"#VirtualMachineArgs:" _
	)
	Return L
End Sub
Sub GetConditional As String()
	Dim L() As String = Array As String( _
	"#If", _
	"#Else", _
	"#End\ If", _
	"#Else\ If", _
	"#Region", _
	"#End\ Region" _
	)
	Return L
End Sub
