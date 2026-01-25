B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private xui As XUI
	Private callback As Object		'ignore
	Private isVerbose As Boolean
	
	Public Py As PyBridge
	Public fns As Map
	Private cDir As String
	Public TABspaces As String = "    "		'check n spaces at tools->IDE options->Font Picker->Tab Size
	Private checkSyntax, installPackage, varNames, blog, pylogs, version As String		'ignore
	Private pyKeyWords As Map
	Private globalVars As Map
	Private varCaseness As Map
	Private defNames As Map
	Private anonCount As Int
	Public kernel As String
End Sub

'Initializes the instance and return the PyWorks Object - the callback parameter is not used yet
Public Sub Initialize(caller As Object, verbose As Boolean) As PyWorks
	initUtils
	pyKeyWords.Initialize
	varCaseness.Initialize
	defNames.Initialize
	Dim items() As String = Array As String("globals", "print", "and", "as", "assert", "async", "await", "break", "class", _
		"continue", "def", "del", "elif", "else", "except", "finally", "for", "from", "global", _
		"if", "import", "in", "is", "lambda", "nonlocal", "not", "or", "pass", "raise", "return", _
		"bool", "int", "str", "list", "tuple", "set", "dict", "abs", "max", "min", "pow", "round", "sum", "dir", _
		"help", "id", "isinstance", "len", "type", "enumerate", "filter", "map", "range", "sorted","zip", _	
		"try", "while", "with", "yield", "True", "False", "None")
	For Each kw As String In items
		pyKeyWords.Put(kw.toLowerCase, kw) 
	Next
	Dim gv() As String = Array As String("__builtins__", "_print", "bridge_instance", "check_code_string", "executable", _
								"_varnames", "io", "itertools", "sys", "_version", "_pyloglines", "blog", "kernel", "pathx", "pylogs")
	globalVars.initialize										
	For Each kw As String In gv
		globalVars.Put(kw, True)
	Next
	callback = caller
	isVerbose = verbose
	'This section is just to get the IDE TabSize number - default=4 can be overridden after initialize (ex. pw.TABspaces = 3)
	cDir = File.DirApp
	Dim user As String = cDir.SubString(cDir.IndexOf("Users\") + 6)
	user = user.SubString2(0, user.IndexOf("\"))
	cDir = cDir.SubString2(0, cDir.IndexOf("Users\") + 6) & user & "\AppData\Roaming\Anywhere Software\B4J"
	If File.Exists(cDir, "b4xV5.ini") Then 
		Dim config As String = File.ReadString(cDir, "b4xV5.ini")
		Dim st As Int = config.IndexOf(CRLF & "TabSize=")
		Dim nsp As Int = config.SubString2(st + 9, config.IndexOf2(CRLF, st + 9))
		TABspaces = "                    ".SubString2(0, nsp)
	End If
	Return Me
End Sub

'Connects PyBridge to Python kernel - requires a Wait for (pw.connect) Complete (OK As Boolean)
Public Sub connect As ResumableSub
	Py.Initialize(Me, "Py")
	Dim opt As PyOptions = Py.CreateOptions("Python/python/python.exe")
	Py.Start(opt)
	Wait For Py_Connected (Success As Boolean)
	Wait For (Py.runcode("_version", Array(), version).Fetch) Complete (Result As PyWrapper)
	kernel = Result.Value
	kernel = kernel.SubString2(0, kernel.indexOf(" "))
	Wait For (Py.runcode("blog", Array(""), blog).Fetch) Complete (Result As PyWrapper)
	Py.Flush
	Sleep(50)
	Return Success
End Sub

Public Sub clean(script As String) As ResumableSub
	Dim v() As String = Regex.Split(CRLF, script)
	Dim minIndent As Int = 1 / 0
	For i = 0 To v.Length - 1
		Dim s As String = v(i)
		Dim t As String = s.trim
		If t.Length = 0 Or t.StartsWith("#") Then Continue
		Dim sb As StringBuilder: sb.initialize
		Do While s.StartsWith(TABspaces) Or s.StartsWith(TAB)
			sb.Append(TAB)
			If s.StartsWith(TABspaces) Then s = s.SubString(TABspaces.length) Else s = s.SubString(1)
		Loop
		Dim indent As String = sb.toString
		If indent.Length < minIndent Then minIndent = indent.Length
		v(i) = indent & fixCaps(s)
	Next
	If minIndent > 100 Then minIndent = 0
	'Adjust left offset to zero minimal indents - add Script Id line and combine lines into single string
	Dim sb As StringBuilder: sb.initialize
	Dim scriptName As String
	For Each s As String In v
		If s.Length > 0 Then 
			Dim adjS As String = s.SubString(minIndent)
			If adjS.StartsWith("def ") Then 
				scriptName = adjS.Substring(4).trim
				scriptName = scriptName.SubString2(0, scriptName.IndexOf("(")).trim
				defNames.Put(scriptName.ToLowerCase, scriptName)
			End If
			sb.Append(adjS).append(CRLF) 
		Else 
			If sb.Length > 0 Then sb.append(CRLF)
		End If
	Next
	If sb.Length > 0 Then sb.Remove(sb.Length - 1, sb.Length)
	If scriptName.Length = 0 Then 
		anonCount = anonCount + 1
		scriptName = "anon_" & anonCount
	End If

	sb.Insert(0, $"#__________ ${scriptName} __________${CRLF}"$)
	Dim cleanScript As String = sb.toString

	Wait For (Py.runcode("check_code_string", Array(cleanScript), checkSyntax).Fetch) Complete (Result As PyWrapper)
	Dim err As String = Result.Value
	If err.Length > 0 Then
		Dim lineNum As Int = err.SubString2(err.indexOf("line") + 5, err.lastIndexOf(")"))
		Dim v() As String = Regex.Split(CRLF, cleanScript)
		Dim line As String = v(lineNum - 1)
		LogColor($"Syntax Error in "${scriptName}" at line ${lineNum}: ${line}"$, xui.Color_RGB(180, 0, 0))
		show(cleanScript)
		LogColor($"Job Terminated"$, xui.Color_Red)
		terminate
		Return False
	Else if isVerbose Then 
		LogColor($"No Syntax Errors in "${scriptName}""$, xui.Color_RGB(0, 180, 0))
	End If
	Return cleanScript
End Sub

Private Sub fixCaps(s As String) As String
	Dim prevAlpha As Boolean = False
	Dim inquote, insingleQ, skiprest As Boolean
	Dim sb As StringBuilder: sb.initialize
	For i = 0 To s.Length - 1
		Dim c As String = s.CharAt(i)
		Dim alpha As Boolean = (c.toLowerCase <> c.toUppercase) Or c = "_"
		If c = QUOTE And Not(insingleQ) And Not(inquote) Then
			inquote = True
		Else If c = QUOTE And Not(insingleQ) And inquote Then
			inquote = False
		Else If c = "'" And Not(insingleQ) And Not(inquote) Then
			insingleQ = True
		Else If c = "'" And insingleQ And Not(inquote) Then
			insingleQ = False
		Else If c = "#" Then 
			skiprest = True
		End If
		If Not(inquote) And Not(insingleQ) And Not(skiprest) Then
			If Not(prevAlpha) And alpha Then 			'start of potential capitalized word
				Dim word As StringBuilder: word.initialize
				word.Append(c)
				Dim n As Int = Min(i + 20, s.Length - 1)
				For j  = i + 1 To n
					Dim a As String = s.CharAt(j)
					Dim alpha2 As Boolean = (a.toLowerCase <> a.toUppercase) Or "_0123456789".Contains(a)
					If Not(alpha2) Then Exit
					word.Append(a)
				Next
				Dim wrd As String = word.toString
				Dim wrdX As String = wrd.toLowerCase
				If pyKeyWords.containsKey(wrdX) Then
					Dim targetCase As String = pyKeyWords.Get(wrdX)
					For j = 0 To targetCase.Length - 1
						sb.Append(targetCase.CharAt(j))
						If j > 0 Then i = i + 1
					Next
					c = ""
				Else If varCaseness.ContainsKey(wrdX) Then 
					If defNames.ContainsKey(wrdX) Then
						If wrd = wrdX Then 
							LogColor($"Error: '${wrd}' already exists"$, xui.Color_RGB(180, 0, 0))
						Else	
							LogColor($"Error: '${wrd}' already exists as '${wrdX}'"$, xui.Color_RGB(180, 0, 0))
						End If
						LogColor($"Job Terminated"$, xui.Color_Red)
						terminate
						Return False
					Else
						Dim targetCase As String = varCaseness.Get(wrdX)
						For j = 0 To targetCase.Length - 1
							sb.Append(targetCase.CharAt(j))
							If j > 0 Then i = i + 1
						Next
						c = ""
					End If
				Else
					varCaseness.Put(wrdX, wrd)
				End If
			End If
		End If
		sb.Append(c)
		prevAlpha = alpha
	Next
	Return sb.toString	
End Sub

Public Sub call(script As String, args() As Object) As ResumableSub
	Dim fnName As String = getName(script)
	If fnName.StartsWith("anon_") Then script = script & CRLF & $"def ${fnName} (): return"$
	Wait For (Py.RunCode(fnName, args, script).Fetch) Complete (Result As PyWrapper)
	Dim err As String = Result.ErrorMessage
	If err.Trim.Length > 0 Then 
		err = err.SubString(err.indexOf("-") + 16)
		If fnName.Length > 0 Then LogColor($"Error in ${fnName} ${err}"$, xui.Color_RGB(180, 0, 0))
		Return Null
	End If
	Return Result.Value
End Sub

Public Sub exec(script As String) As ResumableSub
	Dim fnName As String = getName(script)
	If fnName.StartsWith("anon_") Then script = script & CRLF & $"def ${fnName} (): return"$
	Wait For (Py.RunCode(fnName, Array(), script).Fetch) Complete (Result As PyWrapper)
	Dim err As String = Result.ErrorMessage
	If err.Trim.Length > 0 Then 
		err = err.SubString(err.indexOf("-") + 15)
		If fnName.Length > 0 Then LogColor($"Error in ${fnName} ${err}"$, xui.Color_RGB(180, 0, 0))
		Return False
	End If
	Return True
End Sub

Private Sub getName(script As String) As String
	Dim k As Int = script.indexOf("__________")
	If k = - 1 Then 
		LogColor($"Error in script - missing Script ID header (use pw.clean first)"$, xui.Color_RGB(180, 0, 0))
		Return ""
	End If
	Dim k As Int = script.IndexOf2(CRLF, k + 1)
	If k = -1 Then k = script.length
	Dim v() As String = Regex.Split("__________", script.SubString2(0, k))
	Dim fnName As String = v(1).trim
	Return fnName
End Sub

Public Sub install(packName As String) As ResumableSub
	If kernel = "Default" Then 
		LogColor($"Error - should not install ${packName} in this kernel - make Local copy first"$, xui.Color_RGB(180, 0, 0))
		LogColor($"Job Terminated"$, xui.Color_Red)
		terminate
		Return False
	End If
	Wait For (Py.RunCode("install_package", Array(packName), installPackage).Fetch) Complete (Result As PyWrapper)
	Return True
End Sub

Public Sub names As ResumableSub
	Wait For (Py.RunCode("_varnames", Array(), varNames).Fetch) Complete (Result As PyWrapper)
	Dim res As List: res.initialize
	For Each s As String In Result.Value.As(List)
		If Not(globalVars.ContainsKey(s)) Then res.Add(s)
	Next
	Return res
End Sub

Public Sub blogs As ResumableSub
	Wait For (Py.RunCode("pylogs", Array(), pylogs).Fetch) Complete (Result As PyWrapper)
	LogColor(Result.value, xui.Color_RGB(0, 0, 170))
	Return True
End Sub

'Displays the stored Script on Logs
Public Sub show(script As String)
	Dim v() As String = Regex.Split(CRLF, script)
	For i = 0 To v.Length - 1
		LogColor((i + 1) & TAB & v(i), xui.Color_RGB(0, 0, 170))
	Next
End Sub

'Copies cleaned script to cliboard (add single QUOTE(
Public Sub clipboard(script As String)
	Dim fx As JFX
	Dim v() As String = Regex.Split(CRLF, script)
	Dim sb As StringBuilder: sb.initialize
	For i = 0 To v.Length - 1
		sb.Append("'").Append(v(i)).Append(CRLF)
	Next
	fx.Clipboard.SetString(sb.ToString)
End Sub

Private Sub initUtils
	Dim script As String = $"
def check_code_string(source_code_string):
	result = ""
	try:
		compile(source_code_string, "bogusfile.py", "exec")
	except SyntaxError as e:
		result = f"Syntax Error: {e}"
	except Exception as e:
		result = f"An unexpected error occurred: {e}"
	return result
"$
	checkSyntax = script
	
		Dim script As String = $"
import sys
import subprocess
def install_package(package_name):
    print(f"Installing {package_name}...")
    try:
        subprocess.check_call([sys.executable, "-m", "pip", "install", package_name])
        return f"Successfully installed {package_name}"
    except subprocess.CalledProcessError as e:
        return f"Failed to install {package_name}. Error: {e}"
	"$
	installPackage = script

	Dim script As String = $"
def _varnames():
	result = []
	for name, value in globals().items():
		result += [name]
	return result
"$	
	varNames = script

	Dim script As String = $"
_pyloglines = []		
def blog(s):
	global _pyloglines
	_pyloglines += [s]
	return
"$
	blog = script

	Dim script As String = $"
def pylogs():
	global _pyloglines
	separator = "\n"
	result = separator.join(_pyloglines)
	_pyloglines = []
	return result
"$
	pylogs = script
	
		Dim script As String = $"
import sys
print("Python Version: ", sys.version)
pathx = sys.executable
kernel = "Global Kernel: "
if "\\Objects\\Python\\" in pathx:
	kernel = "Local Kernel: "
if "\\Anywhere Software" in pathx:
	kernel = "Default Kernel: "
print(kernel, pathx)
def _version ():
	return kernel
"$
	version = script
End Sub

Private Sub B4XPage_Background
	Py.KillProcess
End Sub

'Call this Sub when finished with PyWorks and PyBridge
Public Sub disconnect
	Py.KillProcess
	Wait for Py_Disconnected
	Log("PyBridge disconnected")
End Sub

Private Sub terminate
	Py.KillProcess
	Wait for Py_Disconnected
	Log("PyBridge disconnected")
	ExitApplication
End Sub